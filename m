Received: from mail-pj2-f6.google.com (mail-pj2-f6.google.com [74.125.227.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10222EBDE9
	for <linux-pm@vger.kernel.org>; Tue,  1 Sep 2026 05:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788241027; cv=none; b=bOIhPfRQMO9EZK3g+L4AGJYVhxpJ84AAQ/BInJZwgpknvztGorwyfj533UskDlKE+MkdTwuYPHx82tQV60eqoatPoHWcytvbCGrwu3n8JvYLEJNCW4Mno73KnsqUl15IZKSEtu9mGGaEMP9zSAPR8txUH4FswkgPTHmdMrjCl/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788241027; c=relaxed/simple;
	bh=k59oaERz04BqM7S0rthAXQ/2ts1J9ySRWi3F8Prk1SQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u+5XAHHkotQ3FY1dIntxPs4lkSYWOp0qlDFHUyLzf3TERKChKhAhNRR3iwIl79Wf8WggQUL/rvHscC8dEIskX/rfYon7nI9fc9Qm/CRzVt47uiX8KUID4UP1ih53nfCoUBBt/8Gbo+dIdpCSmQN+DE23FvhZCfKCT0LpvQrXEMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.227.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj2-f6.google.com with SMTP id 98e67ed59e1d1-3964e7720afso2585045a91.1
        for <linux-pm@vger.kernel.org>; Mon, 31 Aug 2026 22:37:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788241024; x=1788845824;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=J1L7D2BGcJa8YCR09jb/VFXv3QPDgwb09GcaN70Yl+M=;
        b=gU+04+rzCvte4y8yvpRMgmVww5j/zpUPAkAV/B+ylMlixpTv2ttxTpAu7tgx4Y4cJb
         IOXePsNuarYCCy4EUC89i6fXzj8PzUXcaYkOgXwWYFwtXG0P+GQvwXOa4w+qftH1EOxQ
         9ffPE456ir159n8cCrbC83wb+3LmZQiRjgk/XSTS/9y8QJVL64G+W60LN/skW2JjnjRD
         3+vmgg2A7WOyqX2YP/SwaqIMFZchGHtNwoAIx5poEP1wkdaOAYaA81GA/j4lIaUf32t2
         uOFTECe3z3XZh6LN86QI0reQWe491q3tmfkmmLig0GzD2iRws3SmRljaa/S6ZA+56xcK
         vSNw==
X-Gm-Message-State: AFuF++kkrBEaH4AshDQQWLJQFEDCFaafUDXRmH6XetToHaDDfpFInPq/
	PirgLoxHHDEHK/dnXfOWXous+ea4rB6+XLupJc5S+OsIitTFaEwJ6Qto
X-Gm-Gg: AYBFou0/Fakbn+gtsldY6ZMr1IE7GzKB0L84i9soTrxtQOXKihXOLn/mcHEW+ElYg2g
	NsqvArKra3fKAIng0VvMwD9t4fLbndw/FZyXy+w8MpUtdpxvBOr+Qv5He1uA9ZK25iE8Uy6oSN+
	TA32okA0yGws7VCXXoR7RXXOi0NGvj/FzIU2n/LGY6dtkXm1PbooLh3e8tD11Cq3yGFsplgWh8J
	oVcf2iT201wM0qr7JtnilmtjGAccx2R0UlDI85lg6mMh6Gb8MBu01bF+y4PSSBULAbdvO0Kk7ER
	znCJpWA/BErEo0RrmO3Ftq+xoYI5h1AU+XjFhtqmIx2DjL9uSUkGEv89xBsB163WUSFIOVVoA2u
	Kh+XAiSqII+7Uuwdbv+F6Wu/Ae5Nh4WkDSiR3jD6UsNe7oP+cJpHzjlLGPiDUhWM/iNJyBUy89+
	cK97CGYwaGwIsXYALgYQsMuYXUxJtKxNXC9RmkhTEGm7ZFeK6l/Cr6Ob7EgJXaxzyj8mhqq75cd
	5a+rGQYAg==
X-Received: by 2002:a17:90b:3c44:b0:398:dcef:c040 with SMTP id 98e67ed59e1d1-398dcefc24amr19417604a91.19.1788241023780;
        Mon, 31 Aug 2026 22:37:03 -0700 (PDT)
Received: from kylin-XiaoXinPro-16-AHP9.. ([116.128.244.169])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3990bd1dcfbsm3643324a91.2.2026.08.31.22.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 22:37:03 -0700 (PDT)
From: Xueqin Luo <luoxueqin@kylinos.cn>
To: hansg@kernel.org,
	krzk@kernel.org,
	m.szyprowski@samsung.com,
	sebastian.krzyszkowiak@puri.sm,
	kernel@puri.sm,
	sre@kernel.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xueqin Luo <luoxueqin@kylinos.cn>
Subject: [PATCH] power: supply: max17042_battery: Fix vmin assigned instead of vmax in DT parsing
Date: Tue,  1 Sep 2026 13:36:52 +0800
Message-ID: <20260901053653.1668492-1-luoxueqin@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The else branch of the "maxim,over-volt" property check assigns the
parsed value to chip->vmin instead of chip->vmax, so chip->vmin is
overwritten and chip->vmax never gets the DT value.

Fixes: 6a3b47a5a5fc ("power: supply: Match DT value types")
Signed-off-by: Xueqin Luo <luoxueqin@kylinos.cn>
---
 drivers/power/supply/max17042_battery.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply/max17042_battery.c
index cbf3ac9c3e14..505a68c26463 100644
--- a/drivers/power/supply/max17042_battery.c
+++ b/drivers/power/supply/max17042_battery.c
@@ -1233,7 +1233,7 @@ static int max17042_parse_dt(struct max17042_chip *chip)
 	if (of_property_read_u32(np, "maxim,over-volt", &prop))
 		chip->vmax = INT_MAX;
 	else
-		chip->vmin = prop;
+		chip->vmax = prop;
 
 	return 0;
 }
-- 
2.43.0

