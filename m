From: NeilBrown <neilb@suse.com>
Subject: Re: [PATCH v16 0/4] Introduce usb charger framework to deal with the usb gadget power negotation
Date: Thu, 08 Sep 2016 17:31:51 +1000
Message-ID: <878tv297a0.fsf@notabene.neil.brown.name>
References: <cover.1470034830.git.baolin.wang@linaro.org> <CAMz4kuLotLs1ASuZaMRXf29khmQUfEQc+jFV8Fxp+fHFn90Z9g@mail.gmail.com> <CAMz4ku+pkRT70NcZEDepfshH7z7+Fm3yo-C2+ccWgJwDJE4C-Q@mail.gmail.com> <8760q9a8m6.fsf@notabene.neil.brown.name> <CAMz4kuJJwKFqU=6JnpUQNPeQ-uy-PyZ5VBaBKofn=8Jv5y0nXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMz4kuJJwKFqU=6JnpUQNPeQ-uy-PyZ5VBaBKofn=8Jv5y0nXA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Baolin Wang <baolin.wang@linaro.org>, NeilBrown <nfbrown@novell.com>
Cc: Felipe Balbi <balbi@kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, robh@kernel.org, Jun Li <jun.li@nxp.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Ruslan Bilovol <ruslan.bilovol@gmail.com>, Peter Chen <peter.chen@freescale.com>, Alan Stern <stern@rowland.harvard.edu>, r.baldyga@samsung.com, grygorii.strashko@ti.com, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Linux PM list <linux-pm@vger.kernel.org>, USB <linux-usb@vger.kernel.org>, device-mainli
List-Id: linux-pm@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 08 2016, Baolin Wang wrote:

> Hi Neil,
>
> On 6 September 2016 at 13:40, NeilBrown <nfbrown@novell.com> wrote:
>> On Mon, Aug 29 2016, Baolin Wang wrote:
>>
>>> Hi Felipe,
>>>
>>> On 11 August 2016 at 11:14, Baolin Wang <baolin.wang@linaro.org> wrote:
>>>> Hi Felipe,
>>>>
>>>> On 1 August 2016 at 15:09, Baolin Wang <baolin.wang@linaro.org> wrote:
>>>>> Currently the Linux kernel does not provide any standard integration =
of this
>>>>> feature that integrates the USB subsystem with the system power regul=
ation
>>>>> provided by PMICs meaning that either vendors must add this in their =
kernels
>>>>> or USB gadget devices based on Linux (such as mobile phones) may not =
behave
>>>>> as they should. Thus provide a standard framework for doing this in k=
ernel.
>>>>>
>>>>> Now introduce one user with wm831x_power to support and test the usb =
charger,
>>>>> which is pending testing. Moreover there may be other potential users=
 will use
>>>>> it in future.
>>>>
>>>> Could you please apply this patchset into your 'next' branch if you
>>>> have no comments about it? Thank you.
>>>
>>> Since there are no other comments about this patchset for a long time,
>>> could you please apply this patchset? Thanks.
>>
>
> Sorry for the late reply.
>
>> Sorry, I should have replied earlier.  Tim Bird mentioned on the
>> ksummit-discuss list that there was a frustration with this not making
>> progress so I decided to contribute what I could now.
>>
>> I think this patch set is attempting to address an important problem
>> that needs solving.  However I think it gets some key aspects wrong.
>> Maybe they can get fixed up after the patchset is upstream, maybe they
>> should be fixed first - I have no strong opinion on that.
>>
>> My main complaints involve the detection and handling of the different
>> charger types - DCP, CDP, ACA etc.
>> The big-picture requirement here that the PHY will detect the physical
>> properties of the cable (e.g. resistance to ground on ID) and determine
>> the type of charger expected.  This information must be communicated to
>> the PMIC "power_supply" device so it can regulate the power being drawn
>> through the cable.
>>
>> The first problem is that there are two different ways that the
>> distinction between DCP, CDP, ACA etc can be represented in Linux.  They
>> are cable types in the 'extcon' subsystem, and they are power_supply
>> types in the 'power_supply' subsystem.  This duplication is confusing.
>> It is not caused by your patch set, but I believe your patchset needs to
>> work with the duplication and I think it does so poorly.
>
> Now the usb charger will not get charger type from 'extcon' subsystem,
> we get the charger type from 'power_supply' and calllback
> 'get_charger_type' for users.

I understand this.  I think it is wrong because, in general, the
power_supply doesn't know what the charger_type is (it might know it is
USB, but most don't know which sort of USB).  The PHY knows that, not
the power_supply.


>
>>
>> In my mind, the power_supply should *not* know about this distinction at
>> all (except possibly as an advisor attribute simiarly to the current
>> battery technology attribute).  The other types it knows of are "AC",
>> "USB", and "BATTERY".  The contrast between these is quite different
>> From the contrast between DCP, CDP, ACA, which, from the perspective of
>> the power supply, are almost irrelevant.  Your patchset effectively
>> examines the power_supply_type of one power_supply, and communicates it
>> to another.  It isn't clear to me how the first power_supply gets the
>> information, or what the relationship between the two power_supplies is
>> meant to be.
>
> We just get the charger type from the power supply which can get the
> charger type from register or something else,

But that register would be part of the PHY, not part of the charger.
Having the power_supply driver reading the PHY register might work for
some hardware, but is not a general solution.


>                                                and the usb charger did
> nothing for this power supply. In some platform, the charger type is
> get in power supply driver, thus we should link this power supply to
> get the charger type when USB cable is plugin. If you don't get
> charger type from power supply driver, then it does not need to link
> this power supply phandle.
>
>>
>> It makes much more sense, to me, to utilized the knowledge of this
>> distinction that extcon provides.  A usb PHY can register an extcon,
>> declare the sorts of cables that it can detect, and tell the extcon as
>> cables appear or disappear.  The PMIC power_supply can then register with
>> that extcon for events and can find out when a cable is attached, and
>> what sort of cable.
>> Your usb-charging framework would be well placed to help the
>> power_supply to find the correct extcon, and possibly even to handle the
>> registration for events.
>>
>> Your framework does currently register with extcon, but only listens for
>> EXTCON_USB cables.  I don't think that cable type is (reliably) reported
>> when a DCP (for example) is plugged in.
>
> Here we just listen the plugin/out events from extcon, if one cable
> plugin it will report to usb charger.

As far as I can tell there are no generic "plugin/out events from extcon".
There are only events for a specific cable being plugged or unplugged.
So you need to listed for each different type of cable that you are
interested in.

If it detects a "EXTCON_CHG_USB_ACA plugged" event, then it makes sense
to use that event to tell the power supply that the current profile for
an ACA is available.


>
>>
>> Here there is another problem that is not of your making, but still
>> needs fixing.  Extcon declares a number of cable types like:
>>
>> /* USB external connector */
>> #define EXTCON_USB              1
>> #define EXTCON_USB_HOST         2
>>
>> /* Charging external connector */
>> #define EXTCON_CHG_USB_SDP      5       /* Standard Downstream Port */
>> #define EXTCON_CHG_USB_DCP      6       /* Dedicated Charging Port */
>> #define EXTCON_CHG_USB_CDP      7       /* Charging Downstream Port */
>> #define EXTCON_CHG_USB_ACA      8       /* Accessory Charger Adapter */
>> #define EXTCON_CHG_USB_FAST     9
>> #define EXTCON_CHG_USB_SLOW     10
>>
>> However it doesn't define what those mean, so we are left to guess.
>> They each correspond to bits in a bitmap, so a cable can have multiple t=
ypes.
>> I think the best interpretation is that:
>>
>>  EXTCON_USB means that the cable carries USB data from a host.
>>  EXTCON_USB_HOST means that that cable carries USB data to a host.
>>  EXTCON_CHG_* means that power is available as described in the
>>  standards.
>>  (what EXTCON_CHG_USB_FAST and EXTCON_CHG_USB_SLOW mean is not at all
>>  clear).
>>
>> There is some support for this in the code, but it is not universally
>> acknowledged.  For a USB charging framework to be genuinely useful, it
>> must (I think) make sure this issue gets clarified, and the various
>> cable types used properly.
>
> Here I agree with you, now the usb charger does not listen the charger
> type from extcon which need to be fixed.
>
>>
>> Once the cable/charger type has been determined, the PMIC power_supply
>> needs to use this information.  Your current patches make use of this
>> information in ways that are wrong in two respects.
>>
>> Firstly, you have made the current limit associated with each cable type
>> configurable (__usb_charger_set_cur_limit_by_type).   This is nonsense.
>> The standard (e.g. BC-1.2) declares what the current limits are.  There
>> is no reason for those not to be hard coded.
>
> Yes, but you must think about some special cases on some platforms.
> Users may need to change the current in some situations, thus we
> should export one API for users to change the current. (I think you
> misunderstand the current limit here, that is the current for power
> driver  to draw).

Can you be specific about these "special cases" please?
I cannot think of any.

And what sort of "user" might use that API?  I don't think having an app
on your phone that allows you to set the max-current would be a good
idea, so you must be thinking of some other sort of user.

>
>>
>> Secondly, you treat each charger type as having a single "cur_limit" and
>> utilize that limit by telling the PMIC to draw that much current.
>
> This "cur_limit" is set by user or USB configuration what they want,
> usb charger just tells the power driver how much current need to draw.

You don't tell the power driver "how much current it needs to draw".
You tell it "how much current it is safe to draw".

A power driver cannot draw current that isn't available, and it cannot
draw current that the system as a whole has no use for.
The task of the power driver is to make sure the system doesn't draw
more power than is available, else the voltage will drop and the power
supply might shut off.

>
>> Again, this is inconsistent with the specification.
>> BC-1.2 defines, for each charger type, a minimum and maximum current
>> level.
>> The minimum should always be available.   Attempting to draw more than
>> that (but less that the max) might work or might cause the charger
>> to shut down, but you can be sure that the charger will respond to the
>> increased load by first reducing the voltage, and will not shut down
>> until the voltage has dropped below 2V.
>> If you try to draw more current than the maximum, then the charger might
>> shut down before the voltage drops below 2V.
>>
>> Given this understanding of the current available from the charger,
>> there are two approaches the PMIC might take.
>> 1/ if the PMIC is able to exercise fine control over the current it
>>   draws, and if it can monitor the voltage on the charger, then it
>>   could gradually increase the power being requested until the voltage
>>   drops below some threshold (e.g. 4.75V), and then (probably) back off
>>   a little.  It should only increase at most up to the maximum, even if
>>   the voltage remains high.  It should probably start at zero rather
>>   than at the minimum.  This allows for lossage elsewhere.
>>
>> 2/ If the PMIC cannot measure voltage, or doesn't have sufficiently fine
>>    control of the current requested, then it should request only the
>>    minimum available current.  Any more is not safe.
>
> Make sense.
>
>>
>> So your USB charging framework should communicate the MIN and MAX as
>> specified in the standard, and allow the PMIC to use that information as
>> appropriate.
>> A library routine to support the incremental increase in current drain
>> would probably be appreciated by PMIC driver writers.
>
> I should say again, the current is set by user or USB configuration
> what they want, USB charger just tells the power driver how much
> current need to draw. But we can add some checking if the setting
> current is in the right range.

The USB configuration tells the Host how much power it needs.  If the
host enables the configuration, that implicitly say that much power is
available, so the power_driver can safely request it.  I'm mostly happy
wit that aspect of your patch set.

For a dedicated charger there is no USB configuration.  The electrical
properties of the cable provide some information about how the charger
will behave, but they only guarantee a minimum.  If you want to use more
than the minimum, you have to do so carefully and watch the voltage level.
You cannot sensible let the user tell you how much current the charger
can provide, because they'll probably get it wrong and the charger will
just shut down.

Thanks,
NeilBrown


>
> Thanks for your comments.
>
>>
>>
>> A more details discussion of this problem-space can be found at
>>    https://lwn.net/Articles/693027/
>> and an analysis of the functionality currently available in the kernel
>> (which adds a number of specifics to the above) can be found at
>>    https://lwn.net/Articles/694062/
>>
>> NeilBrown
>>
>>
>
>
>
> --=20
> Baolin.wang
> Best Regards

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJX0RPnAAoJEDnsnt1WYoG5WaUQALVt/1oF/Da14lmr/E80JD8J
aOt7NfbF468kl84JLjMekFmbsV3gvdH2qsfRNKKzpc1uiYvW6MQIs7tnxbOzkECX
TSZNa0L8dgZPb8dyV9FfqLEZ/BhgdUKyIxdYibby/JGu0rBXAQK4s1oXqPBUX742
yClpmRhg2YB9nUTNAkWscNgHwv1OzjBlllPM8ZDvSJkQHzf27Ls9P4y83afENCIL
spwxVUvP63+qM+ees8J5We3K0fXkV3ZgPpsoufpoLKAgJfrwoitbTTOc4EyiEYC7
AjgeO+V/o1uIraCHy3hAKjA6Fe+Y/pzLr4k8hBRw4vHeZ4tTHHOAnXf/ifrtu8ig
w7EDcv082J/Roao2UjneybZOVhA/cLzwzT3HmgWGbO/JkVs5FxLZU04IRv2PiBxH
MyKu2j6YNGX6MPrUnJT29jcBMD/2hlBVSz9V4xxM5vmk5pxhXFPH96uopzfP+fgh
ScNNsPCOuOWZM1k+gfNPsGKlKe0XS+yhNpOt+ApDkb4q8CS7cVEiDedSrqzXbXDt
f8ml/jrIfXdCRdYI6sMcs9SXoL4DwhbAQQomp9o8hlZgr5GmxDkao1DTyoilSzWo
InFJOND+Pb2nH/PfYx68maYMO5w26IypAi1rMBvH4w6BT7Chct4zI11Zl+GY1F+2
4G0+LQ54vwU74u2dPtYy
=I2Lv
-----END PGP SIGNATURE-----
--=-=-=--
