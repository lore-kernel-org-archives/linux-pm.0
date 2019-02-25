From: Qais Yousef <qais.yousef@arm.com>
Subject: Re: [PATCH V2 4/5] cpufreq: Register notifiers with the PM QoS
 framework
Date: Mon, 25 Feb 2019 12:14:58 +0000
Message-ID: <20190225121458.fvdiiumgyhhdardw@e107158-lin.cambridge.arm.com>
References: <cover.1550748118.git.viresh.kumar@linaro.org>
 <e6969d79643c87af24895d508e5c6f7462b1c758.1550748118.git.viresh.kumar@linaro.org>
 <20190222114446.cmwoe7tanxvf2gxh@e107158-lin.cambridge.arm.com>
 <20190225043149.bfl5vdb57xaaje2w@vireshk-i7>
 <20190225085847.yvrtmxtwvk725b7v@e107158-lin.cambridge.arm.com>
 <20190225090955.suq4jw26d2brkjha@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190225090955.suq4jw26d2brkjha@vireshk-i7>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, mka@chromium.org, juri.lelli@gmail.com, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 02/25/19 14:39, Viresh Kumar wrote:
> On 25-02-19, 08:58, Qais Yousef wrote:
> > On 02/25/19 10:01, Viresh Kumar wrote:
> > > > > +	min = dev_pm_qos_read_value(cpu_dev, DEV_PM_QOS_MIN_FREQUENCY);
> > > > > +	max = dev_pm_qos_read_value(cpu_dev, DEV_PM_QOS_MAX_FREQUENCY);
> > > > > +
> > > > > +	if (min > new_policy->min)
> > > > > +		new_policy->min = min;
> > > > > +	if (max < new_policy->max)
> > > > > +		new_policy->max = max;
> 
> > And this is why we need to check here if the PM QoS value doesn't conflict with
> > the current min/max, right? Until the current notifier code is removed they
> > could trip over each others.
> 
> No. The above if/else block is already removed as part of patch 5/5. It was
> required because of conflict between userspace specific min/max and qos min/max,
> which are migrated to use qos by patc 5/5.
> 
> The cpufreq notifier mechanism already lets users play with min/max and that is
> already safe from conflicts.
> 
> 
> > It would be nice to add a comment here about PM QoS managing and remembering
> > values
> 
> I am not sure if that would add any value. Some documentation update may be
> useful for people looking for details though, that I shall do after all the
> changes get in and things become a bit stable.
> 

Up to you. But not everyone is familiar with the code and a one line comment
that points to where aggregation is happening would be helpful for someone
scanning this code IMHO.

> > and that we need to be careful that both mechanisms don't trip over
> > each others until this transient period is over.
> 
> The second mechanism will die very very soon once this is merged, migrating them
> shouldn't be a big challenge AFAICT. I didn't attempt that because I didn't
> wanted to waste time updating things in case this version also doesn't make
> sense to others.
> 
> > I have a nit too. It would be nice to explicitly state this is
> > CPU_{MIN,MAX}_FREQUENCY. I can see someone else adding {MIN,MAX}_FREQUENCY for
> > something elsee (memory maybe?)
> 
> This is not CPU specific, but any device. The same interface shall be used by
> devfreq as well, who wanted to use freq-constraints initially.
> 

I don't get that to be honest. I probably have to read more.

Is what you're saying that when applying a MIN_FREQUENCY constraint the same
value will be applied to both cpufreq and devfreq? Isn't this too coarse?

> > Although I looked at the previous series briefly, but this one looks more
> > compact and easier to follow, so +1 for that.
> 
> Thanks for looking into this Qais.
> 
> -- 
> viresh

Thanks

--
Qais Yousef
