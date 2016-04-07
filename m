From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: Skip all governor-related actions for cpufreq_suspended set
Date: Fri, 08 Apr 2016 00:05:08 +0200
Message-ID: <2346918.2NTGrKGAVB@vostro.rjw.lan>
References: <2044559.GVlD7a2JcO@vostro.rjw.lan> <CAJZ5v0g6zHT8yq-s+FkSb+ZE9K5vw_y0GX1nHaSLjOQXfsUquw@mail.gmail.com> <20160407120503.GG3201@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:57248 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752898AbcDGWCg (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 7 Apr 2016 18:02:36 -0400
In-Reply-To: <20160407120503.GG3201@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

On Thursday, April 07, 2016 05:35:03 PM Viresh Kumar wrote:
> On 07-04-16, 13:44, Rafael J. Wysocki wrote:
> > I'm not sure I'm following.
> > 
> > Without this patch fast switch is disabled when we offline the nonboot
> > CPUs during suspend, because cpufreq_exit_governor() runs then, but
> > the cpufreq_governor() called by it does nothing.  Also
> > cpufreq_governor() during nonboot CPUs online does nothing.
> > 
> > That has to be made consistent somehow.  This patch is one way.
> > Another way would be to disable fast switch from the governor ->exit
> > callback, but the net result would be the same.
> 
> Actually things are working fine today by chance IMO, because we don't
> free the policy structures anymore while we offline CPUs.

Yes, that's why they work.  And that's because the code has been written
that way.  Whether that happened by chance or by design, or because of
a favorable concentration of the Force, I don't care.

> Otherwise, policy->governor_data would have been lost together with
> the policy, and governor wouldn't have worked properly after resume.
> 
> What we are doing today is something like this:
> 
> Suspend
> -------
> 
> -> cpufreq_suspend()
>  -> STOP governor
>  -> cpufreq_suspended = true
> 
> -> Offline non-boot CPUs
>   -> cpufreq_offline()
>     -> SKIP calling EXIT governor (governor had allocated few
>     resources earlier)
> 
> Resume
> ------
> 
> -> Bring back non-boot CPUs
>   -> cpufreq_online()
>     -> SKIP calling INIT governor (policy->governor_data doesn't get
>     reset, luckily)

policy->governor_data is not reset.  Period.

> 
> -> cpufreq_resume()
>  -> cpufreq_suspended = false
>  -> START governor

Yes, that's what the code flow is.

> 
> That's *ugly* and it works by chance, unless I am misreading it
> completely.

I'm assuming that what you mean by "ugly" here is "not really straightforward",
which I agree with, but then it is really disappointing to see comments like
that from you about the code that you helped to write.

But instead of going for a rant about how disappointed I am, let me focus on
the technical side of things.

As per the code today, the only legitimate role of cpufreq_suspended is to prevent
governor operations from being carried out when disabling nonboot CPUs during
system suspend.  My *interpretation* of that is that this is to avoid accessing
hardware resources that may not be available at that point, which is fair enough.
It also has a nice side effect that the disabling/enabling nonboot CPUs doesn't
run code that it doesn't have to run (like remmoving/creating governor tunables
directory in sysfs in the tunables-per-policy case).  That is good.

The bad thing is how that is different from the runtime CPU offline.

> One of the solutions to get this cleaned is to stop checking for
> cpufreq_suspended flag in cpufreq_governor() and put that *only* in
> places where we are trying to interact with the hardware. And that
> essentially is the callbacks provided by the cpufreq drivers. So,
> ignore calling cpufreq-driver callbacks if cpufreq_suspended is true.

No, cpufreq_suspended is not sufficient for that, because the setting/clearing
of it is generally racy with respect to pretty much anything except for the
suspend process itself.  Checking it outside of the suspend process would be
a bug.

Moreover, runtime CPU offline *also* doesn't have to run the governor exit/init
for the same reason why the policy directory doesn't have to be removed on
CPU offline: it is just pointless to do that.  The governor has been stopped
already and it won't do anything more.  The only problem here is to prevent
governor tunable sysfs attributes from triggering actions in that state,
but that shouldn't be too difficult to arrange for.  If that's done,
cpufreq_suspended can be dropped, modulo changing cpufreq_start_governor()
to return immediately if the governor has been started already.

And if something else is needed to protect driver callbacks from being invoked
outside of the suspend-resume path, a more robust mechanism has to be added
for that.

But in the meantime, I'd like to address the fast switch problem first and
then you're free to clean up things on top of that.  Or I will clean them up
if I have the time.

Thanks,
Rafael

