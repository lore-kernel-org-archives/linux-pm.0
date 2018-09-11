From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v4 08/16] sched/core: uclamp: propagate parent clamps
Date: Tue, 11 Sep 2018 09:28:27 -0700
Message-ID: <20180911162827.GJ1100574@devbig004.ftw2.facebook.com>
References: <20180828135324.21976-1-patrick.bellasi@arm.com>
 <20180828135324.21976-9-patrick.bellasi@arm.com>
 <20180911151819.GH1100574@devbig004.ftw2.facebook.com>
 <20180911162624.GB1413@e110439-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180911162624.GB1413@e110439-lin>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Paul Turner <pjt@google.com>, Quentin Perret <quentin.perret@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>, Suren Baghdasaryan <surenb@google.com>
List-Id: linux-pm@vger.kernel.org

Hello, Patrick.

On Tue, Sep 11, 2018 at 05:26:24PM +0100, Patrick Bellasi wrote:
> My question is: IF the scheduler maintainers are going to be happy
> with the overall design for the core bits, are you happy to start the
> review of the cgroups bits before the core ones are (eventually) merged?

Yeah, sure, once the feature is more or less agreed on the scheduler
core side, we can delve into how it should be represented in cgroup.

Thanks.

-- 
tejun
