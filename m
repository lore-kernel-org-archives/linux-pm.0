From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v2 1/2] dt-bindings: thermal: rcar: Add device tree
 support for r8a7743
Date: Wed, 20 Dec 2017 09:27:20 +0100
Message-ID: <20171220082720.7wmxidiyfzgr5pck@verge.net.au>
References: <1513689449-2700-1-git-send-email-biju.das@bp.renesas.com>
 <1513689449-2700-2-git-send-email-biju.das@bp.renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1513689449-2700-2-git-send-email-biju.das@bp.renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Biju Das <biju.das@bp.renesas.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Magnus Damm <magnus.damm@gmail.com>, Chris Paterson <chris.paterson2@renesas.com>, Fabrizio Castro <fabrizio.castro@bp.renesas.com>, devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, Dec 19, 2017 at 01:17:28PM +0000, Biju Das wrote:
> Add thermal sensor support for r8a7743 SoC. The Renesas RZ/G1M
> (r8a7743) thermal sensor module is identical to the R-Car Gen2 family.
> 
> No driver change is needed due to the fallback compatible value
> "renesas,rcar-gen2-thermal".
> 
> Signed-off-by: Biju Das <biju.das@bp.renesas.com>
> Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Rob Herring <robh@kernel.org>

Reviewed-by: Simon Horman <simon.horman@netronome.com>

> ---
> v1->v2
>   * No Change
> 
>  Documentation/devicetree/bindings/thermal/rcar-thermal.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/rcar-thermal.txt b/Documentation/devicetree/bindings/thermal/rcar-thermal.txt
> index a8e52c8..349e635 100644
> --- a/Documentation/devicetree/bindings/thermal/rcar-thermal.txt
> +++ b/Documentation/devicetree/bindings/thermal/rcar-thermal.txt
> @@ -6,6 +6,7 @@ Required properties:
>  			   "renesas,rcar-thermal" (without thermal-zone) as fallback.
>  			  Examples with soctypes are:
>  			    - "renesas,thermal-r8a73a4" (R-Mobile APE6)
> +			    - "renesas,thermal-r8a7743" (RZ/G1M)
>  			    - "renesas,thermal-r8a7779" (R-Car H1)
>  			    - "renesas,thermal-r8a7790" (R-Car H2)
>  			    - "renesas,thermal-r8a7791" (R-Car M2-W)
> -- 
> 1.9.1
> 
