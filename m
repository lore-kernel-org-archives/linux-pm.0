From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH v3 18/20] ARM: dts: Add support of bus frequency using
 VDD_INT for exynos3250-rinato
Date: Fri, 11 Dec 2015 16:18:03 +0900
Message-ID: <566A78AB.9000504@samsung.com>
References: <1449810479-14763-1-git-send-email-cw00.choi@samsung.com>
 <1449810479-14763-19-git-send-email-cw00.choi@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.w1.samsung.com ([210.118.77.11]:26315 "EHLO
	mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750841AbbLKHSR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 11 Dec 2015 02:18:17 -0500
In-reply-to: <1449810479-14763-19-git-send-email-cw00.choi@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>, myungjoo.ham@samsung.com, kgene@kernel.org
Cc: kyungmin.park@samsung.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, tjakobi@math.uni-bielefeld.de, linux.amoon@gmail.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org

On 11.12.2015 14:07, Chanwoo Choi wrote:
> This patch adds the bus device-tree node of INT (internal) block
> to enable the bus frequency scaling. The following sub-blocks share
> the VDD_INT power source:
> - LEFTBUS (parent device)
> - RIGHTBUS
> - PERIL
> - LCD0
> - FSYS
> - MCUISP / ISP
> - MFC
> 
> The LEFTBUS is parent device with devfreq ondemand governor
> and the rest devices has the dependency on LEFTBUS bus.

I pointed this previously. If you wish to leave the sentence in such
form then "rest of" and "have" not "has".

Best regards,
Krzysztof

> 
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> ---
>  arch/arm/boot/dts/exynos3250-rinato.dts | 41 +++++++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
> 
