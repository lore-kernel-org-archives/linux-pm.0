Received: from lgeamrelo07.lge.com (lgeamrelo07.lge.com [156.147.51.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BFF43F8ECC
	for <linux-pm@vger.kernel.org>; Tue, 15 Sep 2026 03:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.147.51.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789442234; cv=none; b=R7gUxJpodLkEprdzgt6SrBLecHkKM3yjSXZPeySGM94zCVp+atE8UkomlgKCnG3KJjFZIh3J85IRF/allaZR5bRlaT6Jg4IEu9rOboUQ57bK6NolUzG6l3Nqi1R3rjjqFAjT0p6EcO62YBDAbF2nmI48d8r0cvNY1uU5XCMrc9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789442234; c=relaxed/simple;
	bh=zDaO8yqKFFSXre14jnlmr/qF2KcP3mayDBhiQeDMszA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g0lcgk7hBthOIEphEKKixyyB9M2tpB30feXKeI1m69Py+IpBYTLniecCHgLNmU0dao3mA0Rl1AiaflESh6Ls0/GF/4MofNJ6wHDOBnQptH8kN8g9xTZ66/NF9u3X9TJxDGGsQjyNExzTj+mBoFVrQ144WEjWuzcClQ6X4QdSoYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.51.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO yjaykim-PowerEdge-T330.lge.net) (10.177.112.156)
	by 156.147.51.103 with ESMTP; 15 Sep 2026 12:17:03 +0900
X-Original-SENDERIP: 10.177.112.156
X-Original-MAILFROM: youngjun.park@lge.com
From: Youngjun Park <youngjun.park@lge.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Kairui Song <kasong@tencent.com>,
	Chris Li <chrisl@kernel.org>
Cc: Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Baoquan He <baoquan.he@linux.dev>,
	Barry Song <baohua@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Len Brown <lenb@kernel.org>,
	linux-mm@kvack.org,
	linux-pm@vger.kernel.org,
	her0gyugyu@gmail.com,
	youngjun.park@lge.com,
	taejoon.song@lge.com
Subject: [RFC PATCH 01/10] PM: hibernate: give the image's swap slots back when test_resume fails
Date: Tue, 15 Sep 2026 12:16:49 +0900
Message-Id: <20260915031658.1505680-2-youngjun.park@lge.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260915031658.1505680-1-youngjun.park@lge.com>
References: <20260915031658.1505680-1-youngjun.park@lge.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

test_resume writes an image and loads it straight back without powering
off.  When the load fails nothing gives the image's swap slots back.
They stay allocated for as long as the system runs, and swapoff on that
device cannot finish, since the slots belong to no process.

Tested by forcing the restore to fail in test_resume mode.

Fixes: fe12c00d21bb ("PM / hibernate: Introduce test_resume mode for hibernation")
Assisted-by: Claude:claude-fable-5
Signed-off-by: Youngjun Park <youngjun.park@lge.com>
---
 kernel/power/hibernate.c |  6 +++++-
 kernel/power/power.h     |  1 +
 kernel/power/swap.c      | 12 ++++++++++++
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index d2479c69d71a..907d791b85ad 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -857,8 +857,12 @@ int hibernate(void)
 	if (snapshot_test) {
 		pm_pr_dbg("Checking hibernation image\n");
 		error = swsusp_check(false);
-		if (!error)
+		if (!error) {
 			error = load_image_and_restore();
+			/* The image was not used, so free its slots. */
+			if (error)
+				swsusp_free_image_slots();
+		}
 	}
 	thaw_processes();
 
diff --git a/kernel/power/power.h b/kernel/power/power.h
index 75b63843886e..9c398cddd0c3 100644
--- a/kernel/power/power.h
+++ b/kernel/power/power.h
@@ -171,6 +171,7 @@ extern void hibernate_release(void);
 extern sector_t alloc_swapdev_block(int swap);
 extern void free_all_swap_pages(int swap);
 extern int swsusp_swap_in_use(void);
+void swsusp_free_image_slots(void);
 
 /*
  * Flags that can be passed from the hibernatig hernel to the "boot" kernel in
diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index c78f1593600b..dc65ec409207 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -1612,6 +1612,18 @@ int swsusp_check(bool exclusive)
 	return error;
 }
 
+/**
+ * swsusp_free_image_slots - Give back the swap slots the image was written to.
+ *
+ * For a path that writes an image and then does not resume from it.  Until
+ * the slots are given back they stay allocated, and swapoff on that device
+ * cannot finish either.
+ */
+void swsusp_free_image_slots(void)
+{
+	free_all_swap_pages(root_swap);
+}
+
 /**
  * swsusp_close - close resume device.
  */
-- 
2.48.1

