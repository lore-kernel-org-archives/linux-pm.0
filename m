From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V3 2/5] cpufreq: ondemand: update sampling rate
 immediately
Date: Wed, 28 Oct 2015 15:01:09 +0530
Message-ID: <20151028093109.GJ30039@ubuntu>
References: <cover.1444723240.git.viresh.kumar@linaro.org>
 <1746c301a8f0a94578f550026cf41e532e6e0f41.1444723240.git.viresh.kumar@linaro.org>
 <2498053.EX0k8RstLZ@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:34922 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754588AbbJ1JbO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 28 Oct 2015 05:31:14 -0400
Received: by pasz6 with SMTP id z6so1952296pas.2
        for <linux-pm@vger.kernel.org>; Wed, 28 Oct 2015 02:31:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <2498053.EX0k8RstLZ@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, open list <linux-kernel@vger.kernel.org>

On 28-10-15, 07:28, Rafael J. Wysocki wrote:
> Your argument seems to be that it should be OK to do the
> cancel_delayed_work_sync()/gov_queue_work() combo in all cases, because
> even if the new rate is greater than the old one, the user may actually
> want it to take effect immediately and it shouldn't hurt to skip the next
> sample anyway in that case.
> 
> Is this really the case, though?  What about the old rate is 1s, the new one
> is 2s and the timer is just about to expire?  Won't the canceling effectively
> move the next sample 3s away from the previous one which may not be desirable?
> 
> The current code just allows the timer to expire, unless that would prevent
> the new rate from taking effect for too long, which seems perfectly reasonable
> to me.

Okay, what about this case: old rate is 1s, new rate it 5s and we have
just serviced the timer. With the current code we will receive
evaluate again after 1 second instead of 5. Is that desirable ?

I didn't wanted to keep special code for such corner cases. And then
how many times are we going to update sampling rates ?

But if we want to do something special, then we may schedule the work
for following delay:

delay = shared->time_stamp + new_sampling_rate.

shared->time_stamp is the last time we evaluated the load.

With this, we will be at shoot at the exact requested time, relative
to the last time we evaluated the loads.

-- 
viresh
