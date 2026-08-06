Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105C242046D;
	Thu,  6 Aug 2026 08:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786006158; cv=none; b=BJ7QE+R2g/62Sw3gR3mMvwoiOQCSJY3/gvkHvtWuJNbeayJcW4DvfxbfPxW9zm9QohUBAWUk83UxYc2hA9sy82y2SCRbeSjoLhyOeTT23UxwgR9Qv3v/qLr7SNzobVm2E2LFsaqpnrp035PC6bQvEFkR4/JBls2v9gpFnUh2nN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786006158; c=relaxed/simple;
	bh=ARu3eo+AzmCY/i1tQVvRQ0wec1DQQyp45sCuLGUpD9k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uKgbSDJ0rsDsEPcPQO+jLdHWc90rvIQDElg8M42ipV1UM0gnsw4JlNhrSMI+kVQ7dV94Iwxmv22ca4OIXV50ex9/hFFcvzjNCR4xraFDloESkHfBJziqenswDUT0KZfydM63D0p1wBoi2Mui4aU8asmq/BvH4oRflr6qJ20EugA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=gVQP7gZV; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="gVQP7gZV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1786006148;
	bh=whvAXfqcI/2CG+KFaVGKysE7QcfBGYNfN6vsf1EJrf4=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=gVQP7gZVdKytT57ApaymSDmAndk3/WuerH6KsQDBlh7NOrFZWE2W530oQEINnsGUd
	 gtgIkQ8BkKEBsXL4+VeNXWQNPhK/2852fUX3bYOyxE0j+fBreiSc8wEyLGGUxnvolt
	 qtPOGEgbwo8Zou/7d8wCdpIUCmG61X24m5IDiaQU=
X-QQ-mid: esmtpgz10t1786006143tdf8f9d1c
X-QQ-Originating-IP: uf6iFDgW7rDy3zzGqYADMSBmyCO/dnFQ3AfidrBp4r0=
Received: from uniontech.com ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 06 Aug 2026 16:49:01 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 14852656375599871192
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
Subject: [PATCH v2 1/3] interconnect: debugfs: replace writable string helper
Date: Thu,  6 Aug 2026 16:48:52 +0800
Message-Id: <20260806084854.1019789-2-chenyichong@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260806084854.1019789-1-chenyichong@uniontech.com>
References: <20260806084854.1019789-1-chenyichong@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: OOUQvGxx3FuKT1ccC4wXGAub6zfA6hpHG9/PCXlMXNBRtQTj0L1pZoIH
	IgjypweprwOalbgN/rkD2KGEYhKlgaSGZpQuqhbiqTNhe2Hn/g+RxL70iWqjCAAyjbry2YS
	JRBmBcbGqvV8dEuNL9qF2c4A+PZmvhY+kmpTUGq/VN5ffihTob9EIhEolE/0GdTxLJ/1hyJ
	DwS8RCAov6tmN9N4mmQGBJbmOB3deZNgued4M9prZt+X/nWa/0keCcOvRlPi0KOqDzea+T7
	hfrUq2FOoplrLb9HusFoU9Z79MkBi0SqDWV6YpqLMn3MabnjQJ34TzPntWL9RqM2J55d+Fu
	UGZMU+X0+2PnQ94MQKBoWibC8gmHtxjsKQR9UHzULm33EGVARycL7gIsTspOcyZfWdwSHLu
	93J0I4O/kyE3WaR/EbJPsG8twmkmPvQFnUG3/KtqW8j9kfMVx22migXiz/mL+3R25IXtdVx
	zEYtfydSfC7F2roY3HizOAn8DFmoUzCOLUXikqs62+sn5NtcjiSHyxWL6IpZtA6oOksmNhQ
	TiYfc4P7aTTXDGRcNY8mWHGpOlGnS78batPW78+mk3nTN1oFhYyOtY6/y8DvdWK1fRm8sS0
	UIZ3MOyghr9KVXq1Oqy1IDb3BLiZtuA6zYrfeVZmAcWz7xOwZ+AJALYhvXig+D6X8jlQm/N
	BH/EK0mWrcMyTskbH6MCqoEpMpl8p2J+JGjGHhVA1on4RyV25kp+FOW6EtBebbcRZNd7FT5
	QVnJ65SscZjZwj5ztkWSnqp9pdzoS49w6y4DLlqYMxNTX30nHeMn8AsOfxknphWMn56W/Uc
	K7B0fSR9vVFbbJrU9F3B63eCNjdVaCxBqJJp/eFwsgxSeVWNceuBqs/SyVmdGXPhCVavNN2
	gu7Gy/7hnCeYr9dPBx/R4p3619NN5dUKpC2u8PEPh8DOm0MEuNCHK5I/Yp8tVGKXZ+UUJ8e
	PVez+kn/N++tMv01bGFmvmXFrAUc+LrtxwW6IL16hutqg0d9Pu446poRm7F+TNhyxv6xi5L
	M2S+/lZloe/95dsakawBLEEZ3ur0QTJQuqPMLqw1Nvi7vFBUIa
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-RECHKSPAM: 0

debugfs_create_str() is being made read-only because its generic write path
is hard to make safe without adding more locking to the helper.

Convert the interconnect debugfs client src_node and dst_node entries to
local file operations before removing writable string support from
debugfs_create_str().  Protect the string replacement and path lookup with
the existing debugfs_lock.

Signed-off-by: Yichong Chen <chenyichong@uniontech.com>
---
 drivers/interconnect/debugfs-client.c | 75 ++++++++++++++++++++++-----
 1 file changed, 62 insertions(+), 13 deletions(-)

diff --git a/drivers/interconnect/debugfs-client.c b/drivers/interconnect/debugfs-client.c
index 08df9188ef94..b71c25fd9314 100644
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
+	mutex_lock(&debugfs_lock);
+	copy = kstrdup(*node ?: "", GFP_KERNEL);
+	mutex_unlock(&debugfs_lock);
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
+	mutex_lock(&debugfs_lock);
+	old = *node;
+	*node = new;
+	mutex_unlock(&debugfs_lock);
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
@@ -56,24 +110,17 @@ static int icc_get_set(void *data, u64 val)
 
 	mutex_lock(&debugfs_lock);
 
-	rcu_read_lock();
-	src = rcu_dereference(src_node);
-	dst = rcu_dereference(dst_node);
-
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
@@ -160,8 +207,10 @@ int icc_debugfs_client_init(struct dentry *icc_dir)
 
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

