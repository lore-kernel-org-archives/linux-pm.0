From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH v3 6/7] max8903: remove unnecessary 'out of memory' error
 message.
Date: Fri, 17 Jun 2016 08:35:59 +0200
Message-ID: <57639A4F.4060309@samsung.com>
References: <1464849897-21527-3-git-send-email-chris@lapa.com.au>
 <1466139626-51434-1-git-send-email-chris@lapa.com.au>
 <1466139626-51434-7-git-send-email-chris@lapa.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.w1.samsung.com ([210.118.77.11]:32623 "EHLO
	mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932067AbcFQGgE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 17 Jun 2016 02:36:04 -0400
In-reply-to: <1466139626-51434-7-git-send-email-chris@lapa.com.au>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chris Lapa <chris@lapa.com.au>, dwmw2@infradead.org, dbaryshkov@gmail.com, sre@kernel.org, mark.rutland@arm.com, robh+dt@kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

On 06/17/2016 07:00 AM, Chris Lapa wrote:
> From: Chris Lapa <chris@lapa.com.au>
> 
> Remove the 'out of memory' error message as it is printed by the core.
> 
> Signed-off-by: Chris Lapa <chris@lapa.com.au>
> ---
>  drivers/power/max8903_charger.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof

