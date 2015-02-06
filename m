From: Mason <mpeg.blue@free.fr>
Subject: cpuidle vs suspend vs something else
Date: Thu, 05 Feb 2015 19:13:07 -0800
Message-ID: <54D43143.2010403@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
Sender: cpufreq-owner@vger.kernel.org
To: Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux PM <linux-pm@vger.kernel.org>, cpufreq <cpufreq@vger.kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Mike Turquette <mturquette@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
List-Id: linux-pm@vger.kernel.org

Hello everyone,

I've been reading about related sub-systems (cpuidle and suspend)
and I'm not sure I understand how they relate / interact.

If I understand correctly (please do point out any misconceptions)
on ARM Cortex A9, the first level of power saving is WFI, which is
typically called from the idle loop.

This places the core in low-power mode ("Standby mode" in ARM docs).
"RAM arrays" (don't know what they are), "processor logic", and
"data engine" (not sure what any of these exactly refers to, guess
I have more reading to do) are still powered-up, but most of the
clocks are disabled.

In ARM's exact words, "WFI and WFE Standby modes disable most of the
clocks in a processor, while keeping its logic powered up. This reduces
the power drawn to the static leakage current, leaving a tiny clock
power overhead requirement to enable the device to wake up."

Some CPUs like Intel's have several levels of sleep (deeper levels
mean less power, but have a higher wake-up latency). AFAIU, cpuidle
is used to describe and manage these levels?

Isn't suspend somewhat like the deepest level of sleep?
(Or is it different in that things like RAM state are only a concern
for suspend, not cpuidle?)

Are both subsystems still actively used?

I saw plans to merge cpufreq into cpuidle / scheduler decisions.

LCA14: LCA14-306: CPUidle & CPUfreq integration with scheduler
http://www.slideshare.net/linaroorg/lca14-306-cpuidlecpufreqintegrationwithscheduler

This presentation doesn't mention suspend, I think.

ARM has a mode called "Dormant Mode". Is suspend typically
used to put the SoC in that mode?

I think I need to read this document carefully:
Power Management In The Linux Kernel -- Current Status And Future
http://events.linuxfoundation.org/sites/events/files/slides/kernel_PM_plain.pdf

There's also an older document that may prove insightful:
CPUIdle versus Suspend
http://www.linuxplumbersconf.org/2010/ocw/proposals/789

But things move so fast in kernel-land, that I don't know how relevant
a 4 year-old document can be.

Regards.

