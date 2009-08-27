From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] rtc: Set wakeup capability for I2C and SPI
	RTC drivers
Date: Thu, 27 Aug 2009 14:52:36 -0700
Message-ID: <200908271452.37358.david-b@pacbell.net>
References: <20090827182207.GA7358@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090827182207.GA7358@oksana.dev.rtsoft.ru>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, Ben Dooks <ben-linux@fluff.org>, Jean Delvare <khali@linux-fr.org>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

NAK; see details below

On Thursday 27 August 2009, Anton Vorontsov wrote:
> RTC core won't allow wakeup alarms to be set if RTC devices' parent
> (i.e. i2c_client or spi_device) isn't wakeup capable.

Quite rightly so ... being wakeup-capable is config-specific.


> For I2C devices there is I2C_CLIENT_WAKE flag exists that we can pass
> via board info, and if set, I2C core will initialize wakeup capability.
> For SPI devices there is no such flag at all.

So why not add it for SPI?  If it's an issue, it's not
unique to RTC devices.

 
> I believe that it's not platform code responsibility to allow or
> disallow wakeups, instead, drivers themselves should set the capability
> if a device can trigger wakeups.

Drivers can't generally know if that's possible though.
They need to be told that it is, by platform code.

Most devices can't issue wakeup events.

 
> That's what drivers/base/power/sysfs.c says:
> 
>  * It is the responsibility of device drivers to enable (or disable)
>  * wakeup signaling as part of changing device power states, respecting
>  * the policy choices provided through the driver model.
> 
> I2C and SPI RTC devices send wakeup events via interrupt lines, so we
> should set the wakeup capability if IRQ is routed.

Re-read the quoted sentence.  You're saying that policy
choices should be hard-wired into the driver; contrary
to that quote.  (In this case the choice is one that
platform code must report, and which the hardware
designer made:  if the device can issue wakeup events.)  


> Ideally we should also check irq for wakeup capability before setting
> device's capability, i.e.
> 
> 	if (can_irq_wake(irq))
> 		device_set_wakeup_capable(&client->dev, 1);
> 
> But there is no can_irq_wake() call exist, and it is not that trivial
> to implement it for all interrupts controllers and complex/cascaded
> setups.

That is why platform code should device_init_wakeup() and
drivers should check device_can_wakeup(dev) ...


> drivers/base/power/sysfs.c also covers these cases:
> 
>  * Devices may not be able to generate wakeup events from all power
>  * states.  Also, the events may be ignored in some configurations;
>  * for example, they might need help from other devices that aren't
>  * active
> 
> So there is no guarantee that wakeup will actually work, 

Yes there is ... it's only **exceptional** cases where it can't
work.  Your patch would make it routine that those flags be
unreliable; pretty nasty.
