Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794836350;
	b=pkOftptFx0MM1aQSKJ77kgOkx43QGoKMpqTGzRRm3ZwoL+k9V36Gs6m3Hxm59H/XbI2P
	 m2+DAmv75r/+ncfCjIQjFMsDO4cGYmG7oUwBm9VZNvhgraR+bCxQUcXkqCyLbY1OazVMg
	 j1iIrIMFpClraImgv1CHYQLwwDyPXYbChWMChNlNPFA6tIPOhlvp4Q6cNq7R9hgu/m/KW
	 ojDZfY9vNyXn8YCkq4rePW5VWf1H9loNuOzjRCu+q6n9leKsT6/qMVSiR2dplhqK5oJTR
	 0uvispxmNU4KQtigkmqR1F//UTsgJZnL7xnRHrkZAS3Uv6ndvSn39VqQZv2oihv0/yA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794836350;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Aomv6GqDOeOuDNVYs67SqHc0FBvx3tU6QqK4RBQ0DAM=;
	b=kUPv3EUO39mxNwMAEGs2T4FR98bCyMuntEYcBKMcapzG0IMa835gAC87dfP/2qK0SBae
	 ShzUuzbpF3YRWNKuQC+6eU+fg8O8QsCsb0eTFwKzOGRK4nHS+DyoxgPicVsyHiNSOp6u6
	 VFlDG13xy6Hlp2fUt3ZShld79f0lvSM9UvVeP2opsdEZdPwHPkC7yXfpiIPCy1F2eF+4N
	 ABDOIPmFK6ueYv5axVT+QCMJPEp/wV7gTRCcGdEadDpOrxXJci0ONEAzCnf4qqP//bAbk
	 TExSK/BD3Z04yHyaBEW+IVCZczNNAwpnlPaxqGtTCBGySOhS+jNQ78tpHh+BwTgv8KA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=W6kWR8ur;
	arc=none smtp.remote-ip=209.85.208.50
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53849606A88B
	for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2026 13:39:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53849606A88B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=W6kWR8ur
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6b2237b596cso7927382a12.0
        for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2026 05:39:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794836349; x=1795441149; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Aomv6GqDOeOuDNVYs67SqHc0FBvx3tU6QqK4RBQ0DAM=;
        b=W6kWR8urafdGBHat9SKmyw7CeW2vOlfF0Gq0dpXwQmCwaE2yKu7a9JIat2PcLdseBj
         c2I0sJPrphVR6rSYkbb0A3yOHcWR6X5AcoHMghXhdKFguxtD0PbTnJQl69bGuVGu2VXz
         BLTCsYu/ZtFs8x0AGARBBai5yAKJ7rm2EaZagpqo6y4pg9lH9nSLs+nYI6NWX9ZhaIkL
         YoFlhKWv57yC4up8C44Kwv0e1dWY7V1RhtWgUEZqR37AXn6wlaaFxROrCDDjKta+fGoI
         Np2Hz9ECu2w9TuCa2PiHbWgwv8/1DaoydtqfvnNNx8s4xoXT77W75ujfFQTrbSg5cncn
         n/bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794836349; x=1795441149;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Aomv6GqDOeOuDNVYs67SqHc0FBvx3tU6QqK4RBQ0DAM=;
        b=A5FM9uxywWRMqjtSXz+jhRFCXPq6Ld7UyPBmoJp9qtWHBDaJiJsRaxQUqC4vcqOhiq
         UtsSZqloSd/e4pcCB1rFe0rA0NfW3YkAjZTI0pozCQJq2XSDZvST53okXuyKYiPYStms
         UIvDhqhXKdOYDHKHW+Z9ZJ7+xyEeTyNswi83GkPEEAwuy968DXAoa9G49L4gkWr/dBGi
         /sc5LnmgBKCtrDJCeDwiIQsdeWn5hxdyveFLB7kNsYqVXul2Ajwf9BDV0x/DwJ0WVwMQ
         4s0rYxnPmB2Ef5L31Tet5mAuQLgDCJWOSNStwe/JDBh29L8yCQfxrvLjLALXNWq3I/uU
         UoPQ==
X-Forwarded-Encrypted: i=1; AL+hErEAJg8MTgBRlEGCtD67890sMlRbvFfQ+G+0+AYxI1VSqrzzRt3WIiWY6RHzAP1ymQsDYQgqYZbJlQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z9TKzP4IsbcZE+MaNO7/uDxReTgT1ViRQmKFNOc1BKE4tfFmImB
	mFpcH3A5nSj+ZQagUodDxwjzUQXQMWc6hBb3J0wDKAI1APLo1JRakFVm
X-Gm-Gg: AYBFou2S0+/pbDIwocEmiibMNovwO0GBwQL/Dnw/2IFyYMJ/qsi44aYVDwrhovPpfTq
	tHfFCvHWWv5HoQiLCgAObzwX8+mqkdEDOYdPC9PpMz4lAVIoRrd6DDhBHOPclgnQ4DpgpWy5kfw
	C6WAXyAx6VHkwvYZ92cI97hQJF6/DdtgiPOixe+hbwh324gWH13SpuoTVf242s0JIaUbOSDwVXq
	beJGjDkVzYVp+vUuAH5SakW2d1CmUg/Rg3fvbQKuCGbMCaKUyr0scPp4GGu4zNqTxF28s+ZKtUF
	2VKBpcvmdK3rahCh1qi771WMRikUErqjZxRiHgUoe98evGs+qfHRMcMkbgArUH+/eMQxcjGDdBV
	0NA7Sp+iEHUlFW8kTG7p4BFCswJdm1gsZnOOfPxdlD7ew2leUphdld9wPV+gfQqkycZBLPdI2pI
	znLa6z4GSe6eZPWMn6rY7SaE3t5p/nQEdNwh4nqvR01Qhcfj5W23SIWyDKfb04TjvLN2xpaMvBU
	tPzorVk7HGSSSh+EfLa19++XuB4VGyCInkLeJ5hCc3o8+6VL52kNd8JyRXZLWuZ53ZvP181444v
	59xiRqvc+qy71GnhLEjcIKH7I5VE0vpxg50IGyRPbks/Fff+uNBtRwyikTScMZ9js2cDWGG/S3O
	ZKBFM+lB6l7/ifgtCo5YDK5zBu99m91r4MA26rDRUQ0K+43cY4J6lqURw6lXu2YrfE64rzcGQqw
	2FSD5ecOHIWx+JWtlj5lLpH5u3Kh+37ENfolWMSaHWeEcBB0G06/XlNwNDVI3bV3y1mU8YfoOHQ
	g==
X-Received: by 2002:a17:907:d8c:b0:c40:560a:462 with SMTP id a640c23a62f3a-c5096375806mr930871666b.32.1794836348404;
        Mon, 16 Nov 2026 05:39:08 -0800 (PST)
Received: from Ubuntu.tail0f733b.ts.net (87-205-15-91.static.ip.netia.com.pl. [87.205.15.91])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c50e9b2b5fasm61267066b.35.2026.11.16.05.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 05:39:07 -0800 (PST)
From: Krystian Kaniewski <krystianmkaniewski@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Tejun Heo <tj@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Cc: Ian Kent <raven@themaw.net>,
	Danilo Krummrich <dakr@kernel.org>,
	Johan Hovold <johan@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	driver-core@lists.linux.dev,
	linux-pm@vger.kernel.org,
	autofs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+002fb7b2d0bc53bf7e75@syzkaller.appspotmail.com
Subject: [PATCH v4 1/2] kernfs, sysfs: add SYSFS_NO_SPLICE to refuse splice
Date: Mon, 16 Nov 2026 14:39:02 +0100
Message-ID: <20261116133903.400202-2-krystianmkaniewski@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261116133903.400202-1-krystianmkaniewski@gmail.com>
References: <20261116133903.400202-1-krystianmkaniewski@gmail.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some sysfs stores look up a path written by the user, for example
/sys/power/resume through lookup_bdev(). When the path reaches an
autofs mount, autofs writes a mount request to its daemon pipe while
kernfs holds of->mutex. splice() enters kernfs files with a pipe mutex
held, and writable opens of all kernfs files without mmap share one
lockdep class for of->mutex, so lockdep sees

  &pipe->mutex --> &of->mutex --> &sbi->pipe_mutex --> &pipe->mutex

A splice into any writable kernfs file can add the first edge. A splice
from the autofs daemon pipe into a file whose store looks up the path
is a real deadlock because autofs then waits for the mutex of the pipe
that the splice holds.

Add kernfs_ops->no_splice and SYSFS_NO_SPLICE for such files. The
kernfs splice callbacks return -EINVAL for all opens of a marked file
before the file callback runs. This gives the option one consistent
meaning instead of making splice support depend on the open mode.

Keep separate of->mutex and seq_file lock classes for writable opens
only. Those opens can reach ->write(), while read-only opens cannot
create the reverse dependency. Read-only opens must also stay in their
own class, which commit 16b52bbee482 ("kernfs: annotate different
lockdep class for of->mutex of writable files") split off because
overlayfs takes it under its inode lock. The seq_file lock needs its
own class because a read through a writable open takes of->mutex under
it, while splice from another seq_file takes the shared seq_file class
under a pipe mutex.

Suggested-by: Tejun Heo <tj@kernel.org>
Link: https://lore.kernel.org/r/ec0c2add83f18d7a3c726d5d219dfe42@kernel.org
Signed-off-by: Krystian Kaniewski <krystianmkaniewski@gmail.com>
---
v4:
- Refuse splice for all opens of marked files (Tejun).
- Keep the separate lockdep classes limited to writable opens.
- Add no-splice operations for read-only regular sysfs attributes.

v3:
- Rename SYSFS_LOOKUP and ->may_lookup to SYSFS_NO_SPLICE and
  ->no_splice (Tejun).
- Drop the mmap, prealloc and binary attribute checks (Tejun).

v2:
- Replace the v1 locking changes with per-attribute splice control.
- Preserve splice on read-only opens.
- Split both the open-file mutex and seq_file lock classes.
- Reject incompatible mmap and preallocated-buffer combinations.
- Reject SYSFS_LOOKUP on binary attributes.
- Rebase onto v7.4-rc1.

 fs/kernfs/file.c       | 51 ++++++++++++++++++++++++++++++++++++++----
 fs/sysfs/file.c        | 23 +++++++++++++++++++
 fs/sysfs/group.c       |  4 ++--
 include/linux/kernfs.h |  9 ++++++++
 include/linux/sysfs.h  | 22 +++++++++++++-----
 5 files changed, 97 insertions(+), 12 deletions(-)

diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index cca9f83fc9b5..10ee357b388e 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -620,7 +620,7 @@ static int kernfs_fop_open(struct inode *inode, struct file *file)
 	struct kernfs_root *root = kernfs_root(kn);
 	const struct kernfs_ops *ops;
 	struct kernfs_open_file *of;
-	bool has_read, has_write, has_mmap;
+	bool has_read, has_write, has_mmap, no_splice_write;
 	int error = -EACCES;
 
 	if (!kernfs_get_active(kn))
@@ -649,6 +649,13 @@ static int kernfs_fop_open(struct inode *inode, struct file *file)
 	if (!of)
 		goto err_out;
 
+	/*
+	 * Splice callbacks need this before the iter paths acquire an active
+	 * reference, so cache it while @kn is active.
+	 */
+	of->no_splice = ops->no_splice;
+	no_splice_write = of->no_splice && (file->f_mode & FMODE_WRITE);
+
 	/*
 	 * The following is done to give a different lockdep key to
 	 * @of->mutex for files which implement mmap.  This is a rather
@@ -666,11 +673,19 @@ static int kernfs_fop_open(struct inode *inode, struct file *file)
 	 * lookup helpers for arbitrary paths and readonly files can be read by
 	 * overlayfs from vfs helpers when sysfs is a lower layer of overalyfs.
 	 *
-	 * All three cases look the same.  They're supposed to
+	 * Writable opens of ->no_splice files get a fourth key.  Their
+	 * ->write() may wait for userspace through a pipe, so splice, which
+	 * takes @of->mutex under a pipe mutex, is refused for all opens of
+	 * such files.  Readonly opens keep the readonly key, because the
+	 * fourth key would bring back the overlayfs case above for them.
+	 *
+	 * All four cases look the same.  They're supposed to
 	 * look that way and give @of->mutex different static lockdep keys.
 	 */
 	if (has_mmap)
 		mutex_init(&of->mutex);
+	else if (no_splice_write)
+		mutex_init(&of->mutex);
 	else if (file->f_mode & FMODE_WRITE)
 		mutex_init(&of->mutex);
 	else
@@ -717,6 +732,16 @@ static int kernfs_fop_open(struct inode *inode, struct file *file)
 	of->seq_file = file->private_data;
 	of->seq_file->private = of;
 
+	/*
+	 * seq_read_iter() takes @of->mutex under the seq_file lock, whose key
+	 * is shared with seq_files that can be spliced. Separate it too.
+	 */
+	if (no_splice_write) {
+		static struct lock_class_key seq_no_splice_key;
+
+		lockdep_set_class(&of->seq_file->lock, &seq_no_splice_key);
+	}
+
 	/* seq_file clears PWRITE unconditionally, restore it if WRITE */
 	if (file->f_mode & FMODE_WRITE)
 		file->f_mode |= FMODE_PWRITE;
@@ -889,6 +914,24 @@ static __poll_t kernfs_fop_poll(struct file *filp, poll_table *wait)
 	return ret;
 }
 
+static ssize_t kernfs_fop_splice_read(struct file *in, loff_t *ppos,
+				      struct pipe_inode_info *pipe, size_t len,
+				      unsigned int flags)
+{
+	if (kernfs_of(in)->no_splice)
+		return -EINVAL;
+	return copy_splice_read(in, ppos, pipe, len, flags);
+}
+
+static ssize_t kernfs_fop_splice_write(struct pipe_inode_info *pipe,
+				       struct file *out, loff_t *ppos,
+				       size_t len, unsigned int flags)
+{
+	if (kernfs_of(out)->no_splice)
+		return -EINVAL;
+	return iter_file_splice_write(pipe, out, ppos, len, flags);
+}
+
 static loff_t kernfs_fop_llseek(struct file *file, loff_t offset, int whence)
 {
 	struct kernfs_open_file *of = kernfs_of(file);
@@ -1035,8 +1078,8 @@ const struct file_operations kernfs_file_fops = {
 	.release	= kernfs_fop_release,
 	.poll		= kernfs_fop_poll,
 	.fsync		= noop_fsync,
-	.splice_read	= copy_splice_read,
-	.splice_write	= iter_file_splice_write,
+	.splice_read	= kernfs_fop_splice_read,
+	.splice_write	= kernfs_fop_splice_write,
 };
 
 /**
diff --git a/fs/sysfs/file.c b/fs/sysfs/file.c
index cd5bb0f9fee6..02b98c109bbd 100644
--- a/fs/sysfs/file.c
+++ b/fs/sysfs/file.c
@@ -252,6 +252,22 @@ static const struct kernfs_ops sysfs_prealloc_kfops_rw = {
 	.prealloc	= true,
 };
 
+static const struct kernfs_ops sysfs_no_splice_kfops_ro = {
+	.seq_show	= sysfs_kf_seq_show,
+	.no_splice	= true,
+};
+
+static const struct kernfs_ops sysfs_no_splice_kfops_wo = {
+	.write		= sysfs_kf_write,
+	.no_splice	= true,
+};
+
+static const struct kernfs_ops sysfs_no_splice_kfops_rw = {
+	.seq_show	= sysfs_kf_seq_show,
+	.write		= sysfs_kf_write,
+	.no_splice	= true,
+};
+
 static const struct kernfs_ops sysfs_bin_kfops_ro = {
 	.read		= sysfs_kf_bin_read,
 };
@@ -296,6 +312,13 @@ int sysfs_add_file_mode_ns(struct kernfs_node *parent,
 			ops = &sysfs_prealloc_kfops_ro;
 		else if (sysfs_ops->store)
 			ops = &sysfs_prealloc_kfops_wo;
+	} else if (mode & SYSFS_NO_SPLICE) {
+		if (sysfs_ops->show && sysfs_ops->store)
+			ops = &sysfs_no_splice_kfops_rw;
+		else if (sysfs_ops->show)
+			ops = &sysfs_no_splice_kfops_ro;
+		else if (sysfs_ops->store)
+			ops = &sysfs_no_splice_kfops_wo;
 	} else {
 		if (sysfs_ops->show && sysfs_ops->store)
 			ops = &sysfs_file_kfops_rw;
diff --git a/fs/sysfs/group.c b/fs/sysfs/group.c
index 4e1e4f18a166..ef4cd632ace2 100644
--- a/fs/sysfs/group.c
+++ b/fs/sysfs/group.c
@@ -74,11 +74,11 @@ static int create_files(struct kernfs_node *parent, struct kobject *kobj,
 					continue;
 			}
 
-			WARN(mode & ~(SYSFS_PREALLOC | 0664),
+			WARN(mode & ~(SYSFS_PREALLOC | SYSFS_NO_SPLICE | 0664),
 			     "Attribute %s: Invalid permissions 0%o\n",
 			     (*attr)->name, mode);
 
-			mode &= SYSFS_PREALLOC | 0664;
+			mode &= SYSFS_PREALLOC | SYSFS_NO_SPLICE | 0664;
 			error = sysfs_add_file_mode_ns(parent, *attr, mode, uid,
 						       gid, NULL);
 			if (unlikely(error))
diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
index 73786b567ccd..803294a67e47 100644
--- a/include/linux/kernfs.h
+++ b/include/linux/kernfs.h
@@ -272,6 +272,7 @@ struct kernfs_open_file {
 	char			*prealloc_buf;
 
 	size_t			atomic_write_len;
+	bool			no_splice;
 	bool			mmapped:1;
 	bool			released:1;
 	const struct vm_operations_struct *vm_ops;
@@ -320,6 +321,14 @@ struct kernfs_ops {
 	 * ->prealloc.  Provide ->read and ->write with ->prealloc.
 	 */
 	bool prealloc;
+	/*
+	 * "no_splice" makes all opens refuse splice. Writable opens also get
+	 * separate @of->mutex and seq_file lockdep classes. Set it for a
+	 * ->write() that may wait for userspace, e.g. through a path lookup
+	 * that triggers an automount, so that the write never runs under a
+	 * pipe mutex. Not supported with ->mmap or ->prealloc.
+	 */
+	bool no_splice;
 	ssize_t (*write)(struct kernfs_open_file *of, char *buf, size_t bytes,
 			 loff_t off);
 
diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
index b1a3a1e6ad09..b20ef1c95aa6 100644
--- a/include/linux/sysfs.h
+++ b/include/linux/sysfs.h
@@ -75,12 +75,13 @@ do {							\
  * @is_visible:	Optional: Function to return permissions associated with an
  *		attribute of the group. Will be called repeatedly for
  *		each non-binary attribute in the group. Only read/write
- *		permissions as well as SYSFS_PREALLOC are accepted. Must
- *		return 0 if an attribute is not visible. The returned
- *		value will replace static permissions defined in struct
- *		attribute. Use SYSFS_GROUP_VISIBLE() when assigning this
- *		callback to specify separate _group_visible() and
- *		_attr_visible() handlers.
+ *		permissions as well as SYSFS_PREALLOC and SYSFS_NO_SPLICE
+ *		are accepted. Must return 0 if an attribute is not
+ *		visible. The returned value will replace static
+ *		permissions defined in struct attribute. Use
+ *		SYSFS_GROUP_VISIBLE() when assigning this callback to
+ *		specify separate _group_visible() and _attr_visible()
+ *		handlers.
  * @is_bin_visible:
  *		Optional: Function to return permissions associated with a
  *		binary attribute of the group. Will be called repeatedly
@@ -124,6 +125,8 @@ struct attribute_group {
 
 #define SYSFS_PREALLOC		010000
 #define SYSFS_GROUP_INVISIBLE	020000
+/* All opens refuse splice, not for prealloc or binary attributes */
+#define SYSFS_NO_SPLICE		040000
 
 /*
  * DEFINE_SYSFS_GROUP_VISIBLE(name):
@@ -251,6 +254,13 @@ struct attribute_group {
 	.store	= _store,						\
 }
 
+#define __ATTR_NO_SPLICE(_name, _mode, _show, _store) {			\
+	.attr = {.name = __stringify(_name),				\
+		 .mode = SYSFS_NO_SPLICE | VERIFY_OCTAL_PERMISSIONS(_mode) },\
+	.show	= _show,						\
+	.store	= _store,						\
+}
+
 #define __ATTR_RO_MODE(_name, _mode) {					\
 	.attr	= { .name = __stringify(_name),				\
 		    .mode = VERIFY_OCTAL_PERMISSIONS(_mode) },		\
-- 
2.53.0

