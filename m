From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 02/10] cpufreq: conservative: Avoid races with transition
 notifier
Date: Thu, 25 Jun 2015 13:29:25 +0530
Message-ID: <20150625075925.GK27188@linux>
References: <cover.1434959517.git.viresh.kumar@linaro.org>
 <41ef05ed3b93677b4519e4c6c758753a7e63d432.1434959517.git.viresh.kumar@linaro.org>
 <55898105.2050907@linux.vnet.ibm.com>
 <20150624011151.GC6424@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:33642 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751213AbbFYH7b (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 25 Jun 2015 03:59:31 -0400
Received: by padev16 with SMTP id ev16so45294768pad.0
        for <linux-pm@vger.kernel.org>; Thu, 25 Jun 2015 00:59:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150624011151.GC6424@linux>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org

On 24-06-15, 06:41, Viresh Kumar wrote:
> On 23-06-15, 21:23, Preeti U Murthy wrote:
> > On 06/22/2015 01:32 PM, Viresh Kumar wrote:
> > > It is possible that cpufreq transition notifier is called while the
> > > governor is performing its EXIT operation. If this happens, 'ccdbs'
> > 
> > When does this happen ? As far as I can see, cpufreq transition notifier
> > gets called from the cpufreq kworker or when we set the cpufreq limits.
> 
> Which kworker are you talking about here ? The work-handlers of
> ondemand/conservative governors ?
> 
> Conservative governor has registered for transition notifier and that
> will be called every time frequency of a CPU is updated. And that has
> nothing to do with the governor callbacks. These notifiers are called
> from the ->target() routines of the drivers.
> 
> > And from your previous patches, an exit operation only proceeds after
> > ensuring that no kworker is running (check on ccdbs->policy). And LIMIT
> > operation does not run in parallel too.

Hmm, you were right. I Nack my own patch. :)

-- 
viresh
