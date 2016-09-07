From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/1] cpufreq: pcc-cpufreq: Re-introduce deadband effect
 to reduce number of frequency changes
Date: Wed, 7 Sep 2016 10:32:01 +0530
Message-ID: <20160907050201.GK27345@vireshk-i7>
References: <20160819121814.GA17296@suselix.suse.de>
 <20160819122101.GB17296@suselix.suse.de>
 <20160829060153.GA5094@vireshk-i7>
 <20160901132140.GA10183@suselix.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160901132140.GA10183@suselix.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Andreas Herrmann <aherrmann@suse.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Stratos Karafotis <stratosk@semaphore.gr>, Thomas Renninger <trenn@suse.com>
List-Id: linux-pm@vger.kernel.org

On 01-09-16, 15:21, Andreas Herrmann wrote:
> On Mon, Aug 29, 2016 at 11:31:53AM +0530, Viresh Kumar wrote:

> > I am _really_ worried about such hacks in drivers to negate the effect of a
> > patch, that was actually good.
> 
> > Did you try to increase the sampling period of ondemand governor to see if that
> > helps without this patch.
> 
> With an older kernel I've modified transition_latency of the driver
> which in turn is used to calculate the sampling rate.

Naah, that isn't what I was looking for, sorry :(

To explain it a bit more, this is what the patch did.

Suppose, your platform supports frequencies: F1 (lowest), F2, F3, F4,
F5, F6 and F7 (highest). The cpufreq governor (ondemand) based on a
sampling rate and system load tries to change the frequency of the
underlying hardware and select one of those.

Before the original patch came in, F2 and F3 were never getting
selected and the system was stuck in F1 for a long time. Which will
decrease the performance for that period of time as we should have
switched to a higher frequency really.

With the new patch we switch to the frequency proportional to current
load.

The requests made from cpufreq-governor wouldn't have changed at all
with that, but the number of freq changes at hardware level may
actually change as we might be returning very quickly if the target
freq evaluated to F1 in the earlier case.

That may lead to switching to frequencies F2 and F3, which wasn't
happening earlier.

I don't think the result of that should be too bad.. We should have
performed better almost everywhere.

transition_latency is used only to initialize sampling rate, but that
may get modified from userspace later on. Please tell us the value
read from sysfs file sampling_rate present in:

/sys/devices/system/cpu/cpufreq/policy0/ondemand/

And try playing with that variable a bit to see if you can make things
better or not.

> I started with the value return as "nominal latency" for PCC.  This
> was 300000 ns on the test system and made things worse.  I've tested
> other values as well unitl I've found a local optimium at 45000ns but
> performance was lower in comparison to when I've applied my hack.

Can you try to use kernel tracer (ftrace) and see how the frequencies
are getting changed and at what frequency.

We need to understand the problem better, as I am not 100% sure what's
going on right now.

> > Also, it is important to understand why is the performance going
> > down, while the original commit should have made it better.
> 
> My understanding is that the original commit was tested with certain
> combinations of hardware and cpufreq-drivers and the claim was that
> for those (two?) tested combinations performance increased and power
> consumption was lower. So I am not so sure what to expect from all
> other cpufreq-driver/hardware combinations.

It was principally the right thing to do IMO. And I don't think any
other hardware should get affected badly. At the max, the tuning needs
to be made a bit better.

> > Is it only about more transitions ?
> 
> I think this is the main issue.

Then it can be controlled with sampling rate from userspace.

> In an older kernel version I activated/added debug output in
> __cpufreq_driver_target(). Of course this creates a huge amount of
> messages. But with original patch reverted it was like:
> 
> [   29.489677] cpufreq: target for CPU 0: 1760000 kHz (1200000 kHz), relation 2, requested 1760000 kHz
> [   29.570364] cpufreq: target for CPU 0: 1216000 kHz (1760000 kHz), relation 2, requested 1216000 kHz
> [   29.571055] cpufreq: target for CPU 1: 1200000 kHz (1148000 kHz), relation 0, requested 1200000 kHz
> [   29.571483] cpufreq: target for CPU 1: 1200000 kHz (1200000 kHz), relation 2, requested 1200000 kHz
> [   29.572042] cpufreq: target for CPU 2: 1200000 kHz (1064000 kHz), relation 0, requested 1200000 kHz
> [   29.572503] cpufreq: target for CPU 2: 1200000 kHz (1200000 kHz), relation 2, requested 1200000 kHz

Your platform is a bit special as it uses ->target() callback and not
->target_index(). And so you can pretty much switch to any frequency.

Can you please read value of all the sysfs files present in the
governor directory? That would be helpful. Maybe we can play with some
more files like: up_threshold to see what the results are.

> a lot of stuff, but system could still handle it and booted to the
> prompt.
> 
> With the original patch applied the system was really flooded and
> eventually became unresponsive:
> 
> ** 459 printk messages dropped ** [   29.838689] cpufreq: target for CPU 43: 1408000 kHz (2384000 kHz), relation 2, requested 1408000 kHz
> ** 480 printk messages dropped ** [   29.993849] cpufreq: target for CPU 54: 1200000 kHz (1248000 kHz), relation 2, requested 1200000 kHz
> ** 413 printk messages dropped ** [   30.113921] cpufreq: target for CPU 59: 2064000 kHz (1248000 kHz), relation 2, requested 2064000 kHz
> ** 437 printk messages dropped ** [   30.245846] cpufreq: target for CPU 21: 1296000 kHz (1296000 kHz), relation 2, requested 1296000 kHz
> ** 435 printk messages dropped ** [   30.397748] cpufreq: target for CPU 13: 1280000 kHz (2640000 kHz), relation 2, requested 1280000 kHz
> ** 480 printk messages dropped ** [   30.541846] cpufreq: target for CPU 58: 2112000 kHz (1632000 kHz), relation 2, requested 2112000 kHz

This looks even more dangerous :)

-- 
viresh
