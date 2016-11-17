From: NeilBrown <neilb@suse.com>
Subject: Re: [PATCH v18 0/4] Introduce usb charger framework to deal with the usb gadget power negotation
Date: Thu, 17 Nov 2016 17:46:13 +1100
Message-ID: <87fumqhadm.fsf@notabene.neil.brown.name>
References: <CAMz4kuJPenbqf935EGW67UeqOiP48_Ti1Jf5YfJ_K=DEcrz++Q@mail.gmail.com> <87a8dls7yn.fsf@notabene.neil.brown.name> <CAMz4kuJdp+ijur_mDjcG3aghn8Q1gnJsTfFWBEiKWcdVQPMj7g@mail.gmail.com> <871sytqrqh.fsf@notabene.neil.brown.name> <CAMz4kuJV5wiCpWJF=-YpTf1sjNrOqjc53iRYmGoEQepqtrfUdA@mail.gmail.com> <87a8dbni27.fsf@notabene.neil.brown.name> <CAMz4ku+qY4U7=v5nEBEdPTjwki8j10jYbQuokz785NEy5SzYmg@mail.gmail.com> <87eg2ek7ye.fsf@notabene.neil.brown.name> <20161114120430.hpnetdedyofhlkad@sirena.org.uk> <87mvh1iw32.fsf@notabene.neil.brown.name> <20161116161605.smif6kf3mdhdhyhd@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161116161605.smif6kf3mdhdhyhd@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Baolin Wang <baolin.wang@linaro.org>, Felipe Balbi <balbi@kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, robh@kernel.org, Jun Li <jun.li@nxp.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Ruslan Bilovol <ruslan.bilovol@gmail.com>, Peter Chen <peter.chen@freescale.com>, Alan Stern <stern@rowland.harvard.edu>, grygorii.strashko@ti.com, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Lee Jones <lee.jones@linaro.org>, John Stultz <john.stultz@linaro.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Linux PM list <linux-pm@vger.kernel.org>, USB <linux-usb@vger.kernel>
List-Id: linux-pm@vger.kernel.org

--=-=-=
Content-Type: text/plain

On Thu, Nov 17 2016, Mark Brown wrote:

> [ Unknown signature status ]
> On Tue, Nov 15, 2016 at 08:35:13AM +1100, NeilBrown wrote:
>> On Mon, Nov 14 2016, Mark Brown wrote:
>
>> > Conflating the two seems like the whole point here.  We're looking for
>> > something that sits between the power supply code and the USB code and
>> > tells the power supply code what it's allowed to do which is the result
>> > of a combination of physical cable detection and USB protocol.  It seems
>> > reasonable that extcon drivers ought to be part of this but it doesn't
>> > seem like they are the whole story.
>
>> I don't think "between the power supply code and the USB code" is where
>> this thing sits. I think it sits inside the power-supply driver.
>> We already have extcon which sits between the phy and the power_supply
>> code, and the usb_notifier which sits between the USB code and the
>> power supply code.  We don't need another go-between.
>
> ...
>
>> correct determinations and set the current limits itself.  All this
>> could be done entirely internally, without the help of any new
>> subsystem.
>> Do you agree?
>
>> Clearly doing it that way would result in lots of code duplication and
>> would mean that each driver probably gets its own private set of bugs,
>> but it would be possible.  Just undesirable.
>
> I think this is the key here - the fact that it's technically possible
> to implement doesn't really matter if it's sufficiently fiddly and non
> obvious that nobody is actually joining everything up (bits are done
> intermittently but not as a whole as far as I can see).
>
>> So yes, it makes perfect to provide common code which handles the
>> registrations, and captures the events, and translates the different
>> events into current levels and feeds those back to the driver.  This
>> isn't some new subsystem, this is just a resource, provided by a
>> library, that power drivers can allocate and initialize if the want to.
>
> To me that's pretty much what's being done here, the code just happens
> to sit in USB instead but fundamentally it's just a blob of helper code,
> you could replace the notifier with a callback if that's the big concern
> here.

It is a lot more than "just a blob of helper code".  It duplicates
existing infrastructure instead of fixing and using the
infrastructure.... but I've said all this before.  Repeatedly.

NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYLVI1AAoJEDnsnt1WYoG5SzkP/22Eren5Q5/LrXnq7SQSNzlR
xls1UJ4v1EIuKARj47ut6sXpAxqh83IlbIolbs6xLKYGERGQCXU/PjxPquFkykXs
gedZ0nF807z8MdnZfxyl1X6kUmEMpCRD6zSKqW/iUMupU/u/obuHv75VORSm2dhV
dQV94cTigGOaJVuzV+2GAQtZypMr44poPFhTDAPC4AX55RUej/eFbxdIbhIqvYib
g9rxrQ+LjFPI+MHTFbr8KRaN26AuqSbyIrPEncejVAQGuPzGljq8H3VebqwdGUxS
gDIfA2GkIcqymgRh/wx1flIKKPMKu86bR4WsZiDZn0+v5t7OyYQwaBwPdOFx2vjw
2ejvUFJGB9x112oliuXP1w9AuU/0n7dy5XtBE8KGLRRg4mR5M+HQEX4kl77lYX4/
xgFDSS3+b9dGu540geN+dOzkl3RhJfoSuPFWa8vvUkJR8sRHps2legA4hb5Xv+8O
n42mgnLM9GVHu1eDPs4Uj/btfzEcztrfMKMeD4oBD6SUwUWoHAPqnmULTa63hW3p
n4XAqrXAKPEPVx96fLBL+TzwXZ+AUgKQdF5lWlLU++W2CIbnT5OqbM4ev/Swl2M/
q8VyGTHqztc7RXVTwqsT+A7O7c3uRCSC9WdP32FV3sU7uPCzxzn3lKmqyxW4GnOs
+Jg5VEIY6Ws3npnE+Eyy
=cTCu
-----END PGP SIGNATURE-----
--=-=-=--
