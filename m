From: Baruch Siach <baruch@tkos.co.il>
Subject: Re: [PATCH v2 14/23] dt-bindings: cp110: prepare the syscon file to
 list other syscons nodes
Date: Tue, 26 Jun 2018 06:35:56 +0300
Message-ID: <20180626033556.bsub25ykdseflsta@tarshish>
References: <20180625151239.20976-1-miquel.raynal@bootlin.com>
 <20180625151239.20976-15-miquel.raynal@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20180625151239.20976-15-miquel.raynal@bootlin.com>
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
Cc: Mark Rutland <mark.rutland@arm.com>, Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, Nadav Haklai <nadavh@marvell.com>, devicetree@vger.kernel.org, Antoine Tenart <antoine.tenart@bootlin.com>, Catalin Marinas <catalin.marinas@arm.com>, Gregory Clement <gregory.clement@bootlin.com>, linux-pm@vger.kernel.org, Will Deacon <will.deacon@arm.com>, Rob Herring <robh+dt@kernel.org>, Maxime Chevallier <maxime.chevallier@bootlin.com>, Eduardo Valentin <edubezval@gmail.com>, David Sniatkiwicz <davidsn@marvell.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Zhang Rui <rui.zhang@intel.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: linux-pm@vger.kernel.org

Hi Miquel,

On Mon, Jun 25, 2018 at 05:12:30PM +0200, Miquel Raynal wrote:
> There are multiple system controllers in CP110. Because all syscon nodes
> use the same compatible, it is pertinent to use this same file to list
> IPs inside it. Thus, change the header to be more generic, and align
> with AP806 file.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

This patch and the file rename in patch #12 should be squashed together, I 
think.

baruch

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

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
