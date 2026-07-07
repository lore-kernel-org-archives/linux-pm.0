Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0123F9A05;
	Tue,  7 Jul 2026 11:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783423120; cv=none; b=bh1Dx5TwoYbMGB+rpTyOo12bhXouREuI+4l56Rv0CjL9Q1sSip48BejFwzPAL06drpCYx4wp6dz2LI6Jo7Mm70uUkvRpbAU1xd13PzrKJvoDdL/qaxFkZkKIGiEHQEq72r+gPyBiH3QIkmcTB2wPFebSKWrJ3+5ge0vislDH8nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783423120; c=relaxed/simple;
	bh=VjssSMudF55fYEue8+QvhRjlAJbL3qIke4KqjiMaopY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mMgqXM+mzn51W+N5+eEyDZFCGS+mCa9cpO/h0z9W+9RVR0ivjvDX9k4AXTo53r35jwN7mHxQl+L+u3Vhb8EcQ23v6IPPszg+gsoAf310pyHSxItcxDs6711VykEJs2lnpQy7ZO6vPxx+gwuRKeC+N/yGYwygUGBNVJL6nn8ZDSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=qZuT5jvk; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="qZuT5jvk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1783423117;
	bh=VjssSMudF55fYEue8+QvhRjlAJbL3qIke4KqjiMaopY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qZuT5jvkBny1G68QHOVf7BQMkGWJZmvgUby6lp33PPdp7FOSc4rKuPSDKJEaYLK5k
	 MdLeckZBA6M9KXMQd1XvkXEXMV1nBPDXwaU6qVZTuQQSmgAxmdFGpCu7bvxev6clDR
	 lzZNa1tdzrpnZbKbd86zi8UH/h3ZKJIEABzE3gKt9jZ+cY8BOlIr/JF2Hqai2tkdgu
	 //4XU9jTwil5j20SA54bPAd5G4LwBg/IbPKeykcvK6iLm7AKxYNd9dx8PJ8lNvjxIC
	 mobSRP7866GtPiQIJha8od42MZbXbrfXnzmD6taaX7kZjdNxlPhehblspxmWBgQIg0
	 VjBW1f0ooi7+g==
Received: from IcarusMOD.eternityproject.eu (unknown [100.64.1.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 2BC1F17E0DFB;
	Tue, 07 Jul 2026 13:18:36 +0200 (CEST)
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
Subject: [PATCH v12 04/12] spmi: Remove unneeded goto in spmi_device_add() error path
Date: Tue,  7 Jul 2026 13:18:21 +0200
Message-ID: <20260707111829.180158-5-angelogioacchino.delregno@collabora.com>
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
index 244bd116f970..4050f3614dab 100644
--- a/drivers/spmi/spmi.c
+++ b/drivers/spmi/spmi.c
@@ -72,13 +72,11 @@ int spmi_device_add(struct spmi_device *sdev)
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

