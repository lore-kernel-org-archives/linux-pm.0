Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C72F38DC4A;
	Fri,  7 Aug 2026 10:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786096944; cv=none; b=gDZd+b+o2FyrKTn/Wh08qMjNb2GSWdUmdv7i2Y4m6QZ0/1vwM2WCoBsqgzCCDkDcSqhpqDokO5ku3zNTyNdX9SjVNuPPaL3KrqizBPwDPG0Xt4NkvgMPQv9/mwnM3vzo0SaEVddomdyzgTtLlfO5os47q1ElRThLm65LPNuoVv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786096944; c=relaxed/simple;
	bh=uPOW7rdVMm6V8ePe7kqGvb3eoPcsx/SPyrtcxzDrszY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XtcvloUoT+t0Etd4kK1rUmSWMT3JSdtiMMz4nUX64BwL6VBAolczW6LHYb3ZCtci4heMpg1Z81oXoIydLQVEvbRc2y6triRt/n1VKRMD+wJrOWLdzBkgg9VWLP4OE2rS3b9VEnh6ZJBaB4FzSmSTxRioNWiUiTdj5Cset+M2J4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=nPs6lpcs; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="nPs6lpcs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1786096933;
	bh=6oSMObSXCJFlZ+zBraZAJWfjfuycNvVXrH6aJjGCFLs=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=nPs6lpcs7KpFia53bSPpokRuUGaY5pDltm2JnebhsNgzHCkmjVXhjeijUpQZtcmba
	 rQLVguL34+3kMT8WLow9g12HfcVw9CThE1XVMPhu+vLLTQTQTuVEUxjx/+pe9C//iE
	 ejHtbf/2hLv4guYqSN7pHlXaHwBDU6qvO8Z9mUaI=
X-QQ-mid: zesmtpgz1t1786096928t856e439f
X-QQ-Originating-IP: fyo/Oo8PE3ZjJTPluJGSxT9G72pGfqCeKSGEeMqGfkk=
Received: from uniontech.com ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 07 Aug 2026 18:02:04 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 14027790777046860935
EX-QQ-RecipientCnt: 13
From: Yichong Chen <chenyichong@uniontech.com>
To: gregkh@linuxfoundation.org
Cc: rafael@kernel.org,
	dakr@kernel.org,
	djakov@kernel.org,
	quic_mdtipton@quicinc.com,
	vkoul@kernel.org,
	yung-chuan.liao@linux.intel.com,
	pierre-louis.bossart@linux.dev,
	driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-sound@vger.kernel.org,
	Yichong Chen <chenyichong@uniontech.com>
Subject: [PATCH v3 1/3] interconnect: debugfs: replace writable string helper
Date: Fri,  7 Aug 2026 18:00:51 +0800
Message-Id: <20260807100053.1089834-2-chenyichong@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260807100053.1089834-1-chenyichong@uniontech.com>
References: <20260807100053.1089834-1-chenyichong@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: OdKggonborlkqk16kWhuEWaRL5u6AhHfpC3zLKpOE1yJQPR2w5wdXu30
	X5l4f81IVFOSPSkjXHWjm9Iee55Q0kyxcd785M9D6zGHsXPWZ8mjU7wENLyTU4+rjlduT8B
	UprZoj1TDORdCgGkIuTJ8Jn9ai7NviN+l9TWA6BXGN39V2k9KdYSBeUafanWxuWwE0i1mN/
	aIp59rpfR/1IVQyM24rFMpbrmi1lT5YYRpl/MoQkQTaBxEnAccKsfGIFk/c37ElVFbxo1gA
	c6C9nzpZTXYL35J50jV0JuG/hH+MwMgQ7lWfj4QBjVgAnAXcvSfpCQj1vipLWgiYkUvpUF3
	+LNceRNHEcRIreh+A5NP7RU78qm3RZhshn64hPqo20dBl0/mG9OFEd8ifKF4pkUXwa8ZL99
	XPuhFgs6wgsRW6WoLBx3mmd4qydgHhAR8Rb8WNjJYlSagdymqB87HNCmCfQnFHmreC2b1tl
	YXzzgwzBhDZZIE3QrmO2s00OUVcNJSwiT6nyNsIP+Kl/+T/yxJJ+Xu6GJEtuOLIc1CQidiz
	71t/Sa+86YBCLKIGn50H44BiYitYNcsNoOJ0/zJip+LdGnQQjtZHE26h5wPsmS/1ZdztJFj
	S13keuRKIzLEGCbvCwyDz3is1wAZwEafD14TdIfbfYQb9Fx9iUikG9ocQRxrzjAquGi3N7V
	ZHzU+Rk5IV+JMmfopOQ37gtAX/TFIPJeGfb0Y5v/jqIgZDUMLmvF7tWmeWZATtBYFtlk3/J
	dECBxXtzkJrmyiOlNb4j73g/sdEnHARiUuTUUQe3J5pu7LIHvmZpV5jPg/eZpmdHFjkJYbj
	BNfBKm2oivXDlt+dCV7QNWMMpjLhSB7PetDA88k4bswCU7A4YN+bbYdr3dQhNFEKTwDdLM3
	DwNTOiBDiYL+v/fa6VjbmTCEBDGSe3lKR5S+VsQdcII+SVnc2/gurNSwhT/VFbuJA1HRPhR
	yQJ2oUUoH4U0xbXaXNH4HfzI71w510eLr2mkyVhBRrB5cHglITNkp2TFihvQSDdo4c4l8el
	i0+ccd/y6EE8qdRyIxyPoUjPpxZb5vx3DmYmAP4Eca8fSvIJyd4H1jmwu58pA/GtbJn/4iH
	sWWKCSysnPBXxek+MPii2i7PolINn+ofhHoq7tiIH9oNGM4yMIGvK2Bhn50mqOj2F9K0al0
	x+RG
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0

debugfs_create_str() is being made read-only because its generic write
path is hard to make safe without adding more locking to the helper.

Convert the interconnect debugfs client src_node and dst_node entries to
local file operations before removing writable string support from
debugfs_create_str().  Protect the string replacement and path lookup with
the existing debugfs_lock.

The old code duplicated the strings under rcu_read_lock(), so it had to use
GFP_ATOMIC.  The local file operations protect src_node and dst_node with
debugfs_lock instead, so the allocation can use GFP_KERNEL.

Signed-off-by: Yichong Chen <chenyichong@uniontech.com>
---
 drivers/interconnect/debugfs-client.c | 81 +++++++++++++++++++++------
 1 file changed, 64 insertions(+), 17 deletions(-)

diff --git a/drivers/interconnect/debugfs-client.c b/drivers/interconnect/debugfs-client.c
index 08df9188ef94..c587fbf519c6 100644
--- a/drivers/interconnect/debugfs-client.c
+++ b/drivers/interconnect/debugfs-client.c
@@ -5,6 +5,7 @@
 #include <linux/debugfs.h>
 #include <linux/interconnect.h>
 #include <linux/platform_device.h>
+#include <linux/slab.h>
 
 #include "internal.h"
 
@@ -36,6 +37,59 @@ struct debugfs_path {
 	struct list_head list;
 };
 
+static ssize_t icc_node_read(struct file *file, char __user *user_buf,
+			     size_t count, loff_t *ppos)
+{
+	char **node = file->private_data;
+	char *copy;
+	size_t len;
+	ssize_t ret;
+
+	scoped_guard(mutex, &debugfs_lock) {
+		copy = kstrdup(*node ?: "", GFP_KERNEL);
+	}
+	if (!copy)
+		return -ENOMEM;
+
+	len = strlen(copy);
+	copy[len++] = '\n';
+	ret = simple_read_from_buffer(user_buf, count, ppos, copy, len);
+	kfree(copy);
+	return ret;
+}
+
+static ssize_t icc_node_write(struct file *file, const char __user *user_buf,
+			      size_t count, loff_t *ppos)
+{
+	char **node = file->private_data;
+	char *old, *new;
+
+	if (*ppos)
+		return -EINVAL;
+	if (count + 1 > PAGE_SIZE)
+		return -E2BIG;
+
+	new = memdup_user_nul(user_buf, count);
+	if (IS_ERR(new))
+		return PTR_ERR(new);
+	strim(new);
+
+	scoped_guard(mutex, &debugfs_lock) {
+		old = *node;
+		*node = new;
+	}
+
+	kfree(old);
+	return count;
+}
+
+static const struct file_operations icc_node_fops = {
+	.open = simple_open,
+	.read = icc_node_read,
+	.write = icc_node_write,
+	.llseek = default_llseek,
+};
+
 static struct icc_path *get_path(const char *src, const char *dst)
 {
 	struct debugfs_path *path;
@@ -54,26 +108,19 @@ static int icc_get_set(void *data, u64 val)
 	char *src, *dst;
 	int ret = 0;
 
-	mutex_lock(&debugfs_lock);
-
-	rcu_read_lock();
-	src = rcu_dereference(src_node);
-	dst = rcu_dereference(dst_node);
+	guard(mutex)(&debugfs_lock);
 
 	/*
 	 * If we've already looked up a path, then use the existing one instead
 	 * of calling icc_get() again. This allows for updating previous BW
 	 * votes when "get" is written to multiple times for multiple paths.
 	 */
-	cur_path = get_path(src, dst);
-	if (cur_path) {
-		rcu_read_unlock();
+	cur_path = get_path(src_node, dst_node);
+	if (cur_path)
 		goto out;
-	}
 
-	src = kstrdup(src, GFP_ATOMIC);
-	dst = kstrdup(dst, GFP_ATOMIC);
-	rcu_read_unlock();
+	src = kstrdup(src_node, GFP_KERNEL);
+	dst = kstrdup(dst_node, GFP_KERNEL);
 
 	if (!src || !dst) {
 		ret = -ENOMEM;
@@ -105,7 +152,6 @@ static int icc_get_set(void *data, u64 val)
 	kfree(src);
 	kfree(dst);
 out:
-	mutex_unlock(&debugfs_lock);
 	return ret;
 }
 
@@ -115,7 +161,7 @@ static int icc_commit_set(void *data, u64 val)
 {
 	int ret;
 
-	mutex_lock(&debugfs_lock);
+	guard(mutex)(&debugfs_lock);
 
 	if (!cur_path) {
 		ret = -EINVAL;
@@ -130,7 +176,6 @@ static int icc_commit_set(void *data, u64 val)
 	icc_set_tag(cur_path, tag);
 	ret = icc_set_bw(cur_path, avg_bw, peak_bw);
 out:
-	mutex_unlock(&debugfs_lock);
 	return ret;
 }
 
@@ -160,8 +205,10 @@ int icc_debugfs_client_init(struct dentry *icc_dir)
 
 	client_dir = debugfs_create_dir("test_client", icc_dir);
 
-	debugfs_create_str("src_node", 0600, client_dir, &src_node);
-	debugfs_create_str("dst_node", 0600, client_dir, &dst_node);
+	debugfs_create_file("src_node", 0600, client_dir, &src_node,
+			    &icc_node_fops);
+	debugfs_create_file("dst_node", 0600, client_dir, &dst_node,
+			    &icc_node_fops);
 	debugfs_create_file("get", 0200, client_dir, NULL, &icc_get_fops);
 	debugfs_create_u32("avg_bw", 0600, client_dir, &avg_bw);
 	debugfs_create_u32("peak_bw", 0600, client_dir, &peak_bw);
-- 
2.51.0

