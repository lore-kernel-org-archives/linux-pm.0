From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v11 00/10] Add sbs-manager with smbalert support
Date: Sun, 29 Oct 2017 00:55:52 +0200
Message-ID: <20171028225552.4uhsqx6fkurmcn3j@ninjato>
References: <1503567070-115646-1-git-send-email-preid@electromag.com.au>
 <66235a12-a209-be89-5bfd-dc69b769cab9@electromag.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2fbur4oqmkmbwqoa"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <66235a12-a209-be89-5bfd-dc69b769cab9-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Phil Reid <preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, jdelvare-IBi9RG/b67k@public.gmane.org, jglauber-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, david.daney-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org, benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org


--2fbur4oqmkmbwqoa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> > Changes from v10
> > - i2c: mux: pca954x: Call request irq after adding mux segments
> >    Added Peters ack
> >    renamed label 'fail_del_adapters' to 'fail_cleanup'
>
> Any comments on this?

I just pushed a branch with some minor fixes to my tree [1] so that
buildbot can check it. If all goes well, I'll post the patches tomorrow
and merge this branch to for-next soon after.

Thanks for your hard work!

[1] git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/sbs-manager


--2fbur4oqmkmbwqoa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAln1CvMACgkQFA3kzBSg
KbYEKg/9GLYPf1c9cOtA3AshbdWirYrUoluIyujQPoRDzmUvULPewzL2ypOwSSmm
JMICDdD1kxmjbhlcV62mxOmW85L1+g3/r7hg2KuYjc7RThtAzPqd+FXgqHIVadFN
EFixxLg5bkznn/YdUNo1uxAhx0jwEWlzqnPm1vOfEYBMBgmHBay96jfzIoE7ua6C
WXj/MvixqqFmmF2ONFWry+gVQ5/Et5VgtMtvh+lxviIZXv/0hvjRKZPdQjHRERlB
M5t7BNQEsa1DSYpLS5dINk3jyBnrdunuhTSLk1qILOGjSx/PvxtlTvwDyfvOt+LX
txWZRjrbGItNuvlkKCRRAGSDMlGPVpScODHJTH+G4E635yHX7MyfuATKQ5lCqwtZ
lkESX6uAWcDKVU6g6erNWEV62a2kjosywh6G3slxmZZJal8BVEZ/dxHnr0Yzv0cA
Io2u2bflHGcR2ZsSuvpmhpilCjRxMymgTg30F+gYV8U92Xfylgi1Gsm0sTzlIflI
RqsFzqZUNmPyaza1raqFSa2KVNStaCjb5c7Jz1bbb2ar+z5Xfm4mlPdXBcUEI3Ma
EWOwb++eGJZU4jPwbQcWFZfxut5Hh+6q8hXvxKGiGWzp3ptA5v/eOOQQF3ZLZp4W
ZOMk89MdDuSddiw84T2OmcQxrsQPFabSoIV89tUnI+5DJvpfdf8=
=Yaje
-----END PGP SIGNATURE-----

--2fbur4oqmkmbwqoa--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
