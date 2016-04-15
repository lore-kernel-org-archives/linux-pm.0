From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH v2 8/8] ARM: dts: Add support of Bus frequency using
 VDD_INT for exynos5422-odroidxu3
Date: Fri, 15 Apr 2016 11:07:27 +0200
Message-ID: <5710AF4F.9030300@samsung.com>
References: <1460701975-24178-1-git-send-email-cw00.choi@samsung.com>
 <1460701975-24178-9-git-send-email-cw00.choi@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1460701975-24178-9-git-send-email-cw00.choi@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>, myungjoo.ham@samsung.com, kyungmin.park@samsung.com, tomasz.figa@gmail.com, s.nawrocki@samsung.com, kgene@kernel.org
Cc: robh@kernel.org, rjw@rjwysocki.net, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, linux.amoon@gmail.com, m.reichl@fivetechno.de, tjakobi@math.uni-bielefeld.de, inki.dae@samsung.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 04/15/2016 08:32 AM, Chanwoo Choi wrote:
> This patch adds the bus device tree nodes for INT (Internal) block
> to enable the AMBA bus frequency scaling and add the NoC (Network on Chip)
> Probe Device Tree node to measure the bandwidht for AMBA AXI bus.
> 
> The WCORE bus bus is parent device in INT block using VDD_INT.
> 
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> Tested-by: Markus Reichl <m.reichl@fivetechno.de>
> Tested-by: Anand Moon <linux.amoon@gmail.com>
> ---
>  arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi | 99 ++++++++++++++++++++++
>  1 file changed, 99 insertions(+)
> 

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
