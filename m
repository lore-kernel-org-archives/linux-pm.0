From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2] cpufreq, intel_pstate, Fix intel_pstate powersave min_perf_pct value
Date: Mon, 19 Oct 2015 23:51:31 +0200
Message-ID: <20365584.ryD5HiWE6T@vostro.rjw.lan>
References: <1444908855-25145-1-git-send-email-prarit@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:43287 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750876AbbJSVWn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 19 Oct 2015 17:22:43 -0400
In-Reply-To: <1444908855-25145-1-git-send-email-prarit@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Prarit Bhargava <prarit@redhat.com>
Cc: linux-kernel@vger.kernel.org, Kristen Carlson Accardi <kristen@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Doug Smythies <dsmythies@telus.net>

On Thursday, October 15, 2015 07:34:15 AM Prarit Bhargava wrote:
> Rafael, as requested ...
> 
> [v2]: rebased on
> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
> 
> ^^^ prolly doesn't need to be in the commit log
> 
> P.
> 
> ---8<---
> 
> On systems that initialize the intel_pstate driver with the performance
> governor, and then switch to the powersave governor will not transition to
> lower cpu frequencies until /sys/devices/system/cpu/intel_pstate/min_perf_pct
> is set to a low value.
> 
> The behavior of governor switching changed after commit a04759924e25
> ("[cpufreq] intel_pstate: honor user space min_perf_pct override on
>  resume").  The commit introduced tracking of performance percentage
> changes via sysfs in order to restore userspace changes during
> suspend/resume.  The problem occurs because the global values of the newly
> introduced max_sysfs_pct and min_sysfs_pct are not lowered on the governor
> change and this causes the powersave governor to inherit the performance
> governor's settings.
> 
> A simple change would have been to reset max_sysfs_pct to 100 and
> min_sysfs_pct to 0 on a governor change, which fixes the problem with
> governor switching.  However, since we cannot break userspace[1] the fix
> is now to give each governor its own limits storage area so that governor
> specific changes are tracked.
> 
> I successfully tested this by booting with both the performance governor
> and the powersave governor by default, and switching between the two
> governors (while monitoring /sys/devices/system/cpu/intel_pstate/ values,
> and looking at the output of cpupower frequency-info).  Suspend/Resume
> testing was performed by Doug Smythies.
> 
> [1] Systems which suspend/resume using the unmaintained pm-utils package
> will always transition to the performance governor before the suspend and
> after the resume.  This means a system using the powersave governor will
> go from powersave to performance, then suspend/resume, performance to
> powersave.  The simple change during governor changes would have been
> overwritten when the governor changed before and after the suspend/resume.
> I have submitted https://bugzilla.redhat.com/show_bug.cgi?id=1271225
> against Fedora to remove the 94cpufreq file that causes the problem.  It
> should be noted that pm-utils is obsoleted with newer versions of systemd.
> 
> Cc: Kristen Carlson Accardi <kristen@linux.intel.com>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: linux-pm@vger.kernel.org
> Cc: Doug Smythies <dsmythies@telus.net>
> Signed-off-by: Prarit Bhargava <prarit@redhat.com>

Applied, thanks!

Rafael

