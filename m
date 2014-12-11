From: "Kasagar, Srinidhi" <srinidhi.kasagar@intel.com>
Subject: Re: [PATCH v7] cpufreq: Add SFI based cpufreq driver support
Date: Thu, 11 Dec 2014 14:43:19 +0530
Message-ID: <20141211091319.GA3424@intel-desktop>
References: <20141211081438.GA2885@intel-desktop>
 <CAKohpomraR_9pywLSM+sRtAS7i31=KwWSTsbW3fSZ6pDDADAoA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:19612 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932531AbaLKJLq (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 11 Dec 2014 04:11:46 -0500
Content-Disposition: inline
In-Reply-To: <CAKohpomraR_9pywLSM+sRtAS7i31=KwWSTsbW3fSZ6pDDADAoA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Brown, Len" <len.brown@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rudramuni, Vishwesh M" <vishwesh.m.rudramuni@intel.com>, srinidhi.kasagar@intel.com

On Thu, Dec 11, 2014 at 01:52:33PM +0530, Viresh Kumar wrote:
> On 11 December 2014 at 13:44, Srinidhi Kasagar
> <srinidhi.kasagar@intel.com> wrote:
> > diff --git a/drivers/cpufreq/sfi-cpufreq.c b/drivers/cpufreq/sfi-cpufreq.c
> 
> > +static DEFINE_PER_CPU(struct cpufreq_frequency_table *, drv_data);
> 
> You don't need to store this information anywhere, its already present
> in policy->freq_table; Just use that and get rid of the per-cpu stuff..

That's wonderful and keeping freq table per policy makes more sense..
Will fix that; finally you made me to get rid of that
per-cpu stuff :). Thank you Viresh.

Srinidhi

> 
> Other than that, Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
