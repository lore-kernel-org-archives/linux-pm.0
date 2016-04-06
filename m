From: Len Brown <lenb@kernel.org>
Subject: [PATCH 13/13] intel_idle: Add KBL support
Date: Wed,  6 Apr 2016 17:00:59 -0400
Message-ID: <82d6c4397a0bd6b88e8a7a11073804472bd5a527.1459975717.git.len.brown@intel.com>
References: <1459976459-2532-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1459976459-2532-1-git-send-email-lenb@kernel.org>
In-Reply-To: <6513da0f2332d2333848af18e374b99f77c124aa.1459975717.git.len.brown@intel.com>
References: <6513da0f2332d2333848af18e374b99f77c124aa.1459975717.git.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Len Brown <len.brown@intel.com>

KBL is similar to SKL

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/idle/intel_idle.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index d0ec343..c966492 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -1047,6 +1047,8 @@ static const struct x86_cpu_id intel_idle_ids[] __initconst = {
 	ICPU(0x56, idle_cpu_bdw),
 	ICPU(0x4e, idle_cpu_skl),
 	ICPU(0x5e, idle_cpu_skl),
+	ICPU(0x8e, idle_cpu_skl),
+	ICPU(0x9e, idle_cpu_skl),
 	ICPU(0x55, idle_cpu_skx),
 	ICPU(0x57, idle_cpu_knl),
 	ICPU(0x5c, idle_cpu_bxt),
-- 
2.8.0.rc4.16.g56331f8
