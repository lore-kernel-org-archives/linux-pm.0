From: Jiri Slaby <jirislaby@gmail.com>
Subject: [PATCH 1/2] DRM: i915, suspend oops fix
Date: Sun, 16 Dec 2007 10:45:09 -0800
Message-ID: <9008147453061115361.slaby@pripojeni.net>
References: <20071213024050.7d6e5f3e.akpm@linux-foundation.org>
	<47646A6C.7070007@gmail.com>
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <47646A6C.7070007@gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Wang Zhenyu <zhenyu.z.wang@intel.com>, airlied@linux.ie, linux-kernel@vger.kernel.org, Eric Anholt <eric@anholt.net>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, dri-devel@lists.sourceforge.net
List-Id: linux-pm@vger.kernel.org

Jiri Slaby wrote:
> On 12/13/2007 11:40 AM, Andrew Morton wrote:
> > 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.24-rc5/2.6.24-rc5-mm1/
> 
> Broken @#$%^ suspend, again (and maybe still for a longer time). Unable to
> reproduce this with netconsole.
> 
> trace led to i915_suspend
>         call    pci_bus_read_config_byte        #
>         movq    8(%rbx), %rdi   # <variable>.mmio_map, <variable>.mmio_map
>         movq    24(%rdi), %rax  # <variable>.handle, D.24395
>         movl    458760(%rax), %eax      #, D.24397
> 
> address in rax (i.e. dev_priv->mmio_map->handle) is broken, at least it seems so
> from the part of the trace and RIP.
> 
>         movl    %eax, 408(%rbx) # D.24397, <variable>.savePIPEACONF
>         movq    24(%rdi), %rax  # <variable>.handle, temp.676
>         movl    393244(%rax), %eax      #, D.24399
> 
> in
>         pci_save_state(dev->pdev);
>         pci_read_config_byte(dev->pdev, LBB, &dev_priv->saveLBB);
> 
>         /* Pipe & plane A info */
> -->     dev_priv->savePIPEACONF = I915_READ(PIPEACONF);

I think, the "problem" is, that something randomizes ioremapped addresses.
Old userspace driver closes drm when X starts and the mapping is lost. The
problem dismissed after X userspace driver update, anyway I think that the
patch still might be needed. Anyway, it's not enough, the same problem for
sarea (next patch).

BTW the new driver (also without both patches) breaks killing of X. Screen
becomes black and console is not shown.

--

i915, suspend oops fix

Register mmio_map space when suspending, it might be lost due to DRM device
closing with older X userspace drivers (it closes drm device and frees
resources after X starts) and then it accesses bad address and oopses while
suspending.

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>
Cc: Dave Airlie <airlied@linux.ie>

---
commit f2e573d8a1b391584c76e95f287010b38867de64
tree cf24a5949513ed8ad03b3920d7213bcebfd9ce99
parent 39dc99d1618c5b3f96ad741cadeccaba055f4b72
author Jiri Slaby <jirislaby@gmail.com> Sun, 16 Dec 2007 17:56:47 +0100
committer Jiri Slaby <jirislaby@gmail.com> Sun, 16 Dec 2007 17:56:47 +0100

 drivers/char/drm/i915_dma.c |   24 +++++++++++++++---------
 drivers/char/drm/i915_drv.c |   10 +++++++++-
 drivers/char/drm/i915_drv.h |    1 +
 3 files changed, 25 insertions(+), 10 deletions(-)

diff --git a/drivers/char/drm/i915_dma.c b/drivers/char/drm/i915_dma.c
index 9e5adca..b274554 100644
--- a/drivers/char/drm/i915_dma.c
+++ b/drivers/char/drm/i915_dma.c
@@ -1276,11 +1276,23 @@ static int i915_set_status_page(struct drm_device *dev, void *data,
 	return 0;
 }
 
-int i915_driver_load(struct drm_device *dev, unsigned long flags)
+int i915_register_mmio_map(struct drm_device *dev)
 {
 	struct drm_i915_private *dev_priv = dev->dev_private;
 	unsigned long base, size;
-	int ret = 0, mmio_bar = IS_I9XX(dev) ? 0 : 1;
+	int mmio_bar = IS_I9XX(dev) ? 0 : 1;
+
+	/* Add register map (needed for suspend/resume) */
+	base = drm_get_resource_start(dev, mmio_bar);
+	size = drm_get_resource_len(dev, mmio_bar);
+
+	return drm_addmap(dev, base, size, _DRM_REGISTERS, _DRM_KERNEL,
+			 &dev_priv->mmio_map);
+}
+
+int i915_driver_load(struct drm_device *dev, unsigned long flags)
+{
+	struct drm_i915_private *dev_priv = dev->dev_private;
 
 	/* i915 has 4 more counters */
 	dev->counters += 4;
@@ -1297,13 +1309,7 @@ int i915_driver_load(struct drm_device *dev, unsigned long flags)
 
 	dev->dev_private = (void *)dev_priv;
 
-	/* Add register map (needed for suspend/resume) */
-	base = drm_get_resource_start(dev, mmio_bar);
-	size = drm_get_resource_len(dev, mmio_bar);
-
-	ret = drm_addmap(dev, base, size, _DRM_REGISTERS, _DRM_KERNEL,
-			 &dev_priv->mmio_map);
-	return ret;
+	return i915_register_mmio_map(dev);
 }
 
 int i915_driver_unload(struct drm_device *dev)
diff --git a/drivers/char/drm/i915_drv.c b/drivers/char/drm/i915_drv.c
index 0f9c1f1..a8c87f0 100644
--- a/drivers/char/drm/i915_drv.c
+++ b/drivers/char/drm/i915_drv.c
@@ -266,7 +266,7 @@ static void i915_restore_vga(struct drm_device *dev)
 static int i915_suspend(struct drm_device *dev)
 {
 	struct drm_i915_private *dev_priv = dev->dev_private;
-	int i;
+	int i, ret;
 
 	if (!dev || !dev_priv) {
 		printk(KERN_ERR "dev: %p, dev_priv: %p\n", dev, dev_priv);
@@ -274,6 +274,14 @@ static int i915_suspend(struct drm_device *dev)
 		return -ENODEV;
 	}
 
+	/* Every lastclose will destroy this mapping, we need it for suspend.
+	 * It doesn't matter if it exists already, it will return the existing
+	 * one. Also it will be surely destroyed; either on next lastclose or
+	 * on lastclose called from drm unload path. -js */
+	ret = i915_register_mmio_map(dev);
+	if (ret)
+		return ret;
+	
 	pci_save_state(dev->pdev);
 	pci_read_config_byte(dev->pdev, LBB, &dev_priv->saveLBB);
 
diff --git a/drivers/char/drm/i915_drv.h b/drivers/char/drm/i915_drv.h
index 6ddcba4..09024a1 100644
--- a/drivers/char/drm/i915_drv.h
+++ b/drivers/char/drm/i915_drv.h
@@ -216,6 +216,7 @@ extern int i915_max_ioctl;
 
 				/* i915_dma.c */
 extern void i915_kernel_lost_context(struct drm_device * dev);
+extern int i915_register_mmio_map(struct drm_device *dev);
 extern int i915_driver_load(struct drm_device *, unsigned long flags);
 extern int i915_driver_unload(struct drm_device *);
 extern void i915_driver_lastclose(struct drm_device * dev);
