From: Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>
Subject: Re: Clocks used by another OS/CPU (was: Re: [RFC PATCH] clk: renesas:
 cpg-mssr: Add interface for critical core clocks)
Date: Mon, 3 Jul 2017 10:17:22 +0100
Message-ID: <8d255a76-babe-312d-15b3-3474969f2410@arm.com>
References: <CAMuHMdW9+CNTTOVO4SRRUxuz3ajLbY2j1uG8b_RpHX52NPwXrQ@mail.gmail.com>
 <CAL_JsqKGrZeR7z80beY_XEjqd5fEQQwPxusJ1FADoALgNE3fEg@mail.gmail.com>
 <20170630202453.eh6vaehkap3as4np@pengutronix.de>
 <8d86a9aa-1928-6b52-1487-d5fb9dae17f4@gmail.com>
 <20170701181408.yuocymwtj5dgt74d@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170701181408.yuocymwtj5dgt74d-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Dirk Behme <dirk.behme-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Dirk Behme <dirk.behme-V5te9oGctAVWk0Htik3J/w@public.gmane.org>, Linux PM list <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Michael Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Linux-Renesas <linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Kevin Hilman <khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, linux-clk <linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-pm@vger.kernel.org



On 01/07/17 19:14, Uwe Kleine-König wrote:
> Hello,
> 
> On Sat, Jul 01, 2017 at 07:02:48AM +0200, Dirk Behme wrote:

[...]

>>
>>
>> The other problem is security related. If, at all, you have to do it the
>> other way around, then:
>>
>> Make Linux a consumer of the other CPU's (trusted/trustzone/whatever
>> secured) OS clock driver.

Yes, that's better and is getting common on newer platforms. They have
separate M-class(or even low A-class e.g. A5/A7) processors to handle
all the system management.

The new ARM SCMI specification[0][1] is designed to standardize the
interface. It covers the clocks in clock protocol.

> 
> That doesn't matter much. Either way the first CPU has to provide the
> master side of this device (as it needs clks for booting up) and the 2nd
> gets this virtual clk device that forwards clk requests to the first
> CPU.
> 
> On my machine (Udoo Neo, A9 + M4) the A9 is the primary CPU that is
> started by the bootrom. If I want the M4 being the primary device I'd
> need support in the bootloader to wait long enough (i.e. until the M4 is
> up) before letting the A9 jump into Linux.

I think that is platform specific. On few platforms I have seen
recently, it's M4 or whatever core that handles system power management
boots first and is responsible to even boot secondaries.

> Managable I'd say. This way would even make sense if the M4 runs a
> rt critical OS that shouldn't be forced to wait on the non-rt A9 to> enable a clk.
> 

Exactly.

-- 
Regards,
Sudeep


[0] http://infocenter.arm.com/help/topic/com.arm.doc.den0056a/index.html
[1] https://marc.info/?l=devicetree&m=149849482623492&w=2
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
