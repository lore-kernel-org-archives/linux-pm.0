Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2391043B6F5
	for <linux-pm@vger.kernel.org>; Thu,  3 Sep 2026 10:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788432175; cv=none; b=PzF4mjLik33MfLCvkUBuK3XCmR1ni5roilsPk4mWn6zcTBtiqFXvXIRPvwx01PjPZ99RlAXsF+kRc2C/6cO42MZnXtLg1DjPC4V5eBopDsmSL4Bw2yAV4QJMPu9aoz2YhumTSS7KNEPYjhqAGI2Mp6AqLtHRZeXK9aWjap+y+KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788432175; c=relaxed/simple;
	bh=+GX8WEIiqxcsxRx8lJOjMEWa5txU6zxSwwWpPI3e4mA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QIZeMgm/r/KuAK4g4Mrax1SNGqN8kncpt04ULuTEeaoRYMhLSqGtIEvIhMSuYYFBKwWSVYsg+zz7L4QiL73EmhBLKJnQ0CtrXXd9QkR7+zVQasp9xRTtTroOP0LxNMapBX13zA34R8YshbrSkikL/ovqmGjTVblxQQhoNqZ+o+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DbrG4Dvr; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DbrG4Dvr"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-49cca4ffdcfso16224275e9.0
        for <linux-pm@vger.kernel.org>; Thu, 03 Sep 2026 03:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788432171; x=1789036971; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=aaqNY17cMmjcPMSLqDr2N+tN8Vmcq3Ywr2AifLrAlrE=;
        b=DbrG4DvrJEOiaTFF3e5+/ksSjj01VWHj5uWjijZFe0564CUW9240Y4jFfUerAJsknJ
         T3AEfegt+LnWvUTkbvCFFGZChn1/MC6X+ZJ6ik1HLv3OkmVKiQVKn9sqquNxfPvDBmlm
         cSvs7EwJKENtUslckdygm4NOOd5S67vqjZVzQKlju0hq6mpmzPeHAyqglM58Xl6gMNYT
         u3R5qBkHWnKhPgVx/hpXq2/04LfuDrPH0Id+Q8UuMNnzntMZUU0Qf6DNN+MQMcYmf040
         oZE6gaBH1EpYPoFJIoCftEbeh7zzOMkHRysN9JumJeT/R2GX4wXrcp7cSdwNxYD/WHTV
         8MvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788432171; x=1789036971;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aaqNY17cMmjcPMSLqDr2N+tN8Vmcq3Ywr2AifLrAlrE=;
        b=jMkxBI+RdnSyqIs1URQoXvY5CmM5qkye37PEctIivrKc9ecrfcIJ0fvUgEluMsYuYU
         EHwIMjcrfd6eC+OL9xZBbw4ah2TiyeG2Y5e36QZ3G47laRT9jRj8IcngY415Dt9NtZb8
         eQziLuH5WAsPWObFTHjJ5gPTkGHnXyt8QY9YO6qvaRW4WVqghpz9OuULDmsz3Q7X2SSL
         QHhVYim4KH9kf6SNWFLDVGkp7J0RyMdFQlIorgvOedZ24l05/XQe4MZON4p6AdMYrCkW
         rvmUJqWbYvuJBP1KauZckx2D4FzWEcjktXAUfmKfP1/yn7Vq151YVaNwlIlrLBBq/49v
         toEA==
X-Forwarded-Encrypted: i=1; AKwUvByIX5jk8tdfvUyj9ULdkRzpL9iNxyKYPOdU+5AWQ55hAlJESWmn2L9OTvywM4G5kp/FDFtzmF8CmQ==@vger.kernel.org
X-Gm-Message-State: AFuF++m+FJ/r5MARzoCG9h6L13P6QajwmzQ0svkmXK75nYZwIuvoZhML
	e6d2XFDMmM9np8NapWLdyqEvCWDaQkpRywhbuTRmfDdzrdbqXQz+CFW1
X-Gm-Gg: AYBFou3ypz5BHrJLcrgcfI+Z7yICA03uItVUQB7iGrg34ku6AhzFPlBVV2ZCFI7p7Hm
	WYSiFaJqq2b139cEO5w+JoN0j2aXXWTtvh0L+5+nwAiNSFI/yNihQxFElQQ2iX0AfHdHzv6Pzy1
	PT066DalI51w7eYMlJztqEqAEYfLxJh3HUYEw9QzAOaiZ64AiOeAB38d09M2jmHJQTkXMi99Znm
	RyMO0+VX9JZbMOE3EWzc8eZllwjvlwoxtfBqEiBniqMJDm8KhP+PNpr++BfDcgv+SQ0Gg/ojilo
	EXOAlGXgyEGM3rb5FfH3FtPyooSWsJD6medmlIWdeLvaCbhIhweHPe5nskHBkU+TmqHEi/sfKid
	/My8EGc3ePPqHAbokxl1eXvEFWnPSqopx2+96T5s7suaoRq2LCsBeJkCWlUNqOFvMmNJglo82Ux
	dJzOMm6DenEjkRREsmK1yPyQTZjbnd8nffY4zqEoKUnKqv51Cl8viHllX8f7Nh8EFgtquoZEVRZ
	v5AgpexJz2I8kIgrHHuNtDdcixBlbzu
X-Received: by 2002:a05:600c:3f08:b0:49c:e1ed:26b1 with SMTP id 5b1f17b1804b1-49ce5850cefmr215418115e9.16.1788432170902;
        Thu, 03 Sep 2026 03:42:50 -0700 (PDT)
Received: from ubuntu-mbp.fritz.box (bzq-85-130-235-2.static.bezeqint.net. [85.130.235.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cf5135353sm5090695e9.2.2026.09.03.03.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 03:42:50 -0700 (PDT)
From: Itay Shem-tov <itayst@gmail.com>
To: rafael@kernel.org
Cc: lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	sre@kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Itay Shem-tov <itayst@gmail.com>
Subject: [PATCH] ACPI: SBS: report relative state of charge as CAPACITY
Date: Thu,  3 Sep 2026 13:42:44 +0300
Message-ID: <20260903104244.25556-1-itayst@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

acpi_sbs reads SBS command 0x0e (AbsoluteStateOfCharge) into
battery->state_of_charge, which is exported unmodified as
POWER_SUPPLY_PROP_CAPACITY.

Per the Smart Battery Data Specification 1.1, 0x0e is expressed as a
percentage of DesignCapacity and is explicitly permitted to exceed 100%.
Documentation/ABI/testing/sysfs-class-power specifies the capacity
attribute as "Valid values: 0 - 100 (percent)", so any pack whose
FullChargeCapacity exceeds its DesignCapacity - the normal state of a
new or recently replaced battery - makes the driver report out of range.

The correct source is 0x0d (RelativeStateOfCharge), a percentage of
FullChargeCapacity, which the specification bounds to 0..100.

This is the same defect that was fixed in the i2c SBS driver by commit
b1f092f6480e ("sbs-battery.c: Capacity attr = remaining relative
capacity"), whose reasoning applies verbatim here; drivers/acpi/sbs.c was
not updated at the time. drivers/power/supply/sbs-battery.c has used 0x0d
since, so the two SBS drivers currently disagree about what CAPACITY
means.

Observed on a MacBookPro11,1 with an SMP/bq20z451 pack
(FullChargeCapacity 6775 mAh, DesignCapacity 6400 mAh). Both registers
read back-to-back from the pack at a full charge:

  0x0d RelativeStateOfCharge = 100 %
  0x0e AbsoluteStateOfCharge = 106 %

/sys/class/power_supply/BAT0/capacity reported 106 while upower, which
computes charge_now/charge_full itself rather than trusting the driver,
reported 100.

battery->state_of_charge has no other consumer, so no other property
changes behaviour.

Signed-off-by: Itay Shem-tov <itayst@gmail.com>
---
 drivers/acpi/sbs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/sbs.c b/drivers/acpi/sbs.c
index 86b7c79..862cb94 100644
--- a/drivers/acpi/sbs.c
+++ b/drivers/acpi/sbs.c
@@ -318,7 +318,7 @@ static struct acpi_battery_reader state_readers[] = {
 	{0x0a, SMBUS_READ_WORD, offsetof(struct acpi_battery, rate_now)},
 	{0x0b, SMBUS_READ_WORD, offsetof(struct acpi_battery, rate_avg)},
 	{0x0f, SMBUS_READ_WORD, offsetof(struct acpi_battery, capacity_now)},
-	{0x0e, SMBUS_READ_WORD, offsetof(struct acpi_battery, state_of_charge)},
+	{0x0d, SMBUS_READ_WORD, offsetof(struct acpi_battery, state_of_charge)},
 	{0x16, SMBUS_READ_WORD, offsetof(struct acpi_battery, state)},
 };

--
2.51.0
