From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH V2 Resend 3/5] PM / OPP: Move opp core to its own
 directory
Date: Tue, 1 Sep 2015 15:51:15 -0700
Message-ID: <20150901225115.GB21112@codeaurora.org>
References: <cover.1441083292.git.viresh.kumar@linaro.org>
 <54ff6f4e8fe495d9a859a7a7aa61ac2e79f08551.1441083292.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <54ff6f4e8fe495d9a859a7a7aa61ac2e79f08551.1441083292.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, nm@ti.com, khilman@linaro.org, Anand Moon <moon.linux@yahoo.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On 09/01, Viresh Kumar wrote:
> OPP code is expanding and is already present in multiple directories
> (cpufreq and power). Lets move it to its own directory, to manage it
> better.
> 
> This also moves/renames the cpufreq_opp file to cpu.c, as it will
> contain helpers for cpu device. Its not just about cpufreq, other
> frameworks can use OPPs as well.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

> diff --git a/drivers/base/power/opp/Makefile b/drivers/base/power/opp/Makefile
> new file mode 100644
> index 000000000000..33c1e18c41a4
> --- /dev/null
> +++ b/drivers/base/power/opp/Makefile
> @@ -0,0 +1,2 @@
> +ccflags-$(CONFIG_DEBUG_DRIVER)	:= -DDEBUG

It's odd that we use CONFIG_DEBUG_DRIVER here when that's talking
about debugging the driver core. I wonder why this wouldn't be
some OPP specific debug config option instead. But that was
already there before so this topic is for another patch.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
