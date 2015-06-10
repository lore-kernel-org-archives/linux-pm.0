From: Alex Shi <alex.shi@linaro.org>
Subject: Re: [PATCH RFC v2 4/4] sched: cpufreq_cfs: pelt-based cpu frequency
 scaling
Date: Wed, 10 Jun 2015 14:23:23 +0800
Message-ID: <5577D7DB.5020802@linaro.org>
References: <1431396795-32439-1-git-send-email-mturquette@linaro.org> <1431396795-32439-5-git-send-email-mturquette@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f177.google.com ([209.85.220.177]:35947 "EHLO
	mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933178AbbFJGXc (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 10 Jun 2015 02:23:32 -0400
Received: by qkx62 with SMTP id 62so20439049qkx.3
        for <linux-pm@vger.kernel.org>; Tue, 09 Jun 2015 23:23:31 -0700 (PDT)
In-Reply-To: <1431396795-32439-5-git-send-email-mturquette@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Michael Turquette <mturquette@linaro.org>, peterz@infradead.org, mingo@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, preeti@linux.vnet.ibm.com, Morten.Rasmussen@arm.com, riel@redhat.com, efault@gmx.de, nicolas.pitre@linaro.org, daniel.lezcano@linaro.org, dietmar.eggemann@arm.com, vincent.guittot@linaro.org, amit.kucheria@linaro.org, juri.lelli@arm.com, rjw@rjwysocki.net, viresh.kumar@linaro.org, ashwin.chaugule@linaro.org, abelvesa@gmail.com



On 05/12/2015 10:13 AM, Michael Turquette wrote:
> This governor is event-driven. There is no polling loop to check cpu
> idle time nor any other method which is unsynchronized with the
> scheduler. The entry points for this policy are in fair.c:
> enqueue_task_fair, dequeue_task_fair and task_tick_fair.
> 
> This policy is implemented using the cpufreq governor interface for two
> main reasons:
> 
> 1) re-using the cpufreq machine drivers without using the governor
> interface is hard.
> 
> 2) using the cpufreq interface allows us to switch between the
> scheduler-driven policy and legacy cpufreq governors such as ondemand at
> run-time. This is very useful for comparative testing and tuning.

Hi, Mike,

Did you have some testing data with your patch?
