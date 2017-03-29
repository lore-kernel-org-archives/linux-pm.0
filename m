From: Hans Verkuil <hverkuil@xs4all.nl>
Subject: Re: [PATCH 0/4] ARM: exynos: Fix Odroid U3 USB/LAN when TFTP booting
 (power sequence)
Date: Wed, 29 Mar 2017 13:12:21 +0200
Message-ID: <308964a5-84f0-d144-6358-bd334f9dc603@xs4all.nl>
References: <20170107085203.4431-1-krzk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170107085203.4431-1-krzk@kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Krzysztof Kozlowski <krzk@kernel.org>, Kukjin Kim <kgene@kernel.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Anand Moon <linux.amoon@gmail.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Peter Chen <peter.chen@nxp.com>, ulf.hansson@linaro.org, linux-pm@vger.kernel.org, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, sre@kernel.org, robh+dt@kernel.org, Markus Reichl <m.reichl@fivetechno.de>, broonie@kernel.org, stern@rowland.harvard.edu, Sylwester Nawrocki <s.nawrocki@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: linux-pm@vger.kernel.org

Hi Krzysztof,

On 07/01/17 09:51, Krzysztof Kozlowski wrote:
> Hi,
> 
> Thanks to Markus Reichl, I got an Odroid U3 to work with. Thanks to Peter
> Chen, we got a power sequence generic library which solves my long
> standing Odroid U3 problem - no LAN9730 if it was enabled by bootloader.
> 
> My previous attempts for this can be found here [0].
> 
> This patchset is based on Peter's v11 of power sequence [1].
> Patchset is available also on my Github [2].
> 
> More detailed analysis is described in patch 2/4 ("ARM: dts: exynos: Fix
> LAN9730 on Odroid U3 after tftpboot").

It's rather late, but I finally had a chance to test this and it works.

So:

Tested-by: Hans Verkuil <hans.verkuil@cisco.com>

This was with u-boot version v2016.09.01 and kernel 4.11.0-rc1.

Regards,

	Hans

> 
> 
> Best regards,
> Krzysztof
> 
> 
> [0] http://www.spinics.net/lists/linux-mmc/msg37386.html
> [1] https://lwn.net/Articles/710736/
> [2] https://github.com/krzk/linux/commits/for-next/odroid-u3-usb3503-pwrseq
> 
> Krzysztof Kozlowski (4):
>   ARM: dts: exynos: Fix indentation of EHCI and OHCI ports
>   ARM: dts: exynos: Fix LAN9730 on Odroid U3 after tftpboot
>   ARM: exynos_defconfig: Enable power sequence for Odroid U3
>   ARM: multi_v7_defconfig: Enable power sequence for Odroid U3
> 
>  arch/arm/boot/dts/exynos4.dtsi            | 24 ++++++++++++------------
>  arch/arm/boot/dts/exynos4412-odroidu3.dts | 21 +++++++++++++++++++++
>  arch/arm/configs/exynos_defconfig         |  2 ++
>  arch/arm/configs/multi_v7_defconfig       |  1 +
>  4 files changed, 36 insertions(+), 12 deletions(-)
> 
