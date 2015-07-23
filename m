From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/2] cpufreq: Rename two functions related to CPU offline
Date: Thu, 23 Jul 2015 12:10:00 +0530
Message-ID: <20150723064000.GG5322@linux>
References: <7868353.pEStq1MJ2a@vostro.rjw.lan>
 <12623174.AEREjEhPIr@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <12623174.AEREjEhPIr@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>
List-Id: linux-pm@vger.kernel.org

On 23-07-15, 02:01, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Since __cpufreq_remove_dev_prepare() and __cpufreq_remove_dev_finish()
> are about CPU offline rather than about CPU removal, rename them to
> cpufreq_offline_prepare() and cpufreq_offline_finish(), respectively.
> 
> Also change their argument from a struct device pointer to a CPU
> number, because they use the CPU number only internally anyway.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpufreq/cpufreq.c |   14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
