From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v4 0/4] DMA Engine: switch PL330 driver to non-irq-safe
 runtime PM
Date: Fri, 13 Jan 2017 14:59:38 +0100
Message-ID: <CAPDyKFqDGs6OkG-NKiY9Xd3hHEJOJB1YJ2O0_3Tojrzv_xR-yw@mail.gmail.com>
References: <CGME20170113072651eucas1p2b7487d97894de93daab24adb6745087c@eucas1p2.samsung.com>
 <1484292400-29730-1-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1484292400-29730-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, dmaengine@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Vinod Koul <vinod.koul@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Inki Dae <inki.dae@samsung.com>, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-pm@vger.kernel.org

+Arnd

On 13 January 2017 at 08:26, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
> Hello,
>
> This patchset changes the way the runtime PM is implemented in the PL330 DMA
> engine driver. The main goal of such change is to add support for the audio
> power domain to Exynos5 SoCs (5250, 542x, 5433, probably others) and let
> it to be properly turned off, when no audio is being used. Switching to
> non-irq-safe runtime PM is required to properly let power domain to be
> turned off (irq-safe runtime PM keeps power domain turned on all the time)
> and to integrate with clock controller's runtime PM (this cannot be
> workarounded any other way, PL330 uses clocks from the controller, which
> belongs to the same power domain).
>
> For more details of the proposed change to the PL330 driver see patch #4.
>
> Audio power domain on Exynos5 SoCs contains following hardware modules:
> 1. clock controller
> 2. pin controller
> 3. PL330 DMA controller
> 4. I2S audio controller
>
> Patches for adding or fixing runtime PM for each of the above devices is
> handled separately.
>
> Runtime PM patches for clock controllers is possible and has been proposed
> in the following thread (pending review): "[PATCH v4 0/4] Add runtime PM
> support for clocks (on Exynos SoC example)",
> http://www.spinics.net/lists/arm-kernel/msg550747.html
>
> Runtime PM support for Exynos pin controller has been posted in the
> following thread: "[PATCH 0/9] Runtime PM for Exynos pin controller driver",
> http://www.spinics.net/lists/arm-kernel/msg550161.html
>
> Exynos I2S driver supports runtime PM, but some fixes were needed for it
> and they are already queued to linux-next.
>
> This patchset is based on linux-next from 13th January 2017 with "dmaengine:
> pl330: fix double lock" patch applied.
>
> Best regards
> Marek Szyprowski
> Samsung R&D Institute Poland


Marek, this is great work! It's been on my TODO list forever, so I
really appreciate your work here.

I did only a brief review so far, particularly concentrating on the
changes for device links and runtime PM. I like it!

Perhaps we can get someone like Arnd/Vinod to comment in general idea
from a DT and DMA slave channel point of view. I don't know that stuff
good enough to give good opinion.

A couple of things that crosses my mind so far:
1) I have planned to extend pm_runtime_force_suspend|resume() to cover
also device links. Seems like that becomes really useful together with
these changes.
2) I think there will be some corner cases during system
suspend/resume for pl330. Not sure yet though. However, fixing 1) and
converting the driver to use pm_runtime_force_suspend|resume() should
probably work anyway.

Allow me to help out looking into 1) and 2). If not for pl330, I am
pretty sure it will be useful for other DMA controllers that
implements device links and runtime PM.

[...]

Kind regards
Uffe
