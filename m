From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH RESEND v6 3/3] ARM: dts: Add properties to use pwm-fan
 device as a cooling device in Odroid U3
Date: Thu, 13 Aug 2015 09:35:40 +0900
Message-ID: <55CBE65C.4010504@samsung.com>
References: <1425470624-25793-1-git-send-email-l.majewski@samsung.com>
 <1439298922-17898-1-git-send-email-l.majewski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.w1.samsung.com ([210.118.77.13]:14516 "EHLO
	mailout3.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751137AbbHMAfo (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 12 Aug 2015 20:35:44 -0400
In-reply-to: <1439298922-17898-1-git-send-email-l.majewski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lukasz Majewski <l.majewski@samsung.com>, Eduardo Valentin <edubezval@gmail.com>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, devicetree@vger.kernel.org, Lukasz Majewski <l.majewski@majess.pl>

On 11.08.2015 22:15, Lukasz Majewski wrote:
> With those bindings it is possible to use pwm-fan device available in
> Odroid U3 as a cooling device.
> 
> Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
> Acked-by: Eduardo Valentin <edubezval@gmail.com>
> ---
>  arch/arm/boot/dts/exynos4412-odroidu3.dts | 33 ++++++++++++++++++++++++++++++-
>  1 file changed, 32 insertions(+), 1 deletion(-)

Looks sensible.

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof


