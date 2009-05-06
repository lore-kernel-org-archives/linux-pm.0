From: Nigel Cunningham <nigel@tuxonice.net>
Subject: [PATCH 3/19] TuxOnIce: Make drop_pagecache non-static
	and declared in mm.h
Date: Thu,  7 May 2009 00:38:59 +1000
Message-ID: <1241620755-22133-4-git-send-email-nigel__27532.7650284909$1241621187$gmane$org@tuxonice.net>
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

Make the drop_pagecache function non-static, so that TuxOnIce can
provide users with the option to drop caches and save whatever is left
over.

Signed-off-by: Nigel Cunningham <nigel@tuxonice.net>
---
 fs/drop_caches.c   |    2 +-
 include/linux/mm.h |    1 +
 2 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/fs/drop_caches.c b/fs/drop_caches.c
index b6a719a..e2f2799 100644
--- a/fs/drop_caches.c
+++ b/fs/drop_caches.c
@@ -33,7 +33,7 @@ static void drop_pagecache_sb(struct super_block *sb)
 	iput(toput_inode);
 }
 
-static void drop_pagecache(void)
+void drop_pagecache(void)
 {
 	struct super_block *sb;
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 3daeccb..c4199cd 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1298,6 +1298,7 @@ int drop_caches_sysctl_handler(struct ctl_table *, int, struct file *,
 					void __user *, size_t *, loff_t *);
 unsigned long shrink_slab(unsigned long scanned, gfp_t gfp_mask,
 			unsigned long lru_pages);
+void drop_pagecache(void);
 
 #ifndef CONFIG_MMU
 #define randomize_va_space 0
-- 
1.5.6.3
