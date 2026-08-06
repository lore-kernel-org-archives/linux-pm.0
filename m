Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4961441F5C8;
	Thu,  6 Aug 2026 08:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786006164; cv=none; b=fXejqh37ohU6OXT1WI56OlIGdDON+ngUuEQe9jLh6GjOGAgpEWsERZq372xBdcBsxQZBrJH7YdBoCQzrDLBr5kmk3lE8cY5B1nWaa1QbQ41cn1wal/DoChxtrHWxmm9+RVtCtdZB+TMyxDodOzeA8OuZshZRIiRlCX2a0C/bUgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786006164; c=relaxed/simple;
	bh=ePp+RxiutBCyzzEvl5K1dmKuPb/y40CYrZgkRG5vNg0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CzkBfx2wdontdI+UpzbdJla4eDqtYTQabnkAmKaRNdvYDmahu51z0CEUe5ZnZvMb7sacJPzYsGCiOKLyxfVeiwSvEVXaL5RGXdQgGspSMl+dUJBIZHuUS8AU2CbI5j8PBlA4Hn1uoI5FQOrlqSqYyg48AnLX9PJ2USB9IEq8fSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=LqbrOUy2; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="LqbrOUy2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1786006157;
	bh=qvo8GnxR4HBw5KUhU+lgGsArbxbsBLDwyjUKHDJAdeY=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=LqbrOUy2TqqM0OtmFMg1/aUcsufALMPN0WLPugFfgvfYGAHSNMdnqjCmqaW3ywnan
	 bZw8xMgQnOX7SEuRn+bmzVftjP7xDhZgBnh7uMlZK4bB2w+2UJZlqYf+PDSrfrr54Z
	 85fsL5X+JGjQKvsIwLyuqnSuS2vG4cKgjQ9Y7a7Q=
X-QQ-mid: esmtpgz10t1786006153t5a193209
X-QQ-Originating-IP: JVhbFHdaKldKfaSuDbI31KdscLgt26kiGyz/MsQ1sFk=
Received: from uniontech.com ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 06 Aug 2026 16:49:10 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 11587436272673348081
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
Subject: [PATCH v2 3/3] debugfs: make debugfs_create_str() read-only
Date: Thu,  6 Aug 2026 16:48:54 +0800
Message-Id: <20260806084854.1019789-4-chenyichong@uniontech.com>
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
X-QQ-XMAILINFO: Mh1JMxfliF/1MGldjCRDRJRwJtAVKKQlCrJHxteiApDdMbhGrm5tquH/
	Xv2XAbGoAvGCCXOWJHRwTVf/YfbF/FmeNzF5WC6Yr43wkBJUXlgR9/iUAK/uAtBeGQsWr9m
	wdGWkW0aq3DId0HWZvyWUeqhC1XdDugPtOsqSamTb7KjXlY1hMUCXWtSoJxss8eYTmuxdfq
	GsKdXDCVXmssOi84PBSKMkBHrN6/FwMUny0sKWt6nAYr5lDQV5A1wzxeqSZcqaFiMbDCNTz
	gwZfIf7qnIsH7NsQpUd/tdSjetbmHo5hZvsxvDnfijhsMBhz09H5IQw5DeurlRt45woT2l3
	0qKBQxJXL510ZFk9OqvMW8qTTltzcPNKTVlZxJv9wPvRR8EjnVC4ImyyfWXRFxeq8ZvQDNK
	OxTIPptbGPzKBaObMMiAQJVAi8AQC/ori1i5raCkp+OFaX1P1+PyiIRfDnfb85Y2jUWJe73
	tHOxPqoieiD0qCqPRVsIvYnYiiBbwaCTIe+SAMI0oRAX28Ong0K/LuaUTL8KYOLXpHWZNZA
	s+FQZseN0ZXVZdz93IlLKH0vUg8QmII6iUl7EvMeZruTtS4qpDZ0P2gCuqobCEztG61hpum
	vPg6Dv6LpTOPF7eCRULC0HU846i5tK6LlTnXpFHEiTs9WhBZqvfScb/i3/AUK5s/Eg10B2e
	7l3uHbFuPs3WZqvelvKMf/UwoefKHQJYuhaV6MLvVT7si5jNVlTiC+HXWALSWjV8dPSEhdZ
	DXWeLqTmVhWkG/2VX+fErGB/EYo4rc4D/4ApKMsZ5Mz1dkHSl9bVR49xQC5UJzcu+MUGywq
	sh8XwyreqvfFDmAtEixuq2TXZg9HBLZ8VTTyN+bcLHh6dLPLkEP/N0r3NkqBC1w3cW35Bil
	y0ZYA1/O6zhuDAaBu6OquWo8YzfRJrn581IA1VOOfWfgAkVSTZSVQsnNmiGiBpKVO71ZrwE
	vxxSUItxROxg766dTOQJCJ9T9oIcGVcrFRbL034EyWmHz0CWvLIN0RzmUys5esdHAx4gp2l
	xL1Qrgwjgg4XPCnPzjfycGHMnXfPwM2b0sAZm6HRT0OBMgBU+r6hn/QS5dWWU=
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-RECHKSPAM: 0

debugfs_create_str() supports replacing the backing string from userspace.
Concurrent writers can race and free the same old string twice.

All writable in-tree users have been converted to local file operations.
Remove the generic write support from debugfs_create_str(), and refuse to
create a file when the caller passes write permission bits.

This makes unsupported writable use visible instead of silently creating a
file with different permissions.

Fixes: 86b5488121db ("debugfs: Add write support to debugfs_create_str()")
Signed-off-by: Yichong Chen <chenyichong@uniontech.com>
---
 fs/debugfs/file.c | 81 ++++++-----------------------------------------
 1 file changed, 10 insertions(+), 71 deletions(-)

diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
index 08de6652a4f3..f5abd067b260 100644
--- a/fs/debugfs/file.c
+++ b/fs/debugfs/file.c
@@ -1049,98 +1049,37 @@ ssize_t debugfs_read_file_str(struct file *file, char __user *user_buf,
 	return ret;
 }
 
-static ssize_t debugfs_write_file_str(struct file *file, const char __user *user_buf,
-				      size_t count, loff_t *ppos)
-{
-	struct dentry *dentry = F_DENTRY(file);
-	char *old, *new = NULL;
-	int pos = *ppos;
-	int r;
-
-	r = debugfs_file_get(dentry);
-	if (unlikely(r))
-		return r;
-
-	old = *(char **)file->private_data;
-
-	/* only allow strict concatenation */
-	r = -EINVAL;
-	if (pos && pos != strlen(old))
-		goto error;
-
-	r = -E2BIG;
-	if (pos + count + 1 > PAGE_SIZE)
-		goto error;
-
-	r = -ENOMEM;
-	new = kmalloc(pos + count + 1, GFP_KERNEL);
-	if (!new)
-		goto error;
-
-	if (pos)
-		memcpy(new, old, pos);
-
-	r = -EFAULT;
-	if (copy_from_user(new + pos, user_buf, count))
-		goto error;
-
-	new[pos + count] = '\0';
-	strim(new);
-
-	rcu_assign_pointer(*(char __rcu **)file->private_data, new);
-	synchronize_rcu();
-	kfree(old);
-
-	debugfs_file_put(dentry);
-	return count;
-
-error:
-	kfree(new);
-	debugfs_file_put(dentry);
-	return r;
-}
-
 static const struct file_operations fops_str = {
 	.read =		debugfs_read_file_str,
-	.write =	debugfs_write_file_str,
-	.open =		simple_open,
-	.llseek =	default_llseek,
-};
-
-static const struct file_operations fops_str_ro = {
-	.read =		debugfs_read_file_str,
-	.open =		simple_open,
-	.llseek =	default_llseek,
-};
-
-static const struct file_operations fops_str_wo = {
-	.write =	debugfs_write_file_str,
 	.open =		simple_open,
 	.llseek =	default_llseek,
 };
 
 /**
- * debugfs_create_str - create a debugfs file that is used to read and write a string value
+ * debugfs_create_str - create a debugfs file that is used to read a string value
  * @name: a pointer to a string containing the name of the file to create.
  * @mode: the permission that the file should have
  * @parent: a pointer to the parent dentry for this file.  This should be a
  *          directory dentry if set.  If this parameter is %NULL, then the
  *          file will be created in the root of the debugfs filesystem.
- * @value: a pointer to the variable that the file should read to and write
- *         from. This pointer and the string it points to must not be %NULL.
+ * @value: a pointer to the variable that the file should read from. This
+ *         pointer and the string it points to must not be %NULL.
  *
  * This function creates a file in debugfs with the given name that
- * contains the value of the variable @value.  If the @mode variable is so
- * set, it can be read from, and written to.
+ * contains the value of the variable @value.  The file can be read from.
+ * Writable files are not supported; if @mode contains write permission bits,
+ * no file is created.
  */
 void debugfs_create_str(const char *name, umode_t mode,
 			struct dentry *parent, char **value)
 {
 	if (WARN_ON(!value || !*value))
 		return;
+	if (WARN_ONCE(mode & 0222,
+		      "%s() does not support writable files\n", __func__))
+		return;
 
-	debugfs_create_mode_unsafe(name, mode, parent, value, &fops_str,
-				   &fops_str_ro, &fops_str_wo);
+	debugfs_create_file_unsafe(name, mode, parent, value, &fops_str);
 }
 EXPORT_SYMBOL_GPL(debugfs_create_str);
 
-- 
2.51.0

