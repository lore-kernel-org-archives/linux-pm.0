Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0845F3AEF4B;
	Mon, 30 Mar 2026 08:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774860964; cv=none; b=MzC6u7jn2JR3IYbEvazosDAFS7vJVZvtFXQF7Yfqxr7wObvL1lrly7etALrzulcmMV0ErKfC4PNc2qDWTW2+ZpMwBCMMaVabHTyGMs+DzbvemwLbxGiJEGhrdkH6Ck9sjDRPvLnxGahVoHIdGeMrvn1II2w9axL09PfXJBeBn5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774860964; c=relaxed/simple;
	bh=XEEybzyu5k8Pmf1bWB1fQ/xJQAPqd7cjCRaxAStvkZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FAsZwaavCbt4kY0sIjbRsRiochT4x5JytA/MUUIs1S26YTLBViKHvMR+5Y54S4SD1T3EutQTMCi6GT52iqslAS08tCu9rVxN+Kv2VV8Aq7yAgeFTErOSVvZLdnAlDEcGlheuYlASXTJJTN92T4jdRbQVD1XDuiES7rWCG87/LI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lFmKcC0R; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lFmKcC0R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774860963; x=1806396963;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XEEybzyu5k8Pmf1bWB1fQ/xJQAPqd7cjCRaxAStvkZ8=;
  b=lFmKcC0RBJJodLMlkep0ldCVDLI1u4LT0DW0zMnm0+MWFs+tD/bIIf/l
   q7SVrV09IEsOchUbm5EUV9q+cEQg2o94K8+OQTs4eY//YF1Usd14bOvvr
   kjEd6wGXH3BhK8iHQjgKwHggO8ne9Pfszw85x2zeZrHScyvRMKvg55P0A
   D/G6objFPUtSpTaljTz3IFWIEfK8Tp1LCCMwuWFsmjapaPAUGyzkwVoQB
   sqMP7YXooRoUhMOEWiN+6SjIj1cZamfks0ksW8XAxo2qoaMrDr73Tl5tm
   kOmh3VSpwuS8Z6GJwgyUPpmHg+BpwpKBiGjH0F4mgLSRWYUNstZDTB5dd
   Q==;
X-CSE-ConnectionGUID: WwonwTgNSAeMIiTN4z6Vtw==
X-CSE-MsgGUID: Mix1JiR8T8SFaaqPhyU+ew==
X-IronPort-AV: E=McAfee;i="6800,10657,11743"; a="63400390"
X-IronPort-AV: E=Sophos;i="6.23,149,1770624000"; 
   d="scan'208";a="63400390"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 01:56:03 -0700
X-CSE-ConnectionGUID: ZHdbIs7BSjOafzjbHUNQCg==
X-CSE-MsgGUID: +jNbuSSlRG6/3dxzcfhA1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,149,1770624000"; 
   d="scan'208";a="225010571"
Received: from sannilnx-dsk.jer.intel.com ([10.12.231.107])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 01:56:00 -0700
From: Alexander Usyskin <alexander.usyskin@intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Menachem Adin <menachem.adin@intel.com>,
	Alexander Usyskin <alexander.usyskin@intel.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Todd Brandt <todd.e.brandt@linux.intel.com>
Subject: [char-misc v4] mei: me: reduce the scope on unexpected reset
Date: Mon, 30 Mar 2026 11:38:30 +0300
Message-ID: <20260330083830.536056-1-alexander.usyskin@intel.com>
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
when driver is in the MEI_DEV_ENABLED state instead of blacklisting
states as done in the original patch.
This eliminates active waitqueue check as in MEI_DEV_ENABLED state
there will be no active waitqueue.

Reviewed-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
Reported-by: Todd Brandt <todd.e.brandt@linux.intel.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221023
Tested-by: Todd Brandt <todd.e.brandt@linux.intel.com>
Fixes: 2cedb296988c ("mei: me: trigger link reset if hw ready is unexpected")
Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
---

V4: extend commit message, add Rafael's r-b

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

