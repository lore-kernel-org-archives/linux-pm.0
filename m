Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7745741F5D7;
	Thu,  6 Aug 2026 08:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786006160; cv=none; b=t5eW969b9JJkK2SkbbpTfGHD3JxX1lDGs8Gd5UOC/6X4bV2sJZcEwP3pCLS87YYAuSvQ8+eTpyk3K3ZDSkqSrMAKBA04TnYFIIUhfzwqWzKtXJ0FZSPddF6LJ1VWDZYoGaN3tPG4+dy4YidSX+oUF6YGKmALC972CVfrMZ6GxEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786006160; c=relaxed/simple;
	bh=bYVn57snV5A2ibN/w2p93lM39rQLKNNKwdn5GeNSJKk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AbL3O5hraBYPt6wOTQg/EzIiTguJV1fjI+ez9wYwjMLepFVP6ENmf39SWL3ahmBcwh6fdmA5WeNljK9ep5FHx55fbvSpmhnAWo9katXz8dcLJED4WXyPyJBKJf2UREaFBCSe3Y5tcFi+wSX4FWaG63sOfTNB1BIvqSKMXGUi/rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=aCC5lC0e; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="aCC5lC0e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1786006153;
	bh=jUyYmBTsmqs0n3Z9OLd2hHj4Q6AzdFTzYfegDmaEhuU=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=aCC5lC0etUx/c+R+V9ajG2gUyWn/t16QIuhIGgl7EmG03GWgJe2b7Q/iBQqw0/ff3
	 /OMdSiSHcWHvHX/fZw9ER0sLjDoETHaCNdo6F9xx/crg6hxFsOyPchQUHZSytX7mh/
	 outJw+2Rk8hcKQyDVeCERIW+nvNk2rwNJbORY0E8=
X-QQ-mid: esmtpgz10t1786006148t22d80378
X-QQ-Originating-IP: D2JFE83FYkgCrQbhtgVWxiQGpFIeUpgu08ldEDCPt7U=
Received: from uniontech.com ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 06 Aug 2026 16:49:06 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 736460180246486777
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
Subject: [PATCH v2 2/3] soundwire: debugfs: replace writable string helper
Date: Thu,  6 Aug 2026 16:48:53 +0800
Message-Id: <20260806084854.1019789-3-chenyichong@uniontech.com>
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
X-QQ-XMAILINFO: MFdGPHhuqhNo67/nlLyAYJWUdVghf09CvV+OMfNdOLweNCXKhS9Yf+Mu
	ayd5xDCMK9oHyEIiS8V7zoafQVzQkAsv5wcXKVUEtd7QdRhXZZNmI5kNMHrpaIwqn02cqZz
	4LQ86jrcXgdfGAhycNLitxEYJRKgtZ32TfsO+/xUF7/fhGAqLa2k2Rui8jwOVpsRnv9kHxn
	qu/mAU5PlAtu0pAsMK7VVN3Wsw6y8pv10Zz6RNzNYTrpHY33cjaE986GzQH+0K1nz9EDRGv
	6s4uUQNkQuE76ql089QjpqTuITb0BAqxWO3l5VjcdVArqfFq/yjFdtFMl1mhHeg3UrB2Ef0
	fI7e6d3G8y0IToBS3PUCnkg3CDNB9VkojD0fOjGEIMUkmItSGZsicMAwaxQP9xNN4zf3U4H
	0tbpgdO0kvf75v3g2C/4NvWnLavRMYajLnJ/KlKnLsPrTWNRx44gCCc0rfywyVIPC+hyFkS
	XmKh0Xpw7Ao3lv7tQ/wH2bQ5fWLja1Ltb5PQBntwgLFroc4tdiD0op45/MeCl/+g65GicOl
	uznHKwCk9eCNLpV+2rW88MyeZoq0HvQJhNDdXHPGU9Dl2WWuKgkuVUkNwKvNbMjwefB64qr
	3Xu74+JkvLNOywaKF/6C6dLTeI7aFaZlnXAawb4Ks7Gp8C/jwGlPPrPgGIces+aXVUQJrdE
	w1HDenCnTh5fdc+dHAWCIR5oDn2VKvCDRbDVB26SnUjyjBjFsIqSECzmJBEtBKcDCQHjYxc
	y3M5KslnlgKyeLGHAiXWwfHsfky+WflOOibSVKnJavx5nLDszF4NnnYdxsah9QT/1RGPAVQ
	3z6kYxbZIZUVKtaEjm8YiODQPdvw56v3ELYqBKTwdmhch3Fu5voyqF+9nAX5zoHsLSXinJR
	1FoziAC8ysD32VWvQsP913jQd7lZXlfKXG8HYdiZW0qPyqqJhpXQHKy7gzrKtcmuqL922j6
	doWnSWNyqc93kZIGzLZTp7O6MeZQ3aCpbd7skKOrdv0POPdVVvWFynubpAT0NGi1nKlV3cC
	B+5yUmXpvYfC7UUE4/OhkDWeMRwuI=
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0

debugfs_create_str() is being made read-only because its generic write path
is hard to make safe without adding more locking to the helper.

Convert the SoundWire firmware_file entry to a local write-only file
operation before removing writable string support from
debugfs_create_str().

Copy the firmware name before request_firmware() so later debugfs writes
cannot replace the string while it is being used.

Signed-off-by: Yichong Chen <chenyichong@uniontech.com>
---
 drivers/soundwire/debugfs.c | 56 ++++++++++++++++++++++++++++++++++---
 1 file changed, 52 insertions(+), 4 deletions(-)

diff --git a/drivers/soundwire/debugfs.c b/drivers/soundwire/debugfs.c
index 099eb84a548e..bba2b65a0668 100644
--- a/drivers/soundwire/debugfs.c
+++ b/drivers/soundwire/debugfs.c
@@ -145,6 +145,38 @@ static u32 start_addr;
 static size_t num_bytes;
 static u8 read_buffer[MAX_CMD_BYTES];
 static char *firmware_file;
+static DEFINE_MUTEX(firmware_file_lock);
+
+static ssize_t firmware_file_write(struct file *file,
+				   const char __user *user_buf,
+				   size_t count, loff_t *ppos)
+{
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
+	mutex_lock(&firmware_file_lock);
+	old = firmware_file;
+	firmware_file = new;
+	mutex_unlock(&firmware_file_lock);
+
+	kfree(old);
+	return count;
+}
+
+static const struct file_operations firmware_file_fops = {
+	.open = simple_open,
+	.write = firmware_file_write,
+	.llseek = default_llseek,
+};
 
 static int set_command(void *data, u64 value)
 {
@@ -246,6 +278,7 @@ static int cmd_go(void *data, u64 value)
 {
 	const struct firmware *fw = NULL;
 	struct sdw_slave *slave = data;
+	char *fw_name = NULL;
 	ktime_t start_t;
 	ktime_t finish_t;
 	int ret;
@@ -265,15 +298,24 @@ static int cmd_go(void *data, u64 value)
 	}
 
 	if (cmd == 0) {
-		ret = request_firmware(&fw, firmware_file, &slave->dev);
+		mutex_lock(&firmware_file_lock);
+		if (firmware_file)
+			fw_name = kstrdup(firmware_file, GFP_KERNEL);
+		mutex_unlock(&firmware_file_lock);
+		if (!fw_name) {
+			ret = -ENOMEM;
+			goto out;
+		}
+
+		ret = request_firmware(&fw, fw_name, &slave->dev);
 		if (ret < 0) {
-			dev_err(&slave->dev, "firmware %s not found\n", firmware_file);
+			dev_err(&slave->dev, "firmware %s not found\n", fw_name);
 			goto out;
 		}
 		if (fw->size < num_bytes) {
 			dev_err(&slave->dev,
 				"firmware %s: firmware size %zd, desired %zd\n",
-				firmware_file, fw->size, num_bytes);
+				fw_name, fw->size, num_bytes);
 			goto out;
 		}
 	}
@@ -306,6 +348,7 @@ static int cmd_go(void *data, u64 value)
 out:
 	if (fw)
 		release_firmware(fw);
+	kfree(fw_name);
 
 	pm_runtime_mark_last_busy(&slave->dev);
 	pm_runtime_put(&slave->dev);
@@ -358,7 +401,8 @@ void sdw_slave_debugfs_init(struct sdw_slave *slave)
 
 	debugfs_create_file("read_buffer", 0400, d, slave, &read_buffer_fops);
 	if (firmware_file)
-		debugfs_create_str("firmware_file", 0200, d, &firmware_file);
+		debugfs_create_file("firmware_file", 0200, d, NULL,
+				    &firmware_file_fops);
 
 	slave->debugfs = d;
 }
@@ -370,8 +414,10 @@ void sdw_slave_debugfs_exit(struct sdw_slave *slave)
 
 void sdw_debugfs_init(void)
 {
+	mutex_lock(&firmware_file_lock);
 	if (!firmware_file)
 		firmware_file = kstrdup("", GFP_KERNEL);
+	mutex_unlock(&firmware_file_lock);
 
 	sdw_debugfs_root = debugfs_create_dir("soundwire", NULL);
 }
@@ -379,6 +425,8 @@ void sdw_debugfs_init(void)
 void sdw_debugfs_exit(void)
 {
 	debugfs_remove_recursive(sdw_debugfs_root);
+	mutex_lock(&firmware_file_lock);
 	kfree(firmware_file);
 	firmware_file = NULL;
+	mutex_unlock(&firmware_file_lock);
 }
-- 
2.51.0

