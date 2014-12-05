From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 0/2] ARM: shmobile: R-mobile: Fix SYSC register lengths
Date: Fri, 5 Dec 2014 09:13:32 +0900
Message-ID: <20141205001332.GA8790@verge.net.au>
References: <1417696298-27740-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1417696298-27740-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-pm@vger.kernel.org, linux-sh@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thu, Dec 04, 2014 at 01:31:36PM +0100, Geert Uytterhoeven wrote:
> 	Hi Simon, Magnus,
> 
> This patch series fixes the register lengths of the SYSC device nodes, by
> adding the missing 0x prefixes. They were really intended to be 0x8000, not
> 8000.
> This doesn't cause any problems for now, but at least the second range
> is documented to cover the full 32 KiB on R-Mobile A1 (r8a7740).
> Sorry for not noticing before.
> 
> Perhaps these can still be folded into the commits that introduced the bugs?
>   - commit 0f3dad1d6c519ddf ("PM / Domains: Add DT bindings for the R-Mobile
>     System Controller"),
>   - commit 2f49e6f2721c4344 ("ARM: shmobile: r8a7740 dtsi: Add PM domain
>     support").
> 
> Thanks!
> 
> Geert Uytterhoeven (2):
>   PM / Domains: R-Mobile SYSC: Add missing 0x prefixes to example
>   ARM: shmobile: r8a7740 dtsi: Add missing 0x prefix to SYSC reg lengths
> 
>  Documentation/devicetree/bindings/power/renesas,sysc-rmobile.txt | 2 +-
>  arch/arm/boot/dts/r8a7740.dtsi                                   | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Thanks Geert,

I will squash these changes into the patches that added the problems.
