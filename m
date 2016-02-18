From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH/RFC v2 01/11] PM / Domains: Add DT bindings for the R-Car
 System Controller
Date: Thu, 18 Feb 2016 08:38:26 -0600
Message-ID: <20160218143826.GB9654@rob-hp-laptop>
References: <1455571020-18968-1-git-send-email-geert+renesas@glider.be>
 <1455571020-18968-2-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1455571020-18968-2-git-send-email-geert+renesas@glider.be>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon, Feb 15, 2016 at 10:16:50PM +0100, Geert Uytterhoeven wrote:
> The Renesas R-Car System Controller provides power management for the
> CPU cores and various coprocessors, following the generic PM domain
> bindings in Documentation/devicetree/bindings/power/power_domain.txt.
> 
> This supports R-Car Gen1, Gen2, and Gen3.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Alternatives I considered:
> 
>   - Using a single node per power register block, even if it contains
>     multiple domains, e.g.:
> 
> 	    pd_ca15_scu: ca15_scu@180 {
> 		    reg = <0x180 0x20>;
> 		    #address-cells = <1>;
> 		    #size-cells = <0>;
> 		    #power-domain-cells = <0>;
> 		    renesas,interrupt-bits = <12>;
> 
> 		    pd_ca15_cpu: ca15_cpu@40 {
> 			    reg = <0x40 0x20>;
> 			    #power-domain-cells = <1>;
> 			    renesas,pm-domain-indices = <0 1>;
> 			    renesas,pm-domain-names =
> 				    "ca15_cpu0", "ca15_cpu1";
> 			    renesas,interrupt-bits = <0 1>;
> 		    };
> 	    };
> 
>     Notes:
>       - You cannot just have a property with the number of domains, as
> 	index 0 is not used on R-Car H1. Hence the need for
> 	"renesas,pm-domain-indices" and "renesas,interrupt-bits",
>       - "#power-domain-cells = <1>" for nodes with multiple domains,
> 	which allows typos in "power-domains = <&pd_ca15_cpu n>", using
> 	an invalid value of "n".
> 
>   - Using a linear description in DT:
>       - Needs parent links for subdomains,
>       - More complicated to parse (lesson learned from R-Mobile PM
> 	Domain support).
> 
>   - Keeping the power register block offset and the bit number as separate
>     "reg" cells, increasing "#address-cells" from 2 to 3,
> 
>   - Merging the interrupt bit (which needs only 5 bits) in the other "reg"
>     cell, decreasing "#address-cells" from 2 to 1.

I think I'd move to not encoding mulitple things into reg. This seems 
like a bit of abuse of reg. Otherwise, I don't have much to comment on.

Rob
