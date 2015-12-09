From: Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH] cpufreq: tegra: add regulator dependency for T124
Date: Wed, 9 Dec 2015 17:33:33 +0000
Message-ID: <566865ED.3020106@nvidia.com>
References: <2194927.eV2s2QmZs0@wuerfel> <5668188F.2080202@nvidia.com>
 <20151209144734.GB5727@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate16.nvidia.com ([216.228.121.65]:10792 "EHLO
	hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752703AbbLIRdk (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 9 Dec 2015 12:33:40 -0500
In-Reply-To: <20151209144734.GB5727@sirena.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Liam Girdwood <lgirdwood@gmail.com>


On 09/12/15 14:47, Mark Brown wrote:
> * PGP Signed by an unknown key
> 
> On Wed, Dec 09, 2015 at 12:03:27PM +0000, Jon Hunter wrote:
>> On 08/12/15 21:52, Arnd Bergmann wrote:
> 
>>> My first attempt was to implement a helper for this function
>>> for regulator_sync_voltage, but Mark Brown explained:
> 
>>>    We don't do this for *all* regulator API functions - there's some where
>>>    using them strongly suggests that there is actually a dependency on
>>>    the regulator API.  This does seem like it might be falling into the
>>>    specialist category [...]
>>>    Looking at the code I'm pretty unclear on what the authors think the
>>>    use of _sync_voltage() is doing in the first place so it may be even
>>>    better to just remove the call.  It seems to have been included in the
>>>    first commit so there's not changelog explaining things and there's
>>>    no comment either.  I'd *expect* it to be a noop as far as I can see.
> 
>> In this sequence we are switching from the DFLL clock source (which
>> directly controls the voltage) back to a PLL (which does not control the
>> voltage directly). What we want to do is to restore the voltage back to
>> the voltage it was operating at before we switched to the DFLL clock
>> (which could have changed it).
> 
> If changes implemented by the clock driver are trashing the regulator
> settings I would expect the clock driver to be responsible for fixing
> things up rather than another driver that happens to use the clock.  I'd
> also expect some kind of internal documentation explaining what's going
> on, and possibly 

Yes, the DFLL clock driver could restore the voltage, however, that
does not guarantee that the voltage is still sufficient for the other
clock source.

>> I am not familiar with regulator_sync_voltage() but from the comment it
>> does say that it will re-apply the last voltage that was configured for
>> the regulator. So I can see what they were doing. The question I have
>> is, if the consumer has not explicitly called regulator_set_voltage()
>> then what does regulator_sync_voltage() do? I am wondering if we should
>> have been doing a regulator_get_voltage() during the probe and a
>> regulator_set_voltage() when switching back?
> 
> This *is* the sort of thing _sync() is intended for, though it's mainly
> expected to be used in cases like suspend where things have been powered
> off.  As you can see from the code it's based on the settings that
> software made, but then if nothing in software has any need to configure
> anything then why do we even care that the hardware changed anything?

Yes, that's my point. When switching between these clock sources, I
think that software does need to set something and so we should care.

> Setting the voltage you've read back sounds broken, if the hardware
> might randomly change things how do you know the settings we read were
> sane?  Shouldn't we know what voltage range the device requires in a
> given mode and set that - that's much more normal?

The hardware will not randomly change the voltage until the DFLL is
enabled and so you would have to do this before.

Yes, setting the frequency and voltage as defined by a given operating
mode would make sense. However, I am not sure we have those defined in
the kernel for this PLL and would have to be added.

I was thinking that during boot we could read the default voltage and
frequency set by the bootloader and use this as it should not be
changing dynamically at this point because the cpufreq driver has not
been activated yet.

Jon
