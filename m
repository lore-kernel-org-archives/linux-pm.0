From: Nishanth Menon <nm@ti.com>
Subject: [PATCH] PM: OPP: opp_find_freq_exact documentation fix
Date: Fri, 25 Feb 2011 12:44:04 +0530
Message-ID: <1298618044-8292-1-git-send-email-nm__40201.5683976517$1298618131$gmane$org@ti.com>
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
To: linux-pm <linux-pm@lists.linux-foundation.org>
Cc: Nishanth Menon <nm@ti.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

opp_find_freq_exact documentation has is_available instead
of available. This also fixes warning with the kernel-doc:
scripts/kernel-doc drivers/base/power/opp.c >/dev/null
Warning(drivers/base/power/opp.c:246): No description found for parameter 'available'
Warning(drivers/base/power/opp.c:246): Excess function parameter 'is_available' description in 'opp_find_freq_exact'

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 drivers/base/power/opp.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
index 2bb9b4c..56a6899 100644
--- a/drivers/base/power/opp.c
+++ b/drivers/base/power/opp.c
@@ -222,7 +222,7 @@ int opp_get_opp_count(struct device *dev)
  * opp_find_freq_exact() - search for an exact frequency
  * @dev:		device for which we do this operation
  * @freq:		frequency to search for
- * @is_available:	true/false - match for available opp
+ * @available:		true/false - match for available opp
  *
  * Searches for exact match in the opp list and returns pointer to the matching
  * opp if found, else returns ERR_PTR in case of error and should be handled
-- 
1.7.1
