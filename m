From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH] DRM / i915: Fix resume regression on MSI Wind
	U100 w/o KMS
Date: Sat, 9 Jan 2010 00:45:33 +0100
Message-ID: <201001090045.33784.rjw@sisk.pl>
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
To: Eric Anholt <eric@anholt.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Zhenyu Wang <zhenyuw@linux.intel.com>, pm list <linux-pm@lists.linux-foundation.org>, dri-devel@lists.sourceforge.net, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Commit cbda12d77ea590082edb6d30bd342a67ebc459e0 (drm/i915: implement
new pm ops for i915), among other things, removed the .suspend and
.resume pointers from the struct drm_driver object in i915_drv.c,
which broke resume without KMS on my MSI Wind U100.

Fix this by reverting that part of commit cbda12d77ea59.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/gpu/drm/i915/i915_drv.c |   53 ++++------------------------------------
 1 file changed, 6 insertions(+), 47 deletions(-)

Index: linux-2.6/drivers/gpu/drm/i915/i915_drv.c
===================================================================
--- linux-2.6.orig/drivers/gpu/drm/i915/i915_drv.c
+++ linux-2.6/drivers/gpu/drm/i915/i915_drv.c
@@ -464,6 +418,8 @@ static struct drm_driver driver = {
 	.lastclose = i915_driver_lastclose,
 	.preclose = i915_driver_preclose,
 	.postclose = i915_driver_postclose,
+	.suspend = i915_suspend,
+	.resume = i915_resume,
 	.device_is_agp = i915_driver_device_is_agp,
 	.enable_vblank = i915_enable_vblank,
 	.disable_vblank = i915_disable_vblank,
