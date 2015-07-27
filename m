From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v6 0/8] mfd: introduce a driver for LPSS devices on SPT
Date: Mon, 27 Jul 2015 19:04:47 +0300
Message-ID: <20150727160447.GL1577@lahna.fi.intel.com>
References: <1438009443-55317-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <20150727152733.GB21114@x1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150727152733.GB21114@x1>
Sender: linux-acpi-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vinod Koul <vinod.koul@intel.com>, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, mturquette@baylibre.com, sboyd@codeaurora.org
List-Id: linux-pm@vger.kernel.org

On Mon, Jul 27, 2015 at 04:27:33PM +0100, Lee Jones wrote:
> FAO Stephen Boyd,
> 
> > Stephen, can you, please, have a look into patch 8 regarding to clock name
> > matching and other stuff Lee asked?
> 
> Patch 8:
> 
>       "Can you review the clock implementation please?  It looks
>       fragile to me as it relies heavily on device names constructed
>       of MFD cell names and IDA numbers cat'ed together!"

Lee, can you suggest an alternative then?

Why we are doing it like this is that number of different LPSS devices
changes from SoC to SoC. In addition to that the device (called "slice")
might have iDMA block or not.

Since the drivers in question (pxa2xx-spi, i2c-designware and 8250_dw)
use standard clk framework to request their clocks the Linux device must
have clock registered which matches the device in advance.

Because we add the host controller device dynamically (from the MFD
driver) based on how many devices are actually present, we need somehow
predict what would be the correct name and instance number for that
device to get the clock for it. That's the reason we use IDA here along
with the cell name (or driver name).
