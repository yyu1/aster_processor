;Creates a test mosaic at 0.01 deg to see if we have missing tiles and/or holes

pro create_global_mosaic

out_file = '/u/yyu1/temp/global_srtm3_mosaic_0.01deg.int'
in_dir = '/nobackupp6/nexprojects/CMS-ALOS/srtm'

out_block = intarr(36000, 100)

openw, out_lun, out_file, /get_lun

for latitude = 59LL, -56LL, -1LL do begin
	print, latitude
	for longitude = -180LL, 179LL do begin
		data = get_tile(longitude, latitude, in_dir)
		data_trim = data[0:3599, 1:3600]
		out_block[(longitude+180)*100:(longitude+181)*100-1, *] = rebin(data_trim,100,100)
	endfor

	writeu, out_lun, out_block
endfor

free_lun, out_lun

end
