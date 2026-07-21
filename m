Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D25446067;
	Tue, 21 Jul 2026 09:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784626598; cv=none; b=pa7nRwI/I0PF8NlNPLXf7FmTclES8MdDEA7vCBpBiP+pOGTkjxbK17sBchaZOqf2SUHlgerbibBmnwKT5xF4VTvzWWKoWmFSsKCpmZpZVpE1WN6hur5nqAcyglfMy9iqkBpklyQWadqAggCcoeSjkaUyrSh8GNSnAPWH4Ag2f+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784626598; c=relaxed/simple;
	bh=RURxCIbiO9OLzJXZt4K2oNgOwNPpFBiKCrMOjqtktAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E1uymkTBwifId3zF6yyULi8raBg/BOn7rY5IR46Fv2NFMWN5yYIbOP0wnYCGJ/3uiMZnM40Vc3rXSRoyT7DoQwKkWLoEVMxr7GSQE8exrq2Qq5dNwK4q67lcYOOgRi+NOj0g5QPDnVQ5HxDha3jeDszqMmxjD0/6wRxsqKG5KpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=K0GC19BD; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="K0GC19BD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1784626595;
	bh=RURxCIbiO9OLzJXZt4K2oNgOwNPpFBiKCrMOjqtktAw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K0GC19BDJo5oWvYNrBU9kq11veCvItmWezy1z1NpDFfeLt+fUugRX+26/zGLO/K/y
	 XoJrebVu0M6+QaHeXu2at3Z7L1fp+OHe9S+gPj/rQPNc9woFRM5JB8XZV1W9ZxhKRi
	 2ta3lJ8fE7RM1fyaiPOhzSxWQZT/FCOGgNOFrtJQsK3ggQKOYPgWtM2ARhFuZVj5OM
	 5wbdlo4YVbTfFztJTtjW0NkT4T3qoZE/EIlCWDhcUtDJGVdo2N3pRoGvoi/i3+682R
	 MnRgILF4h4IFEzI9a3aUOYZsdCJGmCJ7RSEVBYGvaWQW7oWIwA1Vd9w1CQmTkh/PJK
	 Dsze2EfN1HRLg==
Received: from IcarusMOD.eternityproject.eu (unknown [100.64.1.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id EE5AB17E1066;
	Tue, 21 Jul 2026 11:36:33 +0200 (CEST)
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
Subject: [PATCH v13 03/12] spmi: Print error status with %pe format
Date: Tue, 21 Jul 2026 11:36:17 +0200
Message-ID: <20260721093626.96264-4-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260721093626.96264-1-angelogioacchino.delregno@collabora.com>
References: <20260721093626.96264-1-angelogioacchino.delregno@collabora.com>
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
index 7cd81394c925..ec4389dfae28 100644
--- a/drivers/spmi/spmi.c
+++ b/drivers/spmi/spmi.c
@@ -69,7 +69,7 @@ int spmi_device_add(struct spmi_device *sdev)
 
 	err = device_add(&sdev->dev);
 	if (err < 0) {
-		dev_err(&sdev->dev, "Can't add device, status %d\n", err);
+		dev_err(&sdev->dev, "Can't add device, status %pe\n", ERR_PTR(err));
 		goto err_device_add;
 	}
 
@@ -494,8 +494,8 @@ static void of_spmi_register_devices(struct spmi_controller *ctrl)
 		err = of_property_read_u32_array(node, "reg", reg, 2);
 		if (err) {
 			dev_err(&ctrl->dev,
-				"node %pOF err (%d) does not have 'reg' property\n",
-				node, err);
+				"node %pOF err (%pe) does not have 'reg' property\n",
+				node, ERR_PTR(err));
 			continue;
 		}
 
@@ -523,7 +523,7 @@ static void of_spmi_register_devices(struct spmi_controller *ctrl)
 		err = spmi_device_add(sdev);
 		if (err) {
 			dev_err(&sdev->dev,
-				"failure adding device. status %d\n", err);
+				"failure adding device. status %pe\n", ERR_PTR(err));
 			spmi_device_put(sdev);
 		}
 	}
-- 
2.55.0

