From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v2] cpufreq: instantiate cpufreq-cpu0 as a platform_driver
Date: Sat, 23 Mar 2013 14:32:17 +0800
Message-ID: <20130323063215.GF6281@S2101-09.ap.freescale.net>
References: <1359428020-21068-1-git-send-email-shawn.guo@linaro.org>
 <Pine.LNX.4.64.1303221600060.12375@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <cpufreq-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1303221600060.12375@axis700.grange>
Sender: cpufreq-owner@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Mark Langsdorf <mark.langsdorf@calxeda.com>, AnilKumar Ch <anilkumar@ti.com>, Tony Lindgren <tony@atomide.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Magnus Damm <magnus.damm@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Fri, Mar 22, 2013 at 04:47:17PM +0100, Guennadi Liakhovetski wrote:
> Sorry, confused. Before this used to be a generic cpufreq driver, usable 
> on all (DT-enabled only) platforms. You just had to provide an OPP table, 
> a clock, a regulator, similar to this
> 
> http://thread.gmane.org/gmane.linux.kernel.cpufreq/9510/focus=9509
> 
> (also see the complete thread for more information). Now this won't work 
> obviously. Instead we now need a pseudo platform device to instantiate 
> cpufreq-cpu0. This device cannot be put in DT, because it doesn't describe 
> real hardware. So, we have to add register it from the board specific .c 
> code, which we actually want to get rid of... Is this really what we want?
> 
Yes, that's what we want.  We are moving to multiplatform build, and we
do not want the driver get instantiated on very single platform that is
part of multiplatform.  Some of them may not support cpufreq at all and
others may have operating-points defined in device tree but need to work
with platform specific cpufreq driver.

In an ideal DT world, there shouldn't be any board specific .c code but
only SoC specific code.  Whether or not support cpufreq is a SoC
specific decision, and it's perfectly fine to make the decision in SoC
specific code.

> What about other cpufreq drivers? They have the same problem on 
> multiplatform builds, right? Say, s3c2416-cpufreq.c. It also just 
> initialises itself and starts looking for a clock, names "msysclk" with a 
> NULL device pointer etc. Don't we need a common approach for cpufreq 
> driver initialisation?
> 
The s3c2416 is not part of multiplatform build yet.  And any platform
that wants to be part of multiplatform build needs to fix those global
initcalls.  Two approaches are being used to do that.

- Call of_machine_is_compatible() to check target platform at the
  beginning of the initcall, and return immediately if it's not the
  target platform.  See drivers/cpufreq/highbank-cpufreq.c for example.

- Remove global initcalls and use platform_device/driver mechanism for
  instantiation.  See drivers/cpufreq/imx6q-cpufreq.c for example.

I like the second one which is more scalable, and choose to use it for
cpufreq-cpu0 driver.

> The decision which cpufreq driver to use is SoC-specific, right? We're 
> unlikely to have several boards, using the same SoC, wishing to use 
> different cpufreq drivers? The decision _whether_ or not to enable it and 
> _which_ resources to use might be board-specific. So, how about adding a 
> cpufreq call something like
> 
> cpufreq_driver_request("cpufreq-driver-name");
> 
> to be called by SoC-specific code. You can say it is not much different 
> from adding a virtual device, but firstly I think such a use of a platform 
> device is really an overkill.

I do not see why this is an overkill.  It's pretty common to use the
approach for instantiating particular driver on particular target.

> Secondly you still run a danger, that 
> several platforms, built into a single image, register several devices for 
> different cpufreq drivers, or even for one... With a special call you know 
> there can be only one and you return -EBUSY to all further calls to that 
> function.

I do not see how this could happen.  The cpufreq device gets added in
target specific init function which will only be invoked when the kernel
is running on this target.  Check arch/arm/mach-imx/mach-imx6q.c or the
OMAP example given by Nishanth to see how this should be done.

Shawn

