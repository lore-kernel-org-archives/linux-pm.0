Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F02258EFF
	for <linux-pm@vger.kernel.org>; Sat, 28 Mar 2026 01:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774662033; cv=none; b=Mxeeu0uPSamU/REliXrpOX158co55ygRMsHGpV4H1j/hoCyNGzkSzWB1SFAK6LO40LJE3+yvSIqmEPAMpgIZnitdWj1nDJlrBu3L9Aw1i+wIbJLagxcILRmXk9CS3w/ONp6Wql9R5m9YVu4VCKrdOCJEA8/U2nReFMcOaQAAFhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774662033; c=relaxed/simple;
	bh=YKU/DnmNIxKk/G4FaBPJrYaaIFx5k+4NkZwdBNpIKdU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hXJh4x2Qhop2h7nLji8boHa6fUfyiikkbLbVpYKzhxBBxxLU5g9qKqzUDPlmzTajtWKx+7QZilXWWjveE6YJ+bIO7EnpVo7IlnQL11kwVsDopaVhMeuQM2t5P3/AzGXxy5w/Gr6BYLhFpDLZ2coQ4Ue0oNqB4EBtFzSNKT61B4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RDpfsk8h; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RDpfsk8h"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-89a000f5adeso40158496d6.3
        for <linux-pm@vger.kernel.org>; Fri, 27 Mar 2026 18:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774662032; x=1775266832; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fMK0diFp+y5MtkQk4eP+T+xRtrAK1MN5VxTGJH3Ujrk=;
        b=RDpfsk8hWxIWsHxjL6W0kYjPUu+r37UPgSDgPJNBsU7h1sKwTEOpLbNQ7iOzWS5jkW
         NZqzBBnPYlZmK9T7VIudNhZE3AAIPwY5pASu4/ROS0BzlnaVaD5SsCZnxrt14dgY/q0z
         2S3HOUevslJK7nGrlNTm7vU1c6QDDn9b9u8k3eI8vN/7IymnmZqUwFGol3AZW2NSiOYG
         PskScbo9Ml+KUS/vmQpLlpVRVc61wO8pbQQaSe57S/vmtdfLII/meLw6W67bxvI0MY8e
         7uh94qFTW4rT4IefRa3FHR7L+xRSiQgypTWXwrgPF0SaYYgMDHcXNcvra5IPHRVgh7FG
         GyXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774662032; x=1775266832;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fMK0diFp+y5MtkQk4eP+T+xRtrAK1MN5VxTGJH3Ujrk=;
        b=Ubg4CtQ053fdQZ+i4+y1RcWuCsLfRuDZX5AKyM752lqsRj849oYUJ+MDJHnTGfBDSf
         VHVKtlgI8rk0kBrvxC0RfXNIT2aiZxxh50wr40ZG+CAKIQy6spWanFlX5T2aRsTJT0BV
         PFfnXkicJgLVgMZrQw373RUkAPEsA63oGXMQ8s331yC0nOA5/dnTHZfPRsc59oUqshwZ
         MaF+dSd7+kAdggGaci25jIta8TEhN/hrBy7XHqhlppPvy+UxPYZ6fN2FeImXUieOLgHC
         XOw4HNdP0mBMFsGLKBt4mSCkB5czNDGgAyRtuFnQysVrP67DfNH5iFld1q9FMHp26gpy
         ydqg==
X-Forwarded-Encrypted: i=1; AJvYcCW0jvd7fhfdR7sIgXyrti+1BwFSoRNSoC8tbBdfvx6q1jslU9Q7ZZPykGfZklMkCdkuMt3yQjBriw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8Z1G93pVVnFGWipYrZmsKa+wG+/xpbbTQ+Nb3S68P53pmjmuK
	jI6wui5mZsVLcLrXC51ARAqSJZAOtzcNX7NvITGB46Xfb9Gsuyx3UYqV
X-Gm-Gg: ATEYQzydMC2uMExI1Kr2zo+r0nibqkeCZmgQ+Nyl+iBpAimltdX+IyfBFDdGaLHV4aG
	8UkECgFj7bbRrGVkFy5S5gx6lS5e7YvHr2uPgnSWedlUWThT+QZK3UntJSWgg54mvjdalV6pfYZ
	gKNRz6JlbRIP9oaG3KdxYJcesAvS++eXHxz7cdtFrB5icADbKBwah40YRbnP2pmZCa2MjmciFfy
	hBFZOjONL69GodpG1KGv+H61VV9uPSMomx5p8cy8uyUCKpZwuF/V8Lk3VWE17AE7KNI7gqdzWeb
	Yr0bspah6Z0+xS0FzkICug+FaCpBkhBtDwsgMmcapdD5eqsEYmFEVofXzngxAU/J89ioDLMukWk
	xKv1iKjMb2w1bBV+UjukcciUuT6bDt1zukpvRVVMJ3q+dbnCdmpJBRMoN/w5FKhnENTXkMxeJ0j
	RNX/eI3Ce/W1p5sT8AlX+wPAu5EzmHnMIG32T9
X-Received: by 2002:a05:6214:f2b:b0:89c:df61:7a10 with SMTP id 6a1803df08f44-89ce8f02e4bmr68450336d6.58.1774662031691;
        Fri, 27 Mar 2026 18:40:31 -0700 (PDT)
Received: from localhost ([184.144.58.243])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89ecf95f3c1sm6396276d6.40.2026.03.27.18.40.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 18:40:30 -0700 (PDT)
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
Subject: [PATCH v4 2/4] dt-bindings: thermal: lmh: Add SDM670 compatible
Date: Fri, 27 Mar 2026 21:40:39 -0400
Message-ID: <20260328014041.83777-3-mailingradian@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260328014041.83777-1-mailingradian@gmail.com>
References: <20260328014041.83777-1-mailingradian@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the SDM670 LMh.

Signed-off-by: Richard Acayan <mailingradian@gmail.com>
---
 Documentation/devicetree/bindings/thermal/qcom-lmh.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-lmh.yaml b/Documentation/devicetree/bindings/thermal/qcom-lmh.yaml
index 1175bb358382..ce72347e29d1 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-lmh.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-lmh.yaml
@@ -22,6 +22,9 @@ properties:
           - qcom,sc8180x-lmh
           - qcom,sdm845-lmh
           - qcom,sm8150-lmh
+      - items:
+          - const: qcom,sdm670-lmh
+          - const: qcom,sdm845-lmh
       - items:
           - const: qcom,qcm2290-lmh
           - const: qcom,sm8150-lmh
-- 
2.53.0

