From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: [PATCH -next] power: fix block_io.c printk warning
Date: Mon, 3 May 2010 10:06:11 -0700
Message-ID: <20100503100611.2ca63b58.randy.dunlap__577.721189665858$1272906525$gmane$org@oracle.com>
References: <20100503151619.f75e3a80.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100503151619.f75e3a80.sfr@canb.auug.org.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Stephen Rothwell <sfr@canb.auug.org.au>, "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@lists.linux-foundation.org, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Randy Dunlap <randy.dunlap@oracle.com>

Fix printk format warning in block_io.c:

kernel/power/block_io.c:41: warning: format '%ld' expects type 'long int', but argument 2 has type 'sector_t'

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
---
 kernel/power/block_io.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20100503.orig/kernel/power/block_io.c
+++ linux-next-20100503/kernel/power/block_io.c
@@ -37,8 +37,8 @@ static int submit(int rw, struct block_d
 	bio->bi_end_io = end_swap_bio_read;
 
 	if (bio_add_page(bio, page, PAGE_SIZE, 0) < PAGE_SIZE) {
-		printk(KERN_ERR "PM: Adding page to bio failed at %ld\n",
-			sector);
+		printk(KERN_ERR "PM: Adding page to bio failed at %llu\n",
+			(unsigned long long)sector);
 		bio_put(bio);
 		return -EFAULT;
 	}
