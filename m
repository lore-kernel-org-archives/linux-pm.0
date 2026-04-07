Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73AC63A7839;
	Tue,  7 Apr 2026 10:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775558474; cv=none; b=MAIHOn5J0t9usedMPpjeX7t9DsoB8d7sQZUGmAV1pYBqBtxM2MObgdlIMjP//xaP3SdxrX4trg1hX9Ve23/K3ZOkpqjh6DdrfWCsalUiaB/ejHouk07n4ZNC/yq1gSTPnbmD4C2/9KYz2XIR92zWQUSNu4rNwpVgcyLdn1TpiUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775558474; c=relaxed/simple;
	bh=CiHOQaswtehpidBPcpvulY2cIzBWFPhGas3Jv2R5EH4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HWBcOK8POn8OWDJ9uWgNd0GkZ86V8a9fcOLpjTIi+Ig2JnZ5nXETMCMJXyKjO6ielGV9sCbZPnmFuzc820LdoTOw/na1bbpHWOAy4isOFgeKignnmW0SnEshRKqOvpUOpBGfc49s8qsII8f6uXvrEg1lIUZV20Qw/EHR1S0ygu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZQzMS9sc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZQzMS9sc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18CF7C116C6;
	Tue,  7 Apr 2026 10:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775558474;
	bh=CiHOQaswtehpidBPcpvulY2cIzBWFPhGas3Jv2R5EH4=;
	h=From:To:Cc:Subject:Date:From;
	b=ZQzMS9sc+0IRjiNNX+l9PyO3VQxZpw+g0MNLyA8SKtaXsNJj6JLLGGSwKxyeugaRZ
	 nA3VCMJkxYEz9QWtgiOmiR9PUJeTAiBz9qNxwCTrWhpiniilN8w5KLQWSwojvgC0WI
	 V367/W9MBc7RnmDUVXMpxd9yI4GygEh9sLriwxYac2DgAoEc3G5uCcSyhvWz4iU9U3
	 UOJw420DHXaapVquPdIEx3JaP2gv49V+ebFafTCWcKGs6tqkSiuknDHe3AAGhapgr7
	 XnkoLfCinVlV3nHgN5UGhoqG6PqCLt/fJAWt/Sk0f+8mExsN2TC8V+pWtbNNwCP19Z
	 Uwvngc2KYht+w==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wA3rr-0000000B6EI-3HVm;
	Tue, 07 Apr 2026 12:41:11 +0200
From: Johan Hovold <johan@kernel.org>
To: Sebastian Reichel <sre@kernel.org>
Cc: Hans de Goede <hansg@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
	Purism Kernel Team <kernel@puri.sm>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org,
	Dzmitry Sankouski <dsankouski@gmail.com>
Subject: [PATCH] power: supply: fix OF node reference imbalance
Date: Tue,  7 Apr 2026 12:40:39 +0200
Message-ID: <20260407104039.2645514-1-johan@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver reuses the OF node of the parent multi-function device but
fails to take another reference to balance the one dropped by the
platform bus code when unbinding the MFD and deregistering the child
devices.

Fix this by using the intended helper for reusing OF nodes.

Fixes: 0cd4f1f77ad4 ("power: supply: max17042: add platform driver variant")
Cc: stable@vger.kernel.org	# 6.14
Cc: Dzmitry Sankouski <dsankouski@gmail.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/power/supply/max17042_battery.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply/max17042_battery.c
index acea176101fa..914f18ce79b3 100644
--- a/drivers/power/supply/max17042_battery.c
+++ b/drivers/power/supply/max17042_battery.c
@@ -1165,7 +1165,8 @@ static int max17042_platform_probe(struct platform_device *pdev)
 	if (!i2c)
 		return -EINVAL;
 
-	dev->of_node = dev->parent->of_node;
+	device_set_of_node_from_dev(dev, dev->parent);
+
 	id = platform_get_device_id(pdev);
 	irq = platform_get_irq(pdev, 0);
 
-- 
2.52.0

