Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16AE53DDDAA
	for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2026 07:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785138781; cv=none; b=Zoncx7oTknXj8Y6iKJ0AQ05b1djHECVzQEwBVnbDFheTzRMqjO9qht8jWsZR2UUkEUHGeTKQiFPzzW21JRKHaHY8htcIEjOMpL2s/3kuyuvfpqjSpJeFIFeGZngdaQWK9m2AQqmH/f6sJZ7npkEOY3TXv4LMicyVjaKGCkn6mPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785138781; c=relaxed/simple;
	bh=H7pWTSeb1xk0+d5w9/EXCzJ3Dxx2A5cyzA707Rjw0m8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=iZV+m2zFK5E1l6+52jQk1nvzv6bpFB/KreS4TmPCz8nApyzB8R1HELXt5d8v0vEIanTCAxYFR9DVQX18LqqtIl0Kbf+hOd96duIWMoxW456D1XBujMWzzLT7HdUqoc6mi2dv9Y3HUaU+p68Q6CFq/QeRiGnV6UsSrS1lbfEFj3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=537XhasB; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="537XhasB"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-47c2b362ee2so2009716f8f.1
        for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2026 00:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1785138778; x=1785743578; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=OoCCE+8WEegpz3erKr7ATAfAUKMHripHI7m6gAg6Azk=;
        b=537XhasBJgfOUrNxpUCIcojPVBLAhZxDh4Mr7MPBVYaZ0XZJKjuLGW1AixOMyEg8+L
         PlIUgaMybwwsQm5aTejedpKR5iwrClmidqaW1T+bUxa4qPBhY36xma8FzQiCS4s9R+x/
         orD40SAFoeZdZgLB8xddD5A8z5xrJHsJJi2fBinpOalG7607/646L6Y0kSLmRJKi5Aip
         9wUTBPogARSimjdk6oINDdsOB1IKRRcKfewY4pnu1uWCWYHaWwJ4QKfAw5Eg4a8bgooK
         0yeoCIy3PCqW2jSIZ19vONk0jVoJQcMQ4BSPCfz5kqomQGbNKbeOZCz2XogZTb6qpSbL
         LKsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785138778; x=1785743578;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=OoCCE+8WEegpz3erKr7ATAfAUKMHripHI7m6gAg6Azk=;
        b=IvZ1IgAKXrZHgFZp0tcrK7DKyoEBkc0lJ9tuNuxkc0+qM1N9TIJay86QDUNVAnYPrH
         LIvj4xIziQ9VVSwE3UtxG9+uGkVw0gnf7gHBluuMEYl0JCJHPNmcWY6SibJHdctApveP
         3X0LO6ktpdaD763ZsCjmgbx5Q+HXcitVfeJGlD7wJkO9oHHgrmic1HkigAIvrQ/5KVdJ
         g5z+0kd+aXP/lTWoiK56owkYZYXkfnsw09y8n3JlXydhoo91SofcnTnnDrZPvM65lSzp
         y+RiZpJbBqdlvWntUXCHiXwTrN2Y1OSqSXmuJsvqnWUar9B2ZxqIOe+OUPlEJ4VC1l5k
         5k9w==
X-Forwarded-Encrypted: i=1; AHgh+RrssRPypaKsGxrnSQUCvRqwQsUj4/44Ydn++ClAwZ1+Hqf214MGZfoqLAHdRudbuRyEMM2WrCDD3w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxVT/7WX2csi2XCM6uCcgPp0Z6P5mVo1CBGqBrNkMD8efQ6ppcs
	JmtUEUQfokd5HybYoeFwlx4mYcwLRvW3LFqTuYKnUnZYpAKkL1EABot+u5f9Mj9Wo6LgU5ymbpd
	qWe8Yk/E=
X-Gm-Gg: AR+sD11k1p//GknCD2SHR0Fi+2NFaqaeYdcL8MeOVslt9IqGpg07b+60+ZPP/8n49JA
	STfeBSUihvHTaCz2p/ES/keKCNZmqDvFeeQcR0SR+Jkzv1C5v8Q53cYUHqSeohPkhF00/Oxnj5T
	OnaeJk7sc6YMwogqWw2+iX13O2VQkxKi1c+ISszUD+gTcZolPHNStRi16NkKt6bGZBunzPUbuHu
	lbtHQuQMwqiRgUFd48cHHeg1AHo9hnjdbaq5Oow0Nrc7rJAqYDKa6KV7dW03YQ0geQKFqq91nXC
	NB5V2flmPgejMkZqPZFLqBQn30XKLJfeCnbhz9yB/9naFltcbtDVfDjYa78yq0txF/VHSgNn73C
	VNlLvUNaWe0YZk0EhttO7kX/Vg0Uci9kO227pyH0R7dBpc6Y4GPRo/E3aUtkQbxkAHWSWF4DduS
	Nn/Hts3syRJw/rb/uTl1e0hjEWciWss4Yb7I94IQkuJ9XsBqso4cN88w==
X-Received: by 2002:a05:6000:26c7:b0:47f:943a:45fa with SMTP id ffacd0b85a97d-47f9fe98f1cmr8016862f8f.29.1785138778249;
        Mon, 27 Jul 2026 00:52:58 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-92-99-174-41.alshamil.net.ae. [92.99.174.41])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85c531basm50841449f8f.19.2026.07.27.00.52.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 00:52:57 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Subject: [PATCH v8 0/2] Add support for the TI BQ25792 battery charger
 (regulator part)
Date: Mon, 27 Jul 2026 11:52:35 +0400
Message-Id: <20260727-bq25792-v8-0-c1c70473bbe7@flipper.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2XQQW7EIAwF0KuMWJcKbDCkq96j6iIE00GqMplkF
 LUa5e4l2YSK5Ue8b8tPsfCceRFvl6eYec1Lvo0l+JeLGK79+MUyx5IFKCCFCmW4g3UdSKUR+sG
 TNxRF+T3NnPLP0fTxWfI1L4/b/HsUr3p/bTtWLZVkYstKIRrr39N3niaeX0d+iL1lhVrSKcsCk
 mxnwXSRmFIrsZJanRKLVJA8A0IkDK00tdSnNEU60Gi0jR3z0EpbSTCntPvMHjhYPyStYyupklj
 NpGNb51PoETl0rXSnpPq2rshovAscwVFU/+W2bX8fRywL/AEAAA==
X-Change-ID: 20260303-bq25792-0132ac86846d
To: Chris Morgan <macromorgan@hotmail.com>, Mark Brown <broonie@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 linux-pm@vger.kernel.org, Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3410; i=alchark@flipper.net;
 h=from:subject:message-id; bh=H7pWTSeb1xk0+d5w9/EXCzJ3Dxx2A5cyzA707Rjw0m8=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWSl8wUH+TRk6euKx8mfkPg1q0yepfuGdy/z9+lKiW+aP
 3dnCTZ3TGRhEONisBRTZJn7bYntVCO+Wbs8PL7CzGFlAhkiLdLAAAQsDHy5iXmlRjpGeqbahnqG
 RjrGOkYMXJwCMNV1Mxn+h69dvn9KJ/OjercwqdU8x3fEZZrf38KwQqhn9sfeQ/NXn2D478w/cXe
 /5LN9cn1CqsdlnL+/aq2Z6Ph2HqO6mf+DBycncQMA
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5

This adds support for the TI BQ25792 battery charger, which is similar in
overall logic to the BQ25703A, but has a different register layout and
slightly different lower-level programming logic.

Mark, would you mind applying the regulator part, which already carries
your Ack, and which is the only part outstanding from this series?

No cross-tree dependencies here, as the MFD part is already in master.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
Changes in v8:
- Rebased onto recent -next and dropped patches already applied by Sebastian (thanks!)
- Link to v7: https://patch.msgid.link/20260603-bq25792-v7-0-d487bed276d0@flipper.net

Changes in v7:
- Rebase onto recent -next and dropped patches already applied by Mark and Lee
- Enable the Input Current Optimizer to improve reliability with unrecognized chargers
- Explicitly program the battery cell count at init time to alleviate transient glitches
  with the charger going into spurious battery overvoltage state due to misdetected
  battery cell count
- Handle return values of all regmap writes in the init function
- Link to v6: https://lore.kernel.org/r/20260331-bq25792-v6-0-0278fba33eb9@flipper.net

Changes in v6:
- Changed -EINVAL to -ENODEV for non-match cases in the MFD driver, to stay
  in line with what other drivers do in similar situations (Lee Jones)
- Link to v5: https://lore.kernel.org/r/20260324-bq25792-v5-0-0a2eb58cf11d@flipper.net

Changes in v5:
- Added non-OF match data and switched to i2c_get_match_data() to support
  non-OF platforms (Lee Jones)
- Shifted the types in the enum to start at 1 to avoid confusion with
  zero-initialized data and non-match cases (Lee Jones)
- Reinstated the const qualifier on the MFD cell array (Lee Jones)
- Link to v4: https://lore.kernel.org/r/20260311-bq25792-v4-0-7213415d9eec@flipper.net

Changes in v4:
- Avoid additional data structures and pass 'type' within the existing
  struct bq257xx_device instead (Lee Jones)
- Move comments for new struct fields to the patches where those fields
  are added (Sebastian Reichel)
- Collect tags from Sebastian Reichel (thanks!)
- Link to v3: https://lore.kernel.org/r/20260310-bq25792-v3-0-02f8e232d63b@flipper.net

Changes in v3:
- Move MFD cell definitions back out of the probe function (Lee Jones)
- Collect tags from Mark Brown, Krzysztof Kozlowski and Chris Morgan (thanks!)
- Enable ship FET functionality at init for BQ25792
- Link to v2: https://lore.kernel.org/r/20260306-bq25792-v2-0-6595249d6e6f@flipper.net

Changes in v2:
- Fix an error in DT schema (thanks Rob's bot)
- Ensure the broadest constraints for all variants remain in the common
  part of the schema, per writing-schema doc (thanks Krzysztof)
- Link to v1: https://lore.kernel.org/r/20260303-bq25792-v1-0-e6e5e0033458@flipper.net

To: Liam Girdwood <lgirdwood@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org

---
Alexey Charkov (2):
      regulator: bq257xx: Drop the regulator_dev from the driver data
      regulator: bq257xx: Add support for BQ25792

 drivers/regulator/bq257xx-regulator.c | 106 ++++++++++++++++++++++++++++++++--
 1 file changed, 101 insertions(+), 5 deletions(-)
---
base-commit: c5e32e86ca02b003f86e095d379b38148999293d
change-id: 20260303-bq25792-0132ac86846d

Best regards,
--  
Alexey Charkov <alchark@flipper.net>

