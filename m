From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/2] cpufreq: powernv: Ramp-down global pstate slower
 than local-pstate
Date: Thu, 14 Apr 2016 07:49:27 +0530
Message-ID: <20160414021927.GK19433@vireshk-i7>
References: <1460484386-28389-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
 <1460484386-28389-3-git-send-email-akshay.adiga@linux.vnet.ibm.com>
 <20160413050310.GE19433@vireshk-i7>
 <570E889F.2010401@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f170.google.com ([209.85.192.170]:34054 "EHLO
	mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750985AbcDNCTb (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 13 Apr 2016 22:19:31 -0400
Received: by mail-pf0-f170.google.com with SMTP id c20so40955456pfc.1
        for <linux-pm@vger.kernel.org>; Wed, 13 Apr 2016 19:19:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <570E889F.2010401@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Cc: rjw@rjwysocki.net, linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, ego@linux.vnet.ibm.com

On 13-04-16, 23:27, Akshay Adiga wrote:
> On 04/13/2016 10:33 AM, Viresh Kumar wrote:
> >>+void gpstate_timer_handler(unsigned long data)
> >>+{
> >>+	struct cpufreq_policy *policy = (struct cpufreq_policy *) data;
> >no need to cast.
> 
> May be i need a cast here,  because data is unsigned long ( unlike other places where its void *).
> On building without cast, it throws me a warning.

My bad, yeah :(

> >>+	if (freq_data.gpstate_id != freq_data.pstate_id)
> >>+		ret = queue_gpstate_timer(gpstates);
> >ret not used.
> 
> Should i make it void instead of returning int?, as i cannot do much even if it fails, except for notifying.

Sure.

-- 
viresh
