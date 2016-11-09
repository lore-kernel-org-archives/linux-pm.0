From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH] PM / devfreq: correct comment typo.
Date: Wed, 09 Nov 2016 10:46:31 +0900
Message-ID: <58227FF7.9040208@samsung.com>
References: <CGME20161109013921epcms1p7e3a7f9daf4899a395dc0e73b1aa762df@epcms1p7>
 <698260245.615933.1478655561574.JavaMail.weblogic@ep2ml103c>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:44008 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751032AbcKIBqd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Nov 2016 20:46:33 -0500
Received: from epcpsbgm1new.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0OGC01I9LQ91HT60@mailout1.samsung.com> for
 linux-pm@vger.kernel.org; Wed, 09 Nov 2016 10:46:31 +0900 (KST)
In-reply-to: <698260245.615933.1478655561574.JavaMail.weblogic@ep2ml103c>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: myungjoo.ham@samsung.com, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 2016년 11월 09일 10:39, MyungJoo Ham wrote:
> 
> The function name in the comment was incorrect.
> 
> Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
> ---
>  drivers/devfreq/devfreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index bf3ea76..a324801 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -850,7 +850,7 @@ int devfreq_add_governor(struct devfreq_governor *governor)
>  EXPORT_SYMBOL(devfreq_add_governor);
>  
>  /**
> - * devfreq_remove_device() - Remove devfreq feature from a device.
> + * devfreq_remove_governor() - Remove devfreq feature from a device.
>   * @governor:	the devfreq governor to be removed
>   */
>  int devfreq_remove_governor(struct devfreq_governor *governor)
> 

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
