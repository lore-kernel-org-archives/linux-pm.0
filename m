From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v2 1/4] power: axp20x_usb: Add support for usb
 power-supply on axp22x pmics
Date: Sat, 4 Jun 2016 16:01:55 +0200
Message-ID: <20160604140154.GB31801@earth>
References: <1464887936-17020-1-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="MW5yreqqjyrRcusr"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:55230 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750887AbcFDOCC (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sat, 4 Jun 2016 10:02:02 -0400
Content-Disposition: inline
In-Reply-To: <1464887936-17020-1-git-send-email-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Lee Jones <lee.jones@linaro.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree <devicetree@vger.kernel.org>


--MW5yreqqjyrRcusr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Thu, Jun 02, 2016 at 07:18:53PM +0200, Hans de Goede wrote:
> The usb power-supply on the axp22x pmics is mostly identical to the
> one on the axp20x pmics. One significant difference is that it cannot
> measure / monitor the usb voltage / current.

Acked-By: Sebastian Reichel <sre@kernel.org>

What's the merge strategy for this patchset?

-- Sebastian

--MW5yreqqjyrRcusr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXUt9QAAoJENju1/PIO/qaCksP/327gkFphyeoriNnXhzof9i9
ioJfr/q+Yz2V5I9SPJZyJEd+GoqTgaAyibhtjcw1y4Hiys8qv39TkDv6Jd6qhcq2
xXoEPCHw4aZKfzBQJg4tJ8ErRGqi/6z/GDtI5W+PXK6yFvObSwcOLzqwkwx8Z0Cu
wCnL11f1hGxqfJQ+yIjgFynIvBrYTCTrMynxzgilhDCVAJrqV0CSUx+VOyXcMzeW
ngH2nrwY0j4FQmJT2fl76Sr6MXsnLLwBTvFtqj+SB0jXBDqFb9nXxUR/UOjqHwHM
ZBKZQZpBOKbKntQVuVhn8g/46iKR0vaJVDt9VHh3aXj2vOMWt8SVU8UdNIALgBOw
+R8dGvPyvspHnuOs+uO1CBVeRoZRgAwqagdosjzRgMOe+5Db+5IRH5K8s1ZpZCLC
os2f2UmgPyBL+cRNgcSKPPEjTDODOLbFrG9R1UQ0BuPd5hXTdT39T6l7EmHOLy/L
JJ/PpRn/cUUdg1xBOsNMImc0295UXVWMkbHJcj7n2AJl1MOEhxAAmUyrnqgKrrAO
XZkKMfH9bAX+ixzJHwcIIPQoX9T0fF8LWTvMnqQ5zn3N/9j+bMliahKMJNYTabDH
pP/3Sono2HCs4K+637IFrWNqhQ7qkEBNMkSbrbNHBxd9CBim7BAc99bOT28Fa+Be
npgw6WrejxZP3CihX6JG
=PMqd
-----END PGP SIGNATURE-----

--MW5yreqqjyrRcusr--
