From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH -next] i7300_idle: fix typo in parameter description
Date: Mon, 14 Nov 2016 01:35:06 +0100
Message-ID: <2091194.yr7fGkAp0D@vostro.rjw.lan>
References: <1477753891-1841-1-git-send-email-weiyj.lk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:47216 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751564AbcKNA1e (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 13 Nov 2016 19:27:34 -0500
In-Reply-To: <1477753891-1841-1-git-send-email-weiyj.lk@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: Andy Henroid <andrew.d.henroid@intel.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Wei Yongjun <weiyongjun1@huawei.com>, linux-pm@vger.kernel.org

On Saturday, October 29, 2016 03:11:31 PM Wei Yongjun wrote:
> From: Wei Yongjun <weiyongjun1@huawei.com>
> 
> Fix typo in parameter description.
> 
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  drivers/idle/i7300_idle.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/idle/i7300_idle.c b/drivers/idle/i7300_idle.c
> index 9a104e5..b570560 100644
> --- a/drivers/idle/i7300_idle.c
> +++ b/drivers/idle/i7300_idle.c
> @@ -44,7 +44,7 @@ MODULE_PARM_DESC(debug, "Enable debug printks in this driver");
>  
>  static int forceload;
>  module_param_named(forceload, forceload, uint, 0644);
> -MODULE_PARM_DESC(debug, "Enable driver testing on unvalidated i5000");
> +MODULE_PARM_DESC(forceload, "Enable driver testing on unvalidated i5000");
>  
>  #define dprintk(fmt, arg...) \
>  	do { if (debug) printk(KERN_INFO I7300_PRINT fmt, ##arg); } while (0)

Applied.

Thanks,
Rafael

