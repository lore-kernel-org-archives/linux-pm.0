From: Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v4 1/2] ARM: keystone: pm: switch to use generic pm domains
Date: Fri, 21 Nov 2014 11:20:05 -0800
Message-ID: <7h8uj4nyxm.fsf@deeprootsystems.com>
References: <1415631557-22897-1-git-send-email-grygorii.strashko@ti.com>
	<1709760.E0jX3Myv0h@wuerfel> <546C7FDD.7030906@ti.com>
	<2900095.WIocOu7ue2@wuerfel>
	<CAPDyKFqeZ3YU2OEN4tCOdcQ0pAho67Q8U_eCEOroG9aS0mp+-Q@mail.gmail.com>
	<546DD87B.3080806@ti.com>
	<CAPDyKFrBhZyqozM98_4pPdW0EMFt5W6VX1X7cz6Z=yNhW4vYTA@mail.gmail.com>
	<CAMuHMdWtHT7QX3Kpa-GCLa49ToGODwjnNVgfxDzJzcM-FU1ffg@mail.gmail.com>
	<546E0970.5090301@ti.com> <7hh9xtr5ac.fsf@deeprootsystems.com>
	<CAMuHMdV7zASj8_NtLRir1VubXEKTkq0vBGMXeYXDACu8UC2tZA@mail.gmail.com>
	<7hbno1r1af.fsf@deeprootsystems.com>
	<CAMuHMdVXGPu7x706NxqO3rn3KuRbPbD_ZQsJtDH4Hf31AaRR+Q@mail.gmail.com>
	<7hppchpcfm.fsf@deeprootsystems.com>
	<CAMuHMdU6G35SP-P7bt6RJQk59CrGcKE2XM4N3o8Dv3qxZU7gxA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAMuHMdU6G35SP-P7bt6RJQk59CrGcKE2XM4N3o8Dv3qxZU7gxA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
	(Geert Uytterhoeven's message of "Fri, 21 Nov 2014 09:06:09 +0100")
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Cc: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, ssantosh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, "linux-pm@vger.kernel.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-kernel@vger.kernel.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree@vger.kernel.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org> writes:

> Hi Kevin,
>
> On Fri, Nov 21, 2014 at 2:30 AM, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>> Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org> writes:
>>> On Thu, Nov 20, 2014 at 10:48 PM, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>>>>>> So what exactly are we talking about with "PM" clocks, and why are they
>>>>>> "special" when it comes to PM domains?  IOW, why are the clocks to be
>>>>>> managed during PM domain transitions for a given device any different
>>>>>> than the clocks that need to be managed for a runtime suspend/resume (or
>>>>>> system suspend/resume) sequence for the same device?
>>>>>
>>>>> (Speaking for my case, shmobile)
>>>>>
>>>>> They're not. The clocks to be managed during PM domain transitions are the
>>>>> same as the clocks that need to be managed for a runtime suspend/resume
>>>>> (or system suspend/resume) sequence.
>>>>>
>>>>> The special thing is that this is more a platform than a driver thing: the same
>>>>> module may have a "PM/functional" clock (that is documented to enable/disable
>>>>> the module) on one Soc, but noet on another.
>>>>
>>>> So why isn't the presence or absence of the clock described in the .dtsi
>>>> for the SoC instead of being handled by special PM domain logic?
>>>
>>> It is. Cfr. the presence/absence of clocks for renesas,rcar-gpio nodes.
>>
>> Hmm, OK, Good.
>>
>> So now I'm confused about why the PM domain has to do anything special
>> if the presence/absence of the clocks is already handled by the DT.
>
> Just adding a clock property to a device node in DT doesn't enable the clock
> automatically, nor make it runtime-managed automatically.

In general, that's true.  But I thought you're PM domain was written to
look for clock properties, and if present would manage them.  The
proposed genpd support for TI Keystone2 would make it so these clocks
would definitely be automatically managed by the PM domain.

> Compare this to e.g. pinctrl, where adding pinctrl properties to DT does enable
> them automatically, without the driver for the device having to care about it.

Well, we're headed down the same path with genpd (if given the right
properties in genpd.)

> Drivers interfacing external hardware typically do care about clocks, as they
> have to program clock generators for the external hardware interface (e.g.
> driving spi or i2c buses at specific frequencies).

Yes, but IMO, these should be handled by the driver, not by the PM
domain.  More specifically, if a device is generating a clock for
external hardware, presumably it cannot be runtime suspended, so the
enclosing PM domain can be powered off.  If it's not generating a clock,
then it can be runtime suspended and presumably would gate it's
externally facing clocks when it runtime suspends.

> Other random drivers don't care about clocks, so they don't handle them.
> But as long as they make basic pm_runtime_{enable,get_sync,put}() calls,
> the (optional) clocks (and hardware PM domains) will "work" fine, if handled
> by the PM (clock) domain.

Yes, I understand that.  But this still isn't helping me understand why
your PM domain has to distinguish between different types of clocks
(e.g. why it only manages the first clock.) 

Did you set up the properties so that the first clock was the functional
clock and any additional ones were for devices that generate external
clocks?

Kevin

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
