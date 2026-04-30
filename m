Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364FB3B8958
	for <linux-pm@vger.kernel.org>; Thu, 30 Apr 2026 08:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777536639; cv=none; b=XnhBzctJK8SpT150HqIuUASJhYATLfnl7x8WP7bmS5p+5JCX5j1nqcs62x6oU3KYQmvmS0KowJUl9ztB6eJeyBJ1SUXRrHASrol7frPL1f2XhYONSDhfWmRH3kpOZAg7LcR3VQ+ZjWDGoLDN5PLaocdC/7ob5OvZEuqzWOe9KjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777536639; c=relaxed/simple;
	bh=Y7Z+f4twj102MaqgafUmbmWhaBz0+bcIsL4YX6/rdag=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eF19iJYC7a123xn3MDf9KFS71Eecq/YMx0rCddhi4RHNeisWAm48IHBaS6ECk9HrsriM1EEjaKGikcVvpRSQOEK1yIO79o8sKlDDKDEMzGv6/RwUEFrjfyruiworMDO4Gv2kjpFYUJzHc7p7eLxoTFp1SO0X3xmupQFvbc645jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z7KfP51d; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z7KfP51d"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-449de065cb3so4997f8f.2
        for <linux-pm@vger.kernel.org>; Thu, 30 Apr 2026 01:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777536637; x=1778141437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4VTLShMWp8Pof70NawJHNcJQ7O87q7RcUOF6Y6NMU6I=;
        b=Z7KfP51dmH0v9j+barHH7eiqByr37ZEp1hNdtF0TEs3EPQCceqBdUqvf7l/gKnc+tz
         /uVve7xARNXVr07PSZ3F7zKHejYPi+5LTgXu3WDUsbx9JayM+2OJ+dLuXTfHGumKqqJY
         ehEaYvEbxN9H1Xai337//LDQ0K3RCH1h5bCOkiF96ekTJ2ddHNpvD+YKLC03P4Z+4AoF
         FyTWB7dDkxWeJI/QEzaixXCOc/7HJ5fubV9sz5uOQdHwNUjStZYjqnh0bWaRoIIdl2U8
         IPZupobdFrWn73sTxvkMBzAhUEYIEZ2q1rmQ+WayCd/S2afijDkRUAhNUIGq2yc8spFX
         oqaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777536637; x=1778141437;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4VTLShMWp8Pof70NawJHNcJQ7O87q7RcUOF6Y6NMU6I=;
        b=hlPNTwFtkd/eZOUZts+xluj+F/kcA4+dpHPON79CkQ6NHjjkgrzqWXY4i20QkOS05I
         ApCU1pwgQw0CbbV+4DaGnbkf3uCvvlu2NJbHzltqLUV1Wo01DuWMj8k2uzOJ8QJcTgNk
         1r+I/q2hcwPEbBQf+BDO4Xmjgnb5O6V9nqn6jEvC3NXsnz8VUaVtM0jf8/S5psLHhR5b
         QjbOK6eAq7dJxnlQVi4E5JSJaeUXw5alsrnfT3syKtC4hKhXgT15hGyt1Rp9t0F00Xl5
         aA0213kXtmJvZVUpCxZnzixlzhZKDWcW9UEiPiANvDlRNnHc+68+rokXuPweglGQETK1
         DlxA==
X-Forwarded-Encrypted: i=1; AFNElJ90HG4nAzGWRfFAb8JC0IORMglZ9v9javv+FbCAsj9PssrMdbZoBIJPwguTTH+P364x4YerJ2dh+g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyNya48FNxAUjGBNnyVh/ylrocQ5Gzo06PHoi7/obVZt6tlP8d4
	uGFrPH3JztoQlLypNwLf8aitoynZMO4gvpmIKg7oudmc4apvXO3+fnB0UzMoXoNi
X-Gm-Gg: AeBDieuLEkXBp19O7D/Bf9HHcHF6sUyNSVMr2tnGaQK0Cbo34QOnxBABgsRuhpumwPN
	tdFZU1oA/yfuRMKtDrUn7b9iPV9BBR4BDT3Gm60Sojjf0lY68h1HRzXN50TQQ40TIiERUYXdGrx
	B0Q2VppIsNJ481G4xDdL7PWKXRH1Zy37WQD7WbnXqPfZvQ13/oEjnThzepro2KWQ9NGDP5LV7SV
	rUYCfvxAB044DWWkoB7sse98t45x+wGobrwR5g4lD6ZjiHXNUz6HLagUc7V7t41XIS4/4pUwtzT
	AeEFvzFVF1CttK4aPLPmH/UWtrOdrUXr+5oY083MxbdR22lKLLKH7FWGwjF9+9MwjYZ1O0HzRBg
	w8LP0kO2rcAtwMaxP380hDZ8ffSJMqXUdorEvpB1LNqbU5k05M6oR5Umm6u+yga7iwCpxUgm3uY
	0A9dq9bao6Kaq1N/QsebFI3bI=
X-Received: by 2002:a05:6000:2c11:b0:43d:6787:992f with SMTP id ffacd0b85a97d-4493d02a39bmr2853909f8f.10.1777536636357;
        Thu, 30 Apr 2026 01:10:36 -0700 (PDT)
Received: from xeon ([188.163.112.56])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-447b120bdefsm11809517f8f.0.2026.04.30.01.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 01:10:35 -0700 (PDT)
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
Subject: [PATCH v2 0/2] power: supply: Add support for Surface RT battery and charger
Date: Thu, 30 Apr 2026 11:10:13 +0300
Message-ID: <20260430081017.59345-1-clamor95@gmail.com>
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

