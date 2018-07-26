From: Quentin Perret <quentin.perret@arm.com>
Subject: Re: [PATCH v5 06/14] sched/topology: Lowest energy aware balancing
 sched_domain level pointer
Date: Thu, 26 Jul 2018 18:01:48 +0100
Message-ID: <20180726170146.k5mx2px46blrdiqj@queper01-lin>
References: <20180724122521.22109-1-quentin.perret@arm.com>
 <20180724122521.22109-7-quentin.perret@arm.com>
 <76777be2-0f70-ca54-21a8-5af77a47ea86@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <76777be2-0f70-ca54-21a8-5af77a47ea86@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Valentin Schneider <valentin.schneider@arm.com>
Cc: peterz@infradead.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, gregkh@linuxfoundation.org, mingo@redhat.com, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, chris.redpath@arm.com, patrick.bellasi@arm.com, vincent.guittot@linaro.org, thara.gopinath@linaro.org, viresh.kumar@linaro.org, tkjos@google.com, joel@joelfernandes.org, smuckle@google.com, adharmap@quicinc.com, skannan@quicinc.com, pkondeti@codeaurora.org, juri.lelli@redhat.com, edubezval@gmail.com, srinivas.pandruvada@linux.intel.com, currojerez@riseup.net, javi.merino@kernel.org
List-Id: linux-pm@vger.kernel.org

On Thursday 26 Jul 2018 at 17:00:50 (+0100), Valentin Schneider wrote:
> > +DECLARE_PER_CPU(struct sched_domain *, sd_ea);
> 
> There's already the asym-packing shortcut which is making naming a bit more
> tedious, but should that really be named energy-aware? IMO it's just the
> lowest level at which we can see asymmetry, so perhaps it should be named
> as such, i.e. something like sd_asym_capa (and perhaps rename the other one
> as sd_asym_pack)?

So the 'sd_ea' name comes from the usage we do of this shortcut, and also
because this is how the EAS shortcut has always been called, historically.

But TBH, if nobody is against that, I don't mind changing the name at all.
And maybe we should go for the longer names ? 'sd_asym_packing' and
'sd_asym_cpucapacity' aren't that long, I think. And they're
descriptive :-)

Thanks,
Quentin
