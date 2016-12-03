From: Pan Bian <bianpan201602@163.com>
Subject: [PATCH 1/1] cpuidle: fix improper return value on error
Date: Sat,  3 Dec 2016 23:02:27 +0800
Message-ID: <1480777347-7497-1-git-send-email-bianpan201602@163.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Pan Bian <bianpan2016@163.com>
List-Id: linux-pm@vger.kernel.org

From: Pan Bian <bianpan2016@163.com>

In function cpuidle_add_state_sysfs(), variable ret takes the return
value. Its value should be negative on errors. Because ret is reset in
the loop, its value will be 0 during the second and after repeat of the
loop. If kzalloc() returns a NULL pointer then, it will return 0. It may
be better to explicitly assign "-ENOMEM" when the call to kzalloc()
fails.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=188901

Signed-off-by: Pan Bian <bianpan2016@163.com>
---
 drivers/cpuidle/sysfs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/cpuidle/sysfs.c b/drivers/cpuidle/sysfs.c
index 832a2c3..c5adc8c 100644
--- a/drivers/cpuidle/sysfs.c
+++ b/drivers/cpuidle/sysfs.c
@@ -403,8 +403,10 @@ static int cpuidle_add_state_sysfs(struct cpuidle_device *device)
 	/* state statistics */
 	for (i = 0; i < drv->state_count; i++) {
 		kobj = kzalloc(sizeof(struct cpuidle_state_kobj), GFP_KERNEL);
-		if (!kobj)
+		if (!kobj) {
+			ret = -ENOMEM;
 			goto error_state;
+		}
 		kobj->state = &drv->states[i];
 		kobj->state_usage = &device->states_usage[i];
 		init_completion(&kobj->kobj_unregister);
-- 
1.9.1
