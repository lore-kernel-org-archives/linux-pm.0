From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 0/8] schedutil enhancements
Date: Wed, 16 Mar 2016 01:08:02 +0100
Message-ID: <2494941.hQv4heU2vL@vostro.rjw.lan>
References: <1457932932-28444-1-git-send-email-mturquette+renesas@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:45191 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751086AbcCPAGB (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 15 Mar 2016 20:06:01 -0400
In-Reply-To: <1457932932-28444-1-git-send-email-mturquette+renesas@baylibre.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Michael Turquette <mturquette@baylibre.com>
Cc: peterz@infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Juri.Lelli@arm.com, steve.muckle@linaro.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, vincent.guittot@linaro.org, Michael Turquette <mturquette+renesas@baylibre.com>

Hi Mike,

On Sunday, March 13, 2016 10:22:04 PM Michael Turquette wrote:
> I'm happy that scheduler-driven cpu frequency selection is getting some
> attention. Rafael's recent schedutil governor is a step in the right direction.

Thanks!

> This series builds on top of Rafael's schedutil governor, bringing it to parity
> with some of the features in the schedfreq series posted by Steve[0], as well
> as adding a couple of new things.
> 
> Patch 1 removes cpufreq_trigger_update()
> 
> Patches 2-4 move the cfs capacity margin out of the governor and into
> cfs. This value is made tunable by a sysfs control in schedutil.
> 
> Patches 5-6 make cpufreq_update_util() aware of multiple scheduler
> classes (cfs, rt & dl), and add storage & summation of these per-class
> utilization values into schedutil.
> 
> Patches 7-8 introduces Dietmar's generic cpufreq implementation[1] of the
> frequency invariance hook and changes the preprocessor magic in sched.h to
> favor the cpufreq implementation over arch- or platform-specific ones.

After the discussion mentioned by Peter in one of his responses (the relevant
e-mail thread is here: http://marc.info/?t=145688568600003&r=1&w=4) I have
changed the schedutil series to address some points made during it.

In particular, I've modified it to use the formula from 
http://marc.info/?l=linux-acpi&m=145756618321500&w=4 with the twist that
if the utilization is frequency-invariant, max_freq will be used instead
of current_freq.

The way it recognizes whether or not that is the case is based on the
Peter's suggestion from http://marc.info/?l=linux-kernel&m=145760739700716&w=4.

For this reason, the governor goes into kernel/sched/ as I don't want
arch_scale_freq_invariant() to be exposed to cpufreq at large, because
schedutil will be the only governor using it in foreseeable future.

The fast switching support patch is slightly different too, but that's
not relevant here.

The new series is in the pm-cpufreq-experimental branch of my tree:

git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
pm-cpufreq-experimental

I haven't had the time to post it over the last few days (sorry about
that), but I'll do that tomorrow.

Thanks,
Rafael

