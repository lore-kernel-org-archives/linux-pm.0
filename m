Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.254.49.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795779209;
	b=YKErlKaxRZ0TOm1Uz9brgFDi/5VIp1G6LOLqe4JE1XDMuMGxEtiXOHOfkelQT0+pxhmk
	 naBPug6V+SvuMkowBoQtSDESR132hfyKrdvKqqecto/w0tnqoZHHnVw3Z9ow7U+zlV6wz
	 d3UzmhjTiYSow+kwfwcR7t7jvwT9npB6m8xM8Mk1Oi5ujbnzWzYxDNNYRtb9NvlMW3L3U
	 xe+IK6pN+xae1ebCAgBUe6IjoQhPToyDWcKtwY5eelMzi6QJhz2zUMM1qrGkKqUOPnj8N
	 DSLscyYqp6MsjzSikUjMHZ3/VFrFZIakIto7PZtjyHSwWjmLCZagmRtXXaTO4CQm7qw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795779209;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-HM-Tid:X-HM-MType:
	 X-HM-Spam-Status:DKIM-Signature;
	bh=CiPchp7Zot0ITrMRYUd3u5Ovf4akoG8PMlDnhUlKbaM=;
	b=G/Ak/NZyoqHRGV53YP6IyThMF1VTC4I/RSeE6eBjZ0pDl4hG2i4rPlLqvgGWZpc3UZ1Z
	 4egTmNPgUZnhPcVYGaNEHRKAtRojKFAkZNQi2KJXGh1oHhwgoQAbyFNMIreODOCZRwj2+
	 1O6fU4GAKo28RkBT2SZCKjCtdm1nFybnA/r4UTVPLsmmtsLiHHyemfnGd9aJNznV+/LP5
	 Qu0FADx3rZWsK9oj7j/NVzZNzhE+zPOrogvdn4ZOp85J3ZqgwCG/o7/xOkjXL6GrRDZ4j
	 l3Br+NlwwRKhUm/cBSFzHCQOBTbffsYzTT3Cg16UI8R95p+wPMB+Y0dDuG3LAtwjwjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.sdu.edu.cn;
	spf=pass smtp.mailfrom=mail.sdu.edu.cn;
	dkim=pass header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=amaoRmQm;
	arc=none smtp.remote-ip=45.254.49.197
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C88606A31C;
	Fri, 27 Nov 2026 11:33:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7C88606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=amaoRmQm
Received: from user.localdomain (unknown [223.80.110.101])
	by smtp.qiye.163.com (Hmail) with ESMTP id 564299829;
	Fri, 27 Nov 2026 19:33:23 +0800 (GMT+08:00)
From: Tian Xuechen <202300460064@mail.sdu.edu.cn>
To: rafael@kernel.org,
	viresh.kumar@linaro.org,
	krzk@kernel.org,
	peter.griffin@linaro.org,
	t.figa@samsung.com,
	kgene.kim@samsung.com
Cc: alim.akhtar@samsung.com,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org
Subject: [PATCH 0/2] cpufreq: Add remove callbacks for s5pv210 and SPEAr
Date: Fri, 27 Nov 2026 19:33:20 +0800
Message-Id: <20261127113322.390337-1-202300460064@mail.sdu.edu.cn>
X-Mailer: git-send-email 2.34.1
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
X-HM-Tid: 0aa21cc811fa03a2kunm5097e7d4395dc6
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDSUJLVk1MQxoaSxlIQklPT1YeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUhVQ0tVSkpLVUpLSllXWRYaDxIVHRRZQVlLVUtVS1VLWQ
	Y+
DKIM-Signature: a=rsa-sha256;
	b=amaoRmQmmCoIgf8PwX4NRM/TuCbGLYLESirT/4+RkH0rgobQYf8CJskSQJRd0Sgad6sW9zFf/vepKXUBfmQvhk5Yr/squLa2rmwUZj80Ro7Y+xH647rm2t3XrGiesRwWrWa93VYVZmimUpsdh3dCqGbUTdJau1hPFgSovBO07DI=; s=default; c=relaxed/relaxed; d=mail.sdu.edu.cn; v=1;
	bh=CiPchp7Zot0ITrMRYUd3u5Ovf4akoG8PMlDnhUlKbaM=;
	h=date:mime-version:subject:message-id:from;

From: Tian Xuechen <202300460064@mail.sdu.edu.cn>

Unregister the cpufreq driver when the S5PV210 and SPEAr platform
devices are removed.

Tian Xuechen (2):
  cpufreq: s5pv210: Add teardown and unwind probe failures
  cpufreq: spear: Add a platform remove callback

base-commit: 4dce97c6c265544342e716e62fd24bbb232590c5
