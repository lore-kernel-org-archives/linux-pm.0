From: Sebastian Reichel <sre@kernel.org>
Subject: Re: tps65090-charger: Delete an error message for a failed memory
 allocation in two functions
Date: Mon, 18 Dec 2017 18:24:04 +0100
Message-ID: <20171218172404.3nqyza4ml5oofykn@earth>
References: <aa138aa9-d8c9-c6e3-7071-9fc642e7b248@users.sourceforge.net>
 <1513450432.4647.47.camel@perches.com>
 <4beb0d2e-adf6-5eeb-43c7-7829d54c6656@users.sourceforge.net>
 <alpine.DEB.2.20.1712162135140.17082@hadrien>
 <cf645236-d4da-a52c-216a-248d76a61025@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="j2gf7rgxtkc7secp"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cf645236-d4da-a52c-216a-248d76a61025@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: Julia Lawall <julia.lawall@lip6.fr>, linux-pm@vger.kernel.org, Joe Perches <joe@perches.com>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--j2gf7rgxtkc7secp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Dec 16, 2017 at 09:47:34PM +0100, SF Markus Elfring wrote:
> >> I am still waiting for possibilities to improve also the corresponding
> >> reference documentation somehow as you know it already.
> >=20
> > If you require someone else to update the documentation to be able to
> > explain why the patch is useful,
>=20
> My approach is to refer to the Linux allocation failure report.
>=20
>=20
> > then it would seem that you do not know why the patch is useful,
> > and thus should not submit it.
>=20
> We tried to clarify other explanation approaches a few times.
>=20
> But it seems that we are stuck with specific software aspects.
> How would you like to see remaining open issues to be resolved
> there anyhow?

FYI: I will drop this and (without any further notice) all future
patches from you, that do no follow the documented process in
Documentation/process/.

-- Sebastian

--j2gf7rgxtkc7secp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlo3+asACgkQ2O7X88g7
+pqL0g//Z7T/gG/Yp/8W8pShe9T37MQgzqAVqCxhqng7oTPO19+ibs1gHidnkgRT
oh+Qn4js8icw11qPZCkGI7hYMJ2ggJldQ3aZOWCsRCoFbefn0dmcN7Jr1dNBi0QM
QgOIisF2tVne4lvX9kk1fTDp5FscTjRJGqCkgLZ2ENzfWo5TZicaHwIp07yGeL8d
q3pplqt9rpS3uPMuHBO/JlRGC7kxVIr82mgU8ifW8LTbVIqQkfE4DxT8Nsh01ocK
1hgGksBNP6nGFIS/ohzRQ1QIEbrkxCoDlAdsDdZraOkM04RTKawOUjdkxviI/lwj
cOY0AcYibzMq3N/UGOh2+uZnAdzvJva8Qqp2REfUKAY1tlH/Te31f8M4BAz2XEt0
NZUTRQeJw5TXPrhDbzX35xQKSJ15Dik0NkHSrlK/0EC5dbJKRKgt/vSOexIjsO3p
pjneZBcGgRDHHl85vT9ypM4WziMC3YbGnj/1r8WoBPRlN5inJP1wCJHu55t1Y3le
UdMrt8oxktwjO66LRd6ccc3d0AcI/Dr4dpgvQxSsSH4EESKWrlGQ3+36QgGw4wqS
ZBpU6LQ3Ph49AmdxGcDikCqOwnQuQZ35t5xK/1wEIbpmGjyZOtf7B4OwpjqA94Vs
aDuY9Y4DrkTAq1jFkmelHHgTvBdGwNkGb400hzHQq3y783ZDDUQ=
=xh8M
-----END PGP SIGNATURE-----

--j2gf7rgxtkc7secp--
