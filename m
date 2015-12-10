From: Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH] cpufreq: tegra: add regulator dependency for T124
Date: Thu, 10 Dec 2015 12:12:11 +0000
Message-ID: <56696C1B.3010503@nvidia.com>
References: <2194927.eV2s2QmZs0@wuerfel> <5668188F.2080202@nvidia.com>
 <20151209144734.GB5727@sirena.org.uk> <566865ED.3020106@nvidia.com>
 <20151209201007.GG5727@sirena.org.uk> <56694EFA.7010901@nvidia.com>
 <20151210113541.GL5727@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate16.nvidia.com ([216.228.121.65]:8541 "EHLO
	hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751017AbbLJMMT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 10 Dec 2015 07:12:19 -0500
In-Reply-To: <20151210113541.GL5727@sirena.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Liam Girdwood <lgirdwood@gmail.com>


On 10/12/15 11:35, Mark Brown wrote:
> * PGP Signed by an unknown key
> 
> On Thu, Dec 10, 2015 at 10:07:54AM +0000, Jon Hunter wrote:
>> On 09/12/15 20:10, Mark Brown wrote:
>>> On Wed, Dec 09, 2015 at 05:33:33PM +0000, Jon Hunter wrote:
> 
>>>> Yes, setting the frequency and voltage as defined by a given operating
>>>> mode would make sense. However, I am not sure we have those defined in
>>>> the kernel for this PLL and would have to be added.
> 
>>> I think given how you're describing the hardware that this will be
>>> required in order to provide something robust (and also to get the best
>>> power savings from the hardware).
> 
>> Yes I agree it would be more robust. However, if you care about power
>> savings then you should be using the DFLL/cpufreq anyway.
> 
> Without knowing anything about the hardware this is all a bit confusing
> I'm afraid.  What is "DFLL/cpufreq" as opposed to "the PLL"?

No problem.

The two main clocks sources (there are others) used for the CPU complex
are the PLLX and the DFLL. The PLLX is a normal PLL and you can
configure to run at various frequencies. However, this PLL requires that
you/software set the voltage appropriately. The DFLL has the ability to
control the voltage itself per the frequency requested (no software
management of the voltage required).

There is no reason why you could not use the PLLX in conjunction with
cpufreq, but for T124 we use the DFLL.

Typically, T124 will boot using the PLLX and then if cpufreq is enabled,
the DFLL will be enabled and we will switch to this clock.

We would only ever switch back to the PLLX if cpufreq is removed and
hence the DFLL is disabled. And this is where this patch comes in and I
am wondering if this has ever been tested.

>> From testing the t124 jetson and nyan-big, both of these boards have a
>> different configuration for the PLL at boot time, so although we could
>> pick a safe operating point for all t124 boards, I was thinking of just
>> restoring their initial configuration.
> 
> This seems more complex, and also makes the idea of relying on the
> initial configuration seem slightly concerning - other software seems to
> be already changing the configuration before we get to the kernel so if
> we don't fully understand the configuration we're doing we seem likely
> to find some configuration where we miss things.

I don't think so. At probe time for cpufreq, we know the clock source
for the CPU complex and we can query the voltage and frequency. You may
say what happens if you are already running from the DFLL that happened
to be setup by the bootloader? It is probably not likely as there is
more software setup involved before you can enable the DFLL. However, it
could be handled.

By the way, I am not saying that we should do this, but if we don't we
need to define a safe/default V-F for all devices to operate at. I guess
that it could also be specified in the DTB and if not we use a default.

Jon
