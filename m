From: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Subject: Re: [PATCH V8 2/6] thermal: bcm2835: add thermal driver for bcm2835 soc
Date: Fri, 18 Nov 2016 09:32:47 +0100
Message-ID: <7957B3CC-0E18-4B27-82EB-EF88B7695E28@martin.sperl.org>
References: <1478081906-12009-1-git-send-email-kernel@martin.sperl.org> <1478081906-12009-3-git-send-email-kernel@martin.sperl.org> <20161117021107.GA2647@localhost.localdomain> <766e1b70-d83a-eb52-fa2b-aec435e85673@martin.sperl.org> <20161117151019.GA3115@localhost.localdomain>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161117151019.GA3115-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-pm@vger.kernel.org


> On 17.11.2016, at 16:10, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> 
> Hello Martin,
> 
> On Thu, Nov 17, 2016 at 10:51:33AM +0100, Martin Sperl wrote:
>> 
>> 
>> On 17.11.2016 03:11, Eduardo Valentin wrote:
>>> Hey Martin,
>>> 
>>> Very sorry for the late feedback. Not so sure if this one got queued
>>> already or not. Anyways, just minor questions as follows:
>>> 
>>> On Wed, Nov 02, 2016 at 10:18:22AM +0000, kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org wrote:
>>>> From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
>>>> 
>>>> Add basic thermal driver for bcm2835 SOC.
>>>> 
>>>> This driver currently relies on the firmware setting up the
>>>> tsense HW block and does not set it up itself.
>>>> 
>>>> Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
>>>> Acked-by: Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>
>>>> Acked-by: Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>
>>>> 
>> ...
>>>> +static int bcm2835_thermal_adc2temp(
>>>> +	const struct bcm2835_thermal_info *info, u32 adc)
>>>> +{
>>>> +	return info->offset + (adc * info->slope);
>>> 
>>> Any specific reason we cannot use thermal_zone_params->slope and
>>> thermal_zone_params->offset?
>> 
>> You could - the patch was just rebased to 4.9 and those slope and
>> offset just got merged during this cycle.
>> 
>> Do we really need to modify it - the patch has been around since 4.6.
>> 
>>>> +
>>>> +static int bcm2835_thermal_get_trip_temp(
>>>> +	struct thermal_zone_device *tz, int trip, int *temp)
>>>> +{
>>>> +	struct bcm2835_thermal_data *data = tz->devdata;
>>>> +	u32 val = readl(data->regs + BCM2835_TS_TSENSCTL);
>>>> +
>>>> +	/* get the THOLD bits */
>>>> +	val &= BCM2835_TS_TSENSCTL_THOLD_MASK;
>>>> +	val >>= BCM2835_TS_TSENSCTL_THOLD_SHIFT;
>>>> +
>>>> +	/* if it is zero then use the info value */
>>>> +	if (val)
>>> 
>>> Is this a read only register or is this driver supposed to program it?
>>> In which scenario it would be 0? Can this be added as comments?
>> 
>> It is RW, but the Firmware typically sets up the thermal device with the
>> correct values already - this is just a fallback.
> 
> OK, but how do you differentiate from a buggy firmware or misconfigured
> hardware? How do you know if the firmware is supposed to be loaded and
> ready? There is no firmware loading in this driver. Also, there is no
> dependency with a driver that loads firmware, or at least, I missed it.
> 
The way that firmware works on the RPI is quite different from most others I guess.
in principle you got 2 different CPUs on the bcm2835:
* ARM, which runs the linux instance
* VideoCore 4, which runs the firmware (loading from SD initially) and
  then booting the ARM.

So this Firmware on VC4 is the one that I am talking about.
Without the working firmware linux can not boot on arm.
As of now he firmware is also checking temperature of the SOC itself and
if it finds “critical” temperatures it will clock down ARM and the GPU.

Hope that this explains the “firmware” on bcm2835.

>> 
>>>> +static int bcm2835_thermal_get_temp(struct thermal_zone_device *tz,
>>>> +				    int *temp)
>>>> +{
>>>> +	struct bcm2835_thermal_data *data = tz->devdata;
>>>> +	u32 val = readl(data->regs + BCM2835_TS_TSENSSTAT);
>>>> +
>>>> +	if (!(val & BCM2835_TS_TSENSSTAT_VALID))
>>> 
>>> What cases you would get the valid bit not set? Do you need to wait for
>>> the conversion to finish?
>> 
>> I guess: if you have just enabled the HW-block (which the FW does much
>> in advance) and start to read the value immediately (before the first sample
>> period has finished), then this will not be valid.
>> 
> 
> Then again, how does this driver make sure the initialization procedure
> is correct, and that by the time it is using the hardware, the hardware
> is in a sane state?
> 
> Back to the original question, does it mean the hardware is in
> some sort of continuous ADC conversion mode or reading the temperature
> requires specific steps to get the conversion done, and therefore you
> are checking the valid bit here?

As far as I understand the conversion is continuous (as soon as the HW is
configured). This case is there primarily to handle the situation where
we initialize the HW ourselves (see line 226 and below), and we immediately
want to read the ADC value before the first conversion is finished.

The above mentioned “configuration if not running” reflect the values that
the FW is currently setting. We should not change those values as long as the
Firmware is also reading the temperature on its own.

> 
>> So do you need another version of the patchset that uses that new API?
> 
> I think the API usage is change that can be done together with
> clarification for the above questions too: on hardware state,
> firmware loading, maybe a master driver dependency, and the ADC
> conversion sequence, which are not well clear to me on this driver. As long as
> this is clarified and documented in the code (can be simple comments so
> it is clear to whoever reads in the future), then I would be OK with
> this driver. 

So how do you want this to get “documented” in the driver?
The setup and Firmware is a generic feature of the SOC, so if we would put
some clarifications in this driver, then we would need to put it in every
bcm283X driver (which seems unreasonable).

Thanks,
	Martin--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
