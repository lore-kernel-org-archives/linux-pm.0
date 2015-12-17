From: Eric Anholt <eric@anholt.net>
Subject: Re: [PATCH] PM / sleep: define inline functions
Date: Wed, 16 Dec 2015 16:41:37 -0800
Message-ID: <87wpsdrjni.fsf@eliezer.anholt.net>
References: <1450266099-4352-1-git-send-email-sudipm.mukherjee@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1450266099-4352-1-git-send-email-sudipm.mukherjee@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>
List-Id: linux-pm@vger.kernel.org

--=-=-=
Content-Type: text/plain

Sudip Mukherjee <sudipm.mukherjee@gmail.com> writes:

> If CONFIG_PM_SLEEP is not defined then the functions are defined as
> NULL. And as a result we are getting build failure with
> alpha allmodconfig with the error:
>
> drivers/gpu/drm/vc4/vc4_v3d.c: In function 'vc4_v3d_set_power':
> include/linux/stddef.h:7:14: error: called object is not a function or function pointer
>  #define NULL ((void *)0)
>               ^
> include/linux/pm.h:776:30: note: in expansion of macro 'NULL'
>  #define pm_generic_poweroff  NULL
>                               ^
> drivers/gpu/drm/vc4/vc4_v3d.c:157:10: note: in expansion of macro 'pm_generic_poweroff'
>    return pm_generic_poweroff(&vc4->v3d->pdev->dev);
>           ^
> include/linux/stddef.h:7:14: error: called object is not a function or function pointer
>  #define NULL ((void *)0)
>               ^
> include/linux/pm.h:764:28: note: in expansion of macro 'NULL'
>  #define pm_generic_resume  NULL
>                             ^
> drivers/gpu/drm/vc4/vc4_v3d.c:159:10: note: in expansion of macro 'pm_generic_resume'
>    return pm_generic_resume(&vc4->v3d->pdev->dev);
>           ^
>
> Fixes: d5b1a78a772f ("drm/vc4: Add support for drawing 3D frames.")
> Cc: Eric Anholt <eric@anholt.net>
> Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>

I'm happy with this solution, and would also be willing to just depend
on the config option as well.  Whatever people prefer.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWcgTBAAoJELXWKTbR/J7o68IP/ifYiFVQl8yl/cW5k6P6wJRl
4u2XHsAFgKNZd5cSKWQ/SFNqJv2fDM3+Rsmcb0Zs+GYMuk+qsGdVH/XcS/TjhV/i
qUdKZs4d8kjD/t48bDAgaho6uXsK02kxoO7pcxIQDorJfsjdI1Ki6smsomXRMMIY
f/0WMaVGHGHwPLweK9aSGNVRxqWiD25PrzJsOiQqRTY9IY53CewFroMjLkz6lje0
unpZfMV7CHKzXsi7WwWfB2bl3yvcwb5qqpcfAPYVy8Z1vPTrszwLCKvEb86+2+fS
ZCP2qg0maiBRTVA+grsGat9hVEwgOwRs2wh7wxCRmWhT2Co4T9BDdYvzymuZUfFx
Ksi2F+agAF3QGag9bJc1GgjrwlPywT71JdpBBcCrnKgYsgLinFlMF+TVplCSkXPy
RlXlc1zNIY93jHvMSVKCRuOkyRUPM5b0FY35jRG5Xg7hvPrrB2Jy+fZ/zSHPKPHS
y4zxfb42WlP9t3SyzHr0McanrGqfg/QnrXSTUqzzgfTaoo/wAgQpa86Wdq796UZi
6gPGENbsRyYn6ox7vSwRAT+qcXAKq7u1jSC9OBVjXL8WNhvk2K/lOHeLEN983qU3
SWQXkL3DeN9rPrhMHuD9tqfYRkNKrdozO/98NicyxH4S/ErureUTdlpMOiVmm/7m
LYybySLah29JZygNb2rd
=Ywvz
-----END PGP SIGNATURE-----
--=-=-=--
