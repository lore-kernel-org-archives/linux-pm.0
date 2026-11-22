Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795355972;
	b=spRRsY76d82yQFAKiyhBPz9BtruBfgDAmpcnwqur6ZWE4FB2mjsYgnTfKNHeThK0z1zP
	 DPd/I0lwSXVnI98wIYjQSlT7McxB05M5NkCf/JE3+l9ghKTM5Rq6R7NGjqXyWSGO8MvZK
	 JrMEE658MjVqGtc7SrRy1wB3ohILpGqabg1t0VAKP8bxEFsqZhzRCWeVuWdSEgdNDXqUZ
	 vehKibGYIcXXimwbZR+yArC9FPRwoydeV9hKs8e1AQk0RinLemcxsi6Qe7IFR8j1eaUM/
	 ZvVrfIJb+oQZi4Qlc5LYypN5zu2YJ0+KK6+kVsOZMWQpbNJoxR7teGwCJ+3hJwovM7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795355972;
	h=Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=pQRIFlXVeD2k9S79sDVf0n2jthJ7bOLnLDajn9P68r4=;
	b=p8WxVNhZi8sXP7n3ZVD3beDt9rGYd9qbJcZI0e+ZgvvKo8KOpVjmEQxChTaIC3K/tzYJ
	 m5QXFyQ1YXSpF/f06NUBYoxpYNAz8iKKXcvWIMvkfZoY/wkKoPTO5BMfc/2IRPdrIbYGO
	 PVn1Z1oTXwmRVEHTWR/c/nEteiKbiqU6o/mb2qtE8ydsCjz3FsnTzrw7S0IOT9tlc+TA5
	 oxZESKqGiHh7GfWydool2SStpfxHkK5z8QpzzbBUaN7jilcfVyexP2o3ftyuXvG8w9KHT
	 z2D+h5awJ+9aNfasVqwA7pNqOO99TEbVeWOlt3rZPi/Me9K2qCMTBmzLvW0sZyyNbqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7670C606A333;
	Sun, 22 Nov 2026 13:59:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 641201F000D3;
	Sun, 22 Nov 2026 13:59:31 +0000 (UTC)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Sun, 22 Nov 2026 14:59:13 +0100
Subject: [PATCH 2/2] interconnect: qcom: Consistently handle MSM8953,
 MSM8976 and others
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
Message-Id: <20261122-b4-qcom-kconfig-unify-interconnect-v1-2-d5e65c1fbd7d@oss.qualcomm.com>
References: <20261122-b4-qcom-kconfig-unify-interconnect-v1-0-d5e65c1fbd7d@oss.qualcomm.com>
In-Reply-To: <20261122-b4-qcom-kconfig-unify-interconnect-v1-0-d5e65c1fbd7d@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2548;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=YR8PUEtqxH+Kf8lxRa/IMlZUiFR3s3IU4wPu/Q17tUc=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBrAvU3/SCk9F4c5zaUT+rdfPTozzl7B8jGMdVBm
 58Ga70+fuqJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCawL1NwAKCRDBN2bmhouD
 14asD/9/Nvy2XaMG3HK9fkJAU52Tgj0ohA/3pE4D3Z4bC46joEmd+BcYgktb4Z8/lrE/BzlWku/
 XxsIrRyDVm/dW2Llhsk3aTb4Rr4/DEUeLW8ax3xi5IuzwBvI1jM1t/nMyYzWIU6+o1y8ex2/3F9
 6aw1DtGxuIFA3mQ15RYoEg+SM80T+RhD2/JVjFC3x/hj/uMT8lxiTV1Tcrhgxe3vxqitdOCuo3V
 cbVu5cKBK8I0h6EY5jxqBIRMzpKpzp6Nr4NDg/4Pt11uwuV8LrNBD/OLab62zzf0shnytdCgOFR
 D3kF9hoPZ5VMaxzCqCWCr3L21i6UXxDp3pFDA4oeZOgiRopVMQYWx9Wm6ar0fNjYIbQYCjB18Yt
 EFHn6OB63wQwJAaqykz4N4MUgQMZFD4iiKYKLKiaudI1NkdZhHv9TpgQs4sQdzPcHAqHdeO9IpB
 9RH3jTBIFweB+EB1QvUE5KqFzcv2ZaMELxMbEyq+1xJ+v86kEMCC6qhEGS72OeNz3epRzk4knUu
 IVU2I8U3wPqD7L8ykvGOzhH6ACsSF8HZgJ9Iab3T+9F6vb8YV00gaEqXdoss53tjZ+/L5OzW+9v
 rMQobwhlPwj1Dh8OkUSiJ5bamLZE4vXWO8+3uxujJNtQ2VEUS/zw/yejQGpEb5yRDrcbuP4DR1p
 cxubTqp0FP3Qlmg==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Other critical drivers, like clock and pin controllers, for Qualcomm
MSM8953, MSM8976, MSM8996, QCS404 and SDX75 are allowed for 32-bit ARM
builds, so interconnect drivers should follow.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/interconnect/qcom/Kconfig | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/interconnect/qcom/Kconfig b/drivers/interconnect/qcom/Kconfig
index 110789a2d232..59a8d1142e76 100644
--- a/drivers/interconnect/qcom/Kconfig
+++ b/drivers/interconnect/qcom/Kconfig
@@ -120,9 +120,8 @@ config INTERCONNECT_QCOM_MSM8953
 	tristate "Qualcomm MSM8953 interconnect driver"
 	depends on INTERCONNECT_QCOM
 	depends on QCOM_SMD_RPM
-	depends on ARM64 || COMPILE_TEST
 	select INTERCONNECT_QCOM_SMD_RPM
-	default ARCH_QCOM
+	default ARCH_QCOM if ARM64
 	help
 	  This is a driver for the Qualcomm Network-on-Chip on msm8953-based
 	  platforms.
@@ -142,8 +141,8 @@ config INTERCONNECT_QCOM_MSM8976
 	tristate "Qualcomm MSM8976 interconnect driver"
 	depends on INTERCONNECT_QCOM
 	depends on QCOM_SMD_RPM
-	depends on ARM64 || COMPILE_TEST
 	select INTERCONNECT_QCOM_SMD_RPM
+	default ARCH_QCOM if ARM64
 	help
 	  This is a driver for the Qualcomm Network-on-Chip on msm8976-based
 	  platforms.
@@ -152,9 +151,8 @@ config INTERCONNECT_QCOM_MSM8996
 	tristate "Qualcomm MSM8996 interconnect driver"
 	depends on INTERCONNECT_QCOM
 	depends on QCOM_SMD_RPM
-	depends on ARM64 || COMPILE_TEST
 	select INTERCONNECT_QCOM_SMD_RPM
-	default ARCH_QCOM
+	default ARCH_QCOM if ARM64
 	help
 	  This is a driver for the Qualcomm Network-on-Chip on msm8996-based
 	  platforms.
@@ -196,9 +194,8 @@ config INTERCONNECT_QCOM_QCS404
 	tristate "Qualcomm QCS404 interconnect driver"
 	depends on INTERCONNECT_QCOM
 	depends on QCOM_SMD_RPM
-	depends on ARM64 || COMPILE_TEST
 	select INTERCONNECT_QCOM_SMD_RPM
-	default ARCH_QCOM
+	default y if ARCH_QCOM && ARM64
 	help
 	  This is a driver for the Qualcomm Network-on-Chip on qcs404-based
 	  platforms.
@@ -376,10 +373,9 @@ config INTERCONNECT_QCOM_SDX65
 config INTERCONNECT_QCOM_SDX75
 	tristate "Qualcomm SDX75 interconnect driver"
 	depends on INTERCONNECT_QCOM_RPMH_POSSIBLE
-	depends on ARM64 || COMPILE_TEST
 	select INTERCONNECT_QCOM_RPMH
 	select INTERCONNECT_QCOM_BCM_VOTER
-	default ARCH_QCOM
+	default ARCH_QCOM if ARM64
 	help
 	  This is a driver for the Qualcomm Network-on-Chip on sdx75-based
 	  platforms.

-- 
2.53.0

