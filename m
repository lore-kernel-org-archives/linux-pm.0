From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v5 0/8] mfd: introduce a driver for LPSS devices on SPT
Date: Thu, 16 Jul 2015 18:58:08 +0530
Message-ID: <20150716132808.GY5086@localhost>
References: <1436185334-34275-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1436962531.10819.135.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:65032 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751677AbbGPN01 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 16 Jul 2015 09:26:27 -0400
Content-Disposition: inline
In-Reply-To: <1436962531.10819.135.camel@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Lee Jones <lee.jones@linaro.org>, Andrew Morton <akpm@linux-foundation.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, mturquette@baylibre.com

On Wed, Jul 15, 2015 at 03:15:31PM +0300, Andy Shevchenko wrote:
> On Mon, 2015-07-06 at 15:22 +0300, Andy Shevchenko wrote:
> > The new coming Intel platforms such as Skylake will contain 
> > Sunrisepoint PCH.
> > 
> > The driver is based on MFD framework since the main device, i.e. 
> > serial bus
> > controller, contains register space for itself, DMA part, and an 
> > additional
> > address space (convergence layer). 
> > 
> > The public specification of the register map is avaiable in [1].
> > 
> > This is fifth generation of the patch series to bring support LPSS 
> > devices
> > found on Intel Sunrisepoint (Intel Skylake PCH). Previous one can be 
> > found here
> > [2].
> > 
> > The series has few logical parts:
> > - patches 1-3 prepares PM core, ACPI, and driver core (PM) to handle 
> > our case
> > - patches 4-6 introduce unregistering platform devices in MFD in 
> > reversed
> >   order
> > - patch 7 implements iDMA 64-bit driver
> > - patch 8 introduces an MFD driver for LPSS devices
> > 
> > The patch 7 can be applied independently, though it's better if it 
> > goes before
> > patch 8.
> > 
> > The driver has been tested with SPI and UART on Intel Skylake PCH.
> > 
> > [1] https://download.01.org/future-platform-configuration
> > -hub/skylake/register-definitions/332219-002.pdf
> > [2] http://www.spinics.net/lists/linux-acpi/msg58622.html
> 
> Gentle ping on this.
> 
> Vinod, can you Ack the DMA driver?
I thought it was independent and can go thru dmaengine tree..?

-- 
~Vinod

