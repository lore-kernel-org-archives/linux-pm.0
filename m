From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PM / QoS: Use the correct variable to check the QoS request type
Date: Tue, 19 Sep 2017 23:17:22 +0200
Message-ID: <1725795.LCqil3DtTG@aspire.rjw.lan>
References: <1504646069-4216-1-git-send-email-jschoenh@amazon.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:63350 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751309AbdISV00 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Sep 2017 17:26:26 -0400
In-Reply-To: <1504646069-4216-1-git-send-email-jschoenh@amazon.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jan =?ISO-8859-1?Q?H=2E_Sch=F6nherr?= <jschoenh@amazon.de>
Cc: linux-pm@vger.kernel.org

On Tuesday, September 5, 2017 11:14:29 PM CEST Jan H. Schönherr wrote:
> Use the actual function argument for the validation of the request type,
> instead of the type field in a fresh (supposedly zero-initialized)
> request structure.
> 
> Signed-off-by: Jan H. Schönherr <jschoenh@amazon.de>
> ---
>  drivers/base/power/qos.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/base/power/qos.c b/drivers/base/power/qos.c
> index f850dae..277d43a 100644
> --- a/drivers/base/power/qos.c
> +++ b/drivers/base/power/qos.c
> @@ -277,11 +277,11 @@ void dev_pm_qos_constraints_destroy(struct device *dev)
>  	mutex_unlock(&dev_pm_qos_sysfs_mtx);
>  }
>  
> -static bool dev_pm_qos_invalid_request(struct device *dev,
> -				       struct dev_pm_qos_request *req)
> +static bool dev_pm_qos_invalid_req_type(struct device *dev,
> +					enum dev_pm_qos_req_type type)
>  {
> -	return !req || (req->type == DEV_PM_QOS_LATENCY_TOLERANCE
> -			&& !dev->power.set_latency_tolerance);
> +	return type == DEV_PM_QOS_LATENCY_TOLERANCE &&
> +	       !dev->power.set_latency_tolerance;
>  }
>  
>  static int __dev_pm_qos_add_request(struct device *dev,
> @@ -290,7 +290,7 @@ static int __dev_pm_qos_add_request(struct device *dev,
>  {
>  	int ret = 0;
>  
> -	if (!dev || dev_pm_qos_invalid_request(dev, req))
> +	if (!dev || !req || dev_pm_qos_invalid_req_type(dev, type))
>  		return -EINVAL;
>  
>  	if (WARN(dev_pm_qos_request_active(req),
> 

Applied, thanks!
