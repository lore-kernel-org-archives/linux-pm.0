Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A913F86F8;
	Tue,  7 Jul 2026 11:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783423119; cv=none; b=uRIfbTgUAeK3q67/6BVtrF/ntt5+1u7Px2I2kYuUjkbFCqIvJ5toye5KYj8cmIXXTGgrHmHHtQU+ZINS5bPE4w/kHynkcOcUcqFxOGYuwnHv81iyGm8aMIXqYECmkc/g1darmY337Ax1yCcQVVjTcVaOtv+dXxEQ2q2vzy00NwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783423119; c=relaxed/simple;
	bh=zpAYODfPgEaDXSzIqSip1NB35cM62aU/zNPBl5c3e7k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MuDYnwWp7LG+LX3KG/rSEyfxbuwJJqWsiLQ308XxwezUX8QJK6ze4O65RS6QYXql2tTEiPq91OCwWii+rhBpIj4pn79ufVP3U2mNPO9zNLXH8XFYeery3SvpY3G2otp7agHP9508UkVup8+Qr1wnOO8TWWoWbewW/qegV3i4IaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=HZ59ZB6d; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="HZ59ZB6d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1783423116;
	bh=zpAYODfPgEaDXSzIqSip1NB35cM62aU/zNPBl5c3e7k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HZ59ZB6dUj95vz8DVaW0qi2TChTzf10ThfF2+u9wgGroD/0lliGJQtMaWMXF8Uc9F
	 e5v2u0jxM3tpPvzEXgiVAt1hQE3GU3wSgPT3WFLyLzLPsR7tNCxmxB5GrBshn+KC3q
	 fNCXprrPu6nn1dOrZkWSplcRBCuEsAM2/4g7yCAWDC1hGeG5ZqPLISPhDCrMCyzGnW
	 KhJ9eA123DSjLUb0HITbzwSmrJnEQ+XSc+oZxMvSNLVkW5qEfJx8kTkC8G3gIK0+BA
	 3b7wqfAqAl2bFvrEIOQQkG6iALrEePMcAEu5m7lwu7+DsGmCpt07acDAPZZUsjAu5K
	 CQi9FPd1cskPw==
Received: from IcarusMOD.eternityproject.eu (unknown [100.64.1.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id EDF1117E0DE6;
	Tue, 07 Jul 2026 13:18:34 +0200 (CEST)
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
Subject: [PATCH v12 03/12] spmi: Print error status with %pe format
Date: Tue,  7 Jul 2026 13:18:20 +0200
Message-ID: <20260707111829.180158-4-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260707111829.180158-1-angelogioacchino.delregno@collabora.com>
References: <20260707111829.180158-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of printing just a number, use the %pe format for error
status, increasing readability of error prints.

Acked-by: Stephen Boyd <sboyd@kernel.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/spmi/spmi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spmi/spmi.c b/drivers/spmi/spmi.c
index de019f3f1e27..244bd116f970 100644
--- a/drivers/spmi/spmi.c
+++ b/drivers/spmi/spmi.c
@@ -71,7 +71,7 @@ int spmi_device_add(struct spmi_device *sdev)
 
 	err = device_add(&sdev->dev);
 	if (err < 0) {
-		dev_err(&sdev->dev, "Can't add device, status %d\n", err);
+		dev_err(&sdev->dev, "Can't add device, status %pe\n", ERR_PTR(err));
 		goto err_device_add;
 	}
 
@@ -496,8 +496,8 @@ static void of_spmi_register_devices(struct spmi_controller *ctrl)
 		err = of_property_read_u32_array(node, "reg", reg, 2);
 		if (err) {
 			dev_err(&ctrl->dev,
-				"node %pOF err (%d) does not have 'reg' property\n",
-				node, err);
+				"node %pOF err (%pe) does not have 'reg' property\n",
+				node, ERR_PTR(err));
 			continue;
 		}
 
@@ -525,7 +525,7 @@ static void of_spmi_register_devices(struct spmi_controller *ctrl)
 		err = spmi_device_add(sdev);
 		if (err) {
 			dev_err(&sdev->dev,
-				"failure adding device. status %d\n", err);
+				"failure adding device. status %pe\n", ERR_PTR(err));
 			spmi_device_put(sdev);
 		}
 	}
-- 
2.54.0

