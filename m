Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF73F507
	for <linux-pm@vger.kernel.org>; Sat, 12 Sep 2026 11:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789214103; cv=none; b=PeDjAwtPOxOlxscV7XaiQKKH0TX7Zf12yEPHtn+gAa+VCN2pROOKqu8FGxJ0iCc4C28SAngfVRfLqjlnvyADID8llEV9+xYfeiYfN5exrP1LukmkY9xGmeYzHgdX+K4yDK6wI/LH5b1RPuud2iD77NtK5OGidGVoWfG+WXKRhK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789214103; c=relaxed/simple;
	bh=wjrfmzwCB2Vf8FRU6UVIgozAzhd2ZwXNpub4sYKeexg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ief5i8e0kH+5m9q7QB2W0CntJTzTWYBKROoX7v/3Vrf9eIAPdGPopT8MfMeeyKCQnkzXZnGT2G4N+bkEvnPQK9UrcxzyZ/lWBovRJbv3/EJ5NuYGsSHX/LPUrdqlnxkHp/vvzkW5U1o1iNTYI7JzjsOmWZJd5Swuwxj5xr+0QoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rCASUYaE; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rCASUYaE"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-486fa798933so7157f8f.0
        for <linux-pm@vger.kernel.org>; Sat, 12 Sep 2026 04:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789214100; x=1789818900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HHQY0It3MNtGCYNfDhAD2naKxs+6llSjkNyX4pY9SfU=;
        b=rCASUYaEbNTpyMF0BRRBGNHkvqnYUVBAI8gLyHmp6U2/zglnuMC/vPuKbRWvBmveBV
         ZXH6RdLZTS2l/1FbYjXkD6FP4W2WkXlN9Wv+O0g6hPfg/9gq57CYZtt2xjXCNS96Dyt4
         92jR2Xo+xrVe70Rqxh4PUgBpuDEGUDDH2SNODN4NZcdBs5a00OEDymBgC3m2p5vYVlCs
         kqxfsBJfkXiligRzntEqlnt3jpboxmCHd79uPV91Xgi1KVTSEjHtH4Ekx72xasL52fK2
         wARWNa6gU8bzFZpOPWfT3QkT2YES/znDwBMhvIwFmgEkydKlsZMAYERv8rB6ZwsrVxz8
         voZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789214100; x=1789818900;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HHQY0It3MNtGCYNfDhAD2naKxs+6llSjkNyX4pY9SfU=;
        b=GnTm0av7HBK3w1FMK7k/76kqa4r6YeP5rNgTaQHn8Paat47q03drXI0b7Pyx2iaBYC
         e6aVy8blA5uaU0LHvVbO3yFnrxYdoZyDMlRzTWQTkIAY7n6yZ17f2G0dLJX+tr8JM8fi
         WnzfEAknpubDQa9ry2x84Rdgaeac0TVXu3wr9czkvMGckPvbvzztMymthdVG79kuhBCZ
         k8mbgk8clL+0E/V/kYe60kbyYQSCCsCOEXYLMTnAr6jG+VIMGZ9m/M+TX1MkDOy0B98i
         6hKFtxGCSBDVy1vRGf2PYb28Hq6ZtatkvSg27hMcimLI7oHNQazpAVhI9X0FOTpTBsf8
         jpPA==
X-Forwarded-Encrypted: i=1; AKwUvBwVGfsWXqNYbzkHTNCx99HSeP42ErGh39A0s/l0Raou5un/Zl+WkjyrWZt3NNBXqLMwwRjx/UcfHw==@vger.kernel.org
X-Gm-Message-State: AFuF++mjqfwcXERxsfcBrtbNPgkeHjiMhXhATyPnZ1GXAFpMb25x6/y4
	qPksi9lmrf/74fxype4I18neKaZ0ApjO9a0Kv7V4bPClYK3pwyongJkXv4c0NKeh
X-Gm-Gg: AYBFou1MSABq/vGhfO8LzkGDVqzb4JU5NmrKNI/TiH10lOf4NjdcCc5/PNXQM6rEMU5
	k3v9iBDbOXAMvoqUlk0I+G3MFH8W/FG3FxOocIX+TbaKeFa/TH0WgQUrrNpTblFlND0c6Dv/w1x
	9wyL39NLFYu+xKKjBLUMms07vI5if2OtQUSnxJEZcxxjUPEZlacrue0snVfz6RZqs+2TkJpz4BN
	KqtUIBawCaWnobG0iJm5pEnZFAFumG4Nr5t+FKNf5d5vVPfTZVzWee0JBIsaEtQLDoDS7SapIPR
	P8WU5LeE6oGI6LdCfOiWsvOtau1jZ/D2l22b+1wrq2hrIEmgzefmG5zXiQJSgXcuheFWzgiSBR6
	2DptqWHAB+SyRyIYQCPN9xT4ovq66yVgaw/YGhJmqR5xeMmfcJzbEGxvC2UEM74/vt2h4WzlaET
	eRGoyiE3q5G/YtKFpYksnPqSrp3viEXo2F79tgIH8YFxRGA/OrQFCC80OMyJCDFxHfeD4u2/x3F
	ASm6uPAUYcoRjclC2F8rzafsz1Puf3OhM+QO1g/xZo+RS9/uLJqlyNyUdULQyTyps10FEMQDNxW
	sFNYSTeENpr8ZBOdSdhbwj7cijeg2VVOAWblIT4DY5atPhYJ70EX6VmGXE+/iyRq2t0zRwAbKaq
	LpG4+FoeG/1Lk
X-Received: by 2002:a05:6000:2c0e:b0:484:3313:fd86 with SMTP id ffacd0b85a97d-486eb2eb014mr9316892f8f.27.1789214099433;
        Sat, 12 Sep 2026 04:54:59 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-b260-f201-9983-e8c4-aff5-7a36.310.pool.telefonica.de. [2a02:3100:b260:f201:9983:e8c4:aff5:7a36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb350686sm13413575f8f.27.2026.09.12.04.54.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 12 Sep 2026 04:54:59 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Georgi Djakov <djakov@kernel.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH v2] interconnect: Add kernel-doc for devm_of_icc_get(), icc_enable() and icc_disable()
Date: Sat, 12 Sep 2026 13:54:56 +0200
Message-Id: <20260912115456.89169-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Documentation/driver-api/interconnect.rst lists devm_of_icc_get(),
icc_enable() and icc_disable() in its kernel-doc directive for
drivers/interconnect/core.c, but none of the three functions has a
kernel-doc comment. The directive silently produces nothing for them, so
the consumer API section of the rendered documentation never shows
them.

Add kernel-doc comments in the style of the neighbouring functions.

Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
Changes in v2:
- Describe @path as an interconnect path and explicitly state that
  passing NULL is a no-op returning 0 for both icc_enable() and
  icc_disable() (Kuan-Wei Chiu).

v1: https://lore.kernel.org/r/20260907020504.24783-1-kmehltretter@gmail.com/

 drivers/interconnect/core.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index 4aa991a54101..802f07e806d5 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -423,6 +423,17 @@ static void devm_icc_release(struct device *dev, void *res)
 	icc_put(*(struct icc_path **)res);
 }
 
+/**
+ * devm_of_icc_get() - get a path handle from a DT node based on name
+ * @dev: device pointer for the consumer device
+ * @name: interconnect path name
+ *
+ * This function is the resource managed version of of_icc_get(). The path
+ * is released with icc_put() automatically when @dev is unbound.
+ *
+ * Return: icc_path pointer on success or ERR_PTR() on error. NULL is returned
+ * when the API is disabled or the "interconnects" DT property is missing.
+ */
 struct icc_path *devm_of_icc_get(struct device *dev, const char *name)
 {
 	struct icc_path **ptr, *path;
@@ -786,12 +797,33 @@ static int __icc_enable(struct icc_path *path, bool enable)
 			  path->reqs[0].peak_bw);
 }
 
+/**
+ * icc_enable() - enable a path
+ * @path: interconnect path
+ *
+ * Mark all requests on the path as enabled and reapply the bandwidth that
+ * was last set with icc_set_bw().
+ * Passing a NULL @path is a no-op and returns 0.
+ *
+ * Return: 0 on success, or an appropriate error code otherwise.
+ */
 int icc_enable(struct icc_path *path)
 {
 	return __icc_enable(path, true);
 }
 EXPORT_SYMBOL_GPL(icc_enable);
 
+/**
+ * icc_disable() - disable a path
+ * @path: interconnect path
+ *
+ * Mark all requests on the path as disabled, so that they no longer count
+ * towards the aggregated bandwidth, and reapply the constraints. The
+ * requested bandwidth is kept and restored by icc_enable().
+ * Passing a NULL @path is a no-op and returns 0.
+ *
+ * Return: 0 on success, or an appropriate error code otherwise.
+ */
 int icc_disable(struct icc_path *path)
 {
 	return __icc_enable(path, false);

base-commit: 986c24e0fe44f844b44d365b71ce831947f50298
-- 
2.39.5 (Apple Git-154)

