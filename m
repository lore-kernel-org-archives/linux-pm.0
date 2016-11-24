From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH V2 4/4] cpufreq: schedutil: irq-work and mutex are only
 used in slow path
Date: Thu, 24 Nov 2016 05:53:37 +0100
Message-ID: <20161124045337.GB18417@gmail.com>
References: <cover.1479197311.git.viresh.kumar@linaro.org>
 <a099804224d5e980a78668fa111e0564b0f44029.1479197311.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <a099804224d5e980a78668fa111e0564b0f44029.1479197311.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Juri Lelli <Juri.Lelli@arm.com>, Robin Randhawa <robin.randhawa@arm.com>, Steve Muckle <smuckle.linux@gmail.com>
List-Id: linux-pm@vger.kernel.org


Firstly, please start changes to scheduler code with a verb. This title:

  Subject: Re: [PATCH V2 4/4] cpufreq: schedutil: irq-work and mutex are only used in slow path

is totally inadequate as it's a statement that says nothing about the _change_.

What does the patch do? Does it add, remove, modify, fix or clean up?

* Viresh Kumar <viresh.kumar@linaro.org> wrote:

> Execute the irq-work specific initialization/exit code only when the
> fast path isn't available.

Is this an optimization? A correctness fix?

Thanks,

	Ingo
