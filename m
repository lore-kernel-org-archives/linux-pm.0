From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] thermal/cpu_cooling: remove local cooling state variable
Date: Sat, 1 Aug 2015 17:04:05 +0530
Message-ID: <20150801113405.GL899@linux>
References: <1437516835-198750-1-git-send-email-radivoje.jovanovic@linux.intel.com>
 <9hhegjxbmqz.fsf@e105922-lin.cambridge.arm.com>
 <20150724100905.7e2e53f4@radivoje-desk2>
 <9hhoaiuap3m.fsf@e105922-lin.cambridge.arm.com>
 <20150730080541.GD31351@linux>
 <20150730132130.3c957267@radivoje-desk2>
 <20150731031841.GH17794@linux>
 <20150731083003.2f47ca5f@radivoje-desk2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:35894 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751207AbbHALeK (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 1 Aug 2015 07:34:10 -0400
Received: by pachj5 with SMTP id hj5so55641164pac.3
        for <linux-pm@vger.kernel.org>; Sat, 01 Aug 2015 04:34:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150731083003.2f47ca5f@radivoje-desk2>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Radivoje Jovanovic <radivoje.jovanovic@linux.intel.com>
Cc: Punit Agrawal <punit.agrawal@arm.com>, rjw@rjwysocki.net, LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Radivoje Jovanovic <radivoje.jovanovic@intel.com>

On 31-07-15, 08:30, Radivoje Jovanovic wrote:
> I just looked over the notifier in the current upstream (my patch was
> made on our production kernel which is 3.14 and has old notifier
> implementation with notifier_device in place) and I see your point.

That's disappointing. You were expected to check if the same problem
exists in mainline.

> I agree with you that this patch is trivial for the current
> implementation since the notifier, as it is currently, will enforce
> cpu_cooling policy change at every CPUFREQ_ADJUST which would cause
> problems in our current implementation. In our implementation there is
> a cpufreq driver that will also change policies during CPUFREQ_ADJUST,
> once the request comes from the underlying FW so there would be a fight
> who gets there first since cpu_cooling will change the policy in
> CPUFREQ_ADJUST notifier_chain and the driver would do the same thing.
> It seems to me that better implementation of the cpu_cooling notifer
> would be to keep the flag and change the policy in CPUFREQ_ADJUST only
> when the change was requested by cpu_cooling, and update the current
> state of cpufreq_cooling_device during CPUFREQ_NOTIFY event.
> What do you think?

I think the way cpu-cooling is written today, is an *ugly* hack. We hack
the notifier to change policy->max and no one is notified for it.

That's crap.

I would rather get some help from cpufreq core on that. Which can
provide some APIs to take care of thermal considerations.

Okay, I push that to my todo list. Will keep you all posted.

-- 
viresh
