From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH] extcon: class: Add NULL pointer checking for removing
 notifier block.
Date: Fri, 14 Jun 2013 16:17:49 +0900
Message-ID: <51BAC39D.6020909@samsung.com>
References: <1371175897-3001-1-git-send-email-jonghwa3.lee@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:11021 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751514Ab3FNHSA (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 14 Jun 2013 03:18:00 -0400
In-reply-to: <1371175897-3001-1-git-send-email-jonghwa3.lee@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jonghwa Lee <jonghwa3.lee@samsung.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, MyungJoo Ham <myungjoo.ham@samsung.com>

On 06/14/2013 11:11 AM, Jonghwa Lee wrote:
> This patch adds NULL pointer checking of extcon device to 'extcon_unregister
> _interest' which unregisters extcon notifier block.
> 
> Signed-off-by: Jonghwa Lee <jonghwa3.lee@samsung.com>
> Signed-off-by: Myungjoo Ham <myungjoo.ham@samsung.com>
> ---
>  drivers/extcon/extcon-class.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/extcon/extcon-class.c b/drivers/extcon/extcon-class.c
> index 8c69803..23f11ea 100644
> --- a/drivers/extcon/extcon-class.c
> +++ b/drivers/extcon/extcon-class.c
> @@ -491,7 +491,7 @@ EXPORT_SYMBOL_GPL(extcon_register_interest);
>   */
>  int extcon_unregister_interest(struct extcon_specific_cable_nb *obj)
>  {
> -	if (!obj)
> +	if (!obj || !obj->edev)
>  		return -EINVAL;
>  
>  	return raw_notifier_chain_unregister(&obj->edev->nh, &obj->internal_nb);
> 

Applied it.

Thanks,
Chanwoo Choi
