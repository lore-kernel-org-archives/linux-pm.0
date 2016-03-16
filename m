From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH v4 0/7] cpufreq: schedutil governor
Date: Wed, 16 Mar 2016 15:41:53 +0100
Message-ID: <1711281.bPmSjlBT7c@vostro.rjw.lan>
References: <2495375.dFbdlAZmA6@vostro.rjw.lan> <2409306.qzzMXcm4dm@vostro.rjw.lan> <4088601.C2vItRYpQn@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4088601.C2vItRYpQn@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Ingo Molnar <mingo@kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi,

Here's a new iteration of the schedutil governor series.  It is based on
linux-next (particularly on the material from my pull request for 4.6-rc1),
so I'm not resending the patches already included there.  It has been
present in my pm-cpufreq-experimental branch for a few days.

The first patch is new, but it is just something I think would be useful
(and seems to be kind of compatible with thigs currently under discussion:
http://marc.info/?l=linux-pm&m=145813384117349&w=4).

The next four patches are needed for sharing code between the new governor
and the existing ones.  Three of them have not changed since the previous
iteration of the series and the fourth one is new (but it only moves some
symbols around).

Patch [6/7] adds fast frequency switching support to cpufreq.  It has changed
since the previous version.  Most importantly, there's a new fast_switch_enabled
field in struct cpufreq_policy which is to be set when fast switching is actually
enabled for the given policy and governors are supposed to set it (using a
helper function provided for that).  This way notifier registrations are only
affected if someone is really using fast switching and that prevents existing
setups from being affected in particular.

Patch [7/7] introduces the schedutil governor.  There are a few changes in it
from the previous version.

First off, I've attempted to address some points made during the recent
discussion on the next frequency selection formula
(http://marc.info/?t=145688568600003&r=1&w=4).  It essentially uses the
formula from http://marc.info/?l=linux-acpi&m=145756618321500&w=4 (bottom
of the message body), but with the modification that if the utilization
is frequency-invariant, it will use max_freq instead of the current frequency.
It uses the mechanism suggested by Peter to recognize whether or not the
utilization is frequency invariant
(http://marc.info/?l=linux-kernel&m=145760739700716&w=4).

Second, because of the above, the schedutil governor goes into kernel/sched/
(again).  Namely, I don't want arch_scale_freq_invariant() to be visible by
all cpufreq governors that won't need it.

Now, since we seem to want to build upon this series (ref the recent Mike's
patchset: http://marc.info/?l=linux-kernel&m=145793318016832&w=4), I need
you to tell me what to change before it is good enough to be queued up for
4.7 (assuming that my 4.6 material is merged, that is).

Thanks,
Rafael
