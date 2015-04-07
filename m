From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] power: add poodle battery driver
Date: Tue, 7 Apr 2015 17:40:24 +0200
Message-ID: <20150407154023.GA23823@earth>
References: <1427714679-27472-1-git-send-email-dbaryshkov@gmail.com>
 <20150406164428.GB18145@earth>
 <CALT56yOH-rc1RG=xQhcGT-FKJz7D9qKd+rO+8s4PdYrK0weCGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="J2SCkAp4GZ/dPZZf"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:46133 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752989AbbDGPkz (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 7 Apr 2015 11:40:55 -0400
Content-Disposition: inline
In-Reply-To: <CALT56yOH-rc1RG=xQhcGT-FKJz7D9qKd+rO+8s4PdYrK0weCGQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Andrea Adami <andrea.adami@gmail.com>


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Apr 07, 2015 at 03:34:30PM +0300, Dmitry Eremin-Solenikov wrote:
> > On Mon, Mar 30, 2015 at 02:24:39PM +0300, Dmitry Eremin-Solenikov wrote:
> >> Add a driver supporting battery charging on Sharp SL-5600 (poodle).
> >> Voltage and temperature readings are provided through add7846 hwmon
> >> interface. Battery voltage is in1_input (mV) and temp in in0_input
> >> (values unknown, but should be less than 2441).
> >
> > You may want to convert add7846 to iio interface, which can be
> > exposed via hwmon and requested by other kernel drivers (e.g. this
> > one).
>=20
> This needs a more careful thought. I have several devices in mind,
> which provide touchscreen + ADC interfaces, where ADC is used
> for battery voltage and temperature sensing. Sometimes additional
> GPIOs are in play. Thus I'd like for now to sustain from changing
> ads7846 driver. Or, at least to delay such changes, iff there will be
> no real design/ideas how to handle such devices in a generic enough
> way.

If you have more of these devices it's even more appealing to use
the IIO interface. You can basically keep the touchscreen part of
the ads7846 driver and replace hwmon with IIO. Then other kernel
drivers can request an IIO channel, but you are still able to use
hwmon interface from userspace via iio-hwmon.

> [...]

> >> +static int poodle_battery_probe(struct platform_device *dev)
> >> +{
> >> + int ret;
> >> +
> >> + ret =3D gpio_request_array(poodle_batt_gpios,
> >> + ARRAY_SIZE(poodle_batt_gpios));
> >> + if (ret)
> >> + return ret;
> >> +
> >> + mutex_init(&poodle_bat_main.work_lock);
> >> +
> >> + INIT_WORK(&bat_work, poodle_bat_work);
> >> +
> >> + ret =3D power_supply_register(&dev->dev, &poodle_bat_main.psy);
> >> + if (ret)
> >> + goto err_psy_reg_main;
> >
> > we have devm_power_supply_register() now.
>=20
> Not so sure about it. I'd like to cancel work after unregistering power_s=
upply.
> I think I'll even switch from devm_request_irq back to request_irq to be =
able
> to cancel IRQs before canceling work.

Why?

-- Sebastian

--J2SCkAp4GZ/dPZZf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVI/pkAAoJENju1/PIO/qaBCQQAIK/jZ4ufpD5cQM3soRjpdBB
ubqpsI6QYHHXvOY4XNe8RJwQg7U5uAjvEVDiYDfa2dBHADt/0zgDZZURLed9gAkB
tWxmd//FSLXJAQumj4akrsLNdRkuG641gqFxre4YVJ4L4FhOBgeJKJz/gqIMNCiv
VJPZq53F+Wgj59RHsHbUijANs9PbuQdYkNYDg3Or5qwunpusqq+O0o9o+ZnzXPNK
SkiXSAGi2gz6kCS6NoPskn7PxXfrhoGhrGtuyOZcg4ziArnTmrAfRgqjKkItLk/R
/KQqEGXG5JfKu4TtHwMnc9c27Im5/DdbHDld/N8r81pwkV0nTURY44GnVg2fByAg
o1racPTGh3emmcyFzOw6WpM3WaDNmwnZLx4IQwRfzwTsRu2A1lMgUrGRaainBA+G
9eBJvnYgsKxRHEnGfO3yenTPKi+suN2p2KOMr0Fdzx/DnoaNGQaRPL0oEQ8ncV6V
BIufd3JKEZsnwN3mT9ambi9fT16NCJCASeb222ruNBwVPP9l8jq2Pfcfrb9RCIN5
u2q0i9oQINIUiY4gsz/KjDVMEr0pbPQIPZfHtHh5/QcxAo1FQG54a2M1p4uEbAp1
CMt+ozeqG14IlfxOcuyU+4kFY+xjJ+jb9yF/hApqxlb8oqyhNzRiYvIviUmoRkhx
4fKVuX6damyvCzSrOabP
=KJfR
-----END PGP SIGNATURE-----

--J2SCkAp4GZ/dPZZf--
