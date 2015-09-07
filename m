From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: System will not suspend with highest numbered CPU offline [REGRESSION][BISECTED]
Date: Mon, 07 Sep 2015 15:32:22 +0200
Message-ID: <36067670.SJVW3MBOsV@vostro.rjw.lan>
References: <001401d0e691$302127b0$90637710$@net> <001601d0e7af$01a22140$04e663c0$@net> <20150905081407.GK5285@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:49233 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751098AbbIGNEd (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 7 Sep 2015 09:04:33 -0400
In-Reply-To: <20150905081407.GK5285@linux>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Doug Smythies <dsmythies@telus.net>, "'Rafael J. Wysocki'" <rafael@kernel.org>, 'Saravana Kannan' <skannan@codeaurora.org>, linux-pm@vger.kernel.org

On Saturday, September 05, 2015 01:44:07 PM Viresh Kumar wrote:
> On 05-09-15, 00:46, Doug Smythies wrote:
> > > It is not clear to me why that echo line (there is only one)
> > > would fail.
> 
> To me it is clear now :)
> 
> > The echo line fails because the related CPU is offline.
> > If the failed echo is the last pass through the loop,
> > then the script interprets the overall execution of
> > 94cpufreq as a failure and aborts the suspend. If the
> > failed echo is not the last pass through the loop, then
> > the bad exit code gets overwritten with a good one before
> > the loop exits.
> > 
> > Since the loop is merely setting a temporary governor,
> > to test I just used performance mode anyway, and commented
> > out the echo. pm-suspend with CPU 7 offline then worked fine.
> > 
> > I have not yet gone back to any before the patch kernel
> > to determine why it used to work (it is late in my time zone).
> > However, I would have to assume that before the commit in
> > question, the echo worked even if the CPU was offline.
> 
> So here is the story behind it.
> - In your system all CPUs are independent, that is there are no links
>   to cpufreq directory, so that check in the script is useless for
>   you.
> - The $COMMIT in question did a significant change. Earlier, while
>   offlining the CPU, we used to remove the cpufreq directory from
>   sysfs, which is not the case any more.
> 
> - So to be precise, following lines came to your rescue earlier:
> 
> # if we do not have a scaling_governor file, skip.
> # [ -f "$gov" ] || continue
> 
> - But they don't after the patch, as the file and directory are
>   present even if the CPU is offline.
> - But because the CPU is offline, writing to those files isn't allowed
>   and so the echo failed.
> 
> Solution to that is that we check for CPU offline as well in the
> beginning of the script, and skip if the CPU is offline.

That's a bug in the script.  It should discard all errors from the entire inner
loop, but it doesn't discard errors from the last iteration of it.

That said, what store() in cpufreq.c does is questionable too.

First, if policy->cpu is offline, the policy will be inactive to my eyes, so
we don't need the second check.

But if the policy is active (and policy->cpu is online), it will not generally
fail for an offline CPU.  So, if the policy applies to more than 1 CPU, you
can use any of them to manipulate it, even if one of them is offline as long
as there are any online CPUs in the set.

This isn't entirely consistent.  We should either fail store() for any offline
CPU or make the changes for offline CPUs to.  And in the particular case of
the governor, I'm wondering what will be the problem with changing last_governor
for an inactive policy?

Thanks,
Rafael

