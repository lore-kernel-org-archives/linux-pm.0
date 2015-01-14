From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v2 0/6] ARM: shmobile: sh73a0: DT PM domain support
Date: Thu, 15 Jan 2015 08:53:03 +0900
Message-ID: <20150114235302.GC10479@verge.net.au>
References: <1421237484-16847-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1421237484-16847-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Geert,

On Wed, Jan 14, 2015 at 01:11:18PM +0100, Geert Uytterhoeven wrote:
> 	Hi Simon, Magnus,
> 
> This patch series enables DT support for PM domains on the Renesas
> SH-Mobile AG5 (sh73a0) SoC.
> 
> This series builds further on the DT PM Domain support for R-Mobile A1
> (r8a7740).  Due to the similarity of the SYSC System-Controller on the
> various SH-Mobile/R-Mobile SoCs, and the abstraction of PM domains in
> DT, the same driver can handle sh73a0 after some small modifications,
> without changing the DT bindings.
> 
> Compared to r8a7740, the only significant change is the move of the
> memory-controller(s) to separate PM domains on sh73a0 (and also on
> R-Mobile APE6 (r8a73a4)). Hence a provision must be made to not turn off
> these PM domains inadvertently, cfr. the series "[PATCH 0/4] ARM:
> shmobile: Add DT support for memory controllers" I've just sent.
> 
> This series has been sent before, as part of the series "[PATCH RFC
> 0/7] ARM: shmobile: sh73a0: DT PM domain support"
> (https://lkml.org/lkml/2014/11/19/404).
> Changes since v1 (more detailed changelogs in the individual patches):
>   - Factored out addition of the memory-controller in a separate
>     series.
> 
> Dependencies:
>   1. Patches 1-4 (DT binding doc, C code) depend on:
>        a. The R-Mobile DT PM Domain work for r8a7740, queued in tag
>           renesas-dt-pm-for-v3.20 of Simon's repository,

In response to a request from Olof renesas-dt-pm-for-v3.20 has been
withdrawn and the patches split between the soc-for-v3.20 and dt-for-v3.20
branches. I am assuming that the patches that 1-4 depend on are
now all in the soc-for-v3.20 branch. Could you check?

>        b. "ARM: shmobile: R-Mobile: Fix DT refcount bugs in PM domain
> 	   code"
> 	   (http://www.spinics.net/lists/arm-kernel/msg391084.html),

FWIW, I have squashed that patch into the patch that adds the problem
and the result is in the soc-for-v3.20. I will to push that result
a little later today.

>   2. Patch 5 (dtsi) depends on:
>        a. The multiplatform work for sh73a0, queued in branch
>           sh73a0-multiplatform-for-v3.20 of Simon's repository,
>        b. Series "[PATCH 0/4] ARM: shmobile: Add DT support for memory
>           controllers"
> 	  (http://marc.info/?l=linux-sh&m=142123399414888).

This may be awkward to get into v3.20 unless we can adopt a looser approach
to the dependencies.

To that end I suggest that it could be queued up in the branch that has the
multiplatform work (a) but not the memory controller work (b) as the latter
seems to more naturally fit into the dt branch. What I am hoping that such
an approach would lead to code that compiles and boots in both branches.
And that new functionality becomes available when the branched are combined
(e.g. in v3.20-rcX).

If this is not possible then I can merge the pre-requisites and put
patch 5 on top. But I feel that the ARM SoC maintainers would prefer
that I didn't do that unless it is absolutely necessary.

In case you are wondering: branch gymnastics are not my favourite pass time :^)

>   3. Patch 6 (drivers/sh) depends on all of the above.

That part is clear enough :)

My intention here is to send a pull request to Linus for this change
once all the other patches have hit his tree. With a bit of luck that
would be around v3.20-rc2.

> This was tested on kzm9g-multiplatform.
> 
> Thanks!
> 
> Geert Uytterhoeven (6):
>   PM / Domains: R-Mobile SYSC: Document SH-Mobile AG5 (sh73a0) binding
>   ARM: shmobile: R-Mobile: Consolidate rmobile_pd_suspend_*()
>   ARM: shmobile: R-Mobile: Generalize adding/looking up special PM
>     domains
>   ARM: shmobile: R-Mobile: Special-case PM domains with
>     memory-controllers
>   ARM: shmobile: sh73a0 dtsi: Add PM domain support
>   drivers: sh: Disable PM runtime for multi-platform sh73a0 with genpd
> 
>  .../bindings/power/renesas,sysc-rmobile.txt        |   1 +

>  arch/arm/boot/dts/sh73a0.dtsi                      | 144 ++++++++++++++++++-
>  arch/arm/mach-shmobile/pm-rmobile.c                | 155 +++++++++++++--------
>  drivers/sh/pm_runtime.c                            |   4 +-
>  4 files changed, 242 insertions(+), 62 deletions(-)
> 
> -- 
> 1.9.1
> 
> Gr{oetje,eeting}s,
> 
> 						Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
> 							    -- Linus Torvalds
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
