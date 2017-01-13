From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v4 4/4] dmaengine: pl330: Don't require irq-safe runtime
 PM
Date: Fri, 13 Jan 2017 16:22:55 +0200
Message-ID: <20170113142255.ut6q5gndfo6yxkil@kozik-lap>
References: <1484292400-29730-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170113072653eucas1p17ed0755fad3bd351c4e89ec9fa10e09e@eucas1p1.samsung.com>
 <1484292400-29730-5-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1484292400-29730-5-git-send-email-m.szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-samsung-soc@vger.kernel.org, dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Vinod Koul <vinod.koul@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Inki Dae <inki.dae@samsung.com>
List-Id: linux-pm@vger.kernel.org

On Fri, Jan 13, 2017 at 08:26:40AM +0100, Marek Szyprowski wrote:
> This patch replaces irq-safe runtime PM with non-irq-safe version based on
> the new approach. Existing, irq-safe runtime PM implementation for PL330 was
> not bringing much benefits of its own - only clocks were enabled/disabled.
> 
> Till now non-irq-safe runtime PM implementation was only possible by calling
> pm_runtime_get/put functions from alloc/free_chan_resources. All other DMA
> engine API functions cannot be called from a context, which permits sleeping.
> Such implementation, in practice would result in keeping DMA controller's
> device active almost all the time, because most of the slave device drivers
> (DMA engine clients) acquire DMA channel in their probe() function and
> released it during driver removal.
> 
> This patch provides a new, different approach. It is based on an observation
> that there can be only one slave device using each DMA channel. PL330 hardware
> always has dedicated channels for each peripheral device. Using recently
> introduced device dependencies (links) infrastructure one can ensure proper
> runtime PM state of PL330 DMA controller basing on the runtime PM state of
> the slave device.
> 
> In this approach in pl330_alloc_chan_resources() function a new dependency
> is being created between PL330 DMA controller device (as a supplier) and
> given slave device (as a consumer). This way PL330 DMA controller device
> runtime active counter is increased when the slave device is resumed and
> decreased the same time when given slave device is put to suspend. This way
> it has been ensured to keep PL330 DMA controller runtime active if there is
> an active used of any of its DMA channels. Slave device pointer is initially
> stored in per-channel data in of_dma_xlate callback. This is similar to what
> has been already implemented in Exynos IOMMU driver in commit 2f5f44f205cc95
> ("iommu/exynos: Use device dependency links to control runtime pm").
> 
> If slave device doesn't implement runtime PM or keeps device runtime active
> all the time, then PL330 DMA controller will be runtime active all the time
> when channel is being allocated. The goal is however to have runtime PM
> added to all devices in the system, because it lets respective power
> domains to be turned off, what gives the best results in terms of power
> saving.
> 
> If one requests memory-to-memory channel, runtime active counter is
> increased unconditionally. This might be a drawback of this approach, but
> PL330 is not really used for memory-to-memory operations due to poor
> performance in such operations compared to the CPU.
> 
> Introducing non-irq-safe runtime power management finally allows to turn off
> audio power domain on Exynos5 SoCs.
> 
> Removal of irq-safe runtime PM is based on the revert of the following
> commits:
> 1. commit 5c9e6c2b2ba3 "dmaengine: pl330: fix runtime pm support"
> 2. commit 81cc6edc0870 "dmaengine: pl330: Fix hang on dmaengine_terminate_all
>    on certain boards"
> 3. commit ae43b3289186 "ARM: 8202/1: dmaengine: pl330: Add runtime Power
>    Management support v12"
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/dma/pl330.c | 135 ++++++++++++++++++++++++++++------------------------
>  1 file changed, 72 insertions(+), 63 deletions(-)
> 
> diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
> index c77a3494659c..a97cb02250ab 100644
> --- a/drivers/dma/pl330.c
> +++ b/drivers/dma/pl330.c
> @@ -16,6 +16,7 @@
>  #include <linux/init.h>
>  #include <linux/slab.h>
>  #include <linux/module.h>
> +#include <linux/mutex.h>
>  #include <linux/string.h>
>  #include <linux/delay.h>
>  #include <linux/interrupt.h>
> @@ -268,9 +269,6 @@ enum pl330_byteswap {
>  
>  #define NR_DEFAULT_DESC	16
>  
> -/* Delay for runtime PM autosuspend, ms */
> -#define PL330_AUTOSUSPEND_DELAY 20
> -
>  /* Populated by the PL330 core driver for DMA API driver's info */
>  struct pl330_config {
>  	u32	periph_id;
> @@ -449,8 +447,8 @@ struct dma_pl330_chan {
>  	bool cyclic;
>  
>  	/* for runtime pm tracking */
> -	bool active;
>  	struct device *slave;
> +	struct device_link *slave_link;
>  };
>  
>  struct pl330_dmac {
> @@ -465,6 +463,9 @@ struct pl330_dmac {
>  	/* To protect desc_pool manipulation */
>  	spinlock_t pool_lock;
>  
> +	/* For runtime PM management of slave channels */
> +	struct mutex rpm_lock;

Isn't synchronization provided by dmaengine core here? The
dma_chan_get/put (which call the alloc/free resources) are called under
dma_list_mutex(). Don't you trust the core in that matter?

Best regards,
Krzysztof
