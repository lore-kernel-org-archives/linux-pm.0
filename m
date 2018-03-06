From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 10/12] ARM: dts: remove no longer needed samsung thermal properties
Date: Tue, 6 Mar 2018 16:23:47 +0100
Message-ID: <CAJKOXPfdQo=wCixbREyOriEUZPRGOT35sT3ojcoeXRt0UsBwqQ@mail.gmail.com>
References: <CGME20180306144511epcas2p1c1c00d0bdea1e329d2d3d5583f135437@epcas2p1.samsung.com>
 <1520347435-22970-1-git-send-email-b.zolnierkie@samsung.com> <1520347435-22970-11-git-send-email-b.zolnierkie@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1520347435-22970-11-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Kukjin Kim <kgene@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, Mar 6, 2018 at 3:43 PM, Bartlomiej Zolnierkiewicz
<b.zolnierkie@samsung.com> wrote:
> Remove no longer needed samsung thermal properties.
>
> There should be no functional changes caused by this patch.
>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>  arch/arm/boot/dts/exynos3250.dtsi                   |  2 +-
>  arch/arm/boot/dts/exynos4.dtsi                      |  2 +-
>  arch/arm/boot/dts/exynos4412-tmu-sensor-conf.dtsi   | 20 --------------------
>  arch/arm/boot/dts/exynos5250.dtsi                   |  2 +-
>  arch/arm/boot/dts/exynos5410.dtsi                   |  8 ++++----
>  arch/arm/boot/dts/exynos5420-tmu-sensor-conf.dtsi   | 21 ---------------------
>  arch/arm/boot/dts/exynos5420.dtsi                   | 10 +++++-----
>  arch/arm/boot/dts/exynos5440-tmu-sensor-conf.dtsi   | 20 --------------------
>  arch/arm/boot/dts/exynos5440.dtsi                   |  6 +++---
>  .../dts/exynos/exynos5433-tmu-g3d-sensor-conf.dtsi  | 20 --------------------
>  .../boot/dts/exynos/exynos5433-tmu-sensor-conf.dtsi | 19 -------------------
>  arch/arm64/boot/dts/exynos/exynos5433.dtsi          | 10 +++++-----
>  .../boot/dts/exynos/exynos7-tmu-sensor-conf.dtsi    | 21 ---------------------
>  arch/arm64/boot/dts/exynos/exynos7.dtsi             |  2 +-
>  14 files changed, 21 insertions(+), 142 deletions(-)
>  delete mode 100644 arch/arm/boot/dts/exynos4412-tmu-sensor-conf.dtsi
>  delete mode 100644 arch/arm/boot/dts/exynos5420-tmu-sensor-conf.dtsi
>  delete mode 100644 arch/arm/boot/dts/exynos5440-tmu-sensor-conf.dtsi
>  delete mode 100644 arch/arm64/boot/dts/exynos/exynos5433-tmu-g3d-sensor-conf.dtsi
>  delete mode 100644 arch/arm64/boot/dts/exynos/exynos5433-tmu-sensor-conf.dtsi
>  delete mode 100644 arch/arm64/boot/dts/exynos/exynos7-tmu-sensor-conf.dtsi

Hi,

Please split the arm64 to separate patchset.

It is a cleanup patch and it depends on your driver changes so it will
have to wait till your driver patches hit mainline.

Best regards,
Krzysztof
