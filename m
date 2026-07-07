Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239C133B6EA;
	Tue,  7 Jul 2026 08:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783413484; cv=none; b=UuE+KcLNFryt1lKQcli2CaAX32OPJ6H7uBpQt7HKRUD8ltOGvclqVhLWCXKaBqj7rNmUZqwWyrY0m/XYT1lM142sGwUCDU3zjcUmkMhg9emrxexWRIH3jLb18z7W12D1SwApXsX2y07OL4IBVOUcaHfiHJQzxwUGldLTWM4kO8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783413484; c=relaxed/simple;
	bh=2tUijlIbwEJAicuHkHE+gb5GjP4Yc9F64tcHiUdnKrs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sfjnjbvjn6RL4DoLJYbtZAqvIV5ratqaJV2Ae/rPZXpXCres7NUUjDKQTByQbkI67mYYdZ3PETbBC3MrORd1O8NMoGModqcN+/k/HZ9t3Ce75YxJw4T52nXaLp3ERhJqyzXcRjJhoumK9SqGMupMBTN7wED9IXL5vQ5UEnrntug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Qawk5Nxc; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Qawk5Nxc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1783413464;
	bh=2tUijlIbwEJAicuHkHE+gb5GjP4Yc9F64tcHiUdnKrs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qawk5NxcHypvH/2atyIVbrJZvW+EhRxsHfreMIAhYqPIYn1gXbsubSobI5ah/6mLe
	 mXaV05bFwCM5V+O3Om7TzCccj3GY5OSiIq9YN3GcPxZ25U9tYWx7vZ0xgzN1waFQp7
	 B0RQ0NcMvHWmsZKINEztdTzYh0rJ1L6DlaTzGT27CfbrtzSbCYUkHNLQ4Cj51NfHy7
	 JJZ7uvjVx8ipTaHMlq+TueUK73dpnckYB1iK4VOusSSiNp3i70Gkv+q4ZeSdcVlYRu
	 WtSPJVk1I1VfVhcW2/RitERDCh/wjobl7u4+8cJGoFMQYFeBhEw5NyTYxfeIRxtYaR
	 u3t4qqrzUuJTg==
Received: from IcarusMOD.eternityproject.eu (unknown [100.64.1.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 3B3E217E0DFB;
	Tue, 07 Jul 2026 10:37:43 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: jic23@kernel.org,
	sboyd@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	arnd@arndb.de,
	gregkh@linuxfoundation.org,
	srini@kernel.org,
	vkoul@kernel.org,
	neil.armstrong@linaro.org,
	sre@kernel.org,
	angelogioacchino.delregno@collabora.com,
	krzk@kernel.org,
	dmitry.baryshkov@oss.qualcomm.com,
	quic_wcheng@quicinc.com,
	melody.olvera@oss.qualcomm.com,
	quic_nsekar@quicinc.com,
	ivo.ivanov.ivanov1@gmail.com,
	abelvesa@kernel.org,
	luca.weiss@fairphone.com,
	konrad.dybcio@oss.qualcomm.com,
	mitltlatltl@gmail.com,
	krishna.kurapati@oss.qualcomm.com,
	linux-arm-msm@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-pm@vger.kernel.org,
	kernel@collabora.com,
	Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: [PATCH v10 04/11] spmi: Remove unneeded goto in spmi_device_add() error path
Date: Tue,  7 Jul 2026 10:37:23 +0200
Message-ID: <20260707083730.33977-5-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260707083730.33977-1-angelogioacchino.delregno@collabora.com>
References: <20260707083730.33977-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If any error happens during device_add() just return inside of the
conditional, as the goto path doesn't do anything else if not just
returning.

While at it, to improve readability, also change this function to
explicitly return 0 (for success) at the end.

Acked-by: Stephen Boyd <sboyd@kernel.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/spmi/spmi.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spmi/spmi.c b/drivers/spmi/spmi.c
index fa3323521f1a..cae89dd915d4 100644
--- a/drivers/spmi/spmi.c
+++ b/drivers/spmi/spmi.c
@@ -69,13 +69,11 @@ int spmi_device_add(struct spmi_device *sdev)
 	err = device_add(&sdev->dev);
 	if (err < 0) {
 		dev_err(&sdev->dev, "Can't add device, status %pe\n", ERR_PTR(err));
-		goto err_device_add;
+		return err;
 	}
 
 	dev_dbg(&sdev->dev, "device registered\n");
-
-err_device_add:
-	return err;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(spmi_device_add);
 
-- 
2.54.0

