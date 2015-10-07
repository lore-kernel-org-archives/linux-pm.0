From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq, intel_pstate, set max_sysfs_pct and min_sysfs_pct on governor switch
Date: Thu, 08 Oct 2015 00:05:53 +0200
Message-ID: <10053399.aMfHfU7Xt3@vostro.rjw.lan>
References: <1444168147-17812-1-git-send-email-prarit@redhat.com> <000f01d10131$59c67a60$0d536f20$@net> <56158F2D.50200@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:59848 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754983AbbJGVhW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 7 Oct 2015 17:37:22 -0400
In-Reply-To: <56158F2D.50200@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Prarit Bhargava <prarit@redhat.com>
Cc: Doug Smythies <dsmythies@telus.net>, 'Kristen Carlson Accardi' <kristen@linux.intel.com>, linux-kernel@vger.kernel.org, 'Viresh Kumar' <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org

On Wednesday, October 07, 2015 05:31:25 PM Prarit Bhargava wrote:
> 
> On 10/07/2015 02:52 PM, Doug Smythies wrote:
> > On 2015.10.07 08:46 Prarit Bhargava wrote:
> >> On 10/07/2015 11:40 AM, Doug Smythies wrote:
> >>>
> >>> Do we agree or disagree that the root issue seems to be (from your test)?:
> >>>
> >>> \#  echo 100 > /sys/devices/system/cpu/intel_pstate/min_perf_pct
> >>>
> >>> [   21.483436] store_min_perf_pct[453] min_sysfs_pct = 100
> >>> [   21.489373] store_min_perf_pct[456] min_perf_pct = 100
> >>> [   21.495203] store_min_perf_pct[459] min_perf_pct = 100
> >>> [   21.501050] store_min_perf_pct[462] min_perf_pct = 100
> >>
> >> Yep, and it appears to be done by default in Fedora & RHEL :/ ... the issue is
> >> still the same IMO that min_sysfs_pct & max_sysfs_pct are not cleared on a
> >> governor switch.
> > 
> > Clearing them will break some other things. For example, and as
> > shown in my original reply, resume from suspend.
> > 
> > Why? Because, at least on my computer, the governor is changed to
> > "performance" during suspend, and the "powersave" governor is
> > restored sometime during resume. The users wants the settings they had
> > before the suspend.
> > 
> 
> Looking at this in more detail after having tested on a Intel(R) Core(TM)
> i7-2600 CPU @ 3.40GHz in Fedora and RHEL.
> 
> I have a feeling that the switch you're seeing (poweersave->performance, suspend
> ... resume, performance->powersave) is occurring in userspace, and not as a
> result of the kernel.  IMO if userspace changes the governor, all bets are off
> on maintaining max_sysfs_pct and min_sysfs_pct.
> 
> Here's something I cannot figure out (because I do not have an Ubuntu install).
>  *Why* is Ubuntu making the governor switch during suspend/resume?  Is it
> because of archaic brokeness they were trying to paper over?

That's not limited to Ubuntu, pm-utils has been doing that forever.

I have no idea why has it been doing that, though.  I guess the reason
was to "speed up" PM transitions (in case it started when you were in a
low-frequency P-state and then there was no time to bump it up before
things got too far).

Thanks,
Rafael

