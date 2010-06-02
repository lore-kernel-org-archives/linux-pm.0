From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 4/9] PM / Hibernate: user,
	implement user_ops reader
Date: Wed,  2 Jun 2010 10:52:43 +0200
Message-ID: <1275468768-28229-4-git-send-email-jslaby__47568.0881333121$1275468847$gmane$org@suse.cz>
References: <1275468768-28229-1-git-send-email-jslaby@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1275468768-28229-1-git-send-email-jslaby@suse.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: rjw@sisk.pl
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, jirislaby@gmail.com
List-Id: linux-pm@vger.kernel.org

Switch /dev/snapshot writer to hibernate_io_ops approach so that we
can do whatever we want with snapshot processing code. All the later
code changes will be transparent and needn't care about different
readers/writers.

In this patch only reader is implemented, writer was done previously.

It works similarly to writer, CONSUMER here is snapshot layer,
PRODUCER is fops->write.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
---
 kernel/power/user.c |   76 +++++++++++++++++++++++++++++++++++++++++++++-----
 1 files changed, 68 insertions(+), 8 deletions(-)

diff --git a/kernel/power/user.c b/kernel/power/user.c
index b4610c3..fb9e5c8 100644
--- a/kernel/power/user.c
+++ b/kernel/power/user.c
@@ -79,6 +79,7 @@ static struct {
 #define TODO_FINISH	2
 #define TODO_CLOSED	3
 #define TODO_ERROR	4
+#define TODO_RD_RUNNING	5
 	DECLARE_BITMAP(flags, 10); /* TODO_* flags defined above */
 } to_do;
 
@@ -131,12 +132,43 @@ static int user_writer_finish(struct hibernate_io_handle *io_handle,
 	return error;
 }
 
+static struct hibernate_io_handle *user_reader_start(unsigned int *flags_p)
+{
+	return hib_io_handle_alloc(0) ? : ERR_PTR(-ENOMEM);
+}
+
+static int user_read_page(struct hibernate_io_handle *io_handle, void *addr,
+		struct bio **bio_chain)
+{
+	int err = 0;
+
+	mutex_lock(&to_do.lock);
+	to_do.buffer = addr;
+	mutex_unlock(&to_do.lock);
+	set_bit(TODO_WORK, to_do.flags);
+	wake_up_interruptible(&to_do.wait);
+
+	wait_event(to_do.done, !test_bit(TODO_WORK, to_do.flags) ||
+			(err = test_bit(TODO_CLOSED, to_do.flags)));
+
+	return err ? -EIO : 0;
+}
+
+static int user_reader_finish(struct hibernate_io_handle *io_handle)
+{
+	return 0;
+}
+
 struct hibernate_io_ops user_ops = {
 	.free_space = user_free_space,
 
 	.writer_start = user_writer_start,
 	.writer_finish = user_writer_finish,
 	.write_page = user_write_page,
+
+	.reader_start = user_reader_start,
+	.reader_finish = user_reader_finish,
+	.read_page = user_read_page,
 };
 
 static void snapshot_writer(struct work_struct *work)
@@ -150,6 +182,22 @@ static void snapshot_writer(struct work_struct *work)
 
 static DECLARE_WORK(snapshot_writer_w, snapshot_writer);
 
+static void snapshot_reader(struct work_struct *work)
+{
+	int ret;
+
+	set_bit(TODO_RD_RUNNING, to_do.flags);
+	ret = swsusp_read(NULL);
+	if (ret) {
+		printk(KERN_ERR "PM: read failed with %d\n", ret);
+		set_bit(TODO_ERROR, to_do.flags);
+	}
+	clear_bit(TODO_RD_RUNNING, to_do.flags);
+	wake_up_interruptible(&to_do.wait);
+}
+
+static DECLARE_WORK(snapshot_reader_w, snapshot_reader);
+
 static int snapshot_open(struct inode *inode, struct file *filp)
 {
 	struct snapshot_data *data;
@@ -300,20 +348,29 @@ static ssize_t snapshot_write(struct file *filp, const char __user *buf,
 
 	mutex_lock(&pm_mutex);
 
+	if (!test_bit(TODO_RD_RUNNING, to_do.flags))
+		queue_work(to_do.worker, &snapshot_reader_w);
+
 	data = filp->private_data;
 
 	if (!pg_offp) {
-		res = snapshot_write_next(&data->handle);
-		if (res <= 0)
+		res = wait_event_interruptible(to_do.wait,
+				test_bit(TODO_WORK, to_do.flags));
+		if (res)
 			goto unlock;
-	} else {
-		res = PAGE_SIZE - pg_offp;
 	}
+	res = PAGE_SIZE - pg_offp;
 
-	res = simple_write_to_buffer(data_of(data->handle), res, &pg_offp,
-			buf, count);
+	mutex_lock(&to_do.lock);
+	res = simple_write_to_buffer(to_do.buffer, res, &pg_offp, buf, count);
+	mutex_unlock(&to_do.lock);
 	if (res > 0)
 		*offp += res;
+
+	if (!(pg_offp & ~PAGE_MASK)) {
+		clear_bit(TODO_WORK, to_do.flags);
+		wake_up(&to_do.done);
+	}
 unlock:
 	mutex_unlock(&pm_mutex);
 
@@ -398,9 +455,12 @@ static long snapshot_ioctl(struct file *filp, unsigned int cmd,
 		break;
 
 	case SNAPSHOT_ATOMIC_RESTORE:
-		snapshot_write_finalize(&data->handle);
+		error = wait_event_interruptible(to_do.wait,
+				!test_bit(TODO_RD_RUNNING, to_do.flags));
+		if (error)
+			break;
 		if (data->mode != O_WRONLY || !data->frozen ||
-		    !snapshot_image_loaded(&data->handle)) {
+				test_bit(TODO_ERROR, to_do.flags)) {
 			error = -EPERM;
 			break;
 		}
-- 
1.7.1
