{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE QuasiQuotes #-}
module Handler.Evento where

import Import

-- Get all eventos
getListaEventoR :: Handler TypedContent
getListaEventoR = do 
    eventos <- runDB $ selectList [] [Desc EventoId]
    sendStatusJSON ok200 (object ["eventos" .= eventos])
    
-- Post evento
postEventoR :: Handler TypedContent
postEventoR = do 
    addHeader "ACCESS-CONTROL-ALLOW-ORIGIN" "*"
    evento <- requireJsonBody :: Handler Evento
    _ <- runDB $ insert evento
    sendStatusJSON created201 (object ["evento" .= evento])