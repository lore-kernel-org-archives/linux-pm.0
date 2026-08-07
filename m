Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD933F788F;
	Fri,  7 Aug 2026 10:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786096953; cv=none; b=mGWmcul2iO/XY7Ea7MyDEQf5arxzSO87a0uL59kx61MQuv2nG2jltiPtyE0+850ycrnj09CsKKbUZaaRkXriOagkik0Zs26jPRVVvuFPelBWTt8J+WFBvbjp9BdDPAzwY4LGcacUuInjOZ7meoCldABo6BSHE9bsvfn3LWOFqP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786096953; c=relaxed/simple;
	bh=sTB+q2yGXMUFFVb/puERdZJCmbQ4/NCEbjGWkoO3doQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eUsbFCGVFNig5HgVM9wHWot7IErAFVMwmMGDBs/cUeyXpELFSotlIPaSfnhVx9x9X0h90kaXqsFoza6O/VhvPOqgwjYKnpuYpgVGOgbE/rR/bL6Q38ih4HIeD5IAPYbVuP9WxQY5yt5E2uJ4jlPRcM3nPUZErjeTs1OWHLXzgZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=RT68QvRk; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="RT68QvRk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1786096943;
	bh=MsDLrJziY9sfCbxEdR4Mn3VYin9jFIv1p9TVwvNq7cs=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=RT68QvRkmS6GFP8VPC9D7ibZzoyK8U6EMDrk4mRWVnOU+SxSGPsaRkZCr8Ht4mNVR
	 0yv/qgsG4JiDW+w1UtEvqgupnbLa07BPfx5tasB4rCYVfzHymaoa7FB/4FKOc9egX4
	 9yg+TVLrcLTEQJodUGWy1KwgTa04OzKYBquifvgY=
X-QQ-mid: zesmtpgz1t1786096938ta3e5e1b1
X-QQ-Originating-IP: S+p1emIyL/pTOuj2FrBZ+LochIXhVzo8lbfR6Q1S5xI=
Received: from uniontech.com ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 07 Aug 2026 18:02:11 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 17825993322717190689
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
Subject: [PATCH v3 2/3] soundwire: debugfs: replace writable string helper
Date: Fri,  7 Aug 2026 18:00:52 +0800
Message-Id: <20260807100053.1089834-3-chenyichong@uniontech.com>
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
X-QQ-XMAILINFO: MQDQK+Kntirdn/cSaOaPwK7oA35F8fAKjjK82ATkRHliwn2gC2mVUq+p
	utiiPcnmlxYopOaHuHYyh/4yNViZcVgx8fAffx6LsUCqvD+BDKlRxTcxAs/hgW8fMTtkZ2P
	M+dJZVccETn5hj+eq8z1NIjMQ0upneMyPdJSALltgpdR3YncpL+af9svLoW/Ssc/YGMqdeB
	8ua/+xoiDgSnxE8OGxbVgzCYkrXfzYR7wf+xIWetCujWAJp5mfVASBCHKhKzzoxifZstMNL
	BpTG6Ad/u/rEgMiXPp1eNa4k96CaRo3zbcl6aJOFkneGSZ6wTUH8ex/dLnguLlibJVHhVsr
	9fdRrBQ39EH/c/9i11rCZzsTFaYcmHIdtF6UPLzq4xCMSmwyLnfh6+K78x71y4NyQ41NQT8
	vLncGaTuU1QTzwJQUUt3L6qIEFc6RVnqx3P8fQzy0IjrJZKXb3wXZBLs9f1k+xxPUNyCncq
	H5GK06AIAupRWaRiFTZ453nRHUM+JRNj3P15aCrjZmh7cWbjl3Y1+4bEpsXmZhtKgAyH7SS
	sWKDN0ZATdzkx73JbP0o3euIQ3bQZAIP3T/xIGCHnjloOgMXSCTL85t2vuqcL5scW19tGQm
	iDfGu/HsJw+EEhjEgdhYMAeRWV2vmkm7Kpmd4yY22eAR3glPoHEtM0tattnfMDgqTUl5xK1
	ZveO1ylpAt1hfv8cSwe1fFqwdI3IQ7jaTHXGFQ4FrqgDyjebcUPbyohoSl9xmXSadfmSwKO
	0hYOO/9EnI0YgrNvnR26VExDh/JL1VXh8O5X42C3CK4PQTISHKfFyOJLrYArR4rzLwA+v1t
	GpM25whbUagXSYdmtKFSzsUrEegtvVHnOz5LESm5ER8tLddrpJ09glZMpZBLOky0SdU7cNi
	DHJI6QC3p3AoRZXo89l6jgwVI9w46tsseX8pL7BVSh8/mR1WUKzh3F9eFuQuyDDFbfdR0yu
	6BzcNL+HOR5crhlsOU4F6eDBjA8F57ge0AE0Fp24BOqPy+Lu7KakndrSKjwuKCLqbYXv1qM
	uBsB456ku13bImqHrMzU8vOHpCVopooNHTyGfAvOx4A/IMzBin7G/PO072YGeTMRxC8fopm
	BwMXFcF6tYyqexrQ3qjm6rPxOv/bMWT4DrsOwMKSTDD0eh7BfVM0XTACKiZhIDGkbl6qOBJ
	jg0T
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0

debugfs_create_str() is being made read-only because its generic write
path is hard to make safe without adding more locking to the helper.

Convert the SoundWire firmware_file entry to a local write-only file
operation before removing writable string support from
debugfs_create_str().

Copy the firmware name before request_firmware() so later debugfs writes
cannot replace the string while it is being used.

Signed-off-by: Yichong Chen <chenyichong@uniontech.com>
---
 drivers/soundwire/debugfs.c | 63 ++++++++++++++++++++++++++++++++-----
 1 file changed, 55 insertions(+), 8 deletions(-)

diff --git a/drivers/soundwire/debugfs.c b/drivers/soundwire/debugfs.c
index 099eb84a548e..a8a6db164fe7 100644
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
+	scoped_guard(mutex, &firmware_file_lock) {
+		old = firmware_file;
+		firmware_file = new;
+	}
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
+		scoped_guard(mutex, &firmware_file_lock) {
+			if (firmware_file)
+				fw_name = kstrdup(firmware_file, GFP_KERNEL);
+		}
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
-	if (!firmware_file)
-		firmware_file = kstrdup("", GFP_KERNEL);
+	scoped_guard(mutex, &firmware_file_lock) {
+		if (!firmware_file)
+			firmware_file = kstrdup("", GFP_KERNEL);
+	}
 
 	sdw_debugfs_root = debugfs_create_dir("soundwire", NULL);
 }
@@ -379,6 +425,7 @@ void sdw_debugfs_init(void)
 void sdw_debugfs_exit(void)
 {
 	debugfs_remove_recursive(sdw_debugfs_root);
-	kfree(firmware_file);
-	firmware_file = NULL;
+	scoped_guard(mutex, &firmware_file_lock) {
+		kfree(firmware_file);
+	}
 }
-- 
2.51.0

