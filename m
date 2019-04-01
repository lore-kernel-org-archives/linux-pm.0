From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 4.4 084/131] cpu/hotplug: Handle unbalanced hotplug enable/disable
Date: Mon,  1 Apr 2019 19:02:34 +0200
Message-ID: <20190401170059.116218209@linuxfoundation.org>
References: <20190401170051.645954551@linuxfoundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190401170051.645954551@linuxfoundation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, Lianwei Wang <lianwei.wang@gmail.com>, peterz@infradead.org, linux-pm@vger.kernel.org, oleg@redhat.com, Thomas Gleixner <tglx@linutronix.de>, Sasha Levin <sashal@kernel.org>
List-Id: linux-pm@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 01b41159066531cc8d664362ff0cd89dd137bbfa ]

When cpu_hotplug_enable() is called unbalanced w/o a preceeding
cpu_hotplug_disable() the code emits a warning, but happily decrements the
disabled counter. This causes the next operations to malfunction.

Prevent the decrement and just emit a warning.

Signed-off-by: Lianwei Wang <lianwei.wang@gmail.com>
Cc: peterz@infradead.org
Cc: linux-pm@vger.kernel.org
Cc: oleg@redhat.com
Link: http://lkml.kernel.org/r/1465541008-12476-1-git-send-email-lianwei.wang@gmail.com
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/cpu.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 40d20bf5de28..42ce0b0ae5c5 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -183,10 +183,17 @@ void cpu_hotplug_disable(void)
 }
 EXPORT_SYMBOL_GPL(cpu_hotplug_disable);
 
+static void __cpu_hotplug_enable(void)
+{
+	if (WARN_ONCE(!cpu_hotplug_disabled, "Unbalanced cpu hotplug enable\n"))
+		return;
+	cpu_hotplug_disabled--;
+}
+
 void cpu_hotplug_enable(void)
 {
 	cpu_maps_update_begin();
-	WARN_ON(--cpu_hotplug_disabled < 0);
+	__cpu_hotplug_enable();
 	cpu_maps_update_done();
 }
 EXPORT_SYMBOL_GPL(cpu_hotplug_enable);
@@ -626,7 +633,7 @@ void enable_nonboot_cpus(void)
 
 	/* Allow everyone to use the CPU hotplug again */
 	cpu_maps_update_begin();
-	WARN_ON(--cpu_hotplug_disabled < 0);
+	__cpu_hotplug_enable();
 	if (cpumask_empty(frozen_cpus))
 		goto out;
 
-- 
2.19.1
