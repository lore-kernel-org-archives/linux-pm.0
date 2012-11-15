From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 1/1] thermal: cpu_cooling: Make 'notify_device' static
Date: Thu, 15 Nov 2012 15:43:59 +0800
Message-ID: <1352965439.2080.13.camel@rzhang1-mobl4>
References: <1352962184-20970-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:2498 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423305Ab2KOHoB (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 15 Nov 2012 02:44:01 -0500
In-Reply-To: <1352962184-20970-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-pm@vger.kernel.org, hongbo.zhang@linaro.com, patches@linaro.org

On Thu, 2012-11-15 at 12:19 +0530, Sachin Kamat wrote:
> Silences the following sparse warning:
> 
> drivers/thermal/cpu_cooling.c:67:31: warning:
> symbol 'notify_device' was not declared. Should it be static?
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>

applied to therml-next.

thanks,
rui
> ---
>  drivers/thermal/cpu_cooling.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
> index 392d57d..6f94c2c 100644
> --- a/drivers/thermal/cpu_cooling.c
> +++ b/drivers/thermal/cpu_cooling.c
> @@ -64,7 +64,7 @@ static unsigned int cpufreq_dev_count;
>  
>  /* notify_table passes value to the CPUFREQ_ADJUST callback function. */
>  #define NOTIFY_INVALID NULL
> -struct cpufreq_cooling_device *notify_device;
> +static struct cpufreq_cooling_device *notify_device;
>  
>  /**
>   * get_idr - function to get a unique id.


