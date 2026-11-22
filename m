Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795355969;
	b=ImgBCYUd6gwaiU+LRYQNR9FqATFPZmX/jE4fdVPCpr16ovGuCT++caeRksTHFpfAM/Yz
	 UyK6eOKT/j6fo6KVvtel9V4nciGaGR48DRwVjmR2lRHtkV4fa0CJ4UX7TYhOuucJzWMNo
	 BkBVJfN0xEj4uOuC1ey5GuNak5ORSF/RHJmb0o1nUjaWKPaH6qVGGVWD5xpxCSW+odD/x
	 FHupGtYHuofvjh5jb/M5oMABQ2GmkpbZy4DyBB1xJa/yhLDDg5znl1P6apK5n5xoRPQMd
	 8aLDC3TZtNQ5tdILsW6avr22wvXGG1nRI1mSxEHR/r9qfus0rq4/v4YVz1i+CXY3FhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795355969;
	h=Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=FAqlgXzrPgvz39IQUH9LPoXp2YywYov87eDHsyT3IrA=;
	b=VINKzvOj4yb1KhQJEHak/agjkXXdMVngn8CUQ70gVbqLw8XAkYtVU35EFcYNfSs2ZD85
	 w5nLLEzEXfhRaY3vNkuxZF1TKvzbfLTVWV8LqBXaJCluMnarn1toPBP/dYi7ndRcjokgb
	 SsXiaCSyp+K1RLAHgXArxBzPNBf6TZU0N3pf1E9XTSG2W1YgKpnUhEZvlUa2+G0yDRKYj
	 9vzF2BBmy9KY0gtJSAx22R9hb4T8GC68cHFKXJP2XxZ77cCQLQ3LwGQ68jAz/GYKYbVJY
	 nmAHlbWdpqJ3VC8pUw1tjlU3JHj7ca6B6aZeOpOzHJfNGTpgvnUt3SCuJl3NAr1r3wA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2159606A320;
	Sun, 22 Nov 2026 13:59:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B02A21F000CF;
	Sun, 22 Nov 2026 13:59:27 +0000 (UTC)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Sun, 22 Nov 2026 14:59:12 +0100
Subject: [PATCH 1/2] interconnect: qcom: Consistently enable MSM8916,
 MSM8939 and SDX65
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261122-b4-qcom-kconfig-unify-interconnect-v1-1-d5e65c1fbd7d@oss.qualcomm.com>
References: <20261122-b4-qcom-kconfig-unify-interconnect-v1-0-d5e65c1fbd7d@oss.qualcomm.com>
In-Reply-To: <20261122-b4-qcom-kconfig-unify-interconnect-v1-0-d5e65c1fbd7d@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1437;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=Rx0AZ4Fj+0lgGR2cyWrTgoIUSS3bMe2fz11jfRihIpk=;
 b=kA0DAAoBwTdm5oaLg9cByyZiAGsC9Tagctf+VaFKDH1pxg/519wiEy7qxUgvGD+kJdNkOt3Gh
 IkCMwQAAQoAHRYhBN3SYig9ERsjO264qME3ZuaGi4PXBQJrAvU2AAoJEME3ZuaGi4PX/18P/A8C
 lyl/aBYZW1JcnhIkmozfeDNP+PjraLrbGTFNOnJ0jMr8v6JiQS16zS2fyrn0Cb3zmjBbo6+ruQ4
 q6EFZgq2wh4XMVh77syrZFaRpdBC7mvFSuqrlX0ducNW2w3AsQuAS8EvzDfLPr0iBRSB0J+tR2x
 BrFrgZ71E1i27DSNFgndR0r0E01Wg4IvNz1iKBzml6DC8J+uky7e/ZxIcuPrfoe40Edsnv8ak59
 okTUwVbFBn/VRGX4tyEyA81mWLqpGI3KidvivQy5DoQ1r+Os7R34UCsHlaI7O+huPAZuuH/zOZ+
 7jdrL2kjwrlV+AI4NCLqcTvwMYKqKWM8F8USdQ/wnMXodN84fndqZQatrzx/yz43iO9ZB9UFZD+
 KgnpmtZj4oCCLj5xrrl4HQRSFTY92u+47RBQHiKmuAdSGIV+UDWWQGv7SWwPJEoTEVIQv6crhri
 LSBu6GbkrVJCT+xHEF9t6VvKXK6pd4yZ4Nu+rwoc019BBqKVJHxDhd+Mq9fcrNCKDDD4BzAGYfc
 ZrKqvBucRgANLzI5xur2oPXrv3T9kyX5Dc7T0aTCPjnmclwSeeXTWTHlNbrE0AN4B7WRpUu4wMH
 A99ih46XvJevpwepkQW5u2yA6qzcdrtlnLK8ZPgcAaGMKGyazrRJEGACgsbqkmbn0LVo3vcNV7T
 jCMmd
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Critical drivers for MSM8916, MSM8939 and SDX65, like clock and pin
controllers, are already enabled by default (MSM8916 for both ARM and
ARM64), so should be the interconnect drivers as well.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/interconnect/qcom/Kconfig | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/interconnect/qcom/Kconfig b/drivers/interconnect/qcom/Kconfig
index 7f3a977e8f10..110789a2d232 100644
--- a/drivers/interconnect/qcom/Kconfig
+++ b/drivers/interconnect/qcom/Kconfig
@@ -92,7 +92,7 @@ config INTERCONNECT_QCOM_MSM8916
 	depends on INTERCONNECT_QCOM
 	depends on QCOM_SMD_RPM
 	select INTERCONNECT_QCOM_SMD_RPM
-	default ARCH_QCOM if ARM64
+	default ARCH_QCOM
 	help
 	  This is a driver for the Qualcomm Network-on-Chip on msm8916-based
 	  platforms.
@@ -111,6 +111,7 @@ config INTERCONNECT_QCOM_MSM8939
 	depends on INTERCONNECT_QCOM
 	depends on QCOM_SMD_RPM
 	select INTERCONNECT_QCOM_SMD_RPM
+	default ARCH_QCOM if ARM64
 	help
 	  This is a driver for the Qualcomm Network-on-Chip on msm8939-based
 	  platforms.
@@ -367,6 +368,7 @@ config INTERCONNECT_QCOM_SDX65
 	depends on ARM || COMPILE_TEST
 	select INTERCONNECT_QCOM_RPMH
 	select INTERCONNECT_QCOM_BCM_VOTER
+	default ARCH_QCOM
 	help
 	  This is a driver for the Qualcomm Network-on-Chip on sdx65-based
 	  platforms.

-- 
2.53.0

