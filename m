Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63469466AE1
	for <linux-pm@vger.kernel.org>; Wed, 16 Sep 2026 07:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789545542; cv=none; b=GCJfYwFO8KcokaH/ghosZJt8tMItq1/M6BtXqkGOYqTGU90DZFxzDjhyp/fZsXyknN/dsnIEKSAwzsM7pXkNnDhvHPRU69KPC4JIsS6y2U2fi2TOX6jdpuwCsR0rgwRrAk6si2LOtfaHN24YFwpw7fB4Qr34gslqBhlqXgTpla0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789545542; c=relaxed/simple;
	bh=guAn9TMfJdLxEfb0LTGkrmmVx3DDJgyF4Kcka2QfUz8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mIpQxtlcDbT1ctvP9PVt+olcjE1hMDhhsxHNBPRg29NNLWPckrPGuGUI6WXT78EqAXE6BuduC2yO4pBvGukSyTjLHA/zWjadvxu0tHHvdViyQnGOB1r/1fC968cD8X/fPruF6J/7s92h+tmOMqmlUXpTsSYRf+Lbg/QBW5059cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bFRS5K0f; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bFRS5K0f"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-396cccbba92so527838a91.0
        for <linux-pm@vger.kernel.org>; Wed, 16 Sep 2026 00:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1789545523; x=1790150323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9EP7B7Ij+uzgh7ozqOWENJmY+4dziA6HYdxmCK1rOAM=;
        b=bFRS5K0fJAFRwemfCnobO4KDZTJ0Upc+aurdNPL5HXxuXmicqD+uwP31FwD0DPH+2h
         guPLAibJTdNgLyZ1K8XB7SpjnWbvJ6sd6N2NPfzzBbnRJUZv5BtKeDkNWIzn/YTEs1p5
         p/SihHo7CsS/rx2z6z70oTxKTyoxlUNDjUrVU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789545523; x=1790150323;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9EP7B7Ij+uzgh7ozqOWENJmY+4dziA6HYdxmCK1rOAM=;
        b=jQrZ6+JND/Tf6Biy4XNgPhUPjyaolcuS9yTF2spqfLr4RaRphUIFVtTE8wByAs9Bu8
         SP1kJtYg5LICxXa5F7KZdLojIg1msWeqAQWqQv43xJQq54gmk2mjEvd2/wTqqyigC7ns
         RyZ+CZ26e1L/nklqVIKrjU8MZOnU1tcN8kYpJdlQ9jUsy/DOPmGWAAfCKyda4931LSPS
         aIwPCVzsi66ghvyn/fpr/4+pGcYHyZOsyawYYAmI7NfTaSTLgQAIZSz4PN95Cwrne/1a
         3uv0rpW1jAP1XzhFj/6p++8+3FgmIHrpd1NRtxVgW71CuE2rmdPXI5qW3sD3dw5Tzzxq
         +3wQ==
X-Forwarded-Encrypted: i=1; AKwUvBzDlA+tJJ062KBALZFCY3DG6VNczh8Hd4gxUMMDxuTfgKjx55hb7hiOf/Dk1tXe4Fuz+dOhecIMmQ==@vger.kernel.org
X-Gm-Message-State: AFuF++l8EeBZZHTgUiE8YO1a2hS2fnuJeZ2MsDLS/EQMoJVisG6uL0hG
	LXPg6GpnrNvN8Ar4SjVwY1zqGiAIrObiDZ0Y6MBxHvURCsbkBaWTxwbEt106AVjIhg==
X-Gm-Gg: AYBFou1v0RkrlIIUwlgoKoUy3POnHZeya2ChMZOjjzmqbXtiHG9LhhTWU11aV/28JlA
	ki4eAWM849C94yH6NgDS7ncT+guIcB+59xH0GHApMd2Vm/WWbOSmmQ1/GJKGMIH4siudWwbgzRM
	eFHn+b6uXPRce0iHKkTxUdTRDm+DDE5SrYc6R+yWfW3xVshsqk9laf2zOWpXH6PJLCaL3p3RsXI
	MLxYrEg6GbaYnqpiZbmNj5Xe0+VkE8EglrgvZ7RYDUIJpkpBYpmZceKlPSXXTkIY434ULGJcp2I
	SgheIlq5kqQSeYtxKYtDZGLNSqBRyHRPAaDNqiEgCq+LVKErQTtDS76FWgxKSerxAuZxOBMX1qX
	Ri19mPA8aS2lq3MJBXXGiC2mFY6Ki6PaJ9LGs+WMnz29PGb887+irhYLIEr4ZgeoO/0S49mCOik
	tzIYFkyEbGWF25YqwjPAoYzahL2BboLxulS5iE+G3EnaqDwFmXtav3qQmw7L7eHhkftYrSCKCv5
	2jEzG4miY6F8FhGKdSdZbL2ncg9RLHHruuqZhwbgBgOGJYRc6WauyD/YA==
X-Received: by 2002:a17:90b:440c:b0:39d:fea0:c17 with SMTP id 98e67ed59e1d1-39e1e309c21mr3792094a91.8.1789545523106;
        Wed, 16 Sep 2026 00:58:43 -0700 (PDT)
Received: from wenst-7875.tpe.corp.google.com ([2a00:79e0:203d:7:1f62:7622:5d61:2578])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e1b7acba2sm4348197a91.16.2026.09.16.00.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 00:58:42 -0700 (PDT)
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
Cc: Chen-Yu Tsai <wenst@chromium.org>,
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
Subject: [PATCH v9 04/15] usb: hub: Use assign_bit() in usb_hub_set_port_power()
Date: Wed, 16 Sep 2026 15:57:30 +0800
Message-ID: <20260916075745.3549953-5-wenst@chromium.org>
X-Mailer: git-send-email 2.55.0.1032.g73a4cd73de-goog
In-Reply-To: <20260916075745.3549953-1-wenst@chromium.org>
References: <20260916075745.3549953-1-wenst@chromium.org>
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
index 199d3f535a89..a4ec79a06a5c 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -10,6 +10,7 @@
  * Released under the GPLv2 only.
  */
 
+#include <linux/bitops.h>
 #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/module.h>
@@ -902,10 +903,7 @@ int usb_hub_set_port_power(struct usb_device *hdev, struct usb_hub *hub,
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
2.55.0.1032.g73a4cd73de-goog

