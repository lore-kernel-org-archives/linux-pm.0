From: Zhang Rui <rui.zhang@intel.com>
Subject: [GIT PULL] Thermal management updates for v4.10-rc6
Date: Fri, 27 Jan 2017 18:08:53 +0800
Message-ID: <1485511733.2469.39.camel@intel.com>
References: <1485489016.2469.36.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1485489016.2469.36.camel@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Guenter Roeck <linux@roeck-us.net>, Pavel Machek <pavel@ucw.cz>, Fabio Estevam <festevam@gmail.com>
List-Id: linux-pm@vger.kernel.org

Hi, Linus,

Please pull from
  git://git.kernel.org/pub/scm/linux/kernel/git/rzhang/linux.git for-rc

to receive the latest Thermal Management updates for v4.10-rc6 with
top-most commit 3feb479cea37fc623cf4e705631b2e679cbfbd7a:

  Revert "thermal: thermal_hwmon: Convert to
hwmon_device_register_with_info()" (2017-01-25 09:51:08 +0800)

on top of commit 883af14e67e8b8702b5560aa64c888c0cd0bd66c:

  Merge branch 'akpm' (patches from Andrew) (2017-01-24 16:54:39 -0800)

Specifics:

commit 7611fb68062f ("thermal: thermal_hwmon: Convert to
hwmon_device_register_with_info()"), which is introduced in 4.10-rc5,
uses new hwmon API. But this breaks some soc thermal driver because the
new hwmon API has a strict rule for the hwmon device name.
Revert the offending commit as a quick solution for 4.10.

thanks,
rui

----------------------------------------------------------------
Fabio Estevam (1):
      Revert "thermal: thermal_hwmon: Convert to
hwmon_device_register_with_info()"

 drivers/thermal/thermal_hwmon.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)
