Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042E73F9F4C;
	Fri,  7 Aug 2026 10:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786096956; cv=none; b=oUqQ6NnJFRqzuHnLAh3PlCE0oFKxlOq0KZarDNbj32DBqFCGSpZkUJguvuEtC3kL8nbTYOfDgWT5X8TyOtR4CGFi612sfAKfoIdSjc8fJaNfjYlPOfsBjidnnTRU1bNvdWt1/eqwIyOStKUNtobfBGKwoQfBC03ovzgY0EP32pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786096956; c=relaxed/simple;
	bh=HzKxMRWqgnUrqGjs5xW5rIPpkTGLbuRLIuuAwL4P/BQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ubo6FtJiiOPmBab954M6H9Aqx3xwnGOxQXJ87jkrO8qbEGkVGup3Z6wsJ9d7DWewCQH9/FnY3n1DF8+cppjFw2lYnQ7Z+JOsp+/+86LSFEtvjuQRjT3KzYxMTVc2AHILnn+Ms3uq83OTf4+3eMrtU7z+DRrc6b7HUb7z+oWyAnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=Pr1lB9gH; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="Pr1lB9gH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1786096949;
	bh=tP6FsQWEwYoq2MGkNGhgwZkP1Jh1LVRNF/KcW4T3hFY=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=Pr1lB9gHZO1pq0I/ZRv3RgGmw01vSr6l0zMXXKDds7/pCV2cgVyJqc6nCPTdQbbTc
	 Pr9iRCppgp8ax1RdqRiGIipYKmqaj64YdcwjbI5NZMIYgvvQEip6DalEXDkBR6rHUq
	 esuL/GSIPFbccY6c4RdTkpW21wjsXzaNt8jyVFh0=
X-QQ-mid: zesmtpgz1t1786096944tba2b5ced
X-QQ-Originating-IP: 2ULuDb63Nqk5vrbJn0taO1cZCs7QEGJCr1/P5AoBP6M=
Received: from uniontech.com ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 07 Aug 2026 18:02:21 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 4948339811663763525
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
Subject: [PATCH v3 3/3] debugfs: make debugfs_create_str() read-only
Date: Fri,  7 Aug 2026 18:00:53 +0800
Message-Id: <20260807100053.1089834-4-chenyichong@uniontech.com>
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
X-QQ-XMAILINFO: MUTEK31BCrLQ8y6Wr1p8+MPh3B4BVoyZtepfH4hcdfUp6naAZtJJ4PEu
	EN+6ugMYyJ3nZa8JSVft5Ms5SFG+JcQ42nq1MYRFyZfXtmK3eY9gR/03jV/Nh6dcCpVw9AV
	KmrMW1jCO0eBoYFays8f3V3mTRm4rgIQjiRXcHsVq8aef6Ncbk+Agbt0RjjkX8CBqDSQg+Q
	TiwxL/j+yd6OJ2xETC692YVTlppfs98nn4cPU/nkh0Nw4pS9I02A6pk1+EsTYtrnAIJ1LGk
	Yed6E/VIhsL9BBfLUbGFQyZYoVkoCwUQl3lQgJEjypp+zHe1A7moQeWyVHQrX6bD7Wgij0r
	H2a9DL9kRHnKKslB06zPpwJqaTnqx22m3waN+56Wq/F2PcmPG5vUvlX6LJ2UYGfbLDX741l
	XCZ4d55Se5kGCzzKDroPKWZXjSkla2DIQXF0z3GAnABhtJ4bQx+1/w9pvAzNO6N/+X7e/Y6
	/rCAeihdceTEK5i4ggM6cdesg1hVnz+p1Wxrd0IEILMSaj9NN9w0Vs04LgsW4dhnJPyvj1V
	leN13/pGJvJ2d2IykVkGxpCrvO/aGZO9VGE9dXS+sK1B9ViPjtzvTk591pjrcXAng+Ba/Ct
	EeunaCaylOuzViwPulKkdgUSI59A5ePifP6jibvOaUcsDZRU+B3fjDdHpIH7hFk98jPbDXA
	4S6PSGRefOAIYsE53I87uWOBG/HHOp/Spo3LK6d5s97m8fdUbaIGIPx7GylO/9XvJ11LbjI
	tD4vvnU0KoAetz8NODLFpxjnmuWBbrjiPm4KAe7SNnQrirceP/DTa3M51BzKXBpKXjt4zkB
	RD61OChNO8Xb+byR7d104/2H8nVhY1Dy4k82+5woDwSiu9Wgx0GEkAHVoyHgAZRLoOoF5WK
	WAQGKwr5LC3A2hNBFx7jdhqRAqknHiJ5ce6tDabZ7k1Q4lgEO6ARB1U7zf8yJKIYENazIMk
	eXNbwaUAeDs7j3FphH7j4io1dXCkXtPpTsFCoTQzqYXq+0appGkMusadLuL1KTPS3ktvCgS
	QsIWHmdptCdYj7Ac1QCuQIFX0GL2sFqS0dQrV0AamSfI2BRwl7LGW4NOSAiCqnEfBi3yG/H
	9iO+89jNyfDgsM7GGiwm4/jAj6jhNj+bwif5Pa6RvIVjalYjJcMxCb3oSsoWeMrGnZZNnXb
	SdhQNRG3XF3YhGI=
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
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
index 08de6652a4f3..170feb75317f 100644
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
+	if (WARN(mode & 0222,
+		 "%s() does not support writable files\n", __func__))
+		return;
 
-	debugfs_create_mode_unsafe(name, mode, parent, value, &fops_str,
-				   &fops_str_ro, &fops_str_wo);
+	debugfs_create_file_unsafe(name, mode, parent, value, &fops_str);
 }
 EXPORT_SYMBOL_GPL(debugfs_create_str);
 
-- 
2.51.0

