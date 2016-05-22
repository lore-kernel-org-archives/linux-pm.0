From: Steve Muckle <steve.muckle@linaro.org>
Subject: Re: [RFC PATCH] Increase in idle power with schedutil
Date: Sun, 22 May 2016 13:42:52 -0700
Message-ID: <20160522204252.GH15383@graphite.smuckle.net>
References: <1463576020-18597-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <CAJZ5v0jv+fD-ZKjLBepL9Fkn1JFROO3nGHX_3-=PuzGSAALB5g@mail.gmail.com>
 <20160519114029.GW3193@twins.programming.kicks-ass.net>
 <201605201223.u4KCNWn9028105@mx0a-001b2d01.pphosted.com>
 <20160522103912.GN3193@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:36565 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752562AbcEVUm5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 22 May 2016 16:42:57 -0400
Received: by mail-pa0-f48.google.com with SMTP id bt5so55303646pac.3
        for <linux-pm@vger.kernel.org>; Sun, 22 May 2016 13:42:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20160522103912.GN3193@twins.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>, shreyas@linux.vnet.ibm.com, akshay.adiga@linux.vnet.ibm.com, linuxppc-dev@ozlabs.org, Steve Muckle <steve.muckle@linaro.org>

On Sun, May 22, 2016 at 12:39:12PM +0200, Peter Zijlstra wrote:
> On Fri, May 20, 2016 at 05:53:41PM +0530, Shilpasri G Bhat wrote:
> > 
> > Below are the comparisons by disabling watchdog.
> > Both schedutil and ondemand have a similar ramp-down trend. And in both the
> > cases I can see that frequency of the cpu is not reduced in deterministic
> > fashion. In a observation window of 30 seconds after running a workload I can
> > see that the frequency is not ramped down on some cpus in the system and are
> > idling at max frequency.
> 
> So does it actually matter what the frequency is when you idle? Isn't
> the whole thing clock gated anyway?
> 
> Because this seems to generate contradictory requirements, on the one
> hand we want to stay idle as long as possible while on the other hand
> you seem to want to clock down while idle, which requires not being
> idle.
> 
> If it matters; should not your idle state muck explicitly set/restore
> frequency?

AFAIK this is very platform dependent. Some will waste more power than
others when a CPU idles above fmin due to things like resource (bus
bandwidth, shared cache freq etc) voting.

It is also true that there is power spent going to fmin (and then
perhaps restoring the frequency when idle ends) which will be in part a
function of how slow the frequency change operation is on that platform.

I think Daniel Lezcano (added) was exploring the idea of having cpuidle
drivers take the expected idle duration and potentially communicate to
cpufreq to reduce the frequency depending on a platform-specific
cost/benefit analysis.


