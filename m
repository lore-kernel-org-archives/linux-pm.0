Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64783C584B
	for <linux-pm@vger.kernel.org>; Tue, 23 Jun 2026 07:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782200976; cv=none; b=S6KML/JBHlov7pi1JxEtOM9tAR46t1GTwdP2L3tByYQs/Nz/HzUSxDruwLZkh7OGVf2uschcISfrR829BZbx1G4e80T13uaJWBrUPU7XSre+i5gq1wjOxrRj/NW+k6sLRTuDn6jxJsyOsrdORVv1l0QZ0Gk7jzREy7i7916mR5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782200976; c=relaxed/simple;
	bh=X0z8lUjRFMAm31SvVn3XAHG6MCbc1NvvPfUwObFN9nU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=MuCVyPg+2TCbLtY0ALwug4h62/4eGfKmalgpgqxjHXDNetwlllJIW2D3mTcKimIZWfI/ENSRkgktYpL5rLlzOGX0QuZVW9J4NdDDe5bSJyPMBkP8t8Pkqadz4hH73N1xpARXxn8VXW79JdYo1orH3/ri7s3vc5Au5n4Ia49DKLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CyCKRtR5; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CyCKRtR5"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c0c964d6470so374574966b.3
        for <linux-pm@vger.kernel.org>; Tue, 23 Jun 2026 00:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782200973; x=1782805773; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UrCfxhTAecILkVCugcEHsa3TmnRhxKjXZll8FagDxjc=;
        b=CyCKRtR5WPjpGWv9Te0IUKhl9RPy6F3svSTAmM2bai6Z1zL3wFltvsmGot3IkU3WZ1
         T4AI7gzEGG1Fbd0MD7R3ilAI9UN74CNB5CLmJlSo4X8I1H8llLC9u5bWKHuwDxWBoDK9
         e6xgsKJ+cBckk9E+SUEm+KyGQGQe2nm5AX2Wzp1GIXemiKNgAi7R27NNuR8IHDq5SBCa
         YoB7/jn7sJQxxZ35lYo7/tJbYdbai0W9eYo5cw+PBIYI+YCpcVrtVFsbc5yjB45udOnQ
         feeXa8Ti8TD0fJxeHlQSrUC1AsXssJdBgRCK8yXgT3ESBZZ0gFOCV6moSCBMP0pj7uBw
         A2KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782200973; x=1782805773;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UrCfxhTAecILkVCugcEHsa3TmnRhxKjXZll8FagDxjc=;
        b=B9pseFZEdmhaNsuMqtHrsUiOoxHP6Wp+LvvxxjNvcg9vdOADu2nkgEtbxKzYVChpgi
         5FhOpUYIp0rKnEO8LtVKvCE9vStJAAVdmgTOyQt9Vhml+5/umoYb1UH4i0xTPjV/Ow0Y
         lXTdL/NSO7bfUbPnDuQYlVkyBYg+bVd+fDPRuArUVJhosh6S5CJIS3b45ByxG7ER71W/
         MVsiPZUpxi4sfpf1MLBW1q0+GQDp2K5eBlC8xBzfwcAnB7NJ5UlDqlfcGdf0sphanPnc
         OA5aW8bnoZ1z/lwq9jb2VTxDo2agReK0HhCz8XllvND6w5URqKLX6KzHttT/fBbohVkI
         yw5w==
X-Forwarded-Encrypted: i=1; AFNElJ+7rZthJKFSlo2sJfF9KP3mptSaGk+TmIdrtA6W3w2Sjxn7zQ7GvOxsBHIz8sbKFiEGdnJuttXqPw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxXsSxsR9Sel6br3nb++TR2ChwQx2zrt0V2uD0kPExQHTgPaQao
	QvCjKpKOPCk3N/1dg1QFYRxPIOBLYmsX9GOuNkuMbck+eoiTxFGuQrLCtmGG8A==
X-Gm-Gg: AfdE7cn03fG6HbO/RzEXKgI5laSH/Co654Unaups78KIPrJx7u4zZWiA6Rk6bFPS4PW
	TfezP1Otqwnzsldwk1gdPK//weVKEPvNjSuGPu2bvZJxQnaQcCGv6qHlstTz9zzhuRHYbsNWzVu
	A9aDoB2cZ+Wo4U5pQPvZnMYn8TaFWoahtpJMSgD5JDwX0fXL896L0bkcfGx/eHUMS3SJJ331YN3
	CDQTenDr63A/5vaKyihzQ5+API9h9N+tUoz25pQZeqPweP2GSJ0CacD6HFAEWwtTkblxRVe+55T
	oYhbVcu/LfjvIwLFaDrqtr6Y/bremojGqvEqKNTSDQKBwWVEoZ94sWrJuCUGLSqaUDlyQxCV0Dr
	aLn8/wrLCZLw2j9MykNv8Xj2coch7n8V0CxbK3TpswIBNedGUTeZApsovmvTsX2MoAmTugyObQb
	jJULHaUCwN
X-Received: by 2002:a17:907:724f:b0:c0c:3b13:5249 with SMTP id a640c23a62f3a-c10908bc4aemr64165166b.52.1782200972913;
        Tue, 23 Jun 2026 00:49:32 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c0c5e498cf8sm457914066b.13.2026.06.23.00.49.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 00:49:32 -0700 (PDT)
Date: Tue, 23 Jun 2026 10:49:29 +0300
From: Dan Carpenter <error27@gmail.com>
To: Niklas =?iso-8859-1?Q?S=F6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Cc: Niklas =?iso-8859-1?Q?S=F6derlund?= <niklas.soderlund@ragnatech.se>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] thermal/drivers/rcar: add error checking in probe()
Message-ID: <ajo6iQ3VWvcxedA9@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The thermal_zone_device_register_with_trips() can fail for a number of
reasons, including allocation failures.  Check for error pointers to
avoid an error pointer dereference.

Fixes: 9d617949d490 ("thermal/drivers/renesas: Group all renesas thermal drivers together")
Signed-off-by: Dan Carpenter <error27@gmail.com>
---
 drivers/thermal/renesas/rcar_thermal.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/thermal/renesas/rcar_thermal.c b/drivers/thermal/renesas/rcar_thermal.c
index 6e5dcac5d47a..71f836fbc698 100644
--- a/drivers/thermal/renesas/rcar_thermal.c
+++ b/drivers/thermal/renesas/rcar_thermal.c
@@ -492,6 +492,11 @@ static int rcar_thermal_probe(struct platform_device *pdev)
 				"rcar_thermal", trips, ARRAY_SIZE(trips), priv,
 						&rcar_thermal_zone_ops, NULL, 0,
 						idle);
+			if (IS_ERR(priv->zone)) {
+				ret = PTR_ERR(priv->zone);
+				priv->zone = NULL;
+				goto error_unregister;
+			}
 
 			ret = thermal_zone_device_enable(priv->zone);
 			if (ret) {
-- 
2.53.0

