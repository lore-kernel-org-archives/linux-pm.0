Received: from outbound.mr.icloud.com (p-west2-cluster1-host2-snip4-10.eps.apple.com [57.103.68.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB6238C2D6
	for <linux-pm@vger.kernel.org>; Mon,  6 Apr 2026 20:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.68.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775509115; cv=none; b=f6XH/r/g2GYz+rw5HtMoBlcrZ9xtPpnaEexiNypu3GUFrXuvvY5MPp5ADnRGeNzXzY25GilFkvsgcb2PrKbIDNruI317JR67BOBVyDhVeb01HHtcneMNoXDDyE5n/HQdCR07/Ls9lVWmXyAU/EQGAGbp+wJtCuhhkvXzMkDwZhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775509115; c=relaxed/simple;
	bh=AMwD/10VTif1hBkjtQDXDlZCtGa6RGHKMnn71rMDUIo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ORbRJRsKeTRKjUyG65c3aADZEPIb9heztn81opLyDADaHNc8mCEfjppMIjHen92i0xcjunBwo66eVse29Pkko3y9AEdfo19ZwGQ77iNypVig0bLgF0BMyjJGK2G5IMg0sy8Wjl8l1bvWaWn8wq0Yx/EowxxVKQB0l672bXQ6IHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=Fhg+DyQZ; arc=none smtp.client-ip=57.103.68.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="Fhg+DyQZ"
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-2a-100-percent-3 (Postfix) with ESMTPS id 86477180011C;
	Mon, 06 Apr 2026 20:58:28 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1775509109; x=1778101109; bh=B+trGXuzsBi7BBdRkup+Lr8u2oDGSvuTlLJj7Z/MTN8=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=Fhg+DyQZjlTPCR+w0aiJSqvEXgasyr5T4YtKwc8wOAXqhGi48lusBKUcxPIq11gMVcC8OWfCRY7oijMnwKA/06nrQYJE/Oa+gkWEAfzQRPQk5uXHB1N34kBKaeKtp/UNpjy+vPuMvhX2wK24EEHhPaiTh5tko7wvw7q7rCuLdPdR5j5H/QkTnpArcCtSd4fls2ra2Eh0sutKYTuZtLol62nKNSdtPlPikBsx5wU2Lyqc2W71lwMUzuwjNeSj4b854VhjIzhRk03gan6shYMM/wbVROZij9PIYxCJrG2TWVTjobgc4StqeCpD2PiSCbBNLaNnpit7TszI6xWRLjUGJA==
Received: from bigre.tail98293.ts.net (unknown [17.57.152.38])
	by p00-icloudmta-asmtp-us-west-2a-100-percent-3 (Postfix) with ESMTPSA id 4EF69180027B;
	Mon, 06 Apr 2026 20:58:27 +0000 (UTC)
From: Vincent Cloutier <vincent.cloutier@icloud.com>
To: Sebastian Reichel <sre@kernel.org>
Cc: Hans de Goede <hansg@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
	Purism Kernel Team <kernel@puri.sm>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vincent Cloutier <vincent@cloutier.co>
Subject: [PATCH v1 3/9] power: supply: max17042_battery: Use dev_err_probe for power supply registration
Date: Mon,  6 Apr 2026 16:57:51 -0400
Message-ID: <20260406205759.493288-4-vincent.cloutier@icloud.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260406205759.493288-1-vincent.cloutier@icloud.com>
References: <20260406205759.493288-1-vincent.cloutier@icloud.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Hxi6cmDWxZniVpjJd42kVfpN-5NKNyAO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA2MDIwNiBTYWx0ZWRfXxpj8pVchhZ0C
 GY4GZW6p+tYgy6Wk1i7n/CaHK07EoNcSj9ETrqSpf4MpC5NPTU/Xd4xvB6P831qrXL1ugL7Y64J
 Bg8MbVa7iJsFg3OaUXkIv4crdQq8zesSx6s8efq05L/YEhgkXM247sV3IV/Ye8JDt5O7g4H2OS3
 6cy+z3+XUAeFw/w7IyvgLC33lESQgMSAW5dYQZfpgIs+vzvya/DecnOAB0jxoXBeUUDxzTvSkmo
 UH2kB0emQoHGFInjw+giXMRxy46bld3YYhHmIstuRHYJnf82TT/FIxZwQvRVNuZ7Lz81oilfutQ
 E0UvBvPhsIRFTAbuAdQWquNJM7DKJjTrpq0JMqhzpIT2IEfE8m6/Xqkxcs7T7o=
X-Authority-Info-Out: v=2.4 cv=BaDVE7t2 c=1 sm=1 tr=0 ts=69d41e74
 cx=c_apl:c_pps:t_out a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=A5OVakUREuEA:10 a=x7bEGLp0ZPQA:10
 a=5j__JWfIoqoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=9e34aSz6kEOh0L3mk08A:9
X-Proofpoint-GUID: Hxi6cmDWxZniVpjJd42kVfpN-5NKNyAO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-06_04,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 mlxscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 clxscore=1015 phishscore=0 mlxlogscore=999
 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.22.0-2601150000 definitions=main-2604060206

From: Vincent Cloutier <vincent@cloutier.co>

Use dev_err_probe() for power-supply registration failures so deferred probe does not spam the log and the original error code is preserved.

Signed-off-by: Vincent Cloutier <vincent@cloutier.co>
---
 drivers/power/supply/max17042_battery.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply/max17042_battery.c
index ddeba965ab5b..31007ba122e5 100644
--- a/drivers/power/supply/max17042_battery.c
+++ b/drivers/power/supply/max17042_battery.c
@@ -1095,10 +1095,9 @@ static int max17042_probe(struct i2c_client *client, struct device *dev, int irq
 
 	chip->battery = devm_power_supply_register(dev, max17042_desc,
 						   &psy_cfg);
-	if (IS_ERR(chip->battery)) {
-		dev_err(dev, "failed: power supply register\n");
-		return PTR_ERR(chip->battery);
-	}
+	if (IS_ERR(chip->battery))
+		return dev_err_probe(dev, PTR_ERR(chip->battery),
+				     "failed: power supply register\n");
 
 	if (irq) {
 		unsigned int flags = IRQF_ONESHOT | IRQF_SHARED | IRQF_PROBE_SHARED;
-- 
2.53.0

