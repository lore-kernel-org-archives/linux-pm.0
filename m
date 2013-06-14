From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] power: Include additional information in pm_print_times
Date: Fri, 14 Jun 2013 09:41:35 -0700
Message-ID: <1371228095.31941.49.camel@joe-AO722>
References: <1371227625-3141-1-git-send-email-shuah.kh@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1371227625-3141-1-git-send-email-shuah.kh@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shuah Khan <shuah.kh@samsung.com>
Cc: pavel@ucw.cz, rjw@sisk.pl, len.brown@intel.com, gregkh@linuxfoundation.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, shuahkhan@gmail.com
List-Id: linux-pm@vger.kernel.org

On Fri, 2013-06-14 at 10:33 -0600, Shuah Khan wrote:
> Change __device_suspend() path to include driver name and the ops that
> get run for a device.
[]
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
[]
> -static ktime_t initcall_debug_start(struct device *dev)
> +static ktime_t initcall_debug_start(struct device *dev, char *info)
>  {
>  	ktime_t calltime = ktime_set(0, 0);
>  
>  	if (pm_print_times_enabled) {
> -		pr_info("calling  %s+ @ %i, parent: %s\n",
> +		pr_info("calling %s+ @ %i, parent: %s driver: %s %s\n",

dev_info(dev, etc...
