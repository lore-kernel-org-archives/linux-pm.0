From: Paul Walmsley <paul@pwsan.com>
Subject: Re: omap cpufreq driver in multi-platform kernels
Date: Sat, 30 Mar 2013 22:21:40 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1303302156180.6436@utopia.booyaka.com>
References: <5152503C.2050503@gmail.com> <alpine.DEB.2.00.1303270212110.8161@utopia.booyaka.com> <20130327133220.GA30868@kahuna> <5153207A.4050109@gmail.com> <20130327170221.GA32231@kahuna> <87d2uk91ai.fsf@linaro.org> <20130327175621.GA32693@kahuna>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:35422 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753951Ab3C3WVl (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 30 Mar 2013 18:21:41 -0400
In-Reply-To: <20130327175621.GA32693@kahuna>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Nishanth Menon <nm@ti.com>, Kevin Hilman <khilman@linaro.org>, Mark Langsdorf <mark.langsdorf@calxeda.com>, Shawn Guo <shawn.guo@linaro.org>, Rob Herring <robherring2@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-pm@vger.kernel.org

Hi folks,

On Wed, 27 Mar 2013, Nishanth Menon wrote:

> On 10:53-20130327, Kevin Hilman wrote:
> > Nishanth Menon <nm@ti.com> writes:
> > > On 11:38-20130327, Rob Herring wrote:
> > >> On 03/27/2013 08:32 AM, Nishanth Menon wrote:
> > >> > On 02:23-20130327, Paul Walmsley wrote:
> > >> >> On Tue, 26 Mar 2013, Rob Herring wrote:
> > >> >>>
> > >> >>> Converting the driver to a platform driver would be another option.
> > 
> > I think the platform_device conversion is the way to go.  I think you
> > should do that instead of PATCH 8/8 of your OMAP conversion to the
> > generic driver[1].
>
> Yep, thinking about this over lunch, I came to the same conclusion that
> instead of checking on DT node existance, platform_device conversion
> will solve both parts of the puzzle.

Looked at this a little today.  I see that the platform_driver CPUFreq 
driver approach was taken with several SoCs in mainline. Could someone 
explain the theory behind making the CPUFreq drivers platform_drivers, 
rather than just modules?

The part that doesn't make sense to me is that the existing CPUFreq 
drivers don't represent an actual hardware block.  Conceptually, they 
aren't drivers for the CPU, nor are they drivers for a CPU frequency 
scaling IP block.  One might as well bind a CPUIdle driver or a CPU 
throttling thermal driver to the CPU device.

Wouldn't it be best to just make them modules?

Also, noticed that the Highbank CPUFreq driver creates a virtual device in 
its code.  That also doesn't seem right.  Isn't device creation better 
left to DT/ACPI/whatever?


regards,

- Paul
