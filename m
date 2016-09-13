From: Andreas Herrmann <aherrmann@suse.com>
Subject: Re: [PATCH 1/1] cpufreq: pcc-cpufreq: Re-introduce deadband effect
 to reduce number of frequency changes
Date: Tue, 13 Sep 2016 12:53:35 +0200
Message-ID: <20160913105335.GA25602@suselix>
References: <20160819121814.GA17296@suselix.suse.de>
 <20160819122101.GB17296@suselix.suse.de>
 <20160829060153.GA5094@vireshk-i7>
 <20160901132140.GA10183@suselix.suse.de>
 <20160907050201.GK27345@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:35619 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751433AbcIMKx7 (ORCPT
        <rfc822;groupwise-linux-pm@vger.kernel.org:0:0>);
        Tue, 13 Sep 2016 06:53:59 -0400
Content-Disposition: inline
In-Reply-To: <20160907050201.GK27345@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Stratos Karafotis <stratosk@semaphore.gr>, Thomas Renninger <trenn@suse.com>

On Wed, Sep 07, 2016 at 10:32:01AM +0530, Viresh Kumar wrote:
> On 01-09-16, 15:21, Andreas Herrmann wrote:
> > On Mon, Aug 29, 2016 at 11:31:53AM +0530, Viresh Kumar wrote:
> 
> > > I am _really_ worried about such hacks in drivers to negate the effect of a
> > > patch, that was actually good.
> > 
> > > Did you try to increase the sampling period of ondemand governor to see if that
> > > helps without this patch.
> > 
> > With an older kernel I've modified transition_latency of the driver
> > which in turn is used to calculate the sampling rate.
> 
> Naah, that isn't what I was looking for, sorry :(
> 
> To explain it a bit more, this is what the patch did.
> 
> Suppose, your platform supports frequencies: F1 (lowest), F2, F3, F4,
> F5, F6 and F7 (highest). The cpufreq governor (ondemand) based on a
> sampling rate and system load tries to change the frequency of the
> underlying hardware and select one of those.
> 
> Before the original patch came in, F2 and F3 were never getting
> selected and the system was stuck in F1 for a long time. Which will
> decrease the performance for that period of time as we should have
> switched to a higher frequency really.
> 
> With the new patch we switch to the frequency proportional to current
> load.
> 
> The requests made from cpufreq-governor wouldn't have changed at all
> with that, but the number of freq changes at hardware level may
> actually change as we might be returning very quickly if the target
> freq evaluated to F1 in the earlier case.
> 
> That may lead to switching to frequencies F2 and F3, which wasn't
> happening earlier.
> 
> I don't think the result of that should be too bad.. We should have
> performed better almost everywhere.
> 
> transition_latency is used only to initialize sampling rate, but that
> may get modified from userspace later on. Please tell us the value
> read from sysfs file sampling_rate present in:
> 
> /sys/devices/system/cpu/cpufreq/policy0/ondemand/

/sys/devices/system/cpu/cpufreq/ondemand contains following values:

ignore_nice_load           : 0
io_is_busy                 : 1
min_sampling_rate          : 10000
powersave_bias             : 0
up_threshold               : 95
sampling_rate              : 10000
sampling_down_factor       : 1

FYI, for each CPU direcories /sys/devices/system/cpu/cpufreq/policy* look like:

scaling_cur_freq           : 1200000
cpuinfo_max_freq           : 2800000
cpuinfo_transition_latency : 0
cpuinfo_min_freq           : 1200000
cpuinfo_cur_freq           : 1204000
affected_cpus              : 0
scaling_governor           : ondemand
scaling_driver             : pcc-cpufreq
scaling_max_freq           : 2800000
related_cpus               : 0
scaling_setspeed           : <unsupported>
scaling_available_governors: ondemand performance 
scaling_min_freq           : 1200000

(which is for policy0 for CPU0)

> And try playing with that variable a bit to see if you can make things
> better or not.

Done that. Following the elapsed time with ondemand governor and
different values for sampling rate (for each of 4.8-rc5
vanilla/modified with my patch/commit 6393d6a reverted).

4.8-rc5 (vanilla)
                                                 sample_rate
           10000            20000            30000            45000            60000            90000
jobs  seconds  % CPU   seconds  % CPU   seconds  % CPU   seconds  % CPU   seconds  % CPU   seconds  % CPU
2     283.47   203.00  273.79   204.00  276.08   204.00  276.99   204.00  281.80   203.60  291.00   203.00 
4     146.92   399.20  140.98   399.80  141.55   399.80  140.91   400.00  142.91   400.00  146.49   399.80 
8      81.66   770.00   77.44   769.20   76.81   769.20   73.74   769.20   73.17   767.20   72.75   767.00 
16     54.31  1466.20   49.58  1458.40   48.37  1456.60   44.29  1447.80   42.89  1436.40   41.12  1416.80
32     36.71  2720.60   30.70  2672.80   29.22  2578.80   26.34  2563.20   25.57  2506.80   24.58  2457.80
64     13.99  3291.20   13.63  3295.40   13.55  3309.20   13.30  3354.60   13.66  3264.40   13.55  3288.60
120    14.84  3114.20   14.10  3215.00   14.57  3115.20   14.11  3209.80   14.17  3198.60   14.09  3220.80
------------------------------
4.8-rc5 re-intro deadband for pcc-cpufreq only (my patch)
                                                 sample_rate
           10000            20000            30000            45000            60000            90000
jobs  seconds  % CPU   seconds  % CPU   seconds  % CPU   seconds  % CPU   seconds  % CPU   seconds  % CPU
2     270.88   192.00  270.87   192.80  270.65   192.00  274.08   192.00  277.97   192.80  289.85   193.00 
4     140.23   379.20  138.94   379.80  138.20   378.80  138.99   379.20  140.81   379.60  145.83   380.40 
8      76.15   738.20   73.86   733.60   71.58   734.20   70.43   730.40   70.32   730.60   71.14   728.20 
16     47.39  1414.80   44.20  1395.60   43.02  1384.60   41.09  1368.00   40.37  1362.80   39.56  1351.20
32     32.78  2659.80   29.05  2531.80   27.18  2482.40   25.36  2471.60   24.55  2441.00   24.18  2365.80
64     13.34  3213.20   13.29  3204.60   13.38  3158.60   13.30  3162.40   13.57  3089.60   13.48  3125.20
120    13.89  3103.00   14.00  3047.40   13.87  3068.40   13.83  3077.80   13.93  3054.80   14.10  3033.60
------------------------------
4.8-rc5 reverted commit 6393d6a
                                                 sample_rate
           10000            20000            30000            45000            60000            90000
jobs  seconds  % CPU   seconds  % CPU   seconds  % CPU   seconds  % CPU   seconds  % CPU   seconds  % CPU
2     250.94   205.00  256.26   205.00  261.29   205.00  268.92   205.00  275.60   204.80  288.64   204.00 
4     127.20   401.20  129.63   401.80  131.80   402.00  135.41   401.20  138.88   401.20  144.96   401.00 
8      64.24   767.60   64.18   769.60   64.49   770.20   65.69   766.00   66.38   768.60   68.64   767.40 
16     37.02  1438.00   36.09  1432.20   36.10  1429.40   36.10  1424.60   36.61  1408.80   36.87  1405.60
32     24.73  2618.80   23.28  2533.80   23.00  2513.40   22.45  2526.00   22.92  2463.00   23.12  2422.20
64     12.62  3550.60   12.94  3439.60   12.95  3425.60   12.94  3421.80   13.29  3336.80   13.65  3257.80
120    13.30  3408.80   13.43  3346.40   13.44  3347.80   13.55  3322.60   13.76  3277.20   14.19  3192.40

> > I started with the value return as "nominal latency" for PCC.  This
> > was 300000 ns on the test system and made things worse.  I've tested
> > other values as well unitl I've found a local optimium at 45000ns but
> > performance was lower in comparison to when I've applied my hack.
> 
> Can you try to use kernel tracer (ftrace) and see how the frequencies
> are getting changed and at what frequency.

I am currently looking into this ...

> We need to understand the problem better, as I am not 100% sure what's
> going on right now.

... to gather related data.

> > > Also, it is important to understand why is the performance going
> > > down, while the original commit should have made it better.
> > 
> > My understanding is that the original commit was tested with certain
> > combinations of hardware and cpufreq-drivers and the claim was that
> > for those (two?) tested combinations performance increased and power
> > consumption was lower. So I am not so sure what to expect from all
> > other cpufreq-driver/hardware combinations.
> 
> It was principally the right thing to do IMO. And I don't think any
> other hardware should get affected badly. At the max, the tuning needs
> to be made a bit better.
> 
> > > Is it only about more transitions ?
> > 
> > I think this is the main issue.
> 
> Then it can be controlled with sampling rate from userspace.
> 
> > In an older kernel version I activated/added debug output in
> > __cpufreq_driver_target(). Of course this creates a huge amount of
> > messages. But with original patch reverted it was like:
> > 
> > [   29.489677] cpufreq: target for CPU 0: 1760000 kHz (1200000 kHz), relation 2, requested 1760000 kHz
> > [   29.570364] cpufreq: target for CPU 0: 1216000 kHz (1760000 kHz), relation 2, requested 1216000 kHz
> > [   29.571055] cpufreq: target for CPU 1: 1200000 kHz (1148000 kHz), relation 0, requested 1200000 kHz
> > [   29.571483] cpufreq: target for CPU 1: 1200000 kHz (1200000 kHz), relation 2, requested 1200000 kHz
> > [   29.572042] cpufreq: target for CPU 2: 1200000 kHz (1064000 kHz), relation 0, requested 1200000 kHz
> > [   29.572503] cpufreq: target for CPU 2: 1200000 kHz (1200000 kHz), relation 2, requested 1200000 kHz
> 
> Your platform is a bit special as it uses ->target() callback and not
> ->target_index(). And so you can pretty much switch to any frequency.
> 
> Can you please read value of all the sysfs files present in the
> governor directory? That would be helpful. Maybe we can play with some
> more files like: up_threshold to see what the results are.

For sysfs values see above. I've not yet played with up_threshold but
plan to do this as well.

> > a lot of stuff, but system could still handle it and booted to the
> > prompt.
> > 
> > With the original patch applied the system was really flooded and
> > eventually became unresponsive:
> > 
> > ** 459 printk messages dropped ** [   29.838689] cpufreq: target for CPU 43: 1408000 kHz (2384000 kHz), relation 2, requested 1408000 kHz
> > ** 480 printk messages dropped ** [   29.993849] cpufreq: target for CPU 54: 1200000 kHz (1248000 kHz), relation 2, requested 1200000 kHz
> > ** 413 printk messages dropped ** [   30.113921] cpufreq: target for CPU 59: 2064000 kHz (1248000 kHz), relation 2, requested 2064000 kHz
> > ** 437 printk messages dropped ** [   30.245846] cpufreq: target for CPU 21: 1296000 kHz (1296000 kHz), relation 2, requested 1296000 kHz
> > ** 435 printk messages dropped ** [   30.397748] cpufreq: target for CPU 13: 1280000 kHz (2640000 kHz), relation 2, requested 1280000 kHz
> > ** 480 printk messages dropped ** [   30.541846] cpufreq: target for CPU 58: 2112000 kHz (1632000 kHz), relation 2, requested 2112000 kHz
> 
> This looks even more dangerous :)
> 
> -- 
> viresh


Thanks,

Andreas
