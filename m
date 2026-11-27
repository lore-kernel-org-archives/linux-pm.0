Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=101.71.155.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795779212;
	b=309k3WBV7EoKCpCV2V2vhl0BfPJXZB0TTJqO3psPbNq5jxjyvdvfsJFH5+ajKuu4xSkO
	 SJJGMCa2J8uo85T/u46q78ajqfyq0Gkt+4wX6bZ6xZvbBKwZppVcNnvtzbgQQCVJWWzHl
	 J3/OK8TqUfc5ZqJhEQDMR5UCpRPRd8JA+eZHpi4sUNyufA5FeE08ygktG+xjRPCPb9D7F
	 7lth2xxTTeaB54ipqLtd5eVOjERN5f0gGB+PAYNbv4JQStg1LOIY3f7gIFxdX3UWrclU9
	 7UmXCSR3n/i064Sxe2/YRDuOfbyck45ZJDGBnEaGZt7nfOdP5/+D9XVrlQ+t3MGCClQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795779212;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-HM-Tid:X-HM-MType:
	 X-HM-Spam-Status:DKIM-Signature;
	bh=Vpyy6zemv+YuuqJrdJ4wj3yo8jYAVZ/C6m+mZJr7VhA=;
	b=eIPks1MKy7ZGoh/lPcL9zHbiZPFbwBhwGDLQunqLeXhyBlHqdalvBIL1IebwnxYUhMuI
	 6a4VUgJZWC0l9I6rFYc7Wi3kqW5N/7s/WXfyeKkBqoNjDl9EgJhmhSi5JRV8l0/dWu2vZ
	 PQWeziFJ6VBnJIQlLdaZfkCX48CMyYku9FEln+8xtbyiP1lQE3jSeLCOCdip+KN6pij4Y
	 LpnqaOFOjMYLPWUO4rVyfStCfxzcRwerbkbdhn6pXHSG3JY8eh5EUdtkypg694vGgWaYH
	 YE54Ad2wMmMYywANPE8BnaITe+oXJnwsgWwrZPP9BxxHYXSmzA8JCb55C5Rq4unvNMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.sdu.edu.cn;
	spf=pass smtp.mailfrom=mail.sdu.edu.cn;
	dkim=pass header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=guYxVVeI;
	arc=none smtp.remote-ip=101.71.155.101
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC9F606A32D
	for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 11:33:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5DC9F606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=guYxVVeI
Received: from user.localdomain (unknown [223.80.110.101])
	by smtp.qiye.163.com (Hmail) with ESMTP id 56429982d;
	Fri, 27 Nov 2026 19:33:27 +0800 (GMT+08:00)
From: Tian Xuechen <202300460064@mail.sdu.edu.cn>
To: ulfh@kernel.org,
	neil.armstrong@linaro.org,
	khilman@baylibre.com,
	jianxin.pan@amlogic.com
Cc: jbrunet@baylibre.com,
	martin.blumenstingl@googlemail.com,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org
Subject: [PATCH 0/2] pmdomain: amlogic: Add teardown for EE and secure power domains
Date: Fri, 27 Nov 2026 19:33:24 +0800
Message-Id: <20261127113326.390398-1-202300460064@mail.sdu.edu.cn>
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
X-HM-Tid: 0aa21cc81fa103a2kunm351106c8395dd3
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZTh0YVk1MSR0ZTkxKTB5LGlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUhVQ0tVSkpLVUpLSllXWRYaDxIVHRRZQVlPS0hVSktJQk
	NDTFVKS0tVS1kG
DKIM-Signature: a=rsa-sha256;
	b=guYxVVeIdIVSPNNE9ee9t77nGKoQjgpSKtxeiWZUEWbsvqnjiaRShOPowLqtmWgsGJmwQWOf1ITb9gsRJcXzrkKvutoquuFRL8qFMt3Vk/kJeiYJLcohpyeSjsQm9zjrgJ6lDeXMioYpA4+JzidvwVqsBUaDm1W9TID+RIMuAMU=; s=default; c=relaxed/relaxed; d=mail.sdu.edu.cn; v=1;
	bh=Vpyy6zemv+YuuqJrdJ4wj3yo8jYAVZ/C6m+mZJr7VhA=;
	h=date:mime-version:subject:message-id:from;

From: Tian Xuechen <202300460064@mail.sdu.edu.cn>

Unregister the domains published by the EE and secure power controllers
during removal.

Tian Xuechen (2):
  pmdomain: amlogic: Tear down EE domains and their OF provider
  pmdomain: amlogic: Tear down secure domains and their OF provider

base-commit: 4dce97c6c265544342e716e62fd24bbb232590c5
