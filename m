From: Roel Kluin <roel.kluin@gmail.com>
Subject: [PATH] i915: Read outside array bounds
Date: Sun, 26 Jul 2009 00:50:38 +0200
Message-ID: <4A6B8C3E.7060501@gmail.com>
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
To: airlied@linux.ie, pavel@ucw.cz, dri-devel@lists.sourceforge.net, linux-pm@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

dev_priv->saveSWF1 is a 16 element array, but this reads up to index 22

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
save_state does not do this addition, can it be removed? please review.

diff --git a/drivers/gpu/drm/i915/i915_suspend.c b/drivers/gpu/drm/i915/i915_suspend.c
index 9e1d16e..1d04e19 100644
--- a/drivers/gpu/drm/i915/i915_suspend.c
+++ b/drivers/gpu/drm/i915/i915_suspend.c
@@ -598,7 +598,7 @@ int i915_restore_state(struct drm_device *dev)
 
 	for (i = 0; i < 16; i++) {
 		I915_WRITE(SWF00 + (i << 2), dev_priv->saveSWF0[i]);
-		I915_WRITE(SWF10 + (i << 2), dev_priv->saveSWF1[i+7]);
+		I915_WRITE(SWF10 + (i << 2), dev_priv->saveSWF1[i]);
 	}
 	for (i = 0; i < 3; i++)
 		I915_WRITE(SWF30 + (i << 2), dev_priv->saveSWF2[i]);
