Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCCF2248B3
	for <linux-pm@vger.kernel.org>; Thu, 19 Mar 2026 19:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773949650; cv=none; b=Ayfd5OwZdeVbt3CH1iswWvDL28R/3GddYkquZTMkkB0/5I5Csjuyeuf3p+a7g31r0JHhFblKKYyVK59G3o6kw/kM8d5CEsxisqz8PZB8+lXoc0IxElk1bdGbc/2DRpVZRDQca2FSkdWIu5vtdseoDfeVzWrEUO0iEMDIq2tNRB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773949650; c=relaxed/simple;
	bh=9rYMIWh8GjEA1YfHQq4b/h1XvmB5D3QXVHpi7exWYfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hLsjn08PX/Z3Z5simDipM0K5sEye3zx9bIum4G4qzbXdQP8/PygAQ2blkU86ZTV9x8uE+C/33OsqLMnVfDLDbobDp5tiPaKTeyslaM0RfBL9h/74zfU3SgAz6/o1jRmv3BDCLnyyUrRSzIk48nBm0VQe1WLfv617rDtjQHJX8Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hGDokw0O; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hGDokw0O"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-35b9d29480aso1111983a91.1
        for <linux-pm@vger.kernel.org>; Thu, 19 Mar 2026 12:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773949648; x=1774554448; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xO6S9BQH7HFJ5MqOMQCImyt8X8APmhg6RtZHuLbfJK8=;
        b=hGDokw0OcxTRQkuiUmdCvukueU6uDn4f1Z6phsnrLL0K/MsrX/bgouRjSQLI2SGnv0
         Ss5xNXNkoNulOWkCYnNtoYngVqLkaj1FcwZMC2l0hdz3pIagjfrHphjojONn5djn4qFE
         dbJEqN/QaDBOoUNQdWcaF5YfSr3iaw/QsWs7NR18h0GG5BUCJJRhyE0NuzItgAZS9FL3
         QkWoXc5+OQ0+zXh5E9ys8w/h+1rLOQRyCmh8OF7wTuxOv+tgTAns4NFKR/RVI3kONkdA
         +J5M/FxefyWWa17RnDPInLZ8L0Ab/dpzj3lhm4qdwcgasCKTJkRNLd+19b5lLW73l8zJ
         bseg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773949648; x=1774554448;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xO6S9BQH7HFJ5MqOMQCImyt8X8APmhg6RtZHuLbfJK8=;
        b=b16QEpJ4TssFfzmRH9KU/sz1KNVtG+VCpLjuTuBJzOyczDcKvawHCRS+hzyImPBd02
         y/nJvVz6XzP1dh31j1h5STw6m82lK0pkRpVfVd1DDJVFl2VsqZy1tQeqmT3Q6xWuESkE
         W1YOyoKbWqrDe/Lf1mf/C8KHTFJQC4cZENl126kul+DwDEQZzp/sT0fD+0fsuXx+H+NU
         nlt/v0FfsH6thKVN/Q9B3XGNXKocYjEkeUgp5LWswsIP3On8IvIf1Q2++YPKncdzpy0q
         yF8zuVTmj2IYJGFF2ia5lImj7y/BecTkynok1h19/wdOR0lz+vRYphJO6vyprLE/G8xw
         /rKw==
X-Forwarded-Encrypted: i=1; AJvYcCXRgH6GZ9N2K71C8cMVDH1ToEtaL5sN8ThkL0D7XRSdFr3lDOLMawuZKzbWXZ2Vr2yOTk3k8LcbWw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzwLadGQ8FGa0Ye64/2eVBe6HIBUkW1tT29gXf6vXiJHkmjeVVx
	qDP120LIdCC7eawExRbFExpZjsC8GZxwMS8S1z1LDa/MKtswddCUA6L4
X-Gm-Gg: ATEYQzxBJdjZuTcs3yGoLwjJAhHNlWkfsRCUj6dF/n3hs1v+xMhBn4HNVboZyNCmCSo
	Tvaw8gP0jR5v8Vr1bbsmZHWVbqBZIru1UObeud333wejEzsSpe9bNYSzVMTopeXZ/QXf1Iin4wl
	pgCLeSIuDzCX2O+Cofosmf1wDaqCgoYS8G03h0FW8hyLUXrscKJif04Y7ydM6/wZCPxYDnLf5Y1
	2H8UJYTn7C+bbNykPjlTFijYW3+0H48jFYpePwf371vH7IxxqWKyBFSmsW5LVMAopoHRcIGr0//
	/YX6XFVbCf4c/6QRoqgIwXB39lreX7wCUWkwxoud0SdiBoQHcj9WZNoWdMfgO8I8vAGstP+u2Wj
	g71mbd6W3e+Jhq2mnaMKTscrkbUlgsqN3HLuv8EQlBUl/if7q+IHI0dUp9xiJu1dNweoMgv2sNZ
	ai7D4pAnajQbhW0TwCLg==
X-Received: by 2002:a17:90b:554e:b0:35b:9ab6:1d65 with SMTP id 98e67ed59e1d1-35bd2d52dc5mr257287a91.25.1773949648149;
        Thu, 19 Mar 2026 12:47:28 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:13::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bd25fb8fbsm82204a91.1.2026.03.19.12.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 12:47:27 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	miklos@szeredi.hu,
	david@kernel.org,
	therealgraysky@proton.me,
	linux-pm@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 1/1] writeback: don't block sync(2) for filesystems with no data integrity guarantees
Date: Thu, 19 Mar 2026 12:45:40 -0700
Message-ID: <20260319194540.3463371-2-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260319194540.3463371-1-joannelkoong@gmail.com>
References: <20260319194540.3463371-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a SB_I_NO_DATA_INTEGRITY superblock flag for filesystems that cannot
guarantee data persistence on sync (eg fuse). For superblocks with this
flag set, sync(2) kicks off writeback of dirty inodes but does not wait
for the flusher threads to complete the writeback.

This replaces the per-inode AS_NO_DATA_INTEGRITY mapping flag added in
commit f9a49aa302a0 ("fs/writeback: skip AS_NO_DATA_INTEGRITY mappings
in wait_sb_inodes()"). The flag belongs at the superblock level because
data integrity is a filesystem-wide property, not a per-inode one.
Having this flag at the superblock level allows us to skip the logic in
sync_inodes_sb() entirely, rather than iterating every dirty inode in
wait_sb_inodes() only to skip each inode individually.

This also addresses a recent report [1] for a suspend-to-RAM hang seen
on fuse-overlayfs:

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

Prior to this commit, mappings with no data integrity guarantees skipped
waiting on writeback completion but it still waited on the flusher
threads to finish initiating the writeback. On fuse this is problematic
because even though the writeback requests are non-blocking background
requests, there are still paths that may cause the flusher thread to
block (eg if systemd freezes the user session cgroups first, which
freezes the fuse daemon, before invoking the kernel suspend. The kernel
suspend triggers ->write_node() which on fuse issues a synchronous
setattr request, which cannot be processed since daemon is frozen. Or
another example, if the daemon is buggy and does not properly complete
writeback, initiating writeback on a dirty folio already under writeback
leads to writeback_get_folio() -> folio_prepare_writeback() ->
unconditional wait on writeback to finish which will cause a hang). This
commit restores fuse to its prior behavior before tmp folios were
removed, where sync was essentially a no-op.

[1] https://lore.kernel.org/linux-fsdevel/CAJnrk1a-asuvfrbKXbEwwDSctvemF+6zfhdnuzO65Pt8HsFSRw@mail.gmail.com/T/#m632c4648e9cafc4239299887109ebd880ac6c5c1

Fixes: 0c58a97f919c ("fuse: remove tmp folio for writebacks and internal rb tree")
Reported-by: John <therealgraysky@proton.me>
Cc: <stable@vger.kernel.org>
Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fs-writeback.c              |  7 +------
 fs/fuse/file.c                 |  4 +---
 fs/fuse/inode.c                |  1 +
 fs/sync.c                      |  7 ++++++-
 include/linux/fs/super_types.h |  1 +
 include/linux/pagemap.h        | 11 -----------
 6 files changed, 10 insertions(+), 21 deletions(-)

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
index 942a60cfedfb..aedbf723830a 100644
--- a/fs/sync.c
+++ b/fs/sync.c
@@ -73,7 +73,12 @@ EXPORT_SYMBOL(sync_filesystem);
 
 static void sync_inodes_one_sb(struct super_block *sb, void *arg)
 {
-	if (!sb_rdonly(sb))
+	if (sb_rdonly(sb))
+		return;
+
+	if (sb->s_iflags & SB_I_NO_DATA_INTEGRITY)
+		wakeup_flusher_threads_bdi(sb->s_bdi, WB_REASON_SYNC);
+	else
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

