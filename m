From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 07/10] cpufreq: ondemand: queue work for policy->cpus
 together
Date: Fri, 26 Jun 2015 14:22:30 +0530
Message-ID: <20150626085230.GG16275@linux>
References: <cover.1434959517.git.viresh.kumar@linaro.org>
 <66980e2b51a83bf34f6fd18ee55155b6c667aa6a.1434959517.git.viresh.kumar@linaro.org>
 <558D0D32.7060001@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:36067 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751673AbbFZIwg (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 26 Jun 2015 04:52:36 -0400
Received: by paceq1 with SMTP id eq1so65232286pac.3
        for <linux-pm@vger.kernel.org>; Fri, 26 Jun 2015 01:52:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <558D0D32.7060001@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org

On 26-06-15, 13:58, Preeti U Murthy wrote:
> > +		/*
> > +		 * Checking this for any CPU of the policy is fine. As either
> > +		 * all would have queued work or none.
> 
> Are you sure that the state of the work will be the same across all
> policy cpus ? 'Pending' only refers to twork awaiting for the timer to
> fire and then queue itself on the runqueue right ? On some of the
> policy->cpus, timers may be yet to fire, while on others it might
> already have ?

I think a better way to check this is to check if the governor is
stopped or not. i.e. by checking ccdbs->policy. Will fix that.

-- 
viresh
