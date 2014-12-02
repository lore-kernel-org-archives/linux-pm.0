From: "Javi Merino" <javi.merino@arm.com>
Subject: Re: [PATCH 11/26] cpu_cooling: propagate error returned by
 idr_alloc()
Date: Tue, 2 Dec 2014 15:35:31 +0000
Message-ID: <20141202153531.GB2834@e104805>
References: <cover.1417167599.git.viresh.kumar@linaro.org>
 <1cfc99a9a641f2937a8ac95c6b784e3eee033b0c.1417167599.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:52571 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752846AbaLBPfh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 2 Dec 2014 10:35:37 -0500
In-Reply-To: <1cfc99a9a641f2937a8ac95c6b784e3eee033b0c.1417167599.git.viresh.kumar@linaro.org>
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "edubezval@gmail.com" <edubezval@gmail.com>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "rui.zhang@intel.com" <rui.zhang@intel.com>

On Fri, Nov 28, 2014 at 09:44:05AM +0000, Viresh Kumar wrote:
> We aren't supposed to return our own error type here. Return what we got.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/thermal/cpu_cooling.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
> index bb11dd4..964586f 100644
> --- a/drivers/thermal/cpu_cooling.c
> +++ b/drivers/thermal/cpu_cooling.c
> @@ -477,7 +477,7 @@ __cpufreq_cooling_register(struct device_node *np,
>  	ret = get_idr(&cpufreq_idr, &cpufreq_dev->id);
>  	if (ret) {
>  		kfree(cpufreq_dev);
> -		return ERR_PTR(-EINVAL);
> +		return ERR_PTR(cpufreq_dev->id);

The error is ret, not the id which is probably 0 if there was an
error. So:

+		return ERR_PTR(ret);

Cheers,
Javi

