From: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH 0/3] ARM: shmobile: r8a73a4: DT PM domain support
Date: Wed,  4 Feb 2015 14:52:43 +0100
Message-ID: <1423057966-23321-1-git-send-email-geert+renesas@glider.be>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Simon Horman <horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

	Hi Simon, Magnus,

This patch series enables DT support for PM domains on the Renesas
R-Mobile APE6 (r8a73a4) SoC.

This series builds further upon the DT PM Domain support for R-Mobile
A1 (r8a7740) and SH-Mobile AG5 (sh73a0).  Due to the similarity of the
SYSC System-Controller on the various SH-Mobile/R-Mobile SoCs, and the
abstraction of PM domains in DT, the same driver can handle r8a73a4,
without any additional modifications, and without changing the DT
bindings.

Dependencies:
  1. Patch 1 (DT binding doc) depends on the R-Mobile DT PM Domain
     work for sh73a0, which depends on the multiplatform work for
     sh73a0, which is blocked on simple-pm-bus,
  2. Patch 2 (dtsi) depends on the multiplatform work for r8a73a4,
     which is blocked on simple-pm-bus,
  3. Patch 3 (drivers/sh) depends on all of the above.

This was tested on ape6evm-multiplatform.

Thanks for your comments!

Geert Uytterhoeven (3):
  PM / Domains: R-Mobile SYSC: Document R-Mobile APE6 (r8a73a4) binding
  ARM: shmobile: r8a73a4 dtsi: Add PM domain support
  drivers: sh: Disable PM runtime for multi-platform r8a73a4 with genpd

 .../bindings/power/renesas,sysc-rmobile.txt        |   1 +
 arch/arm/boot/dts/r8a73a4.dtsi                     | 177 +++++++++++++++++++++
 drivers/sh/pm_runtime.c                            |   2 +-
 3 files changed, 179 insertions(+), 1 deletion(-)

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
