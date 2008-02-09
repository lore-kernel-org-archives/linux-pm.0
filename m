From: Len Brown <lenb@kernel.org>
Subject: Re: [GIT PATCH] ACPI patches for 2.6.25-rc0
Date: Sat, 9 Feb 2008 04:04:32 -0500
Message-ID: <200802090404.32835.lenb__26619.0003174872$1202548183$gmane$org@kernel.org>
References: <200802070450.09098.lenb@kernel.org>
	<20080209082748.GA7792@elte.hu> <20080209083143.GA9634@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080209083143.GA9634@elte.hu>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Thomas Sujith <sujith.thomas@intel.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Saturday 09 February 2008 03:31, Ingo Molnar wrote:
> 
> * Ingo Molnar <mingo@elte.hu> wrote:
> 
> > that fixed the build failure on 32-bit, but there's another one i just 
> > hit on 64-bit x86:
> > 
> > drivers/built-in.o: In function `acpi_video_bus_put_devices':
> > video.c:(.text+0x5540d): undefined reference to `thermal_cooling_device_unregister'
> > drivers/built-in.o: In function `acpi_video_bus_add':
> > video.c:(.text+0x56994): undefined reference to `thermal_cooling_device_register'
> > 
> > which is due to:
> > 
> >   commit 702ed512de9c8a67a69a981c73b7337c2131f198
> >   Date:   Thu Jan 17 15:51:22 2008 +0800
> > 
> >       ACPI: register ACPI Video LCD as generic thermal cooling device
> > 
> > the commit couldnt be reverted cleanly, i've done a manual fixup of 
> > the revert (find the patch below).
> 
> (config for that build breakage attached, in case you were wondering 
> about how to trigger it.)

>From a0dd25b2c83de4623487ca4de9c1d962b552ca0f Mon Sep 17 00:00:00 2001
From: Len Brown <len.brown@intel.com>
Date: Sat, 9 Feb 2008 04:01:48 -0500
Subject: [PATCH] ACPI: thermal: buildfix for CONFIG_THERMAL=n
Organization: Intel Open Source Technology Center

This fixes the build, but acpi_fan_add() still needs
to be updated to handle thermal_cooling_device_register()
returning NULL as a non-fatal condition.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 include/linux/thermal.h |   23 ++++++++++++++++++++---
 1 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index bba7712..818ca1c 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -79,7 +79,9 @@ struct thermal_zone_device {
 };
 
 struct thermal_zone_device *thermal_zone_device_register(char *, int, void *,
-					struct thermal_zone_device_ops *);
+							 struct
+							 thermal_zone_device_ops
+							 *);
 void thermal_zone_device_unregister(struct thermal_zone_device *);
 
 int thermal_zone_bind_cooling_device(struct thermal_zone_device *, int,
@@ -87,8 +89,23 @@ int thermal_zone_bind_cooling_device(struct thermal_zone_device *, int,
 int thermal_zone_unbind_cooling_device(struct thermal_zone_device *, int,
 				       struct thermal_cooling_device *);
 
+#ifdef	CONFIG_THERMAL
 struct thermal_cooling_device *thermal_cooling_device_register(char *, void *,
-					struct thermal_cooling_device_ops *);
+							       struct
+							       thermal_cooling_device_ops
+							       *);
 void thermal_cooling_device_unregister(struct thermal_cooling_device *);
+#else
+static inline struct thermal_cooling_device
+*thermal_cooling_device_register(char *c, void *v,
+				 struct thermal_cooling_device_ops *t)
+{
+	return NULL;
+}
+static inline
+    void thermal_cooling_device_unregister(struct thermal_cooling_device *t)
+{
+};
+#endif
 
-#endif				/* __THERMAL_H__ */
+#endif /* __THERMAL_H__ */
-- 
1.5.4.34.g053d9
