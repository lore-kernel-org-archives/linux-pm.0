From: Eric Engestrom <eric@engestrom.ch>
Subject: [PATCH 31/41] Documentation: power: fix spelling mistake
Date: Mon, 25 Apr 2016 07:36:57 +0100
Message-ID: <1461566229-4717-5-git-send-email-eric@engestrom.ch>
References: <1461543878-3639-1-git-send-email-eric@engestrom.ch>
 <1461566229-4717-1-git-send-email-eric@engestrom.ch>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1461566229-4717-1-git-send-email-eric@engestrom.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Eric Engestrom <eric@engestrom.ch>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Signed-off-by: Eric Engestrom <eric@engestrom.ch>
---
 Documentation/power/opp.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/power/opp.txt b/Documentation/power/opp.txt
index c6279c2..1721a86 100644
--- a/Documentation/power/opp.txt
+++ b/Documentation/power/opp.txt
@@ -146,7 +146,7 @@ dev_pm_opp_find_freq_exact - Search for an OPP based on an *exact* frequency and
 	 rcu_read_lock();
 	 opp = dev_pm_opp_find_freq_exact(dev, 1000000000, false);
 	 rcu_read_unlock();
-	 /* dont operate on the pointer.. just do a sanity check.. */
+	 /* don't operate on the pointer.. just do a sanity check.. */
 	 if (IS_ERR(opp)) {
 		pr_err("frequency not disabled!\n");
 		/* trigger appropriate actions.. */
-- 
2.8.0
