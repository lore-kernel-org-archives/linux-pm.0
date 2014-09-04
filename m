From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 03/15] Documentation: Charger Manager: Fix spelling mistakes
Date: Thu,  4 Sep 2014 17:31:24 +0530
Message-ID: <c8ff3bd5880d1f0022da745eefe6d16d2828fab3.1409831636.git.viresh.kumar@linaro.org>
References: <2eacd908a8094887cc1796f75ae0513be8a3e36d.1409831636.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:54976 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753774AbaIDMCQ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 4 Sep 2014 08:02:16 -0400
Received: by mail-pa0-f46.google.com with SMTP id eu11so19730347pac.5
        for <linux-pm@vger.kernel.org>; Thu, 04 Sep 2014 05:02:16 -0700 (PDT)
In-Reply-To: <2eacd908a8094887cc1796f75ae0513be8a3e36d.1409831636.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1409831636.git.viresh.kumar@linaro.org>
References: <cover.1409831636.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, anton@enomsg.org
Cc: linux-pm@vger.kernel.org, linaro-kernel@lists.linaro.org, Viresh Kumar <viresh.kumar@linaro.org>

'unnecessary' was wrongly spelled as 'unncessary', also it should have been
'unnecessarily'.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 Documentation/power/charger-manager.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/power/charger-manager.txt b/Documentation/power/charger-manager.txt
index b4f7f4b..9ff1105 100644
--- a/Documentation/power/charger-manager.txt
+++ b/Documentation/power/charger-manager.txt
@@ -29,7 +29,7 @@ the system may need multiple instances of Charger Manager.
 	While the battery is being charged and the system is in suspend-to-RAM,
 	we may need to monitor the battery health by looking at the ambient or
 	battery temperature. We can accomplish this by waking up the system
-	periodically. However, such a method wakes up devices unncessary for
+	periodically. However, such a method wakes up devices unnecessarily for
 	monitoring the battery health and tasks, and user processes that are
 	supposed to be kept suspended. That, in turn, incurs unnecessary power
 	consumption and slow down charging process. Or even, such peak power
-- 
2.0.3.693.g996b0fd

