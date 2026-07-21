Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD296446C09;
	Tue, 21 Jul 2026 09:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784626599; cv=none; b=sYpwUuMHMHxhGMyctm49g6X1jyJjnCWQfBBTLiJHp6HvnZzWh9yQAdiDWQaahbnTxKvHJe9qIRUEHexJzGqPAAwwcnGXoQbQ1eR5eaQrsedFN1eodRL96aNJAw6Cjb98SWYreWZeyrPqqrUDPEhuy0RiSCTFjxhLjcQ44DsGXTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784626599; c=relaxed/simple;
	bh=2JegC7bwl2yAooLEPFpMPt9OMTNbjCZotatCuYA4LeE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KWInbLoOZy317G2ozWKPUY4lqccwAq4eqOYpPtqQB0Ook2UD3qG/RPF3YwCYgYwuie562tdLA+GysDYc6NRfHrHz0dhoh9H8qJev+2erNPV/kT0HJnMTTGkHwmzhwQy/l0Lgdjm4qEfyoUQdq01AHopnBEV6v35ZjpfF5QhlKhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=qddJp80f; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="qddJp80f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1784626596;
	bh=2JegC7bwl2yAooLEPFpMPt9OMTNbjCZotatCuYA4LeE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qddJp80f+nyQV6STPPvFzXOdkpB4njVmhDF2q/gx6deBLg8X9AiyQbn311xuW9m2m
	 luVno7aMueyUR3PtLgwl0zbjDNItWE1uxT6yJpAp3y0B0QomyW5p3MCHpLrJY1doLa
	 Wtj/972fC1kTaOV4etfvud6AsuwkvIrZjxSy0grJpGUpHLcWojk5xYkkwo1X63L6Wy
	 raNlpoIezBZCixh416wSi0/hAY5eSZgWyRpMusVtyfblxBoKeHfSK3O1JbhKeFvX//
	 y7C0d4jOk+kVS7Jno3D1Cs8Nyk6JR1pOVfnNJ17cM/mA8YDbVPJ9OuePKVe2MFuBL+
	 cjuVcLYbw3gAw==
Received: from IcarusMOD.eternityproject.eu (unknown [100.64.1.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 2C8FF17E10F4;
	Tue, 21 Jul 2026 11:36:35 +0200 (CEST)
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
Subject: [PATCH v13 04/12] spmi: Remove unneeded goto in spmi_device_add() error path
Date: Tue, 21 Jul 2026 11:36:18 +0200
Message-ID: <20260721093626.96264-5-angelogioacchino.delregno@collabora.com>
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
index ec4389dfae28..ba4a980a35eb 100644
--- a/drivers/spmi/spmi.c
+++ b/drivers/spmi/spmi.c
@@ -70,13 +70,11 @@ int spmi_device_add(struct spmi_device *sdev)
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
2.55.0

