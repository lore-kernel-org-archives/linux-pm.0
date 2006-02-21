From: Patrick Mochel <mochel@digitalimplant.org>
Subject: [PATCH 1/4] [pm] Add state filed to pm_message_t (to hold actual
 state device is in).
Date: Mon, 20 Feb 2006 16:55:37 -0800 (PST)
Message-ID: <Pine.LNX.4.50.0602201652430.21145-100000@monsoon.he.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1161245AbWBUAzq@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: greg@kroah.com, akpm@osdl.org, torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, linux-pm@osdl.org
List-Id: linux-pm@vger.kernel.org


Signed-off-by: Patrick Mochel <mochel@linux.intel.com>

---

 include/linux/pm.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

applies-to: 55ce8c6305fc70b1b544ce7365abd6054e9b5f61
7af37561812f4599841ade4abee067b808b40054
diff --git a/include/linux/pm.h b/include/linux/pm.h
index 5be87ba..a7324ea 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -140,6 +140,7 @@ struct device;

 typedef struct pm_message {
 	int event;
+	u32 state;
 } pm_message_t;

 /*
---
0.99.9.GIT
