From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 1/4] dt-bindings: power: reset: add document for
 reboot-mode driver
Date: Thu, 4 Feb 2016 17:08:14 -0600
Message-ID: <20160204230814.GA4847@rob-hp-laptop>
References: <1454406981-4692-1-git-send-email-andy.yan@rock-chips.com>
 <1454407151-4751-1-git-send-email-andy.yan@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1454407151-4751-1-git-send-email-andy.yan-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Yan <andy.yan-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Cc: arnd-r2nGTMty4D4@public.gmane.org, john.stultz-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, moritz.fischer-+aYTwkv1SeIAvxtiuMwx3w@public.gmane.org, matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, jun.nie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, mbrugger-IBi9RG/b67k@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, richard-/L3Ra7n9ekc@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Tue, Feb 02, 2016 at 05:59:11PM +0800, Andy Yan wrote:
> add device tree bindings document for reboot-mode driver
> 
> Signed-off-by: Andy Yan <andy.yan-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
> 
> ---
> 
> Changes in v3:
> - descirbe all reboot mode as properity instead of subnode
> 
> Changes in v2: None
> Changes in v1: None
> 
>  .../bindings/power/reset/reboot-mode.txt           | 26 ++++++++++++++++
>  .../bindings/power/reset/syscon-reboot-mode.txt    | 36 ++++++++++++++++++++++
>  2 files changed, 62 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/reset/reboot-mode.txt
>  create mode 100644 Documentation/devicetree/bindings/power/reset/syscon-reboot-mode.txt
> 
> diff --git a/Documentation/devicetree/bindings/power/reset/reboot-mode.txt b/Documentation/devicetree/bindings/power/reset/reboot-mode.txt
> new file mode 100644
> index 0000000..517080f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/reset/reboot-mode.txt
> @@ -0,0 +1,26 @@
> +Generic reboot mode core map driver
> +
> +This driver get reboot mode arguments and call the write
> +interface to stores the magic value in special register
> +or ram . Then the bootloader can read it and take different
> +action according the argument stored.
> +
> +All mode properties are vendor specific, it is a indication to tell

The values should be vendor specific. The property names should not. We 
can allow vendor specific ones, but we need to have a common set.

> +the bootloder what to do when the system reboot, and should be named
> +as mode-xxx = <magic> (xxx is mode name).
> +
> +- mode-normal: Normal reboot mode, system reboot with command "reboot".
> +- mode-recovery: Android Recovery mode, it is a mode to format the device or update a new image.
> +- mode-fastboot: Android fastboot mode, it's a mode to  re-flash partitions on the device.
> +- mode-loader: A bootloader mode, it's a mode used to download image on Rockchip platform,
> +	       usually used in development.
> +- mode-maskrom: It's a mode to download bootloader on Rockchip platform.
> +
> +Example:
> +	reboot-mode {
> +		mode-normal = <BOOT_NORMAL>;
> +		mode-recovery = <BOOT_RECOVERY>;
> +		mode-fastboot = <BOOT_FASTBOOT>;

I tend to agree with John on calling this mode-bootloader.

OTOH, fastboot is more specific about what the mode is. The name in DT 
and the userspace name don't necessarily have to be the same.

> +		mode-loader = <BOOT_LOADER>;

This one needs a better name. Maybe it should be 'rockchip,mode-loader' 
as it is vendor specific. Either way, loader is vague. Perhaps 
rockchip,mode-bl-download?

> +		mode-maskrom = <BOOT_MASKROM>;

I think this should be "mode-rom-download".

> +	}
> diff --git a/Documentation/devicetree/bindings/power/reset/syscon-reboot-mode.txt b/Documentation/devicetree/bindings/power/reset/syscon-reboot-mode.txt
> new file mode 100644
> index 0000000..923c82b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/reset/syscon-reboot-mode.txt
> @@ -0,0 +1,36 @@
> +SYSCON reboot mode driver
> +
> +This driver get reboot mode magic value form reboot-mode driver
> +and stores it in a SYSCON mapped register. Then the bootloader
> +can read it and take different action according to the magic
> +value stored.
> +
> +This DT node should be represented as a sub-node of a "syscon", "simple-mfd"
> +node.

Whether or not it is a simple-mfd or not depends on the syscon node.

> +
> +Required properties:
> +- compatible: should be "syscon-reboot-mode"
> +- offset: offset in the register map for the storage register (in bytes)
> +
> +Optional properity:
> +- mask: the mask bits of the mode magic value, default set to 0xffffffff if missing.
> +
> +The rest of the properties should follow the generic reboot-mode discription
> +found in reboot-mode.txt
> +
> +Example:
> +	pmu: pmu@20004000 {
> +		compatible = "rockchip,rk3066-pmu", "syscon", "simple-mfd";
> +		reg = <0x20004000 0x100>;
> +
> +		reboot-mode {
> +			compatible = "syscon-reboot-mode";
> +			offset = <0x40>;
> +			mode-normal = <BOOT_NORMAL>;
> +			mode-recovery = <BOOT_RECOVERY>;
> +			mode-fastboot = <BOOT_FASTBOOT>;
> +			mode-loader = <BOOT_LOADER>;
> +			mode-maskrom = <BOOT_MASKROM>;
> +
> +		};
> +	};
> -- 
> 1.9.1
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
