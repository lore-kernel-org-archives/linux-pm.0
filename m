From: Namhyung Kim <namhyung@gmail.com>
Subject: [PATCH] ACPI: add missing __percpu markup in
	arch/x86/kernel/acpi/cstate.c
Date: Sun,  8 Aug 2010 02:17:29 +0900
Message-ID: <1281201449-31158-1-git-send-email-namhyung__17438.0897464745$1281386920$gmane$org@gmail.com>
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
To: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pm@lists.linux-foundation.org
Cc: Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

cpu_cstate_entry is a percpu pointer but was missing __percpu markup.
Add it.

Signed-off-by: Namhyung Kim <namhyung@gmail.com>
---
 arch/x86/kernel/acpi/cstate.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/x86/kernel/acpi/cstate.c b/arch/x86/kernel/acpi/cstate.c
index fb7a5f0..fb16f17 100644
--- a/arch/x86/kernel/acpi/cstate.c
+++ b/arch/x86/kernel/acpi/cstate.c
@@ -61,7 +61,7 @@ struct cstate_entry {
 		unsigned int ecx;
 	} states[ACPI_PROCESSOR_MAX_POWER];
 };
-static struct cstate_entry *cpu_cstate_entry;	/* per CPU ptr */
+static struct cstate_entry __percpu *cpu_cstate_entry;	/* per CPU ptr */
 
 static short mwait_supported[ACPI_PROCESSOR_MAX_POWER];
 
-- 
1.7.0.4
