From: Andrey Rahmatullin <wrar-Bxt/JK/G85ezQB+pC5nmwQ@public.gmane.org>
Subject: Re: [linux-pm] ehci_hcd related S3 lockup on ASUS laptops, again
Date: Tue, 24 Apr 2012 16:42:38 +0600
Message-ID: <20120424104238.GB4610@belkar.wrar.name>
References: <1335205839.28106.108.camel@gandalf.stny.rr.com>
 <Pine.LNX.4.44L0.1204231554210.1612-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="kXdP64Ggrk/fb43R"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1204231554210.1612-100000-IYeN2dnnYyZXsRXLowluHWD2FQJk+8+b@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: Steven Rostedt <rostedt-nx8X9YLhiw1AfugRpC6u6w@public.gmane.org>, jrnieder-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org


--kXdP64Ggrk/fb43R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 23, 2012 at 04:11:48PM -0400, Alan Stern wrote:
> I don't have a very clear idea of how specific this needs to be.  There=
=20
> have been other bug reports of problems related to suspend that were=20
> fixed by the same script you were using, but the symptoms weren't the=20
> same.  For example, see Bugzilla #42728.
>=20
> Anyway, this patch is reasonably close to being a final version, and it
> should work on both machines.  You should be able to suspend and resume
> with no problems, without using the script.
Tested-by: Andrey Rahmatullin <wrar-Bxt/JK/G85ezQB+pC5nmwQ@public.gmane.org>

--=20
WBR, wRAR

--kXdP64Ggrk/fb43R
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJPloOeAAoJEDNi9wMaSZLhihgQAIF++itWJLJtsSHiZOSdByE0
Mp/KmpDp0+dKk2Wy7jwp4ifLw6jp+2mQG+ittF2OIvggvDzLPaoFDG3IA15xctM/
S5GmHf0CjhYkteEBrvsMZ7gJjkwro8qErp43v+Jvb0pC0nFmRu12l8jW86GgcxZ1
jvfyY8gl4i2ZJBUATrsuH2wxtxILchSSEGHdoIT3ikp3HlhB+2gMgSpVtdc9GGmv
4ir6/JeTnL7xs9/OkupKT+ENPYk9tWE8glLspfpiCgrV31QponGW4WImUu/HDcwP
P6MHIhsPKduL1gqTuWtoigEeZa2GxjviFLz5/qK45QF37xesQ6k83MufBERTulg1
wdBRyjSi9jz6udYo892apZWJlXQIniJu9nflpUUAVsLkwEPkVR7HkYG9QvhHWA9j
mlntYPFMoFU6ZO9lS6+JcipXj5k1ag1JelW54BZqv3eAyagDLzEWm7bncxFSdnNt
ZtuEn6+nsO+SrEiQranDau4RRu6cEcMBFElZy8BUunh6YGA1rRvBBcwb7dymOtn4
NYUINeU96Heq+Y1d3wshgK2L1JxruHA51g+c06Kcd1diLl8XEYPfR9IrWv7xfQv3
1xuOoict2f1ZcsWtE8vh1dqc2GrOcM9mlB33iY+Zrq2dfLU+/wlCxCADw8VJm6Zy
e72ds47UMI7Xtk4CLKWe
=zFRK
-----END PGP SIGNATURE-----

--kXdP64Ggrk/fb43R--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
