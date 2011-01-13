From: Len Brown <lenb@kernel.org>
Subject: [PATCH 07/12] SH,
	cpuidle: delete use of NOP CPUIDLE_FLAGS_SHALLOW
Date: Wed, 12 Jan 2011 22:39:57 -0500
Message-ID: <03d8b083511a7be2c69b750b8a4e412a21189291.1294889887.git.len.brown@intel.com>
References: <1294890002-6274-1-git-send-email-lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <1294890002-6274-1-git-send-email-lenb@kernel.org>
In-reply-to: <ddbd550d503c9cdefcd6674a0ef168d57d3f0917.1294889887.git.len.brown@intel.com>
References: <ddbd550d503c9cdefcd6674a0ef168d57d3f0917.1294889887.git.len.brown@intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
Cc: Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Len Brown <len.brown@intel.com>

set but not checked.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/sh/kernel/cpu/shmobile/cpuidle.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/sh/kernel/cpu/shmobile/cpuidle.c b/arch/sh/kernel/cpu/shmobile/cpuidle.c
index 83972aa..c19e2a9 100644
--- a/arch/sh/kernel/cpu/shmobile/cpuidle.c
+++ b/arch/sh/kernel/cpu/shmobile/cpuidle.c
@@ -81,7 +81,6 @@ void sh_mobile_setup_cpuidle(void)
 	state->target_residency = 1 * 2;
 	state->power_usage = 3;
 	state->flags = 0;
-	state->flags |= CPUIDLE_FLAG_SHALLOW;
 	state->flags |= CPUIDLE_FLAG_TIME_VALID;
 	state->enter = cpuidle_sleep_enter;
 
-- 
1.7.4.rc1.14.g7fad99
