From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 0/3] thermal: Fix workqueue-related issues in drivers
Date: Thu, 27 Sep 2018 13:32:32 +0200
Message-ID: <20180927113235.30354-1-geert+renesas@glider.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Support Opensource <support.opensource@diasemi.com>, Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Arjan van de Ven <arjan@linux.intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-pm@vger.kernel.org

	Hi,

This patch series fixes workqueue-related issues in the Renesas R-Car
Thermal and Dialog DA9062/9061 PMIC drivers, where the workqueue may run
while the device is suspended, or unbound.
The R-Car Thermal driver fixes have been tested on R-Car M2-W and R-Mobile
APE6.
The DA9062/9061 fixes have been compile-tested only.

Note: The Intel PowerClamp driver also uses schedule_delayed_work(), but I
believe that is OK, as the thermal registers are part of the CPU.

Thanks!

Geert Uytterhoeven (3):
  thermal: rcar_thermal: Prevent hardware access during system suspend
  thermal: rcar_thermal: Prevent doing work after unbind
  thermal: da9062/61: Prevent hardware access during system suspend

 drivers/thermal/da9062-thermal.c | 4 ++--
 drivers/thermal/rcar_thermal.c   | 5 +++--
 2 files changed, 5 insertions(+), 4 deletions(-)

-- 
2.17.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
