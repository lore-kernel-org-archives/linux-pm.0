From: Tommaso Cucinotta <tommaso.cucinotta@sssup.it>
Subject: Re: [PATCH 2/3] cpufreq: schedutil: move slow path from workqueue to
 SCHED_FIFO task
Date: Fri, 11 Nov 2016 15:32:04 +0100
Message-ID: <d9caf98b-706d-d331-89c4-b75120589da3@sssup.it>
References: <cover.1478858983.git.viresh.kumar@linaro.org>
 <85bf45982709e06f7f42e1b8f8315945e9d9b6d0.1478858983.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <85bf45982709e06f7f42e1b8f8315945e9d9b6d0.1478858983.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Juri Lelli <Juri.Lelli@arm.com>, Robin Randhawa <robin.randhawa@arm.com>, Steve Muckle <smuckle.linux@gmail.com>
List-Id: linux-pm@vger.kernel.org

Hi,

On 11/11/2016 11:22, Viresh Kumar wrote:
> If slow path frequency changes are conducted in a SCHED_OTHER context
> then they may be delayed for some amount of time, including
> indefinitely, when real time or deadline activity is taking place.
>
> Move the slow path to a real time kernel thread. In the future the
> thread should be made SCHED_DEADLINE.

would you have an insight, as to what runtime/deadline/period to set, and/or
what specific timing constraints you'd like to set, just for this cpufreq
slowpath work?

> The RT priority is arbitrarily set
> to 50 for now.
[...]
> +	struct sched_param param = { .sched_priority = 50 };

won't you have a tunable here? (sysctl?)

Thanks,

	T.
-- 
Tommaso Cucinotta, Computer Engineering PhD
Associate Professor at the Real-Time Systems Laboratory (ReTiS)
Scuola Superiore Sant'Anna, Pisa, Italy
http://retis.sssup.it/people/tommaso
