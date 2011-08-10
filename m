From: Mike Turquette <mturquette@ti.com>
Subject: [PATCH v2 2/2] cpu: update cpu_hotpluggable_mask in
	register_cpu
Date: Wed, 10 Aug 2011 13:03:34 -0700
Message-ID: <1313006614-28702-3-git-send-email-mturquette__22533.5189294585$1313007212$gmane$org@ti.com>
References: <1313006614-28702-1-git-send-email-mturquette@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1313006614-28702-1-git-send-email-mturquette@ti.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@lists.linux-foundation.org, gregkh@suse.de, linaro-dev@lists.linaro.org, patches@linaro.org
List-Id: linux-pm@vger.kernel.org

Update the cpu_hotpluggable_mask for each registered CPU which supports
hotplug.  This makes it trivial for kernel code to know which CPUs
support hotplug operations.

Signed-off-by: Mike Turquette <mturquette@ti.com>
---
Change log:
v2: no change

 drivers/base/cpu.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index 251acea..91ddcf8 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -224,8 +224,10 @@ int __cpuinit register_cpu(struct cpu *cpu, int num)
 
 	error = sysdev_register(&cpu->sysdev);
 
-	if (!error && cpu->hotpluggable)
+	if (!error && cpu->hotpluggable) {
 		register_cpu_control(cpu);
+		set_cpu_hotpluggable(num, true);
+	}
 	if (!error)
 		per_cpu(cpu_sys_devices, num) = &cpu->sysdev;
 	if (!error)
-- 
1.7.4.1
