From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH v3 0/7] cpufreq: schedutil governor
Date: Tue, 08 Mar 2016 03:23:06 +0100
Message-ID: <4088601.C2vItRYpQn@vostro.rjw.lan>
References: <2495375.dFbdlAZmA6@vostro.rjw.lan> <2409306.qzzMXcm4dm@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <2409306.qzzMXcm4dm@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Ingo Molnar <mingo@kernel.org>
List-Id: linux-pm@vger.kernel.org

On Friday, March 04, 2016 03:56:09 AM Rafael J. Wysocki wrote:
> On Wednesday, March 02, 2016 02:56:28 AM Rafael J. Wysocki wrote:
> > Hi,
> > 
> > My previous intro message still applies somewhat, so here's a link:
> > 
> > http://marc.info/?l=linux-pm&m=145609673008122&w=2
> > 
> > The executive summary of the motivation is that I wanted to do two things:
> > use the utilization data from the scheduler (it's passed to the governor
> > as aguments of update callbacks anyway) and make it possible to set
> > CPU frequency without involving process context (fast frequency switching).
> > 
> > Both have been prototyped in the previous RFCs:
> > 
> > https://patchwork.kernel.org/patch/8426691/
> > https://patchwork.kernel.org/patch/8426741/
> > 
> 
> [cut]
> 
> > 
> > Comments welcome.
> 
> There were quite a few comments to address, so here's a new version.
> 
> First off, my interpretation of what Ingo said earlier today (or yesterday
> depending on your time zone) is that he wants all of the code dealing with
> the util and max values to be located in kernel/sched/.  I can understand
> the motivation here, although schedutil shares some amount of code with
> the other governors, so the dependency on cpufreq will still be there, even
> if the code goes to kernel/sched/.  Nevertheless, I decided to make that
> change just to see how it would look like if not for anything else.
> 
> To that end, I revived a patch I had before the first schedutil one to
> remove util/max from the cpufreq hooks [7/10], moved the scheduler-related
> code from drivers/cpufreq/cpufreq.c to kernel/sched/cpufreq.c (new file)
> on top of that [8/10] and reintroduced cpufreq_update_util() in a slightly
> different form [9/10].  I did it this way in case it turns out to be
> necessary to apply [7/10] and [8/10] for the time being and defer the rest
> to the next cycle.
> 
> Apart from that, I changed the frequency selection formula in the new
> governor to next_freq = util * max_freq / max and it seems to work.  That
> allowed the code to be simplified somewhat as I don't need the extra
> relation field in struct sugov_policy now (RELATION_L is used everywhere).
> 
> Finally, I tried to address the bikeshed comment from Viresh about the
> "wrong" names of data types etc related to governor sysfs attributes
> handling.  Hopefully, the new ones are better.
> 
> There are small tweaks all over on top of that.

I've taken patches [1-2/10] from the previous iteration into linux-next
as they were not controversial and improved things anyway.

What follows is reordered a bit and reworked with respect to the v2.

Patches [1-4/7] have not been modified (ie. resends).

Patch [5/7] (fast switch support) has a mechanism to deal with notifiers
included (works for me with the ACPI driver) and cpufreq_driver_fast_switch()
is just a wrapper around the driver callback now (because the givernor needs
to do frequency tracing by itself as it turns out).

Patch [6/7] makes the hooks use util and max arguments again, but this time
the callback function format is the same for everyone (ie. 4 arguments) and
the new governor added by patch [7/7] goes into drivers/cpufreq/ as that
is *much* cleaner IMO.

The new frequency formula has been tweaked a bit once more to make more
util/max values map to the top-most frequency (that matters for systems
where turbo is "encoded" by an extra frequency level where the frequency
is greater by 1 MHz from the previous one, for example).

At this point I'm inclined to take patches [1-2/7] into linux-next for 4.6,
because they set a clear boundary between the current linux-next code which
doesn't really use the utilization data and schedutil, and defer the rest
till after the 4.6 merge window.  That will allow the new next frequency
formula to be tested and maybe we can do something about passing util data
from DL to cpufreq_update_util() in the meantime.

If anyone has any issues with that plan, please let me know.

Thanks,
Rafael

