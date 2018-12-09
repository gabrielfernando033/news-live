{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE QuasiQuotes #-}
module Handler.Comentario where

import Import

-- Buscar comentarios por noticia
getListaComentarioR :: NoticiaId -> Handler TypedContent
getListaComentarioR noticiaid = do 
    comentarios <- runDB $ selectList [ComentarioNoticiaid ==. noticiaid] []
    sendStatusJSON ok200 (object ["comentarios" .= comentarios])

-- Post comentario
postComentarioR :: Handler TypedContent
postComentarioR = do 
    addHeader "ACCESS-CONTROL-ALLOW-ORIGIN" "*"
    comentario <- requireJsonBody :: Handler Comentario
    _ <- runDB $ insert comentario
    sendStatusJSON created201 (object ["comentario" .= comentario])