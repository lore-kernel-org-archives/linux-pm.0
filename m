Received: from lgeamrelo03.lge.com (lgeamrelo03.lge.com [156.147.51.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82CF4219F3
	for <linux-pm@vger.kernel.org>; Mon,  2 Mar 2026 17:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.147.51.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772471333; cv=none; b=E15xoFbEK4PT/4nxb1byy+BhmhkToWednEcBNrBdPw9SMuWqTeXjZn+bIeL1xRO4Vdgw0hLlacNl1SMkMKQ4o/Fo6WCW8tF3AHd26vvjJwtyE3Dryznf43LNYXt2ZJf35e68QWc17HdoLyT4bShr1lT/xcdH9BAeLcwtljTOJk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772471333; c=relaxed/simple;
	bh=AAngqLotEYvL+D4bsiqg820FmFqj0FoDAAWjSKIAHBs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jWZcKduM4jUSG0/b3nlZtRpQVyNnm128KNXPU4ja1oc9dy0R/wbhCW6/4sV1lU4/4fqaNOT9dnwVU4e9k5FtnTde7A220vCOD87bNuEandyVvWKRHQKFepUHUXTQ323nMcZmBiobA2NA7+gXEmvy/+pXdCbeA7RGyWndQ+JMm38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.51.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO yjaykim-PowerEdge-T330.lge.net) (10.177.112.156)
	by 156.147.51.102 with ESMTP; 3 Mar 2026 01:53:39 +0900
X-Original-SENDERIP: 10.177.112.156
X-Original-MAILFROM: youngjun.park@lge.com
From: Youngjun Park <youngjun.park@lge.com>
To: linux-pm@vger.kernel.org
Cc: linux-mm@kvack.org,
	rafael@kernel.org,
	lenb@kernel.org,
	pavel@kernel.org,
	akpm@linux-foundation.org,
	chrisl@kernel.org,
	kasong@tencent.com,
	shikemeng@huaweicloud.com,
	nphamcs@gmail.com,
	bhe@redhat.com,
	baohua@kernel.org,
	youngjun.park@lge.com
Subject: [RFC PATCH 2/2] kernel/power: hold swap device reference across hibernation swap operation
Date: Tue,  3 Mar 2026 01:53:34 +0900
Message-Id: <20260302165334.1278479-3-youngjun.park@lge.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260302165334.1278479-1-youngjun.park@lge.com>
References: <20260302165334.1278479-1-youngjun.park@lge.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Acquire the swap device reference at the point the swap device is looked
up and release it at each exit path, rather than grabbing and dropping it
on every slot allocation.

This also fixes a race where only the swap type value was retrieved at
lookup time without holding a reference. If swapoff raced after the type
was acquired, subsequent operations would reference a stale swap device.

put_swap_device_by_type() is now placed at all relevant cleanup paths in
both swap.c and user.c to ensure the reference is properly released when
the hibernation swap operation completes or fails.

Signed-off-by: Youngjun Park <youngjun.park@lge.com>
---
 kernel/power/swap.c | 12 +++++++++---
 kernel/power/user.c |  9 ++++++++-
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index 2e64869bb5a0..c230b0fa5a5f 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -350,9 +350,10 @@ static int swsusp_swap_check(void)
 
 	hib_resume_bdev_file = bdev_file_open_by_dev(swsusp_resume_device,
 			BLK_OPEN_WRITE, NULL, NULL);
-	if (IS_ERR(hib_resume_bdev_file))
+	if (IS_ERR(hib_resume_bdev_file)) {
+		put_swap_device_by_type(root_swap);
 		return PTR_ERR(hib_resume_bdev_file);
-
+	}
 	return 0;
 }
 
@@ -418,6 +419,7 @@ static int get_swap_writer(struct swap_map_handle *handle)
 err_rel:
 	release_swap_writer(handle);
 err_close:
+	put_swap_device_by_type(root_swap);
 	swsusp_close();
 	return ret;
 }
@@ -480,8 +482,11 @@ static int swap_writer_finish(struct swap_map_handle *handle,
 		flush_swap_writer(handle);
 	}
 
-	if (error)
+	if (error) {
 		free_all_swap_pages(root_swap);
+		put_swap_device_by_type(root_swap);
+	}
+
 	release_swap_writer(handle);
 	swsusp_close();
 
@@ -1647,6 +1652,7 @@ int swsusp_unmark(void)
 	 * We just returned from suspend, we don't need the image any more.
 	 */
 	free_all_swap_pages(root_swap);
+	put_swap_device_by_type(root_swap);
 
 	return error;
 }
diff --git a/kernel/power/user.c b/kernel/power/user.c
index 4401cfe26e5c..9cb6c24d49ea 100644
--- a/kernel/power/user.c
+++ b/kernel/power/user.c
@@ -90,8 +90,11 @@ static int snapshot_open(struct inode *inode, struct file *filp)
 			data->free_bitmaps = !error;
 		}
 	}
-	if (error)
+	if (error) {
 		hibernate_release();
+		if (data->swap >= 0)
+			put_swap_device_by_type(data->swap);
+	}
 
 	data->frozen = false;
 	data->ready = false;
@@ -115,6 +118,8 @@ static int snapshot_release(struct inode *inode, struct file *filp)
 	data = filp->private_data;
 	data->dev = 0;
 	free_all_swap_pages(data->swap);
+	if (data->swap >= 0)
+		put_swap_device_by_type(data->swap);
 	if (data->frozen) {
 		pm_restore_gfp_mask();
 		free_basic_memory_bitmaps();
@@ -235,6 +240,8 @@ static int snapshot_set_swap_area(struct snapshot_data *data,
 		offset = swap_area.offset;
 	}
 
+	if (data->swap >= 0)
+		put_swap_device_by_type(data->swap);
 	/*
 	 * User space encodes device types as two-byte values,
 	 * so we need to recode them
-- 
2.34.1

