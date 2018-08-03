From: Quentin Perret <quentin.perret@arm.com>
Subject: Re: [PATCH v5 10/14] sched/cpufreq: Refactor the utilization
 aggregation method
Date: Fri, 3 Aug 2018 14:04:55 +0100
Message-ID: <20180803130453.zaia4e252aajxd3c@queper01-lin>
References: <20180724122521.22109-11-quentin.perret@arm.com>
 <331552975e858911db66bc78c2c8e720@codeaurora.org>
 <20180731075950.tfvxef6yuja3ad2k@queper01-lin>
 <75f415911ccdd02d6fd217ca1c7d8902@codeaurora.org>
 <CAJZ5v0j=EYnANGAj9bd44eeux1eCfeMtdn9npe5pSAzE8EVKaA@mail.gmail.com>
 <20180801082353.egym4tsbr7ppql27@queper01-lin>
 <CAJZ5v0joYFXkXxoV8odPtrCNW=jAw3RVv3rTzMoabeYWGDnREw@mail.gmail.com>
 <20180801092325.g2upcivcvdo62hub@queper01-ThinkPad-T460s>
 <20180802130440.GW2476@hirez.programming.kicks-ass.net>
 <20180802153917.cpvls5hxkvevjh6s@queper01-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180802153917.cpvls5hxkvevjh6s@queper01-lin>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Saravana Kannan <skannan@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ingo Molnar <mingo@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Chris Redpath <chris.redpath@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Valentin Schneider <valentin.schneider@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>, Thara Gopinath <thara.gopinath@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joel@joelfernandes.org>, Steve Muckle <smuckle@google.com>, adh
List-Id: linux-pm@vger.kernel.org

On Thursday 02 Aug 2018 at 16:39:18 (+0100), Quentin Perret wrote:
> Sounds good :-) Would kernel/sched/pelt.c be the right place then ? It's
> cross-class and kinda pelt-related I guess

Since we agreed to create a dependency between EAS and sugov, I don't think
there is a lot of value in relocating that function for now.

I'll leave it in cpufreq_schedutil.c for v6 until there is a good reason
to move it.

Thanks,
Quentin
