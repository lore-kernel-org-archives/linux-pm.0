From: Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH V8 2/6] thermal: bcm2835: add thermal driver for bcm2835
 soc
Date: Thu, 24 Nov 2016 21:20:15 -0800
Message-ID: <20161125052008.GA8342@localhost.localdomain>
References: <1478081906-12009-1-git-send-email-kernel@martin.sperl.org>
 <1478081906-12009-3-git-send-email-kernel@martin.sperl.org>
 <20161117021107.GA2647@localhost.localdomain>
 <766e1b70-d83a-eb52-fa2b-aec435e85673@martin.sperl.org>
 <20161117151019.GA3115@localhost.localdomain>
 <7957B3CC-0E18-4B27-82EB-EF88B7695E28@martin.sperl.org>
 <20161119042224.GA25063@localhost.localdomain>
 <28F93ABE-8210-4389-AE77-4D5E830E669B@martin.sperl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <28F93ABE-8210-4389-AE77-4D5E830E669B-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Cc: Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Hello,

On Tue, Nov 22, 2016 at 03:28:04PM +0100, Martin Sperl wrote:
> Hi Eduardo!
> 
> On 19.11.2016 05:22, Eduardo Valentin wrote:
> > Hello Martin,

<cut>

> 
> I was asked to implement the "initialize" case just in case FW ever
> stopped setting up the device itself, so that is why this code is
> included.

OK. Looks like we (like, we in the Linux side) do not understand the
conditions that firmware fails to initialize the thermal device, but we
still want to force an initialization, hoping to get the device in a sane
state, even if we do not know if the firmware is correctly booted or
not. And that is done silently, with no notification to user. I see.

> 
> > 
> > Who has the ownership of this device?
> 
> Joined ownership I suppose...
> 

with no synchronization mechanism?

> > 
> >> The above mentioned “configuration if not running” reflect the values that
> >> the FW is currently setting. We should not change those values as long as the
> >> Firmware is also reading the temperature on its own.
> > 
> > hmm.. that looks like racy to me. Again, How do you synchronize accesses to
> > this device? What if you configure the device and right after the
> > firmware updates the configs? How do you make sure the configs you are
> > writing here are the same used by the firmware? What if the firmware
> > version changes? What versions of the firmware does this driver support?
> > 
> > Would it make sense to simply always initialize the device? Do you have
> > a way to tell the firmware that it should not use the device?
> > 
> > Or, if you want to keep the device driver simply being a dummy reader,
> > would it make sense to simply avoid writing configurations to the
> > device, and simply retry to check if the firmware gets the device
> > initialized?
> 
> Again: the device registers are only ever written if the device is not started
> already. Otherwise the driver only reads for the ADC register, so there
> is no real race here.
> 

and no race?

To me, there is a race when you write to the config of this device,
given that there is no sync between the two. We do not know if the
firmware would be still attempting to initialize the device or not, do
we? 

> > 
> >> 
> >>> 
> >>>> So do you need another version of the patchset that uses that new API?
> >>> 
> >>> I think the API usage is change that can be done together with
> >>> clarification for the above questions too: on hardware state,
> >>> firmware loading, maybe a master driver dependency, and the ADC
> >>> conversion sequence, which are not well clear to me on this driver. As long as
> >>> this is clarified and documented in the code (can be simple comments so
> >>> it is clear to whoever reads in the future), then I would be OK with
> >>> this driver.
> >> 
> >> So how do you want this to get “documented” in the driver?
> >> The setup and Firmware is a generic feature of the SOC, so if we would put
> >> some clarifications in this driver, then we would need to put it in every
> >> bcm283X driver (which seems unreasonable).
> >> 
> > 
> > I think a simple comment explaining the firmware dependency and the
> > expected pre-conditions to get this driver working in a sane state would
> > do it.
> > 
> > A better device initialization would also be appreciated. Based on my
> > limited understanding of this platform, and your explanations, this
> > device seams to have a serious race condition with firmware while
> > accessing this device.
> 
> Again: the firmware runs before the ARM is started and for all practical
> purposes the firmware is (as of now) configuring the thermal device.
> 

Oh, OK, we know the firmware wont touch the thermal device, right?

Then, If that is the case, what is still not clear is in which conditions
the firmware would leave the thermal device uninitialized.

This driver seams to be only concerned of critical temperature. The
concern I see with this code, and the explanations I heard, is a side
effect of seeing spurious thermal shutdown, or even worse, getting the
device booted hot and never shutting down, due to (possible) race
between the two systems.

Besides, if the firmware would not touch the thermal device when ARM is
running, why not always writing to the device a configuration that you
know is your sane starting point? Just do not rely on what was
previously set. How do you know it is a sane configuration? Have you
done sensor calibration exercise to confirm temperature reads are
correct?

> As for the use of thermal_zone_get_offset/slope: looking into the code
> it looks like this actually blows up the code, as we now would need to
> allocate thermal_zone_params and preset it with the “correct” values.
> 
> So more code to maintain and more memory consumed.
> The only advantage I would see is that it would allow to set offset and
> slope directly in the device tree.
> 

Any specific reason not to use of-thermal, then?


> Thanks,
> 		Martin

BR,

Eduardo Valentin

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
