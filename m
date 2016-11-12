From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/3] cpufreq: schedutil: move slow path from workqueue to
 SCHED_FIFO task
Date: Sat, 12 Nov 2016 10:51:19 +0530
Message-ID: <CAKohpo=GGXnTbd4dsVAPTQXDvxGOvesJgveCzt6c8kTd+KU1pg@mail.gmail.com>
References: <cover.1478858983.git.viresh.kumar@linaro.org> <85bf45982709e06f7f42e1b8f8315945e9d9b6d0.1478858983.git.viresh.kumar@linaro.org>
 <d9caf98b-706d-d331-89c4-b75120589da3@sssup.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <d9caf98b-706d-d331-89c4-b75120589da3@sssup.it>
Sender: linux-kernel-owner@vger.kernel.org
To: Tommaso Cucinotta <tommaso.cucinotta@sssup.it>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Juri Lelli <Juri.Lelli@arm.com>, Robin Randhawa <robin.randhawa@arm.com>, Steve Muckle <smuckle.linux@gmail.com>
List-Id: linux-pm@vger.kernel.org

On 11 November 2016 at 20:02, Tommaso Cucinotta
<tommaso.cucinotta@sssup.it> wrote:

> would you have an insight, as to what runtime/deadline/period to set, and/or
> what specific timing constraints you'd like to set, just for this cpufreq
> slowpath work?

I don't have any such figures for not at least :(
