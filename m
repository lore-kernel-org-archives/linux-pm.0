From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v7 0/6] cpufreq: powernv: Redesign the presentation of
 throttle notification and solve bug-fixes in the driver
Date: Thu, 28 Jan 2016 13:55:25 +0530
Message-ID: <20160128082525.GG3935@vireshk>
References: <1453965941-7363-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1453965941-7363-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org, pc@us.ibm.com, anton@samba.org, ego@linux.vnet.ibm.com, shreyas@linux.vnet.ibm.com, bsingharora@gmail.com, mpe@ellerman.id.au
List-Id: linux-pm@vger.kernel.org

On 28-01-16, 12:55, Shilpasri G Bhat wrote:
> In POWER8, OCC(On-Chip-Controller) can throttle the frequency of the
> CPU when the chip crosses its thermal and power limits. Currently,
> powernv-cpufreq driver detects and reports this event as a console
> message. Some machines may not sustain the max turbo frequency in all
> conditions and can be throttled frequently. This can lead to the
> flooding of console with throttle messages. So this patchset aims to
> redesign the presentation of this event via sysfs counters and
> tracepoints. And it also fixes couple of bugs reported in the driver.
> 
> - Patch [1] fixes a memory leak bug
> - Patch [2] fixes the cpu hot-plug bug in powernv_cpufreq_work_fn().
> - Patch [3] solves a bug in powernv_cpufreq_throttle_check(), which
>   calls in to cpu_to_chip_id() in hot path which reads DT every time
>   to find the chip id.
> - Patches [4] to [6] will add a perf trace point
>   "power:powernv_throttle" and sysfs throttle counter stats in
>   /sys/devices/system/cpu/cpufreq/chipN.
> 
> Changes from v6:
> - Changes wrt comments from Balbir Singh and Viresh Kumar.

Who cares about these names in version-log ?? You have completely
missed what should have been present here. This is version log and
that's what should be present here :)

And because of that, I have to
- search for your earlier version in my mailbox
- Read all my comments
- Haven't read what Balbir have said

See ..

-- 
viresh
