From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH v9 01/20] PM / devfreq: exynos: Add generic exynos bus
 frequency driver
Date: Tue, 12 Apr 2016 09:23:33 +0200
Message-ID: <570CA275.6000903@samsung.com>
References: <1460347078-15175-1-git-send-email-cw00.choi@samsung.com>
 <1460347078-15175-2-git-send-email-cw00.choi@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1460347078-15175-2-git-send-email-cw00.choi@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>, myungjoo.ham@samsung.com, kyungmin.park@samsung.com, kgene@kernel.org, s.nawrocki@samsung.com, tomasz.figa@gmail.com
Cc: rjw@rjwysocki.net, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, linux.amoon@gmail.com, m.reichl@fivetechno.de, tjakobi@math.uni-bielefeld.de, inki.dae@samsung.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 04/11/2016 05:57 AM, Chanwoo Choi wrote:
> This patch adds the generic exynos bus frequency driver for AMBA AXI bus
> of sub-blocks in exynos SoC with DEVFREQ framework. The Samsung Exynos SoC
> have the common architecture for bus between DRAM and sub-blocks in SoC.
> This driver can support the generic bus frequency driver for Exynos SoCs.
> 
> In devicetree, Each bus block has a bus clock, regulator, operation-point
> and devfreq-event devices which measure the utilization of each bus block.
> 
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> [m.reichl and linux.amoon: Tested it on exynos4412-odroidu3 board]
> Tested-by: Markus Reichl <m.reichl@fivetechno.de>
> Tested-by: Anand Moon <linux.amoon@gmail.com>
> Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
> ---
>  drivers/devfreq/Kconfig      |  15 ++
>  drivers/devfreq/Makefile     |   1 +
>  drivers/devfreq/exynos-bus.c | 443 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 459 insertions(+)
>  create mode 100644 drivers/devfreq/exynos-bus.c

Acked-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
