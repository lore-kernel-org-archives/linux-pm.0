From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v7 2/4] dmaengine: Forward slave device pointer to
 of_xlate callback
Date: Wed, 25 Jan 2017 14:12:38 +0100
Message-ID: <26397455-1237-2a66-acf8-215aacc7c9ce@metafoo.de>
References: <1485340088-25481-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170125102824eucas1p1cf027184286131ff628eb7113c3f9e60@eucas1p1.samsung.com>
 <1485340088-25481-3-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1485340088-25481-3-git-send-email-m.szyprowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>, linux-samsung-soc@vger.kernel.org, dmaengine@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Vinod Koul <vinod.koul@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown <broonie@kernel.org>, Inki Dae <inki.dae@samsung.com>
List-Id: linux-pm@vger.kernel.org

On 01/25/2017 11:28 AM, Marek Szyprowski wrote:
> Add pointer to slave device to of_dma_xlate to let DMA engine driver
> to know which slave device is using given DMA channel. This will be
> later used to implement non-irq-safe runtime PM for DMA engine driver.

of_dma_xlate() is used to translate from a OF phandle and a specifier to a
DMA channel. On one hand this does not necessarily mean that the channel is
actually going to be used by the slave that called the xlate function.
Modifying the driver state when a lookup of the channel is done is a
layering violation. And this approach is also missing a way to disassociate
a slave from a DMA channel, e.g. when it is no longer used.

On the other hand there are other mechanisms to translate between some kind
of firmware handle to a DMA channel which are completely ignored here.

So this approach does not work. This is something that needs to be done at
the dmaengine level, not a the firmware resource translation level. And it
needs a matching method that is called when the channel is disassociated
from a device, when the device no longer uses the DMA channel.
