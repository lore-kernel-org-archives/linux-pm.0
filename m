From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [linux-sunxi] [PATCH 6/8] ARM: dts: axp209: Add usb_power_supply
 child node to the ax209 node
Date: Fri, 31 Jul 2015 09:57:18 +0200
Message-ID: <20150731075718.GW2564@lukather>
References: <1433885881-19809-1-git-send-email-hdegoede@redhat.com>
 <1433885881-19809-7-git-send-email-hdegoede@redhat.com>
 <CAGb2v66X79dK84hG8NVTho-kPPMNcKXQspvT2pCM8Zbmnme53A@mail.gmail.com>
 <20150731075104.48c467e6@pluto.restena.lu>
 <CAGb2v67nM7pauyjyhBdfgX7p_Rud6TEsNqphB+gx4ROekVqtbw@mail.gmail.com>
 <20150731083541.5f2c683a@pluto.restena.lu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QNuYedFeXxEqrKRj"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:58119 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751272AbbGaH6E (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 31 Jul 2015 03:58:04 -0400
Content-Disposition: inline
In-Reply-To: <20150731083541.5f2c683a@pluto.restena.lu>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Bruno =?iso-8859-1?Q?Pr=E9mont?= <bonbons@linux-vserver.org>
Cc: Chen-Yu Tsai <wens@csie.org>, Hans De Goede <hdegoede@redhat.com>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Kishon Vijay Abraham I <kishon@ti.com>, Felipe Balbi <balbi@ti.com>, linux-pm@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, devicetree <devicetree@vger.kernel.org>, linux-sunxi <linux-sunxi@googlegroups.com>


--QNuYedFeXxEqrKRj
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 31, 2015 at 08:35:41AM +0200, Bruno Pr=E9mont wrote:
> > > NB: I should hopefully get my battery supply driver ported this WE,
> > > ac-in/rtc are done, this WE. I'm going to default-off for them as well
> > > (note that for some extra details should be provided in dts).
> >=20
> > I'm guessing we won't be using the axp288 one?
>=20
> In a first step I won't be using it.
>=20
> There are a few reasons for that:
> - axp288 is based on ACPI/platform to provide configuration information
>   instead of dts

That's not an issue. You have an API to handle lookup in both DT and
ACPI (the fwnode_* stuff).

> - it makes extensive use of OCV and registers that are possibly present
>   on axp20x but undocumented there.

That will be more problematic. Still I don't see why we wouldn't use a
similar setup to what they did.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--QNuYedFeXxEqrKRj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVuypeAAoJEBx+YmzsjxAgMRYP/jRcntuhrR3bgOyETzFm8RVG
qwWaigkjz2Vrk2C6hERbWNLC07NjXOje+N5c//iZp0ObYkQZi1uiPZbNFKfW2Nhw
9lAwKK6Pbp0lRhEmKHO5Ta0n5GVP7zOxc2ZxnGR1Kgi2AIWVJidlCSZ0Zdv3hcQy
4P1GoHTpaLWKhIoraykVEb35JHhWHsCaCfe3ReE/oC3dxDsKAXqqaEmL3h+/bpqy
N11yodDhVMoSXo2Eak0GBJG1TCkcE1h71braBTMSfNEd4DiwcafSeqc+oZst0Hkf
AJtaCBQX+Y/NrHmZpIEKpphkPvcnBdwXP/eGr8OHKrx5J0ZhdRvx1GgsHEnEykf2
FdaxBLAzD9Xado2pzAAj72mNaRaw8o184re+0J5WjhZtE11OOUSfgCsgmi+UvDGB
FWmwZBd8j2YOVN8RZmcSDr4SXogpn4HSGldoRd+ZnmbQAU8CAiKRLyCdm1ew2Q8e
VdnDx/Zmj+8jqdoxscozf+PQM8XMHJxkpT63b3uRiPAa0wBGc051t/TamMZp0/UH
AdVGEISX38ppHZ4Wmv7SlEqfTRA6TOjEw7BbJYng9KRKG693jxc0+9F74n9nOmBp
ft3klnufvw+OIwQ0N6hCCMkBIvFxrKXPJDbxbcWEXKVPfI/2JCwJHy8aeNIowPlN
HbIgjIq5N88S2HYArHhq
=9g5t
-----END PGP SIGNATURE-----

--QNuYedFeXxEqrKRj--
