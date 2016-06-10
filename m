From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH v2 4/4] max8903: remove unnecessary malloc failed message
 print out.
Date: Fri, 10 Jun 2016 16:08:09 +0200
Message-ID: <575AC9C9.60607@samsung.com>
References: <1464849897-21527-3-git-send-email-chris@lapa.com.au>
 <1465561970-18377-1-git-send-email-chris@lapa.com.au>
 <1465561970-18377-5-git-send-email-chris@lapa.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.w1.samsung.com ([210.118.77.11]:60113 "EHLO
	mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751698AbcFJOIO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 10 Jun 2016 10:08:14 -0400
In-reply-to: <1465561970-18377-5-git-send-email-chris@lapa.com.au>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chris Lapa <chris@lapa.com.au>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

On 06/10/2016 02:32 PM, Chris Lapa wrote:
> From: Chris Lapa <chris@lapa.com.au>

Here and in all other patches (like #1) you need to write something. The
commit title could be very short (even non-sentence) and here a little
bit longer. E.g.:

Title: power: max8903: Remove pointless 'out of memory' error message
Body: Remove the error message of memory allocation failure because it
is printed by core.

Best regards,
Krzysztof

> Signed-off-by: Chris Lapa <chris@lapa.com.au>
> ---
>  drivers/power/max8903_charger.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/power/max8903_charger.c b/drivers/power/max8903_charger.c
> index 20d4b55..d60f9b2 100644
> --- a/drivers/power/max8903_charger.c
> +++ b/drivers/power/max8903_charger.c
> @@ -246,10 +246,8 @@ static int max8903_probe(struct platform_device *pdev)
>  	int usb_in = 0;
>  
>  	charger = devm_kzalloc(dev, sizeof(struct max8903_data), GFP_KERNEL);
> -	if (charger == NULL) {
> -		dev_err(dev, "Cannot allocate memory.\n");
> +	if (!charger)
>  		return -ENOMEM;
> -	}
>  
>  	charger->pdata = pdev->dev.platform_data;
>  	if (IS_ENABLED(CONFIG_OF) && !charger->pdata && dev->of_node) {
> 

