Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B4278F39
	for <linux-pm@vger.kernel.org>; Fri, 20 Mar 2026 00:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773967929; cv=none; b=GvyrlhAVQZidFBzVFhfA9Gsa2/5U7UFpMRcUSlsGpUv6bA+VbO+h5Q6byPGsshdBo7nPQWoLX8onOlG1akhkfWRy8gn1LHhc0VT1KEpDqLXRL31EfzSOtXZASxhQO0nQ30LeKyNwn61PJjZDd9zoYzmti0Fp8K2YSikz9cxtLc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773967929; c=relaxed/simple;
	bh=6zbojOudXdggg9qVMe4xYt6ynrLslbVnlF/4yirnZVY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QeueuANKOBjVrCthX7Exy7gHOoJj7Tt4DNeiyTkM2bXHLdMdQZOOpMK4b55x0iK63VE/JG/gHMK80IoAqoKW3jABWk3pYhQi3bA+JrjhuE9fopPHKcGlAEjPRPWISkFJdaS1oXpYtxDDNwfszPRHHmFCRrlrURVQbc99V82xJ+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UvuUQMon; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UvuUQMon"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2a7a9b8ed69so18705055ad.2
        for <linux-pm@vger.kernel.org>; Thu, 19 Mar 2026 17:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773967927; x=1774572727; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2OLuNnZGT6jZ9snvlA/KM/8SsxaBnz20mK3bQKuVL7g=;
        b=UvuUQMon0HHFWaOEKxy4/4l28kL5jD09N3dRPbi4p0vIsVaXYBRxq62FqQfVwGkFum
         3JKEqdJkJSW9xVh7RRJGk7cCiU+g2dXDF/lKnNY1NPrDgb1HuDbAGZjFBrtlP7ODiUoG
         PiFARQkQ/9Z9zrnXVu2+MjFmlhk5+bNkpz3nLkF6N+h3PRTehoidzuK9c6v1eGHQH7dZ
         wxzqzuskx/NpCYw4Eh6TKd6FfxpftldP7cKw+qOgutKKMYkruCIjB0uappJF2WwNjn+9
         RA6mNiJOUy85P32ML/g3k9WYozlVm7x9XW9u5UHh3MtwxVYFiu+NwxHGR/R4JqMR/qcA
         qYKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773967927; x=1774572727;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2OLuNnZGT6jZ9snvlA/KM/8SsxaBnz20mK3bQKuVL7g=;
        b=hH6gzLadX2HkpcufbPYshhmWi0kxogj4ofgstR8wQqeQc4VVpMAhc+AwhMU2piPXfi
         VQx1xnrVpian+HiYCT7V2xkZVL2IKR+13JvIqqZSAiFNJ/8Mj16x5PxmMz7cyGmKF8He
         LuD8yM3xroyntiDOd94VFn8Md6q3jA1C8axANE5oCw0a17Jp69N4ooKqa9rPjsqsLzzP
         B1j7d5LY3X0TFETqxSje3984/8w3XHoqKhwkV8hYbVkK0pfY3jM0XgAID2d7At+Ov6MH
         36wYuoxn/DFAopRz8T6j8XwsF7MvL0M3DaL6PrjMRGf1dx+tJlRB4EyfA7l70w+SvwQ9
         W/bQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkLR1JN3JZBlsJMVtqNyZ/yqohC6lYQqtMs+rhVeCjKqAUm3kixY9kOY+eNzaby7b8IWO/qFsefA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyPCLSX6PRCBBBcjOpK+shsYeB2PJpGte69iHlT4mzX6NtzscdK
	w0xYOs+mMggkze3ySrji1dJhuWQyQ4towOxAdEr3tHsZ45gjv1AAYjrJ
X-Gm-Gg: ATEYQzweXfIK2AXK+ZS28bfM6oIQkpOUdA8rkUIJgy+7nlypxD5L1zgEf0yAsrULTaq
	+sGL3HSQ24UX7qtQ72o8xDBhDeEVRyZBLog+OhnUeYm8aTZDE54qe5tosCOelfmM+vKLZwAw54g
	MAC+sGRuThShNurUezufS1gDuRRTQBcsgGcDBdfaXw6ZlJkb7hpTOKH8tQYkiT6D1Nyo2q9NE31
	/gNRwBFpVFFfoIeBfmv5XIjXiKltWfWyIv8/IhMJmZKUD8UXodeJUUgUHsXZYT1X46JFEH9r/n0
	rjS6SM17ULQ5lGYOt0EIVYu9K9IVnXXAIy2XqhruPPJQivqsd3xyY+lqX5Bacdj/iwnXC6ggzU5
	ZCN20ZULa+yHRXhBCCaMMv7nZPzcTBRBAln3BPaIYNwgtMgnprshNawA913jEmyjkizsh6OrHN7
	95RdUoCq0h1HG6IlMe0qMakK8rV0Y=
X-Received: by 2002:a17:902:e947:b0:2ae:3a77:a1eb with SMTP id d9443c01a7336-2b0827c3e2cmr10402495ad.39.1773967927029;
        Thu, 19 Mar 2026 17:52:07 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:d::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b083655b45sm4857475ad.42.2026.03.19.17.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 17:52:06 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	miklos@szeredi.hu,
	david@kernel.org,
	therealgraysky@proton.me,
	linux-pm@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v3 1/1] writeback: don't block sync for filesystems with no data integrity guarantees
Date: Thu, 19 Mar 2026 17:51:45 -0700
Message-ID: <20260320005145.2483161-2-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260320005145.2483161-1-joannelkoong@gmail.com>
References: <20260320005145.2483161-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a SB_I_NO_DATA_INTEGRITY superblock flag for filesystems that cannot
guarantee data persistence on sync (eg fuse). For superblocks with this
flag set, sync kicks off writeback of dirty inodes but does not wait
for the flusher threads to complete the writeback.

This replaces the per-inode AS_NO_DATA_INTEGRITY mapping flag added in
commit f9a49aa302a0 ("fs/writeback: skip AS_NO_DATA_INTEGRITY mappings
in wait_sb_inodes()"). The flag belongs at the superblock level because
data integrity is a filesystem-wide property, not a per-inode one.
Having this flag at the superblock level also allows us to skip having
to iterate every dirty inode in wait_sb_inodes() only to skip each inode
individually.

Prior to this commit, mappings with no data integrity guarantees skipped
waiting on writeback completion but still waited on the flusher threads
to finish initiating the writeback. Waiting on the flusher threads is
unnecessary. This commit kicks off writeback but does not wait on the
flusher threads. This change properly addresses a recent report [1] for
a suspend-to-RAM hang seen on fuse-overlayfs that was caused by waiting
on the flusher threads to finish:

Workqueue: pm_fs_sync pm_fs_sync_work_fn
Call Trace:
 <TASK>
 __schedule+0x457/0x1720
 schedule+0x27/0xd0
 wb_wait_for_completion+0x97/0xe0
 sync_inodes_sb+0xf8/0x2e0
 __iterate_supers+0xdc/0x160
 ksys_sync+0x43/0xb0
 pm_fs_sync_work_fn+0x17/0xa0
 process_one_work+0x193/0x350
 worker_thread+0x1a1/0x310
 kthread+0xfc/0x240
 ret_from_fork+0x243/0x280
 ret_from_fork_asm+0x1a/0x30
 </TASK>

On fuse this is problematic because there are paths that may cause the
flusher thread to block (eg if systemd freezes the user session cgroups
first, which freezes the fuse daemon, before invoking the kernel
suspend. The kernel suspend triggers ->write_node() which on fuse issues
a synchronous setattr request, which cannot be processed since the
daemon is frozen. Or if the daemon is buggy and cannot properly complete
writeback, initiating writeback on a dirty folio already under writeback
leads to writeback_get_folio() -> folio_prepare_writeback() ->
unconditional wait on writeback to finish, which will cause a hang).
This commit restores fuse to its prior behavior before tmp folios were
removed, where sync was essentially a no-op.

[1] https://lore.kernel.org/linux-fsdevel/CAJnrk1a-asuvfrbKXbEwwDSctvemF+6zfhdnuzO65Pt8HsFSRw@mail.gmail.com/T/#m632c4648e9cafc4239299887109ebd880ac6c5c1

Fixes: 0c58a97f919c ("fuse: remove tmp folio for writebacks and internal rb tree")
Reported-by: John <therealgraysky@proton.me>
Cc: <stable@vger.kernel.org>
Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fs-writeback.c              | 18 ++++++++++++------
 fs/fuse/file.c                 |  4 +---
 fs/fuse/inode.c                |  1 +
 include/linux/fs/super_types.h |  1 +
 include/linux/pagemap.h        | 11 -----------
 5 files changed, 15 insertions(+), 20 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 7c75ed7e8979..dd6225736721 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -2775,13 +2775,8 @@ static void wait_sb_inodes(struct super_block *sb)
 		 * The mapping can appear untagged while still on-list since we
 		 * do not have the mapping lock. Skip it here, wb completion
 		 * will remove it.
-		 *
-		 * If the mapping does not have data integrity semantics,
-		 * there's no need to wait for the writeout to complete, as the
-		 * mapping cannot guarantee that data is persistently stored.
 		 */
-		if (!mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK) ||
-		    mapping_no_data_integrity(mapping))
+		if (!mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK))
 			continue;
 
 		spin_unlock_irq(&sb->s_inode_wblist_lock);
@@ -2916,6 +2911,17 @@ void sync_inodes_sb(struct super_block *sb)
 	 */
 	if (bdi == &noop_backing_dev_info)
 		return;
+
+	/*
+	 * If the superblock has SB_I_NO_DATA_INTEGRITY set, there's no need to
+	 * wait for the writeout to complete, as the filesystem cannot guarantee
+	 * data persistence on sync. Just kick off writeback and return.
+	 */
+	if (sb->s_iflags & SB_I_NO_DATA_INTEGRITY) {
+		wakeup_flusher_threads_bdi(bdi, WB_REASON_SYNC);
+		return;
+	}
+
 	WARN_ON(!rwsem_is_locked(&sb->s_umount));
 
 	/* protect against inode wb switch, see inode_switch_wbs_work_fn() */
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index a9c836d7f586..f6240f24b814 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -3202,10 +3202,8 @@ void fuse_init_file_inode(struct inode *inode, unsigned int flags)
 
 	inode->i_fop = &fuse_file_operations;
 	inode->i_data.a_ops = &fuse_file_aops;
-	if (fc->writeback_cache) {
+	if (fc->writeback_cache)
 		mapping_set_writeback_may_deadlock_on_reclaim(&inode->i_data);
-		mapping_set_no_data_integrity(&inode->i_data);
-	}
 
 	INIT_LIST_HEAD(&fi->write_files);
 	INIT_LIST_HEAD(&fi->queued_writes);
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index e57b8af06be9..c795abe47a4f 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1709,6 +1709,7 @@ static void fuse_sb_defaults(struct super_block *sb)
 	sb->s_export_op = &fuse_export_operations;
 	sb->s_iflags |= SB_I_IMA_UNVERIFIABLE_SIGNATURE;
 	sb->s_iflags |= SB_I_NOIDMAP;
+	sb->s_iflags |= SB_I_NO_DATA_INTEGRITY;
 	if (sb->s_user_ns != &init_user_ns)
 		sb->s_iflags |= SB_I_UNTRUSTED_MOUNTER;
 	sb->s_flags &= ~(SB_NOSEC | SB_I_VERSION);
diff --git a/include/linux/fs/super_types.h b/include/linux/fs/super_types.h
index fa7638b81246..383050e7fdf5 100644
--- a/include/linux/fs/super_types.h
+++ b/include/linux/fs/super_types.h
@@ -338,5 +338,6 @@ struct super_block {
 #define SB_I_NOUMASK	0x00001000	/* VFS does not apply umask */
 #define SB_I_NOIDMAP	0x00002000	/* No idmapped mounts on this superblock */
 #define SB_I_ALLOW_HSM	0x00004000	/* Allow HSM events on this superblock */
+#define SB_I_NO_DATA_INTEGRITY	0x00008000 /* fs cannot guarantee data persistence on sync */
 
 #endif /* _LINUX_FS_SUPER_TYPES_H */
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index ec442af3f886..31a848485ad9 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -210,7 +210,6 @@ enum mapping_flags {
 	AS_WRITEBACK_MAY_DEADLOCK_ON_RECLAIM = 9,
 	AS_KERNEL_FILE = 10,	/* mapping for a fake kernel file that shouldn't
 				   account usage to user cgroups */
-	AS_NO_DATA_INTEGRITY = 11, /* no data integrity guarantees */
 	/* Bits 16-25 are used for FOLIO_ORDER */
 	AS_FOLIO_ORDER_BITS = 5,
 	AS_FOLIO_ORDER_MIN = 16,
@@ -346,16 +345,6 @@ static inline bool mapping_writeback_may_deadlock_on_reclaim(const struct addres
 	return test_bit(AS_WRITEBACK_MAY_DEADLOCK_ON_RECLAIM, &mapping->flags);
 }
 
-static inline void mapping_set_no_data_integrity(struct address_space *mapping)
-{
-	set_bit(AS_NO_DATA_INTEGRITY, &mapping->flags);
-}
-
-static inline bool mapping_no_data_integrity(const struct address_space *mapping)
-{
-	return test_bit(AS_NO_DATA_INTEGRITY, &mapping->flags);
-}
-
 static inline gfp_t mapping_gfp_mask(const struct address_space *mapping)
 {
 	return mapping->gfp_mask;
-- 
2.52.0

