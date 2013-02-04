From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: [PATCH 2/3] fb: add support for drivers not needing VT
	switch at suspend/resume time
Date: Mon,  4 Feb 2013 13:37:21 +0000
Message-ID: <1359985042-2610-2-git-send-email-jbarnes@virtuousgeek.org>
References: <1359985042-2610-1-git-send-email-jbarnes@virtuousgeek.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org>
In-Reply-To: <1359985042-2610-1-git-send-email-jbarnes@virtuousgeek.org>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org
Errors-To: intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org
To: linux-kernel@vger.kernel.org
Cc: rjw@sisk.pl, intel-gfx@lists.freedesktop.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Use the new PM routines to indicate whether we need to VT switch at suspend
and resume time.  When a new driver is bound, set its flag accordingly,
and when unbound, remove it from the PM's console tracking list.

Signed-off-by: Jesse Barnes <jbarnes@virtuousgeek.org>
---
 drivers/video/fbmem.c |    7 +++++++
 include/linux/fb.h    |    2 ++
 2 files changed, 9 insertions(+)

diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
index 3ff0105..240d783 100644
--- a/drivers/video/fbmem.c
+++ b/drivers/video/fbmem.c
@@ -1643,6 +1643,11 @@ static int do_register_framebuffer(struct fb_info *fb_info)
 	if (!fb_info->modelist.prev || !fb_info->modelist.next)
 		INIT_LIST_HEAD(&fb_info->modelist);
 
+	if (fb_info->skip_vt_switch)
+		pm_vt_switch_required(fb_info->dev, false);
+	else
+		pm_vt_switch_required(fb_info->dev, true);
+
 	fb_var_to_videomode(&mode, &fb_info->var);
 	fb_add_videomode(&mode, &fb_info->modelist);
 	registered_fb[i] = fb_info;
@@ -1673,6 +1678,8 @@ static int do_unregister_framebuffer(struct fb_info *fb_info)
 	if (ret)
 		return -EINVAL;
 
+	pm_vt_switch_unregister(fb_info->dev);
+
 	unlink_framebuffer(fb_info);
 	if (fb_info->pixmap.addr &&
 	    (fb_info->pixmap.flags & FB_PIXMAP_DEFAULT))
diff --git a/include/linux/fb.h b/include/linux/fb.h
index c7a9571..9a7538a 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -499,6 +499,8 @@ struct fb_info {
 			resource_size_t size;
 		} ranges[0];
 	} *apertures;
+
+	bool skip_vt_switch; /* no VT switch on suspend/resume required */
 };
 
 static inline struct apertures_struct *alloc_apertures(unsigned int max_num) {
-- 
1.7.9.5
