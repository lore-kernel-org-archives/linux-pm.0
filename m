Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0421EF09B
	for <linux-pm@vger.kernel.org>; Tue, 10 Mar 2026 00:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773102009; cv=none; b=EecqhzMlttdVnbWmfvci7X6Ya/UEbn2raHnVvAkzDi4vBpGkAfyMXaU5Ch3ScaOxJjzWbraoyVitqmv6SxCZyfdPRkkYHf70Nq11x7gNUnz9FHD9RLdFKmi+PgiFU6pdnfBTBHnkwsR2HLqqDxaFozOIjhh6Y6ZAf1yqXbQEQF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773102009; c=relaxed/simple;
	bh=pQS3+oY8uNxbqu4m+QxhwxvnOL2GT6e9/8qi7PByaVk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AnDUl3viPREWHqoGNP9psylzsaoTyyzchS3YqHKDARNx5rDGVUMokWfFQIYyNmA2+rAHDIxzYJqoxmVnO6usc+uM10nE1E9zNwr4/USs8VHPD/XlEizSy8JPVoIzrwEBOk7SOh1OUZlj7kfIRhrxTbaELv+CvTTJbwksnLXmXh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nXnJ6NyY; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nXnJ6NyY"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-89a0ecbc713so90551776d6.1
        for <linux-pm@vger.kernel.org>; Mon, 09 Mar 2026 17:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773102006; x=1773706806; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R7YDg569U8MvXHa3jpNDu2jY2nnLQu1AklXEVajo+6o=;
        b=nXnJ6NyYMAQfj0ew3WW7lOn9GjYTK4YmJWCZMWBQHwhkdqIKiuWv8Bg6GMyTBDj+Kl
         bCJsRmD/d1YWRpyetD+qm31bx0RQvf4siJGpJl9HxjyAH6yDVe0san3m+wmCSY4Ydydk
         ixBV58WswuYjfzi+PLsl1yIrgksYswzi8r27me+QrSPIpx0S4Qh/hSPng0WLSrmIicxq
         QtQ+PWIoOPgshv0bP85NJFxhjt4sAvt50mVNqJJ5H52sXPTCL38m/Fz4PMuRBAiZwy8m
         l4QXVPgafnmiL4zH8GOujmD4BD2pK2UYsDoJv9bqKuprSeiesKZpAyWfSR1M9LWGl2ra
         BARg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773102006; x=1773706806;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R7YDg569U8MvXHa3jpNDu2jY2nnLQu1AklXEVajo+6o=;
        b=NEbYiPLmUlu6SB31MKaghZLALqA7sPv8LCMFbYPceIAcePTqm5frsLQvodcGPRskJy
         aRS/4V07lurD0lzKRTmjW9Ig14rt6XJJsHK8m3D+d6Iq8E8Xfn4rN9RK7mZBVVZH3D5T
         D+3jbYnwWJ5hKaJRbTSiwcCRHdEsiFX9MB0GArg7IlfW8KrWkhvDDgTt0UtnJNevgAlI
         P1l/uMtT8ALwMbwco4sN3BN4Dp4eEha8p6hywKHyvhoPogqFx/X3sQAdEbgSUpCMK5kd
         8bL740w5mV9G2qt0Zxn1mIZ9x+37jk6Y/Rv9Eg+LQ0/VDSzJlEm1RNlGggZhifdFpbmh
         ADUA==
X-Forwarded-Encrypted: i=1; AJvYcCVg5HcOHJI4adP1ZNkRzcYKdgO/QTOpnkrl8JcSgD5JsHIzRuLQa1iH6ZwM+Q1E+MDAlaTKg3hUeA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwLhy02ftEzuIgh8Qn8Thn8qGjY0DFyYMJFIoGj4fjqBKeVL72+
	bG1YXyuiPMJCkcvWhHcQ4tQj5etYgn6b/xlHjolgmqxqHFnniCePnAh3
X-Gm-Gg: ATEYQzwXV9gNbBXrkfCXI2V7oQP1Gl9/muDJ5lMZ86JcEkNrR8c0TldwlEP9lpG20XB
	Vt2Uz1dpb9bqkkThcQ0LTnOaE3RFOTYRR0LhQC/DKlgG42WhQE9NAI/foPU1DLYOwtwsX3hywV7
	2FCJVzDGE5pZxv02tbbrd83HgqIn8wPYPziYvzVz7jyrrGmwBbqm2AR8OvOVMq98QQUUgIEfKj+
	unSTw6o2fsQ5rB9HO002a8lxjs0n95/iC8ARjYT9B19LRZxdB9/M6btiAtv3+FMYec+MRr4zsNG
	ucBcM0khwRTrY3rVulyEPM4GVtzcD7YjISmtckk6syuTMcQ3JkWtErY+cv7/FTAqxsHvckjZDHC
	K9p/qmhVOKwKXeJgRGrPXkfojuqCwQbjHq7ZG2nZCgk1xS5um+CRRJ1lfoKyzL70jw2H5yI70HX
	uz9mjxt3KKs2N83068e4XfxueTzQ==
X-Received: by 2002:a05:6214:40c:b0:899:ef7a:2425 with SMTP id 6a1803df08f44-89a57c8e7f3mr22310986d6.22.1773102006171;
        Mon, 09 Mar 2026 17:20:06 -0700 (PDT)
Received: from localhost ([184.144.58.243])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a57a3a9a2sm8380336d6.15.2026.03.09.17.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 17:20:05 -0700 (PDT)
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
Subject: [PATCH v3 0/3] SDM670 Basic SoC thermal zones
Date: Mon,  9 Mar 2026 20:20:34 -0400
Message-ID: <20260310002037.1863-1-mailingradian@gmail.com>
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

Changes since v2 (https://lore.kernel.org/r/20260304014530.27775-1-mailingradian@gmail.com):
- remove cooling from memory thermal zone (3/3)

Changes since v1 (https://lore.kernel.org/r/20260210021607.12576-1-mailingradian@gmail.com):
- add review tag from Krzysztof (1/3)
- replace CPU thermal zones with lmh (2/3, 3/3)

Richard Acayan (3):
  dt-bindings: thermal: tsens: add SDM670 compatible
  dt-bindings: thermal: lmh: Add SDM670 compatible
  arm64: dts: qcom: sdm670: add thermal zones and thermal devices

 .../devicetree/bindings/thermal/qcom-lmh.yaml |   3 +
 .../bindings/thermal/qcom-tsens.yaml          |   1 +
 arch/arm64/boot/dts/qcom/sdm670.dtsi          | 400 ++++++++++++++++++
 3 files changed, 404 insertions(+)

-- 
2.53.0

