From: Len Brown <lenb@kernel.org>
Subject: [PATCH 5/5] intel_idle: recognize Lincroft Atom Processor
Date: Sun, 15 Aug 2010 01:22:05 -0400
Message-ID: <4725fd3ce970c27a1678fb0809bfc7c2f4ac3e4f.1281849655.git.len.brown__13860.5606196963$1281849794$gmane$org@intel.com>
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
Cc: Len Brown <len.brown@intel.com>, Arjan van de Ven <arjan@linux.intel.com>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: Arjan van de Ven <arjan@linux.intel.com>

Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/idle/intel_idle.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 97655ed..b1909fb 100755
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -265,6 +265,7 @@ static int intel_idle_probe(void)
 		break;
 
 	case 0x1C:	/* 28 - Atom Processor */
+	case 0x26:	/* 38 - Lincroft Atom Processor */
 		lapic_timer_reliable_states = (1 << 2) | (1 << 1); /* C2, C1 */
 		cpuidle_state_table = atom_cstates;
 		break;
-- 
1.7.2.1.95.g3d045
