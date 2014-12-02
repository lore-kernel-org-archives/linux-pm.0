From: "Javi Merino" <javi.merino@arm.com>
Subject: Re: [PATCH 08/26] cpu_cooling: Pass variable instead of its type to
 sizeof()
Date: Tue, 2 Dec 2014 15:26:24 +0000
Message-ID: <20141202152624.GA2834@e104805>
References: <cover.1417167599.git.viresh.kumar@linaro.org>
 <1a0d2430eb52b55fdb8f82c4cbbb8b4038a105ec.1417167599.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:55830 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750908AbaLBP03 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 2 Dec 2014 10:26:29 -0500
In-Reply-To: <1a0d2430eb52b55fdb8f82c4cbbb8b4038a105ec.1417167599.git.viresh.kumar@linaro.org>
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "edubezval@gmail.com" <edubezval@gmail.com>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "rui.zhang@intel.com" <rui.zhang@intel.com>

Hi Viresh,

On Fri, Nov 28, 2014 at 09:44:02AM +0000, Viresh Kumar wrote:
> Just following coding guidelines here.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/thermal/cpu_cooling.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
> index def0f21..59725d8 100644
> --- a/drivers/thermal/cpu_cooling.c
> +++ b/drivers/thermal/cpu_cooling.c
> @@ -468,8 +468,7 @@ __cpufreq_cooling_register(struct device_node *np,
>  				return ERR_PTR(-EINVAL);
>  		}
>  	}
> -	cpufreq_dev = kzalloc(sizeof(struct cpufreq_cooling_device),
> -			      GFP_KERNEL);
> +	cpufreq_dev = kzalloc(sizeof(*cool_dev), GFP_KERNEL);

This should be:

+	cpufreq_dev = kzalloc(sizeof(*cpufreq_dev), GFP_KERNEL);

Cheers,
Javi

