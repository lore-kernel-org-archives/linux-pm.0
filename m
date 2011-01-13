From: "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH] PM / Hibernate: Don't mark pages dirty when
	reading pages while thawing
Date: Thu, 13 Jan 2011 00:59:11 -0500
Message-ID: <1294898351-26156-1-git-send-email-tytso__14958.2277088941$1294898404$gmane$org@mit.edu>
References: <20110113055612.GF13496@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110113055612.GF13496@thunk.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc: linux-pm@lists.linux-foundation.org, Theodore Ts'o <tytso@mit.edu>, Linux Kernel Developers List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Everything was sync'ed before the hibernation, so no pages could be
dirty.  So this causes a lot of wasted I/O activity right after
resuming from hibernation.

Worse, it also causes pages from files that were opened read/only to
be marked writeble which makes them subject to writeback.  This was
discovered when ext4 was changed to so that the jinode pointer was not
initialized unless the file was opened read/write, and this caused
things to blow up.  But that just unmasked a problem, since the pages
belonging to the file in question should have never been marked dirty
in the first place.  It increases the chances the text blocks for
executables like /usr/bin/killall will get corrupted when they are
needlessly written, and of course it means extra write cycles to the
SSD.

Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>
Cc: Sebastian Ott <sebott@linux.vnet.ibm.com>
Cc: linux-pm@lists.linux-foundation.org
---
 kernel/power/block_io.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/kernel/power/block_io.c b/kernel/power/block_io.c
index 83bbc7c..108a4f3 100644
--- a/kernel/power/block_io.c
+++ b/kernel/power/block_io.c
@@ -49,8 +49,6 @@ static int submit(int rw, struct block_device *bdev, sector_t sector,
 	if (bio_chain == NULL) {
 		submit_bio(bio_rw, bio);
 		wait_on_page_locked(page);
-		if (rw == READ)
-			bio_set_pages_dirty(bio);
 		bio_put(bio);
 	} else {
 		if (rw == READ)
-- 
1.7.3.1
