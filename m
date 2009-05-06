From: Nigel Cunningham <nigel@tuxonice.net>
Subject: [PATCH 2/19] TuxOnIce: GEMS support.
Date: Thu,  7 May 2009 00:38:58 +1000
Message-ID: <1241620755-22133-3-git-send-email-nigel__46982.8827809126$1241621222$gmane$org@tuxonice.net>
References: <1241620755-22133-1-git-send-email-nigel@tuxonice.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1241620755-22133-1-git-send-email-nigel@tuxonice.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, tuxonice-devel@lists.tuxonice.net
List-Id: linux-pm@vger.kernel.org

This patch adds support for finding pages on the LRU being used by GEMS,
so that TuxOnIce can ensure they're atomically copied rather than being
saved prior to the atomic copy like most other LRU pages.

Signed-off-by: Nigel Cunningham <nigel@tuxonice.net>
---
 drivers/gpu/drm/drm_gem.c |    3 ++-
 include/linux/fs.h        |    2 ++
 include/linux/mm.h        |    1 +
 mm/shmem.c                |    2 ++
 4 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
index 4984aa8..c69b548 100644
--- a/drivers/gpu/drm/drm_gem.c
+++ b/drivers/gpu/drm/drm_gem.c
@@ -136,7 +136,8 @@ drm_gem_object_alloc(struct drm_device *dev, size_t size)
 	obj = kcalloc(1, sizeof(*obj), GFP_KERNEL);
 
 	obj->dev = dev;
-	obj->filp = shmem_file_setup("drm mm object", size, VM_NORESERVE);
+	obj->filp = shmem_file_setup("drm mm object", size,
+			VM_NORESERVE | VM_ATOMIC_COPY);
 	if (IS_ERR(obj->filp)) {
 		kfree(obj);
 		return NULL;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 5bed436..344b1ca 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -231,6 +231,8 @@ struct inodes_stat_t {
 #define S_NOCMTIME	128	/* Do not update file c/mtime */
 #define S_SWAPFILE	256	/* Do not truncate: swapon got its bmaps */
 #define S_PRIVATE	512	/* Inode is fs-internal */
+#define S_ATOMIC_COPY	1024	/* Pages mapped with this inode need to be
+				   atomically copied (gem) */
 
 /*
  * Note that nosuid etc flags are inode-specific: setting some file-system
diff --git a/include/linux/mm.h b/include/linux/mm.h
index bff1f0d..3daeccb 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -105,6 +105,7 @@ extern unsigned int kobjsize(const void *objp);
 #define VM_MIXEDMAP	0x10000000	/* Can contain "struct page" and pure PFN pages */
 #define VM_SAO		0x20000000	/* Strong Access Ordering (powerpc) */
 #define VM_PFN_AT_MMAP	0x40000000	/* PFNMAP vma that is fully mapped at mmap time */
+#define VM_ATOMIC_COPY	0x80000000	/* TuxOnIce should atomically copy */
 
 #ifndef VM_STACK_DEFAULT_FLAGS		/* arch can override this */
 #define VM_STACK_DEFAULT_FLAGS VM_DATA_DEFAULT_FLAGS
diff --git a/mm/shmem.c b/mm/shmem.c
index b25f95c..4908d20 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1557,6 +1557,8 @@ static struct inode *shmem_get_inode(struct super_block *sb, int mode,
 		memset(info, 0, (char *)inode - (char *)info);
 		spin_lock_init(&info->lock);
 		info->flags = flags & VM_NORESERVE;
+		if (flags & VM_ATOMIC_COPY)
+			inode->i_flags |= S_ATOMIC_COPY;
 		INIT_LIST_HEAD(&info->swaplist);
 
 		switch (mode & S_IFMT) {
-- 
1.5.6.3
