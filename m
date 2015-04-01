From: Thomas Schlichter <thomas.schlichter@web.de>
Subject: [PATCH] fix sysfs showing the correct C-states after AC->DC and DC->AC transitions
Date: Wed, 01 Apr 2015 20:04:34 +0200
Message-ID: <3701793.GEjYLvWeTc@netbook>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="nextPart2818934.tJEj2j1ePN"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.17.12]:61454 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752779AbbDASEu (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 1 Apr 2015 14:04:50 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

This is a multi-part message in MIME format.

--nextPart2818934.tJEj2j1ePN
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hello,

I do have a Samsung NC20 netbook which provides the C-states C1 and C2 to the 
OS when connected to AC, and additionally provides the C3 C-state when 
disconnected from AC. With the current kernels I have these two problems 
(regressions):

1. The number of C-states shown in sysfs is fixed to the number of C-states
   present at boot.
   If I boot with AC connected, I always only see the C-states up to C2 even
   if I disconnect AC.

   The reason is commit 130a5f692425e6237229598a8624da0a247f33d5
   "ACPI / cpuidle: remove dev->state_count setting". It removes the update of
   dev->state_count, but sysfs uses exactly this variable to show the
   C-states.

   The fix is to use drv->state_count in sysfs. As this is currently the last
   user of dev->state_count, this variable can be completely removed. And this
   is exactly what Bartlomiej Zolnierkiewicz's not yet applied patch "[PATCH
   v2 9/9] cpuidle: remove state_count field from struct cpuidle_device"
   http://marc.info/?m=138756533317836 does.

   Long story short: That patch fixes problem 1 for me.

2. After a AC->DC or DC->AC transition, the name and description of the
   POLLING C-state become "<null>".

   Here, the reason is commit d7c7f103262bc2248548ed0e113e916e843c4eeb
   "cpuidle: don't call poll_idle_init() for every cpu". It only calls
   poll_idle_init() during cpuidle_register_driver() instead of
   cpuidle_enable_device() and thus does not re-initialize the fields of
   drv->states[0] after acpi_processor_setup_cpuidle_states() cleared them.

   Here, the fix is to _not_ clear drv->states[0] in
   acpi_processor_setup_cpuidle_states(). For this purpose I created a small
   patch.

For your convenience, both of the fixing patches are attached to this mail.
The first one is necessary for all kernels since 3.14, the second one for all
kernels since 3.13. So I'd propose to push both of them also to the necessary
stable kernels.

Kind regards,
  Thomas
--nextPart2818934.tJEj2j1ePN
Content-Disposition: inline; filename="0001-cpuidle-remove-state_count-field-from-struct-cpuidle.patch"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="0001-cpuidle-remove-state_count-field-from-struct-cpuidle.patch"

>From cce99e1975a03b15e374dcd42099448a22390c65 Mon Sep 17 00:00:00 2001
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Tue, 31 Mar 2015 20:15:09 +0200
Subject: [PATCH 1/2] cpuidle: remove state_count field from struct
 cpuidle_device

dev->state_count is now always equal to drv->state_count so
it can be removed.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/cpuidle/cpuidle.c | 3 ---
 drivers/cpuidle/sysfs.c   | 5 +++--
 include/linux/cpuidle.h   | 1 -
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index 080bd2d..7a73a27 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -330,9 +330,6 @@ int cpuidle_enable_device(struct cpuidle_device *dev)
 	if (!dev->registered)
 		return -EINVAL;
 
-	if (!dev->state_count)
-		dev->state_count = drv->state_count;
-
 	ret = cpuidle_add_device_sysfs(dev);
 	if (ret)
 		return ret;
diff --git a/drivers/cpuidle/sysfs.c b/drivers/cpuidle/sysfs.c
index 97c5903..832a2c3 100644
--- a/drivers/cpuidle/sysfs.c
+++ b/drivers/cpuidle/sysfs.c
@@ -401,7 +401,7 @@ static int cpuidle_add_state_sysfs(struct cpuidle_device *device)
 	struct cpuidle_driver *drv = cpuidle_get_cpu_driver(device);
 
 	/* state statistics */
-	for (i = 0; i < device->state_count; i++) {
+	for (i = 0; i < drv->state_count; i++) {
 		kobj = kzalloc(sizeof(struct cpuidle_state_kobj), GFP_KERNEL);
 		if (!kobj)
 			goto error_state;
@@ -433,9 +433,10 @@ error_state:
  */
 static void cpuidle_remove_state_sysfs(struct cpuidle_device *device)
 {
+	struct cpuidle_driver *drv = cpuidle_get_cpu_driver(device);
 	int i;
 
-	for (i = 0; i < device->state_count; i++)
+	for (i = 0; i < drv->state_count; i++)
 		cpuidle_free_state_kobj(device, i);
 }
 
diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index 306178d..9c5e892 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -77,7 +77,6 @@ struct cpuidle_device {
 	unsigned int		cpu;
 
 	int			last_residency;
-	int			state_count;
 	struct cpuidle_state_usage	states_usage[CPUIDLE_STATE_MAX];
 	struct cpuidle_state_kobj *kobjs[CPUIDLE_STATE_MAX];
 	struct cpuidle_driver_kobj *kobj_driver;
-- 
2.1.0


--nextPart2818934.tJEj2j1ePN
Content-Disposition: inline; filename="0002-ACPI-cpuidle-do-not-overwrite-name-and-description-o.patch"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="0002-ACPI-cpuidle-do-not-overwrite-name-and-description-o.patch"

>From d8357a73b8bf4e23a4b5ac4499224b39d0079ddb Mon Sep 17 00:00:00 2001
From: Thomas Schlichter <thomas.schlichter@web.de>
Date: Tue, 31 Mar 2015 20:24:39 +0200
Subject: [PATCH 2/2] ACPI / cpuidle: do not overwrite name and description of
 C0

This fixes a bug that leads to showing name and description of C-state C0 as
"<null>" in sysfs after the ACPI C-states changed (e.g. after AC->DC or DC->AC
transition).

The function poll_idle_init() in drivers/cpuidle/driver.c initializes the
state 0 during cpuidle_register_driver(). So we better do not overwrite it
again with '\0' during acpi_processor_cst_has_changed().

Signed-off-by: Thomas Schlichter <thomas.schlichter@web.de>
---
 drivers/acpi/processor_idle.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index c6bb9f1..f98db0b 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -922,7 +922,7 @@ static int acpi_processor_setup_cpuidle_states(struct acpi_processor *pr)
 		return -EINVAL;
 
 	drv->safe_state_index = -1;
-	for (i = 0; i < CPUIDLE_STATE_MAX; i++) {
+	for (i = CPUIDLE_DRIVER_STATE_START; i < CPUIDLE_STATE_MAX; i++) {
 		drv->states[i].name[0] = '\0';
 		drv->states[i].desc[0] = '\0';
 	}
-- 
2.1.0


--nextPart2818934.tJEj2j1ePN--

