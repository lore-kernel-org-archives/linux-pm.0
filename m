From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v6 7/8] dmaengine: add a driver for Intel integrated DMA
 64-bit
Date: Tue, 28 Jul 2015 14:13:47 +0530
Message-ID: <20150728084347.GB29916@localhost>
References: <1438009443-55317-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1438009443-55317-8-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1438009443-55317-8-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Lee Jones <lee.jones@linaro.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, mturquette@baylibre.com, sboyd@codeaurora.org
List-Id: linux-pm@vger.kernel.org

On Mon, Jul 27, 2015 at 06:04:02PM +0300, Andy Shevchenko wrote:
> Intel integrated DMA (iDMA) 64-bit is a specific IP that is used as a part of
> LPSS devices such as HSUART or SPI. The iDMA IP is attached for private
> usage on each host controller independently.
> 
> While it has similarities with Synopsys DesignWare DMA, the following
> distinctions doesn't allow to use the existing driver:
> - 64-bit mode with corresponding changes in Hardware Linked List data structure
> - many slight differences in the channel registers
> 
> Moreover this driver is based on the DMA virtual channels framework that helps
> to make the driver cleaner and easy to understand.
Acked-by: Vinod Koul <vinod.koul@intel.com>

-- 
~Vinod
