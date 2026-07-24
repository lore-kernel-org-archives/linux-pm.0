Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882B33DFC61
	for <linux-pm@vger.kernel.org>; Fri, 24 Jul 2026 08:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784882666; cv=none; b=skHfE8KDt0iP2FcgD2UQzLlTtyOKX7SzdxOxvYXezqp0aptkGsmWioitVBLL8U6DFKvTAgGDDH00SKT05Ikam+K7bet/U6wUX1vgKSLZzc9q1UEqhAYpIVOeCZibpu3+/ngg/AqlFJxeAI1YXAFNj9kcb7UuUk3A7LZyJW9ghqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784882666; c=relaxed/simple;
	bh=nDUhaI/csnrSHq2VN8yN7twClkIbPM+mTJRxHI6rupU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mkSv1qt+hca5M/W1uzFL/0LrUdrnkeqUKa3b6g0QTH8VI/bcoydvkmFxhRLa7w6ECtsN+hOwoIkGaYUUZzl9fQbr5p2LQbrpZUwGrCHMJCHkmHfudZrY0xXzvP+vIMUrhiv6/m2J2PQn+donubxYeewfHdijmxTbydX2la1EVs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=CmKpXFIY; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CmKpXFIY"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-38e071ed6aeso139476a91.0
        for <linux-pm@vger.kernel.org>; Fri, 24 Jul 2026 01:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1784882664; x=1785487464; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=H3ipik7auGStkEDr/T9A/4r5EQKWd/pec5jMaPqfTe4=;
        b=CmKpXFIY2fz0FEh1sBN5K1MITqW6gA3deUByIwLLyRKlpL8Y/MaJytDIqBrNa0/Tt5
         ljLVkmAIQRnPQNpfB1hDuG2LnAC1j9Wk0fUFM/xkU2F9OIbB7PGkSYRFhJtLRzc2cNrR
         NGBFe4Ii44lPSM+VRSDegxZtWTEppi/5ci6vA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784882664; x=1785487464;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=H3ipik7auGStkEDr/T9A/4r5EQKWd/pec5jMaPqfTe4=;
        b=VcaT4VGZUdERNpt2dFNMDFGVEdyKsgDvdA9kUVIFlJTsOkDab8/C2yngMJrTnIObkj
         bRwTSrTaI7Ky78RgYLXaIwtxAVTYyC7DoPkziQBbR9gFl0Ic2SON+vuXSU6uBKtp4v9x
         FekMjQWFvM7s2aHIQmqkEAhGsaXL9eQiHiUi27TgfPzkPcTGcHErYfO/CbJRu8krzfNy
         jjpMXBKlbKwaAhuM2cbFqnF455D1WcyGLhsF4Dv8nqzZXjzhIhSM4npIf+0QX2CU7PDm
         F5m/W2FYcMbEsEmWjahBnW7VHtV4oEmr0nyRE649TmfvrnZeV4sDUAeE5mOAXS8LjKq1
         6lCw==
X-Forwarded-Encrypted: i=1; AHgh+RrmuRLhclNnv+PoBmdGG4RCzMpAPq3IKbM2B38ixp1fq2ngVHVrQmseALlarmc+VG+vjIMj2nah3Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyyo1ymjIEH7x+VkfEW0QVYaD1ngHSqjSqBWhguZHNDnWHebMbb
	erb35IDWFDGq2DKtNwjbdaxJvTkxhXMMRAeSb03GP8x1yLvJacppPHaXWYbt5b126Q==
X-Gm-Gg: AR+sD13KnVyT40/g3VNOGr1Kak8ePKcmpVvawPNsnkbZEkgrYq41bYW8oYyvRzXZo5P
	nki+YW9ppsU4fOl5vI19F5xlZJmPmHSB68Xqie1fcx/iWAI5QEjRpI/BQrZS8uUYs9VevWTx8+A
	B3E4soqx/2HXDs6yiyDGw08hkZmNoHdlqSnOLAY0QdA+tnN8XvuPoDEB8fi5y8Bg47XdG0sHnFx
	vpjJ3s59NOnPKUcfvBGKz62xKyxUW7ul2bPs+0y3t7U6tWuvl09J7wbhsl7hZ/S68/I+WgSrhAb
	jID8k6+y9fyWSrqDCw1xw+Qqp49MMDr886oUW8Xi1W15JoiJw3xSfMPK9mFOT7eooD2JBom4aow
	YoOiPRzfYq20URX9pfaIYJaXEjrgytortAwOrxBdyxO523y6qv/SdXZcOUukAiJXC/9ko/RdMM8
	vUET69lmd7vao5aVRY6tA+i6Ec0IdhoyREdtzVP2F/CpGOZ4IDjhvS+o3w2jM1y6mrtm2A2A==
X-Received: by 2002:a17:90b:314a:b0:381:23d5:693f with SMTP id 98e67ed59e1d1-38ec65f9916mr6632501a91.28.1784882663919;
        Fri, 24 Jul 2026 01:44:23 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:f131:86cc:5858:7325])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f089ac6d8sm434546a91.2.2026.07.24.01.44.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 01:44:23 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Bartosz Golaszewski <brgl@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Wei Deng <wei.deng@oss.qualcomm.com>,
	Chen-Yu Tsai <wenst@chromium.org>,
	linux-acpi@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-pm@vger.kernel.org,
	linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Manivannan Sadhasivam <mani@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH v7 04/16] usb: hub: Use assign_bit() in usb_hub_set_port_power()
Date: Fri, 24 Jul 2026 16:43:13 +0800
Message-ID: <20260724084328.3943997-5-wenst@chromium.org>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
In-Reply-To: <20260724084328.3943997-1-wenst@chromium.org>
References: <20260724084328.3943997-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

usb_hub_set_port_power() open-codes assign_bit(). Just use the
assign_bit() macro instead. This makes subsequent additions to
usb_hub_set_port_power() easier to read.

This change does not introduce any functional changes.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Attributing suggestion to Andy, since the change was originally
requested as part of a review.

Changes since v4:
- New patch (split out from "usb: hub: Power on connected M.2 E-key
  connectors with power sequencing API") (Andy)
---
 drivers/usb/core/hub.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 2cfe09a141d8..715f26f05a31 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -10,6 +10,7 @@
  * Released under the GPLv2 only.
  */
 
+#include <linux/bitops.h>
 #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/module.h>
@@ -899,10 +900,7 @@ int usb_hub_set_port_power(struct usb_device *hdev, struct usb_hub *hub,
 	if (ret)
 		return ret;
 
-	if (set)
-		set_bit(port1, hub->power_bits);
-	else
-		clear_bit(port1, hub->power_bits);
+	assign_bit(port1, hub->power_bits, set);
 	return 0;
 }
 
-- 
2.55.0.229.g6434b31f56-goog

