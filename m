From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] thermal/cpu_cooling: remove local cooling state variable
Date: Fri, 31 Jul 2015 08:48:41 +0530
Message-ID: <20150731031841.GH17794@linux>
References: <1437516835-198750-1-git-send-email-radivoje.jovanovic@linux.intel.com>
 <9hhegjxbmqz.fsf@e105922-lin.cambridge.arm.com>
 <20150724100905.7e2e53f4@radivoje-desk2>
 <9hhoaiuap3m.fsf@e105922-lin.cambridge.arm.com>
 <20150730080541.GD31351@linux>
 <20150730132130.3c957267@radivoje-desk2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:32843 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751120AbbGaDSs (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 30 Jul 2015 23:18:48 -0400
Received: by pdbnt7 with SMTP id nt7so34655061pdb.0
        for <linux-pm@vger.kernel.org>; Thu, 30 Jul 2015 20:18:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150730132130.3c957267@radivoje-desk2>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Radivoje Jovanovic <radivoje.jovanovic@linux.intel.com>
Cc: Punit Agrawal <punit.agrawal@arm.com>, rjw@rjwysocki.net, LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Radivoje Jovanovic <radivoje.jovanovic@intel.com>

Thanks.

I will try to add more layman terms here to map cooling state with
frequencies. So, the cooling state 0 maps to the highest frequency the
cpufreq table supports, and the highest cooling state n maps to the
lowest frequency. Right ?

On 30-07-15, 13:21, Radivoje Jovanovic wrote:
> In this case both userspace thermal solution and cpu_cooling are
> changing policy->max and the userspace solution will let governor or HW
> (depends on architecture) decide the clipped-freq. Now let us say that
> cpu_cooling has 4 available states 0-3

Lets say: 0 == 1.2 GHz
          1 == 1.1 GHz
          2 == 1 GHz
          3 == 800 MHz

> and let us say that cpu_cooling
> has set the state 1 as the last state.

i.e. cpu_cooling says "don't go over 1.1 GHz"..

> Now userspace component comes in
> and changes the state of the system that matches cpu_cooling state 0.

So, policy->max reaches 1.2 GHz and that is not in sync with
cpu_cooling. Right ?

> cpu_cooling is unaware of this change and does not change the local
> cur_state.

That's where I think you one of us might be incorrect. At this point
when policy->max is changed to 1.2 GHz, a notifier will get issued to
cpu_cooling, which will bring policy->max again to 1.1 GHz and so
things will be back in control.

> Now the temperature changes and cpu_cooling should change
> the system state to 1 (userspace component malfunctioned and is not
> picking up this change) but since the cur_state is already at 1
> cpu_cooling will not do anything since it believes it is in the correct
> state. Hope this explains it better

-- 
viresh
