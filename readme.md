# Dependencies

- qbcore
- qb-target
- qb-menu

# INSTALL

- Drag and drop resource into you resources folder whatever name that might be (ensure that there is no -main in the file name after you extract it from zip)
- Next go to you inventory folder and locate the js folder and open up the .js file once opended, locate the follwing:
```lua
} else if (itemData.type == "weapon") {
```
within that else if you should see 2 of the following lines
```lua
$(".item-info-description").html(
```
just above both of them you need to add the following:
```lua
 if (item.info.isScratched == true) then
                {
                    itemData.info.serie = "Scratched";
                }
```
so it should look something like this i have highlighted the added snippets so you can better see:
https://cdn.discordapp.com/attachments/907789876177555495/1055593822178005082/image.png

- Start resource in your server.cfg by using "ensure kevin-weaponscratch" without the quotes