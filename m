From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: pass policy to ->get() driver callback
Date: Fri, 04 Sep 2015 16:50:11 +0200
Message-ID: <2619258.SXQWVSsxpM@vostro.rjw.lan>
References: <98e79b26d8250c33001c7a50378b0e288b8511db.1438339396.git.viresh.kumar@linaro.org> <20150903044545.GI13140@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:53099 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932559AbbIDOW0 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 4 Sep 2015 10:22:26 -0400
In-Reply-To: <20150903044545.GI13140@linux>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Kristen Carlson Accardi <kristen@linux.intel.com>, open list <linux-kernel@vger.kernel.org>, Sudeep Holla <sudeep.holla@arm.com>

On Thursday, September 03, 2015 10:15:45 AM Viresh Kumar wrote:
> On 31-07-15, 16:14, Viresh Kumar wrote:
> > CPUFreq drivers today support ->get(cpu) callback, which returns current
> > clock rate of the CPU. The problem with ->get() is that it takes cpu
> > number as parameter and this unnecessarily makes things complex.
> > 
> > Firstly the core gets the cpu number by doing operation 'policy->cpu' on
> > the policy and then many drivers need to get the policy back and so do
> > cpufreq_cpu_get(cpu) on the cpu passed as argument to ->get().
> > 
> > It would be better if we pass them 'policy' directly and drivers can use
> > policy->cpu if that's all they need.
> > 
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> Is this getting moved to 4.4?

I'm really unsure about this change at all.

I have a concern that it may not go in the right direction.  I'll say more about
that later today.

Thanks,
Rafael

