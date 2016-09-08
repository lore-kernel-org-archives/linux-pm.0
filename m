From: NeilBrown <neilb@suse.com>
Subject: Re: [PATCH v16 0/4] Introduce usb charger framework to deal with the usb gadget power negotation
Date: Fri, 09 Sep 2016 09:13:31 +1000
Message-ID: <87y4326l44.fsf@notabene.neil.brown.name>
References: <cover.1470034830.git.baolin.wang@linaro.org> <CAMz4kuLotLs1ASuZaMRXf29khmQUfEQc+jFV8Fxp+fHFn90Z9g@mail.gmail.com> <CAMz4ku+pkRT70NcZEDepfshH7z7+Fm3yo-C2+ccWgJwDJE4C-Q@mail.gmail.com> <8760q9a8m6.fsf@notabene.neil.brown.name> <CAMz4kuJJwKFqU=6JnpUQNPeQ-uy-PyZ5VBaBKofn=8Jv5y0nXA@mail.gmail.com> <878tv297a0.fsf@notabene.neil.brown.name> <CAMz4kuLXyVSXjh1Sn06+wcUr+bVritCW3sN=XyEdap7h=MN7xw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMz4kuLXyVSXjh1Sn06+wcUr+bVritCW3sN=XyEdap7h=MN7xw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Baolin Wang <baolin.wang@linaro.org>
Cc: NeilBrown <nfbrown@novell.com>, Felipe Balbi <balbi@kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, robh@kernel.org, Jun Li <jun.li@nxp.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Ruslan Bilovol <ruslan.bilovol@gmail.com>, Peter Chen <peter.chen@freescale.com>, Alan Stern <stern@rowland.harvard.edu>, r.baldyga@samsung.com, grygorii.strashko@ti.com, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Linux PM list <linux-pm@vger.kernel.org>, USB <linux-usb@vger.ke>
List-Id: linux-pm@vger.kernel.org

--=-=-=
Content-Type: text/plain

On Thu, Sep 08 2016, Baolin Wang wrote:

> On 8 September 2016 at 15:31, NeilBrown <neilb@suse.com> wrote:
>> On Thu, Sep 08 2016, Baolin Wang wrote:
>>>
>>> Now the usb charger will not get charger type from 'extcon' subsystem,
>>> we get the charger type from 'power_supply' and calllback
>>> 'get_charger_type' for users.
>>
>> I understand this.  I think it is wrong because, in general, the
>> power_supply doesn't know what the charger_type is (it might know it is
>> USB, but most don't know which sort of USB).  The PHY knows that, not
>> the power_supply.
>
> I don't think so. Now many platforms will detect the charger type by
> PMIC hardware, and we can get the charger type by PMIC hardware
> register. Then power supply driver can access the PMIC register to get
> the charger type. Here USB charger just considers if the accessing the
> PMIC register to get charger type is implemented in power supply, it
> is optional depending on what your platform designed.
>

In practice, the USB PHY and the Power manager will often be in the same
IC (the PMIC) so the driver for one could look at the registers for the
other.
But there is no guarantee that the hardware works like that.  It is
best to create a generally design.
Conceptually, the PHY is separate from the power manager and a solution
which recognises that will be more universal.

If the power manager can always just look at that phy registers to know
what sort of charger is connected, why does you framework need to work
with charger types at all?

>>>
>>> Yes, but you must think about some special cases on some platforms.
>>> Users may need to change the current in some situations, thus we
>>> should export one API for users to change the current. (I think you
>>> misunderstand the current limit here, that is the current for power
>>> driver  to draw).
>>
>> Can you be specific about these "special cases" please?
>> I cannot think of any.
>
> Suppose the USB configuration requests 100mA, then we should set the
> USB charger current is 100mA by __usb_charger_set_cur_limit_by_type()
> funtion, then notify this to power driver.

ahh.... I had missed something there.  It's a while since I looked
closely at these patches.

Only.... this usage of usb_charger_set_cur_limit_by_type() is really
nonsensical.

If the cable is detected as being DCP or CDP or ACA (or ACA/DOCK) then
the number negotiated with the USB configuration is not relevant and
should be ignored.  There is a guaranteed minimum which is at least the
maximum that *can* be negotiated.

It is only when the cable appears to be a SDP (standard downstream
port) that the usb-config negotiation is relevant.  That is because the
minimum guaranteed for SDP is only 100mA.

NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJX0fCbAAoJEDnsnt1WYoG5xMEQALcndTOmaDeIO4hLO1SpZUAV
0mqTvAHjjuGpGsCcQomCujQuoByQrDm2xgGS4wfheDKYrPodyX4KlPA5d07I4hPJ
SJOCCPEuH66qREgiRIHY/S1JqpLri3FaxMNMOpclrXiGAaQ2Nwz9EUcdpj9gWjm0
Hy+q1I3AmKMXwKFM8bshkRIfygMcxUCZ9Yudda2aXKCdkZhmVew3rNEp36nAGag5
Y4SSutQC5/KSn3JKziiotqlsP6y4CkORMVjtenEr5tTvG+lzpTJfsEC0V4eqvyky
ULWd/IHmeSiATN4QW5AG1cIcGV53EVDa5arc27Hk8k2z7mcQ7ACU9mJmJYd39PYy
37v45LhgDkDnnP88qIVC0doWg+ff/nr72D40iQ/FiZy9knughuSZegkQhE4Z1HhN
cG7UZicjBQZ5bMSpv5VTXHP+yumOKbxd9m51s5PRy1FWcf4oEMxugwNnNac+eZqC
mrCSo2ywRP3qr+8otU8j6ywuzlWp5MXq+Vwl6yszGJRu6H8iSl4ft+jV1MRfdbTi
u9pBfWOgEdsxD2xCD/i/l6tk2X1+wxIwRZiblleujMRlTLdhixK4dgp6KGYL0Uvi
8TfR1709G9ukiw7orxA9xFBN0DXhdPywXXpovDcu7sRk/HAUUQz+6YEpCiyc4Vcd
39eddCJw8XKp4SyXXbBG
=JDwk
-----END PGP SIGNATURE-----
--=-=-=--
