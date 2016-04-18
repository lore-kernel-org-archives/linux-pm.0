From: Felipe Balbi <balbi@kernel.org>
Subject: Re: [PATCH v7 1/4] gadget: Introduce the usb charger framework
Date: Mon, 18 Apr 2016 13:45:08 +0300
Message-ID: <871t63gpqj.fsf@intel.com>
References: <cover.1458128215.git.baolin.wang@linaro.org> <11ce6df3eb8a95cfed26f3321f15c98a934db642.1458128215.git.baolin.wang@linaro.org> <87h9foqnur.fsf@intel.com> <CAMz4kuJ=StEMsdHgX6n6wi13bs3CZ+9GYXBvdZ5mu+giSmnWdg@mail.gmail.com> <87poubgnbh.fsf@intel.com> <CAMz4kuJwfWPEndmVMoDBQQFZ2X8BAzDgej_9qMKQq0xU3tC=5w@mail.gmail.com> <20160322112940.GB26924@xo-6d-61-c0.localdomain> <87d1pngwjb.fsf@intel.com> <20160418103350.GB27936@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160418103350.GB27936@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Baolin Wang <baolin.wang@linaro.org>, Greg KH <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Peter Chen <peter.chen@freescale.com>, Alan Stern <stern@rowland.harvard.edu>, r.baldyga@samsung.com, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Linux PM list <linux-pm@vger.kernel.org>, USB <linux-usb@vger.kernel.org>, device-mainlining@lists.linuxfoundation.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Pavel Machek <pavel@ucw.cz> writes:
>> >> > a) you are connected to a dedicated charger
>> >> >
>> >> >         In this case, you can get up to 2000mA depending on the cha=
rger.
>> >> >
>> >> >         If $this charger can give you or not 2000mA is not detectab=
le,
>> >> >         so what do charging ICs do ? They slowly increase the attac=
hed
>> >> >         load accross VBUS/GND and measure VBUS value. When IC notic=
es
>> >> >         VBUS dropping bit, step back to previous load.
>> >> >
>> >> >         This means you will always charger with maximum rating of D=
CP.
>> >> >
>> >> >         Why would user change this ? More is unsafe, less is just
>> >> >         stupid.
>> >
>> > Less is not neccessarily stupid. First, it is useful for debugging, se=
cond, you
>> > don't know how much this charger can give you. You measured you can ge=
t 1.8A,
>> > but the note on the charger says 1.5A. You may want to go with 1.5A.
>> >
>> > Also, there are several incompatible standards for detecting
>> > "dedicated charger". IIRC iPhone has different one from iPad. So it is
>> > quite important to be able to control this manually.
>>=20
>> manually ??? Hell no! Charger IC should be able to do this no
>> problem. I would be surprised if there's any charger IC out there which
>> blindly connects a 1.8A load from the start. What these ICs do is that
>> they slowly increment the load and check voltage level. They'll continue
>> to do that up to the maximum you listed (1.8A, let's say). As soon as
>> voltage drops a bit, charger IC knows that it use previous load.
>
> As I explained, if the note on the wall charger says 1.5A, you want to
> do 1.5A, not 1.8A. You can measure voltage on the charger, but you
> don't know its temperature.

phone can't read what it says in the wall charger, nor can it know that
it's connected charger ABC and not charger XYZ. Think of the user
experience. You can't expect users to tell you "okay phone, the charger
reads that maximum is 1.5A, so please don't go over that."

>> >> > d) you are connected to a standard port and get enumerated with your
>> >> > 100mA configuration.
>> >> >
>> >> >         you *know* 100mA is okay. So you connect a 100mA load and g=
et it
>> >> >         over with.
>> >> >
>> >> >         This means you will always charger with maximum rating for =
this
>> >> >         SDP.
>> >> >
>> >> >         Why would user change this ? More is unsafe, less is just
>> >> >         stupid.
>> >
>> > I've needed to override 100mA default many times. Maybe it is unsafe,
>> > but it is useful.
>>=20
>> still unsafe. If you really wanna do that, you're welcome to removing
>> safety margins from your own kernel, but we're definitely not going to
>> ship this to millions of users.
>
> Not more unsafe than loading wall chargers with "lets see how much we
> can get out of it" algorithm. Plus actually required to charge your

it actually _is_ more unsafe. You could burn mother boards with that. If
host tells you it only has 100mA power budget left, why are you trying
to get more ?

> machines in useful way. So it is important that common API
> exists. Whether it gets enalbed at production is different question.

as I said, if you wanna do some unsafe manual method, be my guest; but
I'm not convinced that every user of the linux kernel wants that in
their pockets.

> Unfortunately, there's more than one standard for detecting charger,
> so manual control will probably be required.

n900 never had manual control of anything. It was just using information
given by the battery IC, charger IC and twl4030 madc.

>> > (And with USB 5V connected directly to pretty beefy PC power supply...
>> > it is sometimes safer than it looks).
>>=20
>> you're not considering the thermal dissipation on the USB connector
>> itself. Many of them might not use good metals because they assume the
>> maximum power dissipated is 500mA * 5V =3D 2.5W. If you try to draw more,
>> you could, literally, melt the connector.
>
> If you are dissipating 2.5W at the connector, you are doing something
> very wrong. You should not be short-circuiting your USB... even when
> the ports are usually designed to survive that.

yes. You shouldn't. You also shouldn't go over that limit. If you have a
500mA total power budget, we should not let anybody try to draw more
because we have no control over what's on the side of the wire.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXFLq1AAoJEIaOsuA1yqREeAwP/3YStPZkQs1643jqc99ErsIF
reK73BN+ztUXe26bWSbW/XycB2G00zbKG8Hsd8KmXkdhBT24XyDNVZjyBlEioQCc
70npr1nykrvlGKWyfeWfafagvnHTrcVD/H9mHeYcBv4FRomTw+mvhbzf4Oq12PSj
FiK4ghiSZHcpSDa9Qwg9WTcgLPH4fx6Wpn39rHFApFt5mBI6mSE/rpv6FTQyhIle
wzl5UrVV2mcFEjW48eTRaDQdEI/HqJX/ZRsrMRslJDBg9LidnTxFqEHsQFpWaWSO
awAvb9ohvUKvfsr39kNUiEXUiVgU+BL6b7f1dn6ncqjV7mM13rzQ4B0dTilqKglE
/74uycpGwDbP4aepf39jP7O6d0pH7mfnIxFLI98YeM3fUin6lsoo7aDTfRQz5C0S
XWMw8Qg8KrnAs3o5S+QvIaQHHeg4Y2iBpqOMx8Xb9+DNm0ZXD4tzXNapnWEiIpk4
VrXBPfZcVkrL3MaUI897/S9/z8xO2Rf62AYrjs7tQjEdX9YTfZBT0wNhrFcR4YDs
QHu6iDpsDpuG2Nr0Hi2oWDnzsY2ituYyM/z9/lJHaHfETT31M86mxB9xG7IZI45S
otFur6+VSaA8nWfARANxXAhdCEeTAzSK2q7qvioqnd2k7YSQoOl4zXjeCrUsADlg
DXDnKYe62slNvuaunFSy
=tt5n
-----END PGP SIGNATURE-----
--=-=-=--
