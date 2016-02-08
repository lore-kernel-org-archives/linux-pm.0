From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V3 12/13] cpufreq: ondemand: Traverse list of policy_dbs
 in update_sampling_rate()
Date: Mon, 8 Feb 2016 19:04:46 +0530
Message-ID: <20160208133446.GK8294@vireshk>
References: <cover.1454931188.git.viresh.kumar@linaro.org>
 <bb6f1b48f09cfe1f0322b1718bf797f8cf5e108c.1454931189.git.viresh.kumar@linaro.org>
 <CAJZ5v0iVbzuPdNLyTcih5-U7c7AJOZ_zqmHkLN0AckCPzZpDFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0iVbzuPdNLyTcih5-U7c7AJOZ_zqmHkLN0AckCPzZpDFw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Juri Lelli <juri.lelli@arm.com>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Saravana Kannan <skannan@codeaurora.org>, Peter Zijlstra <peterz@infradead.org>, Michael Turquette <mturquette@baylibre.com>, Steve Muckle <steve.muckle@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, dietmar.eggemann@arm.com, Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 08-02-16, 14:32, Rafael J. Wysocki wrote:
> > - * If new rate is smaller than the old, simply updating
> > - * dbs_tuners_int.sampling_rate might not be appropriate. For example, if the
> > - * original sampling_rate was 1 second and the requested new sampling rate is 10
> > - * ms because the user needs immediate reaction from ondemand governor, but not
> > - * sure if higher frequency will be required or not, then, the governor may
> > - * change the sampling rate too late; up to 1 second later. Thus, if we are
> > - * reducing the sampling rate, we need to make the new value effective
> > - * immediately.
> 
> The comment still applies.

Why? It talks about the case where we have reduced sampling rate, but
that's not the case anymore. We *always* update sample_delay_ns now.

> Moreover, please extend it to say that this must be called with
> dbs_data->mutex held (or it looks racy otherwise).

Yeah, that can be done.
