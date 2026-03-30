Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080583DA7ED
	for <linux-pm@vger.kernel.org>; Mon, 30 Mar 2026 16:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774889517; cv=none; b=RIqJsdN3rQ7ayzJOI4VyGCE5D90eGY0l8+8Rd2ZNRW1n8jnhfQkZVObUK6wTCNPD4xAwCxqKeX84YKdaGYOsZtP+OMleRLeqzpxhsutUA522ocxEEFS90J1oe24hoUgutPQZRyEuutGl4ErVcM/hb9MZ0cEBNWL0wuzokCpRSuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774889517; c=relaxed/simple;
	bh=yzn1qwpZMJkPgigRBzeYMyZVhMPbZ4A5hdI7do7E8HE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fq/uAXlbyhwcoekl2Au0sw1REU7g5qlaD30B0m6m/5afOm9icgbaOSl8awPW66Ov2F7RiCVJVJvgf7+mS/ySFzIAqPiKc6oKOwhOvhOZZq6rQFqKjEw83shP38gsmwKgrCgc2uK1z6ZKqbYeagVXJ16/GY6TZM5Z/zIc5N+1d2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pONveiMG; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pONveiMG"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-50b266413fbso39698611cf.1
        for <linux-pm@vger.kernel.org>; Mon, 30 Mar 2026 09:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774889515; x=1775494315; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZIZbf+qqROsD0LmW3EiPB41zllSjbGoJgs0L3HB6kjY=;
        b=pONveiMGnp+w9UO+MaWMRMfxNrvO3StceMz80q21u3D+rqPs4+Y8qXBAcVi60DkbbN
         gFvyOdPuJEn9p8yeC6e+avYQvc2wmB7enQtBNYyE2SE7PmS9rEGWj1TfIIYO4Z172258
         UmqXy3n9VvC5F4tE39Z1smHg326yIZLhswPlQT8yH+MWiR0uwOAbEdgBU9iGbCYuTb6Q
         oy5v+o+0S2hwjPh/du5+WXrLWj2vGBTyOySv6WNvFRe2IZn4i2FGTcuYX7T7PP1h9GbV
         sgZTxsvA2cihVohOKUD3IKFFb0lz20jl2KsNMt2gvfqifMQilGD4L8H3d5CKkt/UK4iK
         rUmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774889515; x=1775494315;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZIZbf+qqROsD0LmW3EiPB41zllSjbGoJgs0L3HB6kjY=;
        b=lMDWlwkhniIqHspqX3NU6iUWjGEKi7X99pu4v84uFtFGDyrO1xW1nOlSA8hfWGkdbR
         ZXlFc36NsaqOXB8kSsMCF5xBBdDPplroSS8bSwCP/5nPB53g0xgtuq15o0dnBTBikjDF
         nEIyRXjYUMiOhY0GcSJiZp3m3Tu34DdNtuH51ST9CGAPt6NN7akWXpJDvqGlJrCx04vu
         eOPIc7TbXlZ7QWyfcUg/QwQw7SB8tVXRdr2Dmtc5Y/RYA4JES0smuHUpJJ+1qS2jnXKJ
         VGL2tH1HsUKyvITTjsqEhIxEnVnTZs1/waIHKRtEtAHPQL4/wz11SZMc7LEW2cJOVQPd
         nHxA==
X-Forwarded-Encrypted: i=1; AJvYcCX/jel7knAOXivoPQ0X3YILfq2vjFZfiQtN8/PqkOrlz4RYAx1d4nObk/NQLIrRIPb8cqApD6Apdw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyN6Mhewk2pAOle8gs7YGPqFgt/fiC1dzvq3yW+kwWXOt0o3MyD
	TL9pU7bk3V6PeXKAp8VKr0QCdy/XqzDObEtDqe7eKAdW9YmfBJrzuVQB
X-Gm-Gg: ATEYQzyyLTvgcrMppNPXbsQ9YlrALITWCe+1J+1ym22y4pNdbtLFlBmmE6z1y6xOz/g
	IkgBBk6UiRnrjBzk7reCAjs8vDwJYWlkYlCGY/39b/nz6lqMaZTuwG5SoOualjTzR3FWFAnteiG
	kmNi7ptA0u3WlSbEoub9nerRGAALqV+otBnbFjV1enFI979hjL49bALELev6wWF75JLfWkI4eYf
	x7//HqWaQfNsgMmKueSX5OSg7O1dGggRiP2AeFW/6N0xglo0HfLKoWWbmG4/bFSMpNiYh+CnSTo
	tiGlZMKhU+nOntpttv2aAhunGsD1+e4xxCYrLr08REbI2fgWCDNr7Pae2vldYwpooIBmbUFEYqu
	Vm+5URT9YlWfbEBsclIYPbVa4wF4P5PvaJNHufhqPf8KDYk9sS1iU9ovrnFnsp2R0ECu70t4DbA
	i/NiCcZLmBIF1yn5OMorntQnM=
X-Received: by 2002:a05:622a:18a8:b0:509:20de:4ad1 with SMTP id d75a77b69052e-50ba3818222mr175000561cf.10.1774889514877;
        Mon, 30 Mar 2026 09:51:54 -0700 (PDT)
Received: from localhost ([199.7.157.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50bb2cc79d8sm68292771cf.12.2026.03.30.09.51.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 09:51:54 -0700 (PDT)
From: Richard Acayan <mailingradian@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Amit Kucheria <amitk@kernel.org>,
	Thara Gopinath <thara.gopinath@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-pm@vger.kernel.org
Cc: Richard Acayan <mailingradian@gmail.com>
Subject: [PATCH v5 0/2] SDM670 Basic SoC thermal zones
Date: Mon, 30 Mar 2026 12:52:35 -0400
Message-ID: <20260330165237.101045-1-mailingradian@gmail.com>
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

Changes since v4 (https://lore.kernel.org/r/20260328014041.83777-1-mailingradian@gmail.com):
- use simple comparison to differentiate between cluster 0 and 1 (1/2)
- drop applied dt-bindings patches (previously 1-2/4)

Changes since v3 (https://lore.kernel.org/r/20260310002037.1863-1-mailingradian@gmail.com):
- support LMh clusters starting at CPU 6 (dt-bindings tag dropped) (3/4)

Changes since v2 (https://lore.kernel.org/r/20260304014530.27775-1-mailingradian@gmail.com):
- remove cooling from memory thermal zone (3/3)

Changes since v1 (https://lore.kernel.org/r/20260210021607.12576-1-mailingradian@gmail.com):
- add review tag from Krzysztof (1/3)
- replace CPU thermal zones with lmh (2/3, 3/3)

Richard Acayan (2):
  thermal/qcom/lmh: support SDM670 and its CPU clusters
  arm64: dts: qcom: sdm670: add thermal zones and thermal devices

 arch/arm64/boot/dts/qcom/sdm670.dtsi | 400 +++++++++++++++++++++++++++
 drivers/thermal/qcom/lmh.c           |  54 ++--
 2 files changed, 434 insertions(+), 20 deletions(-)

-- 
2.53.0

