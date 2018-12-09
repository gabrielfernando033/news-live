{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE QuasiQuotes #-}
module Handler.Categoria where

import Import

-- Get all categorias
getListaCategoriaR :: Handler TypedContent
getListaCategoriaR = do 
    categorias <- runDB $ selectList [] [Asc CategoriaId]
    sendStatusJSON ok200 (object ["categorias" .= categorias])
    
-- Post categoria
postCategoriaR :: Handler TypedContent
postCategoriaR = do 
    addHeader "ACCESS-CONTROL-ALLOW-ORIGIN" "*"
    categoria <- requireJsonBody :: Handler Categoria
    categoriaid <- runDB $ insert categoria
    sendStatusJSON created201 (object ["categoria" .= categoria])