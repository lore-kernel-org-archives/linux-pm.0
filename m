From: Felipe Balbi <balbi@kernel.org>
Subject: Re: [PATCH v7 1/4] gadget: Introduce the usb charger framework
Date: Mon, 18 Apr 2016 13:30:54 +0300
Message-ID: <877ffvgqe9.fsf@intel.com>
References: <cover.1458128215.git.baolin.wang@linaro.org> <11ce6df3eb8a95cfed26f3321f15c98a934db642.1458128215.git.baolin.wang@linaro.org> <87h9foqnur.fsf@intel.com> <CAMz4kuJ=StEMsdHgX6n6wi13bs3CZ+9GYXBvdZ5mu+giSmnWdg@mail.gmail.com> <87poubgnbh.fsf@intel.com> <20160322113012.GC26924@xo-6d-61-c0.localdomain> <87fuujgwsm.fsf@intel.com> <20160418102316.GA27936@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:10245 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752165AbcDRKc6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 18 Apr 2016 06:32:58 -0400
In-Reply-To: <20160418102316.GA27936@amd>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Baolin Wang <baolin.wang@linaro.org>, Greg KH <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Peter Chen <peter.chen@freescale.com>, Alan Stern <stern@rowland.harvard.edu>, r.baldyga@samsung.com, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Linux PM list <linux-pm@vger.kernel.org>, USB <linux-usb@vger.kernel.org>, device-mainlining@lists.linuxfoundation.org, LKML <linux-kernel@vger.kernel.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Pavel Machek <pavel@ucw.cz> writes:
>> > Very often, you want to charge using 1.8A from an old desktop PC.
>>=20
>> if that old desktop's port is not a charging port, you shouldn't be
>> allowed to do that. Not ever.
>
> Yes, Felipe just decided that I should not be able to charge my N900
> in useful way.

you can do whatever you want with *your* kernel binary, but we're not
gonna ship something potentially dangerous. If that PC port is telling
you it can only allow 100mA, you should *not* be allowed to overcome
that limitation from the device side, sorry.

>> >> a) you are connected to a dedicated charger
>> >>=20
>> >> 	In this case, you can get up to 2000mA depending on the charger.
>> >>=20
>> >> 	If $this charger can give you or not 2000mA is not detectable,
>> >> 	so what do charging ICs do ? They slowly increase the attached
>> >> 	load accross VBUS/GND and measure VBUS value. When IC notices
>> >> 	VBUS dropping bit, step back to previous load.
>> >>=20
>> >> 	This means you will always charger with maximum rating of DCP.
>> >>=20
>> >> 	Why would user change this ? More is unsafe, less is just
>> >> 	stupid.
>> >
>> > Actually, less is not stupid. Charging li-ion battery from li-ion batt=
ery might
>> > be stupid. Imagine I'm on train, with device like N900 (50% battery) a=
nd power bank
>> > (3Ah). I'm actively using the device. If I let it charge at full curre=
nt, I'll waste
>> > energy. If I limit current to approximately the power consumption, it =
will run the
>> > powerbank empty, first, then empty the internal battery, maximizing to=
tal time I
>> > can use the device.
>>=20
>> why would you waste energy ? What the charger chip would do is charge
>> battery to maximum then just to maintenance charge from that point
>> on. Where is energy being wasted other than normal heat dissipation ?
>
> Physics 101, of course wasted energy goes to heat. Lets not waste
> energy by charging li-ion from li-ion when it is not required.

your cellphone has no means to know that it's connected to a Li-Ion
battery. We don't have visibility on what we're connected to, just how
much it can source.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXFLdfAAoJEIaOsuA1yqRE0YwQAKscgrZjgyb/0F/jD7kM0I0D
Au1fJYsBl3Xhy0eWI6OwGsJefCGEAd0RqqAb5f5TX2tFesDW3xInw/IvizqsNoku
J4NyVeQOrGtS1SS3R5dHw9pNAUFMKAcQC7RDhkPrdJRM7GdFgTw5qRXMi3ob/aW/
Rjxa11dW0ZguJGtYk7zfG95hUM0xJe6Kd94ZMk/fW75EGHvItTIUuGqMJ0Svg18j
Z9JmP7/VcHDeb0wXOivndMRmbK298hq9/EPG1cpvT2hOAEYQ66vi0DpCLShUKfiw
XRLdDC7jJdSyRY+bzvAKtdWEPzFy/aIxOAgPHpRN3+ey/Xb6r+VrAV8rvzsW/k6H
HKLNA1BgGEAgXll3xNOMBBH9U3lRvBuZV93aqkTV58Gy3/pIkUjaIK6nitKtHV6F
Z2gSC2CCE55u9XsyB8UO6qyyBH0PozJe6+co56fNsII7SmfQhXkAG6oRQoYRU5OI
yKSrG6ULBG8V9mYIYW1nIy0mwXgAw1zR7UspXKmx/BsrFY+S0KUDXOhFAb/QegZs
OlzafethS8DCPtYwl/+ZYtwdWofi6VT8rvDDqqIJkwXHZTcJQSeZr78XKLacoDHF
bBXsNM+HgvAj0B8N0YJJId4B++4/UMP0u/1K4nMl+PrEqNJxon426AN8OOWlhLP2
SfuLW3/X/wjd6wLNx3fU
=RQ+R
-----END PGP SIGNATURE-----
--=-=-=--
