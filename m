From: Steve Muckle <steve.muckle@linaro.org>
Subject: Re: [RFCv6 PATCH 03/10] sched: scheduler-driven cpu frequency
 selection
Date: Wed, 16 Dec 2015 17:24:56 -0800
Message-ID: <56720EE8.1090507@linaro.org>
References: <1449641971-20827-1-git-send-email-smuckle@linaro.org>
 <1449641971-20827-4-git-send-email-smuckle@linaro.org>
 <20151216034825.GA11303@leoy-linaro>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:36619 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750754AbbLQBY7 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 16 Dec 2015 20:24:59 -0500
Received: by mail-pa0-f48.google.com with SMTP id q3so12713886pav.3
        for <linux-pm@vger.kernel.org>; Wed, 16 Dec 2015 17:24:59 -0800 (PST)
In-Reply-To: <20151216034825.GA11303@leoy-linaro>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Leo Yan <leo.yan@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>, Ricky Liang <jcliang@chromium.org>

Hi Leo,

On 12/15/2015 07:48 PM, Leo Yan wrote:
> I also think "set_current_state(TASK_INTERRUPTIBLE)" will introduce
> logic error when software flow run into "else" block. The reason is
> after you set state with TASK_INTERRUPTIBLE, if there have some
> scheduling happen within cpufreq_sched_try_driver_target(), then the
> thread will be remove from rq. But generally we suppose the thread
> will be on rq and can continue run after next tick.
> 
> Juri's suggestion can fix this issue. And we can use atomic_t to
> safely accessing gd->requested_freq.

I agree, it's incorrect. As I replied earlier I believe setting the task
state back to TASK_RUNNING at the top of the else block is the easiest fix.

thanks,
Steve
