From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH v3 2/3] DT: bingdings: power: reset: add linkstation-reset
 doc
Date: Mon, 2 Jan 2017 21:21:09 -0800
Message-ID: <519e07d0-9b73-4445-ec5e-7ea2cbc1b814@gmail.com>
References: <20161216100501.18173-1-rogershimizu@gmail.com>
 <20161227070611.14852-1-rogershimizu@gmail.com>
 <20161227070611.14852-3-rogershimizu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:34996 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755724AbdACFVM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Jan 2017 00:21:12 -0500
In-Reply-To: <20161227070611.14852-3-rogershimizu@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Roger Shimizu <rogershimizu@gmail.com>, Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Ryan Tandy <ryan@nardis.ca>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org



On 12/26/2016 11:06 PM, Roger Shimizu wrote:
> Add linkstation-reset doc to describe the newly added
> POWER_RESET_LINKSTATION driver, which controls magic command
> sending to UART1 to power-off Buffalo Linkstation / KuroBox
> and their variants.
> 
> To: Sebastian Reichel <sre@kernel.org>
> To: Rob Herring <robh+dt@kernel.org>
> To: Mark Rutland <mark.rutland@arm.com>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Ryan Tandy <ryan@nardis.ca>
> Cc: linux-pm@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> 
> Signed-off-by: Roger Shimizu <rogershimizu@gmail.com>
> ---
>  .../bindings/power/reset/linkstation-reset.txt     | 26 ++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/reset/linkstation-reset.txt
> 
> diff --git a/Documentation/devicetree/bindings/power/reset/linkstation-reset.txt b/Documentation/devicetree/bindings/power/reset/linkstation-reset.txt
> new file mode 100644
> index 000000000000..815e340318f3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/reset/linkstation-reset.txt
> @@ -0,0 +1,26 @@
> +* Buffalo Linkstation Reset Driver
> +
> +Power of some Buffalo Linkstation or KuroBox Pro is managed by
> +micro-controller, which connects to UART1. After being fed from UART1
> +by a few magic numbers, the so-called power-off command,
> +the micro-controller will turn power off the device.
> +
> +This is very similar to QNAP or Synology NAS devices, which is
> +described in qnap-poweroff.txt, however the command is much simpler,
> +only 1-byte long and without checksums.
> +
> +This driver adds a handler to pm_power_off which is called to turn the
> +power off.

This is a driver implementation detail, so does not really belong in the
DT here.

> +
> +Required Properties:
> +- compatible: Should be "linkstation,power-off"
> +- reg: Address and length of the register set for UART1

Humm, should we instead have a phandle to the uart1 node?

> +- clocks: tclk clock
> +
> +Example:
> +
> +	reset {
> +		compatible = "linkstation,power-off";
> +		reg = <0x12100 0x100>;
> +		clocks = <&core_clk 0>;
> +	};
> 

-- 
Florian
