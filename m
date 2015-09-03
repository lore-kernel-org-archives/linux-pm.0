From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: pass policy to ->get() driver callback
Date: Thu, 3 Sep 2015 10:15:45 +0530
Message-ID: <20150903044545.GI13140@linux>
References: <98e79b26d8250c33001c7a50378b0e288b8511db.1438339396.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:35795 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754295AbbICEpw (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 3 Sep 2015 00:45:52 -0400
Received: by pacfv12 with SMTP id fv12so34414964pac.2
        for <linux-pm@vger.kernel.org>; Wed, 02 Sep 2015 21:45:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <98e79b26d8250c33001c7a50378b0e288b8511db.1438339396.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Kristen Carlson Accardi <kristen@linux.intel.com>, open list <linux-kernel@vger.kernel.org>, Sudeep Holla <sudeep.holla@arm.com>

On 31-07-15, 16:14, Viresh Kumar wrote:
> CPUFreq drivers today support ->get(cpu) callback, which returns current
> clock rate of the CPU. The problem with ->get() is that it takes cpu
> number as parameter and this unnecessarily makes things complex.
> 
> Firstly the core gets the cpu number by doing operation 'policy->cpu' on
> the policy and then many drivers need to get the policy back and so do
> cpufreq_cpu_get(cpu) on the cpu passed as argument to ->get().
> 
> It would be better if we pass them 'policy' directly and drivers can use
> policy->cpu if that's all they need.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Is this getting moved to 4.4?

-- 
viresh
