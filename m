From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH 08/15] power: improve function-level documentation
Date: Sat,  1 Oct 2016 21:46:25 +0200
Message-ID: <1475351192-27079-9-git-send-email-Julia.Lawall@lip6.fr>
References: <1475351192-27079-1-git-send-email-Julia.Lawall@lip6.fr>
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <1475351192-27079-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: kernel-janitors-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: kernel-janitors@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

In drivers/power/supply/ab8500_fg.c, fix two typos and adjust the function
name in two cases to correspond to the names of the defined functions.

In drivers/power/supply/power_supply_core.c, change two variable names to
the names of the corresponding parameters.

Issue detected using Coccinelle (http://coccinelle.lip6.fr/)

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/power/supply/ab8500_fg.c         |    8 ++++----
 drivers/power/supply/power_supply_core.c |    4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/power/supply/ab8500_fg.c b/drivers/power/supply/ab8500_fg.c
index 2199f67..c569f82 100644
--- a/drivers/power/supply/ab8500_fg.c
+++ b/drivers/power/supply/ab8500_fg.c
@@ -1900,7 +1900,7 @@ static void ab8500_fg_low_bat_work(struct work_struct *work)
  * ab8500_fg_battok_calc - calculate the bit pattern corresponding
  * to the target voltage.
  * @di:       pointer to the ab8500_fg structure
- * @target    target voltage
+ * @target:   target voltage
  *
  * Returns bit pattern closest to the target voltage
  * valid return values are 0-14. (0-BATT_OK_MAX_NR_INCREMENTS)
@@ -2391,7 +2391,7 @@ static void ab8500_fg_external_power_changed(struct power_supply *psy)
 }
 
 /**
- * abab8500_fg_reinit_work() - work to reset the FG algorithm
+ * ab8500_fg_reinit_work() - work to reset the FG algorithm
  * @work:	pointer to the work_struct structure
  *
  * Used to reset the current battery capacity to be able to
@@ -2528,7 +2528,7 @@ static ssize_t charge_now_store(struct ab8500_fg *di, const char *buf,
 };
 
 /**
- * ab8500_chargalg_sysfs_exit() - de-init of sysfs entry
+ * ab8500_fg_sysfs_exit() - de-init of sysfs entry
  * @di:                pointer to the struct ab8500_chargalg
  *
  * This function removes the entry in sysfs.
@@ -2539,7 +2539,7 @@ static void ab8500_fg_sysfs_exit(struct ab8500_fg *di)
 }
 
 /**
- * ab8500_chargalg_sysfs_init() - init of sysfs entry
+ * ab8500_fg_sysfs_init() - init of sysfs entry
  * @di:                pointer to the struct ab8500_chargalg
  *
  * This function adds an entry in sysfs.
diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index a74d8ca..1e0960b 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -413,7 +413,7 @@ static int power_supply_match_device_node(struct device *dev, const void *data)
 /**
  * power_supply_get_by_phandle() - Search for a power supply and returns its ref
  * @np: Pointer to device node holding phandle property
- * @phandle_name: Name of property holding a power supply name
+ * @property: Name of property holding a power supply name
  *
  * If power supply was found, it increases reference count for the
  * internal power supply's device. The user should power_supply_put()
@@ -458,7 +458,7 @@ static void devm_power_supply_put(struct device *dev, void *res)
  * devm_power_supply_get_by_phandle() - Resource managed version of
  *  power_supply_get_by_phandle()
  * @dev: Pointer to device holding phandle property
- * @phandle_name: Name of property holding a power supply phandle
+ * @property: Name of property holding a power supply phandle
  *
  * Return: On success returns a reference to a power supply with
  * matching name equals to value under @property, NULL or ERR_PTR otherwise.

