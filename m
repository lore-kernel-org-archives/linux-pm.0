From: NeilBrown <neilb@suse.com>
Subject: Re: [PATCH v18 0/4] Introduce usb charger framework to deal with the usb gadget power negotation
Date: Tue, 15 Nov 2016 08:35:13 +1100
Message-ID: <87mvh1iw32.fsf@notabene.neil.brown.name>
References: <CAMz4ku+5=LebdDB9waDD8GYQmYM=uxuOqN6hYZ+E1HSALa1GMQ@mail.gmail.com> <87k2cttptn.fsf@notabene.neil.brown.name> <CAMz4kuJPenbqf935EGW67UeqOiP48_Ti1Jf5YfJ_K=DEcrz++Q@mail.gmail.com> <87a8dls7yn.fsf@notabene.neil.brown.name> <CAMz4kuJdp+ijur_mDjcG3aghn8Q1gnJsTfFWBEiKWcdVQPMj7g@mail.gmail.com> <871sytqrqh.fsf@notabene.neil.brown.name> <CAMz4kuJV5wiCpWJF=-YpTf1sjNrOqjc53iRYmGoEQepqtrfUdA@mail.gmail.com> <87a8dbni27.fsf@notabene.neil.brown.name> <CAMz4ku+qY4U7=v5nEBEdPTjwki8j10jYbQuokz785NEy5SzYmg@mail.gmail.com> <87eg2ek7ye.fsf@notabene.neil.brown.name> <20161114120430.hpnetdedyofhlkad@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161114120430.hpnetdedyofhlkad@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Baolin Wang <baolin.wang@linaro.org>, Felipe Balbi <balbi@kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, robh@kernel.org, Jun Li <jun.li@nxp.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Ruslan Bilovol <ruslan.bilovol@gmail.com>, Peter Chen <peter.chen@freescale.com>, Alan Stern <stern@rowland.harvard.edu>, grygorii.strashko@ti.com, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Lee Jones <lee.jones@linaro.org>, John Stultz <john.stultz@linaro.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Linux PM list <linux-pm@vger.kernel.org>, USB <linux-usb@vger.kernel>
List-Id: linux-pm@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 14 2016, Mark Brown wrote:

> On Mon, Nov 14, 2016 at 03:21:13PM +1100, NeilBrown wrote:
>> On Thu, Nov 10 2016, Baolin Wang wrote:
>
>> > Fourth, we need integrate all charger plugin/out
>> > event in one framework, not from extcon, maybe type-c in future.
>
>> Why not extcon?  Given that a charger is connected by an external
>> connector, extcon seems like exactly the right thing to use.
>
>> Obviously extcon doesn't report the current that was negotiated, but
>> that is best kept separate.  The battery charger can be advised of the
>> available current either via extcon or separately via the usb
>> subsystem.  Don't conflate the two.
>
> Conflating the two seems like the whole point here.  We're looking for
> something that sits between the power supply code and the USB code and
> tells the power supply code what it's allowed to do which is the result
> of a combination of physical cable detection and USB protocol.  It seems
> reasonable that extcon drivers ought to be part of this but it doesn't
> seem like they are the whole story.

I don't think "between the power supply code and the USB code" is where
this thing sits. I think it sits inside the power-supply driver.
We already have extcon which sits between the phy and the power_supply
code, and the usb_notifier which sits between the USB code and the
power supply code.  We don't need another go-between.

If we have extcon able to deliver reliable information about cable type,
and if with have the usb notifier able to deliver reliable information
about negotiated current, and if the power supply manager is able to
register with the correct extcon and the correct usb notifier, then the
power supply manager *could* handle all the notifications and make the
correct determinations and set the current limits itself.  All this
could be done entirely internally, without the help of any new
subsystem.
Do you agree?

Clearly doing it that way would result in lots of code duplication and
would mean that each driver probably gets its own private set of bugs,
but it would be possible.  Just undesirable.

So yes, it makes perfect to provide common code which handles the
registrations, and captures the events, and translates the different
events into current levels and feeds those back to the driver.  This
isn't some new subsystem, this is just a resource, provided by a
library, that power drivers can allocate and initialize if the want to.

To quote myself:

> 5/ Now that all cable connection notifications are sent over extcon and
>    all vbus_draw notifications are sent over the usb_phy notifier, write
>    some support code that a power supply client can use to be told what
>    power is available.
>    e.g. a battery charger driver would call:
>        register_power_client(.....)
>    or similar, providing a phandle (or similar) for the usb phy and a
>    function to call back when the available current changes (or maybe a
>    work_struct containing the function pointer)
>=20
>    register_power_client() would then register with extcon and separately
>    with the usb_phy notifier.  When the different events arrive it
>    calculates what ranges of currents are expected and calls the
>    call-back function with those details.

NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYKi4SAAoJEDnsnt1WYoG5I1kQALCgBgTSJEYu7Y2mU2wku7c/
0Zj7Xd/dv1bG2ySUEEbFFGgr43NpMNpioo+Z68qDWyyidmqTORCvDnxIM91pFvLX
BXxVWiFHvtG1qDA2M6YvzEL+V+3zUBo/3eCA9Gx6/Zx7l1YTY1qDkWE5Lz+sr4a7
pfSLdQpqxllafEFXMkE1WPTShSgiS0uLQvE+nHDYf/tV4wvatsxi6mAG+1RlZGBc
lTjI0C7R1GRvtlcMw2LmFjdJ0RHnFByS91FI88z/Umrmd6BnJhn7kB+AUh/LjmpO
UtmBUUf0BHF0T9sS7GALZuz9A4jPDaL6IS0ZLqE17T+01j9vGpgue4PWBqT6fZf9
cxfMjIRs8oiosLG6nkiaJQE1hFZNWwbqbNPS+fevj1TZtalBRf1+JFbm8nc3ndly
3pH1oUWNHtYXaEPgYnV/D12SegK/rmqrjqfVg1kWz0TVFCe1SvmNKeW5yOLBWh6U
1ILVKQAGChiaXf2Hde2aQsrqMcD4YCM9IUFj8ttYVwJTpnvJn+5xecwrU36IOurD
2fhuK13+oDPE55wBAiARXgPhRGYN0nE2Nhxx4niQ1zD7tSIbWjXn/CQELEPNp9Ax
SR7oV5RZMRwmR/ACillw91npRFmdhtgpZsweCsuVbLgGwfZYWHVQO5Y5oK7ZQ0cx
73bJJulre2Eojs458tzb
=orqQ
-----END PGP SIGNATURE-----
--=-=-=--
