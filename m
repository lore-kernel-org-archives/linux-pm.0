From: Stephane Gasparini <stephane.gasparini@intel.com>
Subject: [PATCH 1/1] kernel/fs: fix I/O wait not accounted for RW O_DSYNC
Date: Tue,  9 Feb 2016 17:07:38 +0100
Message-ID: <1455034058-84181-2-git-send-email-stephane.gasparini@intel.com>
References: <1455034058-84181-1-git-send-email-stephane.gasparini@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:10160 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757541AbcBIQIV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 9 Feb 2016 11:08:21 -0500
In-Reply-To: <1455034058-84181-1-git-send-email-stephane.gasparini@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-block@vger.kernel.org, linux-pm@vger.kernel.org, lenb@kernel.org, srinivas.pandruvada@linux.intel.com
Cc: Stephane Gasparini <stephane.gasparini@linux.intel.com>, len.brown@linux.intel.com, philippe.longepe@linux.intel.com

From: Stephane Gasparini <stephane.gasparini@linux.intel.com>

 When a process is doing Random Write with O_DSYNC flag
 the I/O wait are not accounted in the kernel (get_cpu_iowait_time_us).
 This is preventing the governor or the cpufreq driver to account for
 I/O wait and thus use the right pstate

Signed-off-by: Stephane Gasparini <stephane.gasparini@linux.intel.com>
Signed-off-by: Philippe Longepe <philippe.longepe@linux.intel.com>
---
 block/bio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/bio.c b/block/bio.c
index dbabd48b1934..f53a691b6533 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -874,7 +874,7 @@ int submit_bio_wait(int rw, struct bio *bio)
 	bio->bi_private = &ret;
 	bio->bi_end_io = submit_bio_wait_endio;
 	submit_bio(rw, bio);
-	wait_for_completion(&ret.event);
+	wait_for_completion_io(&ret.event);
 
 	return ret.error;
 }
-- 
Stephane Gasparini<stephane.gasparini@linux.intel.com>

---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, 
92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

