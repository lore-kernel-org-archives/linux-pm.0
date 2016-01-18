From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [RFC PATCH 18/19] cpufreq: remove transition_lock
Date: Mon, 18 Jan 2016 10:39:37 +0530
Message-ID: <20160118050937.GA30762@vireshk>
References: <1452533760-13787-1-git-send-email-juri.lelli@arm.com>
 <1452533760-13787-19-git-send-email-juri.lelli@arm.com>
 <20160112112409.GJ1084@ubuntu>
 <20160113005452.10884.77606@quark.deferred.io>
 <20160113063148.GJ6050@ubuntu>
 <20160113182131.1168.45753@quark.deferred.io>
 <20160114103221.GB6078@vireshk>
 <20160114135224.GH18603@e106622-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160114135224.GH18603@e106622-lin>
Sender: linux-kernel-owner@vger.kernel.org
To: Juri Lelli <juri.lelli@arm.com>
Cc: Michael Turquette <mturquette@baylibre.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, peterz@infradead.org, rjw@rjwysocki.net, steve.muckle@linaro.org, vincent.guittot@linaro.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com
List-Id: linux-pm@vger.kernel.org

On 14-01-16, 13:52, Juri Lelli wrote:
> I was under the impression that the purpose of having
> __cpufreq_driver_target() exported outside cpufreq.c was working due to
> the fact that users implement their own locking.
> 
> That's why I put the following comment in this patch.
> 
>  /*
>   * Callers must ensure proper mutual exclusion on policy (for transition_
>   * ongoing/transition_task handling). While holding policy->rwsem is
>   * sufficient, other schemes might work as well (e.g., cpufreq_governor.c
>   * holds timer_mutex while entering the path that generates transitions).
>   */
> 
> >From what I can see ondemand and conservative (via governor) seem to use
> timer_mutex; userspace userspace_mutex instead. Do they serve different
> purposes instead? How do we currently serialize operations on policy
> when using __cpufreq_driver_target() directly otherwise?

The patch I referred to earlier in the thread had detailed few of the
races we were worried about. The lock you just removed is responsible
for taking care of the races you are worried now :)

-- 
viresh
