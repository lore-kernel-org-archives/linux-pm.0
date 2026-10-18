Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31BE2236F7
	for <linux-pm@vger.kernel.org>; Sun, 18 Oct 2026 00:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792284723; cv=none; b=DUhSsBG8sNlyBo0KQrvpB0jS7oGzl9VwCVyJWJbnq+2PgZSyfcXLoue7NCRTvuPVLXJITE8mG1xg3DmvlliKDYbUGC0Kfrgl8xxKwQavu8Amc9B6NUV+Sc9uZYbNoleywDac7y3t1Z13C3a7h1ZToE3ZlApQjlSa4OvxFFiSbwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792284723; c=relaxed/simple;
	bh=eTUJ67U7/3BnLFH+qFQIlNgaP3/PqrNrZtJFDGZhTNU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=SgLv1N3gGov6r9vW9jdse/AHRqy3O1Cf5Vv+A07Z2FUKtjoPnsu1cHdzOckC9S1Vw39CRUQtN4f2LSZLnc12wvN+hu4U9qwvsdCM/4O5ejWDSoSv8ld3qIQXOeYqO9gNuWDXZ8G2QijbBBlI/JaeIUHok/UkNahen7qVVZwwwXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GMVzsHe3; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GMVzsHe3"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5be4fea434bso906268e87.1
        for <linux-pm@vger.kernel.org>; Sat, 17 Oct 2026 17:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792284720; x=1792889520; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=7AXHPdZUYZbA72hWR34lPKHVl/XaRfzFZKPUd7IEbek=;
        b=GMVzsHe3uPcI/30D2LiG6SQnAoMk4kDqsxpv3tG+Y1+WdagUo/iZBmBNCIBr3lHrwh
         QP+qaCQRprfA6u6YmYe91jg4uUaE2bhwViQJK/6WPFmD+Obbuzjg84ZRYZzQZvfDkiwV
         pd+tY3/9m5bm8R6vSOerNXQ+Hl/oDqFKaLD8KwzeP4QyZXR2pneWS+T1vENHIcAAu9HT
         d8y9wtkidzEYvQC0wqcHle3cCJr/+O0wjyZ3UM98yf2YmdlOMbPg0mXSnSUkIDs5CamW
         1/is9s29Z+ksp1EvnR6WfibKp+bEPR5wEuxbb6yJBvc3+vN1iPI2g8xkDJ1FdqdFwU9Z
         XtxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792284720; x=1792889520;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7AXHPdZUYZbA72hWR34lPKHVl/XaRfzFZKPUd7IEbek=;
        b=vdAMb6w6ymiclwvipqIt9mYnSwh1Myjfs+OI+gKV6WIGrEcgWeet8LwPyLEgbBImTQ
         holRl4VSaKM1sbM+Iz6o23l017m0TW+AN28yw1Y/xTqbz50rI2Pvs5IBVMov+qT0R3dN
         LnhyUQNpH7Qc89KxJoyIyu9Zm5qxxoeLEpNPUswcG3vxoeOEuDeTVUN2E0zxvpxGonkL
         JPeDyaaV6p1/ZciceneenkJ0HjvWH0qz4kh4saHUM5guqFzGhJlxC3otQ4cQw92+BwL5
         MrGYYN4lpTf4V82cUtyF1SlE/8VzOIGHFA7/XcJRXQ/wzh6pS70XLv+zknGQ0x59tf/J
         gEDQ==
X-Gm-Message-State: AFq9FYLw1tsIQgaNaFouV+bJuLq6p7m8WUPyEQ8pjckVhTz6u/NTSSvw
	9anLtmhAhDxYu1Mq25XJEyGAGZrF20XIDSB0G94FVI8OnrbjjirjTFCGnJBh0JPidBg=
X-Gm-Gg: AYBFou0gtMXCPaIQFolV2RtPacbEvyPVR1xuSMU3EivSMW8mY/kpBiob+RX9+iO/gAL
	HveE6ajLkP9SExnWEtN2ULfVtwM5kCYbjeH5irU0QFJIzAw7In5taFG3k0y8stuLCmk9nH1Ld70
	lYj7y69818c+m47GwuTD5s0Tr6WFoskJFHZKDm13K7HMrNDZZ4m/vHciA0Uevp/yCskrpJPrfFY
	NyV8hbSlv3EsRlQsP3xy/Mp7ptxp7rjBkIw521PvlU64zb6ue5ASGpWjDacjs3nI2e1hEN3r66P
	t2GWgVEQ5Cq3f5373K+AzvYCfa4Xt96VjpL8KvASNIDeN1fzfkzBy9OOjWzhoiw+ieXPtCtu/cI
	7VI9Xpu6ZeKU8FlDG3ed0pUeoxiNaoewoXkJE4E17UDhrDRGINB3YR24vg5lDb5pl3tIhvyvnWh
	VZbRjGKO8eIiJlSoMTy+oYxQosmomz2kYN0VgOHtZ2D2TiNBuBbS76/6iP+O6Pcki5ri0OrirEN
	pWIdHirPsIcwBNZltF4ToasDeAmWdSOLWQ+91gMs0PJ
X-Received: by 2002:a05:6512:a83:b0:5be:4f62:5b84 with SMTP id 2adb3069b0e04-5be4f625f92mr1163822e87.19.1792284719388;
        Sat, 17 Oct 2026 17:51:59 -0700 (PDT)
Received: from [127.0.1.1] ([93.189.202.99])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5be4a6335fesm1158148e87.57.2026.10.17.17.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 17:51:57 -0700 (PDT)
From: Rinat Muhamedgaliev <rinat.muhamedgaliev@gmail.com>
Subject: [PATCH v5] bq27xxx: support interchangeable OnePlus 6/6T fuel
 gauges
Date: Sun, 18 Oct 2026 03:51:22 +0300
Message-Id: <20261018-master-v5-0-0be16441cdd1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/zWOQQ6CMBBFr2JmbbVUaMWV9zAs2jLAGGlNi0RDu
 LsUwvLN/Hl/JogYCCPcDhMEHCmSdwsUxwPYTrsWGdULg+BC8lIo1us4YGCm5rqpS1lKbGAJvwM
 29F1Fj2rj+DFPtEO6TgmjIzITtLNdGvlALbnzpkv7juLgw2/9ZMyTZy+97qVjzjLGC2HVBW2mp
 Lq3vabXyfoeqnme/+1Z0knOAAAA
X-Change-ID: 20260927-master-bd0afd9696ef
To: linux-pm@vger.kernel.org
Cc: pali@kernel.org, sre@kernel.org, afd@ti.com, 
 konrad.dybcio@oss.qualcomm.com, david@ixit.cz, krzk@kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Rinat Muhamedgaliev <rinat.muhamedgaliev@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792284715; l=1522;
 i=rinat.muhamedgaliev@gmail.com; s=default; h=from:subject:message-id;
 bh=eTUJ67U7/3BnLFH+qFQIlNgaP3/PqrNrZtJFDGZhTNU=;
 b=uiGK+g5pHQItU5xVxRjt8VNW+ZCmDvRM3V11IWSecneXJCH+CRkZxvse2DbTG8loYZ3qLdd6H
 f6ItcjEytIhCoJc/KwaeLzxB8oF8HRcodNTbYIqdFlangqBPQhgOSq2
X-Developer-Key: i=rinat.muhamedgaliev@gmail.com; a=ed25519;
 pk=qkYQO8LRlRErWiLzlpK8jHbRIxv8+7v06+ytcxX8mec=

OnePlus 6 and 6T replacement battery packs can contain either a bq27411 or a
bq27541 fuel gauge. The latter requires a different register map and produces
invalid battery readings when interpreted as a bq27411.

v4 drops the proposed generic DT compatible and DTS changes. The I2C driver
instead reads DeviceType while probing the existing bq27411 compatible, and
selects the bq27541 profile if the device reports 0x0541.

The bq27541 path was tested on a OnePlus 6T with DeviceType 0x0541. It
reported 4.338 V, 100% capacity, 27.8 C, and Full/Good battery status.
Testing on an OnePlus 6 or 6T whose fuel gauge reports DeviceType 0x0421
(bq27411) would be appreciated.

Changes in v5:
- Report detected and expected DeviceType values instead of hard-coding chip names.
- Describe an unknown DeviceType as unrecognized.
- Link to v4: https://patch.msgid.link/20260928-master-v4-1-052c73ec1767@gmail.com

Changes in v4:
- Drop the generic compatible and binding update.
- Keep the established OnePlus DTS unchanged.
- Detect bq27541 from DeviceType in the bq27411 probe path.
- Send as a new thread.

---
Rinat Muhamedgaliev (1):
      power: supply: bq27xxx: detect bq27541 behind bq27411 compatible

 drivers/power/supply/bq27xxx_battery_i2c.c | 39 ++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)
---
base-commit: 830b3c68c1fb1e9176028d02ef86f3cf76aa2476
change-id: 20260927-master-bd0afd9696ef

Best regards,
--  
Rinat Muhamedgaliev <rinat.muhamedgaliev@gmail.com>

