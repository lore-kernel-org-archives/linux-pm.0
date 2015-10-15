From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq, intel_pstate, Fix intel_pstate powersave min_perf_pct value
Date: Thu, 15 Oct 2015 02:32:44 +0200
Message-ID: <8881818.1ik7dTLnEz@vostro.rjw.lan>
References: <1444822919-14650-1-git-send-email-prarit@redhat.com> <2038385.VTvETXG82F@vostro.rjw.lan> <561EECF9.4070500@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:42413 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753258AbbJOAEC (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 14 Oct 2015 20:04:02 -0400
In-Reply-To: <561EECF9.4070500@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Prarit Bhargava <prarit@redhat.com>
Cc: Kristen Carlson Accardi <kristen@linux.intel.com>, linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Doug Smythies <dsmythies@telus.net>

On Wednesday, October 14, 2015 08:02:02 PM Prarit Bhargava wrote:
> 
> On 10/14/2015 08:29 PM, Rafael J. Wysocki wrote:
> > On Wednesday, October 14, 2015 07:59:38 PM Prarit Bhargava wrote:
> >>
> >> On 10/14/2015 05:09 PM, Kristen Carlson Accardi wrote:
> >>> On Wed, 14 Oct 2015 07:41:59 -0400
> >>> Prarit Bhargava <prarit@redhat.com> wrote:
> >>>
> >>>> On systems that initialize the intel_pstate driver with the performance
> >>>> governor, and then switch to the powersave governor will not transition to
> >>>> lower cpu frequencies until /sys/devices/system/cpu/intel_pstate/min_perf_pct
> >>>> is set to a low value.
> >>>>
> >>>> The behavior of governor switching changed after commit a04759924e25
> >>>> ("[cpufreq] intel_pstate: honor user space min_perf_pct override on
> >>>>  resume").  The commit introduced tracking of performance percentage
> >>>> changes via sysfs in order to restore userspace changes during
> >>>> suspend/resume.  The problem occurs because the global values of the newly
> >>>> introduced max_sysfs_pct and min_sysfs_pct are not lowered on the governor
> >>>> change and this causes the powersave governor to inherit the performance
> >>>> governor's settings.
> >>>>
> >>>> A simple change would have been to reset max_sysfs_pct to 100 and
> >>>> min_sysfs_pct to 0 on a governor change, which fixes the problem with
> >>>> governor switching.  However, since we cannot break userspace[1] the fix
> >>>> is now to give each governor its own limits storage area so that governor
> >>>> specific changes are tracked.
> >>>>
> >>>> I successfully tested this by booting with both the performance governor
> >>>> and the powersave governor by default, and switching between the two
> >>>> governors (while monitoring /sys/devices/system/cpu/intel_pstate/ values,
> >>>> and looking at the output of cpupower frequency-info).  Suspend/Resume
> >>>> testing was performed by Doug Smythies.
> >>>>
> >>>> [1] Systems which suspend/resume using the unmaintained pm-utils package
> >>>> will always transition to the performance governor before the suspend and
> >>>> after the resume.  This means a system using the powersave governor will
> >>>> go from powersave to performance, then suspend/resume, performance to
> >>>> powersave.  The simple change during governor changes would have been
> >>>> overwritten when the governor changed before and after the suspend/resume.
> >>>> I have submitted https://bugzilla.redhat.com/show_bug.cgi?id=1271225
> >>>> against Fedora to remove the 94cpufreq file that causes the problem.  It
> >>>> should be noted that pm-utils is obsoleted with newer versions of systemd.
> >>>>
> >>>> Cc: Kristen Carlson Accardi <kristen@linux.intel.com>
> >>>> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> >>>> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> >>>> Cc: linux-pm@vger.kernel.org
> >>>> Cc: Doug Smythies <dsmythies@telus.net>
> >>>> Signed-off-by: Prarit Bhargava <prarit@redhat.com>
> >>>
> >>> Acked-by: Kristen Carlson Accardi <kristen@linux.intel.com>
> >>>
> >>> BTW - I think I can see an issue here with HWP enabled systems.  It
> >>> looks to me like the hwp settings will not be programmed correctly
> >>> during a governor switch.  This probably needs to be addressed in a
> >>> separate patch.
> >>>
> >>
> >> Oh, I see it now too.  I'll get to that in another patch.  Thanks for pointing
> >> that out Kristen.
> > 
> > The $subject patch doesn't apply any more after the series from Srinivas that
> > I've just applied.
> > 
> > Can you please rebase it on top of my bleeding-edge branch?
> > 
> 
> Sure -- can you send me a pointer to the branch?

git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge

Thanks,
Rafael

