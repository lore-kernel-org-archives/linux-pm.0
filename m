From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v3] cpufreq: stats: clear statistics
Date: Tue, 8 Nov 2016 09:39:40 +0530
Message-ID: <20161108040940.GJ21030@vireshk-i7>
References: <20161107180223.44536-1-code@mmayer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161107180223.44536-1-code@mmayer.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Markus Mayer <code@mmayer.net>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Power Management List <linux-pm@vger.kernel.org>, Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Markus Mayer <mmayer@broadcom.com>
List-Id: linux-pm@vger.kernel.org

On 07-11-16, 10:02, Markus Mayer wrote:
> From: Markus Mayer <mmayer@broadcom.com>
> 
> Allow CPUfreq statistics to be cleared by writing anything to
> /sys/.../cpufreq/stats/reset.
> 
> Signed-off-by: Markus Mayer <mmayer@broadcom.com>
> ---
> 
> Changes since v2:
>     - changed name of write-only macro to cpufreq_freq_attr_wo()
>     - removed "perm" parameter from write-only macro
>     - squashed the two separate commits into a single one
> 
> Changes since v1:
>     - add new cpufreq_freq_attr_wr_perm() macro for write-only
>       attributes (because this is a separate commit, this patch has
>       turned into a series)
>     - remove the Kconfig option, compiling the code unconditionally
>     - remove show_reset()
>     - cpufreq_stats_clear_table() takes a struct cpufreq_stats * as
>       argument rather than a struct cpufreq_policy *
> 
>  Documentation/cpu-freq/cpufreq-stats.txt |  6 ++++++
>  drivers/cpufreq/cpufreq_stats.c          | 22 ++++++++++++++++++++++
>  include/linux/cpufreq.h                  |  4 ++++
>  3 files changed, 32 insertions(+)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
