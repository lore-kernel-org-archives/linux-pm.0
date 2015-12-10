From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH v2 16/19] ARM: dts: Add PPMU node for exynos4412-odroidu3
Date: Thu, 10 Dec 2015 15:44:36 +0900
Message-ID: <56691F54.7040704@samsung.com>
References: <1449634091-1842-1-git-send-email-cw00.choi@samsung.com>
 <1449634091-1842-17-git-send-email-cw00.choi@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1449634091-1842-17-git-send-email-cw00.choi@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>, myungjoo.ham@samsung.com, kgene@kernel.org
Cc: kyungmin.park@samsung.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, tjakobi@math.uni-bielefeld.de, linux.amoon@gmail.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 09.12.2015 13:08, Chanwoo Choi wrote:
> This patch add dt node for PPMU_{DMC0|DMC1|LEFTBUS|RIGHTBUS} for
> exynos4412-odroidu3 board. Each PPMU dt node includes one event of
> 'PPMU Count3'.
> 
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
>  arch/arm/boot/dts/exynos4412-odroid-common.dtsi | 40 +++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
> 

The patch itself is good but now I see that it is duplicated with
Rinato, Monk and Trats2. Probably for all other Exynos4 and
one-cluster-Exynos5 boards this would be exactly the same as well.

How about making a DTSI file with common PPMU events configuration?

Best regards,
Krzysztof
