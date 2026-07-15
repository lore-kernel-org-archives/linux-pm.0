Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861193D9DA1
	for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2026 08:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784105678; cv=none; b=QZJbU9ZS4xADPgK+YWXTn31PQPSONNKmaWIFLYiQhy/wEy2TDP5q2XrlY4KsyaZOs7+K9++5DA3+0e7MhjZcIBDX/51542stbak3N3991kweRL9Hz9luZV51+46i53VEh0h4Sa3SPNgszvHNVUeDXGdhXLw46MyFLI46XmBWpJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784105678; c=relaxed/simple;
	bh=OlqZwr18Cpifvs6/MASST22KmUKK2zb2fxpZOLeBWT0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KZKxnVk2DssIBr4OlUA9dW8NqiO7zVGz8OvIPEUvsP7LHV0TCjB/OrXGvBxZPP2Pot1lyXVIqbcbVNKa0LyRXoJIIFaV3poM1QSnLdcZUKNSr+rEOH0XrvxNy38NLofGqVIX6dwq0b6HAkMauUggDUAbed+OindkNjTKxVV1sOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=VZgYdqBM; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VZgYdqBM"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-848882fdb18so1897226b3a.0
        for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2026 01:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1784105676; x=1784710476; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dYICwpllA6REcHU83KV0EGKSQt2kKv+TAZuxEKEYalU=;
        b=VZgYdqBM9Bta0pcAAOAqBbcozTRYHYk57aR3CCuV4FYSSO4JxeTaLeOzu0Mpkt7PCU
         c4vU4T8TZ6DPuoPQ7wX5fWouPMzzxJ7aTFnDf+Ucl//tVoUCevXtg/Zi3zPLXN4SfZO6
         KOJcR9CfC2XR4tZCmOUeRaGrFgodnGv1Yt2LE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784105676; x=1784710476;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dYICwpllA6REcHU83KV0EGKSQt2kKv+TAZuxEKEYalU=;
        b=HUCc0+eid19SJEQzRSnzXgXsaa0y5ZxCMGQpDu8nZZhKaPBgPG8o87WjqF7RZPB2Cn
         qWuZ4O1Ns4oWCogN2v0/JlKgsuU4/tCDBI+2a32wsMNS5zAAG4wozbQCUgFPGsWDuNqt
         AkQr5FrSLCNe9w+gFAgU4zetFQvv6UJawTVF3+WcLkGGIV/BIuOXG3ZmlJlP6fGjintn
         8xV9npMBawZsHwa3JSyWx9D5q1Q/2eDVI9ybJQ4vBGnS5qM8QOOoY1PV+BtZfxFOEnNL
         Fm06uXQvqXb4U/nkbamGel2bJRQrgpRuonxwUfu8mcvdvgT0mP5ctsaZd3lDOmCmiW1o
         kZ+A==
X-Forwarded-Encrypted: i=1; AHgh+RqTCw2MBzK0yKb5cSLNllf2dHRHQ2gqAHqagBUoqxDrX0Qsy+8MneId4ZpS57nE5Ej8GCTgfGCPwg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxiV9ougcAaygpCvsdmubaUowLBPw0vkNOeXe3dGaeCupQTk/85
	tI2WSCd0szbQ9zqe/BwqtlsgABZqFjfHmHhaApCDYxMsL6Vfqn5WySVXnwhX5ETdjg==
X-Gm-Gg: AfdE7cnfIOp/hxOLspCsBlb7XiMHF5yWN84URlPTem6T//xUI3VfqzxIwjkRsH8oTmA
	+mXm1eAT8ri0R587b4uGmoW37c/IdJuRBgUwxIqPicSy9I+h7QqL61uDHmvV6V5betMq6I6/YVy
	wR/8WPiW9CIpZUESC8ordlNUYoOftvvZtgbAM1dXqfBAy1TX2fgR1pqjVPMBhlM8LkmWDA10x+O
	2ec3dg0DesuJ36ZSwh/Pc4eGtbYeqllTq3CxRutwmsRXV/iIwGBe7qv51dVrnVb1lsfIR6CYLbw
	vkBAqfKTlbzXi6o7xIrTKTFzzGBWl4ClrjPqxEnLX0nk7yPYF1Km89Nhr42ceEOz2qi5H7xESq4
	zrlZNZaADQVxVRULrpN+s1AwXXuuTXQ8p/piNXXxxA/PlrzUJnD+seZ6VbawhAj8CxJAUP2or//
	MzWSQo23b/DUVdnu9uCpvmhNZXTkxT/wEldYD3b/jofXjlg9gJOiTTTqKq4LZ1nPYd6yXXRo6EO
	6/jsQXA
X-Received: by 2002:a05:6a00:17a4:b0:848:88e6:95d3 with SMTP id d2e1a72fcca58-84a673928d8mr1756444b3a.72.1784105676023;
        Wed, 15 Jul 2026 01:54:36 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:47d7:4aa5:a6f8:2279])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84a4f819117sm2757491b3a.59.2026.07.15.01.54.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 01:54:35 -0700 (PDT)
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
	Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH v5 04/16] usb: hub: Use assign_bit() in usb_hub_set_port_power()
Date: Wed, 15 Jul 2026 16:53:34 +0800
Message-ID: <20260715085348.3457359-5-wenst@chromium.org>
X-Mailer: git-send-email 2.55.0.141.g00534a21ce-goog
In-Reply-To: <20260715085348.3457359-1-wenst@chromium.org>
References: <20260715085348.3457359-1-wenst@chromium.org>
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
index 9b2bf608f9cc..36342c5718bb 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -10,6 +10,7 @@
  * Released under the GPLv2 only.
  */
 
+#include <linux/bitops.h>
 #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/module.h>
@@ -896,10 +897,7 @@ int usb_hub_set_port_power(struct usb_device *hdev, struct usb_hub *hub,
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
2.55.0.795.g602f6c329a-goog

