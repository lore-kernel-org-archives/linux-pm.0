From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: Delayed acpi frequency governor call
Date: Fri, 20 Jan 2017 15:37:25 +0530
Message-ID: <20170120100725.GO11478@vireshk-i7>
References: <c8ee7078-ad5a-0a23-66ae-620c507300e5@tik.ee.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f51.google.com ([74.125.83.51]:35702 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751575AbdATKPw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 20 Jan 2017 05:15:52 -0500
Received: by mail-pg0-f51.google.com with SMTP id 194so22677006pgd.2
        for <linux-pm@vger.kernel.org>; Fri, 20 Jan 2017 02:15:52 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <c8ee7078-ad5a-0a23-66ae-620c507300e5@tik.ee.ethz.ch>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Philipp Miedl <philipp.miedl@tik.ee.ethz.ch>
Cc: alex@digriz.org.uk, jun.nakajima@intel.com, venkatesh.pallipadi@intel.com, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

+ PM list.

On 20-01-17, 10:48, Philipp Miedl wrote:
> Hi!
> 
> I'm using the kernel version 4.4.0-59-generic and 4.4.0 with acpi cpufreq
> drivers (cpufrequtils 008) on a Lenovo T440p laptop. Now I've bumped into
> some weird behaviour:
> it can happen that the call to the governor is delayed for so long, that in
> the governor the if-statement in cpufreq_governor.c line 138
> is true, which means the governor thinks the cpu was idle. This can lead to
> the case that the frequency is still scaled up when it should in
> fact be scaled down.
> 
> Now I've written a small programm which ensures that the cpu is never idle
> for longer than 850us, but does not generate a cpu utilization higher
> than 5% - still the behaviour is the same. I've looked a bit closer at this
> and I figured out that if I increase the utilization of the observed CPU,
> at utilzations higher than 80% the maximum delay between two governor calls
> increases and can rise almost to 10x sampling rate
> (/sys/drivers/system/cpu/cpufreq/sampling_rate).
> Weirdly enough, after a long time (>1s) the average call time of the
> governor is always around the specified sampling rate.
> 
> I could not fully understand how the governor is call and this work queue
> works and therefore I also have a hard time making sense of this behaviour.
> Can anyone please help me out?

Have a look at below commit:

commit 00bfe05889e9 ("cpufreq: conservative: Decrease frequency faster
for deferred updates")

It may be related to what you are observing.

-- 
viresh
