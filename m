From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [RFC PATCH 0/7] Introduce thermal pressure
Date: Thu, 18 Oct 2018 09:50:33 +0200
Message-ID: <20181018075033.GA58819@gmail.com>
References: <1539102302-9057-1-git-send-email-thara.gopinath@linaro.org>
 <20181010061751.GA37224@gmail.com>
 <5BBE1E1F.3030308@linaro.org>
 <20181016073305.GA64994@gmail.com>
 <5BC76181.90105@linaro.org>
 <20181018064849.GA42813@gmail.com>
 <CAJZ5v0g=CnAv6HC6H68ub0KbO8Z8Fx4BtW=mjfEshNsnNX407w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0g=CnAv6HC6H68ub0KbO8Z8Fx4BtW=mjfEshNsnNX407w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Thara Gopinath <thara.gopinath@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Zhang, Rui" <rui.zhang@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Amit Kachhap <amit.kachhap@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>, Javi Merino <javi.merino@kernel.org>, Eduardo Valentin <edubezval@gmail.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Linux PM <linux-pm@vger.kernel.org>, Quentin Perret <quentin.perret@arm.com>, ionela.voinescu@arm.com, Vincent Guittot <vincent.guittot@linaro.org>
List-Id: linux-pm@vger.kernel.org


* Rafael J. Wysocki <rafael@kernel.org> wrote:

> > The only long term maintainable solution is to move all high level
> > cpufreq logic and policy handling code into kernel/sched/cpufreq*.c,
> > which has been done to a fair degree already in the past ~2 years - but
> > it's unclear to me to what extent this is true for thermal throttling
> > policy currently: there might be more governor surgery and code
> > reshuffling required?
> 
> It doesn't cover thermal management directly ATM.
> 
> The EAS work kind of hopes to make a connection in there by adding a
> common energy model to underlie both the performance scaling and
> thermal management, but it doesn't change the thermal decision making
> part AFAICS.
> 
> So it is fair to say that additional governor surgery and code
> reshuffling will be required IMO.

BTW., when factoring out high level thermal management code it might make 
sense to increase the prominence of the cpufreq code within the scheduler 
and organize it a bit better, by introducing its own 
kernel/sched/cpufreq/ directory and renaming things the following way:

  kernel/sched/cpufreq.c		=> kernel/sched/cpufreq/core.c
  kernel/sched/cpufreq_schedutil.c	=> kernel/sched/cpufreq/metrics.c
  kernel/sched/thermal.c		=> kernel/sched/cpufreq/thermal.c

... or so?

With no change to functionality, this is just a re-organization and 
expansion/preparation for the bright future. =B-)

Thanks,

	Ingo
