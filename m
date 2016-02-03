From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 0/11] cpufreq: governor: ondemand/conservative data structures rework
Date: Thu, 04 Feb 2016 00:12:52 +0100
Message-ID: <3705929.bslqXH980s@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, Saravana Kannan <skannan@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

Hi,

A few days ago I looked at the common code used by the ondemand and conservative
governors because of the deadlock issue that Viresh has addressed recently
(http://marc.info/?l=linux-pm&m=145450832814058&w=4) and it occurred to me
that the whole thing was really too tangled and might be made easier to follow
at least.  I started to work on this and ended up with the following series.

I'm not really going to stop here, but first, I'd like to let everybody know
that this is happening and second, I'll need to rebase these patches on the
ones from Viresh (in the series linked above), but that may take some time
and I don't want to sit on them for all that long.

Overall, I'd like the governor code to be cleaner and easier to follow, so we can
move at least some parts of governor work to utilization update callbacks (invoked
by the scheduler) or to at least to irq_work so as to reduce the usage of process
context in cpufreq to absolute minimum.  That's the plan for the future, but for
now this is just a major cleanup.

[1/11] Clean up the way in which the default and fallback governors are set up.
[2/11] Use a common global mutex for dbs_data protection.
[3/11] Use common global pointer to dbs_data for system-wide governors.
[4/11] Avoid passing dbs_data pointers to functions that can get them by themselves.
[5/11] Make struct governor be a member of struct common_dbs_data.
[6/11] Rename struct common_dbs_data to struct dbs_governor.
[7/11] Rework cpufreq_governor_dbs() so it can be used as a governor callback directly.
[8/11] Drop the dbs_governor (former cdata) pointer from struct dbs_data.
[9/11] Rename struct cpu_common_dbs_info to struct policy_dbs_info.
[10/11] Rearrange data structures so policy->governor_data points to struct policy_dbs_info.
[11/11] Drop the second argument of dbs_check_cpu().

The patches are on top of 4.5-rc2 with my earlier series replacing timers with
utilization update callbacks (http://marc.info/?l=linux-kernel&m=145410842801883&w=4)
applied.

Thanks,
Rafael
