From: Anda-Maria Nicolae <anda-maria.nicolae@intel.com>
Subject: [PATCH 0/2] bq2415x_charger: Fix coding style issues and add new charger in the list of supported chargers
Date: Thu,  5 Mar 2015 13:23:55 +0200
Message-ID: <1425554637-26782-1-git-send-email-anda-maria.nicolae@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:65364 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932124AbbCELVV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 5 Mar 2015 06:21:21 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: anda-maria.nicolae@intel.com, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

Hello,

First patch from patchset fixes coding style issues: removes unnecessary else after return.
This way, the coding style complies with checkpatch.pl.

Second patch from patchset updates bq2415x driver to support bq24157s charger.

Thanks,
Anda

Anda-Maria Nicolae (2):
  bq2415x_charger: Remove unnecessary else after return
  bq2415x_charger: Add support for bq24157s

 drivers/power/bq2415x_charger.c |   32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

-- 
1.7.9.5

