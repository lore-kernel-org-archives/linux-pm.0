Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40F336E46F;
	Thu, 26 Mar 2026 15:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774538096; cv=none; b=iGPf0BKhuEuPI/zD2tYvlmI77q+XBrUAIm35srJDrvMtXZIoGkYyvoBOMXXlQ3mXsaYV+l4tiRTo8l1W7p2LS+YLySzmtbEofSihu9g1O7Abe0Sa1FXQIWgBn/pGuwETCK6hgC1QjY7tD2zZuYGEHMGxZLrckBXe0DmdVb1UVAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774538096; c=relaxed/simple;
	bh=1uv4N13r/ClcoKN1oGCXIeMrmkHHCJGJZVeasMWOOCg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JNbgL9Lf8g7HrNlP2NkRriM01v83uG3n5vi1WKLtHm9UlpIPg2CPzMnvMi8aXfv4j8mgxQSt7lA5CTfx6s4EGMkRH5Bj2EkYv2SW/i9QChRRJlwJDKTxzzLZrUKvxx4xXlOC7ptzPA3SDMso436s9Z5Ha0Rd38e7LfeoZsgFfwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NOUbfvpF; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NOUbfvpF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774538094; x=1806074094;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1uv4N13r/ClcoKN1oGCXIeMrmkHHCJGJZVeasMWOOCg=;
  b=NOUbfvpFx9s/vdbZ9pVz6gWR4OjVAPPk9zBaNenXg9cwf/XqHPcRH283
   gdc4jg3uvAYGEr0jyaTHtNJUH9UTHn1WtCpP1ThXwhiKVfqvpbcGpGrgB
   lsdOrNLSGnKACeoYL5IcJbzJxGRx4QvyVaTIvGDmL2pIpdrLcdRGNyaMZ
   F+mQe09ZfOBaymrS9iqbrvAwFeHg5tj204aIwXXvlt/K71aN0RqloQZQP
   i3PtV8x77xJHXNlZvMex+siWMyGB78tlyY6X+DwdNzNtpoSukGuQJT6O0
   8d5lMU9sPcgXb6Q86Prl12oa8gXT0e6EGwK+FlEPFjswCvD0cPwK10kD/
   w==;
X-CSE-ConnectionGUID: Zy8yMX5NSRqVjaiYYoHBZA==
X-CSE-MsgGUID: ncrjubPtRDmx4CfS/dVRpQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="86675816"
X-IronPort-AV: E=Sophos;i="6.23,142,1770624000"; 
   d="scan'208";a="86675816"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 08:14:53 -0700
X-CSE-ConnectionGUID: eNbkGSbGTwGACqnr3YLykA==
X-CSE-MsgGUID: kkOG96hjS+GfN+3uBI9F/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,142,1770624000"; 
   d="scan'208";a="225288917"
Received: from sannilnx-dsk.jer.intel.com ([10.12.231.107])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 08:14:51 -0700
From: Alexander Usyskin <alexander.usyskin@intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Menachem Adin <menachem.adin@intel.com>,
	Alexander Usyskin <alexander.usyskin@intel.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Todd Brandt <todd.e.brandt@linux.intel.com>
Subject: [char-misc v3] mei: me: reduce the scope on unexpected reset
Date: Thu, 26 Mar 2026 16:57:20 +0200
Message-ID: <20260326145720.3937252-1-alexander.usyskin@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After commit 2cedb296988c ("mei: me: trigger link reset if hw ready is unexpected")
some devices started to show long resume times (5-7 seconds).
This happens as mei falsely detects unready hardware,
starts parallel link reset flow and triggers link reset timeouts
in the resume callback.

Address it by performing detection of unready hardware only
when driver is in the ENABLED state instead of blacklisting
states as done in the original patch.

Reported-by: Todd Brandt <todd.e.brandt@linux.intel.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221023
Tested-by: Todd Brandt <todd.e.brandt@linux.intel.com>
Fixes: 2cedb296988c ("mei: me: trigger link reset if hw ready is unexpected")
Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
---

V3: reword commit message, add Rafael and PM list

V2: rebase over v7.0-rc4

 drivers/misc/mei/hw-me.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/misc/mei/hw-me.c b/drivers/misc/mei/hw-me.c
index d4612c659784..1e4a41ac428f 100644
--- a/drivers/misc/mei/hw-me.c
+++ b/drivers/misc/mei/hw-me.c
@@ -1337,19 +1337,13 @@ irqreturn_t mei_me_irq_thread_handler(int irq, void *dev_id)
 	/*  check if we need to start the dev */
 	if (!mei_host_is_ready(dev)) {
 		if (mei_hw_is_ready(dev)) {
-			/* synchronized by dev mutex */
-			if (waitqueue_active(&dev->wait_hw_ready)) {
-				dev_dbg(&dev->dev, "we need to start the dev.\n");
-				dev->recvd_hw_ready = true;
-				wake_up(&dev->wait_hw_ready);
-			} else if (dev->dev_state != MEI_DEV_UNINITIALIZED &&
-				   dev->dev_state != MEI_DEV_POWERING_DOWN &&
-				   dev->dev_state != MEI_DEV_POWER_DOWN) {
+			if (dev->dev_state == MEI_DEV_ENABLED) {
 				dev_dbg(&dev->dev, "Force link reset.\n");
 				schedule_work(&dev->reset_work);
 			} else {
-				dev_dbg(&dev->dev, "Ignore this interrupt in state = %d\n",
-					dev->dev_state);
+				dev_dbg(&dev->dev, "we need to start the dev.\n");
+				dev->recvd_hw_ready = true;
+				wake_up(&dev->wait_hw_ready);
 			}
 		} else {
 			dev_dbg(&dev->dev, "Spurious Interrupt\n");
-- 
2.43.0

