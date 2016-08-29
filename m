From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/1] cpufreq: pcc-cpufreq: Re-introduce deadband effect
 to reduce number of frequency changes
Date: Mon, 29 Aug 2016 11:31:53 +0530
Message-ID: <20160829060153.GA5094@vireshk-i7>
References: <20160819121814.GA17296@suselix.suse.de>
 <20160819122101.GB17296@suselix.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160819122101.GB17296@suselix.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Andreas Herrmann <aherrmann@suse.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Stratos Karafotis <stratosk@semaphore.gr>, Thomas Renninger <trenn@suse.com>
List-Id: linux-pm@vger.kernel.org

On 19-08-16, 14:21, Andreas Herrmann wrote:
> 
> Commit 6393d6a102 (cpufreq: ondemand: Eliminate the deadband effect)
> introduced a performance regression for systems using pcc-cpufreq and
> ondemand governor. This is measurable with different workloads. E.g.
> wall-clock time for kernel compilation significantly increased.
> 
> The elimination of the deadband effect significantly increased the
> number of frequency changes with pcc-cpufreq.
> 
> Instead of reverting commit 6393d6a102 I suggest to add a workaround
> in pcc-cpufreq to re-introduce the deadband effect for this driver
> only - to restore the old performance behaviour with pcc-cpufreq with
> ondemand governor.
> 
> Following some performance numbers for similar kernel compilations to
> illustrate the effect of commit 6393d6a102 and the proposed fix.
> 
> Following typical numbers of kernel compilation tests with varying number of
> compile jobs:
> 
>                      v4.8.0-rc2               4.8.0-rc2-pcc-cpufreq-deadband
>  # of jobst   user     sys   elapsed   CPU     user     sys   elapsed   CPU
>        2     440.39  116.49  4:33.35   203%   404.85  109.10  4:10.35   205%
>        4     436.87  133.39  2:22.88   399%   381.83  128.00  2:06.84   401%
>        8     475.49  157.68  1:22.24   769%   344.36  149.08  1:04.29   767%
>       16     620.69  188.33  0:54.74  1477%   374.60  157.40  0:36.76  1447%
>       32     815.79  209.58  0:37.22  2754%   490.46  160.22  0:24.87  2616%
>       64     394.13   60.55  0:13.54  3355%   386.54   60.33  0:12.79  3493%
>      120     398.24   61.55  0:14.60  3148%   390.44   61.19  0:13.07  3453%
> 
> (HP ProLiant DL580 Gen8 system, 60 CPUs @ 2.80GHz)
> 
> Link: http://marc.info/?l=linux-pm&m=147160912625600
> Signed-off-by: Andreas Herrmann <aherrmann@suse.com>
> ---
>  drivers/cpufreq/pcc-cpufreq.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> If this change is accepted maybe it's a good idea to tag it also for
> stable kernels, e.g. starting with v4.4.

I am _really_ worried about such hacks in drivers to negate the effect of a
patch, that was actually good.

Did you try to increase the sampling period of ondemand governor to see if that
helps without this patch.

Also, it is important to understand why is the performance going down, while the
original commit should have made it better. Is it only about more transitions ?

-- 
viresh
