From: NeilBrown <neilb@suse.com>
Subject: Re: [PATCH v16 0/4] Introduce usb charger framework to deal with the usb gadget power negotation
Date: Sat, 10 Sep 2016 07:19:32 +1000
Message-ID: <87twdo7ouz.fsf@notabene.neil.brown.name>
References: <cover.1470034830.git.baolin.wang@linaro.org> <CAMz4kuLotLs1ASuZaMRXf29khmQUfEQc+jFV8Fxp+fHFn90Z9g@mail.gmail.com> <CAMz4ku+pkRT70NcZEDepfshH7z7+Fm3yo-C2+ccWgJwDJE4C-Q@mail.gmail.com> <8760q9a8m6.fsf@notabene.neil.brown.name> <CAMz4kuJJwKFqU=6JnpUQNPeQ-uy-PyZ5VBaBKofn=8Jv5y0nXA@mail.gmail.com> <878tv297a0.fsf@notabene.neil.brown.name> <CAMz4kuLXyVSXjh1Sn06+wcUr+bVritCW3sN=XyEdap7h=MN7xw@mail.gmail.com> <87y4326l44.fsf@notabene.neil.brown.name> <CAMz4ku+wWcSPCA1_UYKNqJv4rRDEm5WYUc8AVT6xPJ651-rzmg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMz4ku+wWcSPCA1_UYKNqJv4rRDEm5WYUc8AVT6xPJ651-rzmg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Baolin Wang <baolin.wang@linaro.org>
Cc: NeilBrown <nfbrown@novell.com>, Felipe Balbi <balbi@kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, robh@kernel.org, Jun Li <jun.li@nxp.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Ruslan Bilovol <ruslan.bilovol@gmail.com>, Peter Chen <peter.chen@freescale.com>, Alan Stern <stern@rowland.harvard.edu>, r.baldyga@samsung.com, grygorii.strashko@ti.com, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Linux PM list <linux-pm@vger.kernel.org>, USB <linux-usb@vger.ke>
List-Id: linux-pm@vger.kernel.org

--=-=-=
Content-Type: text/plain

On Fri, Sep 09 2016, Baolin Wang wrote:

>>
>> In practice, the USB PHY and the Power manager will often be in the same
>> IC (the PMIC) so the driver for one could look at the registers for the
>> other.
>> But there is no guarantee that the hardware works like that.  It is
>> best to create a generally design.
>
> Yes, we hope to create one generally design, so we need to consider
> this situation: the power supply getting the charger type by accessing
> PMIC registers. The registers which save the charger type are not
> always belong to the USB PHY, may be just some registers on PMIC.

If the power_supply can directly detect the type of charger, then it
doesn't need any usb-charger-infrastructure to tell it.  It can handle
current selection entirely internally.
Surely the only interesting case for a framework to address is the one
where the power_supply cannot directly detect the charger type.

>
> Now in mainline kernel, there are 3 methods can get the charger type
> which need to integrate with USB charger framework:
> 1. power supply
> 2. extcon (need to add as you suggested)
> 3. others (by 'get_charger_type' callback of USB charger)

There is no "get_charger_type" now in the mainline kernel.

>>>
>>> Suppose the USB configuration requests 100mA, then we should set the
>>> USB charger current is 100mA by __usb_charger_set_cur_limit_by_type()
>>> funtion, then notify this to power driver.
>>
>> ahh.... I had missed something there.  It's a while since I looked
>> closely at these patches.
>>
>> Only.... this usage of usb_charger_set_cur_limit_by_type() is really
>> nonsensical.
>>
>> If the cable is detected as being DCP or CDP or ACA (or ACA/DOCK) then
>> the number negotiated with the USB configuration is not relevant and
>> should be ignored.  There is a guaranteed minimum which is at least the
>> maximum that *can* be negotiated.
>
> Yes. If it is not relevant, we will no't set the current from USB
> configuration. Just when your charger type is SDP and the USB
> enumeration is done, we can get the USB configuration from host to set
> current.

But you do!
The mA number from the USB configuration is passed to usb_gadget_vbus_draw.
Your patch passes that to usb_charger_set_cur_limit_by_type()
which calls __usb_charger_set_cur_limit_by_type() which will set the
cur_limit for whichever type uchger->type currently is.

So when it is not relevant, your code *does* set some current limit.

NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJX0ydkAAoJEDnsnt1WYoG5fJoP/1Ggy273jgWCzFBh0t+U94z0
9CE/vTsLu01vD7VIIZUkf/37dMmUjMfyxjTLSFFZKoqtx5KtkOVxmlQOrzdu8iP6
QxdUac47Lcz1B4rTmtNyqoarXBiJvTjgbKxRX/n4y3FQpdrlkYKDi0fnwTv80SaM
Hx2MrHrCtHeamhH2pPY1R4cgN66OlQMVTk7gPzPTx3jX2lJ3UxcnJ0WX8Ov/sQCT
G/CPZtFF8b87ZhpV3qfUke36U9UrjA38U0TJnIbQnWDlUqzIx+UXdk4aIQLCAx5A
kyFCiWp4lf9EoAPd7WJMnuNit/gpUTghholf+LaiW0RsQnXHBc2uVdyw2iJP7c5T
50MC6ciK9bYCkwks6xy3qMXX+FywJeOE1g4pCK81CbRkyLx8UA3xHnyNKpkd5jmI
LVCLuL6wbURh8KubsFtATUivd4S8Tz3/fJhk+5IDjYU4CPlBioaWrm8JkUfdOYMb
JMgTTU/xUfNT7dV751UAmqqOY++3aYkJ84t1yY181FlMH9gj0d9abNO328yEGyn0
/8ENtaly6i48sBydnvbyGPDDqAhc18IHVVCimhTkKn1VrP2bXKKeX62VXtYNW8yn
yO67aKftpRqsYECe/1Nivq5pYeInLWbeM56XQdCWZKEnkk43woHxdOrWgzLww69N
epd+AscieuFt1J2Iptkh
=mWMJ
-----END PGP SIGNATURE-----
--=-=-=--
