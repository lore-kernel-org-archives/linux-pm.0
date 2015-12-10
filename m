From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 09/19] PM / devfreq: exynos: Update documentation for
 bus devices using passive governor
Date: Thu, 10 Dec 2015 08:21:09 -0600
Message-ID: <20151210142109.GA32109@rob-hp-laptop>
References: <1449634091-1842-1-git-send-email-cw00.choi@samsung.com>
 <1449634091-1842-10-git-send-email-cw00.choi@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:50341 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752213AbbLJOVT (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 10 Dec 2015 09:21:19 -0500
Content-Disposition: inline
In-Reply-To: <1449634091-1842-10-git-send-email-cw00.choi@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>
Cc: myungjoo.ham@samsung.com, k.kozlowski@samsung.com, kgene@kernel.org, kyungmin.park@samsung.com, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, tjakobi@math.uni-bielefeld.de, linux.amoon@gmail.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org

On Wed, Dec 09, 2015 at 01:08:01PM +0900, Chanwoo Choi wrote:
> This patch updates the documentation for passive bus devices and adds the
> detailed example of Exynos3250.
> 
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
>  .../devicetree/bindings/devfreq/exynos-bus.txt     | 244 ++++++++++++++++++++-
>  1 file changed, 241 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/devfreq/exynos-bus.txt b/Documentation/devicetree/bindings/devfreq/exynos-bus.txt
> index 54a1f9c46c88..c4fdc70f8eac 100644
> --- a/Documentation/devicetree/bindings/devfreq/exynos-bus.txt
> +++ b/Documentation/devicetree/bindings/devfreq/exynos-bus.txt
> @@ -13,18 +13,23 @@ SoC has the different sub-blocks. So, this difference should be specified
>  in devicetree file instead of each device driver. In result, this driver
>  is able to support the bus frequency for all Exynos SoCs.
>  
> -Required properties for bus device:
> +Required properties for all bus devices:
>  - compatible: Should be "samsung,exynos-bus".
>  - clock-names : the name of clock used by the bus, "bus".
>  - clocks : phandles for clock specified in "clock-names" property.
>  - #clock-cells: should be 1.
>  - operating-points-v2: the OPP table including frequency/voltage information
>    to support DVFS (Dynamic Voltage/Frequency Scaling) feature.
> +
> +Required properties for only parent bus device:
>  - vdd-supply: the regulator to provide the buses with the voltage.
>  - devfreq-events: the devfreq-event device to monitor the curret utilization
>    of buses.
>  
> -Optional properties for bus device:
> +Required properties for only passive bus device:
> +- devfreq: the parent bus device.
> +
> +Optional properties for only parent bus device:
>  - exynos,saturation-ratio: the percentage value which is used to calibrate
>                     the performance count againt total cycle count.
>  
> @@ -33,7 +38,20 @@ Example1:
>  	power line (regulator). The MIF (Memory Interface) AXI bus is used to
>  	transfer data between DRAM and CPU and uses the VDD_MIF regualtor.
>  
> -	- power line(VDD_MIF) --> bus for DMC (Dynamic Memory Controller) block
> +	- MIF (Memory Interface) block
> +	: VDD_MIF |--- DMC (Dynamic Memory Controller)
> +
> +	- INT (Internal) block
> +	: VDD_INT |--- LEFTBUS (parent device)
> +		  |--- PERIL
> +		  |--- MFC
> +		  |--- G3D
> +		  |--- RIGHTBUS
> +		  |--- FSYS
> +		  |--- LCD0
> +		  |--- PERIR
> +		  |--- ISP
> +		  |--- CAM

This still has the same problem as before. I would expect that the bus 
hierarchy in the dts match the hierarchy here. You just have flat nodes 
in the example below. So all IP blocks affected by frequency scaling 
should be under the bus node defining the OPPs. Something like this:

soc {
	compatible = "simple-bus";
	bus {
		compatible = "my-awesome-dvfs-bus"; /* simple-bus too if 
no setup needed first */
		reg = <0x0 0x0>; // Bus control registers
		clocks = <&ccm BUS_CLK>;
		operating-points-v2 = <&opp>;
		device@0 {
			compatible = "my-awesome-device-1";
		};
		device@1 {
			compatible = "my-awesome-device-2";
		};
	};
};
