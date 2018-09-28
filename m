From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v7 02/14] sched/cpufreq: Prepare schedutil for Energy Aware Scheduling
Date: Fri, 28 Sep 2018 10:35:31 +0200
Message-ID: <1955193.fk0stZ6klG@aspire.rjw.lan>
References: <20180912091309.7551-1-quentin.perret@arm.com> <2417577.QmA9JEQx1z@aspire.rjw.lan> <20180928083503.h4jbdgk3dqpaufzb@queper01-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180928083503.h4jbdgk3dqpaufzb@queper01-lin>
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Perret <quentin.perret@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ingo Molnar <mingo@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Chris Redpath <chris.redpath@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Valentin Schneider <valentin.schneider@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>, Thara Gopinath <thara.gopinath@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joel@joelfernandes.org>, Steve Muckle <smuckle@google.com>, adharmap@codeaurora.org, Saravana Kannan <skann>
List-Id: linux-pm@vger.kernel.org

On Friday, September 28, 2018 10:35:05 AM CEST Quentin Perret wrote:
> Hi Rafael,
> 
> On Friday 28 Sep 2018 at 10:23:42 (+0200), Rafael J. Wysocki wrote:
> [...]
> > OK, so please document the enum type.
> 
> Will do.
> 
> [...]
> > Documenting things properly is absolutely required.
> 
> Understood.
> 
> > The other changes suggested by me are rather straightforward, so why would it
> > be a problem to make them right away if you agree to make them?
> 
> Right, if I need to spin a v8 for doc purpose anyway, I guess I can do
> the other small fixes at the same time.
> 
> I'll wait a bit before sending the update to see if others have some
> feedback. It's probably a bit late for 4.20 anyway ... Or is it not ?

I think this is scheduler material anyway, even though it affects cpufreq
somewhat, so that depends on what Peter thinks really.

Thanks,
Rafael
