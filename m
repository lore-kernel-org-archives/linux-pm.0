From: Stephane Gasparini <stephane.gasparini@intel.com>
Subject: [PATCH 0/1] account I/O Wait during synchronous write
Date: Tue,  9 Feb 2016 17:07:37 +0100
Message-ID: <1455034058-84181-1-git-send-email-stephane.gasparini@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:10160 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757565AbcBIQIR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 9 Feb 2016 11:08:17 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-block@vger.kernel.org, linux-pm@vger.kernel.org, lenb@kernel.org, srinivas.pandruvada@linux.intel.com
Cc: Stephane Gasparini <stephane.gasparini@linux.intel.com>, len.brown@linux.intel.com, philippe.longepe@linux.intel.com

From: Stephane Gasparini <stephane.gasparini@linux.intel.com>

This patch allow to take into account I/O wait for synchronous write

Stephane Gasparini (1):
  kernel/fs: fix I/O wait not accounted for RW O_DSYNC

 block/bio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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

