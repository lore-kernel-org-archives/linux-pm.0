From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 13/14] ARM: dts: exynos: remove no longer needed samsung
 thermal properties
Date: Mon, 16 Apr 2018 14:16:11 +0200
Message-ID: <CAJKOXPc2DoUgorHct30hkK4W8AsAGWrdUxtCYT4oeekJ-FhaAw@mail.gmail.com>
References: <CGME20180416101425epcas1p46ab4d827e3a64c5c16b32a17f63dd9d0@epcas1p4.samsung.com>
 <1523873525-23718-1-git-send-email-b.zolnierkie@samsung.com> <1523873525-23718-14-git-send-email-b.zolnierkie@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1523873525-23718-14-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Kukjin Kim <kgene@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon, Apr 16, 2018 at 12:12 PM, Bartlomiej Zolnierkiewicz
<b.zolnierkie@samsung.com> wrote:
> Remove no longer needed samsung thermal properties.
>
> There should be no functional changes caused by this patch.
>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>  arch/arm/boot/dts/exynos3250.dtsi                 |  2 +-
>  arch/arm/boot/dts/exynos4.dtsi                    |  2 +-
>  arch/arm/boot/dts/exynos4412-tmu-sensor-conf.dtsi | 20 --------------------
>  arch/arm/boot/dts/exynos5250.dtsi                 |  2 +-
>  arch/arm/boot/dts/exynos5410.dtsi                 |  8 ++++----
>  arch/arm/boot/dts/exynos5420-tmu-sensor-conf.dtsi | 21 ---------------------
>  arch/arm/boot/dts/exynos5420.dtsi                 | 10 +++++-----
>  arch/arm/boot/dts/exynos5440-tmu-sensor-conf.dtsi | 20 --------------------
>  arch/arm/boot/dts/exynos5440.dtsi                 |  6 +++---
>  9 files changed, 15 insertions(+), 76 deletions(-)
>  delete mode 100644 arch/arm/boot/dts/exynos4412-tmu-sensor-conf.dtsi
>  delete mode 100644 arch/arm/boot/dts/exynos5420-tmu-sensor-conf.dtsi
>  delete mode 100644 arch/arm/boot/dts/exynos5440-tmu-sensor-conf.dtsi

Thanks for splitting. Looks good. I'll take both (#13 and #14) after
thermal changes hit mainline (so probably for v4.19).
https://patchwork.kernel.org/bundle/krzk/for-v4.19/

Best regards,
Krzysztof
