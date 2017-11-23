From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/4] cpufreq: Pass policy pointer to
 cpufreq_parse_governor()
Date: Thu, 23 Nov 2017 09:26:14 +0530
Message-ID: <20171123035614.GD4084@vireshk-i7>
References: <1655574.Es7zYAeW1r@aspire.rjw.lan>
 <2577003.K0dSmlKcgZ@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2577003.K0dSmlKcgZ@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

On 23-11-17, 01:24, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Pass policy pointer to cpufreq_parse_governor() instead of passing
> pointers to two members of it so as to make the code slightly more
> straightforward.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpufreq/cpufreq.c |   16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
