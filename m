From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH 1/4] cpufreq: Add configurable generic policies
Date: Mon, 07 Dec 2015 07:03:36 -0800
Message-ID: <1449500616.4009.1.camel@linux.intel.com>
References: <1449274118-15575-1-git-send-email-srinivas.pandruvada@linux.intel.com>
	 <1449274118-15575-2-git-send-email-srinivas.pandruvada@linux.intel.com>
	 <20151207093320.GE3294@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:23049 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932485AbbLGPFU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 7 Dec 2015 10:05:20 -0500
In-Reply-To: <20151207093320.GE3294@ubuntu>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rjw@rjwysocki.net, len.brown@intel.com, linux-pm@vger.kernel.org

On Mon, 2015-12-07 at 15:03 +0530, Viresh Kumar wrote:
> On 04-12-15, 16:08, Srinivas Pandruvada wrote:
> > diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> > index 177c768..8259c3c 100644
> > --- a/include/linux/cpufreq.h
> > +++ b/include/linux/cpufreq.h
> > @@ -76,6 +76,7 @@ struct cpufreq_policy {
> >  	unsigned int		restore_freq; /* = policy->cur
> > before transition */
> >  	unsigned int		suspend_freq; /* freq to set
> > during suspend */
> >  
> > +	u8			available_policies;

> Why don't we let the set-policy drivers fill in this field? No
> callback required then.
> 
That is fine with me. In next revision I will add that.

Thanks,
Srinivas
