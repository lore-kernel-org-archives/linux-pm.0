From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 0/2] PM / Domains: Infinite loop during reboot
Date: Thu, 18 Jun 2015 12:22:32 +0200
Message-ID: <1434622954-26747-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Magnus Damm <damm@opensource.se>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, linux-pm@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-pm@vger.kernel.org

	Hi all,

This patch series fixes an infinite loop during reboot after s2ram, as
seen on r8a7791/koelsch with the CPG Clock Domain:
  - Patch 1 fixes the cause in the sh_cmt driver,
  - Patch 2 hardens the PM Domain core code against infinite loops.

Both patches individually fix the symptom (lock up during reboot), but
only the first one fixes the root cause.
Patches are against next-20150618.

The discussion thread where the problem was originally reported is "PM /
Domains: Infinite loop during reboot"
(http://permalink.gmane.org/gmane.linux.ports.sh.devel/45249).

Thanks!

Geert Uytterhoeven (2):
  clocksource: sh_cmt: Only perform clocksource suspend/resume if
    enabled
  PM / Domains: Avoid infinite loops in attach/detach code

 drivers/base/power/domain.c  | 15 +++++++++++++--
 drivers/clocksource/sh_cmt.c |  6 ++++++
 2 files changed, 19 insertions(+), 2 deletions(-)

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
