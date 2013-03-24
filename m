From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH v2] cpufreq: instantiate cpufreq-cpu0 as a platform_driver
Date: Sun, 24 Mar 2013 11:06:58 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1303241053150.3325@axis700.grange>
References: <1359428020-21068-1-git-send-email-shawn.guo@linaro.org>
 <Pine.LNX.4.64.1303221600060.12375@axis700.grange>
 <20130323063215.GF6281@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <20130323063215.GF6281@S2101-09.ap.freescale.net>
Sender: cpufreq-owner@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Mark Langsdorf <mark.langsdorf@calxeda.com>, AnilKumar Ch <anilkumar@ti.com>, Tony Lindgren <tony@atomide.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Magnus Damm <magnus.damm@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Sat, 23 Mar 2013, Shawn Guo wrote:

> On Fri, Mar 22, 2013 at 04:47:17PM +0100, Guennadi Liakhovetski wrote:

[snip]

> > Secondly you still run a danger, that 
> > several platforms, built into a single image, register several devices for 
> > different cpufreq drivers, or even for one... With a special call you know 
> > there can be only one and you return -EBUSY to all further calls to that 
> > function.
> 
> I do not see how this could happen.  The cpufreq device gets added in
> target specific init function which will only be invoked when the kernel
> is running on this target.  Check arch/arm/mach-imx/mach-imx6q.c or the
> OMAP example given by Nishanth to see how this should be done.

Sorry, I meant buggy implementations, where an initcall is added without 
checking, whether it's running on supported hardware.

Already before your patch for cpufreq-cpu0 to instantiate "mistakenly" on 
unsupported hardware you had to have an "operating-points" property in 
your "cpus" node, and you needed a clock attached to your cpu0 device. Do 
you really think this was likely?

Anyway, I do find this an overkill and an abuse, but I'm not going to 
fight over it. If I'm the only one with this impression - no problem, just 
forget my ranting :)

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
