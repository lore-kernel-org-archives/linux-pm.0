Received: from mail-lf2-f12.google.com (mail-lf2-f12.google.com [74.125.229.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36BB03E7BD5
	for <linux-pm@vger.kernel.org>; Sun, 13 Sep 2026 12:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789303981; cv=none; b=uqbghUegj/P3TUwzUlWLbgRmQBUzE6TUKRSQoHkI0GIAY/uv1nQq/5NkorWPYk+YpA9FOn/p2S+J2x3TPXtjZ2m8zSL259akmNrP9VETteaFeKqL19ESQzwNqqU21VwMyNagxnd0zOmvlqoyqMYZEFVgkHGLNWdlHQcLVEY59Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789303981; c=relaxed/simple;
	bh=YbaVITUhkeDqVIioLFWBfDjSJAJ93O9p9DZUGxcH+fI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hZVe4P0IVHchDMql6FeQc761oYzQ5ue1oor1q+g+3WOI4HZUs4/4wtddGdRDBEtMVu3mxXt69svPR26ZLqgk2SubkhpxpprfPjmjDoCMJlu7t+/Ic0MpMwNLoh5sN1Tz+o914UyVQYdr/ZQKpU27eefpp/HG1aDXdxp4N2ZSr1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r0nUGQqQ; arc=none smtp.client-ip=74.125.229.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r0nUGQqQ"
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b5e4f1651cso808939e87.0
        for <linux-pm@vger.kernel.org>; Sun, 13 Sep 2026 05:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789303976; x=1789908776; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZSiQ4yRWCAeWevHuomAHZI5T/21V8Jw+Qsr3Wu9T7ZY=;
        b=r0nUGQqQpzaxS0W+eDSPFL2q1dco1pvvrQOOoMCl7hl6ITQu1IeY5dmAZLwFiyJEPV
         mKg35vsLls276+W/Uugi0dRl7pF1fIOgrXu7OF0PWutGtYvnBE6K70WmHSybWEnzgDS5
         NcfmRbF/j+O0gdHDvAaRc8RIZT/NERmgr4w7SGEqaPm1FuKB9ZplqkpESWkU+IbIL5zJ
         BSJdGYo5kpMJQfDglosh6Sq+6NLBe10bCNr2GWwkqkmqG9+hqZyJt0uEsA90W8FcmTAm
         BSwx3L/cw93YEtx8LOlQv10UYtproufmBk7c7tKrZ/hxDLC3KDw08QwvJUmOnnlwy1HR
         Wamw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789303976; x=1789908776;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZSiQ4yRWCAeWevHuomAHZI5T/21V8Jw+Qsr3Wu9T7ZY=;
        b=BflZoriMLFSEHi9BguutvBhjtscnJlGu8H+A7egD+pNplrVFeg9v9+Md/bJ5B0muEL
         SEmQe26rJh+Y9J7Of9SqiktmQuugX6A3Mw2ge5pZxLJkcfi4kUWzy/Th6RVaN6QXo2JD
         pNCjrrs+EUd9odQUMwairx8IvFDIuLVcmidA8wgJK6X2u6lXDNBv0epvB2KifPJvxoRV
         WIFeHIjWVyHTl/K25rT2N4Dyj6RBND9NiGMQxI2AfsQ3vSdtsADbC/5XmGfzv7nlgQ7y
         IoGozdCXwEiL+5wyEjwighs7XM+naKynzrJRmNLj9IfaKMMQg2Bk3cqXLNWxtdBlaNqQ
         zovw==
X-Forwarded-Encrypted: i=1; AKwUvBw19dhbkLh7ejmfRGF85xsldMyCj+EMrXf2rZsDRXe9YZFpnOVM9WeBAYqJRaiaOwLU+oYWPuvydg==@vger.kernel.org
X-Gm-Message-State: AFuF++lGtN6Hm6RgDFQRn2D7jA8EYZYxhXKKVlBDAVIIpI1bidXqdlzl
	BM7RC3lfqQY8pFlt4JGdbaA4Jb+uV2KxJv40upVrwObxE6legLrCIB8=
X-Gm-Gg: AYBFou3hh7b4AKA+LrqHgQv9pKCRCI/T1+Fngiuj5eKykxn2lS0fRpBcwaXWgKmTjIz
	zVt9e4OeinICVQJhmHzC17fL8YcDap+rLh1DyUcKo7CQ+LwRbiyUgSL6bnQHGb18R6/puNak2z4
	kFEHD0s714d9VU6RTUqYepyHZcuMpsgRMwMMyx4CLVMbRIaHa7j//mP+lEhXFU0oA+TlVWNXIqS
	MTuzZXyVJPvRA32WBlR8hXqy2eyrP+3yJuzyp65hg4g8RkHpyCLgYTLphZSWVXehuz8rN9arXUY
	ckPnxAhHLEYL5iAD3Fif/NmIQlkjHO29klOl/tgzHx0iz/2/0vj37wNw9sUXUX4wMnyXRZru+XB
	pGOTJvY4qYBldFm0EGjkP6PcQJLQw82ZQt1/WXb/sJTp63Fswjrjb7BLnyXvxeBsItYeHSO/12d
	1QmWeHZAyQCZuO+B+JKSMWNIYFkUDsfutKEZgQy4LkWKmwpzf0DDotbxPm+/NIKg==
X-Received: by 2002:a05:6512:3a96:b0:5b7:a987:d03d with SMTP id 2adb3069b0e04-5b8a8ed15damr1361837e87.21.1789303975926;
        Sun, 13 Sep 2026 05:52:55 -0700 (PDT)
Received: from fedora ([46.8.219.5])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b8a0469a8esm1762844e87.50.2026.09.13.05.52.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 05:52:55 -0700 (PDT)
From: Vitaliy Sochnev <sochnev.v.74@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>
Cc: Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vitaliy Sochnev <sochnev.v.74@gmail.com>
Subject: [PATCH 0/4] thermal/drivers/airoha: Fix AN7583 mux mapping and expose all sensors
Date: Sun, 13 Sep 2026 15:52:22 +0100
Message-ID: <20260913145226.34643-1-sochnev.v.74@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The AN7583 support merged for 7.3-rc1 reads the wrong mux positions: the
mux field names are swapped, and v5 of the series swapped the call
arguments to match them. Patch 1 fixes the field definitions.

Patch 2 serialises mux selection and ADC sampling.

Patches 3 and 4 add one thermal sensor cell for AN7583 and a zone per
sensor. Device trees without cells keep reading the bandgap sensor.

Tested on a Nokia XG-040G-MF (AN7583) with this driver on a 6.18 kernel
in OpenWrt. Without the series the board powers off 2.6 s into boot.
With it the three zones match direct ADC reads, and concurrent readers
during CPU frequency changes gave no failed read and no shutdown. EN7581
was tested with equivalent changes on a Nokia XG-040G-MD. Build-tested
on arm64 with W=1; the binding passes dt_binding_check.

Vitaliy Sochnev (4):
  thermal/drivers/airoha: Fix AN7583 ADC mux field mapping
  thermal/drivers/airoha: Serialise access to the shared ADC
  dt-bindings: arm: airoha: Allow one thermal sensor cell for AN7583
  thermal/drivers/airoha: Register a thermal zone per AN7583 sensor

 .../bindings/arm/airoha,en7581-chip-scu.yaml  |   5 +-
 drivers/thermal/airoha_thermal.c              | 159 ++++++++++++++----
 2 files changed, 128 insertions(+), 36 deletions(-)


base-commit: 5ad0af4f4367202b1bc71813052fe39b5116cdb9
-- 
2.55.0

