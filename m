From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: 4.14 regression - hang on shutdown (VIA longhaul related?)
Date: Mon, 27 Nov 2017 14:26:32 +0100
Message-ID: <CAJZ5v0h34pcz5Xpo-Yaj+Jnth7_GZ6G0gydAOR_hCPx-0h2-dw@mail.gmail.com>
References: <alpine.LRH.2.21.1711241741080.10361@math.ut.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f42.google.com ([209.85.218.42]:44376 "EHLO
        mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751867AbdK0N0d (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Nov 2017 08:26:33 -0500
In-Reply-To: <alpine.LRH.2.21.1711241741080.10361@math.ut.ee>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Meelis Roos <mroos@linux.ee>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel list <linux-kernel@vger.kernel.org>

Hi,

On Mon, Nov 27, 2017 at 11:53 AM, Meelis Roos <mroos@linux.ee> wrote:
> On my Via EPIA-M min-ITX computer, 4.13 works reliably but 4.14
> shutdown or reboot hangs with message "sda: synchronizing cache".
> Longhaul cpufreq has been enable manually with "longhaul.enable=1" and
> it work but ocassionally logs th efollowing in dmesg:
>
> longhaul: Warning: Timeout while waiting for idle PCI bus
> cpufreq: __target_index: Failed to change cpu frequency: -16
>
> It took time to bisect because with bad kernels, it does not happen each
> time. Bisecting finally leads to the following commit. Reverting just
> this commit makes it work again.
>
> e948bc8fbee077735c2b71b991a5ca5e573f3506 is the first bad commit
> commit e948bc8fbee077735c2b71b991a5ca5e573f3506
> Author: Viresh Kumar <viresh.kumar@linaro.org>
> Date:   Thu Aug 17 09:12:27 2017 +0530
>
>     cpufreq: Cap the default transition delay value to 10 ms
>
>     If transition_delay_us isn't defined by the cpufreq driver, the default
>     value of transition delay (time after which the cpufreq governor will
>     try updating the frequency again) is currently calculated by multiplying
>     transition_latency (nsec) with LATENCY_MULTIPLIER (1000) and then
>     converting this time to usec. That gives the exact same value as
>     transition_latency, just that the time unit is usec instead of nsec.
>
>     With acpi-cpufreq for example, transition_latency is set to around 10
>     usec and we get transition delay as 10 ms. Which seems to be a
>     reasonable amount of time to reevaluate the frequency again.
>
>     But for platforms where frequency switching isn't that fast (like ARM),
>     the transition_latency varies from 500 usec to 3 ms, and the transition
>     delay becomes 500 ms to 3 seconds. Of course, that is a pretty bad
>     default value to start with.
>
>     We can try to come across a better formula (instead of multiplying with
>     LATENCY_MULTIPLIER) to solve this problem, but will that be worth it ?
>
>     This patch tries a simple approach and caps the maximum value of default
>     transition delay to 10 ms. Of course, userspace can still come in and
>     change this value anytime or individual drivers can rather provide
>     transition_delay_us instead.
>
>     Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
>     Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> :040000 040000 7bb8dafb58b703b36fc43d3a081c1a4677a4afde 084c10fa24028461048bcf4b8be5360f36aedd05 M      drivers

Please try to replace the 10000 in
cpufreq_policy_transition_delay_us() with a greater number (say 20000
or 50000) and see if that helps.

Thanks,
Rafael
