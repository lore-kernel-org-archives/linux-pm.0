From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH V3 01/13] cpufreq: governor: Create generic macro for
 global tuners
Date: Mon, 8 Feb 2016 17:33:14 +0100
Message-ID: <CAJZ5v0jndrALsqo6KSDCUNchn-jK45=UwjcG4_56u5SLQ50pHA@mail.gmail.com>
References: <cover.1454931188.git.viresh.kumar@linaro.org>
	<85b57a75b97bb7d900c9c7323e2e3e03c3d0e8d1.1454931188.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <85b57a75b97bb7d900c9c7323e2e3e03c3d0e8d1.1454931188.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Juri Lelli <juri.lelli@arm.com>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Saravana Kannan <skannan@codeaurora.org>, Peter Zijlstra <peterz@infradead.org>, Michael Turquette <mturquette@baylibre.com>, Steve Muckle <steve.muckle@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, dietmar.eggemann@arm.com, Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Feb 8, 2016 at 12:39 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> Some tunables are present in governor specific structures, whereas one
> (min_sampling_rate) is present in global 'struct dbs_data'.

To me, the word "global" is not the best one to express that.
"Common" would probably be better.  Or "generic" or similar.

It's just that these tunables apply to both governors (or "all"
governors if you will) as opposed to some other ones specific to a
particular governor type.

So I'd suggest replacing "global" with "common" in the patch in the
names of the macros too.

Thanks,
Rafael
