From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH v2 17/19] ARM: dts: Add support of bus frequency using
 VDD_INT for exynos3250-rinato
Date: Thu, 10 Dec 2015 15:58:44 +0900
Message-ID: <566922A4.5090807@samsung.com>
References: <1449634091-1842-1-git-send-email-cw00.choi@samsung.com>
 <1449634091-1842-18-git-send-email-cw00.choi@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1449634091-1842-18-git-send-email-cw00.choi@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>, myungjoo.ham@samsung.com, kgene@kernel.org
Cc: kyungmin.park@samsung.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, tjakobi@math.uni-bielefeld.de, linux.amoon@gmail.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 09.12.2015 13:08, Chanwoo Choi wrote:
> This patch adds the bus device-tree node of INT (internal) block
> to enable the bus frequency. The following sub-blocks share

"to enable the bus frequency scaling"

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

How about:
"and the rest of devices depend on the LEFTBUS device."
?

The patch is good:

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
