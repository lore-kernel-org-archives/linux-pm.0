From: Balbir Singh <bsingharora@gmail.com>
Subject: Re: [PATCH v7 0/6] cpufreq: powernv: Redesign the presentation of
 throttle notification and solve bug-fixes in the driver
Date: Thu, 28 Jan 2016 22:10:57 +1100
Message-ID: <CAKTCnzn6o6fxP+f4FzsBr3+F9_cBubtUs6sQZod0A6BWdBZzmA@mail.gmail.com>
References: <1453965941-7363-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1453965941-7363-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, pc@us.ibm.com, Anton Blanchard <anton@samba.org>, Gautham R Shenoy <ego@linux.vnet.ibm.com>, shreyas@linux.vnet.ibm.com, mpe@ellerman.id.au
List-Id: linux-pm@vger.kernel.org

On Thu, Jan 28, 2016 at 6:25 PM, Shilpasri G Bhat
<shilpa.bhat@linux.vnet.ibm.com> wrote:
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

Looks good to me. You've got the reviews and acks you need.

Balbir Singh
