From: Ming Lei <tom.leiming@gmail.com>
Subject: [PATCH 17/60] kernel/power/swap.c: comment on direct access to bvec table
Date: Sat, 29 Oct 2016 16:08:16 +0800
Message-ID: <1477728600-12938-18-git-send-email-tom.leiming@gmail.com>
References: <1477728600-12938-1-git-send-email-tom.leiming@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36280 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S941020AbcJ2INK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 29 Oct 2016 04:13:10 -0400
In-Reply-To: <1477728600-12938-1-git-send-email-tom.leiming@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jens Axboe <axboe@fb.com>, linux-kernel@vger.kernel.org
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Ming Lei <tom.leiming@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, "open list:HIBERNATION aka Software Suspend,
        aka swsusp" <linux-pm@vger.kernel.org>

Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 kernel/power/swap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index a3b1e617bcdc..8bc13a4461bc 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -238,6 +238,8 @@ static void hib_init_batch(struct hib_bio_batch *hb)
 static void hib_end_io(struct bio *bio)
 {
 	struct hib_bio_batch *hb = bio->bi_private;
+
+	/* single page bio, safe for multipage bvec */
 	struct page *page = bio->bi_io_vec[0].bv_page;
 
 	if (bio->bi_error) {
-- 
2.7.4

