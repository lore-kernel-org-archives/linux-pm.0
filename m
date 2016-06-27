From: "Jan Beulich" <JBeulich@suse.com>
Subject: [PATCH v2 2/2] intel_idle: correct BXT support
Date: Mon, 27 Jun 2016 00:35:48 -0600
Message-ID: <5770E56402000078000F8D89@prv-mh.provo.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from prv-mh.provo.novell.com ([137.65.248.74]:51836 "EHLO
	prv-mh.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750870AbcF0Gfx convert rfc822-to-8bit (ORCPT
	<rfc822;groupwise-linux-pm@vger.kernel.org:2:1>);
	Mon, 27 Jun 2016 02:35:53 -0400
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-pm@vger.kernel.org

Commit 5dcef69486 ("intel_idle: add BXT support") added an 8-element
lookup array with just a 2-bit value used for lookups. As per the SDM
that bit field is really 3 bits wide. While this is supposedly benign
here, future re-use of the code for other CPUs might expose the issue.

Signed-off-by: Jan Beulich <jbeulich@suse.com>
---
 drivers/idle/intel_idle.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- 4.7-rc5-intel-idle-BXT.orig/drivers/idle/intel_idle.c
+++ 4.7-rc5-intel-idle-BXT/drivers/idle/intel_idle.c
@@ -1157,7 +1157,7 @@ static unsigned long long irtl_2_usec(un
 	if (!irtl)
 		return 0;
 
-	ns = irtl_ns_units[(irtl >> 10) & 0x3];
+	ns = irtl_ns_units[(irtl >> 10) & 0x7];
 
 	return div64_u64((irtl & 0x3FF) * ns, 1000);
 }



