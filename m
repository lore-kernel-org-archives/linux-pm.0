From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2 0/10] cpufreq: governor: ondemand/conservative data structures rework
Date: Sat, 06 Feb 2016 13:44:03 +0100
Message-ID: <1637173.en0L0YzDpX@vostro.rjw.lan>
References: <3705929.bslqXH980s@vostro.rjw.lan> <9008098.QDD8C89zDx@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <9008098.QDD8C89zDx@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, Saravana Kannan <skannan@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

On Friday, February 05, 2016 03:07:27 AM Rafael J. Wysocki wrote:
> On Thursday, February 04, 2016 12:12:52 AM Rafael J. Wysocki wrote:
> > Hi,
> > 
> > A few days ago I looked at the common code used by the ondemand and conservative
> > governors because of the deadlock issue that Viresh has addressed recently
> > (http://marc.info/?l=linux-pm&m=145450832814058&w=4) and it occurred to me
> > that the whole thing was really too tangled and might be made easier to follow
> > at least.  I started to work on this and ended up with the following series.
> > 
> > I'm not really going to stop here, but first, I'd like to let everybody know
> > that this is happening and second, I'll need to rebase these patches on the
> > ones from Viresh (in the series linked above), but that may take some time
> > and I don't want to sit on them for all that long.
> > 
> > Overall, I'd like the governor code to be cleaner and easier to follow, so we can
> > move at least some parts of governor work to utilization update callbacks (invoked
> > by the scheduler) or to at least to irq_work so as to reduce the usage of process
> > context in cpufreq to absolute minimum.  That's the plan for the future, but for
> > now this is just a major cleanup.
> > 
> > [1/11] Clean up the way in which the default and fallback governors are set up.
> > [2/11] Use a common global mutex for dbs_data protection.
> > [3/11] Use common global pointer to dbs_data for system-wide governors.
> > [4/11] Avoid passing dbs_data pointers to functions that can get them by themselves.
> > [5/11] Make struct governor be a member of struct common_dbs_data.
> > [6/11] Rename struct common_dbs_data to struct dbs_governor.
> > [7/11] Rework cpufreq_governor_dbs() so it can be used as a governor callback directly.
> > [8/11] Drop the dbs_governor (former cdata) pointer from struct dbs_data.
> > [9/11] Rename struct cpu_common_dbs_info to struct policy_dbs_info.
> > [10/11] Rearrange data structures so policy->governor_data points to struct policy_dbs_info.
> > [11/11] Drop the second argument of dbs_check_cpu().
> > 
> > The patches are on top of 4.5-rc2 with my earlier series replacing timers with
> > utilization update callbacks (http://marc.info/?l=linux-kernel&m=145410842801883&w=4)
> > applied.
> 
> Some bugs fixed, some comments addressed.  It's time for a v2. :-)
> 
> The most significant difference from the previous one is that I've dropped patch
> [3/11] (so there are 10 of them in the series now) due to a problem with it pointed
> out by Viresh.  Fortunately, this particular one was completely not essential and
> the dependencies on it were rather cosmetic.
> 
> In addition to that I've rebased the series on top of
> https://patchwork.kernel.org/patch/8229901/ as that differs from its previous
> version quite a bit.
> 
> I've already queued up [1/10] for 4.6 as it seems totally uncontroversial.
> 
> The whole series (along with some patches it depends on) is available from the
> git branch at
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-cpufreq-rjw
> 
> in case someone wants to try it.  I've tested it (very lightly) on an x86 laptop
> with the ACPI cpufreq driver and the ondemand governor.

I'm going to tentatively queue up patches [2-8,10/10] with Viresh's ACKs (thanks
Viresh!) for 4.6 (tentatively, because they depend on the timers elimination
series which is still under ongoing review, but that seems to be reaching
conclusion).

Patches [8,10/10] needed a non-trivial rebase, so I'll post the new versions
shortly for completeness.

I'm going to rework patch [9/10] on top of that into a few separate patches
that will hopefully be easier to digest.

Thanks,
Rafael
