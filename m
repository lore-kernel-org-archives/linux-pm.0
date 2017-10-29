From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 0/3] power: supply: minor improvements to sbs-manager and battery
Date: Sun, 29 Oct 2017 16:35:42 +0100
Message-ID: <20171029153545.3947-1-wsa@the-dreams.de>
Return-path: <linux-i2c-owner@vger.kernel.org>
Sender: linux-i2c-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-pm@vger.kernel.org, Phil Reid <preid@electromag.com.au>, sre@kernel.org, Wolfram Sang <wsa@the-dreams.de>
List-Id: linux-pm@vger.kernel.org

Here are three patches I came up with when doing the code review for Phil
Reid's V11 series for the sbs-manager. This code is not upstream yet but resides
in this branch (already with these patches applied):

git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/sbs-manager

Since Sebastian was super-fast in reviewing these patches, I will merge the
above branch pretty soon into i2c/for-next if nobody objects.

Thanks!


Wolfram Sang (3):
  power: supply: sbs-battery: remove superfluous variable init
  power: supply: sbs-battery: remove unchecked return var
  power: supply: sbs-message: fix some code style issues

 drivers/power/supply/sbs-battery.c | 12 ++++--------
 drivers/power/supply/sbs-manager.c |  7 ++++---
 2 files changed, 8 insertions(+), 11 deletions(-)

-- 
2.11.0
