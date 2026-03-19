Received: from lgeamrelo03.lge.com (lgeamrelo03.lge.com [156.147.51.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6F83612E4
	for <linux-pm@vger.kernel.org>; Thu, 19 Mar 2026 14:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.147.51.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773930267; cv=none; b=F3OLLZo/B6L+4MlAHLZx3pIB1hrdnfvPJSg2f9zbkX5Z1t2GK9jovYF6LTwObWNq9bJsbqiPcVFX6MhptM7f8ppLxTASm4zm4RdB56zKq0gTv3u85GulX3MMd0ZNul6NGgoz+GHLyFnmiVM5NPdB2risol7i/sHFJnaqrpm/5yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773930267; c=relaxed/simple;
	bh=e1J1fkM6AZiTgOcgMFlO3gs3bwXsac0O18rJUTBNO00=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FYFAjq7mwBExJgOTze0EI5+rUqaYG+cgkrPG32lNaTz4XbXtsL3qZ5p/LH+dLDt+qOCIFklevY6nC20wxd0nlOIRoaYXdS2Xxks7N7YAoJqdchh3dMTkYZNPiSJhhLheZByUHmpgQ40wpfEriff+q6fs3KcNXXjbU/1JSMYSlBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.51.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO yjaykim-PowerEdge-T330.lge.net) (10.177.112.156)
	by 156.147.51.102 with ESMTP; 19 Mar 2026 23:24:23 +0900
X-Original-SENDERIP: 10.177.112.156
X-Original-MAILFROM: youngjun.park@lge.com
From: Youngjun Park <youngjun.park@lge.com>
To: rafael@kernel.org,
	akpm@linux-foundation.org
Cc: chrisl@kernel.org,
	kasong@tencent.com,
	pavel@kernel.org,
	shikemeng@huaweicloud.com,
	nphamcs@gmail.com,
	bhe@redhat.com,
	baohua@kernel.org,
	youngjun.park@lge.com,
	usama.arif@linux.dev,
	linux-mm@kvack.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v5 3/3] PM: hibernate: fix spurious GFP mask WARNING in uswsusp path
Date: Thu, 19 Mar 2026 23:24:04 +0900
Message-Id: <20260319142404.3683019-4-youngjun.park@lge.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260319142404.3683019-1-youngjun.park@lge.com>
References: <20260319142404.3683019-1-youngjun.park@lge.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 35e4a69b2003f ("PM: sleep: Allow pm_restrict_gfp_mask()
stacking") introduced refcount-based GFP mask management that warns
when pm_restore_gfp_mask() is called with saved_gfp_count == 0:

  WARNING: kernel/power/main.c:44 at pm_restore_gfp_mask+0xd7/0xf0
  CPU: 0 UID: 0 PID: 373 Comm: s2disk
  Call Trace:
   snapshot_ioctl+0x964/0xbd0
   __x64_sys_ioctl+0x724/0x1320
  ...

The uswsusp path calls pm_restore_gfp_mask() defensively in
SNAPSHOT_CREATE_IMAGE and SNAPSHOT_UNFREEZE where the GFP mask may
or may not be restricted depending on context (first call vs retry,
hibernate vs resume). Before the stacking patch this was a silent
no-op; now it triggers a WARNING.

Introduce pm_restore_gfp_mask_safe() that skips the call when
saved_gfp_count is 0. This is preferred over tracking the restrict
state in snapshot_ioctl, as incorrect tracking risks leaving the
GFP mask permanently restricted.

Fixes: 35e4a69b2003f ("PM: sleep: Allow pm_restrict_gfp_mask() stacking")
Signed-off-by: Youngjun Park <youngjun.park@lge.com>
---
 include/linux/suspend.h | 1 +
 kernel/power/main.c     | 7 +++++++
 kernel/power/user.c     | 4 ++--
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index b02876f1ae38..7777931d88a5 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -454,6 +454,7 @@ extern void pm_report_hw_sleep_time(u64 t);
 extern void pm_report_max_hw_sleep(u64 t);
 void pm_restrict_gfp_mask(void);
 void pm_restore_gfp_mask(void);
+void pm_restore_gfp_mask_safe(void);
 
 #define pm_notifier(fn, pri) {				\
 	static struct notifier_block fn##_nb =			\
diff --git a/kernel/power/main.c b/kernel/power/main.c
index 5f8c9e12eaec..e610a8c8b7ff 100644
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -36,6 +36,13 @@
 static unsigned int saved_gfp_count;
 static gfp_t saved_gfp_mask;
 
+void pm_restore_gfp_mask_safe(void)
+{
+	if (!saved_gfp_count)
+		return;
+	pm_restore_gfp_mask();
+}
+
 void pm_restore_gfp_mask(void)
 {
 	WARN_ON(!mutex_is_locked(&system_transition_mutex));
diff --git a/kernel/power/user.c b/kernel/power/user.c
index 3e41544b99d5..41cff6a89a1c 100644
--- a/kernel/power/user.c
+++ b/kernel/power/user.c
@@ -306,7 +306,7 @@ static long snapshot_ioctl(struct file *filp, unsigned int cmd,
 	case SNAPSHOT_UNFREEZE:
 		if (!data->frozen || data->ready)
 			break;
-		pm_restore_gfp_mask();
+		pm_restore_gfp_mask_safe();
 		free_basic_memory_bitmaps();
 		data->free_bitmaps = false;
 		thaw_processes();
@@ -318,7 +318,7 @@ static long snapshot_ioctl(struct file *filp, unsigned int cmd,
 			error = -EPERM;
 			break;
 		}
-		pm_restore_gfp_mask();
+		pm_restore_gfp_mask_safe();
 		error = hibernation_snapshot(data->platform_support);
 		if (!error) {
 			error = put_user(in_suspend, (int __user *)arg);
-- 
2.34.1

