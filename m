From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH 1/2] power: reset: at91: add sama5d3 reset function
Date: Mon, 20 Jul 2015 09:52:31 +0200
Message-ID: <20150720075231.GQ28632@lukather>
References: <1436436947-11210-1-git-send-email-josh.wu@atmel.com>
 <20150710060350.GA3127@piout.net>
 <559F7AC4.6050008@atmel.com>
 <20150710120907.GC3127@piout.net>
 <20150710123148.GA28632@lukather>
 <559FEED3.5080505@atmel.com>
 <55A32EC8.4080309@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VxJb6WgA6MoA+arP"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:41078 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932190AbbGTHzD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 20 Jul 2015 03:55:03 -0400
Content-Disposition: inline
In-Reply-To: <55A32EC8.4080309@atmel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Josh Wu <josh.wu@atmel.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Guenter Roeck <linux@roeck-us.net>, Wei Yongjun <yongjun_wei@trendmicro.com.cn>, Ben Dooks <ben.dooks@codethink.co.uk>, linux-kernel@vger.kernel.org, Krzysztof Kozlowski <k.kozlowski.k@gmail.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Fabian Frederick <fabf@skynet.be>, linux-pm@vger.kernel.org


--VxJb6WgA6MoA+arP
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Josh,

On Mon, Jul 13, 2015 at 11:21:44AM +0800, Josh Wu wrote:
> On 7/11/2015 12:12 AM, Nicolas Ferre wrote:
> >Le 10/07/2015 14:31, Maxime Ripard a =E9crit :
> >>On Fri, Jul 10, 2015 at 02:09:07PM +0200, Alexandre Belloni wrote:
> >>>Hi,
> >>>
> >>>On 10/07/2015 at 15:56:52 +0800, Josh Wu wrote :
> >>>>I would agree with Maxime. Currently all latest chip reset function is
> >>>>compatible with the atmel,sama5d3-rstc.
> >>>>So check compatible string is enough for now.
> >>>>But of cause if we have other incompatible reset in future with new c=
hip,
> >>>>the structure like you said is needed.
> >>>We managed to avoid using of_machine_is_compatible() in all the at91
> >>>drivers. I'd like to keep it that way. It was painful enough to remove
> >>>all those cpu_is_at91xxx calls.
> >>That's your call...
> >>
> >>>Also, using it is trying to match strings and will result in longer bo=
ot
> >>>times.
> >>Have you looked at the implementation of of_match_device? If that's
> >>really a concern to you, you should actually avoid it.
> >I agree: let's keep it simple and use of_match_device().
>=20
> Ok. I will keep it as it is now:  use the (match->data !=3D sama5d3_resta=
rt)
> for the condition.

I'm not just that's been an option in our discussion so far.

Nicolas said that he was agreeing with me, but at the same time said
the complete opposite of what I was arguing for, so I'm not really
sure what's really on his mind, but the two options that were
discussed were to remove that test, and either:

  - Use of_device_is_compatible to prevent the loop execution

  - define a structure with a flag to say whether you need the ram
    controller quirk or not, and test that flag.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--VxJb6WgA6MoA+arP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVrKi/AAoJEBx+YmzsjxAgDSAP/3/a/DPKlVY/84A3cptvIvoH
qrmkYoN5chZlIeLY+pkgOFQizKAYarHgnhj4Fnz3+SeIhDE7kxh1f7+Ws85VyrhN
319qn/tofsg/GCsvpsWIkJz954QamVMlIgRDPY7LZ9g0/2t54PODaqh8OgFcn2I5
Ut6xLGwIiwJqot+qTU41GsdvqomYG+vkR7QLxUDDx0etVs0/c7Ppy/m3NioQLUIC
SylZYhcpFnSKULpCRJUV/ohJA9IxR4hBe+09w53SuEU4DC2N8gnyaAejZpnSwYX1
KMK3p6lFjX5auUWfyLixJe/VXYdTsEph3kfh9noBu1LZaYrUfckTvb8Bt7XQgVHm
G3gVzJxMoluSMmLsn9UluXfB5yXW4LxcVSYzb99wDmyAXCHckIrbrKNERmNWyJkD
4orgI1J0dT2iUNkiSGw8fNUCcQeKtgSlg0yyvoq2lkZ/VZJKfT9sHmfl6WPG+hqq
BEdS1u89BJosfL3HROwf40ghbEuReiVVAD7jBPS7bQqPwNEffVEVOA7L4ZuLNZxE
KXGTSPgvG0KK/+nqrvZEQheQHOld435boDpnsujv6aL2aA9XzJ6TojlDN0xjbOZV
DOWZzbh77coWQYIBAF3Vi+a9U+97qKi4YwhjAyMIrqw0nGkekTDC5iu8dmv8Sogk
QoqUkWyWKtjlCKxfhje7
=Sq48
-----END PGP SIGNATURE-----

--VxJb6WgA6MoA+arP--
