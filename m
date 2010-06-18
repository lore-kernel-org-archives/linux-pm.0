From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH] DRM / radeon / PM: Do not evict VRAM during
	freeze phase of hibernation
Date: Fri, 18 Jun 2010 22:21:57 +0200
Message-ID: <201006182221.57333.rjw__30613.8147986077$1276892801$gmane$org@sisk.pl>
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
To: Dave Airlie <airlied@redhat.com>
Cc: Ondrej Zary <linux@rainbow-software.org>, linux-kernel@vger.kernel.org, dri-devel <dri-devel@lists.freedesktop.org>, Alex Deucher <alexdeucher@gmail.com>, linux-pm@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

I have recently noticed a 55 sec. delay during the "device freeze"
phase of hibernation on my test-bed HP nx6325.  Due to the 100%
reproducibility of it I was able to narrow it down to
radeon_suspend_kms() and then it turned out that the delay occured
somewhere in radeon_bo_evict_vram().  However, it doesn't seem really
necessary or even very useful to me to evict VRAM at this particular
point, because we're going to create an image and bring the device
back to the fully functional state in a little while.  Thus, I think
the VRAM evicition can be skipped for state.event == PM_EVENT_FREEZE,
which makes the delay go away.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/gpu/drm/radeon/radeon_device.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

Index: linux-2.6/drivers/gpu/drm/radeon/radeon_device.c
===================================================================
--- linux-2.6.orig/drivers/gpu/drm/radeon/radeon_device.c
+++ linux-2.6/drivers/gpu/drm/radeon/radeon_device.c
@@ -750,8 +750,11 @@ int radeon_suspend_kms(struct drm_device
 			}
 		}
 	}
-	/* evict vram memory */
-	radeon_bo_evict_vram(rdev);
+
+	if (state.event != PM_EVENT_FREEZE) {
+		/* evict vram memory */
+		radeon_bo_evict_vram(rdev);
+	}
 	/* wait for gpu to finish processing current batch */
 	radeon_fence_wait_last(rdev);
 
