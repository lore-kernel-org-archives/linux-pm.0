From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: [PATCH 0/2] sbs-battery: Add missing power class sysfs files
Date: Mon,  4 Aug 2014 13:47:44 +0200
Message-ID: <1407152866-31790-1-git-send-email-javier.martinez@collabora.co.uk>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Doug Anderson <dianders@chromium.org>, Olof Johansson <olof@lixom.net>, Simon Que <sque@chromium.org>, cychiang <cychiang@chromium.org>, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Javier Martinez Canillas <javier.martinez@collabora.co.uk>
List-Id: linux-pm@vger.kernel.org

This series add the model_name, manufacturer and voltage_min_design
files from the power supply monitor class sysfs interface that were
missing for the sbs-battery driver. The commits were taken from the
Chrome OS 3.8 downstream kernel and patches were squashed when they
just fixed bugs introduced on previous commits that do the export.

The patch-set was tested on a Exynos5420 based Peach Pit machine by
confirming that the sysfs files existed and provide the right data:

# cat /sys/class/power_supply/sbs-20-000b/{voltage_min_design,manufacturer,model_name}
7500000
SANYO
4302A40

Simon Que (1):
  sbs-battery: add min design voltage to sbs-battery

cychiang (1):
  sbs-battery: export manufacturer and model name to sysfs

 drivers/power/sbs-battery.c | 125 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 123 insertions(+), 2 deletions(-)

Best regards,
Javier
