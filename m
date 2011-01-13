From: Len Brown <lenb@kernel.org>
Subject: [PATCH 08/12] cpuidle: delete unused
 CPUIDLE_FLAG_SHALLOW, BALANCED, DEEP definitions
Date: Wed, 12 Jan 2011 22:39:58 -0500
Message-ID: <642f11c53f17aee991d97d14e6922172849ef227.1294889887.git.len.brown@intel.com>
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

Signed-off-by: Len Brown <len.brown@intel.com>
---
 include/linux/cpuidle.h |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index dee3285..c252953 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -48,9 +48,6 @@ struct cpuidle_state {
 /* Idle State Flags */
 #define CPUIDLE_FLAG_TIME_VALID	(0x01) /* is residency time measurable? */
 #define CPUIDLE_FLAG_CHECK_BM	(0x02) /* BM activity will exit state */
-#define CPUIDLE_FLAG_SHALLOW	(0x20) /* low latency, minimal savings */
-#define CPUIDLE_FLAG_BALANCED	(0x40) /* medium latency, moderate savings */
-#define CPUIDLE_FLAG_DEEP	(0x80) /* high latency, large savings */
 #define CPUIDLE_FLAG_IGNORE	(0x100) /* ignore during this idle period */
 #define CPUIDLE_FLAG_TLB_FLUSHED (0x200) /* tlb will be flushed */
 
-- 
1.7.4.rc1.14.g7fad99
