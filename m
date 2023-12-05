Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 48A0912C;
	Tue,  5 Dec 2023 03:05:11 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A48AE139F;
	Tue,  5 Dec 2023 03:05:57 -0800 (PST)
Received: from localhost (ionvoi01-desktop.cambridge.arm.com [10.2.78.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ACC663F5A1;
	Tue,  5 Dec 2023 03:05:10 -0800 (PST)
Date: Tue, 5 Dec 2023 11:05:09 +0000
From: Ionela Voinescu <ionela.voinescu@arm.com>
To: Sumit Gupta <sumitg@nvidia.com>
Cc: Beata Michalska <beata.michalska@arm.com>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
	sudeep.holla@arm.covm, will@kernel.org, catalin.marinas@arm.com,
	viresh.kumar@linaro.org, rafael@kernel.org,
	yang@os.amperecomputing.com, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v2 2/2] cpufreq: Wire-up arch-flavored freq info into
 cpufreq_verify_current_freq
Message-ID: <ZW8D5TfSwuJfdYeD@arm.com>
References: <20231127160838.1403404-1-beata.michalska@arm.com>
 <20231127160838.1403404-3-beata.michalska@arm.com>
 <ZWXy0h/fFfQh+Rhy@arm.com>
 <3e6077bb-907c-057f-0896-d0a5814a4229@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e6077bb-907c-057f-0896-d0a5814a4229@nvidia.com>

Hi Sumit,

On Friday 01 Dec 2023 at 18:32:10 (+0530), Sumit Gupta wrote:
> Hi Ionela,
> 
> > > --- a/drivers/cpufreq/cpufreq.c
> > > +++ b/drivers/cpufreq/cpufreq.c
> > > @@ -1756,7 +1756,8 @@ static unsigned int cpufreq_verify_current_freq(struct cpufreq_policy *policy, b
> > >   {
> > >        unsigned int new_freq;
> > > 
> > > -     new_freq = cpufreq_driver->get(policy->cpu);
> > > +     new_freq = arch_freq_get_on_cpu(policy->cpu);
> > > +     new_freq = new_freq ?: cpufreq_driver->get(policy->cpu);
> > 
> > Given that arch_freq_get_on_cpu() is an average frequency, it does not
> > seem right to me to trigger the sync & update process of
> > cpufreq_verify_current_freq() based on it.
> > 
> > cpufreq_verify_current_freq() will at least modify the internal state of
> > the policy and send PRE and POST notifications, if not do a full frequency
> > update, based on this average frequency, which is likely different from
> > the current frequency, even beyond the 1MHz threshold.
> > 
> > While I believe it's okay to return this average frequency in
> > cpuinfo_cur_freq, I don't think it should be used as an indication of
> > an accurate current frequency, which is what
> > cpufreq_verify_current_freq() expects.
> > 
> > Sumit, can you give more details on the issue at [1] and why this change
> > fixes it?
> > 
> > [1] https://lore.kernel.org/lkml/6a5710f6-bfbb-5dfd-11cd-0cd02220cee7@nvidia.com/
> > 
> > Thank you,
> > Ionela.
> > 
> cpufreq_verify_current_freq() also updates 'policy->cur' in POST
> notification if the frequency from hardware has more delta (out of sync).
> 
> As the value from 'cpufreq_driver->get()' is not reliable due to [1],
> calling the 'get' hook can update the 'policy->cur' with a wrong value when
> governor starts in cpufreq_start_governor().
> And if the frequency is never changed after the governor starts during
> boot e.g. when performance governor is set as default, then
> 'scaling_cur_freq' always returns wrong value.
> 
> Instead, the arch_freq_get_on_cpu() API updates 'policy->cur' with a more
> stable freq value.
> 
> [1] https://lore.kernel.org/lkml/20230418113459.12860-7-sumitg@nvidia.com/

Got it, many thanks! 

As the code is right now in v2, arch_freq_get_on_cpu() is called on
show_scaling_cur_freq(), so the problem you describe would not show up.
policy->cur would still be incorrect, but 'scaling_cur_freq' would
return the value from arch_freq_get_on_cpu().

Would it be enough if arch_freq_get_on_cpu() gets also called from
show_cpuinfo_cur_freq() instead of cpufreq_verify_current_freq()?

Thanks,
Ionela.

> 
> Best regards,
> Sumit Gupta
> 
> > >        if (!new_freq)
> > >                return 0;
> > > 
> > > --
> > > 2.25.1
> > > 
