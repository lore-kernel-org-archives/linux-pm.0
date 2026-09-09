Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351615592F5
	for <linux-pm@vger.kernel.org>; Wed,  9 Sep 2026 15:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788968526; cv=none; b=ULveIVPO5Ch1oR8BXQGDGUxPOA0jK3UvaSjs7g0BSTTsJpJOxYFi/OqwPkQpHO4S6wyhBwUi1ZDGUYV/e6FKPDLBDRqYkhNj3Uq3+qX6qyQIDC03FJDk/yfi2c8+SRcwcBSG289bGkcclFQA2Hb1WRV4feZV9dgRl2nYYyySHYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788968526; c=relaxed/simple;
	bh=g0LSu/WqHQM8vzTp6V9PCbL1O3KFI/kS4kQdJe8Ge80=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=B77cQbhCmwPypfrSmSAhcQfmFUY+Op8eNGIW+1Oi4cOz+OKQGbdB9uTYkPYUgjkr8SHWWyyY/5DtRyu2t9C3flXWyoru2KAPhSoEACCNgpAG3GRH7rgdq7EQ+V6jc7gIs6XW/v2mTf2jJaN/OT4sdqSawNzg8qcMMpOxDYaFVmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=9XWMIxIG; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="9XWMIxIG"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ccfd61ecaso4643135e9.3
        for <linux-pm@vger.kernel.org>; Wed, 09 Sep 2026 08:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1788968523; x=1789573323; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Jdw2hZ27DBy1i8yzmj6RxolBCvaZBi48LgdLvbRyGYM=;
        b=9XWMIxIGH/kAzz2Kb4Sferzp7K3qFOpDBQucec/XJGZf1KxGWSqu4JN1CtccBqLQA6
         yxEisQlUK2TYr4sJv+QS+aYuIf8mmtLFAFdJc/3VwHoMPy/PZThDHpn9OsyTi8lJ07NS
         DG2wqrX8HD/GhpEzbWJ2NbGV9ZG5V/1k64yE9qCrYQw1Ym7pG1Cx06siDUGi9IyHUsf+
         FNoG0tVTYP1nOzJPfhL5kC46o+gj6Gad5hveZF6yDvSc+5I15DrhSko0mjy84b0PTMB0
         /rCTxqiaXfOthYWNsC3rP1ymcd+AKdS0Pv/cCWVpQc01SqbSgZX77Qun3rMJdQkoMYZB
         dcUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788968523; x=1789573323;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Jdw2hZ27DBy1i8yzmj6RxolBCvaZBi48LgdLvbRyGYM=;
        b=d7bnbju/sN97P3Af5a+LxdW8c3eXlfRmEAkR7jE8MlntgE1VLyF5HGaoWw03j7So7K
         /YI4l3O15KXKDbLn3tyh1anZDdybWIth+qI2t8+PJn8Jl4hPEQx0rMsAwTKmPziF4YVz
         TJPrHG+0S5dhAU7feaASHwUjwVCZYnYKWzTjx7KcQC4mASqT9q5u9jsN4iKNZNTlPNef
         ElUnGa1nGrfZl6e/SShLsm4cfxvNGAV4GdVzT3wy86kCN+NUNLdaDK0EptLJLZW0W/D2
         VUifOcjXQ75X8TZCpowQW0kmkp48ImSl+PtN86lGSSRBqejCD8nhQymi70/0aB1v6pUd
         lupw==
X-Forwarded-Encrypted: i=1; AKwUvBwMNBo3U7HARxI5+ZUa/qrzsomeKGbNi+A95eJf70ANJrzkNbWpGVsNYySKKeveEvWWyYL/ABU+IQ==@vger.kernel.org
X-Gm-Message-State: AFuF++kHKkXT7Hz2anTrGdRvn5I4EJ5gcKQFjujoME/OwIOpmK0tNAsY
	pk1egm9Fw9Wz6ak6eG6AfELkC+ytIZDW0KbzrT6z4J6HzVvpPBXusTrKj72SQxl7lw8=
X-Gm-Gg: AYBFou2KX3nlzqemywnkOf69NzEkGXjnw+GtwfIzk67bBsXA9LoBOu9tBe0RrZ2gub3
	qleWSjPoR3s/5iE1+TRhbCUGeA3n9r6ERlOGcs4laBKTVHj21nTPaaywa05SZwfKoTpTvmRAzK8
	omf37Y/Bt10xAVNF+7vbG1WunH/pOm9jMYN3WHnP/alq5DNVUloL/wRhHNRJuODap5LVotaZhlB
	y7l184D1Xrk5Bq1KpYzw9zHXJ0mQDwZuy8+h3Ts9mYqVfIp195euqpzg1SS/jCcTfErpDB4ZkWi
	zGj7GdPq4rzTUPdXq5Gdo/Qbs0SC4rkeREEPsMlmhsAJQJhIFJXqWAFeGh1momx302Hk+RT1WV8
	3ZuNsXxsycNWBj/YC9fFd1Tkc2let7ZReBdwhf/ywIVXBSHztgMnRdgFdS+TpnlsPKGHtN/1y7S
	ZinkfYjOzymdKXQcY0Jvu4NfxOxoPCztu+PXkd55I8csP2rdaRVIvO5iRHgIpbx5h8MYuBp3dcG
	8nLs60x4sb6vtTzX02FRawOYP22xhnpngps2yx9EUOYQ8W8xOtbBFkwFJ6M7A==
X-Received: by 2002:a05:600c:8b16:b0:49c:c0d4:53d9 with SMTP id 5b1f17b1804b1-49d258dfc5fmr17857275e9.14.1788968523269;
        Wed, 09 Sep 2026 08:42:03 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-2-51-220-108.alshamil.net.ae. [2.51.220.108])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cf7740d44sm1042068015e9.15.2026.09.09.08.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 08:42:01 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Subject: [PATCH v2 0/4] power: supply: Fix probe time race against driver
 teardown and battery parsing
Date: Wed, 09 Sep 2026 19:41:43 +0400
Message-Id: <20260909-bq257xx-init-v2-0-deb4076b1f02@flipper.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNyw6CMBBFf4XM2pppiTxc+R+GBa1TGWNKbSvBE
 P7dgmuXJzn33AUiBaYI52KBQBNHHl0GdSjADL27k+BbZlCoKmyxFvqlTvU8C3achLVYatJYm7K
 CPPGBLM977tr9OL71g0zaGpsxcExj+Ox/k9y8P+lJChSyx0arlmRfNRf7ZO8pHB0l6NZ1/QIuQ
 x/gvAAAAA==
X-Change-ID: 20260907-bq257xx-init-ff03beb07c36
To: Sebastian Reichel <sre@kernel.org>, Lee Jones <lee@kernel.org>, 
 Chris Morgan <macromorgan@hotmail.com>, Pavel Machek <pavel@ucw.cz>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>, 
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3143; i=alchark@flipper.net;
 h=from:subject:message-id; bh=g0LSu/WqHQM8vzTp6V9PCbL1O3KFI/kS4kQdJe8Ge80=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWQtrLON+2eevGuuf7QPzzlri6uBvYzX900UuHZd5O0je
 a7r0RxbOiayMIhxMViKKbLM/bbEdqoR36xdHh5fYeawMoEMkRZpYAACFga+3MS8UiMdIz1TbUM9
 QyMdYx0jBi5OAZjqnm2MDAtnf8zfkmFdmL8p86bVqqLO+WaX26XfPH7mFrfqYKtc7B+GP9w2m1d
 1bjuwe4/0TY857TZCxROcL+Vf4dox630H+9TnizgB
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5

If a bus holding the battery-equipped power supply goes down right after
it registered, it leads to massive fireworks as the driver starts to tear
down its resources while callers from other contexts are already eager to
process events using this driver's callbacks (and their private data).

In current power supply core it's further aggravated by the fact that the
battery parsing code expects a psy struct from the caller, which is only
available once the device has been registered, so the device gets
registered with its hardware constraints (e.g. charging current) not yet
fully filled in.

Fix the former by preventing the unregistration of the psy device before
its callbacks complete, and the latter by providing a battery parsing
helper which doesn't require a psy struct from the caller (as it doesn't
strictly need one).

While here, fix up these issues in bq257xx where all of it was discovered.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
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
Alexey Charkov (4):
      power: supply: core: prevent unregistering a power supply while a callback runs
      power: supply: core: Allow getting battery info before psy is registered
      power: supply: bq257xx: Use psy directly instead of driver data
      power: supply: bq257xx: Parse battery info before registering power supply

 drivers/power/supply/bq257xx_charger.c   |  52 +++++++------
 drivers/power/supply/power_supply_core.c | 128 +++++++++++++++++++++++--------
 include/linux/power_supply.h             |  14 ++++
 3 files changed, 142 insertions(+), 52 deletions(-)
---
base-commit: c68a982815dcce5464e3bf2a31ac94f5146c04ca
change-id: 20260907-bq257xx-init-ff03beb07c36

Best regards,
--  
Alexey Charkov <alchark@flipper.net>

