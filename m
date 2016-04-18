From: Felipe Balbi <balbi@kernel.org>
Subject: Re: [PATCH v7 1/4] gadget: Introduce the usb charger framework
Date: Mon, 18 Apr 2016 11:18:16 +0300
Message-ID: <87d1pngwjb.fsf@intel.com>
References: <cover.1458128215.git.baolin.wang@linaro.org> <11ce6df3eb8a95cfed26f3321f15c98a934db642.1458128215.git.baolin.wang@linaro.org> <87h9foqnur.fsf@intel.com> <CAMz4kuJ=StEMsdHgX6n6wi13bs3CZ+9GYXBvdZ5mu+giSmnWdg@mail.gmail.com> <87poubgnbh.fsf@intel.com> <CAMz4kuJwfWPEndmVMoDBQQFZ2X8BAzDgej_9qMKQq0xU3tC=5w@mail.gmail.com> <20160322112940.GB26924@xo-6d-61-c0.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160322112940.GB26924@xo-6d-61-c0.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>, Baolin Wang <baolin.wang@linaro.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Peter Chen <peter.chen@freescale.com>, Alan Stern <stern@rowland.harvard.edu>, r.baldyga@samsung.com, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Linux PM list <linux-pm@vger.kernel.org>, USB <linux-usb@vger.kernel.org>, device-mainlining@lists.linuxfoundation.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Pavel Machek <pavel@ucw.cz> writes:
> Hi!
>
>> > It's your HW :-) You tell me if it's really necessary. But, hey, if you
>> > get enumerated @500mA, this is the host telling you it _CAN_ give you
>> > 500mA. In that case, why wouldn't you ?
>
> Dunno, perhaps not to drain battery in host too quickly?
> Or perhaps you are charging from external battery?
>
>> >>> why RW ? Who's going to use these ? Also, you're not documenting this
>> >>> new sysfs file.
>> >>
>> >> Cause we have show and store operation for SDP type. If users want to
>> >> know or set the SDP current, they can use the sysfs file.
>> >> I'll add the documentation for it.
>> >
>> > but why would the user change it ? Here's the thing: you have a few
>> > posibilities for this:
>> >
>> > a) you are connected to a dedicated charger
>> >
>> >         In this case, you can get up to 2000mA depending on the charge=
r.
>> >
>> >         If $this charger can give you or not 2000mA is not detectable,
>> >         so what do charging ICs do ? They slowly increase the attached
>> >         load accross VBUS/GND and measure VBUS value. When IC notices
>> >         VBUS dropping bit, step back to previous load.
>> >
>> >         This means you will always charger with maximum rating of DCP.
>> >
>> >         Why would user change this ? More is unsafe, less is just
>> >         stupid.
>
> Less is not neccessarily stupid. First, it is useful for debugging, secon=
d, you
> don't know how much this charger can give you. You measured you can get 1=
.8A,
> but the note on the charger says 1.5A. You may want to go with 1.5A.
>
> Also, there are several incompatible standards for detecting
> "dedicated charger". IIRC iPhone has different one from iPad. So it is
> quite important to be able to control this manually.

manually ??? Hell no! Charger IC should be able to do this no
problem. I would be surprised if there's any charger IC out there which
blindly connects a 1.8A load from the start. What these ICs do is that
they slowly increment the load and check voltage level. They'll continue
to do that up to the maximum you listed (1.8A, let's say). As soon as
voltage drops a bit, charger IC knows that it use previous load.

>> > d) you are connected to a standard port and get enumerated with your
>> > 100mA configuration.
>> >
>> >         you *know* 100mA is okay. So you connect a 100mA load and get =
it
>> >         over with.
>> >
>> >         This means you will always charger with maximum rating for this
>> >         SDP.
>> >
>> >         Why would user change this ? More is unsafe, less is just
>> >         stupid.
>
> I've needed to override 100mA default many times. Maybe it is unsafe,
> but it is useful.

still unsafe. If you really wanna do that, you're welcome to removing
safety margins from your own kernel, but we're definitely not going to
ship this to millions of users.

> (And with USB 5V connected directly to pretty beefy PC power supply...
> it is sometimes safer than it looks).

you're not considering the thermal dissipation on the USB connector
itself. Many of them might not use good metals because they assume the
maximum power dissipated is 500mA * 5V =3D 2.5W. If you try to draw more,
you could, literally, melt the connector.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXFJhJAAoJEIaOsuA1yqRE6mkP/jCXVGBlBPJLaQzYz5yh8Ca2
02vvZiO5026dsfUCUc03dHO/A9NGMYIntJY16dZlqPe+ZQwAnZuZtcIhWkyl77OL
yd2pv46hns6So000jZD9zvg0MKzq6SvAgRwqBqn53z4e0QfbCKCrQ3XhER0UY4eB
yaKFXmgRxOP7NP7R/3Xz2bM3uIo+SQ/aVhL1C9iiAwLOiRlZ3fsXFbPk/OuSjTh1
XP+OvW3FeckYa2p0xmonHTx8X1kp+l+QW/Mgl0zxgQR6wFI12TmoQU0qW2PiN/Bf
JoYqi1pfhIEyoHBumBME8/6XzbtDxIGq+gEmk8N0nSIeiJ5oS7cINbOK6YpkGInY
Kt2Q/M+EbU9pETVCwvCWMpPNYQn2hqhxAMnpWAVONWU+ySSHY2HUN09CLWa1mrQi
3iCJnz3R0qX1+/Sa/gNib7wGSDUBbzi8Dpk+kUl5r5l71Q8ojcWllEZ/GSx7YnIk
/kiE8gCXxXYlgavrugoGcWswdneU4eEORVjBPFyq7fiTEMU26jXPdXD/ZA7mg0sm
OT/msGPS8PnymXZOhVJbNUOsDJsh7wniZcN2Z7/iOleJGuiLgY0jywa+7axI41M/
4A+Cb5gkmRr7AOpDh5EKQ9MKeCBbeTh3tIe21cW2Dl1MHiA4ApjP/roZxaT11fWG
ysw7Z6iCZnBA578rNYEy
=YsFI
-----END PGP SIGNATURE-----
--=-=-=--
