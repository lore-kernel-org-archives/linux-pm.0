From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH v16 0/4] Introduce usb charger framework to deal with the
 usb gadget power negotation
Date: Thu, 8 Sep 2016 14:55:04 +0800
Message-ID: <CAMz4kuJJwKFqU=6JnpUQNPeQ-uy-PyZ5VBaBKofn=8Jv5y0nXA@mail.gmail.com>
References: <cover.1470034830.git.baolin.wang@linaro.org> <CAMz4kuLotLs1ASuZaMRXf29khmQUfEQc+jFV8Fxp+fHFn90Z9g@mail.gmail.com>
 <CAMz4ku+pkRT70NcZEDepfshH7z7+Fm3yo-C2+ccWgJwDJE4C-Q@mail.gmail.com> <8760q9a8m6.fsf@notabene.neil.brown.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <8760q9a8m6.fsf@notabene.neil.brown.name>
Sender: linux-kernel-owner@vger.kernel.org
To: NeilBrown <nfbrown@novell.com>
Cc: Felipe Balbi <balbi@kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, robh@kernel.org, Jun Li <jun.li@nxp.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Ruslan Bilovol <ruslan.bilovol@gmail.com>, Peter Chen <peter.chen@freescale.com>, Alan Stern <stern@rowland.harvard.edu>, r.baldyga@samsung.com, grygorii.strashko@ti.com, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Linux PM list <linux-pm@vger.kernel.org>, USB <linux-usb@vger.kernel.org>, device-mainli
List-Id: linux-pm@vger.kernel.org

Hi Neil,

On 6 September 2016 at 13:40, NeilBrown <nfbrown@novell.com> wrote:
> On Mon, Aug 29 2016, Baolin Wang wrote:
>
>> Hi Felipe,
>>
>> On 11 August 2016 at 11:14, Baolin Wang <baolin.wang@linaro.org> wrote:
>>> Hi Felipe,
>>>
>>> On 1 August 2016 at 15:09, Baolin Wang <baolin.wang@linaro.org> wrote:
>>>> Currently the Linux kernel does not provide any standard integration of this
>>>> feature that integrates the USB subsystem with the system power regulation
>>>> provided by PMICs meaning that either vendors must add this in their kernels
>>>> or USB gadget devices based on Linux (such as mobile phones) may not behave
>>>> as they should. Thus provide a standard framework for doing this in kernel.
>>>>
>>>> Now introduce one user with wm831x_power to support and test the usb charger,
>>>> which is pending testing. Moreover there may be other potential users will use
>>>> it in future.
>>>
>>> Could you please apply this patchset into your 'next' branch if you
>>> have no comments about it? Thank you.
>>
>> Since there are no other comments about this patchset for a long time,
>> could you please apply this patchset? Thanks.
>

Sorry for the late reply.

> Sorry, I should have replied earlier.  Tim Bird mentioned on the
> ksummit-discuss list that there was a frustration with this not making
> progress so I decided to contribute what I could now.
>
> I think this patch set is attempting to address an important problem
> that needs solving.  However I think it gets some key aspects wrong.
> Maybe they can get fixed up after the patchset is upstream, maybe they
> should be fixed first - I have no strong opinion on that.
>
> My main complaints involve the detection and handling of the different
> charger types - DCP, CDP, ACA etc.
> The big-picture requirement here that the PHY will detect the physical
> properties of the cable (e.g. resistance to ground on ID) and determine
> the type of charger expected.  This information must be communicated to
> the PMIC "power_supply" device so it can regulate the power being drawn
> through the cable.
>
> The first problem is that there are two different ways that the
> distinction between DCP, CDP, ACA etc can be represented in Linux.  They
> are cable types in the 'extcon' subsystem, and they are power_supply
> types in the 'power_supply' subsystem.  This duplication is confusing.
> It is not caused by your patch set, but I believe your patchset needs to
> work with the duplication and I think it does so poorly.

Now the usb charger will not get charger type from 'extcon' subsystem,
we get the charger type from 'power_supply' and calllback
'get_charger_type' for users.

>
> In my mind, the power_supply should *not* know about this distinction at
> all (except possibly as an advisor attribute simiarly to the current
> battery technology attribute).  The other types it knows of are "AC",
> "USB", and "BATTERY".  The contrast between these is quite different
> From the contrast between DCP, CDP, ACA, which, from the perspective of
> the power supply, are almost irrelevant.  Your patchset effectively
> examines the power_supply_type of one power_supply, and communicates it
> to another.  It isn't clear to me how the first power_supply gets the
> information, or what the relationship between the two power_supplies is
> meant to be.

We just get the charger type from the power supply which can get the
charger type from register or something else, and the usb charger did
nothing for this power supply. In some platform, the charger type is
get in power supply driver, thus we should link this power supply to
get the charger type when USB cable is plugin. If you don't get
charger type from power supply driver, then it does not need to link
this power supply phandle.

>
> It makes much more sense, to me, to utilized the knowledge of this
> distinction that extcon provides.  A usb PHY can register an extcon,
> declare the sorts of cables that it can detect, and tell the extcon as
> cables appear or disappear.  The PMIC power_supply can then register with
> that extcon for events and can find out when a cable is attached, and
> what sort of cable.
> Your usb-charging framework would be well placed to help the
> power_supply to find the correct extcon, and possibly even to handle the
> registration for events.
>
> Your framework does currently register with extcon, but only listens for
> EXTCON_USB cables.  I don't think that cable type is (reliably) reported
> when a DCP (for example) is plugged in.

Here we just listen the plugin/out events from extcon, if one cable
plugin it will report to usb charger.

>
> Here there is another problem that is not of your making, but still
> needs fixing.  Extcon declares a number of cable types like:
>
> /* USB external connector */
> #define EXTCON_USB              1
> #define EXTCON_USB_HOST         2
>
> /* Charging external connector */
> #define EXTCON_CHG_USB_SDP      5       /* Standard Downstream Port */
> #define EXTCON_CHG_USB_DCP      6       /* Dedicated Charging Port */
> #define EXTCON_CHG_USB_CDP      7       /* Charging Downstream Port */
> #define EXTCON_CHG_USB_ACA      8       /* Accessory Charger Adapter */
> #define EXTCON_CHG_USB_FAST     9
> #define EXTCON_CHG_USB_SLOW     10
>
> However it doesn't define what those mean, so we are left to guess.
> They each correspond to bits in a bitmap, so a cable can have multiple types.
> I think the best interpretation is that:
>
>  EXTCON_USB means that the cable carries USB data from a host.
>  EXTCON_USB_HOST means that that cable carries USB data to a host.
>  EXTCON_CHG_* means that power is available as described in the
>  standards.
>  (what EXTCON_CHG_USB_FAST and EXTCON_CHG_USB_SLOW mean is not at all
>  clear).
>
> There is some support for this in the code, but it is not universally
> acknowledged.  For a USB charging framework to be genuinely useful, it
> must (I think) make sure this issue gets clarified, and the various
> cable types used properly.

Here I agree with you, now the usb charger does not listen the charger
type from extcon which need to be fixed.

>
> Once the cable/charger type has been determined, the PMIC power_supply
> needs to use this information.  Your current patches make use of this
> information in ways that are wrong in two respects.
>
> Firstly, you have made the current limit associated with each cable type
> configurable (__usb_charger_set_cur_limit_by_type).   This is nonsense.
> The standard (e.g. BC-1.2) declares what the current limits are.  There
> is no reason for those not to be hard coded.

Yes, but you must think about some special cases on some platforms.
Users may need to change the current in some situations, thus we
should export one API for users to change the current. (I think you
misunderstand the current limit here, that is the current for power
driver  to draw).

>
> Secondly, you treat each charger type as having a single "cur_limit" and
> utilize that limit by telling the PMIC to draw that much current.

This "cur_limit" is set by user or USB configuration what they want,
usb charger just tells the power driver how much current need to draw.

> Again, this is inconsistent with the specification.
> BC-1.2 defines, for each charger type, a minimum and maximum current
> level.
> The minimum should always be available.   Attempting to draw more than
> that (but less that the max) might work or might cause the charger
> to shut down, but you can be sure that the charger will respond to the
> increased load by first reducing the voltage, and will not shut down
> until the voltage has dropped below 2V.
> If you try to draw more current than the maximum, then the charger might
> shut down before the voltage drops below 2V.
>
> Given this understanding of the current available from the charger,
> there are two approaches the PMIC might take.
> 1/ if the PMIC is able to exercise fine control over the current it
>   draws, and if it can monitor the voltage on the charger, then it
>   could gradually increase the power being requested until the voltage
>   drops below some threshold (e.g. 4.75V), and then (probably) back off
>   a little.  It should only increase at most up to the maximum, even if
>   the voltage remains high.  It should probably start at zero rather
>   than at the minimum.  This allows for lossage elsewhere.
>
> 2/ If the PMIC cannot measure voltage, or doesn't have sufficiently fine
>    control of the current requested, then it should request only the
>    minimum available current.  Any more is not safe.

Make sense.

>
> So your USB charging framework should communicate the MIN and MAX as
> specified in the standard, and allow the PMIC to use that information as
> appropriate.
> A library routine to support the incremental increase in current drain
> would probably be appreciated by PMIC driver writers.

I should say again, the current is set by user or USB configuration
what they want, USB charger just tells the power driver how much
current need to draw. But we can add some checking if the setting
current is in the right range.

Thanks for your comments.

>
>
> A more details discussion of this problem-space can be found at
>    https://lwn.net/Articles/693027/
> and an analysis of the functionality currently available in the kernel
> (which adds a number of specifics to the above) can be found at
>    https://lwn.net/Articles/694062/
>
> NeilBrown
>
>



-- 
Baolin.wang
Best Regards
