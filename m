From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/3] cpufreq: schedutil: move slow path from workqueue to
 SCHED_FIFO task
Date: Mon, 14 Nov 2016 15:52:54 +0530
Message-ID: <20161114102254.GD4178@vireshk-i7>
References: <cover.1478858983.git.viresh.kumar@linaro.org>
 <85bf45982709e06f7f42e1b8f8315945e9d9b6d0.1478858983.git.viresh.kumar@linaro.org>
 <d9caf98b-706d-d331-89c4-b75120589da3@sssup.it>
 <20161111143935.GK3117@twins.programming.kicks-ass.net>
 <CAKohponr4=8Bf9C1=_YEhsvDXm0t2vXyGOnrrEr6HaMKzVOcnQ@mail.gmail.com>
 <20161114092252.GT3117@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f46.google.com ([74.125.83.46]:34911 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752433AbcKNKW6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 14 Nov 2016 05:22:58 -0500
Received: by mail-pg0-f46.google.com with SMTP id p66so52811326pga.2
        for <linux-pm@vger.kernel.org>; Mon, 14 Nov 2016 02:22:58 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20161114092252.GT3117@twins.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Tommaso Cucinotta <tommaso.cucinotta@sssup.it>, Rafael Wysocki <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Juri Lelli <Juri.Lelli@arm.com>, Robin Randhawa <robin.randhawa@arm.com>, Steve Muckle <smuckle.linux@gmail.com>

On 14-11-16, 10:22, Peter Zijlstra wrote:
> Any static prio value is wrong (static prio assignment requires system
> knowledge that the kernel doesn't and cannot have), 50 is what threaded
> IRQs default too as well IIRC, so it would at least be consistent with
> that.

Yes you are correct and I have found a better way of defining the
priority in this case using that code instead of magic figure 50.

MAX_USER_RT_PRIO/2 :)

-- 
viresh
