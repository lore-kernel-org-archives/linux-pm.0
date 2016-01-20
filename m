From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 1/4] dt-bindings: power: reset: add document for
 reboot-mode driver
Date: Wed, 20 Jan 2016 12:28:40 -0600
Message-ID: <20160120182840.GA15741@rob-hp-laptop>
References: <1452598029-8222-1-git-send-email-andy.yan@rock-chips.com>
 <1452598189-8272-1-git-send-email-andy.yan@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:51786 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934679AbcATS2q (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 20 Jan 2016 13:28:46 -0500
Content-Disposition: inline
In-Reply-To: <1452598189-8272-1-git-send-email-andy.yan@rock-chips.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andy Yan <andy.yan@rock-chips.com>
Cc: heiko@sntech.de, arnd@arndb.de, john.stultz@linaro.org, linux@roeck-us.net, galak@codeaurora.org, ijc+devicetree@hellion.org.uk, catalin.marinas@arm.com, geert+renesas@glider.be, sre@kernel.org, olof@lixom.net, dbaryshkov@gmail.com, alexandre.belloni@free-electrons.com, jun.nie@linaro.org, pawel.moll@arm.com, f.fainelli@gmail.com, will.deacon@arm.com, linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org, lorenzo.pieralisi@arm.com, moritz.fischer@ettus.com, cernekee@gmail.com, linux-kernel@vger.kernel.org, dwmw2@infradead.org, mark.rutland@arm.com, maxime.ripard@free-electrons.com

On Tue, Jan 12, 2016 at 07:29:49PM +0800, Andy Yan wrote:
> add device tree binding document for reboot-mode driver
> 
> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
> 
> ---
> 
> Changes in v2: None
> Changes in v1: None
> 
>  .../bindings/power/reset/reboot-mode.txt           | 41 +++++++++++++++++
>  .../bindings/power/reset/syscon-reboot-mode.txt    | 52 ++++++++++++++++++++++
>  2 files changed, 93 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/reset/reboot-mode.txt
>  create mode 100644 Documentation/devicetree/bindings/power/reset/syscon-reboot-mode.txt
> 
> diff --git a/Documentation/devicetree/bindings/power/reset/reboot-mode.txt b/Documentation/devicetree/bindings/power/reset/reboot-mode.txt
> new file mode 100644
> index 0000000..81d9f66
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/reset/reboot-mode.txt
> @@ -0,0 +1,41 @@
> +Generic reboot mode core map driver
> +
> +This driver get reboot mode arguments and call the write
> +interface to stores the magic value in special register
> +or ram . Then the bootloader can read it and take different
> +action according to the argument stored.
> +
> +Required properties:
> +- compatible: only support "syscon-reboot-mode" now.
> +
> +Each mode is represented as a sub-node of reboot_mode:
> +
> +Subnode required properties:
> +- linux,mode: reboot mode command,such as "loader", "recovery", "fastboot".
> +- loader,magic: magic number for the mode, this is vendor specific.
> +
> +Example:
> +	reboot_mode {

reboot-mode instead please.

> +		compatible = "syscon-reboot-mode";
> +		offset = <0x40>;

This doc by itself is a little confusing. For example, is a child of the 
syscon node? I would remove offset (and perhaps compatible) from this 
example.

> +
> +		loader {
> +			linux,mode = "loader";
> +			loader,magic = <BOOT_LOADER>;
> +		};

Sorry, my previous suggestion was not clear. I'm suggesting get rid of 
the subnodes and just do properties like this:

loader = <BOOT_LOADER>;
maskrom = <BOOT_MASKROM>;

That's the same amount of information unless node names and linux,mode 
values are going to diverge. Do they need to? I can't see a reason.


We need to be clear what loader means. More specifically, it is boot 
into bootloader shell. 

> +
> +		maskrom {

In theory, the bootrom could have multiple modes. This typically means a 
USB download mode. So perhaps a more precise name would be 
"rom-download". 

In chips I'm familiar with the bootrom mode is selected via a different 
mechanism than the secondary bootloader modes, but I suppose the same 
mechanism could be used.

> +			linux,mode = "maskrom";
> +			loader,magic = <BOOT_MASKROM>;
> +		};
> +
> +		recovery {
> +			linux,mode = "recovery";
> +			loader,magic = <BOOT_RECOVERY>;
> +		};
> +
> +		fastboot {
> +			linux,mode = "fastboot";
> +			loader,magic = <BOOT_FASTBOOT>;
> +		};
