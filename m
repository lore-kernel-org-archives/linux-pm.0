From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH v4 20/20] ARM: dts: Add support of bus frequency for
 exynos4412-trats/odroidu3
Date: Tue, 15 Dec 2015 09:34:18 +0900
Message-ID: <566F600A.4060504@samsung.com>
References: <1450075104-13705-1-git-send-email-cw00.choi@samsung.com>
 <1450075104-13705-21-git-send-email-cw00.choi@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.w1.samsung.com ([210.118.77.13]:42473 "EHLO
	mailout3.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932664AbbLOAe0 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 14 Dec 2015 19:34:26 -0500
In-reply-to: <1450075104-13705-21-git-send-email-cw00.choi@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>, myungjoo.ham@samsung.com, kgene@kernel.org
Cc: kyungmin.park@samsung.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, tjakobi@math.uni-bielefeld.de, linux.amoon@gmail.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org

On 14.12.2015 15:38, Chanwoo Choi wrote:
> THis patch adds the bus device tree nodes for both MIF (Memory) and INT
> (Internal) block to enable the bus frequency.
> 
> The DMC bus is parent device in MIF block using VDD_MIF and the LEFTBUS
> bus is parent device in INT block using VDD_INT.
> 
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> [linux.amoon: Tested on Odroid U3]
> Tested-by: Anand Moon <linux.amoon@gmail.com>
> ---
>  arch/arm/boot/dts/exynos4412-odroid-common.dtsi | 47 +++++++++++++++++++++++++
>  arch/arm/boot/dts/exynos4412-trats2.dts         | 47 +++++++++++++++++++++++++
>  2 files changed, 94 insertions(+)
> 

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof

