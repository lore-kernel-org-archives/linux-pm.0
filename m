Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1392836AF
	for <linux-pm@vger.kernel.org>; Sat, 28 Mar 2026 19:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774725509; cv=none; b=DwQUOWTGa/ZXFYV07XriNiIFAuy+HTu5nU4xXOGpDxlV1OiyjkWZotdCjp1aUUJH2BsaEdj8dij6p08NRx/9dFguO8PLpu4JF29PUYsiFzzzFL7B4EJdYVw+gUnNwuHpY8x3xsic9wXi6Q1O04SKamq7uS/i5VwaPfn2p+PRU6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774725509; c=relaxed/simple;
	bh=JZcLUYCLYEhZcBKzzSCYlJLv9uoFBvbrytjcn306C04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S4e3KosLidjLSIufx6/VZNg60bsiJ3fCLHwRjhXcsS8/ZcOqdWHtKS5UaB6/GYATos71bIpPrOqZKvVk3PDG8cqHO8muykl/ONrT+FFnz4j9LwvpWcWQZdORnTjg6Jagqy+lSwtR+mxa27uc0YCyBA1PFzgMg4Jn8CcwfWxAMBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C8mvyrBR; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C8mvyrBR"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-35d9749c26dso424987a91.2
        for <linux-pm@vger.kernel.org>; Sat, 28 Mar 2026 12:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774725507; x=1775330307; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WA9Y0VWD6q8BWRqcW8ZuOdPM6JPIhso+ucpZhyQ2OAA=;
        b=C8mvyrBRrU49GTfLJAXWWCZRdy+aeykgcJ9h7TWos7zP8jX/gScPNAD8cb2iyens6t
         PY1o1VJL47l/nnXEx25hfMaZtO/MBhsPBzjEwiMR1Ye619d5iFQaNkV/YvOnYxrAk00n
         3eE1rcYYmxah46170Ym+0bqQA1TnSDR6sJwFPZuQgrL182arqSgtjGjj/AbAYN3kcgNE
         OLTWYJVCuh1kXKIZTm90VVuKPBYfNccwcL7MUSyDQFoNMGy4OB7DpUlyGVIkA/TezL2m
         mDyNTkhXvxyjdzvvsWfAEZq/w7xiYXRw3kdYc5L6Q/uKZCibRilI4i/fuqYWFL3MZpeN
         BSyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774725507; x=1775330307;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WA9Y0VWD6q8BWRqcW8ZuOdPM6JPIhso+ucpZhyQ2OAA=;
        b=dTUIeb27nnnt2QtQVkMTsyjqF+E5gd2K+gQmsz9NtlAtKreMgGoSOgK5ssPYvSbSxn
         HxCdA2z4GC8Iye9oK+zKzqQOkzwtXBMHzT373ZjZ03UVDJIypQkPQ1DQI+ztR5gtEEJm
         f3JF57flF1Q3WXdyUJSkMs81/OBCbqid7yro8iTLc30bTkeUitIBvJSsEfx1DgsRQj0P
         pucKEOh4sOuJc/8EjNoNetCTR9ckNIPATW55oo3fzDVs59LQSrmeMudSo0uVMyiI2zs4
         qXPFcwuui8ecpCURISa2vZBJ+U6Fc2l/6fJB7cu3jU00KSJLAqIWiX+SfPJ3uSVVWTst
         g9KQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYEnge0B0jgPP/ou6eGy0xRB5+BF4tBJ2Nm3VjNf3RHapylW76IplsbAL0ONwrGqYFKAmWrgIHjA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwwqhF3GlAEr1VG18tz72LatPkPbe7p+Zf4rxORtQjE9Gb9hhIx
	Y14AYunbZZega6ah6TsxZEh5Zl7bbyBS+9IX2R9uloSkk/pwJTl7vglK
X-Gm-Gg: ATEYQzxMfuCidjLNUBk/ZkgbyMmuAwnLSUMkAeUNsqAy/0A1ZcGOd98D61a9zJy6+uO
	STaSZRo+v7LDLpnTQbvX+1dJELLs70ojxQd4vJP2KPDaHqT7jaiEUlhxQE3mKyaSPJqQBCrVOTj
	7EgBuGPPIUUvdCOPytJW2xwrkcvsjHJGDsJDqHumVw9Jd+G0NwT7Mijxk8TtdxwM3K2Br1uA2JM
	2KifZnPaeozc4ejrMz2jeGw5Hdaw7R2/RHOIdTPXm3Ew44ZETA09DknqSv1Icgv9afCVTmbI92/
	W9xWWJMG0OBNFPFMEK/SJvCKsgzPrwCz8/7qECuZLq+k1cZ662xw4MLY1Ez98OsMOL4cVEXwSpm
	qz6QQvLmx0r+eCs50NRc+cRDZEAyv23CNPziDbLtKhDIqnnwKKSWhBhWx3FrHRxz+qAp8pz+ez/
	vpHf81iL22QITcGgzKGM56DNsOH3F00TLr2EGfpKPN/Q75PXZ5i/Iyag==
X-Received: by 2002:a17:90a:dfce:b0:35d:9f60:827 with SMTP id 98e67ed59e1d1-35d9f6009acmr431713a91.29.1774725506725;
        Sat, 28 Mar 2026 12:18:26 -0700 (PDT)
Received: from debian.killsync.com ([103.38.13.110])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35d9507d739sm2684165a91.11.2026.03.28.12.18.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 12:18:26 -0700 (PDT)
From: aravindanilraj0702@gmail.com
To: rafael@kernel.org,
	linux-pm@vger.kernel.org
Cc: daniel.lezcano@kernel.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com,
	srinivas.pandruvada@linux.intel.com,
	linux-kernel@vger.kernel.org,
	Aravind Anilraj <aravindanilraj0702@gmail.com>
Subject: [PATCH 2/2] thermal: intel: int340x: Check return value of ptc_create_groups()
Date: Sat, 28 Mar 2026 15:18:06 -0400
Message-ID: <20260328191806.8675-3-aravindanilraj0702@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260328191806.8675-1-aravindanilraj0702@gmail.com>
References: <20260328191806.8675-1-aravindanilraj0702@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Aravind Anilraj <aravindanilraj0702@gmail.com>

proc_thermal_ptc_add() ignores the return value of ptc_create_groups(),
causing the driver to silenty continue even if sysfs group creation
fails. The thermal control interface would be unavailable with no
indication of failure.

Check the return value and on failure clean up any sysfs groups that
were successfully created before the error, then propagate the error to
the caller which already handles it correctly via goto err_rem_rapl.

Signed-off-by: Aravind Anilraj <aravindanilraj0702@gmail.com>
---
 .../intel/int340x_thermal/platform_temperature_control.c    | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/intel/int340x_thermal/platform_temperature_control.c b/drivers/thermal/intel/int340x_thermal/platform_temperature_control.c
index 18ac5014d8dc..caed572c6061 100644
--- a/drivers/thermal/intel/int340x_thermal/platform_temperature_control.c
+++ b/drivers/thermal/intel/int340x_thermal/platform_temperature_control.c
@@ -278,12 +278,14 @@ static void ptc_delete_debugfs(void)
 int proc_thermal_ptc_add(struct pci_dev *pdev, struct proc_thermal_device *proc_priv)
 {
 	if (proc_priv->mmio_feature_mask & PROC_THERMAL_FEATURE_PTC) {
-		int i;
+		int i, ret;
 
 		for (i = 0; i < PTC_MAX_INSTANCES; i++) {
 			ptc_instance[i].offset = ptc_offsets[i];
 			ptc_instance[i].pdev = pdev;
-			ptc_create_groups(pdev, i, &ptc_instance[i]);
+			ret = ptc_create_groups(pdev, i, &ptc_instance[i]);
+			if (ret)
+				return ret;
 		}
 
 		ptc_create_debugfs();
-- 
2.47.3

