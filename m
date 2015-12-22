From: Daniel Kurtz <djkurtz@chromium.org>
Subject: [PATCH] PM / Domains: Release mutex when powering on master domain
Date: Tue, 22 Dec 2015 21:13:01 +0800
Message-ID: <1450789981-29877-1-git-send-email-djkurtz@chromium.org>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
Cc: jcliang@chromium.org, drinkcat@chromium.org, ville.syrjala@linux.intel.com, Daniel Kurtz <djkurtz@chromium.org>, stable@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "open list:GENERIC PM DOMAINS" <linux-pm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Commit ba2bbfbf6307 (PM / Domains: Remove intermediate states from the
power off sequence) removed the mutex_unlock()/_lock() around powering on
a genpd's master domain in __genpd_poweron().

Since all genpd's share a mutex lockdep class, this causes a "possible
recursive locking detected" lockdep warning on boot when trying to power
on a genpd slave domain:

[    1.893137] =============================================
[    1.893139] [ INFO: possible recursive locking detected ]
[    1.893143] 3.18.0 #531 Not tainted
[    1.893145] ---------------------------------------------
[    1.893148] kworker/u8:4/113 is trying to acquire lock:
[    1.893167]  (&genpd->lock){+.+...}, at: [<ffffffc000573818>] genpd_poweron+0x30/0x70
[    1.893169]
[    1.893169] but task is already holding lock:
[    1.893179]  (&genpd->lock){+.+...}, at: [<ffffffc000573818>] genpd_poweron+0x30/0x70
[    1.893182]
[    1.893182] other info that might help us debug this:
[    1.893184]  Possible unsafe locking scenario:
[    1.893184]
[    1.893185]        CPU0
[    1.893187]        ----
[    1.893191]   lock(&genpd->lock);
[    1.893195]   lock(&genpd->lock);
[    1.893196]
[    1.893196]  *** DEADLOCK ***
[    1.893196]
[    1.893198]  May be due to missing lock nesting notation
[    1.893198]
[    1.893201] 4 locks held by kworker/u8:4/113:
[    1.893217]  #0:  ("%s""deferwq"){++++.+}, at: [<ffffffc00023b4e0>] process_one_work+0x1f8/0x50c
[    1.893229]  #1:  (deferred_probe_work){+.+.+.}, at: [<ffffffc00023b4e0>] process_one_work+0x1f8/0x50c
[    1.893241]  #2:  (&dev->mutex){......}, at: [<ffffffc000560920>] __device_attach+0x40/0x12c
[    1.893251]  #3:  (&genpd->lock){+.+...}, at: [<ffffffc000573818>] genpd_poweron+0x30/0x70
[    1.893253]
[    1.893253] stack backtrace:
[    1.893259] CPU: 2 PID: 113 Comm: kworker/u8:4 Not tainted 3.18.0 #531
[    1.893269] Workqueue: deferwq deferred_probe_work_func
[    1.893271] Call trace:
[    1.893295] [<ffffffc000269dcc>] __lock_acquire+0x68c/0x19a8
[    1.893299] [<ffffffc00026b954>] lock_acquire+0x128/0x164
[    1.893304] [<ffffffc00084e090>] mutex_lock_nested+0x90/0x3b4
[    1.893308] [<ffffffc000573814>] genpd_poweron+0x2c/0x70
[    1.893312] [<ffffffc0005738ac>] __genpd_poweron.part.14+0x54/0xcc
[    1.893316] [<ffffffc000573834>] genpd_poweron+0x4c/0x70
[    1.893321] [<ffffffc00057447c>] genpd_dev_pm_attach+0x160/0x19c
[    1.893326] [<ffffffc00056931c>] dev_pm_domain_attach+0x1c/0x2c
...

Fix this by releasing the slaves mutex before acquiring the master's,
which restores the old behavior.

Cc: stable@vger.kernel.org
Fixes: 5d837eef7b99 ("PM / Domains: Remove intermediate states from the power off sequence")
Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
---
 drivers/base/power/domain.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 65f50ec..56fa335 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -196,7 +196,12 @@ static int __genpd_poweron(struct generic_pm_domain *genpd)
 	list_for_each_entry(link, &genpd->slave_links, slave_node) {
 		genpd_sd_counter_inc(link->master);
 
+		mutex_unlock(&genpd->lock);
+
 		ret = genpd_poweron(link->master);
+
+		mutex_lock(&genpd->lock);
+
 		if (ret) {
 			genpd_sd_counter_dec(link->master);
 			goto err;
-- 
2.6.0.rc2.230.g3dd15c0
