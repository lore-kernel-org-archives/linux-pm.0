From: Len Brown <lenb@kernel.org>
Subject: [PATCH 2/5] intel_idle: add support for Westmere-EX
Date: Sun, 15 Aug 2010 01:22:02 -0400
Message-ID: <ec67a2ba360d4874b1158e6e87fe1e859b0c9117.1281849655.git.len.brown@intel.com>
References: <1281849725-7379-1-git-send-email-lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <1281849725-7379-1-git-send-email-lenb@kernel.org>
In-reply-to: <0394c6676e3fa48587fbe4821390d3264672c530.1281849655.git.len.brown@intel.com>
References: <0394c6676e3fa48587fbe4821390d3264672c530.1281849655.git.len.brown@intel.com>
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
Cc: Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: Len Brown <len.brown@intel.com>

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/idle/intel_idle.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 6d43bc3..97655ed 100755
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -256,6 +256,7 @@ static int intel_idle_probe(void)
 	case 0x1E:	/* Core i7 and i5 Processor - Lynnfield Jasper Forest */
 	case 0x1F:	/* Core i7 and i5 Processor - Nehalem */
 	case 0x2E:	/* Nehalem-EX Xeon */
+	case 0x2F:	/* Westmere-EX Xeon */
 		lapic_timer_reliable_states = (1 << 1);	 /* C1 */
 
 	case 0x25:	/* Westmere */
-- 
1.7.2.1.95.g3d045
