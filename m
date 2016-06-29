From: Felipe Balbi <balbi@kernel.org>
Subject: Re: [PATCH v12 2/4] gadget: Support for the usb charger framework
Date: Wed, 29 Jun 2016 11:20:52 +0300
Message-ID: <87eg7giexn.fsf@linux.intel.com>
References: <cover.1466497505.git.baolin.wang@linaro.org> <f7bae2566824a5e1da14c1a19dee6af5f250262f.1466497506.git.baolin.wang@linaro.org> <87bn2uomzd.fsf@linux.intel.com> <CAMz4kuJ990pfVxSz7sVEOOiL8gC+BAjJ=PLioez5_Y5c+OyxxQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMz4kuJ990pfVxSz7sVEOOiL8gC+BAjJ=PLioez5_Y5c+OyxxQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Baolin Wang <baolin.wang@linaro.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, robh@kernel.org, Jun Li <jun.li@nxp.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Ruslan Bilovol <ruslan.bilovol@gmail.com>, Peter Chen <peter.chen@freescale.com>, Alan Stern <stern@rowland.harvard.edu>, r.baldyga@samsung.com, grygorii.strashko@ti.com, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Linux PM list <linux-pm@vger.kernel.org>, USB <linux-usb@vger.kernel.org>, device-mainlining@lists.linuxfoundation.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Baolin Wang <baolin.wang@linaro.org> writes:
>> Baolin Wang <baolin.wang@linaro.org> writes:
>>> For supporting the usb charger, it adds the usb_charger_init() and
>>> usb_charger_exit() functions for usb charger initialization and exit.
>>>
>>> It will report to the usb charger when the gadget state is changed,
>>> then the usb charger can do the power things.
>>>
>>> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
>>> Reviewed-by: Li Jun <jun.li@nxp.com>
>>> Tested-by: Li Jun <jun.li@nxp.com>
>>
>> Before anything, I must say that I really liked this patch. It's
>> minimaly invasive to udc core and does all the necessary changes. If it
>> wasn't for the extra charger class, this would've been perfect.
>>
>> Can't you just tie a charger to a UDC and avoid the charger class
>> completely?
>>
>>>  static inline int usb_gadget_vbus_draw(struct usb_gadget *gadget, unsi=
gned mA)
>>>  {
>>> +     if (gadget->charger)
>>
>> I guess you could do this check inside
>> usb_gadget_set_cur_limit_by_type() itself.
>
> We will access the 'gadget->charger->type' member when issuing
> usb_gadget_set_cur_limit_by_type(), so I think I should leave the
> check here in next new version.

Here's what I mean:

int usb_charger_set_cur_limit(struct usb_gadget *gadget, unsigned int mA)
{
	struct usb_charger *charger;
        enum usb_charger_type type;

	if (!gadget->charger)
        	return 0;

        charger =3D gadget->charger;
        type =3D charger->type;

	return __usb_charger_set_cur_limit(charger, type, mA);
}

static inline int usb_gadget_vbus_draw(struct usb_gadget *gadget, unsigned =
mA)
{
	usb_charger_set_cur_limit(gadget,  mA);

 	if (!gadget->ops->vbus_draw)
 		return -EOPNOTSUPP;
 	return gadget->ops->vbus_draw(gadget, mA);
}

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXc4TkAAoJEIaOsuA1yqREwkoQAI6uP3OyR4RvQd/sBr9n660Y
s4x6RtJMh5SYGEKduyzG4G/SxZILResFHHGgJ0Lz/K2yG7J5DXOOerBVqYoddanh
xKKJvS7bV9kJmab8yifcgrfK9OpVitHqagSonr34fO2zW41yKyqFs0G20aIf7xRD
5viOXZhOZE/L/hyPwEGbgMk1SHv9D7M4v7tk3PSPBvVd8q8PgENiEp3VH8f3Tx96
AMoKr+0agmPnjx2oiaZsyQ2e/BkBYj002ItUeS3rWz/TnLnBa7xPP0VLhmJnGb8I
re1BMwwqaKBGdwrGBrxGeHOcjaosmovvT9aXTVJpIKHiBIUawoXYoXTcv1CyLHp0
hARSU8zXyKJKkzqLaT/YikySqICXgtdcxodTzd+HYcq7uynTsoHBPy6xEP9nKm/v
othfygHdoxMta/yAgs9xdvWxP9S7AMJ141X2n7hHAJQFOUFAMDdcQg8xJXqwBbxY
rW0xl0ZvqFrqDqiRWdNtdfMb4Ra2OQhZTOgg7acqD54zWFL138nXcVDXxoiwcixG
4FQtkqdFS1kR2p/M+gSH3DnZbFPk4mBlbC1G5sNbXOrYjXQJczbeM1rWuULXG+UV
K5aCoKPwgHCh4mQ0tEbY+2HXZRj4qt1QtT4NwB2GyAB9uIUm91RYFffCKXbv7Ssj
Ur+slhCDdgg5CV25Ite4
=89KN
-----END PGP SIGNATURE-----
--=-=-=--
