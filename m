Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E5A3B8409
	for <linux-pm@vger.kernel.org>; Wed, 24 Jun 2026 13:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782309548; cv=none; b=I/JeRINmx/DuT9HPy1R+wanCK7tT9nb7AOLz9+GDrpfROqfL1PMrZIcmHiKNZNkDaBQa2v6HO5JrewL8FsFnV10A8ZQ9URuzMU4WmUtBorS2C5WAZXooTMaCkEzLgjaWLeH7rNUbj/gY+DZTNDBwD4dPar7kMtIVcwoXu/kWc0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782309548; c=relaxed/simple;
	bh=FPKaOr0o36xivKMs1N7PLAma+N5tkY3Jb1rmAu8kDuU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c3Ms+SdFTONffuAJccZPWH+KoQg8e9CY5jUtqbw4uDTPXjC+CvNHsCEQEeHnsRgwE42tvE9iUyPkGm5kR5dwkFLPtFeYfm6Da4X0oTF1GA/NmIKUgdDJLq/V4+nDp6JVEtgHc0lQrKL/RMTq/pAuJAif8MwpzAH4WMl6uEA527Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XJ+/66S2; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XJ+/66S2"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-4629051c946so763881f8f.1
        for <linux-pm@vger.kernel.org>; Wed, 24 Jun 2026 06:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782309544; x=1782914344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/RYVoqlyU8kAuuCCBlRgPYzXd5w3OqO5J7/NZsGZb6w=;
        b=XJ+/66S2OC0u6nwRk7r4+LG8k8X9p/b2J0azPhWj6tMp8WzeKjF/uUna+2XXMmZ0g6
         WLopf4oGtGSg8kU1f72PgzzcN9biMnwchfeLHUYDqxPLlRBhOrBU3Sim1upKvZhdMYnA
         T6T+uFhCiaXP6VuvWi+s5844h65GSFuE2g93M5UpHc2bCCxrS54qpliSqr3QVbiCN5YZ
         u9egpc57d3HGxV2op5/UB8KB/I9VnF0DdMy8Fuzu/+sHbNa/IZsw3y5OSw7NSyL4AJ6f
         esXWvuuy6q3AvKX2faI/YkDLxy+EXqW5EBhvBXPR6b5gDk35vnBmR7a+g3XClV2ayYeY
         Ed7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782309544; x=1782914344;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/RYVoqlyU8kAuuCCBlRgPYzXd5w3OqO5J7/NZsGZb6w=;
        b=eSRQW+pJkOsqFf43TbaeQimz7YkbuATE5YXT45NgF44DUANAh32C7PKS7fXNB+bmyx
         lkIXnI5MZe30CQFBk44CpuiqHb61v/lYFuBQFmPnAHSDapSOcn8m43iyutVrhBILAeBg
         lf+CUyahcGI8x5K/tCuRatR/b7t1Z5teAfAfTgHGNoXEKmvCL6ipQncYuCim96/R+1ZT
         anhOEk2QVQ6qSc1yskrpz2ScZo7OQMFdzvQRzkXvCtq4F8JS2SW5n5C7T+rm2m0xRdG/
         SOgdQzqMe+iKubbn5Z+HA+A+Twv3F9XUUUWTs3S34Ps/sdxI0K6twXnd7IpAy9w/i9Q2
         /VTA==
X-Gm-Message-State: AOJu0Yyg8N1HB60J9DnfSprz+UUoKPxtOTxBGJW3JJ2+YY0fkgcKH3s8
	MFId2J6od+BNwN8FDfwzVKrCuJceM6I9AmNDwC1sqt8ey4xoAhEHE8Tx
X-Gm-Gg: AfdE7clL2iJDeaeiKxDdC7D0paLKdphKiw4T4Injg5PTFBXJi8aRZeC8FM/+JwcirUs
	O+IovzpMmQ0maFMGZwW4imTpBnFdw++L88xMn6C7br0Dt8VB5qXfu7X9YJuIoCwM09ASmLJtvSt
	+5n3XEEqEsf1RLADrrP1xyXUI8EGCz6DRQVrxoN8B9zU2ARby6O7q0/ybA1teN2zEUrMDZNSacn
	NFCImbE6cps2+w+VDfW3eSb4O5ypPGh+scMDV7dYW9s+0kH+M27dXl3xqb1NPg4UKodeq3PbIHC
	QCo/quTapdOGeOo5XVLxZeiS63mLXsCI5EvsY6pgATdB0nUzVChmXFN80z/CZz0Oy83IXJ1i0De
	RHMQVlQ5E/Pl8Le3/JTBNGD+z1sKb8xbPhtOhMMTbJC+eaLcgD15Nw6PDCqWJvFodl9UtrKvdiU
	BRpqbn03CsWSiV
X-Received: by 2002:a05:6000:1888:b0:460:21e7:330e with SMTP id ffacd0b85a97d-46a7efb72e0mr14353626f8f.10.1782309543440;
        Wed, 24 Jun 2026 06:59:03 -0700 (PDT)
Received: from beast.lan ([2a00:c281:1461:c400:bf16:e4f3:7fa:c2dc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46c221d93eesm6734311f8f.20.2026.06.24.06.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 06:59:03 -0700 (PDT)
From: Boris Shtrasman <borissh1983@gmail.com>
To: Sebastian Reichel <sre@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-api@vger.kernel.org,
	Boris Shtrasman <borissh1983@gmail.com>
Subject: [PATCH v2 1/2] power: supply: Add PbAc, NiZn, RAM, and ZnAr support
Date: Wed, 24 Jun 2026 16:57:17 +0300
Message-ID: <20260624135718.286771-2-borissh1983@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260624135718.286771-1-borissh1983@gmail.com>
References: <20260624135718.286771-1-borissh1983@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add four new members to the POWER_SUPPLY_TECHNOLOGY
enum and sysfs interface to represent the Smart Battery
Data Specification v1.1 (Section 5.1.30 DeviceChemistry) battery types:

 - Lead Acid (PbAc)
 - Nickel Zinc (NiZn)
 - Rechargeable Alkaline-Manganese (RAM)
 - Zinc Air (ZnAr)

Update documentation to express these types.
Update ABI testing for these types.

Link: https://sbs-forum.org/specs/sbdat110.pdf
Signed-off-by: Boris Shtrasman <borissh1983@gmail.com>
---
 Documentation/ABI/testing/sysfs-class-power                   | 2 +-
 drivers/power/supply/power_supply_sysfs.c                     | 4 ++++
 include/linux/power_supply.h                                  | 4 ++++
 .../selftests/power_supply/test_power_supply_properties.sh    | 3 ++-
 4 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
index 32697b926cc8..5641f1fd5fd6 100644
--- a/Documentation/ABI/testing/sysfs-class-power
+++ b/Documentation/ABI/testing/sysfs-class-power
@@ -525,7 +525,7 @@ Description:
 
 		Valid values:
 			      "Unknown", "NiMH", "Li-ion", "Li-poly", "LiFe",
-			      "NiCd", "LiMn"
+			      "NiCd", "LiMn", "PbAc", "NiZn", "RAM", "ZnAr"
 
 
 What:		/sys/class/power_supply/<supply_name>/voltage_avg,
diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index f30a7b9ccd5e..9d6b24856c8b 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -124,6 +124,10 @@ static const char * const POWER_SUPPLY_TECHNOLOGY_TEXT[] = {
 	[POWER_SUPPLY_TECHNOLOGY_LiFe]		= "LiFe",
 	[POWER_SUPPLY_TECHNOLOGY_NiCd]		= "NiCd",
 	[POWER_SUPPLY_TECHNOLOGY_LiMn]		= "LiMn",
+	[POWER_SUPPLY_TECHNOLOGY_PbAc]		= "PbAc",
+	[POWER_SUPPLY_TECHNOLOGY_NiZn]		= "NiZn",
+	[POWER_SUPPLY_TECHNOLOGY_RAM]		= "RAM",
+	[POWER_SUPPLY_TECHNOLOGY_ZnAr]		= "ZnAr",
 };
 
 static const char * const POWER_SUPPLY_CAPACITY_LEVEL_TEXT[] = {
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 7a5e4c3242a0..034800cd21da 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -83,6 +83,10 @@ enum {
 	POWER_SUPPLY_TECHNOLOGY_LiFe,
 	POWER_SUPPLY_TECHNOLOGY_NiCd,
 	POWER_SUPPLY_TECHNOLOGY_LiMn,
+	POWER_SUPPLY_TECHNOLOGY_PbAc,
+	POWER_SUPPLY_TECHNOLOGY_NiZn,
+	POWER_SUPPLY_TECHNOLOGY_RAM,
+	POWER_SUPPLY_TECHNOLOGY_ZnAr,
 };
 
 enum {
diff --git a/tools/testing/selftests/power_supply/test_power_supply_properties.sh b/tools/testing/selftests/power_supply/test_power_supply_properties.sh
index a66b1313ed88..1ebac6fe5d23 100755
--- a/tools/testing/selftests/power_supply/test_power_supply_properties.sh
+++ b/tools/testing/selftests/power_supply/test_power_supply_properties.sh
@@ -74,7 +74,8 @@ for DEVNAME in $supplies; do
 	test_sysfs_prop_optional model_name
 	test_sysfs_prop_optional manufacturer
 	test_sysfs_prop_optional serial_number
-	test_sysfs_prop_optional_list technology "Unknown","NiMH","Li-ion","Li-poly","LiFe","NiCd","LiMn"
+	test_sysfs_prop_optional_list technology "Unknown","NiMH","Li-ion","Li-poly","LiFe","NiCd"\
+		,"LiMn","PbAc","NiZn","RAM","ZnAr"
 
 	test_sysfs_prop_optional cycle_count
 
-- 
2.47.3

