From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH 1/5] acpi: cppc: Allow build with ACPI_CPU_FREQ_PSS
 config
Date: Fri, 12 Aug 2016 05:34:43 -0700
Message-ID: <1471005283.22284.7.camel@linux.intel.com>
References: <1470874646-70570-1-git-send-email-srinivas.pandruvada@linux.intel.com>
	 <1470874646-70570-2-git-send-email-srinivas.pandruvada@linux.intel.com>
	 <20160812091337.GA7017@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20160812091337.GA7017@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Alexey Klimov <alexey.klimov@arm.com>
Cc: rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, ashwin.chaugule@linaro.org, pprakash@codeaurora.org, sudeep.holla@arm.com
List-Id: linux-pm@vger.kernel.org

On Fri, 2016-08-12 at 10:13 +0100, Alexey Klimov wrote:
> > 
> (adding Sudeep and Prashanth in c/c)
> 
> On Wed, Aug 10, 2016 at 05:17:22PM -0700, Srinivas Pandruvada wrote:

[...]

> >  	result = acpi_cppc_processor_probe(pr);
> > -	if (result)
> > +	if (result) {
> > +#ifndef CONFIG_ACPI_CPU_FREQ_PSS
> >  		return -ENODEV;
> > +#endif
> > +	}
> >  
> >  	if (!cpuidle_get_driver() || cpuidle_get_driver() ==
> > &acpi_idle_driver)
> >  		acpi_processor_power_init(pr);
> If PSS is not defined and kernel fails to probe CPPC then why we
> should not
> execute acpi_processor_power_init()?
Did I change the current behavior? Currently when 
acpi_cppc_processor_probe() fails, then -ENODEV is returned.

Thanks,
Srinivas

> 
> Best regards,
> Alexey
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
