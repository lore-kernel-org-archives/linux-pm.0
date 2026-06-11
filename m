Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6234335E1CB
	for <linux-pm@vger.kernel.org>; Thu, 11 Jun 2026 19:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781207990; cv=none; b=lZsNdF4w0BaF0AI3QseIgKNqLlQgMdmDnWAKX/LfNquZlnlB2CW5gv8BiKmDIJnmf/pFYDGZZ//9RXfvTiGCNT63ak6MMQGaW0IznK7/PDAJUeazn6nuAt0yiIc+ZEjRuFgp8zijDkC8fmSWgE80ZcLSYyntXkoPRrB4ux4r7HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781207990; c=relaxed/simple;
	bh=NKtsR5XdWIfUB1XxE8afsrdInrgXv/Ua9HpKAiIdOY0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=imk/nmIKlmOrgUGq5CILcVfIDtBaNICS3WPm4ASLPAUDTNiaIby9V+OrczwDtspP8REhEyJQYyeY7AYe5ixs2/ktn2SuKQ+7nPQuBUTcn4hQrT6JM/MbeceEgsKFKVFTjInuCJkMGw22SxgJYnLsHLekITY75FY3pW6CjkpLRig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=j3+wySb0; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="j3+wySb0"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c85a2ca7bf7so85678a12.3
        for <linux-pm@vger.kernel.org>; Thu, 11 Jun 2026 12:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781207987; x=1781812787; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U0h4xzUab3ln024szbnVLI6NY86oql1mxyDkoL73DcA=;
        b=j3+wySb0jaFs9JAe9lG3W9lvpzmAXGpltVGGh4i6Vzx4pJ9ndvMS3C5DBMrll+teU5
         px3orEpNUXde+gdzRM6nmUQVYPXUWQxdxchraMxBUVALBJJaxHHLJg7Dfz1jgwgxmTVa
         mp2FUiPVBreMegCihBBqOiiU5U4GNbsTyuN/Q/NdfInUl1t3BWTecI1lOr8Ny+c1d18+
         zA1K1P4WnmrVDl65WQAz1k9103fs6SLe+HTvH+xvRsAwHXoUPvqlfiDec+gHv9u24lZX
         CXkQvo4CR+K+HIfwewsyKHm6XfUuHx0/jtpRLymAdbKATCOFVlTSchST8OtLl/uJR/Kg
         30wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781207987; x=1781812787;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U0h4xzUab3ln024szbnVLI6NY86oql1mxyDkoL73DcA=;
        b=U1ztGjqBVwuIg8DVjtzd+pcv46cJJZRXq51oETJWloIgI2XmF2nVLZXZX7/PzdWvZH
         JifNsVJNbmbkt7DwaLXZEZbztTJQCkro3PW0QgqtUOxzNrexvnyzvtonIdJUf79rJNMR
         yJpN1DHi7ZDiy4EM2NH9pNGG34ijoKeB0QzvLFl3m5poLxDhaDlRAd9wxldlYxLwOpuj
         5D9s1a6t9A64vaJvBdrfH8n26ZjsycZBq9jSFZqlNyaQrH27odZXIOkZsCFAcjcG9Qa/
         EwWzdY2BMk0Sv2kJtBuobqHXDXxDKziUkNrztNhN6GrFiy44382Z3U+EoPtgMakgRysB
         88gw==
X-Forwarded-Encrypted: i=1; AFNElJ+Ng8wbqN6uEoy2jnPQ2EEkW6Z8Eqa3vyLEknOBFlpNaGhW6N9YfGXLeoZdJnq5zMWMyvIoyIXDCA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxB1rlgreEq8AhghLK1UoQ2XJlpSOiRZ3UW1bUHpdjwyVKofoSf
	lF2Hmw039ywVOpcmmq6T9EN5SER218KyFVAv5J09do8kqt9iyXR7qjMYpBvgl3CFY9s=
X-Gm-Gg: Acq92OEWGMGhNvFgJ4bjv82cW+O2nIk2QqgSL+wGydU/9wtmK0qz4m/tw3LKjWxt4rt
	zef7ne80K+FhA2jy3lMR3sXsclJoQ+Q/bhli7m7254+kBJf/i7P+yYpepl1FF8v4afAUhGPDQQA
	qs9ycTMOaFbcJF5QUbTVqTXN/qsULBBltie4RZTMWTfp2Akd6iaurkbxd5rW3N3lOrK8TSTkDwp
	ud+3ZKAoafJ0hte7CxyefYX9vUwrnSDEv1081OY+chPLLCWv/CVac5KroMHNo+5wDSYCkoyyNL+
	RFS66fI4cxi5oqs2DgZIm+gyRUFDpTj8T60M7HN3DvQ8OCrdZSfJptcIjG5/s/nfiBiJofJt7Bk
	eCoTeq5pQgFsLQMAZs/TCOiKKBknGybvMGUO0bs2kRdjePRY2q9g3Bxs9+xMqyvFx9qbtZRVE+9
	f629zzyRdk9juHkr0oWGWm
X-Received: by 2002:a05:6a21:b8f:b0:3b4:736b:da45 with SMTP id adf61e73a8af0-3b5e337a66dmr5222048637.31.1781207986604;
        Thu, 11 Jun 2026 12:59:46 -0700 (PDT)
Received: from localhost ([71.212.202.210])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-c8663352fd4sm91236a12.12.2026.06.11.12.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 12:59:45 -0700 (PDT)
From: "Kevin Hilman (TI)" <khilman@baylibre.com>
Subject: [PATCH v3 0/4] PM: QoS/pmdomains: support resume latencies for
 system-wide PM
Date: Thu, 11 Jun 2026 12:59:36 -0700
Message-Id: <20260611-topic-lpm-pmdomain-device-constraints-v3-0-75d69438518b@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKgTK2oC/5WOQQ7CIBBFr9KwdgygtY0r72Fc0Omgk0ipgERje
 nexLkxc6fL//HlvHiJSYIpiWz1EoMyR/VDCalEJPJnhSMB9yUJLvZFKS0h+ZITz6GB0vXeGB+j
 LHRKgH2IKpUgRqKamRVq3tdSisMZAlm+zZ39450CXa9Gldyk6E18I5zhtq9wspXjtThyTD/f5v
 azm4Z+fZAUSlGwtrtEai7TrzP3MXaBlsc2SrD9gLetfwbqAN8o2HTX9qjb4BZ6m6QmAaduAXgE
 AAA==
X-Change-ID: 20260120-topic-lpm-pmdomain-device-constraints-e5e78ce48502
To: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, 
 Ulf Hansson <ulfh@kernel.org>
Cc: Dhruva Gole <d-gole@ti.com>, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2240; i=khilman@baylibre.com;
 h=from:subject:message-id; bh=NKtsR5XdWIfUB1XxE8afsrdInrgXv/Ua9HpKAiIdOY0=;
 b=owEBbQKS/ZANAwAIAVk3GJrT+8ZlAcsmYgBqKxOxzcPVFrgDJZB4tiEOuUlsRVPdyD3ruh/db
 pBuW/FMy/OJAjMEAAEIAB0WIQR7h0YOFpJ/qfW/8QxZNxia0/vGZQUCaisTsQAKCRBZNxia0/vG
 ZTuVD/oDwQa5wCz30kQqcjFiI08h5fnrcLXkX8rgH3zngNj00WKSQpm07SuIOLG+R4eLiJW+gz6
 ER5cWwkeujCQTdLD2ljcNp5xe7bVxZV//WY9YC6OhDNiZJ9X4Hme9NLPBuDskrqvzmIIFmu5CHi
 dUOdzOWVO7IZwms14V/uGQID0whYjuBKL3b7SlHqbCUEEnI7m4AL8aCt1foPL0W4A01RGJTFhYt
 8y6rhYw2bWHQg6z2PDQ1pwn8zZZjvbB+zLH8VhGrrakyp5/2pgHwFk9PN6iY/xlPO+mHSBSGpKz
 dqjKdkJaCGfCa6TZaobIYTf7OoerBn6JEsaMmuqHiGshSxRvnQDXj6C/io8vgP84gbm28BGBg1J
 Kpj5E9RvDtJLKqfXdfh8X1i+B1JKqcx2zkwe6DMiFdSU1uBtZXgJnsyMh/PgTWOgSaCDAizJmX9
 D+o/qEzKMAdzbS7zWVsTvXskkoJDLvsVz4ysE5QOSX+zDd3HywJGeJJY9+ifV90AqQfUo2hh7sk
 rgPNyRmMvhk/2OcVC811JpdcWE/BKeM2fo5IO9UI49RNHScTfa84EJ47Fba+1QQw0daWzV6i8Pf
 JYHzYg74qvf2eu6/OchmhbNcNYgfeCnVtUpkAXXB/vxbQ3PRT46jhWLAGPcW4E8VGr53XrPOLEK
 WH0dc4ALEF0YgLg==
X-Developer-Key: i=khilman@baylibre.com; a=openpgp;
 fpr=7B87460E16927FA9F5BFF10C5937189AD3FBC665

Currently QoS resume latencies are only considered for runtime PM
transitions of pmdomains, which remains the default.

In order to also support QoS resume latencies during system-wide PM,
add a new flag to indicate a resume latency should be used for
system-wide PM *in addition to* runtime PM.

If a user requires a different latency value for system-wide PM
compared to runtime PM, then the runtime PM value can be set for
normal operations, and the system-wide value (and flag) can be set by
during suspend (for example in a drivers ->prepare() hook) and the
runtime PM value can be restored after resume (for example, in a
driver's ->complete() hook.)

To: Rafael J. Wysocki <rafael@kernel.org>
To: Ulf Hansson <ulf.hansson@linaro.org>
To: linux-pm@vger.kernel.org

Signed-off-by: Kevin Hilman (TI) <khilman@baylibre.com>
---
Changes in v3:
- rebased to v7.0
- fix PREEMPT_RT: add new helper for lockless read of flags for atomic contexts 
- update kerneldoc for genpd_for_each_child() as requested by Ulf
- Link to v2: https://patch.msgid.link/20260205-topic-lpm-pmdomain-device-constraints-v2-0-61f7be7d35ac@baylibre.com

Changes in v2:
- drop the userspace interface
- add genpd helper to iterate over all devices in domain and child domains
- new flag means latency applies to runtime PM *and* system-wide PM
- Link to v1: https://patch.msgid.link/20260120-topic-lpm-pmdomain-device-constraints-v1-0-108fc4cfafce@baylibre.com

---
Kevin Hilman (TI) (4):
      PM / QoS: add flag to indicate latency applies system-wide
      PM / QoS: add lockless read for flags
      pmdomain: core: add genpd_for_each_child() helper
      pmdomain: add support system-wide resume latency constraints

 drivers/pmdomain/core.c     | 45 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/pmdomain/core.h     | 17 +++++++++++++++++
 drivers/pmdomain/governor.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pm_qos.h      |  9 +++++++++
 4 files changed, 127 insertions(+)
---
base-commit: 3131ff5a117498bb4b9db3a238bb311cbf8383ce
change-id: 20260120-topic-lpm-pmdomain-device-constraints-e5e78ce48502

Best regards,
--  
Kevin Hilman (TI) <khilman@baylibre.com>

