From: Anand Moon <linux.amoon@gmail.com>
Subject: Re: [PATCH 0/9] Runtime PM for Exynos pin controller driver
Date: Sat, 24 Dec 2016 15:40:36 +0530
Message-ID: <CANAwSgRQuoriU923XT1B_0CVX2rzOR+8j2YHLMYRUu3gGySEBw@mail.gmail.com>
References: <CGME20161223122513epcas1p394d93d72d2d32c8910aafd1f6cc6b5e2@epcas1p3.samsung.com>
 <1482495889-6201-1-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1482495889-6201-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-gpio@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: linux-pm@vger.kernel.org

Hi Marek

On 23 December 2016 at 17:54, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
> Hello,
>
> This patchset is a next step to add support for audio power domain on
> Exynos5 SoCs.
>
> Audio power domain on Exynos5 SoCs contains following hardware modules:
> 1. clock controller
> 2. pin controller
> 3. PL330 DMA controller
> 4. I2S audio controller
>
> Till now it was assumed that pin controller is located in the "always on"
> power domain and lacked runtime power management. This patch finally
> removes such assumption and adds runtime pm support and awareness to this
> driver. To achieve this, some changes in the Exynos platform support code
> were needed, like moving pad retention control to the pin controller driver.
> Some cleanup to the pin controller driver has been also done while changing
> the code. This new feature requires some additional information in the
> device tree, what is handled by patches 1,2 and 9.
>
> Please note that patches are ordered in such a way that the changes can be
> bisected, so the properties are added to dts before the code requiring them.
>
> The other patches related to enabling full support for audio power domain
> can be found here:
> 1. PL330 ADMA controller non-irqsafe runtime PM:
>    https://www.spinics.net/lists/arm-kernel/msg550008.html
> 2. Runtime PM for clock controllers (Exynos Audio subsystem will be added
>    in v4 soon): https://www.spinics.net/lists/arm-kernel/msg538122.html
>
> Patches are based on linux-next from 2016.12.22.
>
> Best regards
> Marek Szyprowski
> Samsung R&D Institute Poland
>
>
> Patch summary:
>
> Marek Szyprowski (9):
>   ARM: dts: exynos: Add PMU syscon to pinctrl nodes
>   ARM: dts: exynos: Add pinctrl sleep state for 542x i2s module
>   pinctrl: samsung: Remove dead code
>   pinctrl: samsung: Use generic of_device_get_match_data helper
>   pinctrl: samsung: Move retention control from mach-exynos to the
>     pinctrl driver
>   pinctrl: samsung: Replace syscore ops with standard platform device
>     pm_ops
>   pinctrl: samsung: Add property to mark pad state as suitable for power
>     down
>   pinctrl: samsung: Add runtime PM support
>   ARM: dts: exynos: Add audio power domain support to Exynos542x SoCs
>
>  .../bindings/pinctrl/samsung-pinctrl.txt           |  12 ++
>  arch/arm/boot/dts/exynos3250.dtsi                  |   2 +
>  arch/arm/boot/dts/exynos4210.dtsi                  |   3 +
>  arch/arm/boot/dts/exynos4x12.dtsi                  |   3 +
>  arch/arm/boot/dts/exynos5250.dtsi                  |   4 +
>  arch/arm/boot/dts/exynos5420-pinctrl.dtsi          |  11 ++
>  arch/arm/boot/dts/exynos5420.dtsi                  |  18 ++-
>  arch/arm/mach-exynos/suspend.c                     |  64 ---------
>  drivers/pinctrl/samsung/pinctrl-exynos.c           | 148 +++++++++++++++++++++
>  drivers/pinctrl/samsung/pinctrl-samsung.c          | 126 ++++++++----------
>  drivers/pinctrl/samsung/pinctrl-samsung.h          |  15 +++
>  11 files changed, 271 insertions(+), 135 deletions(-)
>

Is their core configuration missing to enable audio through HDMI on
Odroid Boards.
I could not get the sound working on Odroid XU4.
.
-Best Regards
Anand Moon
