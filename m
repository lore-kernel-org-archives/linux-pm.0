From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/3] cpufreq: schedutil: move slow path from workqueue to
 SCHED_FIFO task
Date: Mon, 14 Nov 2016 11:07:11 +0530
Message-ID: <20161114053710.GA4178@vireshk-i7>
References: <cover.1478858983.git.viresh.kumar@linaro.org>
 <85bf45982709e06f7f42e1b8f8315945e9d9b6d0.1478858983.git.viresh.kumar@linaro.org>
 <CAJZ5v0jODn1gJtTtpTigA=7QwK04wzdFopr-R6GeoSchqgpgiQ@mail.gmail.com>
 <582670FD.7080203@codeaurora.org>
 <CAKohpokXHRBr78st=w=JF-dqLw3gVvZgGnAJ0-X-bZvVXQEPOQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAKohpokXHRBr78st=w=JF-dqLw3gVvZgGnAJ0-X-bZvVXQEPOQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Saravana Kannan <skannan@codeaurora.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Rafael Wysocki <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Juri Lelli <Juri.Lelli@arm.com>, Robin Randhawa <robin.randhawa@arm.com>, Steve Muckle <smuckle.linux@gmail.com>
List-Id: linux-pm@vger.kernel.org

On 12-11-16, 10:57, Viresh Kumar wrote:
> On 12 November 2016 at 07:01, Saravana Kannan <skannan@codeaurora.org> wrote:
> > Hold on a sec. I thought during LPC someone (Peter?) made a point that when
> > RT thread run, we should bump the frequency to max?
> 
> I wasn't there but AFAIU, this is the case we have currently for the schedutil
> governor. And we (mobile world, Linaro) want to change that it doesn't work
> that well for us. So perhaps it is just the opposite of what you stated.
> 
> > So, schedutil is going
> > to trigger schedutil to bump up the frequency to max, right?
> 
> How is that question related to this patch ?

Trash my last email, I failed to read yours :(

-- 
viresh
