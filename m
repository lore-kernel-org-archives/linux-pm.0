From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH -mmotm] fbmem: fix fb_info->lock and
 mm->mmap_sem circular locking dependency
Date: Sun, 22 Mar 2009 14:52:19 -0700
Message-ID: <20090322145219.ad294615.akpm__22507.4828522795$1237759727$gmane$org@linux-foundation.org>
References: <498817E2.3020008@gmail.com>
	<1233783983-28802-1-git-send-email-righi.andrea@gmail.com>
	<200903221748.42871.arvidjaar@gmail.com>
	<200903221857.20473.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200903221857.20473.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-fbdev-devel@lists.sourceforge.net, "Antonino A. Daplas" <adaplas@gmail.com>, Andrey Borzenkov <arvidjaar@gmail.com>, linux-kernel@vger.kernel.org, Krzysztof Helt <krzysztof.h1@poczta.fm>, Dave@smtp1.linux-foundation.org, Stefan Richter <stefanr@s5r6.in-berlin.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Johannes Weiner <hannes@cmpxchg.org>, linux-pm@lists.linux-foundation.org, Harvey Harrison <harvey.harrison@gmail.com>, Andrea Righi <righi.andrea@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Sun, 22 Mar 2009 18:57:19 +0100 "Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> On Sunday 22 March 2009, Andrey Borzenkov wrote:
> > On 5 ______________ 2009 00:46:23 Andrea Righi wrote:
> > > Fix this circular locking dependencies in the frame buffer console
> > > driver pushing down the mutex fb_info->lock.
> > >
> > > Circular locking dependecies occur calling the blocking
> > > fb_notifier_call_chain() with fb_info->lock held. Notifier callbacks
> > > can try to acquire mm->mmap_sem, while fb_mmap() acquires the locks
> > > in the reverse order mm->mmap_sem => fb_info->lock.
> > >
> > > Tested-by: Andrey Borzenkov <arvidjaar@mail.ru>
> > > Signed-off-by: Andrea Righi <righi.andrea@gmail.com>
> > 
> > Hmm ... is it in current Linus tree? Because I happened to have this again 
> > in rc8:
> 
> It doesn't seems so, at least I don't see it in there.

I didn't realise that this was needed in mainline.

I would hate to mrege it this late and find that it introduces some nasty
new deadlock which everyone hits.  Probably it's more prodent to merge it
into 2.6.29.1 now.



From: Andrea Righi <righi.andrea@gmail.com>

Fix a circular locking dependency in the frame buffer console driver
pushing down the mutex fb_info->lock.

Circular locking dependecies occur calling the blocking
fb_notifier_call_chain() with fb_info->lock held.  Notifier callbacks can
try to acquire mm->mmap_sem, while fb_mmap() acquires the locks in the
reverse order mm->mmap_sem => fb_info->lock.

Tested-by: Andrey Borzenkov <arvidjaar@mail.ru>
Signed-off-by: Andrea Righi <righi.andrea@gmail.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Krzysztof Helt <krzysztof.h1@poczta.fm>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/video/backlight/backlight.c |    3 +
 drivers/video/backlight/lcd.c       |    3 +
 drivers/video/console/fbcon.c       |   73 ++++++++++++++++++++++----
 drivers/video/fbmem.c               |   11 ---
 4 files changed, 70 insertions(+), 20 deletions(-)

diff -puN drivers/video/backlight/backlight.c~fbmem-fix-fb_info-lock-and-mm-mmap_sem-circular-locking-dependency drivers/video/backlight/backlight.c
--- a/drivers/video/backlight/backlight.c~fbmem-fix-fb_info-lock-and-mm-mmap_sem-circular-locking-dependency
+++ a/drivers/video/backlight/backlight.c
@@ -35,6 +35,8 @@ static int fb_notifier_callback(struct n
 		return 0;
 
 	bd = container_of(self, struct backlight_device, fb_notif);
+	if (!lock_fb_info(evdata->info))
+		return -ENODEV;
 	mutex_lock(&bd->ops_lock);
 	if (bd->ops)
 		if (!bd->ops->check_fb ||
@@ -47,6 +49,7 @@ static int fb_notifier_callback(struct n
 			backlight_update_status(bd);
 		}
 	mutex_unlock(&bd->ops_lock);
+	unlock_fb_info(evdata->info);
 	return 0;
 }
 
diff -puN drivers/video/backlight/lcd.c~fbmem-fix-fb_info-lock-and-mm-mmap_sem-circular-locking-dependency drivers/video/backlight/lcd.c
--- a/drivers/video/backlight/lcd.c~fbmem-fix-fb_info-lock-and-mm-mmap_sem-circular-locking-dependency
+++ a/drivers/video/backlight/lcd.c
@@ -40,6 +40,8 @@ static int fb_notifier_callback(struct n
 	if (!ld->ops)
 		return 0;
 
+	if (!lock_fb_info(evdata->info))
+		return -ENODEV;
 	mutex_lock(&ld->ops_lock);
 	if (!ld->ops->check_fb || ld->ops->check_fb(ld, evdata->info)) {
 		if (event == FB_EVENT_BLANK) {
@@ -51,6 +53,7 @@ static int fb_notifier_callback(struct n
 		}
 	}
 	mutex_unlock(&ld->ops_lock);
+	unlock_fb_info(evdata->info);
 	return 0;
 }
 
diff -puN drivers/video/console/fbcon.c~fbmem-fix-fb_info-lock-and-mm-mmap_sem-circular-locking-dependency drivers/video/console/fbcon.c
--- a/drivers/video/console/fbcon.c~fbmem-fix-fb_info-lock-and-mm-mmap_sem-circular-locking-dependency
+++ a/drivers/video/console/fbcon.c
@@ -2954,8 +2954,11 @@ static int fbcon_fb_unbind(int idx)
 
 static int fbcon_fb_unregistered(struct fb_info *info)
 {
-	int i, idx = info->node;
+	int i, idx;
 
+	if (!lock_fb_info(info))
+		return -ENODEV;
+	idx = info->node;
 	for (i = first_fb_vc; i <= last_fb_vc; i++) {
 		if (con2fb_map[i] == idx)
 			con2fb_map[i] = -1;
@@ -2979,13 +2982,14 @@ static int fbcon_fb_unregistered(struct 
 		}
 	}
 
-	if (!num_registered_fb)
-		unregister_con_driver(&fb_con);
-
-
 	if (primary_device == idx)
 		primary_device = -1;
 
+	unlock_fb_info(info);
+
+	if (!num_registered_fb)
+		unregister_con_driver(&fb_con);
+
 	return 0;
 }
 
@@ -3021,9 +3025,13 @@ static inline void fbcon_select_primary(
 
 static int fbcon_fb_registered(struct fb_info *info)
 {
-	int ret = 0, i, idx = info->node;
+	int ret = 0, i, idx;
 
+	if (!lock_fb_info(info))
+		return -ENODEV;
+	idx = info->node;
 	fbcon_select_primary(info);
+	unlock_fb_info(info);
 
 	if (info_idx == -1) {
 		for (i = first_fb_vc; i <= last_fb_vc; i++) {
@@ -3124,7 +3132,7 @@ static void fbcon_get_requirement(struct
 	}
 }
 
-static int fbcon_event_notify(struct notifier_block *self, 
+static int fbcon_event_notify(struct notifier_block *self,
 			      unsigned long action, void *data)
 {
 	struct fb_event *event = data;
@@ -3132,7 +3140,7 @@ static int fbcon_event_notify(struct not
 	struct fb_videomode *mode;
 	struct fb_con2fbmap *con2fb;
 	struct fb_blit_caps *caps;
-	int ret = 0;
+	int idx, ret = 0;
 
 	/*
 	 * ignore all events except driver registration and deregistration
@@ -3144,23 +3152,54 @@ static int fbcon_event_notify(struct not
 
 	switch(action) {
 	case FB_EVENT_SUSPEND:
+		if (!lock_fb_info(info)) {
+			ret = -ENODEV;
+			goto done;
+		}
 		fbcon_suspended(info);
+		unlock_fb_info(info);
 		break;
 	case FB_EVENT_RESUME:
+		if (!lock_fb_info(info)) {
+			ret = -ENODEV;
+			goto done;
+		}
 		fbcon_resumed(info);
+		unlock_fb_info(info);
 		break;
 	case FB_EVENT_MODE_CHANGE:
+		if (!lock_fb_info(info)) {
+			ret = -ENODEV;
+			goto done;
+		}
 		fbcon_modechanged(info);
+		unlock_fb_info(info);
 		break;
 	case FB_EVENT_MODE_CHANGE_ALL:
+		if (!lock_fb_info(info)) {
+			ret = -ENODEV;
+			goto done;
+		}
 		fbcon_set_all_vcs(info);
+		unlock_fb_info(info);
 		break;
 	case FB_EVENT_MODE_DELETE:
 		mode = event->data;
+		if (!lock_fb_info(info)) {
+			ret = -ENODEV;
+			goto done;
+		}
 		ret = fbcon_mode_deleted(info, mode);
+		unlock_fb_info(info);
 		break;
 	case FB_EVENT_FB_UNBIND:
-		ret = fbcon_fb_unbind(info->node);
+		if (!lock_fb_info(info)) {
+			ret = -ENODEV;
+			goto done;
+		}
+		idx = info->node;
+		unlock_fb_info(info);
+		ret = fbcon_fb_unbind(idx);
 		break;
 	case FB_EVENT_FB_REGISTERED:
 		ret = fbcon_fb_registered(info);
@@ -3178,17 +3217,31 @@ static int fbcon_event_notify(struct not
 		con2fb->framebuffer = con2fb_map[con2fb->console - 1];
 		break;
 	case FB_EVENT_BLANK:
+		if (!lock_fb_info(info)) {
+			ret = -ENODEV;
+			goto done;
+		}
 		fbcon_fb_blanked(info, *(int *)event->data);
+		unlock_fb_info(info);
 		break;
 	case FB_EVENT_NEW_MODELIST:
+		if (!lock_fb_info(info)) {
+			ret = -ENODEV;
+			goto done;
+		}
 		fbcon_new_modelist(info);
+		unlock_fb_info(info);
 		break;
 	case FB_EVENT_GET_REQ:
 		caps = event->data;
+		if (!lock_fb_info(info)) {
+			ret = -ENODEV;
+			goto done;
+		}
 		fbcon_get_requirement(info, caps);
+		unlock_fb_info(info);
 		break;
 	}
-
 done:
 	return ret;
 }
diff -puN drivers/video/fbmem.c~fbmem-fix-fb_info-lock-and-mm-mmap_sem-circular-locking-dependency drivers/video/fbmem.c
--- a/drivers/video/fbmem.c~fbmem-fix-fb_info-lock-and-mm-mmap_sem-circular-locking-dependency
+++ a/drivers/video/fbmem.c
@@ -1086,13 +1086,8 @@ static long do_fb_ioctl(struct fb_info *
 			return -EINVAL;
 		con2fb.framebuffer = -1;
 		event.data = &con2fb;
-
-		if (!lock_fb_info(info))
-			return -ENODEV;
 		event.info = info;
 		fb_notifier_call_chain(FB_EVENT_GET_CONSOLE_MAP, &event);
-		unlock_fb_info(info);
-
 		ret = copy_to_user(argp, &con2fb, sizeof(con2fb)) ? -EFAULT : 0;
 		break;
 	case FBIOPUT_CON2FBMAP:
@@ -1109,12 +1104,8 @@ static long do_fb_ioctl(struct fb_info *
 			break;
 		}
 		event.data = &con2fb;
-		if (!lock_fb_info(info))
-			return -ENODEV;
 		event.info = info;
-		ret = fb_notifier_call_chain(FB_EVENT_SET_CONSOLE_MAP,
-					      &event);
-		unlock_fb_info(info);
+		ret = fb_notifier_call_chain(FB_EVENT_SET_CONSOLE_MAP, &event);
 		break;
 	case FBIOBLANK:
 		if (!lock_fb_info(info))
_
