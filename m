From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] power: supply: sbs-battery: simplify DT parsing
Date: Wed, 7 Sep 2016 15:17:33 +0200
Message-ID: <20160907131732.wfyyyphbofk3ne2g@earth>
References: <20160906131643.1930011-1-arnd@arndb.de>
 <20160906235523.ff4opq56gg4ln6xv@earth>
 <4977026.Nm6AJ7K8UK@wuerfel>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5wxmjq4dqi2zv2dm"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4977026.Nm6AJ7K8UK@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Phil Reid <preid@electromag.com.au>, YH Huang <yh.huang@mediatek.com>, Joshua Clayton <stillcompiling@gmail.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--5wxmjq4dqi2zv2dm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Sep 07, 2016 at 09:58:10AM +0200, Arnd Bergmann wrote:
> On Wednesday, September 7, 2016 1:55:23 AM CEST Sebastian Reichel wrote:
> >=20
> > Patch looks fine to me. Actually I already asked Phil to
> > implement your change [0]. I just queued it to power-supply's
> > for-next branch.
> >=20
> > [0] https://marc.info/?l=3Dlinux-pm&m=3D147273382018953&w=3D2
>=20
> Glad to see we had the same thought. ;-)
>=20
> I see that we went for different defaults for chip->poll_retry_count:
> I concluded that '0' would be the correct default, while you suggested '1'
> in your reply.
>=20
> Can you double-check the code and see which one is right?

0 is correct. It will be incremented to 1 later.

-- Sebastian

--5wxmjq4dqi2zv2dm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJX0BNnAAoJENju1/PIO/qayKMP/RG2edpEECqXjGdkAQ3b/Dv8
HDgV6CViHFzKSZsZxn3rJhxsDZkO8DLgkpqN6nC2T1E/Je0uRg/QnxQXQ+WouY4b
n9d/1Ry0ap+N9A7eSzqq1G6naJvCSxSzPSq0RWeLUtc7HAQ8Z3o7OeqV5elJ4fDC
XUTxk1z5w0JjZplvnZkBfHU4szIJcwxQ72EBZcfWEOZjOJSB4hX7sRulp54aisCG
bwYBYSYEFWjRGoTxzFwxXmHJTTImfTP7pRpVXx7FF+jdokbf8AFSOJLp5zccWlyp
BMFLXsuffnH/lJDHVKGSopJva74tos/BXB2mQ0RH5D3FlqfoaW9BHylW3a71tWk/
r5/J10uRK0ym5mICIXULGJ/v0aUS2bGelmjJ7yUiSXITFHDkiUV3UwaJgBT2iTVl
OrMBrocx0zuCBVosEHxiA0cDel6sLcHerPW9FE2lmGX9cX8ojYbZSzNZKi4j79dY
+U1O1BzfJRqhgnnchAkEz6XAuypCSrIfB72ALx2WtMY5ga73fN7WaNXRhSQ23XVo
vpe8g/wlg1f5MYN/nAxEplpKO3PEVyStaKAWdl8Bx671LmzYP7ijNfDr8SCHRP+g
sv8mMzFZJ7UQogyAwtBCzdLhXGxsHscxgDAxem/YOKTZ4y/MaziKoxDHLdCOKvvD
xuaSvDiVOrT574gNcTiO
=3N0L
-----END PGP SIGNATURE-----

--5wxmjq4dqi2zv2dm--
