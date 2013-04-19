From: Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: bltk-game regressions on snb laptop
Date: Fri, 19 Apr 2013 08:44:42 -0700
Message-ID: <5171666A.6040003@linux.intel.com>
References: <516CFA57.3060709@intel.com> <CAKohponOVZgAxdX5yv9qmn_56mgTdXEBPr-7o7_pA5GRF09J0w@mail.gmail.com> <516F42EE.6080802@intel.com> <CAKohpokju79Fx7TXTD1hKoG0JUmCsRm8Us381bhHeUrBvyOv6w@mail.gmail.com> <516F81BD.3030306@intel.com> <CAKohponG+F6ikVb2iY_Qg5E6NoCkPVj5VC12JqwXfamzsKLrXA@mail.gmail.com> <516FB4AF.6060009@intel.com> <CAKohpo=NGYadRubvBDLsE=oO1wuDSxnutYfZLm9vu4B6tcUw-g@mail.gmail.com> <517115D4.5020505@intel.com> <CAKohpongtqt0Sdc95TTrJ+s5A3Xt7df+SmtBZNyHzQKtARLxKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:30824 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030656Ab3DSPon (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 19 Apr 2013 11:44:43 -0400
In-Reply-To: <CAKohpongtqt0Sdc95TTrJ+s5A3Xt7df+SmtBZNyHzQKtARLxKA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Alex Shi <alex.shi@intel.com>, Linux PM list <linux-pm@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, LKP ML <lkp@linux.intel.com>


>
> So you get better performance without my patch because we don't allocate
> any struct cpufreq_policy for any of the cpus leaving first one. And so only
> manage freq change for it and all other cpus stay at max power..
>
> So, we clearly need to know why don't we want to have all cpus set in
> policy->cpus, when they actually share clock line?
>

right conclusion, wrong solution ;-)

Alex should know by now (we told him this internally quite a few times) that this indeed is happening.
But the answer is not to try to make the software know that things share a clock line,
the answer is that the current code is correct.

(on x86, the way shared voltage/frequency domains work is that the current clock value is the maximum of
what the individual *non idle* cpu's asked for. If the cpu asking for the highest value goes idle,
all others will drop their frequency to the value the next highest is asking for, etc.
Trying to do this kind of thing in software is backwards and actually ends up burning a lot of power)


on the 'regression'; of COURSE things might go slower once you stop acting like the "performance" governor.
now, ondemand is pretty dire for this generation of hardware, and that's why we have asked Alex repeatedly
to actually use the driver Intel has gotten upstream for this generation of hardware instead.
I do not know why he has not done that instead of trying to get a bug put back into the kernel.


