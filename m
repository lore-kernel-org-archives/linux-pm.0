From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH v3 15/20] ARM: dts: Add bus nodes using VDD_INT for
 Exynos4x12
Date: Fri, 11 Dec 2015 16:03:08 +0900
Message-ID: <566A752C.80601@samsung.com>
References: <1449810479-14763-1-git-send-email-cw00.choi@samsung.com>
 <1449810479-14763-16-git-send-email-cw00.choi@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1449810479-14763-16-git-send-email-cw00.choi@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>, myungjoo.ham@samsung.com, kgene@kernel.org
Cc: kyungmin.park@samsung.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, tjakobi@math.uni-bielefeld.de, linux.amoon@gmail.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 11.12.2015 14:07, Chanwoo Choi wrote:
> This patch adds the bus noes using VDD_INT for Exynos4x12 SoC.
> Exynos4x12 has the following AXI buses to translate data between
> DRAM and sub-blocks.
> 
> Following list specifies the detailed relation between DRAM and sub-blocks:
> - ACLK100 clock for PERIL/PERIR/MFC(PCLK)
> - ACLK160 clock for CAM/TV/LCD
> : The minimum clock of ACLK160 should be over 160MHz.
>   When drop the clock under 160MHz, show the broken image.
> - ACLK133 clock for FSYS
> - GDL clock for LEFTBUS
> - GDR clock for RIGHTBUS
> - SCLK_MFC clock for MFC
> 
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> [linux.amoon: Tested on Odroid U3]
> Tested-by: Anand Moon <linux.amoon@gmail.com>
> ---
>  arch/arm/boot/dts/exynos4x12.dtsi | 106 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 106 insertions(+)
> 

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
