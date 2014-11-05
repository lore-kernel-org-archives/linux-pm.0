From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v8 1/5] PM / Runtime: Add getter for querying the IRQ safe option
Date: Wed, 05 Nov 2014 16:54:33 +0200
Message-ID: <22827785.xmOLWzI5M2@avalon>
References: <1413795888-18559-1-git-send-email-k.kozlowski@samsung.com> <20141103162728.GB1870@intel.com> <20141103170408.GD4042@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20141103170408.GD4042@n2100.arm.linux.org.uk>
Sender: linux-doc-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Vinod Koul <vinod.koul@intel.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Jonathan Corbet <corbet@lwn.net>, Dan Williams <dan.j.williams@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Alan Stern <stern@rowland.harvard.edu>, linux-pm@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Michal Simek <michal.simek@xilinx.com>, Kyungmin Park <kyungmin.park@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: linux-pm@vger.kernel.org

Hi Russell,

On Monday 03 November 2014 17:04:08 Russell King - ARM Linux wrote:
> On Mon, Nov 03, 2014 at 09:57:28PM +0530, Vinod Koul wrote:
> > On Sat, Nov 01, 2014 at 02:29:42AM +0200, Laurent Pinchart wrote:
> >> Many other drivers suffer from the same problem. While I won't reject
> >> your proposed fix, I would prefer a more generic approach.
> >> 
> >> One option that has been discussed previously was to use a work queue to
> >> delay starting the DMA transfer to an interruptible context where
> >> pm_runtime_get_sync() could be called. However, as Russell pointed out
> >> [1],
> >> even that won't work in all cases as the DMA slave might need the
> >> transfer to be started before enabling part of its hardware (OMAP audio
> >> seem to be such a case).
> >> 
> >> I've heard a rumor of a possible DMA engine rework to forbid calling the
> >> descriptor preparation API from atomic context. This could be used as a
> >> base to implement runtime PM, as DMA slave drivers should not prepare
> >> descriptors if they don't need to use them. However that's a long term
> >> plan, and we need a solution sooner than that.
> > 
> > Well it is not a rumour :)
> > 
> > I have been contemplating that now that async_tx will be killed so we dont
> > have to worry about that usage. For the slave dma usage, we can change the
> > prepare API to be non atomic. I think the users will be okay with
> > approach. This way drivers can use runtime pm calls in prepare.
> 
> Except we /do/ have a fair number of places where the prep calls are made
> from atomic contexts, particularly in serial drivers.  You'd need to
> introduce a tasklet into almost every serial driver which doesn't
> already have one to restart RX DMA after an error or pause.  Eg,
> 
> drivers/tty/serial/amba-pl011.c
> drivers/tty/serial/pch_uart.c
> drivers/tty/serial/imx.c

I wonder whether it would be possible to decouple descriptor allocation and 
descriptor initialization/preparation. If drivers could allocate descriptors 
and reuse them after they complete, not only would it lower the memory 
management pressure by getting rid of alloc/free during transmission, but it 
would also make it possible to easily allocate the transaction descriptors 
beforehand in non-atomic context.

> Probably also:
> 
> drivers/net/ethernet/micrel/ks8842.c
> 
> There could well be other places as well, I've not gone through and
> checked exhaustively.

-- 
Regards,

Laurent Pinchart

