From: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCHv9 1/3] Runtime Interpreted Power Sequences
Date: Wed, 21 Nov 2012 10:48:45 +0200
Message-ID: <50AC956D.7020303@ti.com>
References: <1353149747-31871-1-git-send-email-acourbot@nvidia.com> <4316169.5QXVzv7peZ@percival> <50AC8D3B.6040300@ti.com> <1699753.ZQsWMHINxd@percival>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigFEB2DE46DC00D8FE6C54AF30"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1699753.ZQsWMHINxd@percival>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alex Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Anton Vorontsov <cbouatmailru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>, Mark Zhang <markz-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

--------------enigFEB2DE46DC00D8FE6C54AF30
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2012-11-21 10:32, Alex Courbot wrote:

>> Ok. I'll need to dig up the conversation
>=20
> IIRC it was somewhere around here:
>=20
> https://lkml.org/lkml/2012/9/7/662
>=20
> See the parent messages too.

Thanks.

>> Did you consider any examples
>> of how some driver could handle the error cases?
>=20
> For all the (limited) use cases I considered, playing the power-off seq=
uence=20
> when power-on fails just works. If power-off also fails you are potenti=
ally in=20
> more trouble though. Maybe we could have another "run" function that do=
es not=20
> stop on errors for handling such cases where you want to "stop everythi=
ng you=20
> can".

If the power-off sequence disables a regulator that was supposed to be
enabled by the power-on sequence (but wasn't enabled because of an
error), the regulator_disable is still called when the driver runs the
power-off sequence, isn't it? Regulator enables and disables are ref
counted, and the enables should match the disables.

> Failures might be better handled if sequences have some "recovery polic=
y"=20
> about what to do when they fail, as mentioned in the link above. As you=
=20
> pointed out, the driver might not always know enough about the resource=
s=20
> involved to do the right thing.

Yes, I think such recovery policy would be needed.

 Tomi



--------------enigFEB2DE46DC00D8FE6C54AF30
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iQIcBAEBAgAGBQJQrJVtAAoJEPo9qoy8lh71Lu8QAKQYKO3s8JapnGwTRpDb95V/
ZESzJ5RqPbWBAOzP9+8RBME/FMJ/jXdophNmbvt0IMGfrHpWdGLzBy1AoPD9O5H8
AHsx4Zfu/NOkLlv7yCI8LePgV/VnJiE1KN6MJXRuR/Rlb76Wj5/AEgstj3KQP6Od
CrwOmJPd2pQwPRk6QMBatIXiNrWl4FcH6iuAQU1cvCO5gcLlXVXRKG/hVcHS/Ddl
lCkkfeKGveV4h9z1o/ubilirovPqUmW/o1YdOJOKv0NUFBow8CdhUv43lQ8apqZq
UZFJ609hSRUU8vYyoG/uoJm72G9b6a+QQ5BVSvgppNVRxV/CgXpZBonon1FvunnH
we2w8DG/JO5SSoaYA0ZN5iyXDMxIeIEyhX8hQePZzFEde83wd2akoPFrK5z5NGSK
J5s3a0mopE4cj5Ps0VI00cJlr71mPA8DOCXR0KvssS2R17rgyJaNuisIu/46wvfq
ANAqkJ61LP3rvf/nH8TJvFapAjIMFOESW3jmJJGaq7GItxpwbTRCJ+kokAZMp7tn
j4ZFT7xQhN3nj0Hxzwv+gl7jxjC6OvU4xUaKwSZDfHQs1HaDkzXS2m2oaBIoSGRc
ex6Dkdh8bvSyFh+6tTrXgGPTMUkGjmuHoRPnXjethQbpAlL7gklG9wsRpQVckgDn
nss1T0JvMISh1HZEAL2W
=gaYE
-----END PGP SIGNATURE-----

--------------enigFEB2DE46DC00D8FE6C54AF30--
