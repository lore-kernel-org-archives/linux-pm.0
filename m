From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH RESEND v6 2/3] ARM: dts: Add pwm-fan node to the Odroid-U3
 board
Date: Thu, 13 Aug 2015 09:35:53 +0900
Message-ID: <55CBE669.6040109@samsung.com>
References: <1425470624-25793-1-git-send-email-l.majewski@samsung.com>
 <1439298899-17645-1-git-send-email-l.majewski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.w1.samsung.com ([210.118.77.14]:12246 "EHLO
	mailout4.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751137AbbHMAf4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 12 Aug 2015 20:35:56 -0400
In-reply-to: <1439298899-17645-1-git-send-email-l.majewski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lukasz Majewski <l.majewski@samsung.com>, Eduardo Valentin <edubezval@gmail.com>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, devicetree@vger.kernel.org, Lukasz Majewski <l.majewski@majess.pl>

On 11.08.2015 22:14, Lukasz Majewski wrote:
> From: Kamil Debski <k.debski@samsung.com>
> 
> Add pwm-fan node to the Odroid-U3 board file to enable PWM control of the
> cooling fan. In addition, add the "pwm" label to the pwm@139D0000 node
> in the exynos4412.dtsi.
> 
> Signed-off-by: Kamil Debski <k.debski@samsung.com>
> Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
> ---
>  arch/arm/boot/dts/exynos4412-odroidu3.dts | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof

