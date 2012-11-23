From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 3.7+stable] pm: fix wrong error-checking condition
Date: Fri, 23 Nov 2012 21:36:55 +0100
Message-ID: <2410876.0MhetLSqTZ@vostro.rjw.lan>
References: <Pine.LNX.4.64.1211231601040.14984@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:35348 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756207Ab2KWUcX (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 23 Nov 2012 15:32:23 -0500
In-Reply-To: <Pine.LNX.4.64.1211231601040.14984@axis700.grange>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-pm@vger.kernel.org

On Friday, November 23, 2012 04:02:56 PM Guennadi Liakhovetski wrote:
> dev_pm_qos_add_request() can return 0, 1, or a negative error code,
> therefore the correct error test is "if (error < 0)." Checking just for
> non-zero return code leads to erroneous setting of the req->dev pointer
> to NULL, which then leads to a repeated call to
> dev_pm_qos_add_ancestor_request() in st1232_ts_irq_handler(). This in turn
> leads to an Oops, when the I2C host adapter is unloaded and reloaded again
> because of the inconsistent state of its QoS request list.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---
> 
> Hi Rafael, please push to 3.7 and to stable.

I will, thanks for the fix!

Rafael


>  drivers/base/power/qos.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/base/power/qos.c b/drivers/base/power/qos.c
> index 74a67e0..fbbd4ed 100644
> --- a/drivers/base/power/qos.c
> +++ b/drivers/base/power/qos.c
> @@ -451,7 +451,7 @@ int dev_pm_qos_add_ancestor_request(struct device *dev,
>  	if (ancestor)
>  		error = dev_pm_qos_add_request(ancestor, req, value);
>  
> -	if (error)
> +	if (error < 0)
>  		req->dev = NULL;
>  
>  	return error;
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
