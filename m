From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [RFC v2 8/8] PM / Domains: Add asserts for PM domain locks
Date: Mon, 12 Jun 2017 17:17:48 +0200
Message-ID: <20170612151748.7380-9-krzk@kernel.org>
References: <20170612151748.7380-1-krzk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170612151748.7380-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>
List-Id: linux-pm@vger.kernel.org

Add lockdep checks for holding domain lock in few places where this is
required.  This might expose misuse even though only file-scope
functions use it for now.

Regular lockdep asserts can be entirely discarded by preprocessor, however
domain code uses mixed type of lock: spinlock or mutex.  This means that
these asserts will not be thrown away entirely.  Instead, always
at least two pointer dereferences (p->lock_ops->assert_held) and
probably one function call (assert_held()) will be made.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/base/power/domain.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 33467beaeea4..36db9a06f0cc 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -40,12 +40,18 @@ static LIST_HEAD(gpd_list);
 static DEFINE_MUTEX(gpd_list_lock);
 
 struct genpd_lock_ops {
+	void (*assert_held)(struct generic_pm_domain *genpd);
 	void (*lock)(struct generic_pm_domain *genpd);
 	void (*lock_nested)(struct generic_pm_domain *genpd, int depth);
 	int (*lock_interruptible)(struct generic_pm_domain *genpd);
 	void (*unlock)(struct generic_pm_domain *genpd);
 };
 
+static void genpd_assert_held_mtx(struct generic_pm_domain *genpd)
+{
+	lockdep_assert_held(&genpd->mlock);
+}
+
 static void genpd_lock_mtx(struct generic_pm_domain *genpd)
 {
 	mutex_lock(&genpd->mlock);
@@ -68,12 +74,18 @@ static void genpd_unlock_mtx(struct generic_pm_domain *genpd)
 }
 
 static const struct genpd_lock_ops genpd_mtx_ops = {
+	.assert_held = genpd_assert_held_mtx,
 	.lock = genpd_lock_mtx,
 	.lock_nested = genpd_lock_nested_mtx,
 	.lock_interruptible = genpd_lock_interruptible_mtx,
 	.unlock = genpd_unlock_mtx,
 };
 
+static void genpd_assert_held_spin(struct generic_pm_domain *genpd)
+{
+	lockdep_assert_held(&genpd->slock);
+}
+
 static void genpd_lock_spin(struct generic_pm_domain *genpd)
 	__acquires(&genpd->slock)
 {
@@ -110,12 +122,14 @@ static void genpd_unlock_spin(struct generic_pm_domain *genpd)
 }
 
 static const struct genpd_lock_ops genpd_spin_ops = {
+	.assert_held = genpd_assert_held_spin,
 	.lock = genpd_lock_spin,
 	.lock_nested = genpd_lock_nested_spin,
 	.lock_interruptible = genpd_lock_interruptible_spin,
 	.unlock = genpd_unlock_spin,
 };
 
+#define genpd_assert_held(p)		p->lock_ops->assert_held(p)
 #define genpd_lock(p)			p->lock_ops->lock(p)
 #define genpd_lock_nested(p, d)		p->lock_ops->lock_nested(p, d)
 #define genpd_lock_interruptible(p)	p->lock_ops->lock_interruptible(p)
@@ -299,6 +313,8 @@ static int genpd_power_off(struct generic_pm_domain *genpd, bool one_dev_on,
 	struct gpd_link *link;
 	unsigned int not_suspended = 0;
 
+	genpd_assert_held(genpd);
+
 	/*
 	 * Do not try to power off the domain in the following situations:
 	 * (1) The domain is already in the "power off" state.
@@ -385,6 +401,8 @@ static int genpd_power_on(struct generic_pm_domain *genpd, unsigned int depth)
 	struct gpd_link *link;
 	int ret = 0;
 
+	genpd_assert_held(genpd);
+
 	if (genpd_status_on(genpd))
 		return 0;
 
@@ -766,6 +784,9 @@ static void genpd_sync_power_off(struct generic_pm_domain *genpd, bool use_lock,
 {
 	struct gpd_link *link;
 
+	if (use_lock)
+		genpd_assert_held(genpd);
+
 	if (!genpd_status_on(genpd) || genpd_is_always_on(genpd))
 		return;
 
@@ -808,6 +829,9 @@ static void genpd_sync_power_on(struct generic_pm_domain *genpd, bool use_lock,
 {
 	struct gpd_link *link;
 
+	if (use_lock)
+		genpd_assert_held(genpd);
+
 	if (genpd_status_on(genpd))
 		return;
 
-- 
2.9.3
