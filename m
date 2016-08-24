From: Phil Reid <preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>
Subject: Re: [PATCH 1/1] power: sbs-manager: Add interrupt support and battery
 detect gpios
Date: Wed, 24 Aug 2016 09:37:48 +0800
Message-ID: <ea453b1c-2ea9-0fae-b394-9bcee3bca6e5@electromag.com.au>
References: <1469433003-68564-1-git-send-email-preid@electromag.com.au>
 <1469433003-68564-2-git-send-email-preid@electromag.com.au>
 <20160727144609.GA12462@rob-hp-laptop> <1469653707.27666.22.camel@amnesix>
 <4553a3f5-55cc-807d-7f34-11b4c7e11a0b@electromag.com.au>
 <e2ca7188-03e4-978d-9c10-9498117acb8e@electromag.com.au>
 <CAL_JsqL0+b5GRMMtK7PmECatR7aayiv-Of05HahGWSHHQ-vrYg@mail.gmail.com>
 <1469973873.5299.9.camel@schneider-inet.de>
 <ade6f7b9-dbaf-fd45-fd82-c3d69125ca8c@electromag.com.au>
 <1471982300.5080.17.camel@schneider-inet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1471982300.5080.17.camel-X5L7DgJ4l23oE99TX8zNy7NAH6kLmebB@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Karl-Heinz Schneider <karl-heinz-X5L7DgJ4l23oE99TX8zNy7NAH6kLmebB@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, andrea.merello-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On 24/08/2016 03:58, Karl-Heinz Schneider wrote:
> Hi Phil, Hi Rob,
>
> Am Montag, den 01.08.2016, 14:52 +0800 schrieb Phil Reid:
>> On 31/07/2016 22:04, Karl-Heinz Schneider wrote:
>>>
>>> Am Donnerstag, den 28.07.2016, 10:45 -0500 schrieb Rob Herring:
>>>>
>>>> On Thu, Jul 28, 2016 at 4:01 AM, Phil Reid <preid-qgqNFa1JUf/iIABC8yteiw@public.gmane.org
>>>> au>
>>>> wrote:
>>>>>
>>>>> On 28/07/2016 10:11, Phil Reid wrote:
>>>>>>
>>>>>> G'day Karl / Rob,
>>>>>> On 28/07/2016 05:08, Karl-Heinz Schneider wrote:
>>>>>>>
>>>>>>> Am Mittwoch, den 27.07.2016, 09:46 -0500 schrieb Rob
>>>>>>> Herring:
>>>>>>>>
>>>>>>>> On Mon, Jul 25, 2016 at 03:50:03PM +0800, Phil Reid
>>>>>>>> wrote:
>>>>>>>>>
>>>>>>>>> This patch added irq support for the SMBALERT pin and
>>>>>>>>> notification of
>>>>>>>>> the battery removal / insertion. The sbs manager would
>>>>>>>>> typically be
>>>>>>>>> used with the corresponding sbs-battery driver that
>>>>>>>>> currently uses a
>>>>>>>>> gpio input for battery presence and interrupt. To
>>>>>>>>> remain
>>>>>>>>> compatible
>>>>>>>>> with
>>>>>>>>> that existing driver this patch implements GPIO inputs
>>>>>>>>> with
>>>>>>>>> interrupt
>>>>>>>>> support. IRQ masking is performed in software as the
>>>>>>>>> hardware does not
>>>>>>>>> support masking of notifications from each battery.
>>>>>>>>> In addition a power_supply change notification is
>>>>>>>>> generated
>>>>>>>>> for the sbs
>>>>>>>>> manager device when the AC present flag is changed.
>>>>>>>>> Tested with LTC1760 and dual sbs compatible batteries.
>>>>>>>> Please don't submit a binding and immediately turn around
>>>>>>>> and
>>>>>>>> add to it.
>>>>>>>> While that is often preferred for drivers or kernel
>>>>>>>> features,
>>>>>>>> bindings
>>>>>>>> should be complete as possible and not evolve. Combine
>>>>>>>> this
>>>>>>>> with your
>>>>>>>> previous patch add sbs-mgr if that hasn't been accepted
>>>>>>>> yet.
>>>>>> That was from Karl. I'm happy to have this combined if he
>>>>>> is.Me
>>>> Indeed it was. Still, it should be combined. You can leave the
>>>> driver
>>>> implementation as multiple patches, just combine all the binding
>>>> to a
>>>> single patch by itself.
>>> Will do that.
>>>>
>>>>>
>>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>> IMO, the sbs-bat should just be a interrupt and making it
>>>>>>>> and
>>>>>>>> this
>>>>>>>> binding a GPIO is overkill. Since batteries nodes using
>>>>>>>> this
>>>>>>>> will be
>>>>>>>> new, there's no reason the driver can't be updated to
>>>>>>>> support
>>>>>>>> interrupts.
>>>>> I did consider this and didn't go that way as:
>>>>> 1) the current sbs-battery driver didn't support it.
>>>>> 2) Then there's also the problem of reporting  the presence of
>>>>> the
>>>>> battery
>>>>> to the battery driver.
>>>>> Without the GPIO support you resort to polling and looking for
>>>>> a
>>>>> NACK. Which
>>>>> didn't seem that nice.
>>>> The ability to read the current irq signal state with the irq api
>>>> would be nice. Of course you can't really count on being able to
>>>> on
>>>> all irqs. Anyway, we shouldn't really design the binding around
>>>> kernel
>>>> limitations.
>>>>
>>>> As I understand how SMBALERT works, you have to poll the devices
>>>> anyway to determine which device is asserting the irq and to ack
>>>> the
>>>> irq. Of course, here you are doing point to point connections,
>>>> but
>>>> you
>>>> still need to know which batteries are present by reading the
>>>> sbs-mgr
>>>> registers.
>>> The more interesting point for me is, that SMBALERT seems to
>>> provide an
>>> easy to use driver side interface. The code Registering the IRQ
>>> would
>>> vanish...
>>> Anyways I'm not very familiar with Linux IRQ handling, so I will
>>> follow
>>> your advise.
>> Just had a look at driver/i2c/i2c-smbus.c
>> This appears to be a generic driver to handle smbalert. Currently
>> used by the i2c-parport driver.
>> Doesn't look to support device trees at the moment thou.
>> Patch series "RFC: I2C: i2c-smbus: add device tree support" from
>> Andrea Merello looked to be adding generic support for it.
>> https://lkml.org/lkml/2016/4/13/157
>> Not sure where that's got to thou.
> Did see this one.
>>
>>>
>>>>
>>>>
>>>> Wouldn't switching the driver to level irq allow you to get the
>>>> state
>>>> immediately without a gpio read? After all, the gpio read and irq
>>>> handler are reading the same register.
>> If it's asserted continuously how do you stop the irq firing all the
>> time?
>> I guess you could register a high and low level irq and disable them
>> alternatively.
>> Unless I'm missing something.
>>
>> Keeping the gpio functionality also allows the battery detect to work
>> without the irq
>> connected to the sbsm thru polling.
>>
> So what to do now? I can simply take Phil's patch to add IRQ and GPIO
> support to the sbsm driver. It needs some fixups though, at least
> Kconfig things.
>
> IMHO adding irq support adds complexity to the driver as well as to the
> device tree binding, which shouldn't be necessary. Could also be true
> for the GPIO part, though (sbsm could issue a call to .notify() for
> it's slaves).
>
> So anyway. Will take Phils patch and resubmit the sbs-manager patch
> series if making the sbsm an IRQ and GPIO controller is really desired.
>

G'day Karl,

I'm planing on looking at the .notify() solution for sbsm.
Having the sbsm trigger an .notify() is an interesting solution.
It could certainly reduce a fair bit of my code and probably address the
biggest concern with the device tree.

I'm all for getting the driver submitted as you have it and I'll sort something
out later. I'm probably a couple of weeks away from getting time to look at this
again.



-- 
Regards
Phil Reid


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
