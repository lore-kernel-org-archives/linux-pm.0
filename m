From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 0/6] ARM: shmobile: sh73a0: DT PM domain support
Date: Wed, 14 Jan 2015 13:11:18 +0100
Message-ID: <1421237484-16847-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from laurent.telenet-ops.be ([195.130.137.89]:37242 "EHLO
	laurent.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751706AbbANMLc (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 14 Jan 2015 07:11:32 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

	Hi Simon, Magnus,

This patch series enables DT support for PM domains on the Renesas
SH-Mobile AG5 (sh73a0) SoC.

This series builds further on the DT PM Domain support for R-Mobile A1
(r8a7740).  Due to the similarity of the SYSC System-Controller on the
various SH-Mobile/R-Mobile SoCs, and the abstraction of PM domains in
DT, the same driver can handle sh73a0 after some small modifications,
without changing the DT bindings.

Compared to r8a7740, the only significant change is the move of the
memory-controller(s) to separate PM domains on sh73a0 (and also on
R-Mobile APE6 (r8a73a4)). Hence a provision must be made to not turn off
these PM domains inadvertently, cfr. the series "[PATCH 0/4] ARM:
shmobile: Add DT support for memory controllers" I've just sent.

This series has been sent before, as part of the series "[PATCH RFC
0/7] ARM: shmobile: sh73a0: DT PM domain support"
(https://lkml.org/lkml/2014/11/19/404).
Changes since v1 (more detailed changelogs in the individual patches):
  - Factored out addition of the memory-controller in a separate
    series.

Dependencies:
  1. Patches 1-4 (DT binding doc, C code) depend on:
       a. The R-Mobile DT PM Domain work for r8a7740, queued in tag
          renesas-dt-pm-for-v3.20 of Simon's repository,
       b. "ARM: shmobile: R-Mobile: Fix DT refcount bugs in PM domain
	   code"
	   (http://www.spinics.net/lists/arm-kernel/msg391084.html),
  2. Patch 5 (dtsi) depends on:
       a. The multiplatform work for sh73a0, queued in branch
          sh73a0-multiplatform-for-v3.20 of Simon's repository,
       b. Series "[PATCH 0/4] ARM: shmobile: Add DT support for memory
          controllers"
	  (http://marc.info/?l=linux-sh&m=142123399414888).
  3. Patch 6 (drivers/sh) depends on all of the above.

This was tested on kzm9g-multiplatform.

Thanks!

Geert Uytterhoeven (6):
  PM / Domains: R-Mobile SYSC: Document SH-Mobile AG5 (sh73a0) binding
  ARM: shmobile: R-Mobile: Consolidate rmobile_pd_suspend_*()
  ARM: shmobile: R-Mobile: Generalize adding/looking up special PM
    domains
  ARM: shmobile: R-Mobile: Special-case PM domains with
    memory-controllers
  ARM: shmobile: sh73a0 dtsi: Add PM domain support
  drivers: sh: Disable PM runtime for multi-platform sh73a0 with genpd

 .../bindings/power/renesas,sysc-rmobile.txt        |   1 +
 arch/arm/boot/dts/sh73a0.dtsi                      | 144 ++++++++++++++++++-
 arch/arm/mach-shmobile/pm-rmobile.c                | 155 +++++++++++++--------
 drivers/sh/pm_runtime.c                            |   4 +-
 4 files changed, 242 insertions(+), 62 deletions(-)

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
