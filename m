From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH/RFC 0/2] regulator: bd9571mwv: Add support for toggle power switches
Date: Wed, 14 Mar 2018 12:26:23 +0100
Message-ID: <1521026785-26456-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Marek Vasut <marek.vasut+renesas@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-pm@vger.kernel.org

	Hi all,

The ROHM BD9571MWV PMIC on the Renesas Salvator-X(S) and ULCB
development boards supports DDR Backup Power, which means that the DDR
power rails can be kept powered while the main SoC is powered down.

This patch series extends the support for DDR backup mode[1] to systems
with toggle instead of momentary power switches.

With a toggle power switch (or level signal), the following steps must
be followed exactly:
   1. Configure PMIC for backup mode, which changes the role of the
      power switch to a wake-up switch, 
   2. Switch accessory power switch off, to prepare for system suspend,
      which is a manual step not controlled by software,
   3. Suspend system,
   4. Switch accessory power switch on, to resume.

Unlike on systems with a momentary toggle switch, an additional step 2
must be performed in between step 1 and step 3.  Hence step 1 can no
longer be handled in the PMIC's suspend callback.

This patch series proposes a new callback for wake-up change
notification, which allows performing step 1 when the user writes
"enabled" to the PMIC's "wakeup" virtual file in sysfs, e.g.

    echo enabled > /sys/devices/platform/soc/e60b0000.i2c/i2c-7/7-0030/bd9571mwv-regulator.2.auto/power/wakeup

Conversely, writing "disabled" reverts the role of the accessory switch
to a power switch.
Note that unlike with momentary switches, backup mode is not enabled by
default, as enabling it prevents the board from being powered off using
the power switch, which may confuse the user.

This has been tested on M3ULCB (thanks Jacopo!), and on Salvator-X(S).

For testing, driver and DTS patches are available in the
topic/bd9571-ddr-backup-mode-driver-v2 and
topic/bd9571-ddr-backup-mode-dt-v2 branches of my renesas-drivers git
repository at
git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git.

Thanks for your comments!

[1] https://lkml.org/lkml/2018/3/14/302

Geert Uytterhoeven (2):
  PM / wakeup: Add callback for wake-up change notification
  regulator: bd9571mwv: Add support for toggle power switches

 drivers/base/power/wakeup.c             |  4 ++++
 drivers/regulator/bd9571mwv-regulator.c | 24 ++++++++++++++++++++++++
 include/linux/pm.h                      |  1 +
 3 files changed, 29 insertions(+)

-- 
2.7.4

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
