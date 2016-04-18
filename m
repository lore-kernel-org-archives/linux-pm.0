From: Felipe Balbi <balbi@kernel.org>
Subject: Re: [PATCH v7 1/4] gadget: Introduce the usb charger framework
Date: Mon, 18 Apr 2016 11:12:41 +0300
Message-ID: <87fuujgwsm.fsf@intel.com>
References: <cover.1458128215.git.baolin.wang@linaro.org> <11ce6df3eb8a95cfed26f3321f15c98a934db642.1458128215.git.baolin.wang@linaro.org> <87h9foqnur.fsf@intel.com> <CAMz4kuJ=StEMsdHgX6n6wi13bs3CZ+9GYXBvdZ5mu+giSmnWdg@mail.gmail.com> <87poubgnbh.fsf@intel.com> <20160322113012.GC26924@xo-6d-61-c0.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:18409 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751126AbcDRIOq (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 18 Apr 2016 04:14:46 -0400
In-Reply-To: <20160322113012.GC26924@xo-6d-61-c0.localdomain>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Baolin Wang <baolin.wang@linaro.org>, Greg KH <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Peter Chen <peter.chen@freescale.com>, Alan Stern <stern@rowland.harvard.edu>, r.baldyga@samsung.com, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Linux PM list <linux-pm@vger.kernel.org>, USB <linux-usb@vger.kernel.org>, device-mainlining@lists.linuxfoundation.org, LKML <linux-kernel@vger.kernel.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Pavel Machek <pavel@ucw.cz> writes:
>> >>> +#define DEFAULT_SDP_CUR_LIMIT        (500 - DEFAULT_CUR_PROTECT)
>> >>
>> >> According to the spec we should always be talking about unit loads (1
>> >> unit load is 100mA for HS/FS/LS and 150mA for SS). Also, this will not
>> >> work for SS capable ports and SS gadgets (we have quite a few of them,
>> >> actually). You're missing the opportunity of charging at 900mA.
>> >
>> > I follow the DCP/SDP/CDP/ACA type's default current limitation and
>> > user can set them what they want.
>>=20
>> no, the user CANNOT set it to what they want. If you get enumerated
>> @100mA and the user just decides to set it to 2000mA, s/he could even
>> melt the USB connector. The kernel _must_ prevent such cases.
>
> root should be allowed to do that.

root should not be allowed to put user at risk. The usb connector is a
path to earth ground in most (all?) desktop computers. Allowing root to
put that connector in a situation where it could melt the connector and
short mains should never be allowed.

> Very often, you want to charge using 1.8A from an old desktop PC.

if that old desktop's port is not a charging port, you shouldn't be
allowed to do that. Not ever.

> N900 will simply not charge from .5A.

it used to with original maemo userspace/kernel.

>> a) you are connected to a dedicated charger
>>=20
>> 	In this case, you can get up to 2000mA depending on the charger.
>>=20
>> 	If $this charger can give you or not 2000mA is not detectable,
>> 	so what do charging ICs do ? They slowly increase the attached
>> 	load accross VBUS/GND and measure VBUS value. When IC notices
>> 	VBUS dropping bit, step back to previous load.
>>=20
>> 	This means you will always charger with maximum rating of DCP.
>>=20
>> 	Why would user change this ? More is unsafe, less is just
>> 	stupid.
>
> Actually, less is not stupid. Charging li-ion battery from li-ion battery=
 might
> be stupid. Imagine I'm on train, with device like N900 (50% battery) and =
power bank
> (3Ah). I'm actively using the device. If I let it charge at full current,=
 I'll waste
> energy. If I limit current to approximately the power consumption, it wil=
l run the
> powerbank empty, first, then empty the internal battery, maximizing total=
 time I
> can use the device.

why would you waste energy ? What the charger chip would do is charge
battery to maximum then just to maintenance charge from that point
on. Where is energy being wasted other than normal heat dissipation ?

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXFJb5AAoJEIaOsuA1yqREm9oP/iiXCKAmogSOIOEJorJKZy6o
Azphy+Vr6ou00Mji1jNy8kCsEVGlG60AyDPHwTPsWL8cPGuP9qam6LW5O7CGmVoj
GCPoRJTKnFVseEivmPQ/F5rxYtTTnWfoseGMlWCG6OC4cmobfb1Y+pYYbnAtxwhe
BNIMUw9fg4yz2FzUNXiibnBDxrZYs5pqkUkgkeY76hOjaebq0uqch3PyPO7ku8Yy
umfsdAo9rxmuxxPHNq0x9Jk2WrDpQPSOtswf23S/lAJ22uezsox4ixYhTd7r8hIP
KU1NK9yTbBBiAI7UGJCmLj+7HZwNTI5BK1NTY3G1R7oV7lXfcJFv9PhdZuVek3/A
6wYea8UjgL5kkXnIqkQlcZNnqgq2uh+HcrQEmCnLJqw7YNKdUu/5Sfm2041O809l
bJVMwGV6RL8BNnm1F0OrGnvyXxlLbcgta58BaNDm3wN/JHXdVuvv80qVfNhwrto6
vkwf2VKz9Yzy+lPnptijmGdy8b4bmPFGvYceH5FSbsNsvlDjgSQBS8bgLmjdAU34
L2rZav8/LlOR+s3qjmV3NfgtsfcBjpph0YBnnMfZXycV6MKHFN2IaY4S2Ql0xv1m
70VyAmLau0qRAkzlzBRJEUNfBD+Qbsd6qCXWDTickOAScmwxNz2Rqk0kOL0lZ+4L
MYieCMCm+mlZ7PNTrIjx
=uaLM
-----END PGP SIGNATURE-----
--=-=-=--
