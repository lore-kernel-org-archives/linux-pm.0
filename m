From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH] intel_idle: shrink avn_cstates table and mark it with
 __initdata tag
Date: Thu, 21 Nov 2013 13:09:38 +0100
Message-ID: <7374737.rFhOp5HKV7@amdc1032>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:48571 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751225Ab3KUMJr (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 21 Nov 2013 07:09:47 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <len.brown@intel.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

This is a fixup for commit fab04b2 ("intel_idle: Support Intel Atom
Processor C2000 Product Family") which didn't take into account
changes done in commits eba682a ("intel_idle: shrink states tables")
and 00f3e75 ("intel_idle: mark states tables with __initdata tag").

Cc: Len Brown <len.brown@intel.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/idle/intel_idle.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index cbd4e9a..f4bdf72 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -329,7 +329,8 @@ static struct cpuidle_state atom_cstates[] __initdata = {
 	{
 		.enter = NULL }
 };
-static struct cpuidle_state avn_cstates[CPUIDLE_STATE_MAX] = {
+
+static struct cpuidle_state avn_cstates[] __initdata = {
 	{
 		.name = "C1-AVN",
 		.desc = "MWAIT 0x00",
-- 
1.8.2.3


