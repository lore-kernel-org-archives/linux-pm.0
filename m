From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v4 08/16] sched/core: uclamp: propagate parent clamps
Date: Tue, 11 Sep 2018 08:18:19 -0700
Message-ID: <20180911151819.GH1100574@devbig004.ftw2.facebook.com>
References: <20180828135324.21976-1-patrick.bellasi@arm.com>
 <20180828135324.21976-9-patrick.bellasi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180828135324.21976-9-patrick.bellasi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Paul Turner <pjt@google.com>, Quentin Perret <quentin.perret@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>, Suren Baghdasaryan <surenb@google.com>
List-Id: linux-pm@vger.kernel.org

Hello, Patrick.

Can we first concentrate on getting in the non-cgroup part first?  The
feature has to make sense without cgroup too and I think it'd be a lot
easier to discuss cgroup details once the scheduler core side is
settled.

Thanks.

-- 
tejun
