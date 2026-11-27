Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.254.49.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795779211;
	b=1JaBK1O0Ib6ZfpmDG/1vMY4uxQftt2tlqozoFzwoOduOYLuqavEXVLij3kOt1j4XetvI
	 DeA5dkmt9s5oQRdrpUbEWiQUWDG36Ehwzm9J1LuTjPJXsQUpR33PQedExrxJ2/FW44xb7
	 4wtBX2WLdsbpYhE1bVsDPH0OvKYk5bX89o73jhCikg2gCPs1EBTcyBEvrrPotZ3TZW3sO
	 DspbH4UOflRDxb8MNyDgeWDZkyaaLOoulrPPkyLNXP8v8rLjwlYCcZxTeP3YQwClo9ibY
	 i09Q0EOhXC79uVgYcrJbeoXtGc8mcZaqvDbhMNLz9FGKDQJrzbuKwsTHn4fCy98uJYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795779211;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-HM-Tid:X-HM-MType:X-HM-Spam-Status:DKIM-Signature;
	bh=nwfeveSkSlHwHSf8OOGn/CKlWE1z7nWFW3dZE8EJls0=;
	b=jyrVfR9cQ1iKhTZwckrEhR0xJILQf2/G5LO96RgIYJCZKf+xqeChaLzA/wQkdTkHfg0Z
	 lbWR8lNNR0Fc94uMIOaxJ51KMiswJ+fG0GOPBW/PS2/HpbFq5qbiJJAhxjp4rMdR1okPv
	 KsjkD/gRTn7ezEoCjYL8+pBOE6FNhdTHBvUqUXREP9/R2Jl0b6Iu1mhAl5f9j3UaT2VnC
	 evYtZL0B1EFBeYoBP3DUproXJCTJMcK0B/Dx8uHQAmBJ3B34gLT672kv+v/leK05ShTe6
	 5JFJ/PBFTspMMS0hQTwY9cRXvBeK3RAz19Vpj1XfJuoEb6YGOTPMoJUamHaatKmCc7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.sdu.edu.cn;
	spf=pass smtp.mailfrom=mail.sdu.edu.cn;
	dkim=pass header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=gqedjlSK;
	arc=none smtp.remote-ip=45.254.49.198
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93CC606A327;
	Fri, 27 Nov 2026 11:33:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C93CC606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=gqedjlSK
Received: from user.localdomain (unknown [223.80.110.101])
	by smtp.qiye.163.com (Hmail) with ESMTP id 56429982b;
	Fri, 27 Nov 2026 19:33:25 +0800 (GMT+08:00)
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
Subject: [PATCH 2/2] cpufreq: spear: Add a platform remove callback
Date: Fri, 27 Nov 2026 19:33:22 +0800
Message-Id: <20261127113322.390337-3-202300460064@mail.sdu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261127113322.390337-1-202300460064@mail.sdu.edu.cn>
References: <20261127113322.390337-1-202300460064@mail.sdu.edu.cn>
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
X-HM-Tid: 0aa21cc8196603a2kunm5097e7d4395dcc
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDGUxNVh5LHk1DH04fGR5IS1YeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUhVQ0tVSkpLVUpLSllXWRYaDxIVHRRZQVlPS0hVSktJQk
	NDTFVKS0tVS1kG
DKIM-Signature: a=rsa-sha256;
	b=gqedjlSKvHxbmuGqek0Iju77DdWi3R1xrnt4wyrDm57ZaP92+eU4sSoxCXaaLT5JrvJB8N/Zp56S35JOWoItshebgkbliIfproNJtj4zYJXwM3Y1zukjUqTe/2Rp/iViElh5Qd8BAqE3QlHfhiRx2qKvnCmE16tpUSKMAWSgbUs=; s=default; c=relaxed/relaxed; d=mail.sdu.edu.cn; v=1;
	bh=nwfeveSkSlHwHSf8OOGn/CKlWE1z7nWFW3dZE8EJls0=;
	h=date:mime-version:subject:message-id:from;

From: Tian Xuechen <202300460064@mail.sdu.edu.cn>

The SPEAr platform device registers a cpufreq driver and retains the CPU
clock and frequency table. Unbinding it leaves the driver and those
resources registered.

Unregister the cpufreq driver before dropping the clock reference and
freeing the table.

This issue was found by our static analysis tool under development.

Fixes: 2449d33a4055 ("cpufreq: SPEAr: Instantiate as platform_driver")
Signed-off-by: Tian Xuechen <202300460064@mail.sdu.edu.cn>
---
 drivers/cpufreq/spear-cpufreq.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/cpufreq/spear-cpufreq.c b/drivers/cpufreq/spear-cpufreq.c
index ffe5eda82f0b..91aeaa099f8f 100644
--- a/drivers/cpufreq/spear-cpufreq.c
+++ b/drivers/cpufreq/spear-cpufreq.c
@@ -229,11 +229,19 @@ static int spear_cpufreq_probe(struct platform_device *pdev)
 	return ret;
 }
 
+static void spear_cpufreq_remove(struct platform_device *pdev)
+{
+	cpufreq_unregister_driver(&spear_cpufreq_driver);
+	clk_put(spear_cpufreq.clk);
+	kfree(spear_cpufreq.freq_tbl);
+}
+
 static struct platform_driver spear_cpufreq_platdrv = {
 	.driver = {
 		.name	= "spear-cpufreq",
 	},
 	.probe		= spear_cpufreq_probe,
+	.remove		= spear_cpufreq_remove,
 };
 module_platform_driver(spear_cpufreq_platdrv);
 

-- 
2.43.0

