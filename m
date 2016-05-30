From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCHv3 08/48] thermal: core: improve power actor documentation
Date: Mon, 30 May 2016 15:15:44 -0700
Message-ID: <1464646584-14322-9-git-send-email-edubezval@gmail.com>
References: <1464646584-14322-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1464646584-14322-1-git-send-email-edubezval@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-pm@vger.kernel.org

Simple improvement on clarity and removal of checkpatch warning
in the documentation of power actor kernel doc.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
 drivers/thermal/thermal_core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 3cbb208..12427cc 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1142,12 +1142,13 @@ int power_actor_get_min_power(struct thermal_cooling_device *cdev,
 }
 
 /**
- * power_actor_set_power() - limit the maximum power that a cooling device can consume
+ * power_actor_set_power() - limit the maximum power a cooling device consumes
  * @cdev:	pointer to &thermal_cooling_device
  * @instance:	thermal instance to update
  * @power:	the power in milliwatts
  *
- * Set the cooling device to consume at most @power milliwatts.
+ * Set the cooling device to consume at most @power milliwatts. The limit is
+ * expected to be a cap at the maximum power consumption.
  *
  * Return: 0 on success, -EINVAL if the cooling device does not
  * implement the power actor API or -E* for other failures.
-- 
2.1.4
