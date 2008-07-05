From: Akinobu Mita <akinobu.mita@gmail.com>
Subject: [PATCH 1/2] swsusp: simplify memory_bm_find_bit()
Date: Sat, 5 Jul 2008 20:10:10 +0900
Message-ID: <20080705110946.GA17071__47822.3767866895$1215440896$gmane$org@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org
Cc: Pavel Machek <pavel@suse.cz>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

The bit obtained by the function memory_bm_find_bit() is represented
by addr and bit_nr. The callers of memory_bm_find_bit() just use addr
and bit_nr as the arguments of set_bit/clear_bit/test_bit.

This patch simplifies the representation of the obtained bit without
using BM_BITS_PER_CHUNK.

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Cc: Pavel Machek <pavel@suse.cz>
Cc: Rafael J. Wysocki <rjw@sisk.pl>
Cc: linux-pm@lists.linux-foundation.org
---
 kernel/power/snapshot.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: 2.6-git/kernel/power/snapshot.c
===================================================================
--- 2.6-git.orig/kernel/power/snapshot.c
+++ 2.6-git/kernel/power/snapshot.c
@@ -478,8 +478,8 @@ static int memory_bm_find_bit(struct mem
 	}
 	zone_bm->cur_block = bb;
 	pfn -= bb->start_pfn;
-	*bit_nr = pfn % BM_BITS_PER_CHUNK;
-	*addr = bb->data + pfn / BM_BITS_PER_CHUNK;
+	*bit_nr = pfn;
+	*addr = bb->data;
 	return 0;
 }
 
