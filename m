From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v5 1/6] I2C: i2c-smbus: add device tree support
Date: Wed, 21 Sep 2016 12:34:05 +0100
Message-ID: <20160921113405.GE18176@leverpostej>
References: <1474447274-90821-1-git-send-email-preid@electromag.com.au>
 <1474447274-90821-2-git-send-email-preid@electromag.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:46162 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754642AbcIULe0 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 21 Sep 2016 07:34:26 -0400
Content-Disposition: inline
In-Reply-To: <1474447274-90821-2-git-send-email-preid@electromag.com.au>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Phil Reid <preid@electromag.com.au>
Cc: wsa@the-dreams.de, robh+dt@kernel.org, sre@kernel.org, andrea.merello@gmail.com, karl-heinz@schneider-inet.de, arnd@arndb.de, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org

On Wed, Sep 21, 2016 at 04:41:09PM +0800, Phil Reid wrote:
> From: Andrea Merello <andrea.merello@gmail.com>
> 
> According to Documentation/i2c/smbus-protocol, a smbus controller driver
> that wants to hook-in smbus extensions support, can call
> i2c_setup_smbus_alert(). There are very few drivers that are currently
> doing this.
> 
> However the i2c-smbus module can also work with any
> smbus-extensions-unaware I2C controller, as long as we provide an extra
> IRQ line connected to the I2C bus ALARM signal.
> 
> This patch makes it possible to go this way via DT. Note that the DT node
> will indeed describe a (little) piece of HW, that is the routing of the
> ALARM signal to an IRQ line (so it seems a fair DT use to me, but RFC).

Which piece of hardware actually generates this IRQ? The I2C controller?
A slave SMBus device? Or something else?

I'm not at all familiar with I2C or SMBus, and a quick scan of
Documentation/i2c/smbus-protocol, has left me none-the-wiser on that
front.

> Note that AFAICT, by design, i2c-smbus module pretends to be an I2C slave
> with address 0x0C (that is the alarm response address), and IMHO this is
> quite consistent with usage in the DT as a I2C child node.
> 
> Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
> Signed-off-by: Phil Reid <preid@electromag.com.au>
> ---
>  Documentation/devicetree/bindings/i2c/i2c-smbus.txt | 20 ++++++++++++++++++++
>  drivers/i2c/i2c-smbus.c                             | 20 +++++++++++++++-----
>  2 files changed, 35 insertions(+), 5 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/i2c/i2c-smbus.txt
> 
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-smbus.txt b/Documentation/devicetree/bindings/i2c/i2c-smbus.txt
> new file mode 100644
> index 0000000..da83127
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/i2c/i2c-smbus.txt
> @@ -0,0 +1,20 @@
> +* i2c-smbus extensions
> +
> +Required Properties:
> +  - compatible: Must contain "smbus_alert"

Nit: s/_/-/ in compatible strings please.

> +  - interrupts: The irq line for smbus ALERT signal
> +  - reg: I2C slave address. Set to 0x0C (alert response address).
> +
> +Note: The i2c-smbus module registers itself as a slave I2C device. Whenever
> +a smbus controller directly support smbus extensions (and its driver supports
> +this), there is no need to add anything special to the DT. Otherwise, for using
> +i2c-smbus with any smbus-extensions-unaware I2C controllers, you need to
> +route the smbus ALARM signal to an extra IRQ line, thus you need to describe
> +this in the DT.

Bindings shouldn't mention driver details (e.g. the i2c-smbus module
behaviour). It feels like we're creating a virtual device for the sake
of a driver, rather than accurately capturing the hardware.

So as-is, I don't think this is the right way to describe this.

Thanks,
Mark.
