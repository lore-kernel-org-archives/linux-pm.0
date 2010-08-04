From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH RESEND block#for-2.6.36] block_dev: always
 serialize exclusive open attempts
Date: Wed, 04 Aug 2010 17:59:39 +0200
Message-ID: <4C598E6B.7050405__41443.5142688037$1280937696$gmane$org@gmail.com>
References: <2dWFdr9kTFM.A.P0D.spXVMB@chimera>
	<AANLkTimcH7+Bq1UEbaSU7SQpzArPgmSLegiqE13V8=CF@mail.gmail.com>
	<4C56F30D.3020304@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4C56F30D.3020304@kernel.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jens Axboe <jaxboe@fusionio.com>
Cc: Linux SCSI List <linux-scsi@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, Linux Wireless List <linux-wireless@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, DRI <dri-devel@lists.freedesktop.org>, stable@kernel.org, Linux ACPI <linux-acpi@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Kernel Testers List <kernel-testers@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Linux PM List <linux-pm@lists.linux-foundation.org>, Maciej Rutecki <maciej.rutecki@gmail.com>
List-Id: linux-pm@vger.kernel.org

bd_prepare_to_claim() incorrectly allowed multiple attempts for
exclusive open to progress in parallel if the attempting holders are
identical.  This triggered BUG_ON() as reported in the following bug.

  https://bugzilla.kernel.org/show_bug.cgi?id=16393

__bd_abort_claiming() is used to finish claiming blocks and doesn't
work if multiple openers are inside a claiming block.  Allowing
multiple parallel open attempts to continue doesn't gain anything as
those are serialized down in the call chain anyway.  Fix it by always
allowing only single open attempt in a claiming block.

This problem can easily be reproduced by adding a delay after
bd_prepare_to_claim() and attempting to mount two partitions of a
disk.

stable: only applicable to v2.6.35

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: Markus Trippelsdorf <markus@trippelsdorf.de>
Cc: stable@kernel.org
---
Oops, had the wrong reported-by credit.  Updated.

Thanks.

 fs/block_dev.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 99d6af8..b3171fb 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -681,8 +681,8 @@ retry:
 	if (!bd_may_claim(bdev, whole, holder))
 		return -EBUSY;

-	/* if someone else is claiming, wait for it to finish */
-	if (whole->bd_claiming && whole->bd_claiming != holder) {
+	/* if claiming is already in progress, wait for it to finish */
+	if (whole->bd_claiming) {
 		wait_queue_head_t *wq = bit_waitqueue(&whole->bd_claiming, 0);
 		DEFINE_WAIT(wait);
