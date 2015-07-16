From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v5 0/8] mfd: introduce a driver for LPSS devices on SPT
Date: Thu, 16 Jul 2015 16:55:07 +0300
Message-ID: <1437054907.8014.17.camel@linux.intel.com>
References: <1436185334-34275-1-git-send-email-andriy.shevchenko@linux.intel.com>
	 <1436962531.10819.135.camel@linux.intel.com>
	 <20150716132808.GY5086@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20150716132808.GY5086@localhost>
Sender: linux-acpi-owner@vger.kernel.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Lee Jones <lee.jones@linaro.org>, Andrew Morton <akpm@linux-foundation.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, mturquette@baylibre.com
List-Id: linux-pm@vger.kernel.org

On Thu, 2015-07-16 at 18:58 +0530, Vinod Koul wrote:
> On Wed, Jul 15, 2015 at 03:15:31PM +0300, Andy Shevchenko wrote:
> > On Mon, 2015-07-06 at 15:22 +0300, Andy Shevchenko wrote:
> > > The new coming Intel platforms such as Skylake will contain 
> > > Sunrisepoint PCH.
> > > 
> > > The driver is based on MFD framework since the main device, i.e. 
> > > serial bus
> > > controller, contains register space for itself, DMA part, and an 
> > > additional
> > > address space (convergence layer). 
> > > 
> > > The public specification of the register map is avaiable in [1].
> > > 
> > > This is fifth generation of the patch series to bring support 
> > > LPSS 
> > > devices
> > > found on Intel Sunrisepoint (Intel Skylake PCH). Previous one can 
> > > be 
> > > found here
> > > [2].
> > > 
> > > The series has few logical parts:
> > > - patches 1-3 prepares PM core, ACPI, and driver core (PM) to 
> > > handle 
> > > our case
> > > - patches 4-6 introduce unregistering platform devices in MFD in 
> > > reversed
> > >   order
> > > - patch 7 implements iDMA 64-bit driver
> > > - patch 8 introduces an MFD driver for LPSS devices
> > > 
> > > The patch 7 can be applied independently, though it's better if 
> > > it 
> > > goes before
> > > patch 8.
> > > 
> > > The driver has been tested with SPI and UART on Intel Skylake 
> > > PCH.
> > > 
> > > [1] https://download.01.org/future-platform-configuration
> > > -hub/skylake/register-definitions/332219-002.pdf
> > > [2] http://www.spinics.net/lists/linux-acpi/msg58622.html
> > 
> > Gentle ping on this.
> > 
> > Vinod, can you Ack the DMA driver?
> I thought it was independent and can go thru dmaengine tree..?

Technically yes, logically it doesn't make much sense to go outside of
the series, on one hand we will have driver without users, on the other
the actual user may experience performance issues. So, the first one is
preferred if we push this driver separately. You may go ahead if you
have no objections.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
