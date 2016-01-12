From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [RFC PATCH 18/19] cpufreq: remove transition_lock
Date: Tue, 12 Jan 2016 16:54:09 +0530
Message-ID: <20160112112409.GJ1084@ubuntu>
References: <1452533760-13787-1-git-send-email-juri.lelli@arm.com>
 <1452533760-13787-19-git-send-email-juri.lelli@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f180.google.com ([209.85.192.180]:35259 "EHLO
	mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933111AbcALLYO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 12 Jan 2016 06:24:14 -0500
Received: by mail-pf0-f180.google.com with SMTP id 65so61596937pff.2
        for <linux-pm@vger.kernel.org>; Tue, 12 Jan 2016 03:24:13 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1452533760-13787-19-git-send-email-juri.lelli@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Juri Lelli <juri.lelli@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, peterz@infradead.org, rjw@rjwysocki.net, mturquette@baylibre.com, steve.muckle@linaro.org, vincent.guittot@linaro.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com

On 11-01-16, 17:35, Juri Lelli wrote:
> From: Michael Turquette <mturquette@baylibre.com>
> 
> transition_lock was introduced to serialize cpufreq transition
> notifiers. Instead of using a different lock for protecting concurrent
> modifications of policy, it is better to require that callers of
> transition notifiers implement appropriate locking (this is already the
> case AFAICS). Removing transition_lock also simplifies current locking
> scheme.

So, are you saying that the reasoning mentioned in this patch are all
wrong?

commit 12478cf0c55e ("cpufreq: Make sure frequency transitions are
serialized")

-- 
viresh
