From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/2] cpufreq, intel_pstate, Fix limits->max_policy_pct
 rounding error
Date: Fri, 20 Nov 2015 20:49:44 +0530
Message-ID: <20151120151944.GE3957@ubuntu>
References: <1448022757-7856-1-git-send-email-prarit@redhat.com>
 <1448022757-7856-2-git-send-email-prarit@redhat.com>
 <20151120131833.GD3957@ubuntu>
 <564F37C8.60307@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:36116 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759820AbbKTPTu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 20 Nov 2015 10:19:50 -0500
Received: by pacdm15 with SMTP id dm15so119295770pac.3
        for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2015 07:19:50 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <564F37C8.60307@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Prarit Bhargava <prarit@redhat.com>
Cc: linux-kernel@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@intel.com>, Len Brown <len.brown@intel.com>, Alexandra Yates <alexandra.yates@intel.com>, Kristen Carlson Accardi <kristen@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org

On 20-11-15, 10:10, Prarit Bhargava wrote:
> >>  	limits->max_policy_pct = clamp_t(int, limits->max_policy_pct, 0 , 100);
> > 
> > And put this after the later one ?
> > 
> >> +	limits->max_policy_pct = DIV_ROUND_UP(policy->max * 100,
> >> +					      policy->cpuinfo.max_freq);
> >>  
> >>  	/* Normalize user input to [min_policy_pct, max_policy_pct] */
> >>  	limits->min_perf_pct = max(limits->min_policy_pct,
> > 
> > Sure you tested it  ? :)
> 
> Oops -- and yeah, tested.  It works because I rewrite the value of
> max_policy_pct :).  I'll repost shortly.

But we aren't doing below anymore, doesn't this change the
calculations at all?

  	limits->max_policy_pct = clamp_t(int, limits->max_policy_pct, 0 , 100);

-- 
viresh
