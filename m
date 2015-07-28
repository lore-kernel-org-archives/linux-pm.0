From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v6 7/8] dmaengine: add a driver for Intel integrated DMA
 64-bit
Date: Tue, 28 Jul 2015 11:14:20 +0300
Message-ID: <1438071260.29746.95.camel@linux.intel.com>
References: <1438009443-55317-1-git-send-email-andriy.shevchenko@linux.intel.com>
	 <1438009443-55317-8-git-send-email-andriy.shevchenko@linux.intel.com>
	 <20150728074829.GU21114@x1> <20150728075329.GW21114@x1>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150728075329.GW21114@x1>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vinod Koul <vinod.koul@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, mturquette@baylibre.com, sboyd@codeaurora.org
List-Id: linux-pm@vger.kernel.org

On Tue, 2015-07-28 at 08:53 +0100, Lee Jones wrote:
> FAO Vinod,
> 
> On Tue, 28 Jul 2015, Lee Jones wrote:
> > On Mon, 27 Jul 2015, Andy Shevchenko wrote:
> > 
> > > Intel integrated DMA (iDMA) 64-bit is a specific IP that is used 
> > > as a part of
> > > LPSS devices such as HSUART or SPI. The iDMA IP is attached for 
> > > private
> > > usage on each host controller independently.
> > > 
> > > While it has similarities with Synopsys DesignWare DMA, the 
> > > following
> > > distinctions doesn't allow to use the existing driver:
> > > - 64-bit mode with corresponding changes in Hardware Linked List 
> > > data structure
> > > - many slight differences in the channel registers
> > > 
> > > Moreover this driver is based on the DMA virtual channels 
> > > framework that helps
> > > to make the driver cleaner and easy to understand.
> > > 
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com
> > > >
> > > ---
> > >  drivers/dma/Kconfig  |   8 +
> > >  drivers/dma/Makefile |   1 +
> > >  drivers/dma/idma64.c | 710 
> > > +++++++++++++++++++++++++++++++++++++++++++++++++++
> > >  drivers/dma/idma64.h | 233 +++++++++++++++++
> > >  4 files changed, 952 insertions(+)
> > >  create mode 100644 drivers/dma/idma64.c
> > >  create mode 100644 drivers/dma/idma64.h
> > 
> > Applied, thanks.  Pull request to follow.
> 
> Will send out a pull request when I have Vinod's Ack.

Vinod, could you have a look at this once again?

> 
> [...]
> 
> Patches will still be applied to -next for soak testing though.

Thanks!


-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
