From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v2 1/4] dmaengine: pl330: remove pdata based
 initialization
Date: Mon, 9 Jan 2017 20:15:11 +0200
Message-ID: <20170109181511.37da3mslzdiq4uhr@kozik-lap>
References: <1483970598-6191-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170109140325eucas1p2674704b2505517ee532284c58c8a64d1@eucas1p2.samsung.com>
 <1483970598-6191-2-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1483970598-6191-2-git-send-email-m.szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-samsung-soc@vger.kernel.org, dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Vinod Koul <vinod.koul@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Inki Dae <inki.dae@samsung.com>
List-Id: linux-pm@vger.kernel.org

On Mon, Jan 09, 2017 at 03:03:15PM +0100, Marek Szyprowski wrote:
> This driver is now used only on platforms which support device tree, so
> it is safe to remove legacy platform data based initialization code.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/dma/pl330.c        | 30 ++++++++----------------------
>  include/linux/amba/pl330.h | 35 -----------------------------------

Nope:
$ git grep pl330.h
arch/arm/plat-samsung/devs.c:#include <linux/amba/pl330.h>

Best regards,
Krzysztof
