Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=80.241.56.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792480794;
	b=aa+Gk1zACPHtxE3O3yhFJjWTnvjfMHKoR1R+aSvFF9ri1kEXiLsM+BCdVC8kD5fL2Pul
	 F0UiyIp7KZ9sovcygIPXdeYnL33Xe1vONmcBLWOn0Ly4Lo4NMTTBsmUpdshkQXxH6fzye
	 KEUwSVXYB5rfznro471l3ECrw7NnQ/eEQXoSEzgIWPe6F3b8Ssxf1urWxj2Xei5hh1i3M
	 DTF40kMyr57dCHIG6JgiB2KBsfYK9IsREE0Bx1DASIwK4ZXhX7ecBfBcaYDOyyOTza8RS
	 gteQ9Iwnd63GyJc8PfygTONtLH4UP81ZGsABX/zmV5a0EixyTOHk3fniXehRItcHqDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792480794;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-MBO-RS-ID:X-MBO-RS-META;
	bh=5hHqP6l6P3y8TPqsQ4uBK1HTBu09IRjIugQD13gPINM=;
	b=Wf5fgfswlDe//Hq5CCi1SibKVLvFs2XV+Pz0zgMUzGa4b6RwsLvDvi69uHxI11h+LUdy
	 +MqmER7VMKOd/viJCGV0J+CVsskhKyBLSy8SUUGllk5904bJWA5jjRX2rml3aMYXhx76W
	 X598L+lo80QE68VLj0Or5mOdwpBAKAe/dW9W92u/wZW6msg+Ge47yb4tV6IkXepU5uFMR
	 TsMNMZiL9jp/DWXzq24UJMnPdGPcja+uEn7jvkQAE4XtF/SStsq1t6tn7ccDRpqtPiEsS
	 HweBVLiYIECGMrWVk1CporexieNstXXu9gvkeLtbk5MJt/5UOWNMf60vcraxTad5EfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mailbox.org;
	spf=pass smtp.mailfrom=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=BTMLbF2d;
	arc=none smtp.remote-ip=80.241.56.152
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB45606A31E;
	Tue, 20 Oct 2026 07:19:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EFB45606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=BTMLbF2d
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4j83hQ0WZDzKp25;
	Tue, 20 Oct 2026 09:19:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1792480790;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5hHqP6l6P3y8TPqsQ4uBK1HTBu09IRjIugQD13gPINM=;
	b=BTMLbF2dSJ+QLGysiCsh1voW+8HBXJuDdwpoqVYXDK75cCbLGtwEyL95e5O6GvidznTCrd
	JBFpf4MJRPHkwruE3Ocjez8o1AeRRf15qznkU4GZiq+lDPeu+BZiqKpN2Oli3oOn11F6K1
	xZ8Rgsc+a0IUVlvLyWo/2OrOBGKgYisMm8tGS9qYczlWJCw36P5HfBm8joh/tAFob90CfH
	RIrD3Bip1hKq9UXBrZlktkn/P+YV8LWRdr1GsWL+xKOmoDEYHNJgC6q7N20LJVqvO6RpSw
	+6F+sqrBlQh5pamJRdSC1zGqcRAk395ngL0gon4aCTpCjpbr9MOsTrqAijgXHA==
From: Manuel Ebner <manuelebnerli@mailbox.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>,
	Manuel Ebner <manuelebnerli@mailbox.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] cpufreq: longrun: fix kernel-doc warning
Date: Tue, 20 Oct 2026 09:19:09 +0200
Message-ID: <20261020071913.1677196-2-manuelebnerli@mailbox.org>
X-Mailer: git-send-email 2.55.0
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
X-MBO-RS-ID: 5b6ebadf7ca5f0ac97e
X-MBO-RS-META: 14gzcfiznwxqakq61nqwkfcms7dmfj7a

Replace kernel-doc comment with normal multi-line comment thereby fixing:

  $ ./scripts/kernel-doc -none drivers/cpufreq/longrun.c
  Warning: drivers/cpufreq/longrun.c:21 This comment starts with '/**', but isn't a kernel-doc comment. Refer to Documentation/doc-guide/kernel-doc.rst
   * longrun_{low,high}_freq is needed for the conversion of cpufreq kHz

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Suggested-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
Signed-off-by: Manuel Ebner <manuelebnerli@mailbox.org>
Reviewed-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
---
[v2]
 Fix Suggested-by-tag
 Add Reviewed-by Zhongqiu Han
 Add Fixes-tag

[v1]
 https://lore.kernel.org/all/20261019182946.1450406-2-manuelebnerli@mailbox.org/

 drivers/cpufreq/longrun.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/longrun.c b/drivers/cpufreq/longrun.c
index 7d4146d6c..c1df9014a 100644
--- a/drivers/cpufreq/longrun.c
+++ b/drivers/cpufreq/longrun.c
@@ -18,7 +18,7 @@
 
 static struct cpufreq_driver	longrun_driver;
 
-/**
+/*
  * longrun_{low,high}_freq is needed for the conversion of cpufreq kHz
  * values into per cent values. In TMTA microcode, the following is valid:
  * performance_pctg = (current_freq - low_freq)/(high_freq - low_freq)
-- 
2.55.0

