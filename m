From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v10 2/4] power: reset: add reboot mode driver
Date: Wed, 6 Jul 2016 17:24:19 +0200
Message-ID: <20160706152419.GB19659@earth>
References: <1467811081-20700-1-git-send-email-andy.yan@rock-chips.com>
 <1467811646-20823-1-git-send-email-andy.yan@rock-chips.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yEPQxsgoJgBvi8ip"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1467811646-20823-1-git-send-email-andy.yan-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Yan <andy.yan-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, john.stultz-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jun.nie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, moritz.fischer-+aYTwkv1SeIAvxtiuMwx3w@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org


--yEPQxsgoJgBvi8ip
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jul 06, 2016 at 09:27:26PM +0800, Andy Yan wrote:
> This driver parses the reboot commands like "reboot bootloader"
> and "reboot recovery" to get a boot mode described in the
> device tree , then call the write interfae to store the boot
> mode in some place like special register or sram, which can
> be read by the bootloader after system reboot, then the bootloader
> can take different action according to the mode stored.
>=20
> This is commonly used on Android based devices, in order to
> reboot the device into fastboot or recovery mode.
>=20
> Reviewed-by: Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Reviewed-by: Moritz Fischer <moritz.fischer-+aYTwkv1SeIAvxtiuMwx3w@public.gmane.org>
> Tested-by: John Stultz <john.stultz-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Acked-by: John Stultz <john.stultz-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Signed-off-by: Andy Yan <andy.yan-TNX95d0MmH7DzftRWevZcw@public.gmane.org>

Thanks, queued into powersupply's next tree with the
whitespace issue fixed.

-- Sebastian

--yEPQxsgoJgBvi8ip
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXfSKjAAoJENju1/PIO/qalqgP/iIfoVBhshzu+fWWVCTcnBwT
waK+UTJ9pOJRTBdQdTNWSSOP+1g+HGT6ZTbBJmFTZVVX5bWZ4edStteJ+ZWnR6s5
XA5Iu0OS7qv0/fAGA8xgZQWxFmnhrieIEJ+1NH8s2DOgP+DewUEx0DiR1Zi1YCML
FBTzlOkDMUAfZqCcYsyjvMppJgSG/LGSWNt1sJ1pigB7/2gR0j2DZE2ySrxvHPGy
vuUekQl0HN3vgC77+lUQFnXz72VRKk5S1F8sK0Tmex8Xtt6Cl5k/d0Tuy6CgQGAj
s+hoIIPm022JKuX9YcEftLhlcwxJGQSrJyI6G3SVzOg74xER/6GqcKaOBOpWEJvG
7pjrnrthbW+AcTFFHONvl1J0eMqgF0NWPwIoLjs/BjaTAnkhewjXnY9VDipLWSI5
no3ziFuIfqsoM8ojbSdnY7pRHJV0ond7r9csWAzfGKajzdA4TL/PP0F0Y5CNjQHT
xjq7OlRjA1ZxqoGhQuva50USDndHgRm+f+QKKdwOgtfj4gWZUJmVXfUZPs8Y/u7l
9kQBMoS5IHGb3FmutS/B0mCsSTdQpwKzQhBUbFT/nBJkHdmRxkGi/yfKq49gaBj0
RNFWwRe9vKsVFl9OmW5qPFXAcyXVdTmkrU1dfN7awLjb4lEQV8vRGfQOaplJzLoQ
X+VRMXI9fdOiwhPJTieX
=T0m2
-----END PGP SIGNATURE-----

--yEPQxsgoJgBvi8ip--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
