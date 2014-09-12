From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Subject: [PATCH] cpuidle/powernv: Enter fastsleep on checking if deep idle
 states are allowed
Date: Fri, 12 Sep 2014 16:31:32 +0530
Message-ID: <20140912110131.7311.86417.stgit@preeti.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e32.co.us.ibm.com ([32.97.110.150]:46939 "EHLO
	e32.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753419AbaILLBt (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 12 Sep 2014 07:01:49 -0400
Received: from /spool/local
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <preeti@linux.vnet.ibm.com>;
	Fri, 12 Sep 2014 05:01:48 -0600
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: mikey@neuling.org, mpe@ellerman.id.au, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, benh@kernel.crashing.org, linuxppc-dev@lists.ozlabs.org
Cc: linux-pm@vger.kernel.org

Today the procfs interface /proc/sys/kernel/powersave-nap is used to control
entry into deep idle states beyond snooze. Check for the value of this
parameter before entering fastsleep. We already do this check for nap in
power7_idle().

Signed-off-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>
---

 drivers/cpuidle/cpuidle-powernv.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
index a64be57..b8ba52e 100644
--- a/drivers/cpuidle/cpuidle-powernv.c
+++ b/drivers/cpuidle/cpuidle-powernv.c
@@ -69,6 +69,12 @@ static int fastsleep_loop(struct cpuidle_device *dev,
 	unsigned long old_lpcr = mfspr(SPRN_LPCR);
 	unsigned long new_lpcr;
 
+	/*
+	 * Verify if snooze is the only valid cpuidle state
+	 */
+	if (!(powersave_nap > 0))
+		return index;
+
 	if (unlikely(system_state < SYSTEM_RUNNING))
 		return index;
 

