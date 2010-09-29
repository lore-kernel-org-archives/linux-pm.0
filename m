From: Len Brown <lenb@kernel.org>
Subject: [PATCH 2/5] cpuidle: Fix typos
Date: Tue, 28 Sep 2010 23:53:04 -0400
Message-ID: <20e3341bb138bc9860adea4d76707470357b76ab.1285732130.git.len.brown@intel.com>
References: <1285732387-18629-1-git-send-email-lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <1285732387-18629-1-git-send-email-lenb@kernel.org>
In-reply-to: <4731fdcf6f7bdab3e369a3f844d4ea4d4017284d.1285732130.git.len.brown@intel.com>
References: <4731fdcf6f7bdab3e369a3f844d4ea4d4017284d.1285732130.git.len.brown@intel.com>
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
Cc: Len Brown <len.brown@intel.com>, Lucas De Marchi <lucas.de.marchi@gmail.com>
List-Id: linux-pm@vger.kernel.org

From: Lucas De Marchi <lucas.de.marchi@gmail.com>

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/cpuidle/governors/menu.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
index c2408bb..f508690 100644
--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -80,7 +80,7 @@
  * Limiting Performance Impact
  * ---------------------------
  * C states, especially those with large exit latencies, can have a real
- * noticable impact on workloads, which is not acceptable for most sysadmins,
+ * noticeable impact on workloads, which is not acceptable for most sysadmins,
  * and in addition, less performance has a power price of its own.
  *
  * As a general rule of thumb, menu assumes that the following heuristic
-- 
1.7.3.2.g9027fa
