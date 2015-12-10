From: Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH] cpufreq: tegra: add regulator dependency for T124
Date: Thu, 10 Dec 2015 10:07:54 +0000
Message-ID: <56694EFA.7010901@nvidia.com>
References: <2194927.eV2s2QmZs0@wuerfel> <5668188F.2080202@nvidia.com>
 <20151209144734.GB5727@sirena.org.uk> <566865ED.3020106@nvidia.com>
 <20151209201007.GG5727@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151209201007.GG5727@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: linux-pm@vger.kernel.org


On 09/12/15 20:10, Mark Brown wrote:
> * PGP Signed by an unknown key
> 
> On Wed, Dec 09, 2015 at 05:33:33PM +0000, Jon Hunter wrote:
>> On 09/12/15 14:47, Mark Brown wrote:
> 
>>> If changes implemented by the clock driver are trashing the regulator
>>> settings I would expect the clock driver to be responsible for fixing
>>> things up rather than another driver that happens to use the clock.  I'd
>>> also expect some kind of internal documentation explaining what's going
>>> on, and possibly 
> 
>> Yes, the DFLL clock driver could restore the voltage, however, that
>> does not guarantee that the voltage is still sufficient for the other
>> clock source.
> 
> But the code we've got won't do that either - it'l just set the voltage
> to whatever the last thing the regulator API had that might have been
> within its constraints.

Today yes, however, I meant that we *could* change it to restore the
previous voltage before the DFLL was enabled.

>>> Setting the voltage you've read back sounds broken, if the hardware
>>> might randomly change things how do you know the settings we read were
>>> sane?  Shouldn't we know what voltage range the device requires in a
>>> given mode and set that - that's much more normal?
> 
>> The hardware will not randomly change the voltage until the DFLL is
>> enabled and so you would have to do this before.
> 
> I'm not clear that there's even a guarantee that the kernel will ever
> have seen this configuration, consider for example what happens if
> someone uses kexec?

True. I have not played around with kexec, but with something like the
DFLL, we would need to make sure that this get disabled. Looks like the
reboot notifier gets called by kexec and so I guess that could be used
to disable the DFLL and switch back to the PLL.

>> Yes, setting the frequency and voltage as defined by a given operating
>> mode would make sense. However, I am not sure we have those defined in
>> the kernel for this PLL and would have to be added.
> 
> I think given how you're describing the hardware that this will be
> required in order to provide something robust (and also to get the best
> power savings from the hardware).

Yes I agree it would be more robust. However, if you care about power
savings then you should be using the DFLL/cpufreq anyway.

>> I was thinking that during boot we could read the default voltage and
>> frequency set by the bootloader and use this as it should not be
>> changing dynamically at this point because the cpufreq driver has not
>> been activated yet.
> 
> I'm a bit confused here, we're talking about a change to the cpufreq
> driver here aren't we?  Or alternatively why are we manipulating the
> clock tree like this if we don't yet have support for the hardware?

Yes, a change to the cpu-freq driver. When probing the cpufreq driver,
we can query the clock-source, clock frequency and voltage and save
this, so that if we ever disable the DFLL/cpufreq, we can switch back to
the initial configuration.

>From testing the t124 jetson and nyan-big, both of these boards have a
different configuration for the PLL at boot time, so although we could
pick a safe operating point for all t124 boards, I was thinking of just
restoring their initial configuration.

Jon
