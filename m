From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 0/3] Add support for Richtek RT9455 battery charger
Date: Fri, 29 May 2015 04:42:50 +0200
Message-ID: <20150529024250.GB17735@earth>
References: <1432549343-5756-1-git-send-email-anda-maria.nicolae@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Bn2rw/3z4jIqBvZU"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1432549343-5756-1-git-send-email-anda-maria.nicolae-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Anda-Maria Nicolae <anda-maria.nicolae-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org


--Bn2rw/3z4jIqBvZU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Anda-Maria,

On Mon, May 25, 2015 at 01:22:20PM +0300, Anda-Maria Nicolae wrote:
> The next 3 patches do the following:
> - first patch adds Richtek Technology Corporation in the vendor-prefixes list
> - second patch adds device tree binding example for Richtek RT9455 battery charger
> - third patch adds the driver for Richtek RT9455 battery charger

I don't see a changelog against "[PATCH v5] power_supply: Add support
for Richtek rt9455 battery charger", but it seems you overlooked all
of my comments except for the one about splitting the patch (which
looks fine now).

-- Sebastian

--Bn2rw/3z4jIqBvZU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVZ9IqAAoJENju1/PIO/qaBZwP/1zfPCJYIYUc94IZ6AqmyH4r
IQ03XDGXjscjSssi7lu3Z53Hen05Co3GxhQAx0AiYvlZCZX1Cwou/yTqSXgTFzjH
Ff+D7tRCWgRW0vZh71pogTP5wJGT/fD81JoDFp3xNZXiqapfDsgixYxuK0cOTmwG
93jRlKg8y6EJc4ryZ/E6247CkqS084yZQIv7eTPDF2YSvWgMnJpvmnEygXvPIS0I
YQNUduK4CVvo2TgZEXt0umBosSKrqWOIiLbqSN4pXtlKqvk0s0qvJxcXGCoWfGES
jUEb81a+qEnS0HpepTdWC3StWvSruc27VmLphaLOYMkxd96vCxhYjwYCe9ZWD4sw
KbUFEyZ+9olsPBa81EuHZPPrjZJIHwIqMaww860fYa1gb9JyVccl1bbTHagN8LoZ
0jEa7bJdukipOvPFIyXGKsy+CJuX2DGv5TbvvkIl2hxKxaglnPmkj6WNXuCo/a5C
1ri47bZ5mEcWR1DPT7edOhnXd16gsFVyXS+p2piq5EWqJN1jpNEMRsRs/7VTBSGL
SNRI+7X6cGWeej0LwxWQuHsJUPsWyIi/L4QQ4ETb3T176JIPcH/TWNbYGVFayk3D
R8cTYA29i7Wl6yc6DG+B6nJ1W3lJTCPEANB/P6ebVwOtrHuFZEg9OjU+SByu2B94
XeJDJsX7XScPWE2bM8jR
=3m9z
-----END PGP SIGNATURE-----

--Bn2rw/3z4jIqBvZU--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
