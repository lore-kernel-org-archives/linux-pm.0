From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 0/6] cpufreq: schedutil governor
Date: Wed, 02 Mar 2016 02:56:28 +0100
Message-ID: <2495375.dFbdlAZmA6@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Michael Turquette <mturquette@baylibre.com>
List-Id: linux-pm@vger.kernel.org

Hi,

My previous intro message still applies somewhat, so here's a link:

http://marc.info/?l=linux-pm&m=145609673008122&w=2

The executive summary of the motivation is that I wanted to do two things:
use the utilization data from the scheduler (it's passed to the governor
as aguments of update callbacks anyway) and make it possible to set
CPU frequency without involving process context (fast frequency switching).

Both have been prototyped in the previous RFCs:

https://patchwork.kernel.org/patch/8426691/
https://patchwork.kernel.org/patch/8426741/

but in the meantime I found a couple of issues in there.

First off, the common governor code relied on by the previous version reset
the sample delay to 0 in order to force an immediate frequency update.  That
doesn't work with the new governor, though, because it computes the frequency
to set in a cpufreq_update_util() callback and (when fast switching is not
used) passes that to a work item which sets the frequency and then restores
the sample delay.  Thus if sysfs changes the sample delay to 0 when work_in_progress
is in effect, it will be overwritten by the work item and so discarded.

When using fast switching, the previous version would update the sample delay
from a scheduler path, but that (on a 32-bit system) might clash with an
update from sysfs leading to a result that's completely off.  That value would
be less than the correct sample delay (I think), so in practice that shouldn't
matter that much, but still it's not nice.

The above means that schedutil cannot really share as much code as I thought it
could with "ondemand" and "conservative".

Moreover, I wanted to have a "rate_limit" tunable (instead of the sampling rate
which doesn't mean what the name suggests in schedutil), but that would be the
only one used by schedutil, so I ended up having to define a new struct to point
to from struct dbs_data just to hold that single value and I would need to
define ->init() and ->exit() callbacks for the governor for that reason (and
the common tunables in struct dbs_data wouldn't be used).

Not to mention the fact that the majority of the common governor code is not
really used by schedutil anyway.

Taking the above into account, I decided to decouple schedutil from the other
governors, but I wanted to avoid duplicating some of the tunables manipulation
code.  Hence patches [3-4/6] taking that code into a separate file so schedutil
can use it too without pulling the rest of the common "ondemand" and
"conservative" code along with it.

Patch [5/6] adds support for fast switching to the core and the ACPI driver,
but doesn't hook it up to anything useful.  That is done in the last patch
that actually adds the new governor.

That depends on two patches I sent previously, [1/6] that makes
cpufreq_update_util() use RCU-sched (one change from the previous version
as requested by Peter) and [2/6] that reworks acpi-cpufreq so the fast
switching (added later in patch [5/6]) can work with all of the frequency
setting methods the driver may use.

Comments welcome.

Thanks,
Rafael
