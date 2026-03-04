Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32BF3148D8
	for <linux-pm@vger.kernel.org>; Wed,  4 Mar 2026 01:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772588702; cv=none; b=Ss8kp7QXYUeG5Y8XZK53yzcc/0LWbvp+f+CMkho+pGf0nmqMuQo6vtB23Ue8kJpWmkFVobsK1yr7OJlynbGe7Aw5K2k6nudDYKj5QMe29Z1614WtoymXMV45lZs7mZX/XECY3tmcFR2uma2PRAaba0OYoBnmAM5pVuuft3z/4Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772588702; c=relaxed/simple;
	bh=nBgkZzIqKNcoJwcAAu81VjsyDufPfFUO0b+QaCipGSE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K8G7ZGq+f/Zpy03WRgemJijjoOjTvIV12iUXZDfPJKRqC422TdUFSlByO3OfE3ZOJCREYKeHYrqAI9OaKaSMWQQnfjkfhyB8bL6ytMlJIpgeeoV3PcGYIThwH40HvU84vCnoTofdJDAT9lB0RHnFsnz2C3B9cGDW3AwuKYHM4E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R5FtPNct; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R5FtPNct"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8cb40149037so650038985a.2
        for <linux-pm@vger.kernel.org>; Tue, 03 Mar 2026 17:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772588701; x=1773193501; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qkCmuU4ExcEJKxqvE0t7QkJXhylBZDtcf5rqRUmv+a4=;
        b=R5FtPNctiX3FbzmHwIhJ15IHyoPIcgAtXsMBIE/VmE8OcWMB3JT8qrhxK4ZR/b60gp
         sIV+e2IvMWQoSnETPESabALk9mKmfHa4HlCYv2UoQUnoFTYNas9BvraAgPYQIOp9Kme/
         YW2JGHnjsnhq6FR/nUaFNdemGc9pF1FmcG9i3rQCmiF98fnKY8BzG0YMdD3tdTk7B8Hx
         iCPZPFJjb7t+ecIikCk006Cj19wz/5sGD40IOTM3rHWs/f2V/pUtktlUU+vHHbFDY8Jh
         XJmVkPqG07WiAZgPDMtdOzn25SyQySQrKKGGLnjP6KT78RJgTXfCZDbUG37CzM0oOp4f
         PueA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772588701; x=1773193501;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qkCmuU4ExcEJKxqvE0t7QkJXhylBZDtcf5rqRUmv+a4=;
        b=PFmmLqC+1FwsJLgQutN4xy7NlJYECUYlmqu9F1i3stwTLFAba6bVy7RBvE4H9YcyLe
         2GVPRFPpTmdfGWaZBfkyRLSiZVSDXR656ieKohuXcKp+YjxLEm3Glt0q+Tg8YW0fnlSo
         VaqIYFzFlnTH17v8bz6Zky9+dZEoC5+La2X3tPv/UcmFZxtboeFERg/ZHcXcBQxJJPcX
         bQgP9QsP2wlFt7QzzozLY523N58m3FbEJQs+son0vBi1jHDBQH5NmUQTx9svpBWpiXjP
         pe2V0tZaxFa8dM81ZZv+UK/rBYxqxqR79IlHffi/KBiFAc3brbV83+Vgh9wTsf8L0CZn
         u7Mw==
X-Forwarded-Encrypted: i=1; AJvYcCWKiu5JsV4a1YpO/3nMTV0Ec3a8NxyJfXDdQrWyIqyyNNQPzcX4/ty4WyPZhT/A6s7BtwsZKkc8ZA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyEZiZ9reLfYmfiD6ZdNjXZPU780T5jRHNPyldx/U6Z3CPjjsAf
	yxlkJ8BlW7nL5umzHOqFjXAMpDbd6y4aEPi9mY58jmgT+fIYTr/O7+OI
X-Gm-Gg: ATEYQzxX6oUODP3dSJmIcTsSiK5EcS75UnlP2ohZyz4AS7OFzjmcNZTuWw9s4ZRvKNT
	vVwvkhQNBLLYCP7ZXzCLLyoMp69VlJjTgw51vPfErdPSNN+C0jiXTDwr2idwHu8/ffG10su1Nfd
	hiMhhPOsGZSs4Q3EXPMY5Ugz5MtRnkpvVIOEJz8bksUk74LtIxm50jGrh+FPrKa/RmRUxtF/khK
	ZZVO4AmVKH1A+HbqD75tGBBbpQXEvYNkUEUd/PqaWuLMcEYrv0SP2DW3ZY4RO6SWRKPJJjrnXfI
	6CtYNNWOKkOoRmVyKhBEHBJxuaLKghXaSPW/aK2wedPEJjgPZV/50YEFAeVql4gnzmke/+tIBpj
	wZm9WiwBTtEdl6ZMZO3Z5RXqHpHlW/8ct0YbaG17z7lD3XQG4QfAbq9BVij86ri/tiSlpOanMhR
	H0tJJQtMk4GvwlQCFSs4SH5RcEig==
X-Received: by 2002:a05:620a:1a18:b0:8c9:f8e5:9f12 with SMTP id af79cd13be357-8cd5afa4e85mr64053985a.57.1772588700602;
        Tue, 03 Mar 2026 17:45:00 -0800 (PST)
Received: from localhost ([184.144.58.243])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf6f5c41sm1495846685a.24.2026.03.03.17.44.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 17:45:00 -0800 (PST)
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
Subject: [PATCH v2 0/3] SDM670 Basic SoC thermal zones
Date: Tue,  3 Mar 2026 20:45:27 -0500
Message-ID: <20260304014530.27775-1-mailingradian@gmail.com>
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

Changes since v1 (https://lore.kernel.org/r/20260210021607.12576-1-mailingradian@gmail.com):
- add review tag from Krzysztof (1/3)
- replace CPU thermal zones with lmh (2/3, 3/3)

Richard Acayan (3):
  dt-bindings: thermal: tsens: add SDM670 compatible
  dt-bindings: thermal: lmh: Add SDM670 compatible
  arm64: dts: qcom: sdm670: add thermal zones and thermal devices

 .../devicetree/bindings/thermal/qcom-lmh.yaml |   3 +
 .../bindings/thermal/qcom-tsens.yaml          |   1 +
 arch/arm64/boot/dts/qcom/sdm670.dtsi          | 474 ++++++++++++++++++
 3 files changed, 478 insertions(+)

-- 
2.53.0

