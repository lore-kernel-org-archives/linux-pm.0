From: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
Subject: [PATCH 2/3] Trivial: fix typo in label name
	s/Platofrm_finish/Platform_finish/
Date: Sat,  4 Jul 2009 19:33:35 -0300
Message-ID: <1246746815-12146-1-git-send-email-cascardo__48776.7392457046$1246891551$gmane$org@holoscopio.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: rjw@sisk.pl
Cc: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>, linux-pm@lists.linux-foundation.org, trivial@kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Although the same label name is used somewhere else in the file, this
particular label was consistently typoed in all of its uses.

Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
---
 kernel/power/hibernate.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index 81d2e74..ec82025 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -460,11 +460,11 @@ int hibernation_platform_enter(void)
 
 	error = hibernation_ops->prepare();
 	if (error)
-		goto Platofrm_finish;
+		goto Platform_finish;
 
 	error = disable_nonboot_cpus();
 	if (error)
-		goto Platofrm_finish;
+		goto Platform_finish;
 
 	local_irq_disable();
 	sysdev_suspend(PMSG_HIBERNATE);
@@ -476,7 +476,7 @@ int hibernation_platform_enter(void)
 	 * We don't need to reenable the nonboot CPUs or resume consoles, since
 	 * the system is going to be halted anyway.
 	 */
- Platofrm_finish:
+ Platform_finish:
 	hibernation_ops->finish();
 
 	dpm_suspend_noirq(PMSG_RESTORE);
-- 
1.6.3
