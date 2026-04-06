Received: from outbound.mr.icloud.com (p-west2-cluster1-host2-snip4-10.eps.apple.com [57.103.68.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BAB01EF09B
	for <linux-pm@vger.kernel.org>; Mon,  6 Apr 2026 20:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.68.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775509116; cv=none; b=hT9BZBz6ONwN1Cziy+msX8Wr4I+YaOk2Gz7Z27taC/0kZzfYWAppDRQui1KRwSSXFHdFcOOZRoi9PW8Zq92aZfYty7pc3HlLHm0s5IqzCzhMmaIhgBk5beqGubu00Lc/uD2AMjNLauTCtgj6uOA7ipbUjp3J58t0ji4RXvrTrLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775509116; c=relaxed/simple;
	bh=JUgMeGaWbGx2RwTFLOZ7+apz8zFtzDRIjiomG8+nIrs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L3ZeHum7Z/ZgwTy+zvqGSUaBM1ayqzY2iNqk5ZscsxJ4Bbyc6+nXe1vkZ3SYRdFX39IIjyXTpe35nmhY9uj2EqzPOAn7mLFNoOZzV3V82JaKVYhyKkS7036rwleVbdnpG3j0F9utcw/Mgm9B7Gnluy7zfz4jlsXIEcQRM5VashU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=skyKEBZP; arc=none smtp.client-ip=57.103.68.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="skyKEBZP"
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-2a-100-percent-3 (Postfix) with ESMTPS id 7AD0A1800270;
	Mon, 06 Apr 2026 20:58:34 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1775509115; x=1778101115; bh=ymp75nBmmp9XWS0rBWuQ9vMG3TCpJN6FQR7ePzfMtuo=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=skyKEBZPfSloJf2JcscoHFUPpPib+as6BE6cj+PgfQ/eiWyHQIMBXh7vVqT4W1EoX2iycyNZUxwzatrBHBU5RHGso3tPGfj2+7g4uV/M1VEJNkgjEGOAF6pj1mAOJ7xGVcgckMhbF5iqg0u3VOGQ07x6gLx+zPWR5FQVD28Skgp1Gi7r9vM78Y7FUyKSHYu43XkImsXXWQbzRRcb21mdGPM90qI7Bs/UeDM4FQnUSzRdDiGfQagxqf78jgnENUg5qudUTASHqyagjZdLZ7ckvQxzrLpqzRqLNGEsk9+ncn8fF3ZMguAPcE0JEx9bLwRk6gOpgjCAr/4Uygc5bjn9GQ==
Received: from bigre.tail98293.ts.net (unknown [17.57.152.38])
	by p00-icloudmta-asmtp-us-west-2a-100-percent-3 (Postfix) with ESMTPSA id 4FCCD180025D;
	Mon, 06 Apr 2026 20:58:33 +0000 (UTC)
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
Subject: [PATCH v1 5/9] power: supply: max17042_battery: Keep only critical alerts during suspend
Date: Mon,  6 Apr 2026 16:57:53 -0400
Message-ID: <20260406205759.493288-6-vincent.cloutier@icloud.com>
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
X-Authority-Info-Out: v=2.4 cv=PKsCOPqC c=1 sm=1 tr=0 ts=69d41e7a
 cx=c_apl:c_pps:t_out a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=A5OVakUREuEA:10 a=x7bEGLp0ZPQA:10
 a=5j__JWfIoqoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=dyxb9JdF2MQeVmfmGMwA:9
X-Proofpoint-GUID: uxSygwNtLqckvkNdTtuRpGIw_wU8BUZx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA2MDIwNiBTYWx0ZWRfX5lOlXXFE9EBu
 1yCXY79Id40uqrv1CSiwNv6qh3jtv8h24fK8K1B2hbhYEa2Fy1MwvK6BMTIaV9r4yt8W8ZJ6QrC
 bGZpllf1zftwYe88+9AQnnHm6qAiTWz38HDHRBkAQyzRxSsJCpaxRVakeYtRs2wJpmCy3EeDloL
 jSDce6+QRq0/Ur2//bNpA8BwgwzmQOo14StcNcF/cMf1PUeQSBFKALlcE6pItqYVoiv/AGSLARn
 3RwPK+pgVxIlPG0qqTzzz2PyFYIhZHlpzEfT3F3VNFULaq46rtnRSbzfBcRCq2d4ENuKNz2K6Cs
 QFiwP9p46QXEDAF7I9pK4Sm+dRINlXvbnkgiGD/dHoqQDJB8rPJ9x96PfbakIk=
X-Proofpoint-ORIG-GUID: uxSygwNtLqckvkNdTtuRpGIw_wU8BUZx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-06_04,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 bulkscore=0 malwarescore=0 suspectscore=0 clxscore=1015 mlxlogscore=999
 phishscore=0 mlxscore=0 lowpriorityscore=0 adultscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604060206

From: Vincent Cloutier <vincent@cloutier.co>

Disable MAX17055 dSOCi while the system is suspended so state-of-charge changes do not wake the system repeatedly. Leave SALRT armed for the critical low-battery threshold and restore runtime alert handling on resume.

Signed-off-by: Vincent Cloutier <vincent@cloutier.co>
---
 drivers/power/supply/max17042_battery.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply/max17042_battery.c
index 09bb1babb0d6..b93fedf183b1 100644
--- a/drivers/power/supply/max17042_battery.c
+++ b/drivers/power/supply/max17042_battery.c
@@ -903,6 +903,16 @@ static void max17042_enable_soc_alerts(struct max17042_chip *chip)
 	max17042_set_soc_threshold(chip, 1);
 }
 
+static void max17042_suspend_soc_alerts(struct max17042_chip *chip)
+{
+	if (chip->chip_type != MAXIM_DEVICE_TYPE_MAX17055)
+		return;
+
+	regmap_update_bits(chip->regmap, MAX17055_Config2,
+			   CFG2_DSOCI_BIT_ENBL, 0);
+	max17042_set_critical_soc_threshold(chip);
+}
+
 static irqreturn_t max17042_thread_handler(int id, void *dev)
 {
 	struct max17042_chip *chip = dev;
@@ -1220,6 +1230,7 @@ static int max17042_suspend(struct device *dev)
 	 */
 	if (chip->irq) {
 		disable_irq(chip->irq);
+		max17042_suspend_soc_alerts(chip);
 		enable_irq_wake(chip->irq);
 	}
 
@@ -1233,8 +1244,8 @@ static int max17042_resume(struct device *dev)
 	if (chip->irq) {
 		disable_irq_wake(chip->irq);
 		enable_irq(chip->irq);
-		/* re-program the SOC thresholds to 1% change */
-		max17042_set_soc_threshold(chip, 1);
+		/* re-arm runtime SOC alerts */
+		max17042_enable_soc_alerts(chip);
 	}
 
 	return 0;
-- 
2.53.0

