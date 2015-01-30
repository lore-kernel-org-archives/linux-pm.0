From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 2/2] PM / QoS: Use lockdep asserts to find missing hold of power.lock
Date: Fri, 30 Jan 2015 01:18:06 +0100
Message-ID: <47446717.2V0dGQkMbA@vostro.rjw.lan>
References: <1420792078-14132-1-git-send-email-k.kozlowski@samsung.com> <1420792078-14132-2-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:58377 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751662AbbA2XzS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 29 Jan 2015 18:55:18 -0500
In-Reply-To: <1420792078-14132-2-git-send-email-k.kozlowski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Friday, January 09, 2015 09:27:58 AM Krzysztof Kozlowski wrote:
> Add lockdep asserts for holding the dev->power.lock to non-static
> functions which require this. They could be used outside of the file so
> asserts may help in detecting locking misuse.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Queued up for 3.20, thanks!

> ---
>  drivers/base/power/qos.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/base/power/qos.c b/drivers/base/power/qos.c
> index a8fe4c1a8d07..e56d538d039e 100644
> --- a/drivers/base/power/qos.c
> +++ b/drivers/base/power/qos.c
> @@ -64,6 +64,8 @@ enum pm_qos_flags_status __dev_pm_qos_flags(struct device *dev, s32 mask)
>  	struct pm_qos_flags *pqf;
>  	s32 val;
>  
> +	lockdep_assert_held(&dev->power.lock);
> +
>  	if (IS_ERR_OR_NULL(qos))
>  		return PM_QOS_FLAGS_UNDEFINED;
>  
> @@ -104,6 +106,8 @@ EXPORT_SYMBOL_GPL(dev_pm_qos_flags);
>   */
>  s32 __dev_pm_qos_read_value(struct device *dev)
>  {
> +	lockdep_assert_held(&dev->power.lock);
> +
>  	return IS_ERR_OR_NULL(dev->power.qos) ?
>  		0 : pm_qos_read_value(&dev->power.qos->resume_latency);
>  }
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
