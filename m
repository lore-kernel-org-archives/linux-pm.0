From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH 0/2] Powercap RAPL update for Denverton
Date: Tue, 31 May 2016 13:41:28 -0700
Message-ID: <1464727290-5400-1-git-send-email-jacob.jun.pan@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:56441 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751375AbcEaUt0 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 31 May 2016 16:49:26 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>

A few MSRs are missing from Denverton RAPL interface which makes domain
detection fail prematurely. The patchset adds flexibility to the detection
logic such that it will support what functionality remains available.

Jacob Pan (2):
  powercap/rapl: handle missing msrs
  powercap/rapl: add support for denverton

 drivers/powercap/intel_rapl.c | 104 ++++++++++++++++++++++++++++++++----------
 1 file changed, 80 insertions(+), 24 deletions(-)

-- 
1.9.1

