From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 9/9] cpufreq: governor: Use microseconds in sample delay
 computations
Date: Mon, 15 Feb 2016 14:28:50 +0530
Message-ID: <20160215085850.GQ6334@vireshk-i7>
References: <3329748.lhJgppdTt9@vostro.rjw.lan>
 <9344385.GMvgsk6ndT@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <9344385.GMvgsk6ndT@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Juri Lelli <juri.lelli@arm.com>
List-Id: linux-pm@vger.kernel.org

On 15-02-16, 02:22, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Do not convert microseconds to jiffies and the other way around
> in governor computations related to the sampling rate and sample
> delay and drop delay_for_sampling_rate() which isn't of any use
> then.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpufreq/cpufreq_conservative.c |    2 +-
>  drivers/cpufreq/cpufreq_governor.c     |    4 +---
>  drivers/cpufreq/cpufreq_governor.h     |   15 ++-------------
>  drivers/cpufreq/cpufreq_ondemand.c     |   28 +++++++++++++---------------
>  4 files changed, 17 insertions(+), 32 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
