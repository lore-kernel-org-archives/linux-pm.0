Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412093E8330
	for <linux-pm@vger.kernel.org>; Thu, 25 Jun 2026 16:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782403663; cv=none; b=YWs/2SZs5DBtlNVJUHYjTAJcvLpvXPZcD94WWEq1st8nnmI3lGMwOOd3xQwzbr5hYVfbEf2TLMGtxpRwkIJBg2GyAxZQ/SfyPPTdH33cpBLkvjv6S2tOQr0WyvEF9IGmKc+Vh7PiGN6dR/nuFOnqDOZJPVvXQZUEtuz3JlyErJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782403663; c=relaxed/simple;
	bh=h33sooVrCbTG5jJ44p3NjBGF+AChHF0yDgbpED9sCwM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mV2iSo9VKM3bOktrajmJNt8BO7D1qDLOPT/V1OsoQmJr+w2kZZ4SPktcDmdtJRmVW48TXrK9sOgmOhMkxOVPGreBGeBaQ0D/LH9eQ2JFZe4p0oSFfKku94rQOCPEgoZt+ertzWdkxQiwRx9iHuIgI1o3J9cGNNMPxDooT6xWMCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bVh2mKL+; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bVh2mKL+"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4903d730b1fso264515e9.2
        for <linux-pm@vger.kernel.org>; Thu, 25 Jun 2026 09:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782403661; x=1783008461; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9xlNMIqzkOijapT3trmKB36H51y0Q3Hatzee9XcmfXw=;
        b=bVh2mKL+60lJLfbvQaVuYhDktryGa42/C14+Wbiamzi6YeDdSu0RAIE31iHEOWDC4u
         nKDn6tvafYTBvAv5g0QQWH7X6u+yiW7IUKZkIqHidHFMnIrrX62Y0SgA+Vqmn5PoC/vl
         g6Dj1A/XcVXwzRVwOr/weapVHvCijFzG3ellNp7jPCCYyPvIbqu9AKtPBeSlEmbbrWCq
         P4Lqwtvej7WrdbmXjHSOEvLIYTBVPgPiiUYkFCFh0f4swOc0k7wrt8UK5FNVndhT8ORF
         K9TWpsJwR8TvO62EpbhtiId5MxE+LL+UP3tdT0CvY2axu2U4TePijkVdsebhm+cEBhMN
         A7qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782403661; x=1783008461;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9xlNMIqzkOijapT3trmKB36H51y0Q3Hatzee9XcmfXw=;
        b=ehSDV42gRZVMYCmC+rPDUhYvqfHtymaaqHRZm1jPLqRzHx/6vq7G/GV2WkhPW3Pg96
         KzNSz0GNAhWTCciEdiSOqR8osaDmGJutTMGwxTs7EVh4lXnw+xdjh8ytwJeEveOwRoDk
         wxpx4W5iDzHRZLedcpyvA7RlYH8Q/6F9idNIsAo+cjZzVRoSdckT2ss+qRO3rGacjKaS
         bxVvJAEP2uEPXqElSmOv0U8G5AlOlJQeau/qLVrDrDLpcuQkDvOQNJ0a7yyrHiallG4V
         ZKCfH/axo6YHSWOPT8B2QyEZmzG38A4ElUQy7wTOBWRpUvteOwR94C0Neqg/86YJCH6y
         DEOw==
X-Gm-Message-State: AOJu0YwiB4Vzq6FxAiqM5qsV+ydRwvn8kx57bIBlY5h7qONTFDtVox67
	DYCnqXoaAEP3wXHAQXGfWLYml/3j0Ji8/MmBzC7EoVwJMeYjP2fY2NTG
X-Gm-Gg: AfdE7cnEESGRFktGweEWCU9GL44qp8Ek9Rw9bJq6P/v0BzkXA88YFL6qSfJsiWtxIDX
	bW3RfDK9EHmrdwjjpkasVuTOKf7JvbeA5zmNOsgXX+GbCKJe2W0JPSAr2mIkkiVAXjtdrDo+MMa
	xiNZhUVZRXPM71iPAIOFQhe1cSdJacTjNuw75EbyC65PVAJMZRtMdCe6AzXCYfMZTuab+Qnae/g
	EPpCJZXVXMAzerKjEoJX4nWIFGqXSY6WKi697v0tUuCdw3WrhIEAS8g+wW7GaSNwgodS2hiSUnh
	n1TiaLzXKU4XUc2nKXI8KvUbTQJi/xF7gdsGJduPmhYsqoBP2PC/YWHmok+GV2mPIRI89Ksr7H/
	MDEnYV0POg4Rx7+lUrCfk4WM2Jn9hB/Tn1FQ2JqceugFRJMq7r5u3JTvH+sfvh4LRh//5G462+g
	g+8aBUxdxXSyq8
X-Received: by 2002:a05:600c:609b:b0:490:e60b:6860 with SMTP id 5b1f17b1804b1-49266833cedmr44566275e9.7.1782403660449;
        Thu, 25 Jun 2026 09:07:40 -0700 (PDT)
Received: from beast.lan ([2a00:c281:1461:c400:bf16:e4f3:7fa:c2dc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49268fef710sm12844515e9.7.2026.06.25.09.07.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 09:07:40 -0700 (PDT)
From: Boris Shtrasman <borissh1983@gmail.com>
To: Sebastian Reichel <sre@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-pm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Boris Shtrasman <borissh1983@gmail.com>
Subject: [PATCH v2 2/2] selftests: test possible usb type values from documentation
Date: Thu, 25 Jun 2026 19:05:55 +0300
Message-ID: <20260625160556.54830-3-borissh1983@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260625160556.54830-1-borissh1983@gmail.com>
References: <20260625160556.54830-1-borissh1983@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

modify kselftest to check for usb_types values from
Documentation/ABI/testing/sysfs-class-power instead of only checking for
property.

Added the
"Unknown", "SDP", "DCP", "CDP", "ACA", "C", "PD",
"PD_DRP", "PD_PPS", "BrickID", "PD_SPR_AVS",
"PD_PPS_SPR_AVS" values from the
 /sys/class/power_supply/<supply_name>/usb_type section.

Signed-off-by: Boris Shtrasman <borissh1983@gmail.com>
---
 .../selftests/power_supply/test_power_supply_properties.sh   | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/power_supply/test_power_supply_properties.sh b/tools/testing/selftests/power_supply/test_power_supply_properties.sh
index a66b1313ed88..7bf76af4cfd5 100755
--- a/tools/testing/selftests/power_supply/test_power_supply_properties.sh
+++ b/tools/testing/selftests/power_supply/test_power_supply_properties.sh
@@ -58,7 +58,10 @@ for DEVNAME in $supplies; do
 	# This fails on kernels < 5.8 (needs 2ad3d74e3c69f)
 	test_uevent_prop TYPE "$SUPPLY_TYPE"
 
-	test_sysfs_prop_optional usb_type
+	test_sysfs_prop_optional_list \
+		usb_type "Unknown","SDP","DCP","CDP","ACA","C","PD"\
+			,"PD_DRP","PD_PPS","BrickID", "PD_SPR_AVS" \
+			,"PD_PPS_SPR_AVS"
 
 	test_sysfs_prop_optional_range online 0 2
 	test_sysfs_prop_optional_range present 0 1
-- 
2.47.3

