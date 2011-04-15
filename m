From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH/RFC] pm: disabling runtime power-management has
 to reset the status
Date: Fri, 15 Apr 2011 20:14:59 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1104152011090.18593@axis700.grange>
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
To: linux-pm@lists.linux-foundation.org
Cc: Magnus Damm <damm@opensource.se>
List-Id: linux-pm@vger.kernel.org

Restore the initial RPM_SUSPENDED runtime pm status, when disabling,
otherwise the following enable will not function. This happens, e.g.,
when unloading and reloading drivers.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Simon Horman <horms@verge.net.au>
Cc: Magnus Damm <damm@opensource.se>
---

No, I do not claim to understand the thousand of states, flags, and 
counters, this just happens to fix the problem for me. Feel free to make a 
correct solution out of this.

 drivers/base/power/runtime.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 3172c60..83d6898 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -1012,8 +1012,10 @@ void __pm_runtime_disable(struct device *dev, bool check_resume)
 		pm_runtime_put_noidle(dev);
 	}
 
-	if (!dev->power.disable_depth++)
+	if (!dev->power.disable_depth++) {
 		__pm_runtime_barrier(dev);
+		dev->power.runtime_status = RPM_SUSPENDED;
+	}
 
  out:
 	spin_unlock_irq(&dev->power.lock);
-- 
1.7.2.5
