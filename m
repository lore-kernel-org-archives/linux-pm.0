From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/1] cpufreq: pcc-cpufreq: Re-introduce deadband effect
 to reduce number of frequency changes
Date: Wed, 5 Oct 2016 10:47:53 +0530
Message-ID: <20161005051753.GK4664@vireshk-i7>
References: <20160819121814.GA17296@suselix.suse.de>
 <20160819122101.GB17296@suselix.suse.de>
 <20160829060153.GA5094@vireshk-i7>
 <20160901132140.GA10183@suselix.suse.de>
 <20160907050201.GK27345@vireshk-i7>
 <20160914145643.GA19982@suselix.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160914145643.GA19982@suselix.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Andreas Herrmann <aherrmann@suse.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Stratos Karafotis <stratosk@semaphore.gr>, Thomas Renninger <trenn@suse.com>
List-Id: linux-pm@vger.kernel.org

Sorry for being late Andreas :(

On 14-09-16, 16:56, Andreas Herrmann wrote:

First of all, thanks for your hardwork in getting these numbers out.
Really appreciate it.

> Below is some trace data. I hope it is of some help.
> 
> (A) - sampling 10s period when system is idle
> (B) - sampling 10s period when system partially loaded (kernel
>       compilation using 2 jobs)
> 
> (1) 4.8-rc5
> (2) 4.8-rc5 with my patch (reintro of deadband effect within
>     pcc-cpufreq)
> (3) 4.8-rc5 with reversal of 6393d6a102 (cpufreq: ondemand: Eliminate
>     the deadband effect)
> 
> Let me know whether you are looking for other trace data wrt this
> issue.
> 
> 
> Thanks,
> 
> Andreas
> 
> ---
> 
> (A)-(1)
> 
>  # Total Lost Samples: 0
>  # Samples: 41  of event 'power:cpu_frequency'
>  # Event count (approx.): 41
>  # Overhead  Command       Shared Object     Symbol                       
>  # ........  ............  ................  .............................
>      39.02%  kworker/14:1  [kernel.vmlinux]  [k] cpufreq_notify_transition
>      29.27%  kworker/0:0   [kernel.vmlinux]  [k] cpufreq_notify_transition
>      19.51%  kworker/10:1  [kernel.vmlinux]  [k] cpufreq_notify_transition
>       7.32%  kworker/5:2   [kernel.vmlinux]  [k] cpufreq_notify_transition
>       2.44%  kworker/23:2  [kernel.vmlinux]  [k] cpufreq_notify_transition
>       2.44%  kworker/40:1  [kernel.vmlinux]  [k] cpufreq_notify_transition
> 
> (A)-(2)
> 
>  # Total Lost Samples: 0
>  # Samples: 6  of event 'power:cpu_frequency'
>  # Event count (approx.): 6
>  # Overhead  Command       Shared Object     Symbol                       
>  # ........  ............  ................  .............................
>      33.33%  kworker/1:2   [kernel.vmlinux]  [k] cpufreq_notify_transition
>      16.67%  kworker/16:1  [kernel.vmlinux]  [k] cpufreq_notify_transition
>      16.67%  kworker/22:1  [kernel.vmlinux]  [k] cpufreq_notify_transition
>      16.67%  kworker/26:1  [kernel.vmlinux]  [k] cpufreq_notify_transition
>      16.67%  kworker/33:1  [kernel.vmlinux]  [k] cpufreq_notify_transition
> 
> (A)-(3)
> 
>  # Total Lost Samples: 0
>  # Samples: 7  of event 'power:cpu_frequency'
>  # Event count (approx.): 7
>  # Overhead  Command       Shared Object     Symbol                       
>  # ........  ............  ................  .............................
>      28.57%  kworker/58:1  [kernel.vmlinux]  [k] cpufreq_notify_transition
>      14.29%  kworker/19:2  [kernel.vmlinux]  [k] cpufreq_notify_transition
>      14.29%  kworker/20:2  [kernel.vmlinux]  [k] cpufreq_notify_transition
>      14.29%  kworker/22:2  [kernel.vmlinux]  [k] cpufreq_notify_transition
>      14.29%  kworker/23:1  [kernel.vmlinux]  [k] cpufreq_notify_transition
>      14.29%  kworker/35:1  [kernel.vmlinux]  [k] cpufreq_notify_transition
> 
> ---
> 
> (B)-(1)
> 
>  # Total Lost Samples: 0
>  # Samples: 2K of event 'power:cpu_frequency'
>  # Event count (approx.): 2382
>  # Overhead  Command       Shared Object     Symbol                       
>  # ........  ............  ................  .............................
>       5.75%  kworker/0:0   [kernel.vmlinux]  [k] cpufreq_notify_transition
>       4.16%  kworker/12:2  [kernel.vmlinux]  [k] cpufreq_notify_transition
>       3.11%  kworker/17:1  [kernel.vmlinux]  [k] cpufreq_notify_transition
>       2.94%  kworker/2:1   [kernel.vmlinux]  [k] cpufreq_notify_transition
>       2.73%  kworker/19:1  [kernel.vmlinux]  [k] cpufreq_notify_transition
>       ...
> 
> (B)-(2)
> 
>  # Total Lost Samples: 0
>  # Samples: 320  of event 'power:cpu_frequency'
>  # Event count (approx.): 320
>  # Overhead  Command       Shared Object     Symbol                       
>  # ........  ............  ................  .............................
>       4.69%  kworker/56:1  [kernel.vmlinux]  [k] cpufreq_notify_transition
>       4.06%  kworker/12:1  [kernel.vmlinux]  [k] cpufreq_notify_transition
>       4.06%  kworker/28:1  [kernel.vmlinux]  [k] cpufreq_notify_transition
>       4.06%  kworker/6:2   [kernel.vmlinux]  [k] cpufreq_notify_transition
>       3.75%  kworker/32:2  [kernel.vmlinux]  [k] cpufreq_notify_transition
>       ...
> 
> (B)-(3)
> 
>  # Total Lost Samples: 0
>  # Samples: 333  of event 'power:cpu_frequency'
>  # Event count (approx.): 333
>  # Overhead  Command       Shared Object     Symbol                       
>  # ........  ............  ................  .............................
>       4.80%  kworker/51:1  [kernel.vmlinux]  [k] cpufreq_notify_transition
>       4.50%  kworker/39:1  [kernel.vmlinux]  [k] cpufreq_notify_transition
>       4.20%  kworker/47:1  [kernel.vmlinux]  [k] cpufreq_notify_transition
>       3.90%  kworker/59:1  [kernel.vmlinux]  [k] cpufreq_notify_transition
>       3.90%  kworker/7:2   [kernel.vmlinux]  [k] cpufreq_notify_transition
>       ...

I am worried by all of these.. So, its not the DVFS transition which
took time, but cpufreq_notify_transition(). And probably one of the
drivers in your setup is screwing up here, which has registered with
cpufreq_register_notifier().

Can you please take a look at that ? Just check which all routines are
getting called as part of srcu_notifier_call_chain().

Also a simple (hacky) solution to fix the problem you have got is to
divide the range of frequency in steps (which you have already done
AFAICT in one of your patches) and not mention the frequencies that
were part of the deadband earlier. That will keep the CPU at either
low freq or some higher freqs.

But I am quite sure that we have an abuser here and we better find it
now.

-- 
viresh
