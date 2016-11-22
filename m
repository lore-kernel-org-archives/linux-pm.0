From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Subject: Re: [PATCH V8 2/6] thermal: bcm2835: add thermal driver for bcm2835 soc
Date: Tue, 22 Nov 2016 15:28:04 +0100
Message-ID: <28F93ABE-8210-4389-AE77-4D5E830E669B@martin.sperl.org>
References: <1478081906-12009-1-git-send-email-kernel@martin.sperl.org> <1478081906-12009-3-git-send-email-kernel@martin.sperl.org> <20161117021107.GA2647@localhost.localdomain> <766e1b70-d83a-eb52-fa2b-aec435e85673@martin.sperl.org> <20161117151019.GA3115@localhost.localdomain> <7957B3CC-0E18-4B27-82EB-EF88B7695E28@martin.sperl.org> <20161119042224.GA25063@localhost.localdomain>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161119042224.GA25063-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Hi Eduardo!

On 19.11.2016 05:22, Eduardo Valentin wrote:
> Hello Martin,
> 
> Thanks for your patience to take the time to explain to me how the
> firmware/linux split is done in your platform. Still, one thing is not
> clear to me.
> 
> On Fri, Nov 18, 2016 at 09:32:47AM +0100, kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org wrote:
>> 
> 
>> The way that firmware works on the RPI is quite different from most others I guess.
>> in principle you got 2 different CPUs on the bcm2835:
>> * ARM, which runs the linux instance
>> * VideoCore 4, which runs the firmware (loading from SD initially) and
>>  then booting the ARM.
>> 
>> So this Firmware on VC4 is the one that I am talking about.
>> Without the working firmware linux can not boot on arm.
> 
> Given that "without the working firmware linux can not boot on arm",
> 
> (...)
> 
>> As far as I understand the conversion is continuous (as soon as the HW is
>> configured). This case is there primarily to handle the situation where
>> we initialize the HW ourselves (see line 226 and below), and we immediately
> 
> and around line 226 we have the comment:
> +       /*
> +        * right now the FW does set up the HW-block, so we are not
> +        * touching the configuration registers.
> +        * But if the HW is not enabled, then set it up
> +        * using "sane" values used by the firmware right now.
> +        */
> 
> 
>> want to read the ADC value before the first conversion is finished.
>> 
> 
> then, does the firmware initializes the device or not?
> 

Yes, it does (normally)

> What are the cases you would load this driver but still get an
> uninitialized device? That looks like some bug workaround hidden
> somewhere. Do system integrators/engineers need to be aware of this w/a?
> Would the driver work right aways when the subsystem is loaded during
> boot? How about module insertion?
> 

I was asked to implement the "initialize" case just in case FW ever
stopped setting up the device itself, so that is why this code is
included.

> 
> Who has the ownership of this device?

Joined ownership I suppose...

> 
>> The above mentioned “configuration if not running” reflect the values that
>> the FW is currently setting. We should not change those values as long as the
>> Firmware is also reading the temperature on its own.
> 
> hmm.. that looks like racy to me. Again, How do you synchronize accesses to
> this device? What if you configure the device and right after the
> firmware updates the configs? How do you make sure the configs you are
> writing here are the same used by the firmware? What if the firmware
> version changes? What versions of the firmware does this driver support?
> 
> Would it make sense to simply always initialize the device? Do you have
> a way to tell the firmware that it should not use the device?
> 
> Or, if you want to keep the device driver simply being a dummy reader,
> would it make sense to simply avoid writing configurations to the
> device, and simply retry to check if the firmware gets the device
> initialized?

Again: the device registers are only ever written if the device is not started
already. Otherwise the driver only reads for the ADC register, so there
is no real race here.

> 
>> 
>>> 
>>>> So do you need another version of the patchset that uses that new API?
>>> 
>>> I think the API usage is change that can be done together with
>>> clarification for the above questions too: on hardware state,
>>> firmware loading, maybe a master driver dependency, and the ADC
>>> conversion sequence, which are not well clear to me on this driver. As long as
>>> this is clarified and documented in the code (can be simple comments so
>>> it is clear to whoever reads in the future), then I would be OK with
>>> this driver.
>> 
>> So how do you want this to get “documented” in the driver?
>> The setup and Firmware is a generic feature of the SOC, so if we would put
>> some clarifications in this driver, then we would need to put it in every
>> bcm283X driver (which seems unreasonable).
>> 
> 
> I think a simple comment explaining the firmware dependency and the
> expected pre-conditions to get this driver working in a sane state would
> do it.
> 
> A better device initialization would also be appreciated. Based on my
> limited understanding of this platform, and your explanations, this
> device seams to have a serious race condition with firmware while
> accessing this device.

Again: the firmware runs before the ARM is started and for all practical
purposes the firmware is (as of now) configuring the thermal device.

As for the use of thermal_zone_get_offset/slope: looking into the code
it looks like this actually blows up the code, as we now would need to
allocate thermal_zone_params and preset it with the “correct” values.

So more code to maintain and more memory consumed.
The only advantage I would see is that it would allow to set offset and
slope directly in the device tree.

Thanks,
		Martin--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
