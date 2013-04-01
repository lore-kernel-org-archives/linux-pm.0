From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/9] CPUFreq Updates & Fixes for 3.10
Date: Mon, 01 Apr 2013 23:05:43 +0200
Message-ID: <1893788.IlN605kbG3@vostro.rjw.lan>
References: <cover.1364820620.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <cover.1364820620.git.viresh.kumar@linaro.org>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Monday, April 01, 2013 06:27:40 PM Viresh Kumar wrote:
> Hi Rafael,
> 
> These are fixes and updates that are sent and reviewed as separate patchsets
> earlier. They are all now combined as part of a single patchset for you to apply
> in your linux-next branch.
> 
> All have got reviews earlier and got fixups mailed and applied.
> 
> The remaining patches: "Move Cpufreq drivers to drivers/cpufreq" are awaiting
> few more Acks before I send them to you.
> 
> I wanted to have another patch as part of this patchset, but I am awaiting Ack
> for it:
> tools: cpufreq: Fix cpufreq-info print messages for affected[related]_cpus
> 
> That can be applied separately once it receives an Ack.
> 
> Thanks
> Viresh
> 
> Viresh Kumar (9):
>   cpufreq: cpu0: Fix mistake in Documentation example
>   cpufreq: Documentation: Fix cpufreq_frequency_table name
>   cpufreq: cpufreq-cpu0: No need to check cpu number in init()
>   cpufreq: cpufreq-cpu0: Call CPUFREQ_POSTCHANGE notifier for failure
>     cases too
>   cpufreq: Notify all policy->cpus in cpufreq_notify_transition()
>   cpufreq: Don't check if cpu is online/offline for cpufreq callbacks
>   cpufreq: drivers: don't check range of target freq in .target()
>   cpufreq: drivers: Remove unnecessary assignments of policy-> members
>   cpufreq: ARM big LITTLE: Add generic cpufreq driver and its DT glue

Thanks!

The [5/9] seems to be missing.  Care to send?

Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
