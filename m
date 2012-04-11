From: Andrey Rahmatullin <wrar-Bxt/JK/G85ezQB+pC5nmwQ@public.gmane.org>
Subject: ehci_hcd related S3 lockup on ASUS laptops, again
Date: Wed, 11 Apr 2012 22:55:31 +0600
Message-ID: <20120411165531.GA3717@belkar.wrar.name>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+HP7ph2BbKc20aGI"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: jrnieder-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org, rostedt-nx8X9YLhiw1AfugRpC6u6w@public.gmane.org
List-Id: linux-pm@vger.kernel.org


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On many ASUS laptops and probably on some non-ASUS ones you need to unload
ehci_hcd or unbind both USB controllers from it before entering S3, else
the system will lockup. Here are some links:

http://thread.gmane.org/gmane.linux.kernel/1222803
https://bugzilla.kernel.org/show_bug.cgi?id=3D37632
http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D658778
http://ubuntuforums.org/showthread.php?t=3D1444822

This still happens on my K53E on v3.4-rc2-16-ga9e1e53.

Unbinding just one of two controllers doesn't help.

Disabling /sys/bus/pci/devices/0000:00:1[ad].0/power/wakeup doesn't help.
echo mem>/sys/power/state doesn't hang with 'core' in /sys/power/pm_test,
only with 'none'.

Windows 7 enters S3 perfectly well.

I didn't see any other suggestions how to debug this. I can provide any
debug data if that will help. This seems to be a very important problem
for owners of certain devices.

--=20
WBR, wRAR

--+HP7ph2BbKc20aGI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJPhbd+AAoJEDNi9wMaSZLhp54P/RjclP/bzQa98+Qf9gRRPMYh
A3pj900dR+EjdNe2oSOv7iGhnIYiShGmi+z3dE/dihtcSDXVzn9/HKdTpfuetbbL
6f6EbgzbLbzG33aB1F6KXNgVkgi3UFyO9JOtsRWpN5/01gWm60qwgnusQnTO7A6U
Zwo0MI5INctb0t5GhcP17BMEspRDdU/T7kNkRK+1wxN5c68FvjDr52cYq9v+8Vtk
C1DSJiUxLn0K/htwx+AgDAQMZMvfMO8R8JVgx27Io05WeYPPYappauBKvsEMGirQ
ffG/0eArFWkWHHV2l43rUV+U1nOa+as2Qt3OrWSpi85rb5K/juqQalYo7aprtK2k
qjddJc2HtbngdTP4c1+xo3EQOj7k5UvYdNSlG8RwrZpTcVbzpfLLBgRHzPgWKjBp
SJT39Wqp2k/bdx0mZUGgDTXi4js00UFYBZo1GJnuMRSv0xk6iuSOEEwljwZ+Aw8C
bkY/bo3x6S2WchTSr+zaVV4NqpjrnFj1foCZIyJw3QFVZY5UFYbdQDdHcR3efAib
/CiHt82GCiietu77Jw5c359Ek/jeikyQP5iIkY9q8t1Zy/JxRyl36UTu9yr4uiwo
8WYUgYsjmWUMEqvNTDG76Kr95/X1tKsVT5KJJqLqTTUqo4cXN6z+2mZr6XuhfJ7Z
IuugfF0ZqVO4E+OP2EzX
=VrjQ
-----END PGP SIGNATURE-----

--+HP7ph2BbKc20aGI--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
