From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v6 0/8] mfd: introduce a driver for LPSS devices on SPT
Date: Tue, 28 Jul 2015 12:02:27 +0300
Message-ID: <20150728090227.GP1577@lahna.fi.intel.com>
References: <1438009443-55317-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <20150728085930.GR14943@x1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150728085930.GR14943@x1>
Sender: linux-acpi-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vinod Koul <vinod.koul@intel.com>, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, mturquette@baylibre.com, sboyd@codeaurora.org
List-Id: linux-pm@vger.kernel.org

On Tue, Jul 28, 2015 at 09:59:30AM +0100, Lee Jones wrote:
> Enjoy,
> 
> The following changes since commit bc0195aad0daa2ad5b0d76cce22b167bc3435590:
> 
>   Linux 4.2-rc2 (2015-07-12 15:10:30 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/ib-mfd-base-acpi-dma-v4.3
> 
> for you to fetch changes up to 4b45efe8526359a11ca60a299bef3aebf413fd77:
> 
>   mfd: Add support for Intel Sunrisepoint LPSS devices (2015-07-28 09:56:47 +0100)
> 
> ----------------------------------------------------------------
> Immutable branch between MFD, Base, ACPI and DMA due for v4.3
> 
> ----------------------------------------------------------------
> Andy Shevchenko (5):
>       klist: implement klist_prev()
>       driver core: implement device_for_each_child_reverse()
>       mfd: make mfd_remove_devices() iterate in reverse order
>       dmaengine: add a driver for Intel integrated DMA 64-bit
>       mfd: Add support for Intel Sunrisepoint LPSS devices
> 
> Mika Westerberg (2):
>       PM / QoS: Make it possible to expose device latency tolerance to userspace
>       ACPI / PM: Attach ACPI power domain only once
> 
> Rafael J. Wysocki (1):
>       Driver core: wakeup the parent device before trying probe

Thank you :-)
