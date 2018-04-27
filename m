From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 16/27] dt-bindings: cp110: prepare the syscon file to
 list other syscons nodes
Date: Fri, 27 Apr 2018 16:06:03 -0500
Message-ID: <20180427210603.fkcuxnug3rgq3wjl@rob-hp-laptop>
References: <20180421151255.29929-1-miquel.raynal@bootlin.com>
 <20180421151255.29929-17-miquel.raynal@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20180421151255.29929-17-miquel.raynal@bootlin.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, Nadav Haklai <nadavh@marvell.com>, devicetree@vger.kernel.org, Antoine Tenart <antoine.tenart@bootlin.com>, Catalin Marinas <catalin.marinas@arm.com>, Gregory Clement <gregory.clement@bootlin.com>, linux-pm@vger.kernel.org, Will Deacon <will.deacon@arm.com>, Maxime Chevallier <maxime.chevallier@bootlin.com>, Eduardo Valentin <edubezval@gmail.com>, David Sniatkiwicz <davidsn@marvell.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Zhang Rui <rui.zhang@intel.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Sat, Apr 21, 2018 at 05:12:44PM +0200, Miquel Raynal wrote:
> There are multiple system controllers in CP110. Because all syscon nodes
> use the same compatible, it is pertinent to use this same file to list
> IPs inside it. Thus, change the header to be more generic, and align
> with AP806 file.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  .../bindings/arm/marvell/cp110-system-controller.txt       | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/marvell/cp110-system-controller.txt b/Documentation/devicetree/bindings/arm/marvell/cp110-system-controller.txt
> index 29cdbae6c5ac..56e7fb1153e7 100644
> --- a/Documentation/devicetree/bindings/arm/marvell/cp110-system-controller.txt
> +++ b/Documentation/devicetree/bindings/arm/marvell/cp110-system-controller.txt
> @@ -1,15 +1,15 @@
> -Marvell Armada CP110 System Controller 0
> -========================================
> +Marvell Armada CP110 System Controller
> +======================================
>  
>  The CP110 is one of the two core HW blocks of the Marvell Armada 7K/8K
> -SoCs. It contains two sets of system control registers, System
> -Controller 0 and System Controller 1. This Device Tree binding allows
> -to describe the first system controller, which provides registers to
> -configure various aspects of the SoC.
> +SoCs. It contains system controllers, which provide several registers

Is this really multiple discrete blocks?

> +giving access to numerous features: clocks, pin-muxing and many other
> +SoC configuration items. This DT binding allows to describe these
> +system controllers.
>  
>  For the top level node:
>   - compatible: must be: "syscon", "simple-mfd";
> - - reg: register area of the CP110 system controller 0
> + - reg: register area of the CP110 system controller
>  
>  Clocks:
>  -------
> -- 
> 2.14.1
> 
