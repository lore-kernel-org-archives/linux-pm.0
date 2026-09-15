Received: from lgeamrelo07.lge.com (lgeamrelo07.lge.com [156.147.51.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1623D4132
	for <linux-pm@vger.kernel.org>; Tue, 15 Sep 2026 03:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.147.51.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789442234; cv=none; b=EGZhli8o0ii++ulPYCVFKss2qTDPZHEHYrQmHGBabKEXwWhWE5wbR7vQ3CdsVXarcc/9Pmc6VZjHqvIc1htxEprC2aRn84FYTEjoAPI6cSW6o03mndY9Pxxlxm33cxVSpXgn74ssXvbcFaSb3L+n5hAdWUvYVuCo2c7Ygbz0Fvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789442234; c=relaxed/simple;
	bh=5EkV6x5BykyvFt/g2bYUIcDRIwmp/MSRf0K52EQSBhw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JLqycWb9FBkW0Q9JBJKxj92mRy/9v7Lq7hNlvQrAeg9QraURsBar1cbi+Hxd+gW3EzHRkF+xR1z2bg31KO8riWij8v+naA2AQzfxh5wYafODq9TdpvzwqwetV97i2GCx2qO5ET09NAfokBTiuSzGwqAwCiYavZcNj9RHXnWMJOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.51.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO yjaykim-PowerEdge-T330.lge.net) (10.177.112.156)
	by 156.147.51.103 with ESMTP; 15 Sep 2026 12:17:08 +0900
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
Subject: [RFC PATCH 09/10] PM: hibernate: tell swap how much space an image needs
Date: Tue, 15 Sep 2026 12:16:57 +0900
Message-Id: <20260915031658.1505680-10-youngjun.park@lge.com>
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

Swap has no way to ask how big a hibernation image gets.  Add
hibernate=reserve[:<size>] and hibernation_reserve_pages(), which swap
can call at swapon to learn how much space to hold back.

The answer is <size>, or image_size when no size is given.  It is zero
without hibernate=reserve and for any area other than the one named by
resume=.  The image can still outgrow it.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Youngjun Park <youngjun.park@lge.com>
---
 .../admin-guide/kernel-parameters.txt         |  8 ++++++
 include/linux/suspend.h                       |  3 +++
 kernel/power/hibernate.c                      | 26 +++++++++++++++++++
 3 files changed, 37 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 68647ff4bdd2..eb2454b73f4b 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1980,6 +1980,14 @@ Kernel parameters
 		protect_image	Turn on image protection during restoration
 				(that will set all pages holding image data
 				during restoration read-only).
+		reserve[:<size>]
+				Hold <size> of swap back for the image when the
+				area named by resume= and resume_offset= is
+				swapped on.  Swap cannot use that space.
+				Without <size>, /sys/power/image_size is used.
+				<size> takes K, M or G.  More than half of the
+				area is refused.  Later changes take effect at
+				the next swapon.
 
 	hibernate.compressor= 	[HIBERNATION] Compression algorithm to be
 				used with hibernation.
diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index b02876f1ae38..1fb1f5d6ce6a 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -393,6 +393,7 @@ extern void hibernation_set_ops(const struct platform_hibernation_ops *ops);
 extern int hibernate(void);
 extern bool system_entering_hibernation(void);
 extern bool hibernation_available(void);
+unsigned long hibernation_reserve_pages(dev_t dev, sector_t offset);
 asmlinkage int swsusp_save(void);
 extern struct pbe *restore_pblist;
 int pfn_is_nosave(unsigned long pfn);
@@ -412,6 +413,8 @@ static inline void hibernation_set_ops(const struct platform_hibernation_ops *op
 static inline int hibernate(void) { return -ENOSYS; }
 static inline bool system_entering_hibernation(void) { return false; }
 static inline bool hibernation_available(void) { return false; }
+static inline unsigned long hibernation_reserve_pages(dev_t dev, sector_t offset)
+{ return 0; }
 
 static inline int hibernate_quiet_exec(int (*func)(void *data), void *data) {
 	return -ENOTSUPP;
diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index 907d791b85ad..225fe55ee703 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -41,6 +41,8 @@
 static int nocompress;
 static int noresume;
 static int nohibernate;
+static int reserve_swap;
+static unsigned long reserve_size;
 static int resume_wait;
 static unsigned int resume_delay;
 static char resume_file[256] = CONFIG_PM_STD_PARTITION;
@@ -113,6 +115,26 @@ bool hibernation_available(void)
 		!secretmem_active() && !cxl_mem_active();
 }
 
+/**
+ * hibernation_reserve_pages - How much swap to hold back for an image.
+ * @dev: the block device the swap area lives on.
+ * @offset: the first block of the swap area on that device.
+ *
+ * Only the area named by resume= and resume_offset= holds anything back.
+ * The image can still grow past this amount.
+ *
+ * Return: the number of pages to hold back, or zero when nothing should be.
+ */
+unsigned long hibernation_reserve_pages(dev_t dev, sector_t offset)
+{
+	if (!reserve_swap || !hibernation_available())
+		return 0;
+	if (!dev || dev != swsusp_resume_device || offset != swsusp_resume_block)
+		return 0;
+
+	return DIV_ROUND_UP(reserve_size ? reserve_size : image_size, PAGE_SIZE);
+}
+
 /**
  * hibernation_set_ops - Set the global hibernate operations.
  * @ops: Hibernation operations to use in subsequent hibernation transitions.
@@ -1437,6 +1459,10 @@ static int __init hibernate_setup(char *str)
 	} else if (IS_ENABLED(CONFIG_STRICT_KERNEL_RWX)
 		   && !strncmp(str, "protect_image", 13)) {
 		enable_restore_image_protection();
+	} else if (!strncmp(str, "reserve", 7)) {
+		reserve_swap = 1;
+		if (str[7] == ':')
+			reserve_size = memparse(str + 8, NULL);
 	}
 	return 1;
 }
-- 
2.48.1

