Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A8236EA88;
	Tue, 22 Sep 2026 01:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790040285; cv=none; b=JdggTpeFMQEsmelCcCFddrCa+q5aJnEkVIKTQMM7DBSMo8J/Vwfn36M3UvcC4q8P46LEQiesBwwY87bTV5vNJyw+NiRpzSI3LC7sA+lF4XEGRyX44w0M6J6JkaGn9lvkRVqLuMTX2tU2z/dNJA7K+RETKfX2/tVAguFxUzecFzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790040285; c=relaxed/simple;
	bh=9zCLaBHANTRL5xorvVG/TxnrCgCcu3PPyV46iQEFDPU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E4unibMlpdsdR77rUEUf9R0B/9+Y6OExQVemh2qVvq/TcnoTH9ks57S21iDvC4cnHgIjgZNw6A0o30ll91AdnMQ57Eedwza03JYIscKVbFYY4SbDOJOlKUrbDULrGthZsCnTH9gwmYI8K0yZvC7/j9NfGo9WsqEXtISUOjAEaJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SE5WO0aR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SE5WO0aR"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4FFBAC2BCF7;
	Tue, 22 Sep 2026 01:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790040285;
	bh=9zCLaBHANTRL5xorvVG/TxnrCgCcu3PPyV46iQEFDPU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=SE5WO0aRgOy3iqpTBe8Hf3Wbk2EA2xnhn16DDeDCfmBl28FNT72u61gBE1i+u/pNh
	 woUjQgR2IbIUIEjYUjk9LSdQ5ulA+VZWjQzM6sb7ijlSV6zA0WicyjECzz+bTWQyk7
	 zEkxU0iX+ZJ6Fe5V9om16UqMJBwYwcKgU8GFOkkK+cpyUbYO9dKeowOdu4BksX9Ocm
	 hFAT2s3AMJ/e4T7odr0VO/QS9ltUKRIw9UYpYH/6QbeLyR4MFmtLXFpUMTXb+GJY2j
	 xnpPLbHoTUbiWKgP9Ttr7ovru7lchH4qc262YNIzEpMabyu2UI982c6vFH3Z2kWtHC
	 BRhA7iGGrLcIA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 271C8C982FC;
	Tue, 22 Sep 2026 01:24:45 +0000 (UTC)
From: Jaidev Shastri via B4 Relay <devnull+jaidevshastri.vt.edu@kernel.org>
Date: Mon, 21 Sep 2026 21:24:42 -0400
Subject: [PATCH 1/2] PM: sleep: publish pm_transition with release
 semantics
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-mb-pm-main-v1-1-1d4cbd9d2b2c@vt.edu>
References: <20260921-mb-pm-main-v1-0-1d4cbd9d2b2c@vt.edu>
In-Reply-To: <20260921-mb-pm-main-v1-0-1d4cbd9d2b2c@vt.edu>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Danilo Krummrich <dakr@kernel.org>
Cc: linux-pm@vger.kernel.org, driver-core@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Jaidev Shastri <jaidevshastri@vt.edu>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790040284; l=3715;
 i=jaidevshastri@vt.edu; s=20260921; h=from:subject:message-id;
 bh=azdyUjMWNlvyw0fWXxRiaZkcMY5OCgItug2q1XG165w=;
 b=6VABRbjIMJcJxQBTxhBhk1XqpoAWb0JsYa9rkb5VV9NS+MSMw8qAdiMDgVPVMixaoOUY3aFkj
 sJY7Uv6cz0PBDbNMU9Ze44+p8qhRScze0mGb1kxLuSnpc3nHbSVoX1l
X-Developer-Key: i=jaidevshastri@vt.edu; a=ed25519;
 pk=J7+xYJRlTPds+pv5hbqFFRqGCpDeJDzmZT1ggRwj7/0=
X-Endpoint-Received: by B4 Relay for jaidevshastri@vt.edu/20260921 with
 auth_id=1044
X-Original-From: Jaidev Shastri <jaidevshastri@vt.edu>
Reply-To: jaidevshastri@vt.edu

From: Jaidev Shastri <jaidevshastri@vt.edu>

Each dpm_*() phase function stores the current transition to
pm_transition with a plain store before it schedules the asynchronous
device callbacks. dev_pm_skip_resume() and pm_hibernate_is_recovering()
read pm_transition.event from those callbacks, on other CPUs, with plain
loads.

Store the event with smp_store_release() and read it with
smp_load_acquire().

Found with MBCheck, a static herd7-based memory consistency checker.

Signed-off-by: Jaidev Shastri <jaidevshastri@vt.edu>
---
 drivers/base/power/main.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index e130da428..bf4b4fd1b 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -78,7 +78,8 @@ static int async_error;
  */
 bool pm_hibernate_is_recovering(void)
 {
-	return pm_transition.event == PM_EVENT_RECOVER;
+	/* Pairs with the smp_store_release() in the dpm_*() phase functions. */
+	return smp_load_acquire(&pm_transition.event) == PM_EVENT_RECOVER;
 }
 EXPORT_SYMBOL_GPL(pm_hibernate_is_recovering);
 
@@ -682,10 +683,13 @@ static void dpm_watchdog_clear(struct dpm_watchdog *wd)
  */
 bool dev_pm_skip_resume(struct device *dev)
 {
-	if (pm_transition.event == PM_EVENT_RESTORE)
+	/* Pairs with the smp_store_release() in the dpm_*() phase functions. */
+	int event = smp_load_acquire(&pm_transition.event);
+
+	if (event == PM_EVENT_RESTORE)
 		return false;
 
-	if (pm_transition.event == PM_EVENT_THAW)
+	if (event == PM_EVENT_THAW)
 		return dev_pm_skip_suspend(dev);
 
 	return !dev->power.must_resume;
@@ -902,7 +906,8 @@ static void dpm_noirq_resume_devices(pm_message_t state)
 	trace_suspend_resume(TPS("dpm_resume_noirq"), state.event, true);
 
 	async_error = 0;
-	pm_transition = state;
+	/* Pairs with the smp_load_acquire() in dev_pm_skip_resume(). */
+	smp_store_release(&pm_transition.event, state.event);
 
 	mutex_lock(&dpm_list_mtx);
 
@@ -1052,7 +1057,8 @@ void dpm_resume_early(pm_message_t state)
 	trace_suspend_resume(TPS("dpm_resume_early"), state.event, true);
 
 	async_error = 0;
-	pm_transition = state;
+	/* Pairs with the smp_load_acquire() in dev_pm_skip_resume(). */
+	smp_store_release(&pm_transition.event, state.event);
 
 	mutex_lock(&dpm_list_mtx);
 
@@ -1230,7 +1236,8 @@ void dpm_resume(pm_message_t state)
 
 	trace_suspend_resume(TPS("dpm_resume"), state.event, true);
 
-	pm_transition = state;
+	/* Pairs with the smp_load_acquire() in dev_pm_skip_resume(). */
+	smp_store_release(&pm_transition.event, state.event);
 	async_error = 0;
 
 	mutex_lock(&dpm_list_mtx);
@@ -1595,7 +1602,8 @@ static int dpm_noirq_suspend_devices(pm_message_t state)
 
 	trace_suspend_resume(TPS("dpm_suspend_noirq"), state.event, true);
 
-	pm_transition = state;
+	/* Pairs with the smp_load_acquire() in dev_pm_skip_resume(). */
+	smp_store_release(&pm_transition.event, state.event);
 	async_error = 0;
 
 	mutex_lock(&dpm_list_mtx);
@@ -1798,7 +1806,8 @@ int dpm_suspend_late(pm_message_t state)
 
 	trace_suspend_resume(TPS("dpm_suspend_late"), state.event, true);
 
-	pm_transition = state;
+	/* Pairs with the smp_load_acquire() in dev_pm_skip_resume(). */
+	smp_store_release(&pm_transition.event, state.event);
 	async_error = 0;
 
 	wake_up_all_idle_cpus();
@@ -2091,7 +2100,8 @@ int dpm_suspend(pm_message_t state)
 	devfreq_suspend();
 	cpufreq_suspend();
 
-	pm_transition = state;
+	/* Pairs with the smp_load_acquire() in dev_pm_skip_resume(). */
+	smp_store_release(&pm_transition.event, state.event);
 	async_error = 0;
 
 	mutex_lock(&dpm_list_mtx);

-- 
2.43.0


