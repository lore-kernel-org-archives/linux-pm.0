Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E993E3C69
	for <linux-pm@vger.kernel.org>; Thu, 19 Mar 2026 16:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773937835; cv=none; b=cHGK9yxdVXInd9oylMA2FPwOzgStmimyFT/RoWly6Xd28CIGz6HMSxTFRFYngUj7Bzkc7M1l99f9rj2vNqg5cNuYaQLeav1BAwLmv28tT7NJdDTrX5xBQfKmPU+zAEQYapkTUVxZ25Mi0zf+pQCLeZ6Gvu0H+GJz7DN2Z487RmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773937835; c=relaxed/simple;
	bh=/0Inx82Sk167/SQ4akQAMhU1dM0KxkKRDf0EL0f/cHA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ig94mOkftI6CYwCpLi4RnVdoMqmQ8VTKa6EpNOgwUbGsO15rNnKz33XAEe9iH0wq/PK4ffkwBXcpcvpHjb//0h3EWspZSD3CirB5VytzUOdXtiW59M37z0hYzk4+kePaVBtCuYR4OdzV9/HJHzRIkP9Ew9uLuQEGnoUnR6wRUOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=idWHtAhu; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="idWHtAhu"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c7413a0e5a0so648873a12.1
        for <linux-pm@vger.kernel.org>; Thu, 19 Mar 2026 09:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773937829; x=1774542629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7WbbIrQRZg+WI5V+d2UHHYYa3r1L0mKPW9kQXI1QdeY=;
        b=idWHtAhuddgzWeDHfTxj0eNK3z7kP0qI2k8cc4HdOVF1HZOn88SgGcmbWcDn+PkDh+
         GqkU4mGe/ScBEh3qSat/x5oKqLktjm7NqfvYZwcGNTvh+s13jYgMAktEfjIG3Shp4NOT
         3TSk+MSrUH98dMq8wkd9DE0agSXzTskngOiRktMbSqt5Crkmp1g5372loA0cLo5x1uXh
         kJod0G3JveBPX2V2HeEVzNZLCIVNmhxdiFz9PD4kl8rBp5ROkeU60JD2ftjGJkDecfL1
         faU1Uut1BX9RnldxBOOTC7NufaPhLcKUIkEsVKTo901hsdzILeFJ74lAOK+/ephteT81
         qZcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773937829; x=1774542629;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7WbbIrQRZg+WI5V+d2UHHYYa3r1L0mKPW9kQXI1QdeY=;
        b=jwdXHzH3aQIx0irMp+GuV+nh2s8jqndyZlkKKCNMR4dZ6t34y5IcYJZPR3sKcolPSv
         3fGO8KZLHvOb/Bhuo2yqCJKIaMgeYp3S9MqtPtYDDnYdKIs/CzzRYgor2ZyAyP/FbwCD
         F/JPgQaQU7MFXhVbIMRCnhlb5T24S0aX/Q7RlHZV+h0AVCYAoaahOEgKoxP49PdKH/r6
         eOzZlT1k/0aEGy+aeAntSaUftbH/JMJEf7lCFW2YvoDtmVE2YQOb9U85YEfBJbszDM79
         5GeE0hcdr9HOeQtME+FpIDUFjxPt4lNrrhcyrwcneI83UFjd+nkr+2mcSTA7B2iUcvuZ
         Hemg==
X-Forwarded-Encrypted: i=1; AJvYcCXP3sYOr1PfPiOrn5FiJRz1dS8JV/1AV4enxc5uWbZskbKYFLIiiJjNHdRCd7dBYr3GThEyK8Y+Vg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzJwOJC1OExiyccla15Dk6LOOOJzT+Navth7olOJQM/CI6hAQQC
	Ch+ZDRfljDdoKp797zyRN2TfRnpza2l2DjfGGE2krfoXx0Hq2ktHwPXs
X-Gm-Gg: ATEYQzyec7GWk5jH3K1z48CNkc9oYTefxK8RU55DchoSGKcTKp9qwp3UNdSb5sFDyaR
	yuU7CWoO6ZciqL84wPwAjm2/L4x6sqGvGp72XG3fEVqkm1PZpAP44x8M5o/mtfuVVk5zy1cEaHr
	JsV1eh0jyJJBS5jx/JUhcSTAQ7P7/fOrK+KfIQ1TvR/LsTsSkR4Tlw4QVlVKO+B/ECMoHQJMKy4
	achz0e5z1+xJFAwKrTT7f51FTCWL2H8SqPILA2GZRGD2rDpb8ZmBeEP2x9u3eTn951jXw0V1/R+
	VJY4kFzlu879v0AvK2mZzVrVvzw1c9qm+io0U6R2dCsQjleFlOD0AUEepvNgkqFehen/npfYUxK
	uOUb2R5bP6QsUEMPjEBUIgHmiHcMdp/e2esVgXwbmJG6RxcLeL3fPV4Va/Nhw4K3MWBVcogxnD4
	YbD+VNwrnRv+GGLQnFBhwOGtDz3xk=
X-Received: by 2002:a17:903:17cb:b0:2b0:67a7:5c4b with SMTP id d9443c01a7336-2b06e3bd39bmr79715765ad.28.1773937829185;
        Thu, 19 Mar 2026 09:30:29 -0700 (PDT)
Received: from ubuntu.. ([152.56.142.182])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b06f7e8290sm61584485ad.82.2026.03.19.09.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 09:30:28 -0700 (PDT)
From: Anas Iqbal <mohd.abd.6602@gmail.com>
To: Chanwoo Choi <cw00.choi@samsung.com>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Heiko Stuebner <heiko@sntech.de>
Cc: Kyungmin Park <kyungmin.park@samsung.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Anas Iqbal <mohd.abd.6602@gmail.com>
Subject: [PATCH] devfreq: event: rockchip-dfi: fix missing clk_disable_unprepare() on error
Date: Thu, 19 Mar 2026 16:30:11 +0000
Message-ID: <20260319163011.18876-1-mohd.abd.6602@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Smatch reports:
drivers/devfreq/event/rockchip-dfi.c:215 rockchip_dfi_enable() warn:
'dfi->clk' from clk_prepare_enable() not released.

If rockchip_dfi_ddrtype_to_ctrl() fails after clk_prepare_enable(),
the clock is not disabled, leading to a resource leak.

Add clk_disable_unprepare() in the error path to properly release
the clock.

Fixes: d724f4a4581b ("PM / devfreq: rockchip-dfi: Prepare for multiple users")
Signed-off-by: Anas Iqbal <mohd.abd.6602@gmail.com>
---
 drivers/devfreq/event/rockchip-dfi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/devfreq/event/rockchip-dfi.c b/drivers/devfreq/event/rockchip-dfi.c
index 5e6e7e900bda..8db0bceeded4 100644
--- a/drivers/devfreq/event/rockchip-dfi.c
+++ b/drivers/devfreq/event/rockchip-dfi.c
@@ -185,8 +185,10 @@ static int rockchip_dfi_enable(struct rockchip_dfi *dfi)
 	}
 
 	ret = rockchip_dfi_ddrtype_to_ctrl(dfi, &ctrl);
-	if (ret)
+	if (ret) {
+		clk_disable_unprepare(dfi->clk);
 		goto out;
+	}
 
 	for (i = 0; i < dfi->max_channels; i++) {
 
-- 
2.43.0

