From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH] ARM: EXYNOS: add power domains support for EXYNOS5440
Date: Fri, 02 Aug 2013 15:01:52 -0600
Message-ID: <51FC1E40.7030807@wwwdotorg.org>
References: <2729097.X0eAsuYF97@amdc1032>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <2729097.X0eAsuYF97@amdc1032>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Kukjin Kim <kgene.kim@samsung.com>, Myungjoo Ham <myungjoo.ham@samsung.com>, Tomasz Figa <t.figa@samsung.com>, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Ian Campbell <ian.campbell@citrix.com>, Mark Rutland <Mark.Rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>
List-Id: linux-pm@vger.kernel.org

(CCing the other DT maintainers, hence quoting binding in full)

On 08/02/2013 07:23 AM, Bartlomiej Zolnierkiewicz wrote:
> On EXYNOS5440 power domains are handled in a different way than on
> the previous EXYNOS SoCs. Add support for them to EXYNOS pm_domains
> driver. Then add device tree nodes for PCIe (controlling power for
> PCIe host controller) and Conn2 (controlling power for Ethernet,
> SATA and USB controllers) power domains to exynos5440.dtsi.
> 
> Currently if runtime Power Management is enabled and the driver
> for devices under power domain is disabled then the power domain
> will be disabled by EXYNOS pm_domains driver. To make more active
> use of power domains (dynamically enable and disabled them as
> needed) it is required to add runtime PM support to pci-exynos,
> stmmac, ahci_platform, ohci-exynos and ehci-s5p drivers (to be
> done later).
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Signed-off-by: Myungjoo Ham <myungjoo.ham@samsung.com>
> Cc: Tomasz Figa <t.figa@samsung.com>
> Cc: Stephen Warren <swarren@wwwdotorg.org>
> ---
>  Documentation/devicetree/bindings/arm/exynos/power_domain.txt |   33 ++
>  arch/arm/boot/dts/exynos5440.dtsi                             |   23 +
>  arch/arm/mach-exynos/Kconfig                                  |    1 
>  arch/arm/mach-exynos/common.c                                 |    4 
>  arch/arm/mach-exynos/pm_domains.c                             |  138 +++++++++-
>  5 files changed, 190 insertions(+), 9 deletions(-)
> 
> Index: b/Documentation/devicetree/bindings/arm/exynos/power_domain.txt
> ===================================================================
> --- a/Documentation/devicetree/bindings/arm/exynos/power_domain.txt	2013-08-02 14:45:53.551392396 +0200
> +++ b/Documentation/devicetree/bindings/arm/exynos/power_domain.txt	2013-08-02 14:46:29.799391845 +0200
> @@ -5,20 +5,47 @@ to gate power to one or more peripherals
>  
>  Required Properties:
>  - compatible: should be one of the following.
> -    * samsung,exynos4210-pd - for exynos4210 type power domain.
> +    * samsung,exynos4210-pd - for Exynos4210 type power domain.
> +    * samsung,exynos5440-pd - for Exynos5440 type power domain.
>  - reg: physical base address of the controller and length of memory mapped
> -    region.
> +    region (Exynos4210 type power domain) or bit offset in the control
> +    register (Exynos5440 type power domain).
> +
> +Additional parent node must be created for Exynos5440 power domains with
> +the following required properties:
> +- compatible: samsung,exynos5440-power-domains, simple-bus
> +- reg: physical base address of the XMU controller and length of memory
> +    mapped region

It's a little odd to describe the child nodes first. Given the 4210 and
5440 bindings work so differently, I'd suggest making separate binding
files for the two; samsung,exynos4210-pd.txt and samsung,exynos5440-pd.txt.

The node being describe here clearly is not a simple-bus; the child
nodes appear to have a specific need that their parent be compatible =
"samsung,exynos5440-power-domains", hence they aren't the independent
devices that simple-bus would usually contain.

Note that I only briefly reviewed the low-level structural aspects of
the binding that I mentioned above; I haven't thought about the binding
at a higher level of e.g. "does this binding conceptually make sense".

>  Node of a device using power domains must have a samsung,power-domain property
>  defined with a phandle to respective power domain.
>  
> -Example:
> +Example for Exynos4210 compatible power domain:
>  
>  	lcd0: power-domain-lcd0 {
>  		compatible = "samsung,exynos4210-pd";
>  		reg = <0x10023C00 0x10>;
>  	};
>  
> +Example for Exynos5440 compatible power domains:
> +
> +	power-domains@00160000 {
> +		compatible = "samsung,exynos5440-power-domains", "simple-bus";
> +		reg = <0x00160000 0x1000>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		pd_pcie: pcie-power-domain@6 {
> +			compatible = "samsung,exynos5440-pd";
> +			reg = <6>;
> +		};
> +
> +		pd_conn2: conn2-power-domain@7 {
> +			compatible = "samsung,exynos5440-pd";
> +			reg = <7>;
> +		};
> +	};
> +
>  Example of the node using power domain:
>  
>  	node {
> Index: b/arch/arm/boot/dts/exynos5440.dtsi
> ===================================================================
> --- a/arch/arm/boot/dts/exynos5440.dtsi	2013-08-02 14:45:53.599392397 +0200
> +++ b/arch/arm/boot/dts/exynos5440.dtsi	2013-08-02 14:46:29.815391842 +0200
> @@ -29,6 +29,23 @@
>  		#clock-cells = <1>;
>  	};
>  
> +	power-domains@00160000 {
> +		compatible = "samsung,exynos5440-power-domains", "simple-bus";
> +		reg = <0x00160000 0x1000>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		pd_pcie: pcie-power-domain@6 {
> +			compatible = "samsung,exynos5440-pd";
> +			reg = <6>;
> +		};
> +
> +		pd_conn2: conn2-power-domain@7 {
> +			compatible = "samsung,exynos5440-pd";
> +			reg = <7>;
> +		};
> +	};
> +
>  	gic:interrupt-controller@2E0000 {
>  		compatible = "arm,cortex-a15-gic";
>  		#interrupt-cells = <3>;
> @@ -192,6 +209,7 @@
>  		phy-mode = "sgmii";
>  		clocks = <&clock 25>;
>  		clock-names = "stmmaceth";
> +		samsung,power-domain = <&pd_conn2>;
>  	};
>  
>  	amba {
> @@ -240,6 +258,7 @@
>  		interrupts = <0 30 0>;
>  		clocks = <&clock 23>;
>  		clock-names = "sata";
> +		samsung,power-domain = <&pd_conn2>;
>  	};
>  
>  	ohci@220000 {
> @@ -248,6 +267,7 @@
>  		interrupts = <0 29 0>;
>  		clocks = <&clock 24>;
>  		clock-names = "usbhost";
> +		samsung,power-domain = <&pd_conn2>;
>  	};
>  
>  	ehci@221000 {
> @@ -256,6 +276,7 @@
>  		interrupts = <0 29 0>;
>  		clocks = <&clock 24>;
>  		clock-names = "usbhost";
> +		samsung,power-domain = <&pd_conn2>;
>  	};
>  
>  	pcie@290000 {
> @@ -275,6 +296,7 @@
>  		#interrupt-cells = <1>;
>  		interrupt-map-mask = <0 0 0 0>;
>  		interrupt-map = <0x0 0 &gic 53>;
> +		samsung,power-domain = <&pd_pcie>;
>  	};
>  
>  	pcie@2a0000 {
> @@ -294,5 +316,6 @@
>  		#interrupt-cells = <1>;
>  		interrupt-map-mask = <0 0 0 0>;
>  		interrupt-map = <0x0 0 &gic 56>;
> +		samsung,power-domain = <&pd_pcie>;
>  	};
>  };
