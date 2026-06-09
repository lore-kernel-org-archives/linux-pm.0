Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CAB5426D19;
	Tue,  9 Jun 2026 12:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781009346; cv=pass; b=udEvPzlJ2M16DMgi2VaBwSaIxKZ2Tb9R6wyU+g3FQpQEFAy8ETIMaq7uhq7ZmWyBLx2RC65zRABC1R+UJkt89Ne93SW+o5ZU/EGaYXh5+KIF0/qNm49nGwGjUYQystXLqd63JbfKr0p8xOq12LoWWh/PrVlf9MvMynGNEDXlOXs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781009346; c=relaxed/simple;
	bh=iFuyG3oXriBmNojeKIPTziSLPPeKVhhvpGTsYb5VhE8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=TcUD578ujR3IbFdwKi+dbu/iaq8W8SP8qYfHRfclYZ/QyStTLPJae8DRNLx75aSoyJ27pS5A30m40DjTuUpBDz7qpcC4Efn6GFbtfyxLO1anBhOMoBfjyKoAeLA7GTUH/4JqH5BQ0Pv1Uu89d0qJlxXtJAqe98VTasNXb1BRf9Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nfraprado@collabora.com header.b=PNNme+Pq; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nfraprado@collabora.com header.b="PNNme+Pq"
ARC-Seal: i=1; a=rsa-sha256; t=1781009324; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=XAERFaIl2KZCGqzpvxWtUyEDgH5JIAgbBMhfBlyMD+2FlgmbFTWhzcgJPqvTIUJHiv1uyQF3aZhAYpvrDSp60Ee3Zk6yz4ewY/T+S3nrT5jnhfBsemqAlEc2MWtiZ7cFdsh8wN0maukk2Bj3KwUeCCpjc9tuk6RNqH3d0zplP7k=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1781009324; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Zk5AeNOipumMG3FIBahIzX+sILsGFUeofdiKIFvKqFY=; 
	b=HYAsHSFY1CQQXtMIADYbQNMDddX6L2jCqgxLyYaVgE96syTS0znE0FVbeURjz+fuEGRQt9DCOYs+XJoz1pPB5e9msQzw9t3j82GQgyZWDRCC2jp2R6xFEkOopzzR3MqVPYZOY+inLHysV3GW4worfPm+qCB33Rs8zyw88+PtqVM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nfraprado@collabora.com;
	dmarc=pass header.from=<nfraprado@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1781009324;
	s=zohomail; d=collabora.com; i=nfraprado@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:To:To:Cc:Cc:Reply-To;
	bh=Zk5AeNOipumMG3FIBahIzX+sILsGFUeofdiKIFvKqFY=;
	b=PNNme+Pq9pUwgO62N7p4DzIFNCmPymOaDWXnwB/7vyUaqJnv7OI21HaraNzQxpyA
	fBwI/4H6561elw4mY0ByFEEOqt2nODozQi+5+yOIb5aYeQ8xgJxVEaC3ZOgcT3W8hEW
	4nRY3rPDTOTiqLsXKs0cQm9uF/H+yEKYZibIkXQU=
Received: by mx.zohomail.com with SMTPS id 1781009323554481.1806073815462;
	Tue, 9 Jun 2026 05:48:43 -0700 (PDT)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Tue, 09 Jun 2026 08:48:39 -0400
Subject: [PATCH RFC] PM: sleep: Return -ECANCELED if aborting due to
 pm_wakeup_pending()
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260609-wakeup-pending-ecanceled-v1-1-428d897c07cb@collabora.com>
X-B4-Tracking: v=1; b=H4sIAKYLKGoC/x3MQQqDMBBG4avIrB1IRAJ2K/QA3UoXMflrB8s0J
 NgWxLsbuvwW7+1UkAWFLs1OGR8p8tYK2zYUnl4XsMRq6kznjDMDf/2KLXGCRtGFEbwGvBAZdpi
 D7eFMb6nmKeMhv/96ott1pPtxnAHgj7RvAAAA
X-Change-ID: 20260609-wakeup-pending-ecanceled-e19bc14e6041
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Pavel Machek <pavel@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Danilo Krummrich <dakr@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>
Cc: kernel@collabora.com, linux-pm@vger.kernel.org, 
 driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
X-Mailer: b4 0.14.3
X-ZohoMailClient: External

If system sleep (suspend or hibernate) has been aborted due to
pm_wakeup_pending() returning true, return -ECANCELED so userspace can
tell it apart from actual failures.

ECANCELED is chosen both because it is a less common error code, so
it is less likely to be used for purposes other than the sleep abort due
to pending wakeups in this code path, and also because it more clearly
represents that the sleep was intentionally canceled.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
To give more context on my specific use case:

I want to address the situation where the system is running systemd's
suspend-then-hibernate and while going into hibernation, the user
triggers a wakeup (by pressing the power button). The expectation is
that the system would abort suspend-then-hibernate and wakeup, but
instead it considers that as a hibernation failure and falls back to
suspend instead. The key thing here is that systemd isn't able to tell
that this hibernation failure is not really a failure but an intentional
abort, which is where the consistent error code for pm_wakeup_pending()
can solve the problem.

Sending as an RFC as this is changing an ABI and although I'm not aware
of userspace that relies on the current error codes, it would be good to
get more input on this.
---
 drivers/base/power/main.c | 4 ++--
 drivers/base/syscore.c    | 2 +-
 kernel/cpu.c              | 2 +-
 kernel/power/hibernate.c  | 9 +++++++--
 kernel/power/process.c    | 2 +-
 kernel/power/suspend.c    | 2 +-
 6 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index ed48c292f575..8585fb94811c 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -1646,7 +1646,7 @@ static void device_suspend_late(struct device *dev, pm_message_t state, bool asy
 		goto Complete;
 
 	if (pm_wakeup_pending()) {
-		WRITE_ONCE(async_error, -EBUSY);
+		WRITE_ONCE(async_error, -ECANCELED);
 		goto Complete;
 	}
 
@@ -1902,7 +1902,7 @@ static void device_suspend(struct device *dev, pm_message_t state, bool async)
 
 	if (pm_wakeup_pending()) {
 		dev->power.direct_complete = false;
-		WRITE_ONCE(async_error, -EBUSY);
+		WRITE_ONCE(async_error, -ECANCELED);
 		goto Complete;
 	}
 
diff --git a/drivers/base/syscore.c b/drivers/base/syscore.c
index 483adb796654..37877b0cabd4 100644
--- a/drivers/base/syscore.c
+++ b/drivers/base/syscore.c
@@ -54,7 +54,7 @@ int syscore_suspend(void)
 
 	/* Return error code if there are any wakeup interrupts pending. */
 	if (pm_wakeup_pending())
-		return -EBUSY;
+		return -ECANCELED;
 
 	WARN_ONCE(!irqs_disabled(),
 		"Interrupts enabled before system core suspend.\n");
diff --git a/kernel/cpu.c b/kernel/cpu.c
index f975bb34915b..7e46d51d2431 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1910,7 +1910,7 @@ int freeze_secondary_cpus(int primary)
 
 		if (pm_wakeup_pending()) {
 			pr_info("Wakeup pending. Abort CPU freeze\n");
-			error = -EBUSY;
+			error = -ECANCELED;
 			break;
 		}
 
diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index d2479c69d71a..56b431bf9b1d 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -349,9 +349,14 @@ static int create_image(int platform_mode)
 		goto Enable_irqs;
 	}
 
-	if (hibernation_test(TEST_CORE) || pm_wakeup_pending())
+	if (hibernation_test(TEST_CORE))
 		goto Power_up;
 
+	if (pm_wakeup_pending()) {
+		error = -ECANCELED;
+		goto Power_up;
+	}
+
 	in_suspend = 1;
 	save_processor_state();
 	trace_suspend_resume(TPS("machine_suspend"), PM_EVENT_HIBERNATE, true);
@@ -632,7 +637,7 @@ int hibernation_platform_enter(void)
 		goto Enable_irqs;
 
 	if (pm_wakeup_pending()) {
-		error = -EAGAIN;
+		error = -ECANCELED;
 		goto Power_up;
 	}
 
diff --git a/kernel/power/process.c b/kernel/power/process.c
index dc0dfc349f22..bd164ccdcc2a 100644
--- a/kernel/power/process.c
+++ b/kernel/power/process.c
@@ -108,7 +108,7 @@ static int try_to_freeze_tasks(bool user_only)
 			what, elapsed_msecs / 1000, elapsed_msecs % 1000);
 	}
 
-	return todo ? -EBUSY : 0;
+	return wakeup ? -ECANCELED : todo ? -EBUSY : 0;
 }
 
 /**
diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index 57c44268698f..8e1b43deb9e6 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -469,7 +469,7 @@ static int suspend_enter(suspend_state_t state, bool *wakeup)
 			trace_suspend_resume(TPS("machine_suspend"),
 				state, false);
 		} else if (*wakeup) {
-			error = -EBUSY;
+			error = -ECANCELED;
 		}
 		syscore_resume();
 	}

---
base-commit: a87737435cfa134f9cdcc696ba3080759d04cf72
change-id: 20260609-wakeup-pending-ecanceled-e19bc14e6041

Best regards,
-- 
Nícolas F. R. A. Prado <nfraprado@collabora.com>

