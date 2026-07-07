Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DA33F789C;
	Tue,  7 Jul 2026 11:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783423117; cv=none; b=BW0jtFbr6xPSKaVQYO3Y4aussAvNz6jaZfO6tsKMMMAUGg28lTdaoio3kduA9Ds0J1zklyHaNR046n4EgAAauRa4RgnI0hkwKXuyhZqtIlra42m41Q1GRnyKQK3bo25onGpx8g0lDWPmJXohDs6C09/SGqy1RsD8pBC6o6SY3ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783423117; c=relaxed/simple;
	bh=TQknSFD/ctzrVBQdTQTZl0Trj8btkpkwP4pqiNucVzA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Aq/GftaANQzKpP9RnzBvhtNGNi89QHhMbykzgf0AgNXyptVi2bP8Mx3bU2a/fXVurT3JIDdsWkwYwj+8wpH3RVx9LDq0ZzfFpSdJtdEHMsvrRXzbYLb4JwkG+b7qf/YMKhCrclxIgKSmvV9ThMEV23lGuxXLFRqcWILl9MeR+Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=QL19opox; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="QL19opox"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1783423114;
	bh=TQknSFD/ctzrVBQdTQTZl0Trj8btkpkwP4pqiNucVzA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QL19opoxz0wTbWmi0VWbqXPnx54f8b1lAra7I94SfvyMblhP6YwvbMCVx6ekTnRGq
	 hzFdqwQIxZ7tB0emCW88la4EkluEBLoIo5YOXwNf5AuBkHFhIUeng8/1KLcgH6MqK/
	 5Q9cZmTLjhtHJ+KKpBJHj46pgedhDyOniqf34Jb9/04FNdk1S3+Hzx2GzugSvIJz3l
	 NFATxCt7Qxfvg/G7CV3CKQtLVQI4t9xPRsyuc7JIYoSr0ocqmgdbNtiGQ1+GCb3yI0
	 qtV+9ek319SmuA0j7rmiAI7VQw06qBevXbADjCK+MG/q5kZ+ZD+kiX+FBojPt3mo2x
	 g7K41IaStulww==
Received: from IcarusMOD.eternityproject.eu (unknown [100.64.1.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id BC33617E0D56;
	Tue, 07 Jul 2026 13:18:33 +0200 (CEST)
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
Subject: [PATCH v12 02/12] spmi: Remove redundant dev_name() print in spmi_device_add()
Date: Tue,  7 Jul 2026 13:18:19 +0200
Message-ID: <20260707111829.180158-3-angelogioacchino.delregno@collabora.com>
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

Function spmi_device_add() uses dev_{dbg,err}() for respectively
debug and error prints, and passes the same device pointer as both
the dev_{dbg,err}() parameters and to a dev_name() that is part of
the actual message.
This means that the device name gets printed twice!

Remove the redundant dev_name() from the messages.

Acked-by: Stephen Boyd <sboyd@kernel.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/spmi/spmi.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/spmi/spmi.c b/drivers/spmi/spmi.c
index 2e4ed06fab42..de019f3f1e27 100644
--- a/drivers/spmi/spmi.c
+++ b/drivers/spmi/spmi.c
@@ -71,12 +71,11 @@ int spmi_device_add(struct spmi_device *sdev)
 
 	err = device_add(&sdev->dev);
 	if (err < 0) {
-		dev_err(&sdev->dev, "Can't add %s, status %d\n",
-			dev_name(&sdev->dev), err);
+		dev_err(&sdev->dev, "Can't add device, status %d\n", err);
 		goto err_device_add;
 	}
 
-	dev_dbg(&sdev->dev, "device %s registered\n", dev_name(&sdev->dev));
+	dev_dbg(&sdev->dev, "device registered\n");
 
 err_device_add:
 	return err;
-- 
2.54.0

