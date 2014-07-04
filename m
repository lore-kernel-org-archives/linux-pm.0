From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH 2/8] cpufreq: add driver for Armada XP
Date: Fri, 4 Jul 2014 13:12:47 +0200
Message-ID: <20140704131247.2c8ecde2@free-electrons.com>
References: <1404467103-29644-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<1404467103-29644-3-git-send-email-thomas.petazzoni@free-electrons.com>
	<CAKohponuvPd1kWDdB66kxd8TxxYqQ219jCq2D2RGhMHAuZTSWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:57759 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752859AbaGDLMv (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 4 Jul 2014 07:12:51 -0400
In-Reply-To: <CAKohponuvPd1kWDdB66kxd8TxxYqQ219jCq2D2RGhMHAuZTSWA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Mike Turquette <mturquette@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory Clement <gregory.clement@free-electrons.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Lior Amsalem <alior@marvell.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

Dear Viresh Kumar,

Thanks for your feedback!

On Fri, 4 Jul 2014 15:25:35 +0530, Viresh Kumar wrote:
> On 4 July 2014 15:14, Thomas Petazzoni
> <thomas.petazzoni@free-electrons.com> wrote:
> > This commit adds a simple cpufreq driver for the Armada XP SoC, which
> > has one separately controllable clock for each CPU. For this reason,
> > the existing cpufreq-cpu0 generic driver cannot be used because it
> > currently assumes that there is only one clock controlling the
> > frequency of all CPUs.
> >
> > There are on-going discussions on extending the cpufreq-cpu0 to cover
> > the case of having one clock for each CPU, but there are still some
> > unresolved issues to get this extended cpufreq-cpu0 driver merged.
> 
> Exactly, and those changes would get merged in one form or the other.
> Surely in 3.17 atleast, if not 3.16 as we are already reaching rc4..
> 
> So, it would be great if you can test on top of those changes to see if
> something isn't solved for your platform yet?
> 
> git://git.linaro.org/people/viresh.kumar/linux.git cpufreq/cpu0-krait-v3

One other problem with cpufreq-cpu0 is that it assumes the Device Tree
can contain a static OPP table, with the frequency/voltage points.
Unfortunately, in the case of the Armada XP platform, this is not
possible, because we cannot hardcode into the Device Tree the possible
CPU frequencies.

The nominal CPU frequency is selected by Sample on Reset pins (i.e pins
of the CPUs that are sampled during the reset sequence) and can
therefore change from one board to the other, and they can also be
changed via special U-Boot commands. And the frequencies supported by
cpufreq are the nominal frequency of the CPU as determined by the
sample at reset pins, and half of this frequency.

That's why the proposed armadaxp-cpufreq driver does not hardcode the
possible frequencies, but instead creates the frequency table by using
the current CPU frequency (nominal frequency) and half of it.

This doesn't work very well with the idea of having the OPP table
statically encoded in to the Device Tree. Options are:

 - Improve the cpufreq-cpu0 driver so that the OPP table can be passed
   through platform_data, and therefore built dynamically by the
   platform code and passed when registering the cpufreq
   platform_device.

 - Dynamically build/update the OPP table in the Device Tree.

Which option do you think is appropriate here?

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
