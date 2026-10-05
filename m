Received: from mail-ed2-f35.google.com (mail-ed2-f35.google.com [74.125.228.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC95D47426E
	for <linux-pm@vger.kernel.org>; Mon,  5 Oct 2026 16:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791218591; cv=none; b=LnGNoBEqtGQlbxcKJ5RMTdEY1muywyMYB6v9oM2W9henqOQodF0roiIQn9ILWk2oQ4rCO6afknCPLZpXP7xzPRcRgQCdQlTI4+2dnGw4TEjRsCNoRteMQ26/eRA3Zhz/r1YAKbqJMwoUASZ5iVvd2u5WDwQnYJ9lQiWjb30m0Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791218591; c=relaxed/simple;
	bh=InZ5RYagRV1LLDs2R4y2SbFxXZgYthEw5PQqVjO3KWM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qLJ1HwzI0GyW5or93pAqeiMpZSUm3Cv6S4U91UTPotztp9x0ZIWcsS69fmpEinc3kle7TfSRQyEE7ksoZr2D0kd+Y+Qbf40AUBbvLk/lnPqhys63YMw34RmaWKUuT5m+8IZzAE6iTBY6D4QwM8fzNp/b1xGkmyJMzQisTuEzAuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ggGUmTPT; arc=none smtp.client-ip=74.125.228.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ggGUmTPT"
Received: by mail-ed2-f35.google.com with SMTP id 4fb4d7f45d1cf-6a605c198fdso2759129a12.2
        for <linux-pm@vger.kernel.org>; Mon, 05 Oct 2026 09:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791218588; x=1791823388; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/u1zvTg+FDBSornCk/zN7IM9H8d2POoh7CUYlVwxFqk=;
        b=ggGUmTPTw2gp6/Ik0mK8kBkvHn9f4N5cz7fEX2YM80lmSCkoN2kJvloRuSZi8RXSNY
         pFvvsMu4b5ThNtX3NV8gFbqKshRxpRCCXN1XPZjlhhU9la7PxLeordYxU+V8Vt72C4Wl
         kYi4ZEPBn34UFe0631IWzHiLTrp4oCJGugXTecdmB5k9iBk3Yh44yL+OpvpWoWgRQfTl
         e/97wcVG0kH10eEzA+Cm/AQCaVU6+LSLpeSnmJFq9+2g8lBrPZkSN2jdUOvmKII0WtZt
         PaZTjusW9RNKoxeiCluYOv1LhoM9gp83K9RGR8wYFRUDWLJC9o0ut1XLJORZKSHtFk6r
         fuMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791218588; x=1791823388;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/u1zvTg+FDBSornCk/zN7IM9H8d2POoh7CUYlVwxFqk=;
        b=XbKXxvlSDvL/o7RqaN0REDVd6hrifIUm0DxnQNHo9BvHP7brwkEOaGJjJNTIxQqvZD
         cODkUMTNofC/5z87WOk/M78TZMTUfO0xQYdS6KoYPStbTmVrLyriA9MSj3RvTcXmgP6L
         elahP9qD7IEAp65tLLrnYrAWXnFA10PImED/7wSsWZS1uLkCaXGou9455m56Xz6wNUox
         doShiNuCrvTkyr8xxzkPGLM+moPVjmtUOiHTqs6sbOaeMl307BPqorZIsruz6FTsHnP3
         PXJYHMe7hl3jeUoTFScyaXubsprGybQtJ/6KwPLPnz24yyI2SUdYu8dE/UsF9678lbfT
         D9Rg==
X-Forwarded-Encrypted: i=1; AKwUvBy4otIEIPHVqQwJlmtt9AhjK15+T9jz/FHMCdKbE6mjvvhwYJwuIY8+vvbXGXj2b83brqemdr8vPQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYJuRH+KJLj0IpZTAWNBuHSiuYMJZwrM0owiYOjYtDmuBQ/Xmogs
	I/U3CkuPcMDtB8xbW3eomLCcM5t4EQOIGDao5bDr2u97PWmwLtt7Ffk3
X-Gm-Gg: AYBFou0ZR8QJvITqGDsRiTzXuf64oJUD93ovkBY8qJt2/iyuwe71zUwPCC9+bfOLh2O
	3zE7Rqp+DieWXAoBpbNQVl/D83iac7wzA1LQcvOBkx9ISyP1rWw3tVbDMnmHkQ4zDJ7cplzPFEd
	pKTQRqGMZNcMLYQL+VF+NSv/P7oGUIfxSDkpkudTGXBaRLCYiilfouNopFzeyUyLbQdRb6qBePm
	3y8q1ZXN0bXNfDpxWPN6qIxs0VQ3NnbgexEhEnWVgRUK0rY8RKy0HoMqzxrYfDaVcR+/b1GzCc6
	FNM3MggHFck9d78F6ByeH1wpwDUtVe3sucPWDB8kGDS8H41gVO7s5RKf5i+ZM6+NZpk+XWYTR7/
	dSSCdhRbgCKuouppn4iyNLo3AaCluiX37FvnKBJRw/DBtCknGfstaaZTOxe8UHpB0Eblh90FkVt
	LZfKw/Xj9sYeb5tG+ujw4rny+/HVR4xhpgye5KzlEWZ2dsWL6V45xFufDXS7eZeXe8q7h1RCAX2
	RPZ6c13b2zZwS8wztP12kZdAhsNM1tMxIKgOw==
X-Received: by 2002:a05:6402:46c1:b0:6aa:1c24:8f7d with SMTP id 4fb4d7f45d1cf-6af9e301528mr9516864a12.21.1791218587878;
        Mon, 05 Oct 2026 09:43:07 -0700 (PDT)
Received: from workstation.home (161-53-210-87.ftth.glasoperator.nl. [87.210.53.161])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6afb021af56sm3485851a12.31.2026.10.05.09.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 09:43:06 -0700 (PDT)
From: Stanislav Zaikin <zstaseg@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sebastian Reichel <sre@kernel.org>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Stanislav Zaikin <zstaseg@gmail.com>
Subject: [PATCH v5 0/3] Add Xiaomi 12 Lite 5G (taoyao) battery support
Date: Mon,  5 Oct 2026 18:43:00 +0200
Message-ID: <20261005164303.1208127-1-zstaseg@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Xiaomi 12 Lite 5G (taoyao) has an additional property with ID 12 that
breaks the parsing in qcom_battmgr. Fix that by introducing separate
maps for lookups properties in both directions.

The other approach that I tried is manual shifting properties:

+	if (battmgr->variant == QCOM_BATTMGR_TAOYAO && prop > BATT_CHG_CTRL_LIM_MAX)
+		prop++;
...
+		if (battmgr->variant == QCOM_BATTMGR_TAOYAO && property > BATT_CHG_CTRL_LIM_MAX + 1)
+			property--;

But I found that more obscure.

Will be happy to switch if the maintainers prefer this one.

Changed in v5:
- Fixed the commit message (patch #1)

Changes in v4:
- Added Konrad's r-b (patch #2)
- Dropped RFC tag

Changes in v3:
- Fix QCOM_BATTMGR_TAOYAO enum ordering (patch #2)
- Order in qcom_battmgr_of_variants[] is already right (no change)
- Revert the qcom,sm7325-pmic-glink SoC fallback (patch #1 and #3)
- Rephrased commit message (patch #3)
- Design question from v1/v2 still open: lookup tables vs. inline shift

Changes in v2:
- Keep the qcom,sm7325-pmic-glink SoC fallback in the compatible chain
  of the taoyao pmic-glink node (review feedback, patch #1 and #3)

Stanislav Zaikin (3):
  dt-bindings: soc: qcom: qcom,pmic-glink: Document Xiaomi taoyao
    compatible
  power: supply: qcom_battmgr: add Xiaomi taoyao support
  arm64: dts: qcom: sm7325-xiaomi-taoyao: switch to device-specific
    pmic-glink compatible

 .../bindings/soc/qcom/qcom,pmic-glink.yaml    |  1 +
 .../boot/dts/qcom/sm7325-xiaomi-taoyao.dts    |  2 +-
 drivers/power/supply/qcom_battmgr.c           | 86 ++++++++++++++++++-
 3 files changed, 84 insertions(+), 5 deletions(-)

-- 
2.55.0

