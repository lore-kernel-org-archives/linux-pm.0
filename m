Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A5C3B95E7
	for <linux-pm@vger.kernel.org>; Thu,  7 May 2026 13:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778161581; cv=none; b=pdCvp0QcYs3bJyAacnG1iA/wqGw5xFw9NeqACyb4uP4v9UyX8deX788Ydg0zwpVJezPW/mpbnAH76/ae6z1zFKyZpCln3VMb83n/Wv7mGbUagCh7+lGfuhlOFRMD06KqnhoPaMVAvg6XtWaqNGTz0ye3SJwLS3c+vGiXKtgpc9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778161581; c=relaxed/simple;
	bh=MNVSebD0+mDfW5apdNkpjHmTZ7QyrFLsTRHwJtzgd/E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PQgDd+BgPjL2YE5/2kbHPZEc13LgAQBhRCzjOQ9KBvKGXiEKwR2d0R9NDQm4iy+pie9pzU7as80Uxd+jGKrd6Ymlwl915eh66xskzT7F2Ft2fjrVJ3apnd5jw2Td4PgBDN2PqGgFnX3oBpNROiUkMBhElqVui58p9ELenx1ay+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aMcD/C4i; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aMcD/C4i"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-bc264a50e7fso167835766b.0
        for <linux-pm@vger.kernel.org>; Thu, 07 May 2026 06:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778161578; x=1778766378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RmK4VbMOENlzFgqB5AiS31ODfP6gNlZbQzPOHR6VrIc=;
        b=aMcD/C4iDIBN9W/i86eH4lcw1dCPt7iumK5kkvtFwikcD52MNV/crINTo0U600lKam
         3ulbjmmPsV2Io5hQXaRvPFbGFmNJTJSl2ZPrdflIrlAtiCRm97ZTkoTOOrVuc9R9N4IJ
         0HMx9r6MNTjp6ef9Gok03JFDBGTDl5AUE8SCuxLe/buJZ+WwK09yLh8NqvGUOLS0yYtc
         kGiSqlBNMXZsj5Uv18N1kAoXymO806gSXJYnGVte+zWyZUNcxkClSwwBc/ynAqUH/9he
         +JUIEHexg3CIH8cj1jV6fPoZw1ZzEKCJhyk1vx62+ztXQV0mAPsybt8Xz5eKgfCJa1q7
         2ErA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778161578; x=1778766378;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RmK4VbMOENlzFgqB5AiS31ODfP6gNlZbQzPOHR6VrIc=;
        b=TFtY6Uv5ymhovMG7DseTlIz8/scWcY/6bOp2Pj0msh9Wqv2Du1fI5pOQQ8eOfQEu5i
         EXwRYKhbUNXtX1wpWallGSVLRPfPTKM6KXWz5GN2Wr57yKFKgyChtVbISe7+cdSofdpk
         9rxKMsHCGHr8m+0uu9iWy2NiJaefy0dKKyI5buKD57VDH3IshUNzptm+TQjhzl+xXxjO
         1/aqbtbxqUw0h+sO5FekqI1Sp/LvuOmqMxDP8Tdmgc3RFYS4uQkOAwRV7Qo8UY5ceYtu
         w2rfvtBdPjaoussbHW/qm+KnoLbWZ8g9X+j1pVmVOwWZ0d4ZN2/g3bQ3dEvbh/7ZAX9s
         tvgQ==
X-Forwarded-Encrypted: i=1; AFNElJ/d4Ctoqa7lLqN42Iqh0YRFwia3WdFNwdK8LZRjZv3m2cVHHd66blAzUbhOep2KUpqwSbGx7gB4Mg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw2jgwhhfhcCN42VotBIyHgBqh4NEHsnlDG2fk2SSpAlwPCSJx
	PV3AgCjptITxRi6eW3pbs6zKtmzDuyYLdeauFqOJpJHHVmw5UX24YYMl
X-Gm-Gg: AeBDievyVPCk+cf9PBh3ujAQNGi6zVdVKjfOZ3Utgv08nLFcvKtdKZCvBsF8rbnRO0F
	5uo3rWEeQ67aAdXmu5d/NDJKuJPlL9CC0c4GxZmON3KCGXtiJRAH41EZ29oM9mpsf+oyqmLIvZh
	4KQNXfwFIdCyBIlBIq2Lf7/QJHlXnGhiMi/FP39mcGZg+aPj5iJs0FxgHfO+plK2Ok+l8qPnHPO
	3tNILffyZrAcxY/Iug6BVzQsXoRQnMyGmm+4wjXamEAP70e86aD6UPWKIX1S3V1pwUlqa+ZFsu6
	3c1OrW4KilA7KhpZJA+9GLR7BPv+KoDx7qt8LIu+ZfxwnuUDK1cDaWCeL2JXzS71lGBZEYlUihx
	BsTiIS//xBQw4e52IjSvfMxdviwJHk9JFbzHbCgFI+hr/JzScTVKAvHVpF3Nnm3GjxL9PCWrkqw
	WTN0fiM7e0Rd7efjQz21oAULA=
X-Received: by 2002:a17:907:e152:b0:bc9:e1b1:8edf with SMTP id a640c23a62f3a-bc9e1b192e3mr69894666b.12.1778161577410;
        Thu, 07 May 2026 06:46:17 -0700 (PDT)
Received: from xeon ([188.163.112.56])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-450524833e1sm20701615f8f.2.2026.05.07.06.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 06:46:15 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	=?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v4 0/2] power: supply: Add support for Surface RT battery and charger
Date: Thu,  7 May 2026 16:46:05 +0300
Message-ID: <20260507134608.76222-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add support for Embedded Controller found in the Microsoft Surface RT and
used to monitor battery cell and charger input status and properties.
Controller works both for UEFI and APX booting.

---
Changes in v4:
- fixed REGS_TECHNOLOGY read size

Changes in v3:
- fixed i2c_smbus_read_i2c_block_data read size

Changes in v2:
- srt_bat_get_string > i2c_smbus_read_i2c_block_data
- added devm_kasprintf return check
---

Jonas Schwöbel (1):
  power: supply: Add support for Surface RT battery and charger

Svyatoslav Ryhel (1):
  dt-bindings: embedded-controller: Document Surface RT EC

 .../microsoft,surface-rt-ec.yaml              |  63 +++
 drivers/power/supply/Kconfig                  |  11 +
 drivers/power/supply/Makefile                 |   1 +
 drivers/power/supply/surface-rt-ec.c          | 389 ++++++++++++++++++
 4 files changed, 464 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/embedded-controller/microsoft,surface-rt-ec.yaml
 create mode 100644 drivers/power/supply/surface-rt-ec.c

-- 
2.51.0

