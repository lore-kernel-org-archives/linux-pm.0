Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5C9277C9D;
	Mon, 18 May 2026 21:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779140082; cv=pass; b=lWB3Pu4cZROppqbzclMUjwBdUW4U4D8hneJSHrbvkRxfzXsufRDzloDNycuITSeOXrbmijunProu51inDmGVsXVoM31LvQiZ/oET2cR2PUsdwpJrDSTZJXR5VXPM2e4R9AmrS7U2wvsJt6jNR6+i2ds04z5SvsndMSJuZ7GNtMQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779140082; c=relaxed/simple;
	bh=h93k6fAr2AjgLiaY1Qxj+TRVuY8Q21qd2Mu4H7QR2XQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GcirZUEPZqw+lS+LAPonx0eKyPijMaigYtkiMRpHi6VDeANqJ9u3TQ3h61uUGrSTSCDUqNHbp98H+Lc8nIP6IRUvEknqHe8RzaZgle5O0dEJfDZUPyts2mtAxNrlrYcXXFdHVFrcqvStlJ0UlABTpQrhYmROUtpbpgjUuJ+TdL0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nfraprado@collabora.com header.b=hbgK+mkH; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nfraprado@collabora.com header.b="hbgK+mkH"
ARC-Seal: i=1; a=rsa-sha256; t=1779140068; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=TDPOySlzjpmI3f14uW6M8It2+JP5qg4osqXGzgxRnOzUK/heJUYc8OUUXM5pHqo0k4OHfkfZIVwZSj3MmkvETOrkyHfN6cTnPhu9rf7h7tFvg7ZVDB5tnvmMM1I/ompK60ZlLP7lpDOREDjnbHal3a0ULT9HreSF2iDmBuRlzl0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1779140068; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=NerxfX4Ukn3y1jS3lkg7tKYKKCCoqxNeUpWMyHMdJWI=; 
	b=h3A2zweJ5nMGIDYcOtEDIaPtLN53cI9urJ/WPRLDnk1nvgc8/6P53mRco6kdSJtygMhkT+9TJFBw9pi60BuqZX501hA5uwT95uBQmqxvWw9AX7Yb8sD7j9shlaBaWGt+QWEVDcnPcNXZknjG4l1Ac1m1xa0Ywv06dWhBpL/WBSE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nfraprado@collabora.com;
	dmarc=pass header.from=<nfraprado@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1779140068;
	s=zohomail; d=collabora.com; i=nfraprado@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=NerxfX4Ukn3y1jS3lkg7tKYKKCCoqxNeUpWMyHMdJWI=;
	b=hbgK+mkHhGJ+PoA1xa3L9kTU+aR9uIibK9pcDbUFcHtMC/MVDYCftrIiIarnJYt8
	LvkJb6sZ5+l600B1pLPQmDwozUexsjpO4eiLjzsY+g7clZnVYA5WxOTQSfxblp9xciF
	HkcOC7NIUK4BPgwhHzltAxCvrSHEVbmJQQxYgqws=
Received: by mx.zohomail.com with SMTPS id 1779140066687957.4820724782115;
	Mon, 18 May 2026 14:34:26 -0700 (PDT)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Mon, 18 May 2026 17:34:23 -0400
Subject: [PATCH 2/3] PM: hibernate: Add platform_enter hibernation test
 level
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260518-hibernation-decrease-time-in-copy-data-pages-v1-2-3998bdf90ee5@collabora.com>
References: <20260518-hibernation-decrease-time-in-copy-data-pages-v1-0-3998bdf90ee5@collabora.com>
In-Reply-To: <20260518-hibernation-decrease-time-in-copy-data-pages-v1-0-3998bdf90ee5@collabora.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Pavel Machek <pavel@kernel.org>
Cc: Brian Geffon <bgeffon@google.com>, kernel@collabora.com, 
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
X-Mailer: b4 0.14.3
X-ZohoMailClient: External

Add a 'platform_enter' hibernation test level to allow testing the full
hibernation path up until the last point of return in
hibernation_platform_enter().

In particular this allows seeing print messages from the code run after
the hibernation image is created on platforms that don't have an easily
accessible serial console, since these messages are not present upon
hibernation resume.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 kernel/power/hibernate.c | 13 +++++++++++--
 kernel/power/main.c      |  1 +
 kernel/power/power.h     |  1 +
 3 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index 001e4556b137..15cb7a090770 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -75,6 +75,7 @@ enum {
 static int hibernation_mode = HIBERNATION_SHUTDOWN;
 
 bool freezer_test_done;
+bool platform_enter_test_done;
 
 static const struct platform_hibernation_ops *hibernation_ops;
 
@@ -636,6 +637,11 @@ int hibernation_platform_enter(void)
 		goto Power_up;
 	}
 
+	if (hibernation_test(TEST_PLATFORM_ENTER)) {
+		platform_enter_test_done = true;
+		goto Power_up;
+	}
+
 	hibernation_ops->enter();
 	/* We should never get here */
 	while (1);
@@ -700,6 +706,8 @@ static int power_down(void)
 		break;
 	case HIBERNATION_PLATFORM:
 		error = hibernation_platform_enter();
+		if (platform_enter_test_done)
+			goto exit;
 		if (error == -EAGAIN || error == -EBUSY) {
 			events_check_enabled = false;
 			pr_info("Wakeup event detected during hibernation, rolling back.\n");
@@ -848,7 +856,7 @@ int hibernate(void)
 			else
 				error = power_down();
 		}
-		if (error) {
+		if (error || platform_enter_test_done) {
 			/* recover any devices that refused to thaw */
 			dpm_resume_suspended_devices(PMSG_RECOVER);
 		}
@@ -870,8 +878,9 @@ int hibernate(void)
 	}
 	thaw_processes();
 
-	/* Don't bother checking whether freezer_test_done is true */
+	/* Don't bother checking whether any of the test_done flags are true */
 	freezer_test_done = false;
+	platform_enter_test_done = false;
  Exit:
 	filesystems_thaw();
 	pm_notifier_call_chain(PM_POST_HIBERNATION);
diff --git a/kernel/power/main.c b/kernel/power/main.c
index 7f53ef65b789..04f0c429519c 100644
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -273,6 +273,7 @@ static const char * const pm_tests[__TEST_AFTER_LAST] = {
 	[TEST_PLATFORM] = "platform",
 	[TEST_DEVICES] = "devices",
 	[TEST_FREEZER] = "freezer",
+	[TEST_PLATFORM_ENTER] = "platform_enter",
 };
 
 static ssize_t pm_test_show(struct kobject *kobj, struct kobj_attribute *attr,
diff --git a/kernel/power/power.h b/kernel/power/power.h
index 7ccd709af93f..0d33d0e46ed0 100644
--- a/kernel/power/power.h
+++ b/kernel/power/power.h
@@ -259,6 +259,7 @@ enum {
 	TEST_PLATFORM,
 	TEST_DEVICES,
 	TEST_FREEZER,
+	TEST_PLATFORM_ENTER,
 	/* keep last */
 	__TEST_AFTER_LAST
 };

-- 
2.53.0

