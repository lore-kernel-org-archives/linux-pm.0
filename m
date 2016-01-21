From: Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 3/4] ARM: dts: rockchip: add syscon-reboot-mode node
Date: Thu, 21 Jan 2016 09:38:17 +0100
Message-ID: <56A098F9.5020100@gmail.com>
References: <1452598029-8222-1-git-send-email-andy.yan@rock-chips.com>
 <1452598378-8371-1-git-send-email-andy.yan@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1452598378-8371-1-git-send-email-andy.yan-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Yan <andy.yan-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, john.stultz-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, cernekee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, moritz.fischer-+aYTwkv1SeIAvxtiuMwx3w@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org, jun.nie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org
List-Id: linux-pm@vger.kernel.org



On 12/01/16 12:32, Andy Yan wrote:
> Rockchip platform use a SYSCON mapped register store
> the reboot mode magic value for bootloader to use when
> system reboot. So add syscon-reboot-mode driver DT node
> for rk3xxx,rk3288 platform
>
> Signed-off-by: Andy Yan <andy.yan-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
>
> ---

Reviewed-by: Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

>
> Changes in v2:
> - make this node as a subnode of PMU
>
> Changes in v1:
> - correct the maskrom magic number
> - use macro defined in rockchip_boot-mode.h for reboot-mode DT node
>
>   arch/arm/boot/dts/rk3288.dtsi                | 31 ++++++++++++++++++++++++++
>   arch/arm/boot/dts/rk3xxx.dtsi                | 33 +++++++++++++++++++++++++++-
>   include/dt-bindings/soc/rockchip_boot-mode.h | 30 +++++++++++++++++++++++++
>   3 files changed, 93 insertions(+), 1 deletion(-)
>   create mode 100644 include/dt-bindings/soc/rockchip_boot-mode.h
>
> diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
> index 04ea209..4e49fb7 100644
> --- a/arch/arm/boot/dts/rk3288.dtsi
> +++ b/arch/arm/boot/dts/rk3288.dtsi
> @@ -45,6 +45,7 @@
>   #include <dt-bindings/clock/rk3288-cru.h>
>   #include <dt-bindings/thermal/thermal.h>
>   #include <dt-bindings/power/rk3288-power.h>
> +#include <dt-bindings/soc/rockchip_boot-mode.h>
>   #include "skeleton.dtsi"
>
>   / {
> @@ -712,6 +713,36 @@
>   				clocks = <&cru ACLK_GPU>;
>   			};
>   		};
> +
> +		reboot-mode {
> +			compatible = "syscon-reboot-mode";
> +			offset = <0x94>;
> +
> +			normal {
> +				linux,mode = "normal";
> +				loader,magic = <BOOT_NORMAL>;
> +			};
> +
> +			loader {
> +				linux,mode = "loader";
> +				loader,magic = <BOOT_LOADER>;
> +			};
> +
> +			maskrom {
> +				linux,mode = "maskrom";
> +				loader,magic = <BOOT_MASKROM>;
> +			};
> +
> +			recovery {
> +				linux,mode = "recovery";
> +				loader,magic = <BOOT_RECOVERY>;
> +			};
> +
> +			fastboot {
> +				linux,mode = "fastboot";
> +				loader,magic = <BOOT_FASTBOOT>;
> +			};
> +		};
>   	};
>
>   	sgrf: syscon@ff740000 {
> diff --git a/arch/arm/boot/dts/rk3xxx.dtsi b/arch/arm/boot/dts/rk3xxx.dtsi
> index 4497d28..58af546 100644
> --- a/arch/arm/boot/dts/rk3xxx.dtsi
> +++ b/arch/arm/boot/dts/rk3xxx.dtsi
> @@ -43,6 +43,7 @@
>
>   #include <dt-bindings/interrupt-controller/irq.h>
>   #include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/soc/rockchip_boot-mode.h>
>   #include "skeleton.dtsi"
>
>   / {
> @@ -242,8 +243,38 @@
>   	};
>
>   	pmu: pmu@20004000 {
> -		compatible = "rockchip,rk3066-pmu", "syscon";
> +		compatible = "rockchip,rk3066-pmu", "syscon", "simple-mfd";
>   		reg = <0x20004000 0x100>;
> +
> +		reboot-mode {
> +			compatible = "syscon-reboot-mode";
> +			offset = <0x40>;
> +
> +			normal {
> +				linux,mode = "normal";
> +				loader,magic = <BOOT_NORMAL>;
> +			};
> +
> +			loader {
> +				linux,mode = "loader";
> +				loader,magic = <BOOT_LOADER>;
> +			};
> +
> +			maskrom {
> +				linux,mode = "maskrom";
> +				loader,magic = <BOOT_MASKROM>;
> +			};
> +
> +			recovery {
> +				linux,mode = "recovery";
> +				loader,magic = <BOOT_RECOVERY>;
> +			};
> +
> +			fastboot {
> +				linux,mode = "fastboot";
> +				loader,magic = <BOOT_FASTBOOT>;
> +			};
> +		};
>   	};
>
>   	grf: grf@20008000 {
> diff --git a/include/dt-bindings/soc/rockchip_boot-mode.h b/include/dt-bindings/soc/rockchip_boot-mode.h
> new file mode 100644
> index 0000000..eedf113
> --- /dev/null
> +++ b/include/dt-bindings/soc/rockchip_boot-mode.h
> @@ -0,0 +1,30 @@
> +#ifndef __ROCKCHIP_BOOT_MODE_H
> +#define __ROCKCHIP_BOOT_MODE_H
> +
> +/*high 24 bits is tag, low 8 bits is type*/
> +#define	REBOOT_FLAG		0x5242C300
> +/* normal boot */
> +#define	BOOT_NORMAL		(REBOOT_FLAG + 0)
> +/* enter loader rockusb mode */
> +#define	BOOT_LOADER		(REBOOT_FLAG + 1)
> +/* enter maskrom rockusb mode */
> +#define	BOOT_MASKROM		(0xEF08A53C)
> +/* enter recovery */
> +#define	BOOT_RECOVERY		(REBOOT_FLAG + 3)
> +/* do not enter recover */
> +#define	BOOT_NORECOVER		(REBOOT_FLAG + 4)
> +/* boot second OS*/
> +#define	BOOT_SECONDOS		(REBOOT_FLAG + 5)
> +/* enter recover and wipe data. */
> +#define	BOOT_WIPEDATA		(REBOOT_FLAG + 6)
> +/* enter recover and wipe all data. */
> +#define	BOOT_WIPEALL		(REBOOT_FLAG + 7)
> +/* check firmware img with backup part*/
> +#define	BOOT_CHECKIMG		(REBOOT_FLAG + 8)
> + /* enter fast boot mode */
> +#define	BOOT_FASTBOOT		(REBOOT_FLAG + 9)
> +#define	BOOT_SECUREBOOT_DISABLE	(REBOOT_FLAG + 10)
> +/* enter charge mode */
> +#define	BOOT_CHARGING		(REBOOT_FLAG + 11)
> +
> +#endif
>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
