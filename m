From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: thermal: Cleanup patches
Date: Mon,  6 Jul 2015 09:46:13 +0200
Message-ID: <1436168777-10463-1-git-send-email-s.hauer@pengutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, linux-kernel@vger.kernel.org, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-pm@vger.kernel.org

This series contains some cleanup patches for the thermal framework.
Some patches are already acked by Eduardo but not yet included in any
tree. Please review/apply.

Sascha

----------------------------------------------------------------
Sascha Hauer (4):
      thermal: trivial: fix typo in comment
      thermal: remove unnecessary call to thermal_zone_device_set_polling
      thermal: Use IS_ENABLED instead of #ifdef
      thermal: Add comment explaining test for critical temperature

 drivers/thermal/thermal_core.c | 55 +++++++++++++++++++-----------------------
 1 file changed, 25 insertions(+), 30 deletions(-)
