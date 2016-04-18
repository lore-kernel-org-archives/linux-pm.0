From: Felipe Balbi <balbi@kernel.org>
Subject: Re: [PATCH v7 1/4] gadget: Introduce the usb charger framework
Date: Mon, 18 Apr 2016 13:49:45 +0300
Message-ID: <87y48bfaye.fsf@intel.com>
References: <cover.1458128215.git.baolin.wang@linaro.org> <11ce6df3eb8a95cfed26f3321f15c98a934db642.1458128215.git.baolin.wang@linaro.org> <87h9foqnur.fsf@intel.com> <CAMz4kuJ=StEMsdHgX6n6wi13bs3CZ+9GYXBvdZ5mu+giSmnWdg@mail.gmail.com> <87poubgnbh.fsf@intel.com> <20160322113012.GC26924@xo-6d-61-c0.localdomain> <87fuujgwsm.fsf@intel.com> <20160418102316.GA27936@amd> <877ffvgqe9.fsf@intel.com> <20160418103945.GA29123@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160418103945.GA29123@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Baolin Wang <baolin.wang@linaro.org>, Greg KH <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Peter Chen <peter.chen@freescale.com>, Alan Stern <stern@rowland.harvard.edu>, r.baldyga@samsung.com, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Linux PM list <linux-pm@vger.kernel.org>, USB <linux-usb@vger.kernel.org>, device-mainlining@lists.linuxfoundation.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Pavel Machek <pavel@ucw.cz> writes:
> On Mon 2016-04-18 13:30:54, Felipe Balbi wrote:
>>=20
>> Hi,
>>=20
>> Pavel Machek <pavel@ucw.cz> writes:
>> >> > Very often, you want to charge using 1.8A from an old desktop PC.
>> >>=20
>> >> if that old desktop's port is not a charging port, you shouldn't be
>> >> allowed to do that. Not ever.
>> >
>> > Yes, Felipe just decided that I should not be able to charge my N900
>> > in useful way.
>>=20
>> you can do whatever you want with *your* kernel binary, but we're not
>> gonna ship something potentially dangerous. If that PC port is telling
>> you it can only allow 100mA, you should *not* be allowed to overcome
>> that limitation from the device side, sorry.
>
> Yes, and if your cpu tells you it can only run on 2GHz, you should not
> be able to run it on 2.1GHz. And you should not be able to use
> non-VESA VGA modes, because you could overheat coils in the monitor.

heh, yada-yada-yada.

> You are shipping something potentially dangerous already, because you
> know, USB-A-to-micro-B cables with D+/D- connected to simulate charger
> are actually very common. The world did not end, yet, so it is clearly
> not as bad as you make it be.

That's not even a supported cable assembly. If you break your HW, that's
your own fault for not using proper cables. There's nothing the kernel
can do about that anyway.

If you're willing to by a "special" cable just to overcome safety limits
set by the various USB specifications, go head. But don't ask me to
support you when things go wrong.

>> >> >> a) you are connected to a dedicated charger
>> >> >>=20
>> >> >> 	In this case, you can get up to 2000mA depending on the charger.
>> >> >>=20
>> >> >> 	If $this charger can give you or not 2000mA is not detectable,
>> >> >> 	so what do charging ICs do ? They slowly increase the attached
>> >> >> 	load accross VBUS/GND and measure VBUS value. When IC notices
>> >> >> 	VBUS dropping bit, step back to previous load.
>> >> >>=20
>> >> >> 	This means you will always charger with maximum rating of DCP.
>> >> >>=20
>> >> >> 	Why would user change this ? More is unsafe, less is just
>> >> >> 	stupid.
>> >> >
>> >> > Actually, less is not stupid. Charging li-ion battery from li-ion b=
attery might
>> >> > be stupid. Imagine I'm on train, with device like N900 (50% battery=
) and power bank
>> >> > (3Ah). I'm actively using the device. If I let it charge at full cu=
rrent, I'll waste
>> >> > energy. If I limit current to approximately the power consumption, =
it will run the
>> >> > powerbank empty, first, then empty the internal battery, maximizing=
 total time I
>> >> > can use the device.
>> >>=20
>> >> why would you waste energy ? What the charger chip would do is charge
>> >> battery to maximum then just to maintenance charge from that point
>> >> on. Where is energy being wasted other than normal heat dissipation ?
>> >
>> > Physics 101, of course wasted energy goes to heat. Lets not waste
>> > energy by charging li-ion from li-ion when it is not required.
>>=20
>> your cellphone has no means to know that it's connected to a Li-Ion
>> battery. We don't have visibility on what we're connected to, just how
>> much it can source.
>
> But cellphone user knows what he connected his charger to, and that's
> why it is useful to be able to lower the current. Even when you said
> "less is just stupid" I demonstrated it is not, at least in case when
> your power source is a battery.

okay, so let's do this. How much more "time" do you get by doing this ?
Without numbers showing that it's considerably better, we can't do
anything.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXFLvKAAoJEIaOsuA1yqREz0QP/18tGlRJ8RJ/XIHMMi/paGWr
NJhpaTgCz/rXQmu0eNYR4eAP1f/OEYZyWVz5m6okx1LfDJOEsfkC4qi850Q1KW6q
e+SS3V6VRT64kdyG6A9/4+aT4j0MDqD+j55wRtmBRdcKBFAyKv8rUSv5idMLQBwK
++322k+fJ+DyaqKSNS0L46Dt5PbhNgZmbiloO1RRca9ZziCssG/T7RWDUrpK09N/
4ZTJGIDV8agWzpiYFr9e6GySuXkCXevNXTUvcRSrV2GTKtLSAbt7+sqf/knT+elo
mldGIcZv/v7KncKMpItdrPFgpKo+EjeWpn9WkXWyRjYhgSXGTU1raxDzRN9OYMW4
0AmkEOerXI6/fOiDPgGYHXJqYeesqRo/CBhXgVS+TQCxkw5hRcy1hn/fyTuotWVC
+OzG4EcJs6oGzxKLEX4NOLbWfH1VaTXzQnqV3n/l+DQjbl/G4iFHf/4H3YUB1hUa
CWcU3GoH77mjLMLQYjVp1zUqrl2RwWo/Qxe2Sl16PQhOxEVUl81haPAr/MNnkRuh
kv9bg4jvNmlrH6ZzZzgUzqyH2w+Sgk1g+kgutpa5qACeAe9LniV/kal5xjtBE0Tc
QXWR7ZzBSIZsoCqm1CKf2diODWU/aQY0aeU3nSZDXbUo1JYXNYpXTaK6hYYPSTAS
8Pb88sV1KYy0KDaJjSNI
=oSvl
-----END PGP SIGNATURE-----
--=-=-=--
