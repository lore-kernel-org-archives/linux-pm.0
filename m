From: Jiri Slaby <jslaby@suse.cz>
Subject: [RFC 10/15] PM / Hibernate: user,
	implement user_ops reader
Date: Tue, 23 Mar 2010 17:17:38 +0100
Message-ID: <1269361063-3341-10-git-send-email-jslaby__17655.1204560839$1269363250$gmane$org@suse.cz>
References: <1269361063-3341-1-git-send-email-jslaby@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1269361063-3341-1-git-send-email-jslaby@suse.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: jirislaby@gmail.com
Cc: Nigel Cunningham <ncunningham@crca.org.au>, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, Jiri Slaby <jslaby@suse.cz>
List-Id: linux-pm@vger.kernel.org

Switch /dev/snapshot reader to sws_module_ops approach so that we
can transparently rewrite the rest of the snapshot from pages pulling
to their pushing through layers.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Nigel Cunningham <ncunningham@crca.org.au>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
---
 kernel/power/user.c |   73 +++++++++++++++++++++++++++++++++++++++++++++-----
 1 files changed, 65 insertions(+), 8 deletions(-)

diff --git a/kernel/power/user.c b/kernel/power/user.c
index 748567d..1b5d2e1 100644
--- a/kernel/power/user.c
+++ b/kernel/power/user.c
@@ -76,6 +76,7 @@ static DECLARE_BITMAP(to_do_flags, 10);
 #define TODO_FINISH	2
 #define TODO_CLOSED	3
 #define TODO_ERROR	4
+#define TODO_RD_RUNNING	5
 
 static unsigned long user_storage_available(void)
 {
@@ -123,12 +124,41 @@ static int put_user_writer(unsigned int flags, int error)
 	return error;
 }
 
+static int get_user_reader(unsigned int *flags_p)
+{
+	return 0;
+}
+
+static int user_read_page(void *addr, struct bio **bio_chain)
+{
+	int err = 0;
+
+	to_do_buf = addr;
+	wmb();
+	set_bit(TODO_WORK, to_do_flags);
+	wake_up_interruptible(&to_do_wait);
+
+	wait_event(to_do_done, !test_bit(TODO_WORK, to_do_flags) ||
+			(err = test_bit(TODO_CLOSED, to_do_flags)));
+
+	return err ? -EIO : 0;
+}
+
+static int put_user_reader(void)
+{
+	return 0;
+}
+
 struct sws_module_ops user_ops = {
 	.storage_available = user_storage_available,
 
 	.get_writer = get_user_writer,
 	.put_writer = put_user_writer,
 	.write_page = user_write_page,
+
+	.get_reader = get_user_reader,
+	.put_reader = put_user_reader,
+	.read_page = user_read_page,
 };
 
 static void snapshot_writer(struct work_struct *work)
@@ -142,6 +172,22 @@ static void snapshot_writer(struct work_struct *work)
 
 static DECLARE_WORK(snapshot_writer_w, snapshot_writer);
 
+static void snapshot_reader(struct work_struct *work)
+{
+	int ret;
+
+	set_bit(TODO_RD_RUNNING, to_do_flags);
+	ret = swsusp_read(NULL);
+	if (ret) {
+		printk(KERN_ERR "PM: read failed with %d\n", ret);
+		set_bit(TODO_ERROR, to_do_flags);
+	}
+	clear_bit(TODO_RD_RUNNING, to_do_flags);
+	wake_up_interruptible(&to_do_wait);
+}
+
+static DECLARE_WORK(snapshot_reader_w, snapshot_reader);
+
 static int snapshot_open(struct inode *inode, struct file *filp)
 {
 	struct snapshot_data *data;
@@ -287,19 +333,27 @@ static ssize_t snapshot_write(struct file *filp, const char __user *buf,
 
 	mutex_lock(&pm_mutex);
 
+	if (!test_bit(TODO_RD_RUNNING, to_do_flags))
+		queue_work(suspend_worker, &snapshot_reader_w);
+
 	data = filp->private_data;
 
 	if (!pg_offp) {
-		res = snapshot_write_next(&data->handle);
-		if (res <= 0)
+		res = wait_event_interruptible(to_do_wait,
+				test_bit(TODO_WORK, to_do_flags));
+		if (res)
 			goto unlock;
-	} else
-		res = PAGE_SIZE - pg_offp;
+	}
+	res = PAGE_SIZE - pg_offp;
 
-	res = simple_write_to_buffer(data_of(data->handle), res, &pg_offp,
-			buf, count);
+	res = simple_write_to_buffer(to_do_buf, res, &pg_offp, buf, count);
 	if (res > 0)
 		*offp += res;
+
+	if (!(pg_offp & ~PAGE_MASK)) {
+		clear_bit(TODO_WORK, to_do_flags);
+		wake_up(&to_do_done);
+	}
 unlock:
 	mutex_unlock(&pm_mutex);
 
@@ -384,9 +438,12 @@ static long snapshot_ioctl(struct file *filp, unsigned int cmd,
 		break;
 
 	case SNAPSHOT_ATOMIC_RESTORE:
-		snapshot_write_finalize(&data->handle);
+		error = wait_event_interruptible(to_do_wait,
+				!test_bit(TODO_RD_RUNNING, to_do_flags));
+		if (error)
+			break;
 		if (data->mode != O_WRONLY || !data->frozen ||
-		    !snapshot_image_loaded(&data->handle)) {
+				test_bit(TODO_ERROR, to_do_flags)) {
 			error = -EPERM;
 			break;
 		}
-- 
1.7.0.2
