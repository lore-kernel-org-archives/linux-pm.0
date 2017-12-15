From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: thermal: rcar: Add device tree support
 for r8a7743
Date: Fri, 15 Dec 2017 17:06:28 -0600
Message-ID: <20171215230628.5is2s7orogu46cqd@rob-hp-laptop>
References: <1513162673-31531-1-git-send-email-biju.das@bp.renesas.com>
 <1513162673-31531-2-git-send-email-biju.das@bp.renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1513162673-31531-2-git-send-email-biju.das@bp.renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Biju Das <biju.das@bp.renesas.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Chris Paterson <chris.paterson2@renesas.com>, devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, Dec 13, 2017 at 10:57:52AM +0000, Biju Das wrote:
> Add thermal sensor support for r8a7743 SoC. The Renesas RZ/G1M
> (r8a7743) thermal sensor module is identical to the R-Car Gen2 family.
> 
> No driver change is needed due to the fallback compatible value
> "renesas,rcar-gen2-thermal".
> 
> Signed-off-by: Biju Das <biju.das@bp.renesas.com>
> Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> ---
>  Documentation/devicetree/bindings/thermal/rcar-thermal.txt | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Rob Herring <robh@kernel.org>
