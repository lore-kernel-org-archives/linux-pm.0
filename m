From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/2] PM / Qos: Fix a free error in the dev_pm_qos_constraints_destroy()
Date: Thu, 01 Nov 2012 15:27:20 +0100
Message-ID: <1792079.RbGMIPVFk9@vostro.rjw.lan>
References: <1351766846-24654-1-git-send-email-tianyu.lan@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:50637 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761540Ab2KAOXO (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 1 Nov 2012 10:23:14 -0400
In-Reply-To: <1351766846-24654-1-git-send-email-tianyu.lan@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lan Tianyu <tianyu.lan@intel.com>
Cc: stern@rowland.harvard.edu, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org

On Thursday, November 01, 2012 06:47:25 PM Lan Tianyu wrote:
> Free a wrong point to struct dev_pm_qos->latency which suppose to
> be the point to struct dev_pm_qos. The patch is to fix the issue.
> 
> Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>

Thanks, will apply.

Rafael


> ---
>  drivers/base/power/qos.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/base/power/qos.c b/drivers/base/power/qos.c
> index 3a7687a..31d3f48 100644
> --- a/drivers/base/power/qos.c
> +++ b/drivers/base/power/qos.c
> @@ -253,7 +253,7 @@ void dev_pm_qos_constraints_destroy(struct device *dev)
>  	spin_unlock_irq(&dev->power.lock);
>  
>  	kfree(c->notifiers);
> -	kfree(c);
> +	kfree(qos);
>  
>   out:
>  	mutex_unlock(&dev_pm_qos_mtx);
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
