From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 3/9] cpufreq: governor: Fix nice contribution computation
 in dbs_check_cpu()
Date: Mon, 15 Feb 2016 13:59:13 +0530
Message-ID: <20160215082913.GI6334@vireshk-i7>
References: <3329748.lhJgppdTt9@vostro.rjw.lan>
 <4591302.DXuxEtjCGY@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4591302.DXuxEtjCGY@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Juri Lelli <juri.lelli@arm.com>
List-Id: linux-pm@vger.kernel.org

On 15-02-16, 02:15, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The contribution of the CPU nice time to the idle time in dbs_check_cpu()
> is computed in a bogus way, as the code may subtract current and previous
> nice values for different CPUs.
> 
> That doesn't matter for cases when cpufreq policies are not shared,
> but may lead to problems otherwise.
> 
> Fix the computation and simplify it to avoid taking unnecessary steps.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpufreq/cpufreq_governor.c |   18 +++---------------
>  1 file changed, 3 insertions(+), 15 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
