From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [RFC][PATCH] cpufreq: intel_pstate: Support of energy
 performance hint using HWP
Date: Thu, 17 Nov 2016 11:31:32 -0800
Message-ID: <1479411092.6544.129.camel@linux.intel.com>
References: <1479250783-74336-1-git-send-email-srinivas.pandruvada@linux.intel.com>
         <1479250783-74336-2-git-send-email-srinivas.pandruvada@linux.intel.com>
         <20161117064954.GD4894@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:55923 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751161AbcKQTbd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 17 Nov 2016 14:31:33 -0500
In-Reply-To: <20161117064954.GD4894@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rjw@rjwysocki.net, morten.rasmussen@arm.com, Juri.Lelli@arm.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Viresh,
On Thu, 2016-11-17 at 12:19 +0530, Viresh Kumar wrote:
> Hi Srinivas,
> 
> I don't think other platforms need it for now and so it is fine to
> add these to the driver itself.
Good to know. In this case I will proceed with change only local to
intel_pstate.

> 
> On 15-11-16, 14:59, Srinivas Pandruvada wrote:
> > 
> > +static ssize_t show_energy_performance_available_preferences(
> 
> Maybe a personal preference, but I would have broken the line after
> ssize_t instead of where you have done it.
I can change that.

> 
> > 
> > +				struct cpufreq_policy *policy,
> > char *buf)
> > +{
> > +static struct freq_attr *hwp_cpufreq_attrs[] = {
> > +	&energy_performance_preference,
> > +	&energy_performance_available_preferences,
> > +	NULL,
> > +};
> 
> What about adding these to intel_pstate_attr_group instead ?
Sure.

Thanks,
Srinivas
