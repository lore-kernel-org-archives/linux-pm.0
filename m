From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] cpufreq: fix jiffies/cputime mixup in conservative/ondemand governors
Date: Fri, 23 Nov 2012 22:48:12 +0100
Message-ID: <4686564.n70P6BrGFi@vostro.rjw.lan>
References: <m21ugq1vfi.fsf@igel.home> <m2625x5shx.fsf@igel.home> <6739224.35DjQmzyyR@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:35405 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756501Ab2KWVnl (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 23 Nov 2012 16:43:41 -0500
In-Reply-To: <6739224.35DjQmzyyR@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Fabio Baltieri <fabio.baltieri@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>

On Friday, October 26, 2012 11:10:10 PM Rafael J. Wysocki wrote:
> On Friday, October 26, 2012 02:26:34 PM Andreas Schwab wrote:
> > "Rafael J. Wysocki" <rjw@sisk.pl> writes:
> > 
> > > http://git.kernel.org/?p=linux/kernel/git/rafael/linux-pm.git;a=shortlog;h=refs/heads/linux-next
> > 
> > 91f347c looks good, unfortunately d7d6f64 undoes the change.
> 
> I didn't notice that, sorry.  Thanks for the heads up.

So, I'm going to apply the following patch to fix this again.

Thanks,
Rafael


---
From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Subject: cpufreq: governors: Fix jiffies/cputime mixup (revisited)

This change was made by commit 8636fd2 (cpufreq: fix jiffies/cputime
mixup in conservative/ondemand governors) before, but then it has
been reverted inadvertently by commit 4471a34 (cpufreq: governors:
remove redundant code).

The changelog of commit 8636fd2 says:

  The function get_cpu_idle_time_jiffy in both the conservative and
  ondemand governors use jiffies_to_usecs to convert a cputime value
  to usecs which gives the wrong value on architectures where cputime
  and jiffies use different units.  Only matters if NO_HZ is
  disabled, since otherwise get_cpu_idle_time_us should already
  return a valid value, and get_cpu_idle_time_jiffy isn't actually
  called.

Since now we have only one common get_cpu_idle_time_jiffy() used by
both governors in question, modify it along the lines of commit
8636fd2 to restore the correct behavior.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/cpufreq_governor.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux/drivers/cpufreq/cpufreq_governor.c
===================================================================
--- linux.orig/drivers/cpufreq/cpufreq_governor.c
+++ linux/drivers/cpufreq/cpufreq_governor.c
@@ -45,9 +45,9 @@ static inline u64 get_cpu_idle_time_jiff
 
 	idle_time = cur_wall_time - busy_time;
 	if (wall)
-		*wall = jiffies_to_usecs(cur_wall_time);
+		*wall = cputime_to_usecs(cur_wall_time);
 
-	return jiffies_to_usecs(idle_time);
+	return cputime_to_usecs(idle_time);
 }
 
 u64 get_cpu_idle_time(unsigned int cpu, u64 *wall)


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
