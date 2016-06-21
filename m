From: Felipe Balbi <balbi@kernel.org>
Subject: Re: [PATCH v12 4/4] power: wm831x_power: Support USB charger current limit management
Date: Tue, 21 Jun 2016 14:53:44 +0300
Message-ID: <87oa6un4fr.fsf@linux.intel.com>
References: <cover.1466497505.git.baolin.wang@linaro.org> <7dc384248d51b1de0df54909f3c5550584b31357.1466497506.git.baolin.wang@linaro.org> <878txyomue.fsf@linux.intel.com> <20160621110332.GC26099@sirena.org.uk> <CAMz4kuJnkd=zpbnaCRcYd4wjzWVpr5Zom0BBJRnjTTikpwxKjA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:14402 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751537AbcFUMJd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 21 Jun 2016 08:09:33 -0400
In-Reply-To: <CAMz4kuJnkd=zpbnaCRcYd4wjzWVpr5Zom0BBJRnjTTikpwxKjA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Baolin Wang <baolin.wang@linaro.org>, Mark Brown <broonie@kernel.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, robh@kernel.org, Jun Li <jun.li@nxp.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Ruslan Bilovol <ruslan.bilovol@gmail.com>, Peter Chen <peter.chen@freescale.com>, Alan Stern <stern@rowland.harvard.edu>, r.baldyga@samsung.com, grygorii.strashko@ti.com, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Lee Jones <lee.jones@linaro.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Linux PM list <linux-pm@vger.kernel.org>, USB <linux-usb@vger.kernel.org>, device-mainlining@lists.linuxfoundation.org, LKML <linux-kernel@vger.kernel.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Baolin Wang <baolin.wang@linaro.org> writes:
> On 21 June 2016 at 19:03, Mark Brown <broonie@kernel.org> wrote:
>> On Tue, Jun 21, 2016 at 01:30:49PM +0300, Felipe Balbi wrote:
>>> Baolin Wang <baolin.wang@linaro.org> writes:
>>> > @@ -607,8 +647,31 @@ static int wm831x_power_probe(struct platform_de=
vice *pdev)
>>> >             }
>>> >     }
>>
>>> > +   if (wm831x_pdata && wm831x_pdata->usb_gadget) {
>>> > +           power->usb_charger =3D
>>> > +                   usb_charger_find_by_name(wm831x_pdata->usb_gadget=
);
>>
>>> the fact that you rely on strings and pass them via pdata is an
>>> indication that you don't have enough description of the HW. Seems like
>>> we need to come up with a set of DT properties which tie a charger to a
>>> UDC.
>>
>>> I'm thinking a phandle would be enough?
>>
>> The wm831x has no DT support currently.
>
> Another hand I suppose the usb charger is one virtual device and does
> not need be described from DT.

Right, I don't think that should be a device at all. But you can pass a
phandle to the UDC controller and use that to get to struct usb_gadget
from which you could reach ->charger.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXaSrIAAoJEIaOsuA1yqREeJAP/3kHX2wBC3AteYZtSGESXuej
QsfUefnKFewuJAw25P3prsHvPROBEj0SW4q6HEmPU7RrcncvgcbLSex4ZwyYULpH
0cg4cJ8R+prAmD0I2QhV0GYH9GkbOrrYR7TZPhNsE+PqTrGFwiSag0ihgQPKhCNr
Si/IleEQ6bV5ZSCVTThgFt1hoRBfw/52smbIII25gKATTlrYQ44Bqm/mwRWZkmf0
4zr6BZwY9RERKXeGhr9odnYaA9rrJMSwz2qYWy6lhGHDkfuWlgUyYIxNjmx7iyu+
WI7bsZw13GC8w9LaYB90E3I42JkdrfwDtkZBdnUGXLT3FL++HCE1fdIL/puoQ8Ds
1+qvg/QQdqslWMmCZnrcbAYtWG44HKQ7ys3ehnBrDtWyTF4f2J0V0YzNoRteDAWe
i7SXbGWzbMRvTAjs3BNSNzfy4D8nfqPBHJ3mW5Ng70Islde3j5BkyTskWGcufx+L
xTslyMtBtaI8vJWKLSlf1f0rqjyR471uNzlnle2y9NRug84CjrN6TstqlqlkZ2NP
H7nRQ+a3q14xqdsUTKYQTXKfW4I625JpJTTDhYYduzUD/wzpAuauU3i4F+ALAoR7
9SQj5XDWlqe6RNf/GApAunSJXrg/TLIL5lIw9k5D7STDwt5vC2cPhHo1lLscfvVA
HEdbQ5WgNqxXaxDxskiS
=uHw8
-----END PGP SIGNATURE-----
--=-=-=--
