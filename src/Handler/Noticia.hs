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
    
-- Post noticia
postNoticiaR :: Handler TypedContent
postNoticiaR = do 
    addHeader "ACCESS-CONTROL-ALLOW-ORIGIN" "*"
    noticia <- requireJsonBody :: Handler Noticia
    _ <- runDB $ insert noticia
    sendStatusJSON created201 (object ["noticia" .= noticia])
    
-- Buscar noticia
getBuscarNoticiaR :: Text -> Handler TypedContent
getBuscarNoticiaR nome = do 
    noticia <- runDB $ selectList [Filter NoticiaTitulo (Left $ concat ["%", nome, "%"]) (BackendSpecificFilter "ILIKE")] []
    sendStatusJSON ok200 (object ["resultado" .= noticia])
    
-- Buscar noticias por categoria
getNoticiaCategoriaR :: CategoriaId -> Handler TypedContent
getNoticiaCategoriaR categoriaid = do 
    noticias <- runDB $ selectList [NoticiaCategoriaid ==. categoriaid] []
    sendStatusJSON ok200 (object ["noticias" .= noticias])
    
-- Buscar noticia por id
getNoticiaUnicaR :: NoticiaId -> Handler TypedContent
getNoticiaUnicaR noticiaid = do 
    noticia <- runDB $ selectList [NoticiaId ==. noticiaid] []
    sendStatusJSON ok200 (object ["noticia" .= noticia])