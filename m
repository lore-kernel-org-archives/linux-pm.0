From: Rob Herring <robh@kernel.org>
Subject: Re: [RFC PATCH 09/15] PM / devfreq: exynos: Update documentation for
 bus devices using passive governor
Date: Mon, 30 Nov 2015 15:14:53 -0600
Message-ID: <20151130211453.GA29423@rob-hp-laptop>
References: <1448545659-32287-1-git-send-email-cw00.choi@samsung.com>
 <1448545659-32287-10-git-send-email-cw00.choi@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1448545659-32287-10-git-send-email-cw00.choi@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>
Cc: myungjoo.ham@samsung.com, kyungmin.park@samsung.com, kgene@kernel.org, k.kozlowski@samsung.com, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, tjakobi@math.uni-bielefeld.de, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thu, Nov 26, 2015 at 10:47:33PM +0900, Chanwoo Choi wrote:
> This patch updates the documentation for passive bus devices and adds the
> detailed example of Exynos3250.
> 
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
>  .../devicetree/bindings/devfreq/exynos-bus.txt     | 226 ++++++++++++++++++++-
>  1 file changed, 223 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/devfreq/exynos-bus.txt b/Documentation/devicetree/bindings/devfreq/exynos-bus.txt
> index 5d90623bd173..c4a6fe30075e 100644
> --- a/Documentation/devicetree/bindings/devfreq/exynos-bus.txt
> +++ b/Documentation/devicetree/bindings/devfreq/exynos-bus.txt
> @@ -12,18 +12,23 @@ SoC has the different sub-blocks. So, this difference should be specified
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
> @@ -32,7 +37,19 @@ Example1:
>  	power line (regulator). The MIF (Memory Interface) AXI bus is used to
>  	transfer data between DRAM and CPU and uses the VDD_MIF regualtor.
>  
> -	- power line(VDD_MIF) --> bus for DMC block (dmc clock)
> +	- MIF (Memory Interface) block
> +	: VDD_MIF |--- DMC
> +
> +	- INT (Internal) block
> +	: VDD_INT |--- LEFTBUS  |--- PERIL
> +		  |    (parent) |--- MFC
> +		  |             |--- G3D
> +		  |
> +		  |--- RIGHTBUS |--- FSYS
> +				|--- LCD0
> +				|--- PERIR
> +				|--- ISP
> +				|--- CAM

I would expect the DT to mirror this topology which doesn't seem to be 
the case in the example.


>  	- MIF bus's frequency/voltage table
>  	-----------------------
> @@ -45,6 +62,20 @@ Example1:
>  	|L5| 400000 |875000   |
>  	-----------------------
>  
> +	- INT bus's frequency/voltage table
> +	-----------------------------------------------------------------------
> +	|Lv| Freq                                                   | Voltage |
> +	-----------------------------------------------------------------------
> +	|  |LEFTBUS|RIGHTBUS|LCD0   |FSYS   |MCUISP |ISP    |PERIL  |VDD_INT  |
> +	|  |*parent|passive |passive|passive|passive|passive|passive|         |
> +	-----------------------------------------------------------------------
> +	|L1|50000  |50000   |50000  |50000  |50000  |50000  |50000  |900000   |
> +	|L2|80000  |80000   |80000  |80000  |80000  |80000  |80000  |900000   |
> +	|L3|100000 |100000  |100000 |100000 |100000 |100000 |100000 |1000000  |
> +	|L4|133000 |133000  |133000 |133000 |200000 |200000 |       |1000000  |
> +	|L5|200000 |200000  |200000 |200000 |400000 |300000 |       |1000000  |
> +	-----------------------------------------------------------------------

Do you really have 5 states? It look like there are 2 to me because the 
OPP tables only really need to have the max freq at each voltage point. 

Rob
