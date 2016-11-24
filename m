From: Steve Muckle <smuckle.linux@gmail.com>
Subject: Re: [PATCH V2 0/4] cpufreq: schedutil: move slow path from workqueue
 to SCHED_FIFO task
Date: Wed, 23 Nov 2016 19:01:02 -0800
Message-ID: <20161124030102.GA20047@graphite.smuckle.net>
References: <cover.1479197311.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35879 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753943AbcKXDBF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Nov 2016 22:01:05 -0500
Content-Disposition: inline
In-Reply-To: <cover.1479197311.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Juri Lelli <Juri.Lelli@arm.com>, Robin Randhawa <robin.randhawa@arm.com>

Hi Viresh,

On Tue, Nov 15, 2016 at 01:53:19PM +0530, Viresh Kumar wrote:
> This work was started by Steve Muckle, where he used a simple kthread
> instead of kthread-worker and that wasn't sufficient as some guarantees
> weren't met.

I know this has already gone in, but can you expand on the unmet
guarantees mentioned here just for my own (and perhaps others')
understanding?

thanks,
Steve
