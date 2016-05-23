From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH 0/2] Misc RAPL updates
Date: Mon, 23 May 2016 09:45:41 -0700
Message-ID: <1464021943-14915-1-git-send-email-jacob.jun.pan@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:28025 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751400AbcEWQrP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 23 May 2016 12:47:15 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Linux PM <linux-pm@vger.kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Prarit Bhargava <prarit@redhat.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>

A couple of small updates to support Skylake server and make it less
noisy on KVM.

Jacob Pan (2):
  powercap/rapl: add support for skx
  powercap/rapl: reduce warning level

 drivers/powercap/intel_rapl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

-- 
1.9.1

