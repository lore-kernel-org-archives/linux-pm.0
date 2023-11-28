Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 426A395;
	Tue, 28 Nov 2023 08:00:05 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5472A169E;
	Tue, 28 Nov 2023 08:00:52 -0800 (PST)
Received: from localhost (ionvoi01-desktop.cambridge.arm.com [10.2.78.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7E1E43F6C4;
	Tue, 28 Nov 2023 08:00:04 -0800 (PST)
Date: Tue, 28 Nov 2023 16:00:03 +0000
From: Ionela Voinescu <ionela.voinescu@arm.com>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	sudeep.holla@arm.com, gregkh@linuxfoundation.org, rafael@kernel.org,
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
	viresh.kumar@linaro.org, lenb@kernel.org, robert.moore@intel.com,
	lukasz.luba@arm.com, pierre.gondois@arm.com,
	beata.michalska@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
	conor.dooley@microchip.com, suagrfillet@gmail.com,
	ajones@ventanamicro.com, lftan@kernel.org
Subject: Re: [PATCH v6 1/7] topology: Add a new arch_scale_freq_reference
Message-ID: <ZWYOg1gIIgI1qXn7@arm.com>
References: <20231109101438.1139696-1-vincent.guittot@linaro.org>
 <20231109101438.1139696-2-vincent.guittot@linaro.org>
 <ZWYM0hn28RHjAalh@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWYM0hn28RHjAalh@arm.com>

On Tuesday 28 Nov 2023 at 15:52:52 (+0000), Ionela Voinescu wrote:
> Hi Vincent,
> 
> I have a small request on this patch, which is useful for [1].
> I'll detail what is needed lower in the code.
> 
> [1] https://lore.kernel.org/lkml/ZWYDr6JJJzBvsqf0@arm.com/
> 
> On Thursday 09 Nov 2023 at 11:14:32 (+0100), Vincent Guittot wrote:
> > @@ -279,13 +278,13 @@ void topology_normalize_cpu_scale(void)
> >  
> >  	capacity_scale = 1;
> >  	for_each_possible_cpu(cpu) {
> > -		capacity = raw_capacity[cpu] * per_cpu(freq_factor, cpu);
> > +		capacity = raw_capacity[cpu] * per_cpu(capacity_freq_ref, cpu);
> 
> The only affected code that I could find is here and below.
> 
> The above line would have to change to:
> capacity = raw_capacity[cpu] * per_cpu(capacity_freq_ref, cpu) ?: 1;
> 
> >  		capacity_scale = max(capacity, capacity_scale);
> >  	}
> >  
> >  	pr_debug("cpu_capacity: capacity_scale=%llu\n", capacity_scale);
> >  	for_each_possible_cpu(cpu) {
> > -		capacity = raw_capacity[cpu] * per_cpu(freq_factor, cpu);
> > +		capacity = raw_capacity[cpu] * per_cpu(capacity_freq_ref, cpu);
> 
> and here:
> capacity = raw_capacity[cpu] * per_cpu(capacity_freq_ref, cpu) ?: 1;
> 
> I think it's nicer to start with capacity_freq_ref as 0 and compensate here
> for uninitialized capacity_freq_ref.
> 
> Let me know if this is alright of if you'd prefer us to make this change
> in a separate patch.
> 
> Thanks,
> Ionela.
> 

Correction - both will need to be:
capacity = raw_capacity[cpu] * (per_cpu(capacity_freq_ref, cpu) ?: 1);

Thanks,
Ionela.
