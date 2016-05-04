From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RESEND PATCH v10 4/4] power: wm831x_power: Support USB charger
 current limit management
Date: Wed, 4 May 2016 09:58:25 +0100
Message-ID: <20160504085825.GU6292@sirena.org.uk>
References: <cover.1462245638.git.baolin.wang@linaro.org>
 <80aa73ffd5c8e9ae8cd280d37f5141067e79c11f.1462245638.git.baolin.wang@linaro.org>
 <CAKDJKT46cJQbjdObUxBpWsciG1FjcL8CdV7iAeMefjNQPGicKA@mail.gmail.com>
 <20160503105718.GL6292@sirena.org.uk>
 <CAKDJKT4=LtMRGJKnj6CkYhey1Avmdk0gFf-mTQuDz+VrRrQsMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="oGy11dVowAZA6eXT"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAKDJKT4=LtMRGJKnj6CkYhey1Avmdk0gFf-mTQuDz+VrRrQsMg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Manish Badarkhe <badarkhe.manish-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Baolin Wang <baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Ruslan Bilovol <ruslan.bilovol-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, r.baldyga-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, device-mainlining-cunTk1MwBs98uUxBSJOaYoYkZiVZrdSR2LY78lusg7I@public.gmane.org, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org


--oGy11dVowAZA6eXT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 04, 2016 at 08:59:23AM +0530, Manish Badarkhe wrote:

> > They're in the silicon, it's just a table of values that were put into
> > the silicon at design time.  The defines would just be TABLE_ENTRY_1 or
> > whatever.

> Thanks for the clarification, In that case, comments/documentation
> will work instead of making any defines.

This is a *really* common pattern in drivers.

--oGy11dVowAZA6eXT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXKbmwAAoJECTWi3JdVIfQBmsH/2WeI2AFEHtBEMQ1RmadMqWJ
kgM2a9B+sw4qr50zlNFrw/wmKyQWwADu7dzPNxl5PSQR4vrdfxOnFVBtO17JExWG
2f5KS+yCbi2odKiaQfzfCSHUqNLKT09qb+oL+2grvoQ8UGn4e1gNPb/kATKOE3Nb
z4+znOllo3coHk1xbyDem8yVWLYykT4XGoJ+XUSrc9QdnrT+anH3D8MEVTuDiL9j
NzprKv4nm2sJ1N1JfXjj+DNwCNXfyOiPKtrQENEiQBotgNtIcZeVKnsAl1fyapNh
xMz3PsnztS7G3EioxpKvRg41J//vxT3uCKend6I70ZtukDm8GJwj9aWDdd66wCw=
=8gog
-----END PGP SIGNATURE-----

--oGy11dVowAZA6eXT--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
