{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE QuasiQuotes #-}
module Handler.Noticia where

import Import

-- Get all noticias
getListaNoticiaR :: Handler TypedContent
getListaNoticiaR = do 
    noticias <- runDB $ selectList [] [Desc NoticiaId]
    sendStatusJSON ok200 (object ["noticias" .= noticias])