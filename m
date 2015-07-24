From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] power_supply: Adjust devm usage
Date: Fri, 24 Jul 2015 14:59:51 +0200
Message-ID: <20150724125951.GA25447@earth>
References: <20150724115813.GA3004@vaishali-Ideapad-Z570>
 <20150724122622.GA22105@earth>
 <CAK-LDbKk5wYAKVJ9eE5Kr6iOW1ah6VxAxBWcZjbufHp8WZXW=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1yeeQ81UyVL57Vl7"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:55704 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754014AbbGXM74 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 24 Jul 2015 08:59:56 -0400
Content-Disposition: inline
In-Reply-To: <CAK-LDbKk5wYAKVJ9eE5Kr6iOW1ah6VxAxBWcZjbufHp8WZXW=g@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Vaishali Thakkar <vthakkar1994@gmail.com>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org


--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jul 24, 2015 at 06:03:38PM +0530, Vaishali Thakkar wrote:
> On Fri, Jul 24, 2015 at 5:56 PM, Sebastian Reichel <sre@kernel.org> wrote:
> > On Fri, Jul 24, 2015 at 05:28:13PM +0530, Vaishali Thakkar wrote:
> >> @@ -267,8 +267,9 @@ static int bq24735_charger_probe() {}
> >> [...]
> >
> > Your patch is missing removal of the
> > kfree(charger->charger_desc.name) in bq24735_charger_remove().
>=20
> Yes. Because it seems that this kfree is freeing some other data which
> is not related to devm_kzalloc. I was not sure about removing it.
> So, I was about to discuss it in a separate thread.s

it's assigned in the probe function:

    name =3D kasprintf(...);
    ...
    supply_desc->name =3D name;
    ...
    power_supply_register(..., supply_desc, ...);


> Also, in the remove function we have devm_free_irq. I am unsure it
> too. Because normally remove functions do not use devm
> counterparts.

It's required to free the irq before removing the power supply
device.

If the power supply is registered with devm, that should happen
automatically, since it is requested before the irq.  Thus the
remove function can be removed completely at that point :)

-- Sebastian

--1yeeQ81UyVL57Vl7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVsjbEAAoJENju1/PIO/qaP2MP/i/KEY08MUfjeN90BefwFXxa
nFyDONU2CqY3dhPLtfG1aOo3yJ/Fls3JNrB2ffQY4+0qsnlGuwmsRV9zSVwd19P+
/DMwALqTYbUfCjH8TQRfGZF31v+ww9oHrwpN7WMWtpi3MR2SXF/sMygduI7J4VF9
KzDBtnILlfrqzhT1dYC9hF7f3SsGL7H7rmz+ksQdE4kgJfz71FK0NxcRvdRkh3Om
RbFJoj0JVASrGE90Wkm+W4sQcl7Y/bPyDRBauRXkXWgNT8SluwWe/bDTwRA29f07
1O2ZJX7RfPa6xba6I5GiUUHXsbBPSy5WDpmX77IOX8Mp+W3ogWWNLXptUb18tU1G
5JvysLmS5yiLz9hZi/08tyAOGv4Nms5kATiBps9Oap44YVLAXeC0pfeiOLJaLc1x
/8fIik8DR2ZutNms9vnJgimEcc2CpjzCnDPmWyWD6J4zz184GmYsq6B69ecX5VAg
saOGOtFaUryeTz/85RY0kSkKgkoE1kr3uvvbk8DV/bR0qPcEyt++Fv+xybhlNqRh
9VksF0J0CjqzY0Qju8WfjTsytJWRGTSN6Krxz8EC2Rbreh+2ulos6bXDvFS1x26G
nwJvf3DjjGSGAWfS7cMFQVVpd3zx2J3RIuS9+LjuHsTQIv9/0OTRsdRZr1sSPTJb
WpuUDNq+MIyh2xQ5mb5K
=wrMn
-----END PGP SIGNATURE-----

--1yeeQ81UyVL57Vl7--
