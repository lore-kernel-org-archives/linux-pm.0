From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 2/2] dt-bindings: power: reset: add document for NVMEM
 based reboot-mode
Date: Tue, 30 Apr 2019 17:47:31 -0500
Message-ID: <20190430224731.GA31760@bogus>
References: <fc60b885f1b447ce55950184c7921cfc1c96ade6>
 <20190421190913.1478-3-nandor.han@vaisala.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190421190913.1478-3-nandor.han@vaisala.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Han Nandor <nandor.han@vaisala.com>
Cc: "sre@kernel.org" <sre@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sun, Apr 21, 2019 at 07:09:30PM +0000, Han Nandor wrote:
> Add the device tree bindings document for the NVMEM based reboot-mode
> driver.
> 
> Signed-off-by: Nandor Han <nandor.han@vaisala.com>
> ---
>  .../power/reset/nvmem-reboot-mode.txt         | 32 +++++++++++++++++++
>  1 file changed, 32 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/reset/nvmem-reboot-mode.txt
> 
> diff --git a/Documentation/devicetree/bindings/power/reset/nvmem-reboot-mode.txt b/Documentation/devicetree/bindings/power/reset/nvmem-reboot-mode.txt
> new file mode 100644
> index 000000000000..2e1b86c31cb3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/reset/nvmem-reboot-mode.txt
> @@ -0,0 +1,32 @@
> +NVMEM reboot mode driver
> +
> +This driver gets reboot mode magic value from reboot-mode driver
> +and stores it in a NVMEM cell named "reboot-mode". Then the bootloader
> +can read it and take different action according to the magic
> +value stored.

This is also assuming the nvmem is writeable which is more often not the 
case.

Is your usecase a platform that supports pstore? Adding on to that 
binding might be a better fit.

> +
> +This DT node should be represented as a sub-node of a "simple-mfd"
> +node.
> +
> +Required properties:
> +- compatible: should be "nvmem-reboot-mode".
> +- nvmem-cells: A phandle to the reboot mode provided by a nvmem device.
> +- nvmem-cell-names: Should be "reboot-mode".
> +
> +The rest of the properties should follow the generic reboot-mode description
> +found in reboot-mode.txt
> +
> +Example:
> +	reboot-mode-nvmem@0 {

What's this node for?

> +		compatible = "simple-mfd";

I only see 1 function.

> +		reboot-mode {
> +			compatible = "nvmem-reboot-mode";
> +			nvmem-cells = <&reboot_mode>;
> +			nvmem-cell-names = "reboot-mode";
> +
> +			mode-normal     = <0xAAAA5501>;
> +			mode-bootloader = <0xBBBB5500>;
> +			mode-recovery   = <0xCCCC5502>;
> +			mode-test       = <0xDDDD5503>;
> +		};
> +	};
> -- 
> 2.17.2
> 
