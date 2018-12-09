{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE QuasiQuotes #-}
module Handler.Administrador where

import Import

-- Get admin
getAdminLoginR :: Text -> Text -> Handler TypedContent
getAdminLoginR usuario senha = do 
    admin <- runDB $ selectList [AdministradorUsuario ==. usuario, AdministradorSenha ==. senha] []
    sendStatusJSON ok200 (object ["admin" .= admin])
    
-- Post admin
postAdminR :: Handler TypedContent
postAdminR = do 
    addHeader "ACCESS-CONTROL-ALLOW-ORIGIN" "*"
    admin <- requireJsonBody :: Handler Administrador
    adminid <- runDB $ insert admin
    sendStatusJSON created201 (object ["adminid" .= adminid])