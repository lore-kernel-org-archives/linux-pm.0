From: NeilBrown <neilb@suse.com>
Subject: Re: [PATCH v18 0/4] Introduce usb charger framework to deal with the usb gadget power negotation
Date: Mon, 14 Nov 2016 15:21:13 +1100
Message-ID: <87eg2ek7ye.fsf@notabene.neil.brown.name>
References: <cover.1476780088.git.baolin.wang@linaro.org> <CAMz4ku+5=LebdDB9waDD8GYQmYM=uxuOqN6hYZ+E1HSALa1GMQ@mail.gmail.com> <87k2cttptn.fsf@notabene.neil.brown.name> <CAMz4kuJPenbqf935EGW67UeqOiP48_Ti1Jf5YfJ_K=DEcrz++Q@mail.gmail.com> <87a8dls7yn.fsf@notabene.neil.brown.name> <CAMz4kuJdp+ijur_mDjcG3aghn8Q1gnJsTfFWBEiKWcdVQPMj7g@mail.gmail.com> <871sytqrqh.fsf@notabene.neil.brown.name> <CAMz4kuJV5wiCpWJF=-YpTf1sjNrOqjc53iRYmGoEQepqtrfUdA@mail.gmail.com> <87a8dbni27.fsf@notabene.neil.brown.name> <CAMz4ku+qY4U7=v5nEBEdPTjwki8j10jYbQuokz785NEy5SzYmg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMz4ku+qY4U7=v5nEBEdPTjwki8j10jYbQuokz785NEy5SzYmg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Baolin Wang <baolin.wang@linaro.org>
Cc: Felipe Balbi <balbi@kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, robh@kernel.org, Jun Li <jun.li@nxp.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Ruslan Bilovol <ruslan.bilovol@gmail.com>, Peter Chen <peter.chen@freescale.com>, Alan Stern <stern@rowland.harvard.edu>, grygorii.strashko@ti.com, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, John Stultz <john.stultz@linaro.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Linux PM list <linux-pm@vger.kernel.org>, USB <linux-usb@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

--=-=-=
Content-Type: text/plain

On Thu, Nov 10 2016, Baolin Wang wrote:

> Hi
>
> On 8 November 2016 at 04:36, NeilBrown <neilb@suse.com> wrote:
>> On Mon, Nov 07 2016, Baolin Wang wrote:
>>
>>> On 3 November 2016 at 09:25, NeilBrown <neilb@suse.com> wrote:
>>>> On Tue, Nov 01 2016, Baolin Wang wrote:
>>>
>>> I agree with your most opinions, but these are optimization.
>>
>> I see them as bug fixes, not optimizations.
>>
>>>                                                              Firstly I
>>> think we should upstream the USB charger driver.
>>
>> I think you missed the point.  The point is that we don't *need* your
>> "USB charger driver" because all the infrastructure we need is *already*
>> present in the kernel.  It is buggy and not used uniformly, and could
>> usefully be polished and improved.  But the structure is already
>> present.
>>
>> If everyone just added new infrastructure when they didn't like, or
>> didn't understand, what was already present, the kernel would become
>> like the Mad Hatter's tea party, full of dirty dishes.
>>
>>>                                                  What I want to ask is
>>> how can we notify power driver if we don't set the
>>> usb_register_notifier(), then I think you give the answer is: power
>>> driver can register by 'struct usb_phy->notifier'. But why usb phy
>>> should notify the power driver how much current should be drawn, and I
>>> still think we should notify the current in usb charger driver which
>>> is better, and do not need to notify current for power driver in usb
>>> phy driver.
>>
>> I accept that it isn't clear that the phy *should* be involved in
>> communicating the negotiated power availability, but nor is it clear
>> that it shouldn't.  The power does travel through the physical
>> interface, so physically it plays a role.
>>
>> But more importantly, it already *does* get told (in some cases).
>> There is an interface "usb_phy_set_power()" which exists explicitly to
>> tell the phy what power has been negotiated.  Given that infrastructure
>> exists and works, it make sense to use it.
>>
>> If you think it is a broken design and should be removed, then fine:
>> make a case for that.  Examine the history.  Make sure you know why it
>> is there (or make sure that information cannot be found), and then
>> present a case as to why it should be removed and replaced with
>> something else.  But don't just leave it there and pretend it doesn't
>> exist and create something similar-but-different and hope people will
>> know why yours is better.  That way lies madness.
>
> Like Peter said, it is not only PHY can detect the USB charger type,
> which means there are other places can detect the charger type.

If I understand Peter's example correctly, it shows a configuration
where the USB PHysical interface is partly implemented in the SOC and
partly in the PMIC.  I appreciate that would make it more challenging to
implement a PHY driver, but there is no reason it should impact anything
outside of the PHY.


> Second, some controller need to detect the charger type manually which
> USB phy did not support.

"manually" is an odd term to use in this context.
I think you mean that to detect the charger type you need to issue some
command to the hardware and wait for it to respond, then assess the
response.
That isn't at all surprising.  The charger type is detected by measuring
resistance between ID and GND, which may require setting up a potential
and activating ADCs to measure the voltage.  This can all be done
internally to the phy driver.
Sometimes it is easy (I did https://lkml.org/lkml/2015/2/23/746 for
twl4030, though it never got upstream).
The code for the imx7d does look more complex, but not intrinsically
different.

> Third, it did not handle what current should
> be drawn in USB phy.

The standards define that.  The extcon just reports the cable type.
Certainly it would be sensible to provide a library function to
translate from cable type to current range.  You don't need a new
subsystem to do that, just a library function.

> Fourth, we need integrate all charger plugin/out
> event in one framework, not from extcon, maybe type-c in future.

Why not extcon?  Given that a charger is connected by an external
connector, extcon seems like exactly the right thing to use.

Obviously extcon doesn't report the current that was negotiated, but
that is best kept separate.  The battery charger can be advised of the
available current either via extcon or separately via the usb
subsystem.  Don't conflate the two.


>  In a
> word, we need one standard integration of this feature we need, though
> like you said we should do some clean up or fix to make it better.

But really, I'm not the person you need to convince.  I'm just a vaguely
interested bystander who is rapidly losing interest.  You need to
convince a maintainer, but they have so far shown remarkably little
interest.  I don't know why, but I'd guess that reviewing a complex new
subsystem isn't much fun.  Reviewing and applying clear bugfixes and
incremental improvements is much easier and more enjoyable.  But that is
just a guess.

NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYKTu5AAoJEDnsnt1WYoG5k64P/2Ih26nlGR54BqOK5rgEnOB0
/1OKf7kMSctD95W5DL2AkX1Mgdahl8lR++cAlVbAT/rsTYzf6lWIhX0n7x7l6bNr
9jg03rpvyKKupMKaBk+YP9EwsZr38GjVcCihcGesAKbtHL459VC5DRuj0nDJjb85
lpI0lBfmNVBy+h8GcUS9KBY+ACiMaaHsN6HXxEOA2xIEsqJXge4U0FDk29HrS0Cp
qpKse0CmA7Z7vn29zvs9ahmEjDxW3JJClHoUO9QVV7e9XvPpOCiRT43Nvy+Z0MP2
BA/t9T+zh45xcfkvG8bmqdmZ5QfoAY55I6AcFU1lUIbn9t6Wq9s0/9IJdOr0XVjd
0tEGlqQBlpmKGy59xTXmwslyxvZykhCf40O0BfIZzS10dTQGDayNdGyFLNkhV1Uf
11/CC7kgGqW62UAPu2n3A5IKollxRKpnnYipgNRRGhptFiPOpDPGiqJuefXXq5AJ
AtYvPDAbt3RQI22t5rfR4xeT+xgYyJrKe2uX1+J2Mn0daXY+lOaD7RC3XlGwDgDy
RT7LW5eEKKiiJo9mudRCK33eG+9g+wN5ORv4HQb3usrSJX0HlL3MnGxikG84RL/M
TeeCNrxaCoCcbjdUfJeIap3AH2It+blVLOoOV1rGWyW6b723uG5yjRYmTORvqXxN
RhPFcksIQVuuNbJjTOs3
=b1fU
-----END PGP SIGNATURE-----
--=-=-=--
