From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 0/4] thermal: rcar: Add missing clock handling
Date: Tue,  7 Jan 2014 19:57:12 +0100
Message-ID: <1389121036-3555-1-git-send-email-geert@linux-m68k.org>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: linux-sh@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

    Hi all,

This patch series fixes a problem when the thermal-rcar device is
instantiated from the device tree on the r8a7791-based Koelsch development
board. The driver fails during initialization with:

    rcar_thermal e61f0000.thermal: thermal sensor was broken

This does not happen when using legacy platform devices.

This series was tested using Koelsch reference (DT) and non-reference
(legacy) kernel configurations. It was not tested on r8a7790/Lager
(which is very similar).

    [1/4] ARM: shmobile: r8a7791: Add thermal clock in device tree
    [2/4] ARM: shmobile: r8a7790: Add thermal clock in device tree
    [3/4] thermal: rcar: Add missing clock handling
    [4/4] thermal: rcar: Spelling s/delaye/delay/g

Thanks for your comments!

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
