Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA4A3368BD
	for <linux-pm@vger.kernel.org>; Sat, 28 Mar 2026 01:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774662009; cv=none; b=U1sbMxHGPqqy9Qz/lmp+2xSGrEahc5+uYd8vdVf0HT7zo0OxHMz0mTxvSKwnD97N1sbWX6KKUIhJmcu4HroSY8xh6d7kwZMXzPqDdAgAw3tFhd3WHTe1a4kFTCdRDgj97c7jG47dUfFCqwiZ1npFjQmjuNkjp2/0kutFg6HNfvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774662009; c=relaxed/simple;
	bh=bNBwjs8zbz1FQu8BUOGiW+xvrm4VsfpXadFXmCELexI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bWj3mKHUypW3m014SB7+iVGwEOHYVlEdMIhUAaHe2g78xBpyjKTdDA4cHPIJoAPLpnHEkOwji8y53Se2vdvVD4mWq5tyBZ0xt9g3Y1yUC6AbWR7nbIEuR6Uq69IJ8+h9nFlL3Ncm7nQmdN7rQs3g/d3ZV/ksMIvgdRq4XQN5O5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=srJ0O2vt; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="srJ0O2vt"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-89cd8596724so29864666d6.0
        for <linux-pm@vger.kernel.org>; Fri, 27 Mar 2026 18:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774662007; x=1775266807; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FGtxO9+SfhLV/Gngm7A9OKK9zLf1CSmm7lKaEGRjrv0=;
        b=srJ0O2vtW7b2EKVyy/6FOjURvTmD7lA20LH763WvjfCjSev7wWdfZOnngUVgIlhY+q
         oHkZm0giale2Rgan0PCOjnS7+gF0tm5twhh1q6sOFDny7wTg7AyiLlXIj91lE6lTo3Oj
         JZQ/HGOQaeqHYLr+ya2w9OUVCYYGgwavH4TDEJKQBjyaOX8ro/xVEpXf+sCOjo/815EO
         T0xhsMUZEL2330PmcQOD0DMQDp7aXnhLGcGH7po+XlRyC8S3E+MAX00CrOpFFojMH0Nj
         1qVTUG36VA9PMqiSWIzdqBQVwAfxMogqILfZ/1ZUVf42HlGAK/0I5V9UyjAsp7YNNA3O
         tC2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774662007; x=1775266807;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FGtxO9+SfhLV/Gngm7A9OKK9zLf1CSmm7lKaEGRjrv0=;
        b=WFj5j9BXEOU6renfUTu7G8P0ZBJRqMMEdFMUi7WTwRISO7spjlxL60MG4r+OOwuJD1
         l2lTFkjQFwkubU2GegNpz59CPFyNZ0Isqe+shKLOlVDp5PYC72nH1NI5OSKFwOmto3xm
         xpoEA1MZN1IZeaaDc+5E9i41u7fzOTsK6JLNylzi+Cqb+8llXfXBohfdBlE880Iv/ZaC
         itLMMvrH8dB6QRa3BSFobkHzglCWNB+adlrNQMEYJk0Uy6s0oq3dZJuwXQS1rxReVm34
         Hjf7b5kPbA3iS7h5VZn5wgoBLbQXf+1/wEOC4sTh8AdJelkctqAbVDpE8K5/EmUpdHjh
         MrVg==
X-Forwarded-Encrypted: i=1; AJvYcCVtHzDrxZczUQS05RGB4KkN7UpBLSw9eOAHEIjsjWMKCA+XTdr29JWpCPF+jZM85eQaqhvLN1hFrw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzlLXftXDSSs2l+7jkArhn1kv9gUi0IqUgYngt18K2BsatJYDJX
	4BbU2tZ76TGlKPNJC6jzqlDU0MtAJuTKxkuAD77wg5Cnreav8BMOPLWi
X-Gm-Gg: ATEYQzw40UsnheAB2fbJtDiBTLPOBF6Pf0yHkY47SVHC+VHolyGm8WvWxLOTzx5vMbJ
	nB7y/mV0qTODxOcispYSrKWAMbYty2znr7GgLE3ivXeMb65I9K4xC/TUuz54Br/maoUUthMOHPd
	fSnljPb4sZ5dWdAAatUlCgoP+zUqpzA3272qEznS6yNAaJatK3IEqCISM7qWJ/9lYogD8Rt75xI
	tKyxZBzuGOqrb+I6EETTkY4s4ybjn0c+ER9q9CbxIg8MhSw8ht7Mn/NTUR2FJ5Pd0+oHE15GEbX
	xUI5qs4TbqyzpjSl6ReUv1HSASEcPsKyLSbN85DCkEodMmtGHREE8kp/o/bQirsvIWJgWIdSVFP
	U6DMi+F3BkkNeIDwP4nLQKPiRdSAra6y8HB4DpnH6FkMVEAbvIqY1NEGeyt1qYMc4UqJiwHhpBv
	UHcBziuaFp+kyf7X28o9V+DuG3K04rdFswNkYi
X-Received: by 2002:a05:6214:498e:b0:899:fd8c:55c3 with SMTP id 6a1803df08f44-89ce8d978e0mr74569846d6.22.1774662006819;
        Fri, 27 Mar 2026 18:40:06 -0700 (PDT)
Received: from localhost ([184.144.58.243])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89ecbda4d50sm6474596d6.15.2026.03.27.18.40.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 18:40:05 -0700 (PDT)
From: Richard Acayan <mailingradian@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Amit Kucheria <amitk@kernel.org>,
	Thara Gopinath <thara.gopinath@gmail.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: Richard Acayan <mailingradian@gmail.com>
Subject: [PATCH v4 0/4] SDM670 Basic SoC thermal zones
Date: Fri, 27 Mar 2026 21:40:37 -0400
Message-ID: <20260328014041.83777-1-mailingradian@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds support for the thermal sensor, for thermal-based CPU
throttling via LMh, and for thermal zones.

Changes since v3 (https://lore.kernel.org/r/20260310002037.1863-1-mailingradian@gmail.com):
- support LMh clusters starting at CPU 6 (dt-bindings tag dropped) (3/4)

Changes since v2 (https://lore.kernel.org/r/20260304014530.27775-1-mailingradian@gmail.com):
- remove cooling from memory thermal zone (3/3)

Changes since v1 (https://lore.kernel.org/r/20260210021607.12576-1-mailingradian@gmail.com):
- add review tag from Krzysztof (1/3)
- replace CPU thermal zones with lmh (2/3, 3/3)

Richard Acayan (4):
  dt-bindings: thermal: tsens: add SDM670 compatible
  dt-bindings: thermal: lmh: Add SDM670 compatible
  thermal/qcom/lmh: support SDM670 and its CPU clusters
  arm64: dts: qcom: sdm670: add thermal zones and thermal devices

 .../devicetree/bindings/thermal/qcom-lmh.yaml |   3 +
 .../bindings/thermal/qcom-tsens.yaml          |   1 +
 arch/arm64/boot/dts/qcom/sdm670.dtsi          | 400 ++++++++++++++++++
 drivers/thermal/qcom/lmh.c                    |  69 ++-
 4 files changed, 460 insertions(+), 13 deletions(-)

-- 
2.53.0

