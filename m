From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: pass policy to ->get() driver callback
Date: Thu, 10 Sep 2015 03:41:45 +0200
Message-ID: <11470100.cEo24Tpcgr@vostro.rjw.lan>
References: <98e79b26d8250c33001c7a50378b0e288b8511db.1438339396.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:42720 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752821AbbIJBNy (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 9 Sep 2015 21:13:54 -0400
In-Reply-To: <98e79b26d8250c33001c7a50378b0e288b8511db.1438339396.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Kristen Carlson Accardi <kristen@linux.intel.com>, open list <linux-kernel@vger.kernel.org>, Sudeep Holla <sudeep.holla@arm.com>

On Friday, July 31, 2015 04:14:33 PM Viresh Kumar wrote:
> CPUFreq drivers today support ->get(cpu) callback, which returns current
> clock rate of the CPU. The problem with ->get() is that it takes cpu
> number as parameter and this unnecessarily makes things complex.
> 
> Firstly the core gets the cpu number by doing operation 'policy->cpu' on
> the policy and then many drivers

I see one.  That unfortunately is the acpi-cpufreq driver, but it still is one.

Well, cpufreq_generic_get() does _get_raw(), so I suppose acpi-cpufreq may
do that too?

> need to get the policy back and so do
> cpufreq_cpu_get(cpu) on the cpu passed as argument to ->get().
> 
> It would be better if we pass them 'policy' directly and drivers can use
> policy->cpu if that's all they need.

Passing a pointer and dereferencing it is generally less efficient than passing
a number.  Before the patch the core has to do the dereference before calling
->get, so it likely doesn't matter here, but the code churn from this change
is quite substantial and the benefit from it is in the noise IMO.

Overall, we need to talk about the design aspect of cpufreq, because there
are much more significant issues in it than things like this one.

Thanks,
Rafael

