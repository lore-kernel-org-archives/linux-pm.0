From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH V1 3/7] dmaengine: Loongson1: add Loongson1 dmaengine
 driver
Date: Wed, 6 Apr 2016 07:26:53 -0700
Message-ID: <20160406142652.GC27292@vkoul-mobl.iind.intel.com>
References: <1459946095-7637-1-git-send-email-keguang.zhang@gmail.com>
 <1459946095-7637-4-git-send-email-keguang.zhang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1459946095-7637-4-git-send-email-keguang.zhang@gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Keguang Zhang <keguang.zhang@gmail.com>
Cc: linux-mips@linux-mips.org, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, dmaengine@vger.kernel.org, linux-gpio@vger.kernel.org, linux-mtd@lists.infradead.org, Ralf Baechle <ralf@linux-mips.org>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Dan Williams <dan.j.williams@intel.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, Richard Weinberger <richard@nod.at>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Wed, Apr 06, 2016 at 08:34:51PM +0800, Keguang Zhang wrote:
> @@ -527,6 +527,15 @@ config ZX_DMA
>  	help
>  	  Support the DMA engine for ZTE ZX296702 platform devices.
>  
> +config DMA_LOONGSON1

The kconfig and makefile is sorted alphabetically, pls arrage these entries
accordingly

> +
> +		/*memorize the physical address of descriptor */

bad comment style


> +	/*allocate DMA descriptors */

here and other places too :(

> +static enum dma_status ls1x_dma_tx_status(struct dma_chan *chan,
> +					  dma_cookie_t cookie,
> +					  struct dma_tx_state *txstate)
> +{
> +	struct ls1x_dma_chan *dma_chan = to_ls1x_dma_chan(chan);
> +	struct ls1x_dma_desc *dma_desc = dma_chan->dma_desc;
> +	struct virt_dma_desc *vdesc;
> +	enum dma_status status;
> +	unsigned int residue = 0;
> +	unsigned long flags;
> +
> +	status = dma_cookie_status(chan, cookie, txstate);
> +	if ((status == DMA_COMPLETE) || !txstate)
> +		return status;
> +
> +	spin_lock_irqsave(&dma_chan->vchan.lock, flags);
> +
> +	vdesc = vchan_find_desc(&dma_chan->vchan, cookie);
> +	if (vdesc)
> +		/* not yet processed */
> +		residue = ls1x_dma_desc_residue(to_ls1x_dma_desc(vdesc), 0);

If your usage queries reside repeatedly, then it might make sense to store
the size which is residue here

-- 
~Vinod
