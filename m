Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FAF433D503
	for <linux-pm@vger.kernel.org>; Thu, 10 Sep 2026 14:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789050793; cv=none; b=mpYxS35TcrkX0983+Uuwn7Mqv8BfqTk7WHw4xlw8IRtZTFgoG98pQLd+n9BG65O1sqTb1ZauxCvm4+qSAl+mzRQ7le3yJQQvlD1in8EUY1McfAtQhWcfY1BJW5saDU+i4oqvN5UIzkbaSBK/oY/wShjBJAzKfW9b1DaluEotN0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789050793; c=relaxed/simple;
	bh=6EjhR0+7L3WDUSaTLBXZV7F+O4y+6uTqZmySECy3+rE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=eebB/zWLKoveYxbb89hnrtDatQ/p7AW4tLnoOj9HMWq2em4rwTSJ33jgZ6A0nxeih34hw0Ek1pERAb4ET159TkSz1benuRGPhX5l8lF5HoF0h8ILaxKnh8kB91kSREX6HeHn3ulh4ClT9sg3lsifGaU5f0B+8MgpjGng0DnRqtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=bYGQ4Cue; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="bYGQ4Cue"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-49b0d8bc2aaso86964125e9.0
        for <linux-pm@vger.kernel.org>; Thu, 10 Sep 2026 07:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1789050788; x=1789655588; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=6oM7pa4VlFfIqD2Tf1cRDvr1YX2oXxRTGcQXQykT3gw=;
        b=bYGQ4CueVXf/pR6z8GAbPvSK9PAhVV0UwmoP2jxbUVmIn2QwqOwqdw3EVlGTKGezDS
         +1gQKN7GcdPCTGSbMEX8N3DdNoE0I84CgxroBsfX+TeG5ah5f7uPTrb17MLbAdQAF5xK
         AGn36SfVv5sQLS5w2Z5dxce6mq3msIpeLmOT+eFjHDI7bQgHFTE7zisPPW7viPRBysCW
         vPJNMRKhExURc1YBEoYq6JtKka3PRsaMmDwNVfBqkDPtvyQ3lPVCW2OJbxsskYILTpLC
         L3WDDsUV/sOk5Gz5foc6BTbhVX/dDkEl0XaXyz2O0HPrkWjBvZzB/T0RLPW1V11LKsv/
         oTtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789050788; x=1789655588;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=6oM7pa4VlFfIqD2Tf1cRDvr1YX2oXxRTGcQXQykT3gw=;
        b=tItXIyi3wWz4o1tmNKC5a7wdMjVZyVJ7DlhAmdqKh+Ny0W0JcsPMy2EQWycTOjt28L
         OFkmpMifR8bLWq9UUwZKNepRzCWPttbMhnH7RRcx1Ul+seYofRFi6b60PQWhf0H86+2D
         LG/34M8p/vvHM0rBB5JbVbyl6YeY91usqqCqltt+HiqmE4rNDcd0m8pSGWJwHslc7c2z
         ppLWmk5o0Rk67k6Vep2K9TVfX1sxpvryx92CZVXRuF+Lir8iGyJ9LYexalTq0pEfkltk
         16/5ulXJJOaC+y6oCpufaKR/MqPm8pnicyJhAbjrWDBvVecas37qrH+7j7Iqn7kMOJq1
         m/vg==
X-Forwarded-Encrypted: i=1; AKwUvByP1WuPmnL9vCyIgn90QiDMfjLETLI6/f7OfxciGOzJR3x2g6fe3tYR4aKJr+pBRk6eE/CCQTrG9A==@vger.kernel.org
X-Gm-Message-State: AFuF++lEHMBu9gdVeHjnRoy3gT0yHswwx+MvQFnYi15eusDi+YSM/48b
	YzkoYZYG8nl6vk/4ffHd1goNnFx0ZcQnurJnvASKkVOL/tvfgH4XAypcdY9+hyehdCBT0Pst/Km
	zSdGd5ao=
X-Gm-Gg: AYBFou3wqB0U8xcznVgz0cSI1cqiMIv4e8GYoteUeuuNIonYTXeaxcvoayoyUdOSpQq
	wL94qLKPYwwlK8vXKjdgIhiisScnV9QHpDx2Kxx0t+vYEM7jKXHWZniCp6AQPVUsmvpD4PT4Mon
	HqWcd3j5mqIfonHFQ2aV3q8QimcgekxeeR2msQy42+ewVshqiQIAdtJakPKp0EHdfHpD7S/fQhP
	njQxqUwAYpWAaoIF5AoLeWPCGu3H03jAW2Mjg7hXiPu5dK99HiG2zCLvbE0yehZaytPfeZBxl/A
	9MRX2cpS7Dk0lg0Unk1Rc0JOr8KvdQWGk9rssmHgivl/K4tqoqfSFWm3KGUJbXgN3Az3ibmmZFD
	kreFmQwWhViM7g6msz4EpK1Wmh6PdfTaGplNwMT0NON2AJatoXjaU40s921bX318kp716lShq/p
	7ZdwHp8G+alGxPkjKyy0huWwpLTovc80OvgleODM7NW5sTWc5CF7HgxZ1finffF/Ys7D8o7KsHW
	JMJNPeQfQboGykkmJJOoZc9gF0aV+5W8MwQQ9g8Yk/dz878zEiH
X-Received: by 2002:a05:600d:8445:10b0:495:48d7:f178 with SMTP id 5b1f17b1804b1-49cf825d77amr301185625e9.11.1789050788119;
        Thu, 10 Sep 2026 07:33:08 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-2-51-220-108.alshamil.net.ae. [2.51.220.108])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e5fbda49asm12537135e9.3.2026.09.10.07.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 07:33:07 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Subject: [PATCH v3 0/3] power: supply: bq257xx: Fix probe time race against
 driver teardown and battery parsing
Date: Thu, 10 Sep 2026 18:32:57 +0400
Message-Id: <20260910-bq257xx-init-v3-0-4e219a1a04a5@flipper.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNwQ6CMBAFf4X0bM22aAFP/ofxQGErawxgWxsM4
 d9t8aImHid5M29mDi2hY4dsZhYDORr6CPkmY01X9xfk1EZmEqSCCgqu73JfTBOnnjw3BnKNGoo
 mVywqo0VD05o7nd/sHvqKjU+NtOjI+cE+178g0u5POggOXNRQalmhqFV5NDcaR7TbHj1L8SA/9
 epHl1FvUe+gUFoYkN/6siwvkdIIIPsAAAA=
X-Change-ID: 20260907-bq257xx-init-ff03beb07c36
To: Sebastian Reichel <sre@kernel.org>, Lee Jones <lee@kernel.org>, 
 Chris Morgan <macromorgan@hotmail.com>, Pavel Machek <pavel@ucw.cz>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>, 
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3524; i=alchark@flipper.net;
 h=from:subject:message-id; bh=6EjhR0+7L3WDUSaTLBXZV7F+O4y+6uTqZmySECy3+rE=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWQt2j+ny+/dX6Wt1tKrn/5cI29jvXOm4zaF5KaCmHvqX
 DNuJb9g65jIwiDGxWAppsgy99sS26lGfLN2eXh8hZnDygQyRFqkgQEIWBj4chPzSo10jPRMtQ31
 DI10jHWMGLg4BWCq7yxl+MV08LQk08pOzjMx325dcviSfGHT9B1CG280b5/3/t1sYQUWRobZlbL
 XrzlHbV+/5sn6AoHjT/sdhOeXyCaFaxStfCXtJsMHAA==
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5

If a bus holding the battery-equipped power supply goes down right after
it registered, it leads to massive fireworks as the driver starts to tear
down its resources while callers from other contexts are already eager to
process events using this driver's callbacks (and their private data).

This was observed on a bq257xx device, which also uses the legacy parsing
of battery information from the probe routine, where it happens after the
power supply registration, adding yet another failure mode to callbacks
firing early (i.e. before the device is fully initialized).

This series therefore does the following:
 - Add a new semaphore in the core to prevent the unregistration of the
   psy device before its callbacks complete
 - Make bq257xx use the passed-in psy during external power change events
   instead of the one stored in its private data, as the latter is not
   guaranteed to be valid at that point (and was observed to produce a
   use after free during teardown)
 - Migrate the battery parsing and hw init into the newly available .init
   callback, which ensures that the device is fully programmed by the time
   external callbacks start firing

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
Changes in v3:
- Use the new .init callback instead of adding a dev-based battery parsing
  helper (Sebastian)
- Link to v2: https://patch.msgid.link/20260909-bq257xx-init-v2-0-deb4076b1f02@flipper.net

Changes in v2:
- Use psy->removing as the predicate for detecting unregistration instead
  of use_cnt, because a leaking caller can leave use_cnt non-zero even
  after the device is being removed, and ->removing already exists and is
  used by the removal function anyway (Sashiko)
- Don't rearrange the existing short-circuit check for use_cnt and the
  availability of the callback in the psy struct to avoid breakage (Sashiko)
- Drop the patch making the bq257xx_external_power_changed() return early
  upon I2C read failures, otherwise a transient I2C failure in updating
  cached status fields could lead to missed updates to charging current or
  input current, which is worse (Sashiko). Those status fields are re-read
  upon every property update anyway
- Amend patch description of patch 3 (formerly 4) to explicitly state the
  potential use of unallocated memory, and add a Fixes: tag accordingly
- Link to v1: https://patch.msgid.link/20260907-bq257xx-init-v1-0-1a08b29e1a68@flipper.net

To: Sebastian Reichel <sre@kernel.org>
To: Pavel Machek <pavel@ucw.cz>
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
To: Lee Jones <lee@kernel.org>
To: Chris Morgan <macromorgan@hotmail.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>

---
Alexey Charkov (3):
      power: supply: core: prevent unregistering a power supply while a callback runs
      power: supply: bq257xx: Use psy directly instead of driver data
      power: supply: bq257xx: Convert parameters setup to the new .init callback

 drivers/power/supply/bq257xx_charger.c   | 124 +++++++++++++++----------------
 drivers/power/supply/power_supply_core.c |  26 ++++++-
 include/linux/power_supply.h             |  10 +++
 3 files changed, 94 insertions(+), 66 deletions(-)
---
base-commit: c68a982815dcce5464e3bf2a31ac94f5146c04ca
change-id: 20260907-bq257xx-init-ff03beb07c36

Best regards,
--  
Alexey Charkov <alchark@flipper.net>

