Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795119556;
	b=y+/N7RhtroxRuYbwO+UP4dp52e+hG6TXyj6vNl2U60+R4uvekvc7K4PDy/3w7kxRGkuX
	 BHqLZYBwcW71YThShT+5t3h4KtxBRbvIP5ao5Lh8JQDwpA1cZ4jbPrQkX9DwZitHtkovm
	 qExBjqNYTzbaG/nsGNihL0OIYMJ6/ElD/7bZIlcvQ1KG9kSLtjDr2wXQ5dovM7lyXncXu
	 V9p0ZtsnMzKy8fhThfigaUYWRjlLRHxSv/W/9YmTULgZIv6IKxPsuOAmGYpqGhxcUL118
	 Bi0QQwrDVN39wMqqr4w4yZI/QwE9VNucTlRlCQa0ZaMxsadDahjPXA5hNtQN/UWK4cg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795119556;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 Organization:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	bh=OogEKCNGRvLuBW//eII916UBiZklVlIkjAsq+LhWHpI=;
	b=2o57wN2efgHhgOLSYhHVdfmBxhd5MstvJtlGI2mZ5TB55nEOr79A4G/4jW/prw2PDbGb
	 XA1wYHb6bjDk5smKD8d12ZJ1533eSgL88JBjxmsptNb/bFcGy5bPkgJVodKuXI2piN15J
	 4lz+yWbHGckCclAbMGYzuVdpRiRorcFPbA5g/6YtW/G3LnnZZ6kwp3DMLCWl3ejUz7jCI
	 nMu6Kw+DbhR7QWt1PKxF/THeko9MpiJb0zTN2ueTq9xJ89kS9IRqLcvdujQk5xzr+1ODf
	 r18GNvVxiZwoP2EISUBcROd67PYVzuYLiE7e58LZt9RqLeqodvfVCF1hq0OeoChsMnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tfa5AdOG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0A8606A9C1;
	Thu, 19 Nov 2026 20:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tfa5AdOG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59F0D1F000C4;
	Thu, 19 Nov 2026 20:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795119556;
	bh=OogEKCNGRvLuBW//eII916UBiZklVlIkjAsq+LhWHpI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Tfa5AdOG2NYI4iEdhJLxj1mNS0pUww3Ei78ala+44+7pA+zfWgmlXL1lMepGYg73f
	 nXbFaWczsim1VRMZoNvcIYjWLam5D9Lyl7QjMGigcStDoJdAPSnKnEiwmlIlffbXvY
	 RoFuLn6xlqmgbXgJIWatfpzf3nDXpU0tgBzeniKiJwRNaPupH0hlvQaATe8C79oZ6H
	 9sZbCxbMOyH2DRIx38cDpBtmnUFZcqkVDNuIUQZByg2HRaEJgXrlaFOaUMrxNETQ4r
	 UbmL9Ih/qn0ZB09g9vktNMTwKL9EUaUqHqvjsaZWHqPj2SFOSkvHu7LtxMR98o3ugQ
	 J69IMRisrN5MQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Brian Norris <briannorris@chromium.org>,
 Alan Stern <stern@rowland.harvard.edu>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Ulf Hansson <ulf.hansson@oss.qualcomm.com>,
 Linux Driver Core Development <driver-core@lists.linux.dev>
Subject: [PATCH v1 1/4] PM: runtime: Update last_busy in all rpm_idle() paths
Date: Thu, 19 Nov 2026 21:16:30 +0100
Message-ID: <3076901.e9J7NaK4W3@rafael.j.wysocki>
Organization: Linux Kernel Development - Intel
In-Reply-To: <1978814.tdWV9SEqCh@rafael.j.wysocki>
References: <1978814.tdWV9SEqCh@rafael.j.wysocki>
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

The changelog of commit 26236a3e8803 ("PM: runtime: Update last_busy
before calling rpm_suspend() in rpm_idle()") stated that rpm_idle() only
needed to update last_busy when it was about to call rpm_suspend(), but
that is incorrect.  There are still cases in which a device may be
autosuspended earlier than expected.

The first one is when pm_runtime_put() is called while a leftover
autosuspend timer is running.  Then, dropping the device's runtime PM
usage counter to 0 allows rpm_suspend() triggered by the timer to
suspend the device immediately before __pm_runtime_idle() is able to
grab the spinlock.  Prevent it from occurring by adding a last_busy
update before the rpm_drop_usage_count() call in __pm_runtime_idle().

Another one is when rpm_idle() returns without calling rpm_suspend(),
for example because the callback has returned a transient error, while
an autosuspend timer is running.  The timer may then suspend the device
without respecting the autosuspend delay.  Moreover, the timer may fire
while the callback is running and it will not see the new last_busy
value in that case.  To address these cases, move the existing
pm_runtime_mark_last_busy() call in rpm_idle() before the first return
value check.

In both places mentioned above add comments explaining the rationale for
updating last_busy.

Fixes: 26236a3e8803 ("PM: runtime: Update last_busy before calling rpm_suspend() in rpm_idle()")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

Commit 26236a3e8803 is present in linux-next.

---
 drivers/base/power/runtime.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 0b15c718c1bb..02e7b4953c38 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -518,6 +518,14 @@ static int rpm_idle(struct device *dev, int rpmflags)
 	else if (dev->power.idle_notification)
 		retval = -EINPROGRESS;
 
+	/*
+	 * Update last_busy to defer autosuspend by the full autosuspend delay.
+	 * Since an autosuspend timer may be running and the new last_busy value
+	 * needs to be seen by it, update last_busy before returning an error or
+	 * dropping the spinlock and allowing the timer function to grab it.
+	 */
+	pm_runtime_mark_last_busy(dev);
+
 	if (retval)
 		goto out;
 
@@ -563,7 +571,6 @@ static int rpm_idle(struct device *dev, int rpmflags)
 	if (retval)
 		return retval;
 
-	pm_runtime_mark_last_busy(dev);
 	return rpm_suspend(dev, rpmflags | RPM_AUTO);
 }
 
@@ -1132,6 +1139,13 @@ int __pm_runtime_idle(struct device *dev, int rpmflags)
 	int retval;
 
 	if (rpmflags & RPM_GET_PUT) {
+		/*
+		 * Once the usage counter drops to 0, a leftover autosuspend
+		 * timer may fire before the spinlock below is acquired.  Update
+		 * last_busy first so it does not find the expiration time in
+		 * the past and suspend the device immediately.
+		 */
+		pm_runtime_mark_last_busy(dev);
 		retval = rpm_drop_usage_count(dev);
 		if (retval < 0) {
 			return retval;
-- 
2.51.0




