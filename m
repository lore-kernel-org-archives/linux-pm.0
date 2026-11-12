Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794493030;
	b=CQs5r1TrhpgWltxrO+SVUOGMHrXr02qs5F+xgk7vpmMhdO3xbeaXJZLRX3L15NEdcDDO
	 VCvOxoskn06snpGH1Enees7eZQCcJ+vf+Dgq/uwMnR6Pr5lDZGEmyoSTLuV3o7ExSpn0i
	 6z2UJp+dtku08bxANuS1OgjoduIvQSaEi5NcRjq4rW2huF2tvKqag8CqyxmW4+aroAnB3
	 30daLoONi/wNNbEFSuGmozUFh3mKtR1UjOBJjJC+T7qmqcJ0dG4VvNqDTLYCsJTZ4d09r
	 RPT7i9gDv2z6RteHfQwCJllnxPjPCfceaKHaunDElHmqUj665/msLbqOXWQXcXyzD3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794493030;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=boCA2daOQ+TyIVh3xMJHgQmUEAwZI0O8OGy6/w/qqJ8=;
	b=J/LCwXOT8VYqmmiS0m8lLN1FIGnW8eAl2ZhAqQOKMDu5T6/9yuzRd7iCESO41gE/gVEg
	 CAa21svOzUc9qMYkCEQWsACA6tVKyDKsK5qUMJCxilw4/hERU+iSTJ32YlRlrsNgkLrBI
	 BQpmNofoNipwLDyFilLYuf1D1lHKAXyfh6eE6TFhTvnbQYXsLpa7Zv4fBuGGPyGkGoode
	 8hTztDEcCu47q2zMSGrprBiiizxDTNGQv0UTi9XRVnjI43YTjmdLfD9yWAd3gIHguBx/B
	 mX7Gufq4HskhWG4i04XzlqDUlzm74aj3CAoWr+W028H50SnKh7RH3GBgFJfnOEASLrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=USExnjSi;
	arc=none smtp.remote-ip=209.85.218.52
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75DCE606A8BA
	for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 14:17:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 75DCE606A8BA
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=USExnjSi
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c247f6687dcso712730366b.2
        for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 06:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794493028; x=1795097828; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=boCA2daOQ+TyIVh3xMJHgQmUEAwZI0O8OGy6/w/qqJ8=;
        b=USExnjSiP/LTXN4Mt0h9lqHmxkDGOpsgry4uJJB7H7Rl5Mcd1T3KPBqKk3281yt2eq
         JXeRr0zki2fSCez7P2ri3rEL29LwYqkX6HkoIPZkASWMXEoxLRUTQfeIthgiTv49AZV8
         Ah1joV/H7aFPgltphfY+AYFA2Wmp/6umx26g45hrF0Ju3OFm7ZyuEO/IUYuXnY9MiLYT
         03+GQWvPfbP24a0hkt9l8c+MdABB1hQcasxA5nL79OrsvYgLbJUfyDEmqBGV3hzIg45X
         HfKw6yLnkuWOhN4qrZvFb42FcjQHZaZ1yCaHCG1lI4C/smvEXOx+m23BPcePep/zVofr
         0dag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794493028; x=1795097828;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=boCA2daOQ+TyIVh3xMJHgQmUEAwZI0O8OGy6/w/qqJ8=;
        b=UyoBxhyxqqCW4nwUHiyzJuUNSLpBlQ/kTaCXHePj9pZv+TbQ2SF1Ur4sHN1ytpITP9
         Z16048AQeNecGJSsr3ZdxibuHHgSS+MynzxN72ADd+/Jt5QL417gt7tSmkUrBeVHJzwn
         2HOlD/K+vuJMUadbWxD+SnyqOFkYjzX1wFCECzZRkxImv+p5iX7MWzc2vSvQKA1rPW6e
         Q59QrkglqYjHhSs7Fz1MdcGfoxXzHHhtIN/WG0Hdk8NopPU/W8qLPB3Ua7XV2yUFIY/J
         8g3+a1MWZIU55OdUIY6ylV0GmTz3Hx7mMf+BrPNIiAJyswuX4oD458mUh6GH65EEnliI
         GFTg==
X-Forwarded-Encrypted: i=1; AL+hErE6ANkpxX+62XG5Kd10tLbGbRlkqV9f4f7zVxUaUFdPXJDI/+DYypJi361U+62kaS8AeOgFNupVWw==@vger.kernel.org
X-Gm-Message-State: APuU4Z+VWeNmouoMtH9We7kRP/MUTn0g9djKhAyrRcEFcchqeF478A2O
	F4x89WG5sx1BHpME1X0/+NsGPwhguATZlTmgqD4gj+9kTWWyvvI3iu3E
X-Gm-Gg: AYBFou3uOpHNy5kny35Z+FT8o6WahJ3o/TPB68gR4pmGIxT61oSSfXLru6X6I03f/BJ
	XcUp5h9izOwI7NzqyfGfTVgw4qzkE6jeMgtr2YGGs+FnQ8ZxRMN1iB+dWEDaglDFeQr/90iAyaR
	AIxGooOz5+n2qoQSIumEHFs7e+2eJV9O6Qyv/GZt0FhEwoxzJpwUjq3p8bUuJbhtzB9mQ2JACIE
	2YX6qw4XzgVWSmJnFQzqO1W/yJhlEMXrchfU5/9Qzk7XsZuQ7/swgohgBbklsVhKVO/QvBO12WD
	uRWwaZU8UrDPB2HZIxcYVC1RxLQsTbm1O6bmhMmR93diAd7N4uax5F/a315xMw7I8fMrXfXfIbJ
	suKu+4kljQXbd3S0C/Gsq3wK2yX4Y59ueQ5uV96/kEKpoPKMdDqBQHRwIDD/K3v6hITLr24Ujjm
	7jKguWtUKHO6HXYjGkvaQdYosdg3nfSR6q5xesmgq3dJrbtX+scxabNJGs68444L4Xp1jo96B6N
	SMr19vqux/XT4UHcY045jVbC5davBtj9PlOHBq7P9dnJp56HNQrXO2UUCXaGeM1BgQBt2kCALe/
	PMDLqvyocrh7/ku3NIFAERBeYitzw9eRK5sXbG/a9o8j7weOVkwL5IomQNnZhr8UFwamH4Xslax
	NS1PJzLeVHQfqrXRoZfC8NHm74InEV9oNW1ey7FunmX7pawdHy7FVcHfcVaDBvWZN2KhA8YU+lD
	68zXhmfF5OSsSWFUZJBs0OdZ8sUnschRR/egHWFWCNDNOfsYJt+wM=
X-Received: by 2002:a17:907:f816:b0:c49:b952:5425 with SMTP id a640c23a62f3a-c5066ce8350mr454392466b.45.1794493027762;
        Thu, 12 Nov 2026 06:17:07 -0800 (PST)
Received: from Ubuntu (87-205-15-91.static.ip.netia.com.pl. [87.205.15.91])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c504a56b772sm360156466b.16.2026.11.12.06.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 06:17:07 -0800 (PST)
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
Subject: [PATCH v3 1/2] kernfs, sysfs: add SYSFS_NO_SPLICE to refuse splice on writable opens
Date: Thu, 12 Nov 2026 15:17:01 +0100
Message-ID: <f9f3df7a60ecbbacc3186b700deb947d7dc23e9f.1794479968.git.krystianmkaniewski@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1794479968.git.krystianmkaniewski@gmail.com>
References: <cover.1794479968.git.krystianmkaniewski@gmail.com>
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
is a real deadlock, because autofs then waits for the mutex of the pipe
that the splice holds.

Add kernfs_ops->no_splice and SYSFS_NO_SPLICE for such files. Writable
opens of a marked file refuse both splice directions with -EINVAL
before the file callback runs, and their of->mutex and seq_file lock
get lockdep classes of their own. The seq_file lock needs its own class
as well, because a read through such an open takes of->mutex under it,
while a splice from any other seq_file takes the shared seq_file class
under a pipe mutex. Read-only opens keep splice support because they
cannot reach ->write().

Suggested-by: Tejun Heo <tj@kernel.org>
Link: https://lore.kernel.org/r/ec0c2add83f18d7a3c726d5d219dfe42@kernel.org
Signed-off-by: Krystian Kaniewski <krystianmkaniewski@gmail.com>
---
v3:
- Rename SYSFS_LOOKUP and ->may_lookup to SYSFS_NO_SPLICE and
  ->no_splice (Tejun).
- Drop the mmap, prealloc and binary attribute checks, document the
  limits in comments instead (Tejun).

v2:
- Replace the v1 locking changes with per-attribute splice control.
- Preserve splice on read-only opens.
- Split both the open-file mutex and seq_file lock classes.
- Reject incompatible mmap and preallocated-buffer combinations.
- Reject SYSFS_LOOKUP on binary attributes.
- Rebase onto v7.4-rc1.

 fs/kernfs/file.c       | 46 +++++++++++++++++++++++++++++++++++++++---
 fs/sysfs/file.c        | 18 +++++++++++++++++
 fs/sysfs/group.c       |  4 ++--
 include/linux/kernfs.h |  9 +++++++++
 include/linux/sysfs.h  | 22 ++++++++++++++------
 5 files changed, 88 insertions(+), 11 deletions(-)

diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index cca9f83fc9b5..9a0640fb2959 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -649,6 +649,12 @@ static int kernfs_fop_open(struct inode *inode, struct file *file)
 	if (!of)
 		goto err_out;
 
+	/*
+	 * Splice callbacks need this before the iter paths acquire an active
+	 * reference, so cache it while @kn is active.
+	 */
+	of->no_splice = (file->f_mode & FMODE_WRITE) && ops->no_splice;
+
 	/*
 	 * The following is done to give a different lockdep key to
 	 * @of->mutex for files which implement mmap.  This is a rather
@@ -666,11 +672,17 @@ static int kernfs_fop_open(struct inode *inode, struct file *file)
 	 * lookup helpers for arbitrary paths and readonly files can be read by
 	 * overlayfs from vfs helpers when sysfs is a lower layer of overalyfs.
 	 *
-	 * All three cases look the same.  They're supposed to
+	 * Writable opens of ->no_splice files get a fourth key.  Their
+	 * ->write() may wait for userspace through a pipe, so splice, which
+	 * takes @of->mutex under a pipe mutex, is refused for them.
+	 *
+	 * All four cases look the same.  They're supposed to
 	 * look that way and give @of->mutex different static lockdep keys.
 	 */
 	if (has_mmap)
 		mutex_init(&of->mutex);
+	else if (of->no_splice)
+		mutex_init(&of->mutex);
 	else if (file->f_mode & FMODE_WRITE)
 		mutex_init(&of->mutex);
 	else
@@ -717,6 +729,16 @@ static int kernfs_fop_open(struct inode *inode, struct file *file)
 	of->seq_file = file->private_data;
 	of->seq_file->private = of;
 
+	/*
+	 * seq_read_iter() takes @of->mutex under the seq_file lock, whose key
+	 * is shared with seq_files that can be spliced. Separate it too.
+	 */
+	if (of->no_splice) {
+		static struct lock_class_key seq_no_splice_key;
+
+		lockdep_set_class(&of->seq_file->lock, &seq_no_splice_key);
+	}
+
 	/* seq_file clears PWRITE unconditionally, restore it if WRITE */
 	if (file->f_mode & FMODE_WRITE)
 		file->f_mode |= FMODE_PWRITE;
@@ -889,6 +911,24 @@ static __poll_t kernfs_fop_poll(struct file *filp, poll_table *wait)
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
@@ -1035,8 +1075,8 @@ const struct file_operations kernfs_file_fops = {
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
index cd5bb0f9fee6..54f715fe57a8 100644
--- a/fs/sysfs/file.c
+++ b/fs/sysfs/file.c
@@ -252,6 +252,17 @@ static const struct kernfs_ops sysfs_prealloc_kfops_rw = {
 	.prealloc	= true,
 };
 
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
@@ -296,6 +307,13 @@ int sysfs_add_file_mode_ns(struct kernfs_node *parent,
 			ops = &sysfs_prealloc_kfops_ro;
 		else if (sysfs_ops->store)
 			ops = &sysfs_prealloc_kfops_wo;
+	} else if (mode & SYSFS_NO_SPLICE) {
+		if (sysfs_ops->show && sysfs_ops->store)
+			ops = &sysfs_no_splice_kfops_rw;
+		else if (sysfs_ops->show)
+			ops = &sysfs_file_kfops_ro;
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
index 73786b567ccd..2e8466d2c314 100644
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
+	 * "no_splice" makes writable opens refuse splice and gives their
+	 * @of->mutex and seq_file lock separate lockdep classes.  Set it
+	 * for a ->write() that may wait for userspace, e.g. through a path
+	 * lookup that triggers an automount, so that the write never runs
+	 * under a pipe mutex.  Not supported with ->mmap or ->prealloc.
+	 */
+	bool no_splice;
 	ssize_t (*write)(struct kernfs_open_file *of, char *buf, size_t bytes,
 			 loff_t off);
 
diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
index b1a3a1e6ad09..574424760c23 100644
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
+/* Writable opens refuse splice, not for prealloc or binary attributes */
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

