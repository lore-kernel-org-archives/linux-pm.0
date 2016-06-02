From: Michele Di Giorgio <michele.digiorgio@arm.com>
Subject: [PATCH] thermal: fix race condition when updating cooling device
Date: Thu,  2 Jun 2016 15:25:31 +0100
Message-ID: <1464877531-2161-1-git-send-email-michele.digiorgio@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from fw-tnat.cambridge.arm.com ([217.140.96.140]:52533 "EHLO
	cam-smtp0.cambridge.arm.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932297AbcFBOZn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 2 Jun 2016 10:25:43 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Javi Merino <javi.merino@arm.com>, Michele Di Giorgio <michele.digiorgio@arm.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Peter Feuerer <peter@piie.net>

When multiple thermal zones are bound to the same cooling device, multiple
kernel threads may want to update the cooling device state by calling
thermal_cdev_update(). Having cdev not protected by a mutex can lead to a race
condition. Consider the following situation with two kernel threads k1 and k2:

	    Thread k1				Thread k2
                                    ||
                                    ||  call thermal_cdev_update()
                                    ||      ...
                                    ||      set_cur_state(cdev, target);
    call power_actor_set_power()    ||
        ...                         ||
        instance->target = state;   ||
        cdev->updated = false;      ||
                                    ||      cdev->updated = true;
                                    ||      // completes execution
    call thermal_cdev_update()      ||
        // cdev->updated == true    ||
        return;                     ||
                                    \/
                                    time

k2 has already looped through the thermal instances looking for the deepest
cooling device state and is preempted right before setting cdev->updated to
true. Now, k1 runs, modifies the thermal instance state and sets cdev->updated
to false. Then, k1 is preempted and k2 continues the execution by setting
cdev->updated to true, therefore preventing k1 from performing the update.
Notice that this is not an issue if k2 looks at the instance->target modified by
k1 "after" it is assigned by k1. In fact, in this case the update will happen
anyway and k1 can safely return immediately from thermal_cdev_update().

This may lead to a situation where a thermal governor never updates the cooling
device. For example, this is the case for the step_wise governor: when calling
the function thermal_zone_trip_update(), the governor may always get a new state
equal to the old one (which, however, wasn't notified to the cooling device) and
will therefore skip the update.

CC: Zhang Rui <rui.zhang@intel.com>
CC: Eduardo Valentin <edubezval@gmail.com>
CC: Peter Feuerer <peter@piie.net>
Reported-by: Toby Huang <toby.huang@arm.com>
Signed-off-by: Michele Di Giorgio <michele.digiorgio@arm.com>
---
Protecting only the assignment of cdev->updated with mutexes may look
suspicious, but it is necessary to guarantee synchronization and avoiding the
situation described in the commit message.

There are other two possible solutions.

Moving the cdev->lock mutex outside thermal_cdev_update() and protect both the
assignment and the function. This would work, but will probably cause many
issues when updating all the modules that use thermal_cdev_update().

The other solution is to make cdev->updated an atomic_t, change the if
condition to an atomic_cmpxchg and extend the critical section to include the
call to cdev->ops->set_cur_state().

 drivers/thermal/fair_share.c      |  2 ++
 drivers/thermal/gov_bang_bang.c   |  2 ++
 drivers/thermal/power_allocator.c |  2 ++
 drivers/thermal/step_wise.c       |  2 ++
 drivers/thermal/thermal_core.c    | 10 +++++++---
 5 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/fair_share.c b/drivers/thermal/fair_share.c
index 34fe365..68bd1b5 100644
--- a/drivers/thermal/fair_share.c
+++ b/drivers/thermal/fair_share.c
@@ -116,7 +116,9 @@ static int fair_share_throttle(struct thermal_zone_device *tz, int trip)
 		instance->target = get_target_state(tz, cdev, percentage,
 						    cur_trip_level);
 
+		mutex_lock(&instance->cdev->lock);
 		instance->cdev->updated = false;
+		mutex_unlock(&instance->cdev->lock);
 		thermal_cdev_update(cdev);
 	}
 	return 0;
diff --git a/drivers/thermal/gov_bang_bang.c b/drivers/thermal/gov_bang_bang.c
index 70836c5..39d1519 100644
--- a/drivers/thermal/gov_bang_bang.c
+++ b/drivers/thermal/gov_bang_bang.c
@@ -65,7 +65,9 @@ static void thermal_zone_trip_update(struct thermal_zone_device *tz, int trip)
 		dev_dbg(&instance->cdev->device, "target=%d\n",
 					(int)instance->target);
 
+		mutex_lock(&instance->cdev->lock);
 		instance->cdev->updated = false; /* cdev needs update */
+		mutex_unlock(&instance->cdev->lock);
 	}
 
 	mutex_unlock(&tz->lock);
diff --git a/drivers/thermal/power_allocator.c b/drivers/thermal/power_allocator.c
index 1246aa6..2cc5616 100644
--- a/drivers/thermal/power_allocator.c
+++ b/drivers/thermal/power_allocator.c
@@ -529,7 +529,9 @@ static void allow_maximum_power(struct thermal_zone_device *tz)
 			continue;
 
 		instance->target = 0;
+		mutex_lock(&instance->cdev->lock);
 		instance->cdev->updated = false;
+		mutex_unlock(&instance->cdev->lock);
 		thermal_cdev_update(instance->cdev);
 	}
 }
diff --git a/drivers/thermal/step_wise.c b/drivers/thermal/step_wise.c
index ea9366a..bcef2e7 100644
--- a/drivers/thermal/step_wise.c
+++ b/drivers/thermal/step_wise.c
@@ -175,7 +175,9 @@ static void thermal_zone_trip_update(struct thermal_zone_device *tz, int trip)
 			update_passive_instance(tz, trip_type, -1);
 
 		instance->initialized = true;
+		mutex_lock(&instance->cdev->lock);
 		instance->cdev->updated = false; /* cdev needs update */
+		mutex_unlock(&instance->cdev->lock);
 	}
 
 	mutex_unlock(&tz->lock);
diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index a0a8fd1..9d23109 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1089,7 +1089,9 @@ int power_actor_set_power(struct thermal_cooling_device *cdev,
 		return ret;
 
 	instance->target = state;
+	mutex_lock(&cdev->lock);
 	cdev->updated = false;
+	mutex_unlock(&cdev->lock);
 	thermal_cdev_update(cdev);
 
 	return 0;
@@ -1619,11 +1621,13 @@ void thermal_cdev_update(struct thermal_cooling_device *cdev)
 	struct thermal_instance *instance;
 	unsigned long target = 0;
 
+	mutex_lock(&cdev->lock);
 	/* cooling device is updated*/
-	if (cdev->updated)
+	if (cdev->updated) {
+		mutex_unlock(&cdev->lock);
 		return;
+	}
 
-	mutex_lock(&cdev->lock);
 	/* Make sure cdev enters the deepest cooling state */
 	list_for_each_entry(instance, &cdev->thermal_instances, cdev_node) {
 		dev_dbg(&cdev->device, "zone%d->target=%lu\n",
@@ -1633,9 +1637,9 @@ void thermal_cdev_update(struct thermal_cooling_device *cdev)
 		if (instance->target > target)
 			target = instance->target;
 	}
-	mutex_unlock(&cdev->lock);
 	cdev->ops->set_cur_state(cdev, target);
 	cdev->updated = true;
+	mutex_unlock(&cdev->lock);
 	trace_cdev_update(cdev, target);
 	dev_dbg(&cdev->device, "set to state %lu\n", target);
 }
-- 
1.9.1

