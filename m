From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v5 1/6] I2C: i2c-smbus: add device tree support
Date: Fri, 23 Sep 2016 14:42:13 -0500
Message-ID: <20160923194213.GA24328@rob-hp-laptop>
References: <1474447274-90821-1-git-send-email-preid@electromag.com.au>
 <1474447274-90821-2-git-send-email-preid@electromag.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:33002 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760699AbcIWTmP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 23 Sep 2016 15:42:15 -0400
Content-Disposition: inline
In-Reply-To: <1474447274-90821-2-git-send-email-preid@electromag.com.au>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Phil Reid <preid@electromag.com.au>
Cc: wsa@the-dreams.de, mark.rutland@arm.com, sre@kernel.org, andrea.merello@gmail.com, karl-heinz@schneider-inet.de, arnd@arndb.de, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org

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
> 
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
> +  - interrupts: The irq line for smbus ALERT signal
> +  - reg: I2C slave address. Set to 0x0C (alert response address).

This is not right. The 0xC address is special, not an actual device 
address. The bindings should just have the actual device's compatible 
string and address.

> +
> +Note: The i2c-smbus module registers itself as a slave I2C device. Whenever
> +a smbus controller directly support smbus extensions (and its driver supports
> +this), there is no need to add anything special to the DT. Otherwise, for using
> +i2c-smbus with any smbus-extensions-unaware I2C controllers, you need to
> +route the smbus ALARM signal to an extra IRQ line, thus you need to describe
> +this in the DT.

Now, I guess what you need in the kernel is a common handler for 
SMBALERT# and to know which interrupt line is SMBALERT#.

The drivers should know this. A given h/w device will or will not handle 
the "SMB Alert Response Address". So the drivers should register their 
interrupt with the I2C/SMBus core.

If a controller handles the SMBALERT, then it should make itself an 
interrupt controller and that's what slave devices 'interrupts' property 
will point to.

Rob
