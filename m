From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v6 10/14] sched/cpufreq: Refactor the utilization aggregation method
Date: Mon, 10 Sep 2018 12:25:02 +0200
Message-ID: <26961140.kuCyhvbGLP@aspire.rjw.lan>
References: <20180820094420.26590-1-quentin.perret@arm.com> <3619149.Cl0Cp2apok@aspire.rjw.lan> <20180910100719.uan6gskxpgu25dj5@queper01-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180910100719.uan6gskxpgu25dj5@queper01-lin>
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Perret <quentin.perret@arm.com>
Cc: peterz@infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, gregkh@linuxfoundation.org, mingo@redhat.com, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, chris.redpath@arm.com, patrick.bellasi@arm.com, valentin.schneider@arm.com, vincent.guittot@linaro.org, thara.gopinath@linaro.org, viresh.kumar@linaro.org, tkjos@google.com, joel@joelfernandes.org, smuckle@google.com, adharmap@codeaurora.org, skannan@codeaurora.org, pkondeti@codeaurora.org, juri.lelli@redhat.com, edubezval@gmail.com, srinivas.pandruvada@linux.intel.com, currojerez@riseup.net, javi.merino@kernel.org
List-Id: linux-pm@vger.kernel.org

On Monday, September 10, 2018 12:07:21 PM CEST Quentin Perret wrote:
> On Monday 10 Sep 2018 at 11:53:58 (+0200), Rafael J. Wysocki wrote:
> > On Monday, August 20, 2018 11:44:16 AM CEST Quentin Perret wrote:
> > > Schedutil aggregates the PELT signals of CFS, RT, DL and IRQ in order
> > > to decide which frequency to request. Energy Aware Scheduling (EAS)
> > > needs to be able to predict those requests to assess the energy impact
> > > of scheduling decisions. However, the PELT signals aggregation is only
> > > done in schedutil for now, hence making it hard to synchronize it with
> > > EAS.
> > > 
> > > To address this issue, introduce schedutil_freq_util() to perform the
> > > aforementioned aggregation and make it available to other parts of the
> > > scheduler. Since frequency selection and energy estimation still need
> > > to deal with RT and DL signals slightly differently, schedutil_freq_util()
> > > is called with a different 'type' parameter in those two contexts, and
> > > returns an aggregated utilization signal accordingly.
> > 
> > This is complementary to patch [02/14] IMO.
> > 
> > schedutil_freq_util() and map_util_freq() introduced by that patch should
> > always be used together as they are two parts of one algorithm in my view.
> 
> I agree.
> 
> > Would it be possible to make that clearer?
> 
> I could squash the two at the beginning of the series in a preparatory
> patch that refactors schedutil for EAS all in one go, with a clear
> mention of what we intend to do (make EAS depend on sugov) in the commit
> message.
> 
> Would that work ?

I think so.

Thanks,
Rafael
