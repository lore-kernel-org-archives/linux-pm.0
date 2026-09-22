Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29FA36D9F9;
	Tue, 22 Sep 2026 01:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790040285; cv=none; b=k7yvIbDCxMq7YabYKsQdHCARdQ1lLZh1AUw12aat33vuCxAAYA7X4VTVYAKbAo/Gdi8VzI/mD5Lovb1HMVzbggrgT4klVhxhMpsOJymsG+3A6gz+DHSCgvscUXPDs7LMajIbQdOnPhdqXw5SbCPnB+bM/UWTRTlD1N8lNr9gstY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790040285; c=relaxed/simple;
	bh=TQneHJ/bZcX6S+vxi41JFPQ6lhtFincFVc+Qnq9ZE70=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PE78GOr1tpnpRyj5HvM+Q2pgain8M/uop+QRhqxDBjOHMdTt5c7UBD7C9XCWMGFpWENuCl0zQUi5uQU0PPnDHt+5rYMMCe2ml7LdNeKDY0NeoLcuL/ZmOMupa2Z9sQvRX0M42e639zPHJ9W5ThGWa+v948K1AvZc/ePES2rxj7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hszhwrTb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hszhwrTb"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 59D13C2BCFC;
	Tue, 22 Sep 2026 01:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790040285;
	bh=TQneHJ/bZcX6S+vxi41JFPQ6lhtFincFVc+Qnq9ZE70=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=hszhwrTb+AFBfav2KeaK+MgjNsIzAr7Qzuh0daUpJNpDbeL5WVdP0UHdU3g9INExv
	 3iaDjzLsSGhIKrbM0yQFLqG5AGYnm7OpeSLCRZz5J4JV/w3L74vvLvgLlNTpS0vzQH
	 rQ7xI+7Nsx2rFM6elWtM3rZlvNtYf9/qaJnmYb5sJ1FKvHNtdyF/KEeOmdHB1fg15A
	 CkqEQun8BlVQI7Nkv1mZBmI/k43LFDe/2d/ZwR+xQhPLDKV9maZ130ULM3eKAsT1wi
	 YEgyotZfRC/ssnQRpDbj2uZSbecBYLm5N4sl+WUUwRHWI7fFrhTTtjcWyxqNHiy/cQ
	 XBe0qICAlwX4w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 340B8C982FE;
	Tue, 22 Sep 2026 01:24:45 +0000 (UTC)
From: Jaidev Shastri via B4 Relay <devnull+jaidevshastri.vt.edu@kernel.org>
Date: Mon, 21 Sep 2026 21:24:43 -0400
Subject: [PATCH 2/2] PM: sleep: reset async_error with WRITE_ONCE()
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-mb-pm-main-v1-2-1d4cbd9d2b2c@vt.edu>
References: <20260921-mb-pm-main-v1-0-1d4cbd9d2b2c@vt.edu>
In-Reply-To: <20260921-mb-pm-main-v1-0-1d4cbd9d2b2c@vt.edu>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Danilo Krummrich <dakr@kernel.org>
Cc: linux-pm@vger.kernel.org, driver-core@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Jaidev Shastri <jaidevshastri@vt.edu>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790040284; l=2514;
 i=jaidevshastri@vt.edu; s=20260921; h=from:subject:message-id;
 bh=FjB7xS3+qARVsXk4Wq7dhtfdezLpl2Z4zIUoXhuVxW8=;
 b=wtO0ax58zemrWNGn4XyWf2ptQ0cjYdcW4tMj3UNAN6Wk39c7xqXTdq8E+ji3J/vVTuRdPFV7C
 BSVjGs3F5cKBTnT0BotNoYF1ImhC3ECem01CQtDCmfE95vaLpYjgBH9
X-Developer-Key: i=jaidevshastri@vt.edu; a=ed25519;
 pk=J7+xYJRlTPds+pv5hbqFFRqGCpDeJDzmZT1ggRwj7/0=
X-Endpoint-Received: by B4 Relay for jaidevshastri@vt.edu/20260921 with
 auth_id=1044
X-Original-From: Jaidev Shastri <jaidevshastri@vt.edu>
Reply-To: jaidevshastri@vt.edu

From: Jaidev Shastri <jaidevshastri@vt.edu>

The device PM callbacks record failures with WRITE_ONCE(async_error, ...)
and every reader uses READ_ONCE(), but the six phase functions reset the
variable with a plain store before they schedule the asynchronous
callbacks.

Use WRITE_ONCE() for the reset so that every access to async_error
follows the same convention.

Found with MBCheck, a static herd7-based memory consistency checker.

Signed-off-by: Jaidev Shastri <jaidevshastri@vt.edu>
---
 drivers/base/power/main.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index bf4b4fd1b..24b56aaa3 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -905,7 +905,7 @@ static void dpm_noirq_resume_devices(pm_message_t state)
 
 	trace_suspend_resume(TPS("dpm_resume_noirq"), state.event, true);
 
-	async_error = 0;
+	WRITE_ONCE(async_error, 0);
 	/* Pairs with the smp_load_acquire() in dev_pm_skip_resume(). */
 	smp_store_release(&pm_transition.event, state.event);
 
@@ -1056,7 +1056,7 @@ void dpm_resume_early(pm_message_t state)
 
 	trace_suspend_resume(TPS("dpm_resume_early"), state.event, true);
 
-	async_error = 0;
+	WRITE_ONCE(async_error, 0);
 	/* Pairs with the smp_load_acquire() in dev_pm_skip_resume(). */
 	smp_store_release(&pm_transition.event, state.event);
 
@@ -1238,7 +1238,7 @@ void dpm_resume(pm_message_t state)
 
 	/* Pairs with the smp_load_acquire() in dev_pm_skip_resume(). */
 	smp_store_release(&pm_transition.event, state.event);
-	async_error = 0;
+	WRITE_ONCE(async_error, 0);
 
 	mutex_lock(&dpm_list_mtx);
 
@@ -1604,7 +1604,7 @@ static int dpm_noirq_suspend_devices(pm_message_t state)
 
 	/* Pairs with the smp_load_acquire() in dev_pm_skip_resume(). */
 	smp_store_release(&pm_transition.event, state.event);
-	async_error = 0;
+	WRITE_ONCE(async_error, 0);
 
 	mutex_lock(&dpm_list_mtx);
 
@@ -1808,7 +1808,7 @@ int dpm_suspend_late(pm_message_t state)
 
 	/* Pairs with the smp_load_acquire() in dev_pm_skip_resume(). */
 	smp_store_release(&pm_transition.event, state.event);
-	async_error = 0;
+	WRITE_ONCE(async_error, 0);
 
 	wake_up_all_idle_cpus();
 
@@ -2102,7 +2102,7 @@ int dpm_suspend(pm_message_t state)
 
 	/* Pairs with the smp_load_acquire() in dev_pm_skip_resume(). */
 	smp_store_release(&pm_transition.event, state.event);
-	async_error = 0;
+	WRITE_ONCE(async_error, 0);
 
 	mutex_lock(&dpm_list_mtx);
 

-- 
2.43.0


