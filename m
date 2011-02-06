From: Mandeep Singh Baines <msb@chromium.org>
Subject: [PATCH v2] TTY: use appropriate printk priority level
Date: Sun, 6 Feb 2011 09:31:53 -0800
Message-ID: <20110206173153.GT19745__22395.7542017617$1297013600$gmane$org@google.com>
References: <20110125235700.GR8008@google.com>
	<1296084570-31453-5-git-send-email-msb@chromium.org>
	<20110203221346.GA477@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20110203221346.GA477@kroah.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Greg KH <greg@kroah.com>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org, linux-mm@kvack.org, mingo@redhat.com, linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Rebased to apply cleanly against v2.6.38-rc3

---
printk()s without a priority level default to KERN_WARNING. To reduce
noise at KERN_WARNING, this patch set the priority level appriopriately
for unleveled printks()s. This should be useful to folks that look at
dmesg warnings closely.

Signed-off-by: Mandeep Singh Baines <msb@chromium.org>
---
 drivers/tty/vt/vt.c |   15 ++++++++-------
 1 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 147ede3..d5669ff 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -2157,10 +2157,10 @@ static int do_con_write(struct tty_struct *tty, const unsigned char *buf, int co
 
 	currcons = vc->vc_num;
 	if (!vc_cons_allocated(currcons)) {
-	    /* could this happen? */
-		printk_once("con_write: tty %d not allocated\n", currcons+1);
-	    console_unlock();
-	    return 0;
+		/* could this happen? */
+		pr_warn_once("con_write: tty %d not allocated\n", currcons+1);
+		console_unlock();
+		return 0;
 	}
 
 	himask = vc->vc_hi_font_mask;
@@ -2940,7 +2940,7 @@ static int __init con_init(void)
 	gotoxy(vc, vc->vc_x, vc->vc_y);
 	csi_J(vc, 0);
 	update_screen(vc);
-	printk("Console: %s %s %dx%d",
+	pr_info("Console: %s %s %dx%d",
 		vc->vc_can_do_color ? "colour" : "mono",
 		display_desc, vc->vc_cols, vc->vc_rows);
 	printable = 1;
@@ -3103,7 +3103,7 @@ static int bind_con_driver(const struct consw *csw, int first, int last,
 			clear_buffer_attributes(vc);
 	}
 
-	printk("Console: switching ");
+	pr_info("Console: switching ");
 	if (!deflt)
 		printk("consoles %d-%d ", first+1, last+1);
 	if (j >= 0) {
@@ -3809,7 +3809,8 @@ void do_unblank_screen(int leaving_gfx)
 		return;
 	if (!vc_cons_allocated(fg_console)) {
 		/* impossible */
-		printk("unblank_screen: tty %d not allocated ??\n", fg_console+1);
+		pr_warning("unblank_screen: tty %d not allocated ??\n",
+			   fg_console+1);
 		return;
 	}
 	vc = vc_cons[fg_console].d;
-- 
1.7.3.1
