From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH v16 0/4] Introduce usb charger framework to deal with the
 usb gadget power negotation
Date: Sat, 8 Oct 2016 11:18:38 +0800
Message-ID: <CAMz4kuL68SqD4TWida2V4fBCraL1ORvsv1uG+LEXJZcVqYPafA@mail.gmail.com>
References: <cover.1470034830.git.baolin.wang@linaro.org> <CAMz4kuLotLs1ASuZaMRXf29khmQUfEQc+jFV8Fxp+fHFn90Z9g@mail.gmail.com>
 <CAMz4ku+pkRT70NcZEDepfshH7z7+Fm3yo-C2+ccWgJwDJE4C-Q@mail.gmail.com>
 <8760q9a8m6.fsf@notabene.neil.brown.name> <CAMz4kuJJwKFqU=6JnpUQNPeQ-uy-PyZ5VBaBKofn=8Jv5y0nXA@mail.gmail.com>
 <878tv297a0.fsf@notabene.neil.brown.name> <CAMz4kuLXyVSXjh1Sn06+wcUr+bVritCW3sN=XyEdap7h=MN7xw@mail.gmail.com>
 <87y4326l44.fsf@notabene.neil.brown.name> <CAMz4ku+wWcSPCA1_UYKNqJv4rRDEm5WYUc8AVT6xPJ651-rzmg@mail.gmail.com>
 <87twdo7ouz.fsf@notabene.neil.brown.name> <CAMz4kuLXyLK2jFmaoxxceq01FT4fo+N-iAtCLPyQzJh5R24uOw@mail.gmail.com>
 <CAMz4kuLHEv16yBDxW=peVyPB3_K27QUDyKHT0ecBZxAQR-2VXA@mail.gmail.com>
 <878tu3p78u.fsf@linux.intel.com> <87a8ej9iso.fsf@notabene.neil.brown.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87a8ej9iso.fsf@notabene.neil.brown.name>
Sender: linux-kernel-owner@vger.kernel.org
To: NeilBrown <neilb@suse.com>
Cc: Felipe Balbi <balbi@kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, robh@kernel.org, Jun Li <jun.li@nxp.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Ruslan Bilovol <ruslan.bilovol@gmail.com>, Peter Chen <peter.chen@freescale.com>, Alan Stern <stern@rowland.harvard.edu>, r.baldyga@samsung.com, grygorii.strashko@ti.com, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Linux PM list <linux-pm@vger.kernel.org>, USB <linux-usb@vger.kernel.org>, device-mainli
List-Id: linux-pm@vger.kernel.org

Hi Neil,

On 5 October 2016 at 18:44, NeilBrown <neilb@suse.com> wrote:
> On Wed, Oct 05 2016, Felipe Balbi wrote:
>
>> Hi Baolin,
>>
>> Baolin Wang <baolin.wang@linaro.org> writes:
>>>>> But you do!
>>>>> The mA number from the USB configuration is passed to usb_gadget_vbus_draw.
>>>>> Your patch passes that to usb_charger_set_cur_limit_by_type()
>>>>> which calls __usb_charger_set_cur_limit_by_type() which will set the
>>>>> cur_limit for whichever type uchger->type currently is.
>>>>>
>>>>> So when it is not relevant, your code *does* set some current limit.
>>>>
>>>> Suppose the charger type is DCP(it is not relevant to the mA number
>>>> from the USB configuration ), it will not do the USB enumeration, then
>>>> no USB configuration from host to set current.
>>>
>>> From the talking, there are some issues (thanks for Neil's comments)
>>> need to be fixed as below:
>>> 1. Need to add the method getting charger type from extcon subsystem.
>>> 2. Need to remove the method getting charger type from power supply.
>>> 3. There are still some different views about reporting the maximum
>>> current or minimum current to power driver.
>>>
>>> Now the current v16 patchset can work well on my Spreadtrum platform
>>> and Jun's NXP platform, if you like to apply this patchset then I can
>
> I'm really curious how much testing this has had.  Have you actually
> plugged in different cable types (SDP DCP DCP ACA) and has each one been
> detected correctly?  Because I cannot see how that could happen with the
> code you have posted.

I transplanted the USB charger framework to our Spreadtrum platform
with implementing the 'get_charger_type' callback to get the charger
type in power driver. Cause we get the charger type from accessing the
PMIC registers not from USB PHY.

>
>>> send out new patches to fix above issues. If you don't like that, I
>>> can send out new version patchset to fix above issues. Could you  give
>>> me some suggestions what should I do next step? Thanks.
>>
>> Merge window just opened, nothing will happen for about 2 weeks. How
>> about you send a new version after merge window closes and we go from
>> there? Fixing 1 and 2 is needed. 3 we need to consider more
>> carefully. Perhaps report both minimum and maximum somehow?
>>
>> Neil, comments?
>
> This probably seems a bit harsh, but I really think the current patchset
> should be discarded and the the project started again with a clear
> vision of what is required.  What we currently have is too confused.

Probably not. Now the USB charger framework tried to integrate all
different charger plugged/unplugged events, and all different charger
type getting methods, then noticed the plugged/unplugged events and
charger current to power driver, which I think that is what USB
charger should really do. Moreover, this patchset is reviewed and
helped by many people (thanks Felipe, Greg, Mark, Peter and Jun), I
really hope I can make it better to upstream.

>
> To respond to the points:
>>> 1. Need to add the method getting charger type from extcon subsystem.
>
> Yes.  This should be the only way to get the charger type.

Not really. Like I said, some platform's charger detection is done by
hardware not USB PHY, thus we can get the charger type from PMIC
hardware registers.

>
>>> 2. Need to remove the method getting charger type from power supply.
>
> Also need to remove the ->get_charger_type() method as there is no
> credible use-case for this.

No. User can implement the get_charger_type() method to access the
PMIC registers to get the charger type, which is one very common
method.

>
>>> 3. There are still some different views about reporting the maximum
>>> current or minimum current to power driver.
>
> I think those were resolved.  There was some confusion over whether a
> particular power manager wanted to be told the maximum or the minimum,
> but I think both have a clear use case in different hardware.

So, seems I should report both minimum and maximum.

>
> Also: We don't want another notifier_chain.  The usb_notifier combined
> with the extcon notifier are sufficient.  Possibly it would be sensible
> to replace the usb notifier with a new new notifier chain, but don't add
> something without first cleaning up what is there.

USB charger is one virtual device not one actual hardware device, we
should not mess it together with usb_notifier or extcon notifier.

>
> Also: resolve the question of whether it could ever make sense to have
>  more than one "usb_charger" in a system.  If it doesn't, make it an
>  obvious singleton.  If it does, make it clear how the correct
>  usb_charger is chosen.

Usually only one USB charger in one system, I have not seen more than
one charger in a system.

>
> Also: think very carefully before exposing any details through sysfs.
>   Some of the details are already visible, either in sys/class/extcon
>   or sys/class/power_supply.  Don't duplicate without good reason.

I think now the current/state/type attributes are enough, which are
USB chargger needed. Thanks.

-- 
Baolin.wang
Best Regards
