Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795534844;
	b=qdPdgvROn9r041dJgZpl/OUmRAXYf+38w0QKQ8342H5d1+JzcVWcsYADp3VEJ2CAy/Oo
	 bDSu3MonrsMNAK8t89e4+MD4V3oB5GSFzjWIiCzOXyWImQat/HnY6scQbbCby/8jQVUef
	 GI64P8Tghe0NezIqzoyIDRZucmcRjNfb/TUsqrcuNBU07bIELuB5EZ9W4d8OGkbYoLWVd
	 +wHwJYqfh6MKtOLTGxHTY3e2tU0SDE0eJJ/m0RQevbnNU+LN98ionMkXDwvEzpz51jrth
	 FbCoaC/9XuKaH60YBJUlwgcyfMqOk652K3+qooTkmWVB+bJpapbPrX/vFOe0hbZMrJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795534844;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 Organization:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	bh=1BHPrRVeo8h61Zu87VGiPptusl8oadkPoM4yqveP1JU=;
	b=QW0//epM9uK8KDBPROm77W/xqAwGrJ/6oTGoWidXFptX2qG3zPAIM3/dsextWKEEtg+h
	 facfjQeJMV5XiJih7hMWWXPBPNWWtMjgI2TmsG0k19xNqY/7e957u9HQd2jR4oiY8A/V0
	 PLiYdHyNF0yI4xAmyz2biSwNV89N9+MOxwoPyY1q1A84DI4Wfpdyc9cVI3l5qKvrB+EUg
	 wM8GoHrZIzWCbzMTrj3/NIua1FeJBoyZ18aUO7KTIHCD/hVl5kvMlbCkPJztuZxMOfW+g
	 bgw4Lw3whMErpAtQ0hKvcC1iLvhshmcPPRMMm86Q3v7XEyLvxHaw/17yVDBJ44BwTZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J5BzEdMN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD22606A323;
	Tue, 24 Nov 2026 15:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J5BzEdMN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 205441F000C0;
	Tue, 24 Nov 2026 15:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795534844;
	bh=1BHPrRVeo8h61Zu87VGiPptusl8oadkPoM4yqveP1JU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=J5BzEdMNKdcQW0qkPoatHivahLdo+B9GH+w0/kU/Tex0ZzsMaOY16mUu6nMnY9miP
	 ezU4xAH3OUj7kdJs3CLPeKxwskftkcvrTvoTLDcPtBWvKTv8X4xw+UPZ6FavUPumSB
	 TvdUf+NkVOG1m1icGPJ6reZYDJWKMMMIsAv10b9SB47eixy6rtFv7+SJ+uhPiiulMD
	 O6+lOBGiyQNEOYrr2i0OtuqE09cW/8OkzGFdJQVZ/UiLpMiqwTQU6/tsYHeP72Yyhy
	 mlkwxYrcnBMKR9ObFErv7J6nIM/g+ecObyikGct4Y3asrnzx1y5FuSsyjjTBjo12jV
	 2LwbhtpIwsPsQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Brian Norris <briannorris@chromium.org>,
 Alan Stern <stern@rowland.harvard.edu>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Ulf Hansson <ulf.hansson@oss.qualcomm.com>,
 Linux Driver Core Development <driver-core@lists.linux.dev>
Subject:
 [PATCH v2 2/4] PM: runtime: Avoid suspends without respecting autosuspend
 delay
Date: Tue, 24 Nov 2026 16:35:08 +0100
Message-ID: <3450859.44csPzL39Z@rafael.j.wysocki>
Organization: Linux Kernel Development - Intel
In-Reply-To: <4779892.LvFx2qVVIh@rafael.j.wysocki>
References: <4779892.LvFx2qVVIh@rafael.j.wysocki>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Commit 26236a3e8803 ("PM: runtime: Update last_busy before calling
rpm_suspend() in rpm_idle()") overlooked some cases in which the given
device may be suspended without respecting its autosuspend delay right
after the last runtime PM reference to it has been dropped.  They are all
scenarios in which a leftover autosuspend timer is running when the last
runtime PM reference to the given device is dropped, and dropping that
reference allows the timer to suspend the device right away.

For example, pm_runtime_put() may be called while an autosuspend timer
is running.  Then, dropping the device's runtime PM usage counter to 0
in __pm_runtime_idle() allows rpm_suspend() triggered by the timer to
suspend the device right away before __pm_runtime_idle() is able to
grab its PM spinlock.

Analogous situations may occur when child_count of a device's parent
is dropped in rpm_suspend() and __pm_runtime_set_status(), and in the
callers of pm_runtime_release_supplier().

Prevent them all from occurring by adding last_busy updates in a few
places where rpm_idle() calls follow dropping runtime PM references to
devices.

It is not necessary to add memory barriers to enforce the requisite
ordering of updates which is naturally enforced by the existing code in
all of those cases.  However, add comments explaining the rationale for
updating last_busy and the pairing of memory barriers, and accordingly
update the memory barrier comment in pm_runtime_autosuspend_expiration().

Fixes: 26236a3e8803 ("PM: runtime: Update last_busy before calling rpm_suspend() in rpm_idle()")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2:
   * New patch addressing one of the cases addressed by the v1 and a few
     more analogous cases (Brian)

---
 drivers/base/power/runtime.c | 53 ++++++++++++++++++++++++++++++++----
 1 file changed, 47 insertions(+), 6 deletions(-)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index c295acf6a718..a71afaea7707 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -187,10 +187,13 @@ u64 pm_runtime_autosuspend_expiration(struct device *dev)
 		return 0;
 
 	/*
-	 * Prevent last_busy updates occurring before the rpm_drop_usage_count()
-	 * invocations in __pm_runtime_idle() and __pm_runtime_suspend() from
-	 * being missed if the last_busy access below gets reordered before the
-	 * initial usage counter check in rpm_suspend().
+	 * If the last_busy access below gets reordered before the initial usage
+	 * counter check in rpm_suspend(), last_busy updates made before any of
+	 * the following may be missed:
+	 * - rpm_drop_usage_count() in __pm_runtime_idle() and
+	 *   __pm_runtime_suspend(),
+	 * - the usage count update in pm_runtime_release_supplier(),
+	 * - the child_count update in rpm_release_parent().
 	 */
 	smp_rmb();
 	expires  = READ_ONCE(dev->power.last_busy);
@@ -333,6 +336,16 @@ void pm_runtime_release_supplier(struct device_link *link)
 {
 	struct device *supplier = link->supplier;
 
+	/*
+	 * Since rpm_suspend() may run as a whole right after the loop below,
+	 * prevent it from suspending the supplier without respecting its
+	 * autosuspend delay.  The last_busy update cannot be reordered with
+	 * the usage counter update in pm_runtime_put_noidle(), which is fully
+	 * ordered and pairs with the read memory barrier in
+	 * pm_runtime_autosuspend_expiration().
+	 */
+	pm_runtime_mark_last_busy(supplier);
+
 	/*
 	 * The additional power.usage_count check is a safety net in case
 	 * the rpm_active refcount becomes saturated, in which case
@@ -574,6 +587,25 @@ static int rpm_idle(struct device *dev, int rpmflags)
 	return rpm_suspend(dev, rpmflags | RPM_AUTO);
 }
 
+static void rpm_release_parent(struct device *parent)
+{
+	/*
+	 * Since rpm_suspend() may run as a whole for parent right after its
+	 * child_count update below, prevent it from suspending parent without
+	 * respecting its autosuspend delay.
+	 */
+	if (!parent->power.ignore_children)
+		pm_runtime_mark_last_busy(parent);
+
+	/*
+	 * A successful atomic_add_unless() call is a memory barrier which is
+	 * sufficient to enforce the requisite ordering with respect to the
+	 * last_busy update above and it pairs with the read memory barrier in
+	 * pm_runtime_autosuspend_expiration().
+	 */
+	atomic_add_unless(&parent->power.child_count, -1, 0);
+}
+
 /**
  * rpm_suspend - Carry out runtime suspend of given device.
  * @dev: Device to suspend.
@@ -719,7 +751,7 @@ static int rpm_suspend(struct device *dev, int rpmflags)
 
 	if (dev->parent) {
 		parent = dev->parent;
-		atomic_add_unless(&parent->power.child_count, -1, 0);
+		rpm_release_parent(parent);
 	}
 	wake_up_all(&dev->power.wait_queue);
 
@@ -1139,6 +1171,15 @@ int __pm_runtime_idle(struct device *dev, int rpmflags)
 	int retval;
 
 	if (rpmflags & RPM_GET_PUT) {
+		/*
+		 * Since rpm_suspend() may run as a whole right after the usage
+		 * counter decrementation below, prevent it from suspending the
+		 * device without respecting its autosuspend delay.  The
+		 * requisite ordering is enforced by rpm_drop_usage_count(),
+		 * which is an implicit memory barrier and pairs with the
+		 * explicit one in pm_runtime_autosuspend_expiration().
+		 */
+		pm_runtime_mark_last_busy(dev);
 		retval = rpm_drop_usage_count(dev);
 		if (retval < 0) {
 			return retval;
@@ -1383,7 +1424,7 @@ int __pm_runtime_set_status(struct device *dev, unsigned int status)
 		goto out_set;
 
 	if (status == RPM_SUSPENDED) {
-		atomic_add_unless(&parent->power.child_count, -1, 0);
+		rpm_release_parent(parent);
 		notify_parent = !parent->power.ignore_children;
 	} else {
 		spin_lock_nested(&parent->power.lock, SINGLE_DEPTH_NESTING);
-- 
2.51.0




