From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH v3 5/7] max8903: removes non zero validity checks on gpios.
Date: Fri, 17 Jun 2016 08:35:43 +0200
Message-ID: <57639A3F.90607@samsung.com>
References: <1464849897-21527-3-git-send-email-chris@lapa.com.au>
 <1466139626-51434-1-git-send-email-chris@lapa.com.au>
 <1466139626-51434-6-git-send-email-chris@lapa.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.w1.samsung.com ([210.118.77.12]:28826 "EHLO
	mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752665AbcFQGfs (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 17 Jun 2016 02:35:48 -0400
In-reply-to: <1466139626-51434-6-git-send-email-chris@lapa.com.au>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chris Lapa <chris@lapa.com.au>, dwmw2@infradead.org, dbaryshkov@gmail.com, sre@kernel.org, mark.rutland@arm.com, robh+dt@kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

On 06/17/2016 07:00 AM, Chris Lapa wrote:
> From: Chris Lapa <chris@lapa.com.au>
> 
> Prior to this commit a zero gpio was treated as invalid. Whereas
> gpio_is_valid() will treat a zero gpio as valid.
> 
> This commit removes the confusion and explicity uses gpio_is_valid()

s/explicity/explicitly/

> throughout. Which in turn results in several of the error messages becoming
> redundant and thus removed.
> 
> Signed-off-by: Chris Lapa <chris@lapa.com.au>
> ---
>  drivers/power/max8903_charger.c | 125 ++++++++++++++++++----------------------
>  1 file changed, 55 insertions(+), 70 deletions(-)

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
