From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH RFC 1/3] thermal: allow hwmon devices to be created for
 of-thermal zones
Date: Mon, 20 Mar 2017 12:15:52 -0500
Message-ID: <20170320171552.o2ye73c2okcvhluq@rob-hp-laptop>
References: <E1cn8qC-0002uz-PB@rmk-PC.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <E1cn8qC-0002uz-PB@rmk-PC.armlinux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King <rmk+kernel@armlinux.org.uk>
Cc: Mark Rutland <mark.rutland@arm.com>, Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, linux-pm@vger.kernel.org, Eduardo Valentin <edubezval@gmail.com>, devicetree@vger.kernel.org, Gregory Clement <gregory.clement@free-electrons.com>, Zhang Rui <rui.zhang@intel.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Sun, Mar 12, 2017 at 07:07:40PM +0000, Russell King wrote:
> Allow hwmon devices to be optionally created for of-thermal zones,
> rather than permanently denying them "in case" there is a hwmon
> driver duplicating the thermal driver.
> 
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> ---
> Without this, "sensors" is unable to report the temperature of the
> Dove SoC when it supports thermal zones.
> 
>  Documentation/devicetree/bindings/thermal/thermal.txt | 3 +++
>  arch/arm/boot/dts/dove.dtsi                           | 1 +
>  drivers/thermal/of-thermal.c                          | 3 ++-
>  3 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/thermal.txt b/Documentation/devicetree/bindings/thermal/thermal.txt
> index 88b6ea1ad290..1478735fff85 100644
> --- a/Documentation/devicetree/bindings/thermal/thermal.txt
> +++ b/Documentation/devicetree/bindings/thermal/thermal.txt
> @@ -175,6 +175,9 @@ containing trip nodes and one sub-node containing all the zone cooling maps.
>  			2000mW, while on a 10'' tablet is around
>  			4500mW.
>  
> +- linux,hwmon:		Allow Linux to create hwmon devices for the thermal
> +  Type: bool		zone.
> +
>  Note: The delay properties are bound to the maximum dT/dt (temperature
>  derivative over time) in two situations for a thermal zone:
>  (i)  - when passive cooling is activated (polling-delay-passive); and
> diff --git a/arch/arm/boot/dts/dove.dtsi b/arch/arm/boot/dts/dove.dtsi
> index 40fb98687230..00f5971cd039 100644
> --- a/arch/arm/boot/dts/dove.dtsi
> +++ b/arch/arm/boot/dts/dove.dtsi
> @@ -804,6 +804,7 @@
>  
>  	thermal-zones {
>  		soc-thermal {
> +			linux,hwmon;

I'd prefer to see a black or white list of sensor compatibles here. Then 
the dtb doesn't need to change if things move between hwmon and thermal 
zones.

Rob
