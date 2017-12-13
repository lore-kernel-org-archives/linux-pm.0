From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v3 1/6] cpufreq: schedutil: reset sg_cpus's flags at IDLE
 enter
Date: Wed, 13 Dec 2017 14:36:23 +0530
Message-ID: <20171213090623.GV25177@vireshk-i7>
References: <20171130114723.29210-1-patrick.bellasi@arm.com>
 <20171130114723.29210-2-patrick.bellasi@arm.com>
 <20171207050135.vvhqttazumjg7n7n@vireshk-mac-ubuntu>
 <20171207124510.GP31247@e110439-lin>
 <20171212113727.GO25177@vireshk-i7>
 <20171212151626.GA8264@e110439-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pl0-f48.google.com ([209.85.160.48]:40929 "EHLO
        mail-pl0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751173AbdLMJG0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 Dec 2017 04:06:26 -0500
Received: by mail-pl0-f48.google.com with SMTP id 1so636849pla.7
        for <linux-pm@vger.kernel.org>; Wed, 13 Dec 2017 01:06:26 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20171212151626.GA8264@e110439-lin>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@android.com>, Joel Fernandes <joelaf@google.com>

On 12-12-17, 15:16, Patrick Bellasi wrote:
> Since you are already changing some flags position, maybe we can have
> a better organization by using lower flags for "general bits" and
> higher ones for class specific, i.e.
> 
> #define SCHED_CPUFREQ_CLEAR	(1U <<  0)
> #define SCHED_CPUFREQ_IOWAIT	(1U <<  1)
> 
> #define SCHED_CPUFREQ_CFS	(1U <<  8)
> #define SCHED_CPUFREQ_RT	(1U <<  9)
> #define SCHED_CPUFREQ_DL	(1U << 10)

Since we aren't normally going to add any more of class specific ones, I would
like to keep them as 0, 1 and 2. And using the top most bit for CLEAR seems
better to me somehow, just like the signed bit for 32 bit integers.

-- 
viresh
