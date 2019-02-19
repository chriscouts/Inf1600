.global func_s

func_s:
	# Votre programme assembleur ici... 

    flds b          #st[0] = b
    flds d          #st[0] = d, st[1] = b
    fmulp           #st[0] = b*d, st[1] = b*d
    flds c          #st[0] = c, st[1] = b*d
    fsubrp          #st[0] = (b*d)-c, st[1] =(b*d)-c
    fstps a         #sauvegarde la valeur de st[0] dans l'adresse a

    flds f          #st[0] = f 
    flds g          #st[0] = g , st[1] = f
    fsubrp          #st[0] = f-g , st[1] = f-g
    flds a          #sauvegarde la valeur de st[0] dans l'adresse a
    fdivp           #st[0] = ((b*d)-c)/(f-g) , st[1] = ((b*d)-c)/(f-g)
    flds e          #st[0] = e, st[1] = ((b*d)-c)/(f-g)
    faddp           #st[0] = (c+(((b*d)-c)/(f-g))), st[1] =(c+(((b*d)-c)/(f-g)))
    fstps a         #st[0] = (c+(((b*d)-c)/(f-g)))

    flds g          #st[0] = g, st[1] = (c+(((b*d)-c)/(f-g)))
    flds e          #st[0] = e,  st[1] = g
    fsubrp          #st[0] = g-e, st[1] = g-e
    flds f          #st[0] = f, st[1] = g-e
    fdivrp          #st[0] = ((g-e)/f), st[1] = ((g-e)/f)
    flds a          #sauvegarde la valeur de st[0] dans l'adresse a
    fmulp           #st[0] = ((g-e)/f) * (c+(((b*d)-c)/(f-g))), st[1] = ((g-e)/f) * (c+(((b*d)-c)/(f-g)))
    fstps a         #sauvegarde la valeur de st[0] dans l'adresse a



	ret
