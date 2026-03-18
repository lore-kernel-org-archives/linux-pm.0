Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A6733F8C3
	for <linux-pm@vger.kernel.org>; Wed, 18 Mar 2026 22:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773874621; cv=none; b=IJr0pRdCgOANURuAG93rFZPIuYMzV4aSIQxsJSyohRBsSHnbWP/hYTftJKVEhPUG/JqbI/jQ4pC04tQ3aBVCa0y6TyjKLSqVHAEhX1H15BKVFpTmtQnxrW+toawCd5ekvZoD1gE/Ntx8c++9xNi87KxrEdZ11pNb6yMkU0fSVjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773874621; c=relaxed/simple;
	bh=SPLJ9nNUjm9HSYNFTzMwmPez99Lb3AJh/1FtHbtn35c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fMx6TbYLYjv7kt4aQqnFiulW0a6N7okIOKLYP+K03KemXjiz6hkvNoBsGCF1oMeInmVrZDzinAvNp5isVYZW5hvtgYjEcB85Y9PK5s+VRyQx2tzXgwJ9e3u9RnJ9/otk5Bo2cXyxqoEtmJl/JnXzf/YCZ0p9rxalxF1K8sIFyog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZVv3/zpc; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZVv3/zpc"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-35ba749f441so412476a91.1
        for <linux-pm@vger.kernel.org>; Wed, 18 Mar 2026 15:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773874619; x=1774479419; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kGOaEfwR0VKXIUy5Es+FlNcpkueXyVGIUtV2XCMOFns=;
        b=ZVv3/zpcADm6gWieK83SDsb2pxMI18sTz8E+ucPjSYpc51Zhs62q0J8wfljn0ZE9X6
         1WfUkzInTnolQqY64J38cVbyoerTELZyuvJFHTjydDWgEuWGwLaGGJmwApENua/Q4R4m
         lCJgMEgD/3v5HZPnqz1hoiC0y8DdegluPxwHsgxwdVSTiJN0cBIiaEPl0Y2IJ5yH4Eos
         yPORtn6XH523xHCc6+Xm3fZ3DhtZ03ZAUTeTo1IlV2kj48uviSGDhdUNvxvXYuTAiU7o
         IC3dPtG1GIEBCd9R5caRw3Bjz4HZLeUYjK2TedHQjEfjYIlihqphi6E1kEvvo/Xhx0JF
         hjBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773874619; x=1774479419;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kGOaEfwR0VKXIUy5Es+FlNcpkueXyVGIUtV2XCMOFns=;
        b=A3FopOjFEpXE3ZmIVnWuVRch3x5q2KKFzrZ1VM4nAjHawoiuxo68eJO9s3ANIBkG/9
         2uCJRrGwqX9e0/4glxIvWT8wpSLtJyX+fRKJkonQLAoJmxqJ54Gi1NBbOGVUA0zHXgjZ
         ZDpJI7Y0uVZnP6PK43s98B19eCawTUXaNEXD/BK4uV9kfu09BFLV66ZXBnYP1Tlv7NG1
         HHYSgVbya0UghJCQ6KBmS1fRJaqB+oGzE4gNK516ouyR/f2hneBp8YAolFqRtcm2mZxd
         W/MBhu0NQC/UXJV3RaIoCtw9MRlAZyVrI/27IG5hAVB99qLoeRyfYvSGCBt4HA+/tUyX
         sKCA==
X-Forwarded-Encrypted: i=1; AJvYcCWcG3Jeak6VZ1F41Y/G28G0/gS4KeFwX77DIYXhuJxYwYgFYgwqVXLgAEXPiDiV8m70ZpYGFJRf3Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0p1Vigu9EiXVJ4kHQpgy7F+kzOvrJWffqyz2P6IIMddQn0/j+
	Bkv4Y8hYjbnU7GZEjRwsKjGcunCfPXjdSmFWU8rE68dgiGybDOnZCh+7
X-Gm-Gg: ATEYQzyrpPqN2xaljcbybHmvXAYqclMROwCKtwyVMJPfRPr9cEE1XvNnbhLW4uROEVK
	Ml1iQ+LhDmd8iIb+tNXrmvT6nKcC8OmKwAREcz9dmfFGCHMjGKy0qQk3wu4m9ucFKs7odV4FkYz
	CZfw3cdui2tXYE3KcX/am1jqtT4f0xQh81HFMjFMYEweEgXD/TNgJKdOldHcvwRok8sYJG/9L+B
	WzfKhVlo+64fNX5nyjdd3Nj3XpNIYt6Dvlv9Qqg4mxsXQOoZr3PE/d6jtF6IJThEc1ODM9eXYLU
	rJ4W9kmFGZlMFkjMHW2IP3ShQ9quQOAKLx57NELm+0dDhukrB++BCr7Pka38tMg3JN6RdOA8fnF
	m9OIszFUt2VbvBhdAHvnQHfE4lFp2vysiPmygBpbjUuquzpA/eym9whOPTy5u0VxwnuNqyPw9XN
	6zauRQmWVHiu3Pf+tcG9zT3gNT+xj3
X-Received: by 2002:a17:90b:288c:b0:359:f3b1:6811 with SMTP id 98e67ed59e1d1-35bb9e3cff6mr3959828a91.1.1773874618907;
        Wed, 18 Mar 2026 15:56:58 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:4a::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c741e0da7a6sm3506854a12.13.2026.03.18.15.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 15:56:58 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	miklos@szeredi.hu,
	david@kernel.org,
	therealgraysky@proton.me,
	linux-pm@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v1] writeback: skip sync(2) inode writeback for filesystems with no data integrity guarantees
Date: Wed, 18 Mar 2026 15:56:04 -0700
Message-ID: <20260318225604.71545-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add SB_I_NO_DATA_INTEGRITY superblock flag for filesystems that cannot
guarantee data persistence on sync (eg fuse) and skip sync(2) inode
writeback for superblocks with this flag set.

There was a recent report [1] for a suspend-to-RAM hang on fuse-overlayfs with
firefox + youtube in wb_wait_for_completion() from the pm_fs_sync_work_fn()
path:

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

This can happen in two ways:
a) systemd freezes the user session cgroups first (which freezes the fuse daemon)
before invoking the kernel suspend. The suspend triggers the wb_workfn() ->
write_inode() path, where fuse issues a synchronous setattr request to the
frozen daemon, which cannot process the request
b) if a dirty folio is already under writeback and needs to have writeback
issued again, in writeback_get_folio() -> folio_prepare_writeback(), we
unconditionally wait on writeback to finish, but for buggy/faulty fuse
servers, the request may never be processed

The correct fix is for sync(2) to skip the sync_inodes_sb() path entirely for
any filesystems that do not have data integrity guarantees.

A prior commit (commit f9a49aa302a0 ("fs/writeback: skip AS_NO_DATA_INTEGRITY
mappings in wait_sb_inodes()")) added the AS_NO_DATA_INTEGRITY mapping flag to
skip sync(2) waits for mappings without data integrity semantics, but it still
allowed wb_workfn() worker threads to be kicked off for the writeback.

This patch improves upon that by replacing the per-inode AS_NO_DATA_INTEGRITY
mapping flag with a flag at the superblock level, and using that superblock
flag to skip the sync_inodes_sb() path entirely if there are no data integrity
guarantees. The flag belongs at the superblock level because data integrity is
a filesystem-wide property, not a per-inode one. Having the flag at the
superblock level allows sync_inodes_one_sb() to skip the entire filesystem
efficiently, rather than iterating every dirty inode only to skip each one
individually.

This patch restores fuse to its prior behavior before tmp folios were removed,
where sync was essentially a no-op.

[1] https://lore.kernel.org/linux-fsdevel/CAJnrk1a-asuvfrbKXbEwwDSctvemF+6zfhdnuzO65Pt8HsFSRw@mail.gmail.com/T/#m632c4648e9cafc4239299887109ebd880ac6c5c1

Fixes: 0c58a97f919c ("fuse: remove tmp folio for writebacks and internal rb tree")
Reported-by: John <therealgraysky@proton.me>
Tested-by: John <therealgraysky@proton.me>
Cc: <stable@vger.kernel.org>
Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fs-writeback.c              |  7 +------
 fs/fuse/file.c                 |  4 +---
 fs/fuse/inode.c                |  1 +
 fs/sync.c                      |  2 +-
 include/linux/fs/super_types.h |  1 +
 include/linux/pagemap.h        | 11 -----------
 6 files changed, 5 insertions(+), 21 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 7c75ed7e8979..154249e4e5ce 100644
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
diff --git a/fs/sync.c b/fs/sync.c
index 942a60cfedfb..88c08e2f76b2 100644
--- a/fs/sync.c
+++ b/fs/sync.c
@@ -73,7 +73,7 @@ EXPORT_SYMBOL(sync_filesystem);
 
 static void sync_inodes_one_sb(struct super_block *sb, void *arg)
 {
-	if (!sb_rdonly(sb))
+	if (!sb_rdonly(sb) && !(sb->s_iflags & SB_I_NO_DATA_INTEGRITY))
 		sync_inodes_sb(sb);
 }
 
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

