Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E7930FC36
	for <linux-pm@vger.kernel.org>; Mon, 20 Apr 2026 23:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776729086; cv=none; b=g7Z3Hd0QhGn/UV8XA3mr+er1iDlnlytIPMeMj8Wr+jIKKWblMrMwmIUvm1JOOSz1tIi5HggBiO1iyYNiQy9VKfRrM8MgAQoRGMI66A3oeuY+T5XyLubiwZKH+nm4qUngre/x6pxpRIAoXA3aWBVLvHUKavYUyx2gnbhTa1jhQKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776729086; c=relaxed/simple;
	bh=6WxIAiLE/9LRIR82Mb4m+MqABJehEcnrKw/oRJbTM5c=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=NmcgmuB7CJnfuUMJk3WNaTnRCSe2kSduDXJJ3tjGzp1VesAE81cCrVU6Q6AB9r9EKuFKIqV8a3uTpM8Xf1WpaGibXGmTZmnNjCTwdSrBAqkQHcey6iqQ3cYxydAwf7++mGpeIkn1IH+01fL/6jTy0DKHYI2Ip+hNiJ4+oU5kSnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=i8S3oNFD; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="i8S3oNFD"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-82f9fdfc965so1134871b3a.1
        for <linux-pm@vger.kernel.org>; Mon, 20 Apr 2026 16:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1776729083; x=1777333883; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ufPgVDBbM9kVZQF2498czX2rJ62DJlm2iNO99og33OM=;
        b=i8S3oNFDb8Wf2zaYuniuZNemMlENxjP0bENoz3dqycrjWA2sxEQf5QrPv6NbUsJyBh
         sVwcJErm33yTQbLBUE9QlOiINDy0S3ImTFS9nQ6auuMnhmv9oZ/zCmFB4zmMAA5MVxpj
         LSqTxVSkwgVZJVYvX6po5VdK4S/6DH1i45qL+Dqvy79H+KUWKkE8iOmOxICIyYI1stlQ
         mr1hsi+73NAcKMyV78OT8UDqkA+qVVgL4Lma9asf6Ah418tYJeWB6K2nlUwDHAN/NNVH
         LixA8UlmY8dTGbtqXEdhSVpW2jK6B7ol9Os3RYO1arbsecG6odEydlxi0JbYcvt0LWc0
         fJiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776729083; x=1777333883;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ufPgVDBbM9kVZQF2498czX2rJ62DJlm2iNO99og33OM=;
        b=IEb8LpjbyJHfhe0E8IA4SL2o9BS0xsQFNigH856VA47Ki1T8lXmSxduHKv9yRdm7Nq
         Z2c5QfYeCaotRAocO2YIIbFl/2KFr48qJzUjEaxr6cccY49dCvhvAUPwTC0U+/9m+8yW
         7HB7dKpNUcA4OHbgJMbaoFpXXF1WQrMOP9qgdsZthd/ptBY4EFbE1kXcCda2DWCrmRgI
         6sv6F3F0PVUmRgAY4UVk/Eb01yx43oVuu9Fo8XyfrtdMFzlILl/CQp9hJbNLY9Vka8XO
         cC8qq0Hw4uFOlok5718G1vdDYNjzMN01X+51SG6Ii+DYuSVItWxozFzPOPZ/pA6Ceyk5
         d1pw==
X-Forwarded-Encrypted: i=1; AFNElJ8oY+Im1oxYxLWQU+cMZyv/TpCav7G0ABai0q1Ge8z+zOeHLxUqFS7S/3kmEqCEDTfAIQnnQaRIzw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzKg7HoqhpzDBzwrI8VyRksxIy2l9fQJePp7vrRuY6NTgwQYe0p
	2jPTau8EYASioUjlTklZx3tKqCGjxwZ4mMb5fuc6Eov8Bl/9BCE7SJVX2OowlCCPhrU=
X-Gm-Gg: AeBDieufbObpE7K/gxSarwhxvmnr09aub4x+5c23ex6WxSMcapzvgCRcN/c7ygG/CNL
	dcLwrhM+ahHlrB8bzlx9MgN5RG8xnRxbgMGuOvchlEW78ZGAbiWVdWCkB2kfhkTZwsHtITzzsir
	FTpk7eDc0Tdno4i1vxA/qphobngBOEEiWtpXj6EwKbmnoKTMxz3yIg5kZA81ruagxPOVcU2U8dp
	C89V6yUSE1jqZyvvblYkBe1vPmLz+/25lVKuDBOJZcMWZuriClmXWK6jkUM4oPCdhHlf91ol2jt
	Pk8HswQWHgUwDYFeKnRisCtrAQHQlKpyJEuWrjsrPLBDXW92gyvVIAqA0NobGItRUSXBq02aoMW
	CUyKNEMsqYI8JZuhl/HI1LTgfqwBnubB+ERIFu4XcocYcO5OyOfefgP5DVMRp2/njixG+kS4YvX
	sDNWl0uxnwG3e86VWcBs+5V4JlhUT/WA==
X-Received: by 2002:a05:6a00:3496:b0:82f:52dd:4446 with SMTP id d2e1a72fcca58-82f8c9cc390mr16844270b3a.45.1776729083514;
        Mon, 20 Apr 2026 16:51:23 -0700 (PDT)
Received: from localhost ([97.126.187.42])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8e9d2fa9sm12324138b3a.16.2026.04.20.16.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 16:51:23 -0700 (PDT)
From: "Kevin Hilman (TI)" <khilman@baylibre.com>
Subject: [PATCH v3 0/3] pmdomain: core: add support for domain hierarchies
 in DT
Date: Mon, 20 Apr 2026 16:51:16 -0700
Message-Id: <20260420-topic-lpm-pmdomain-child-ids-v3-0-c2c40bef238c@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPS75mkC/43OQW7DIBAF0KtYrEMExsYkq96jygLwOJ7KGAcIS
 hT57iVOpUrdpMsv/Xl/HiRCQIjkWD1IgIwR/VyC2FXEjno+A8W+ZFKzWjLBGU1+QUunxdHF9d5
 pnKkdcepLL1IQfdtpaDvWMFKIJcCAt43/PL1yvJovsOlp/jQCXK5lN71qxOgI1HrnMB2rLPdck
 efpiDH5cN8ezXxr/u+nzCmjrZBcqk5zNQwfRt8nNAH2ZWWzc/3rNW+9unhKiIOExrSDMn+8dV2
 /AefA9htWAQAA
X-Change-ID: 20260310-topic-lpm-pmdomain-child-ids-e3d57ae57040
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3250; i=khilman@baylibre.com;
 h=from:subject:message-id; bh=6WxIAiLE/9LRIR82Mb4m+MqABJehEcnrKw/oRJbTM5c=;
 b=owEBbQKS/ZANAwAIAVk3GJrT+8ZlAcsmYgBp5rv6Rf/zytON0i/RmuShXkpqsPFc/gGPasid+
 /3oPG9tkoCJAjMEAAEIAB0WIQR7h0YOFpJ/qfW/8QxZNxia0/vGZQUCaea7+gAKCRBZNxia0/vG
 ZfTVEACfWnHioXc95XXtaqx6QRy/RYoNMGYwwJQguRkSnNMHV6zscT6TciPxDi1Q5gXr5AIdiBu
 4M+C8XiRKN3+EnnsRnKHszeTAO15Y1UOSJRhB5gcaEVj0WfVMBK6i1ut3GJtcFudnV0ytQt8HUY
 ahctQg8nYMyAP4B4JWAGwAJ3lMUXm4RLPEKsILBM+2vZ2TGx4xLpPNSZNqv4I9swsW+CHUmDA0b
 1paRmlmFS2oRiB+pQn9buKKflpUDq7Wvpm/V62QUBjJt4iSQsUVv180djB9J36ygcZ/NJiKR1/F
 mkR/Re8ygxw5KyWbfi6RMSzTciGbH7tRm4IP4bxWq5umYuAoTIwdLfnwIwwcpNqhQ3joIPgCupZ
 F835lTbFS1JgxUYPHYeA+iA8u6wsdSd61u/M7ZdOf51AJaO9qSZCQekxR+AT8joe3dLyC1Uxlyw
 4HfZ+td+PFqA+NEzWgXP+QfvoQuAr0VsrQtFZ2OYY7fNMNnFl7/SrMFJcwGsD9n2kHvCmpf9cXo
 alpU14tukrPoBKa3x0gM0GrrdBV9yee4sc/y097c5UHkzHeqCkkhPzaaDJaWzJyBu348KpvOTc2
 /TCsF3YhMcutog7n4MNWbwigLxdMQVInMLTIjZ036/9l88aJDv8fhpxMU3aU2TXeNFtci0wh+zc
 Z1h0TtbyeS3bgfg==
X-Developer-Key: i=khilman@baylibre.com; a=openpgp;
 fpr=7B87460E16927FA9F5BFF10C5937189AD3FBC665

Currently, PM domains can only support hierarchy for simple
providers (e.g. ones with #power-domain-cells = 0).

Add support for oncell providers as well by adding a new property
`power-domains-child-ids` to describe the parent/child relationship.

Also adds the first user of the new API: the Arm SCMI PM domain driver.

Signed-off-by: Kevin Hilman (TI) <khilman@baylibre.com>
---
Changes in v3:
- cleanup return codes for add_child_ids()
  - < 0: error
  - zero means no child domains present
  - > 0: number of child domains added
- arm_scmi: adopt to new return codes (only <0 is an error)
- Link to v2: https://patch.msgid.link/20260410-topic-lpm-pmdomain-child-ids-v2-0-83396e4b5f8b@baylibre.com

Changes compared to initial RFC[2]
- dropped RFC
- rewrote the parse/add function to use iterators/helpers from of.h
- add a remove function for cleanup
- use child domain language instead of subdomain

This idea was previously discussed on the arm-scmi mailing list[1]
where this approach was proposed by Ulf, and then an initial RFC[2]
implementation was made.  From there, it was suggested by Rob[3] to
use a nexus node map instead, which led to several more versions
attempting to implement that, culminating in v5[4], where Rob and
Geert then had second thoughts about the power-domain-map approach.

Therefore, I've gone back to the approach in the initial RFC[2] to use
the child-ids approach.

[1] https://lore.kernel.org/arm-scmi/CAPDyKFo_P129sVirHHYjOQT+QUmpymcRJme9obzKJeRgO7B-1A@mail.gmail.com/
[2] https://lore.kernel.org/all/20250528-pmdomain-hierarchy-onecell-v1-1-851780700c68@baylibre.com/
[3] https://lore.kernel.org/all/20250528203532.GA704342-robh@kernel.org/
[4] https://lore.kernel.org/r/20260122-pmdomain-hierarchy-onecell-v5-0-76855ec856bd@baylibre.com

Changes in v2:
- dt-bindings: fix warinings from make dt_binding_check
- scmi_pm_domain: switch to dev_err()
- pmdomain: core: fix locking around add/remove domains
- pmdomain: error unwind if any children fail to be added
- pmdomain: fix node reference leak
- pmdomain: ensure power-domains and child-ids properties are same
  length before iterating
- Link to v1: https://patch.msgid.link/20260310-topic-lpm-pmdomain-child-ids-v1-0-5361687a18ff@baylibre.com

---
Kevin Hilman (TI) (3):
      dt-bindings: power: Add power-domains-child-ids property
      pmdomain: core: add support for power-domains-child-ids
      pmdomain: arm_scmi: add support for domain hierarchies

 Documentation/devicetree/bindings/power/power-domain.yaml |  34 ++++++++++++++++++++++++++++++++++
 drivers/pmdomain/arm/scmi_pm_domain.c                     |  14 +++++++++++++-
 drivers/pmdomain/core.c                                   | 167 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pm_domain.h                                 |  16 ++++++++++++++++
 4 files changed, 230 insertions(+), 1 deletion(-)
---
base-commit: f7b88edb52c8dd01b7e576390d658ae6eef0e134
change-id: 20260310-topic-lpm-pmdomain-child-ids-e3d57ae57040

Best regards,
--  
Kevin Hilman (TI) <khilman@baylibre.com>

