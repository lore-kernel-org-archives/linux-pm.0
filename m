From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] PM / Domains: Power on the PM domain right after attach
 completes
Date: Mon, 17 Nov 2014 17:07:28 +0000
Message-ID: <20141117170728.GX4042@n2100.arm.linux.org.uk>
References: <1416237550-31092-1-git-send-email-ulf.hansson@linaro.org>
 <20141117153257.GS4042@n2100.arm.linux.org.uk>
 <546A2854.3020204@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <546A2854.3020204@ti.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Len Brown <len.brown@intel.com>, linux-samsung-soc@vger.kernel.org, Sylwester Nawrocki <s.nawrocki@samsung.com>, Geert Uytterhoeven <geert+renesas@glider.be>, linux-pm@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@linaro.org>, Pavel Machek <pavel@ucw.cz>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Mon, Nov 17, 2014 at 06:54:44PM +0200, Grygorii Strashko wrote:
> I'd be very appreciated if you would be able to clarify one point to me as
> I'm not familiar with amba hw?
> 
> I've found at least 2 AMBA drivers where secondary clock is used 
> to enable/disable device in addition to "apb_pclk":
>  - drivers/mmc/host/mmci.c 
>  - drivers/spi/spi-pl022.c
> So, form the code point of view, the assumption that "unbound AMBA
> devices are already powered up" is not always true. And "apb_pclk"
> is just an interface clock in such cases. 

Right, what we're talking about here is that the device is accessible
to the CPU - that it is powered up and the bus clock to it is running,
so that accesses to the device will not cause a bus fault.

It does not mean that the external interface to the outside world is
functional - for example, there's no suggestion that the clock to the
SD/MMC card attached to MMCI would be running, or that the SD/MMC card
itself would be powered up, and the same goes for the clocks supplied
as functional clocks.  The driver is expected to manage these clocks
(see below.)

How this all works in the AMBA context is:

- we ensure that the apb_pclk is running by getting it, preparing and
  enabling it.

- the bus code calls pm_runtime_get_noresume() which increments the
  usage counter without calling the (as yet not bound) driver.

- if a PM domain is attached to the device, it should already be active
  and powered up.

- the device is marked active (as it should now be powered and bus-clocked.)

- runtime PM is enabled.

At this point, the device must be accessible to the CPU.

- the driver probe function is called, and it can go around getting any
  additional clocks it needs, and enabling or disabling them as it
  requires.  (For example, in the case of MMCI, a card may not be inserted
  in the slot, so the driver may decide to keep the functional MMCICLK
  disabled.)

- if the driver wishes to take part in runtime PM, it calls pm_runtime_put()
  or an equivalent function.  This balances the pm_runtime_get_noresume()
  above, and allows the runtime PM infrastructure to consider the device
  idle, and a candidate for runtime suspend.

Should the device runtime suspend, it's up to the driver to deal with the
functional clocks it is managing, because only it knows whether it kept
those clocks running, and disabling an already disabled clock is not
permitted.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
