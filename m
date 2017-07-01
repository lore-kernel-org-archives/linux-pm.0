From: Dirk Behme <dirk.behme-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Clocks used by another OS/CPU (was: Re: [RFC PATCH] clk: renesas:
 cpg-mssr: Add interface for critical core clocks)
Date: Sat, 1 Jul 2017 07:02:48 +0200
Message-ID: <8d86a9aa-1928-6b52-1487-d5fb9dae17f4@gmail.com>
References: <CAMuHMdW9+CNTTOVO4SRRUxuz3ajLbY2j1uG8b_RpHX52NPwXrQ@mail.gmail.com>
 <CAL_JsqKGrZeR7z80beY_XEjqd5fEQQwPxusJ1FADoALgNE3fEg@mail.gmail.com>
 <20170630202453.eh6vaehkap3as4np@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170630202453.eh6vaehkap3as4np-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Dirk Behme <dirk.behme-V5te9oGctAVWk0Htik3J/w@public.gmane.org>, Linux PM list <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Michael Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Linux-Renesas <linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Kevin Hilman <khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, linux-clk <linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 30.06.2017 22:24, Uwe Kleine-König wrote:
> Hello,
> 
> On Fri, Jun 30, 2017 at 10:58:26AM -0500, Rob Herring wrote:
>>> TL;DR: Clocks may be in use by another CPU not running Linux, while Linux
>>> disables them as being unused.
> 
> not long ago I thought with a few colleagues about this. The scenario is
> to start a Linux kernel on a Cortex-M companion to a Cortex-A.
> 
>>> On Mon, Jun 26, 2017 at 1:30 PM, Dirk Behme <dirk.behme-V5te9oGctAVWk0Htik3J/w@public.gmane.org> wrote:
>>>> With commit 72f5df2c2bbb6 ("clk: renesas: cpg-mssr: Migrate to
>>>> CLK_IS_CRITICAL") we are able to handle critical module clocks.
>>>> Introduce the same logic for critical core clocks.
>>>>
>>>> Signed-off-by: Dirk Behme <dirk.behme-V5te9oGctAVWk0Htik3J/w@public.gmane.org>
>>>> ---
>>>> Commit
>>>>
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/clk/renesas?id=72f5df2c2bbb66d4a555cb51eb9f412abf1af77f
>>>>
>>>> is quite nice to avoid *module* clocks being disabled. Unfortunately,
>>>> there are *core* clocks, too. E.g. using an other OS on the Cortex R7
>>>> core of the r8a7795, the 'canfd' is a quite popular core clock which
>>>> shouldn't be disabled by Linux.
>>>>
>>>> Therefore, this patch is a proposal to use the same 'mark clocks as
>>>> critical' logic implemented for the module clocks for the core
>>>> clocks, too.
>>>>
>>>> Opinions?
>>>
>>> On r8a7795, there are several Cortex A cores running Linux, and a Cortex R7
>>> core which may run another OS.
>>> This is an interesting issue, and relevant to other SoCs, too.
>>>
>>> In this particular case, the "canfd" clock is a core clock used as an
>>> auxiliary clock for the CAN0, CAN1, and CANFD interfaces.  This can lead
>>> to three scenarios:
>>>    1. Linux controls all CAN interfaces
>>>       => no issue,
>>>    2. The OS on the RT CPU controls all CAN interfaces
>>>       => issue, Linux disables the clock
>>>    3. Mix of 1 and 2
>>>       => More issues.
>>> Of course this is not limited to clocks, but also to e.g. PM domains.
>>>
>>> How can this be handled?
>>> I believe just marking the "canfd" clock critical is not the right solution,
>>> as about any clock could be used by the RT CPU.
>>>
>>> Still, Linux needs to be made aware that devices (clocks and PM domains) are
>>> controlled by another CPU/OS.
>>>
>>> Should this be described in DT? It feels like software policy to me.
>>
>> No, it shouldn't. It is Linux policy to disable all unused clocks, so
>> Linux gets to deal with the consequences.
> 
> The ideal solution I imagine is to make the other CPU's OS a consumer of
> the Linux clock driver. This would require a generic device driver on the
> companion CPU that forwards clk requests via inter-cpu communication to
> the Linux clk driver. It could be feed with the necessary information by
> the rproc glue. So when the companion cpu is supposed to care for the
> can0 device, the steps that should happen are:
> 
>   - make sure can0 isn't occupied by the Linux Host
>   - reroute the can irq to the companion cpu (if necessary)
>   - create a dtb containing something like this for the companion CPU:
> 
>   	clks: virtclk {
> 		compatible = ???
> 		#clock-cells = <1>;
> 		...
> 	};
> 
> 	can@$address {
> 		compatible = ...
> 		regs = ...
> 		clocks = <&clks 3>;
> 		clock-names = ...
> 		...
> 	};
> 
>     where the driver binding to the virtclk device just forwards clk
>     requests to the Linux host side which then knows that clk 3 is the
>     can clock and does the necessary stuff.
> 
> This way the can clock doesn't need special handling in the host's dtb
> and no clock necessary for the companion is disabled as unused because
> it is requested and enabled.
> 
> The only problem I see is that implementing such a driver/protocol
> probably is time consuming.


The other problem is security related. If, at all, you have to do it 
the other way around, then:

Make Linux a consumer of the other CPU's (trusted/trustzone/whatever 
secured) OS clock driver.

Best regards

Dirk
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
