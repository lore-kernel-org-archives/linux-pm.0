Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B933783C7
	for <linux-pm@vger.kernel.org>; Fri, 15 May 2026 08:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778834970; cv=none; b=opYquC8UaP6AKa67ixlnktFONElHJyKaLcKDzK9ifRXP9o6tufoeBiTo44VGCoa/Z6cQiN0L+nr6UznHetN5imNrV6hVdoEjj2RfmLZZBgPkaD6EC4NdipnKWni2+MZxAp++3lhF7I/MpgPmQ9DyTLqB14xFdWr9Br4x+1sNGpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778834970; c=relaxed/simple;
	bh=UojO1EoI6P1vrhd85fsUzmawA5cTX8ly/rRizMh3c28=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=H5W2cdVCabIRKhAse5YJiA6m+ZAIuctwHx6IrGbHQcN725mOPTw+CiR6/jeUhckFewg8TqrzVnlEgA9Q2CE1NZYE/Oo+UQBEWXF6PdupyeSbhMHkwSmueFY+XK/cY5IZzyGhQb5qTpT+r58j0WV5FPdh9SN3+bCdMLcebgASsis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=AR5MluAU; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="AR5MluAU"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48e6db3ff7eso38466255e9.0
        for <linux-pm@vger.kernel.org>; Fri, 15 May 2026 01:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1778834967; x=1779439767; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4Nb7Qe0kdVXL4U4JyJkcRncQBABfAEBAmBW/cBK9axU=;
        b=AR5MluAUGzTIL+ArY1m0tlWgk0PLkB3qqIV65OpkRQorRpORvrPcIcBeX2Eqlv5Wnn
         D1slem4qYyNzgxQrNnx2KLukfd1sSLHK3H5htykSQqCkhM+yQKDqORkIss4VfB7MoE/G
         Zhm7UqEXnhe5584EfzidJbUb5bdMlf7D3JJiKzkA45Y6YJjNHjezDQs93Qh+E6CQyAKa
         65YYkuziCOsTY+osKjR9hDeWtcL014IfYJig/OpOfJGijIwVRreMu3UcxVBDOECaLDs9
         T5gHSgVXfl60gocKZAnMvFweFXekJr5NsTPMqsRLqt5RscJO1BT+1Z6WjwtstlQtjsOK
         dNFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778834967; x=1779439767;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Nb7Qe0kdVXL4U4JyJkcRncQBABfAEBAmBW/cBK9axU=;
        b=loPEekNdJowYAOLbKhtOb3SVt0X/QRwqAEij3fcgFEn1LrM4fN5GrftXENviZ/mmv7
         X6n8pchmgv0NwDJ/Be6/a+zw7uO1Hes9fly5Er/vsU1P1icyFpYa4yW0TeBQTgsBSsj1
         7K0LxL5r2Rtqc3U/Y1AbPKTFOYIDJxRinSQD4IwQDC1pYXPNIYBYsDVXH+y5QEGApfoN
         Hzip88qJ8nHUPCzgP03nu80Njbpb6mO3FO1r1XslXNcPIDAe7fGR0+hOK9DH4tAgPai+
         C4ch1Jc+q5uwU4Y5wogfWItLQb7n6uj7aU6zdJtqh6jQSrGKSAGZ85jfXCv0B9AljoEm
         N9WQ==
X-Forwarded-Encrypted: i=1; AFNElJ84QXTN0AJ7MdIfd6j3RBKy5EgZnjvZSE4B6E7YBTyHcUnLjrxpbVpdtCSdtk1S3cf4p4Rp4/1aTg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwApZ74y0Zg9dJqSqAXPyg7zojfzxOEQt8HlksfFCqdJWTQRb13
	XEQeBnBw85BzpMxZXU6fkU7WflYXsfNl5NEjDhlBYKsUfzo1UdxXZvwDuukJq9r96CI=
X-Gm-Gg: Acq92OEzEc9DweKY2S77wH/gN5H8GbiS6aEY9H1HB8t0AYwggGG8CFv+HJxYqdGVQ76
	jZ+bC6T7dBNFoQ8KgGzXouLsGmWG1tMihUiuTx0hT5ztYFzI3oJRHO/u2pcuyfbG2V/1JVT7gxJ
	RIo5DSvkt4iDEQ6kI+NUVgssNxiZG/OvYPZEKMykOD5OF+bkQDwuATYJ80Am7wjTHD7N80XYn/G
	52Ia1EfgyHT9fru0BE0Pu+h6n/BqrOJlxAflT3FJ1nhPklMmB8DtpVjiYh7b4sZV0IFa/fyYjQb
	maXZW3ntUVnpM3Jnc48TAOtkKMEKg1x1KSprNw9nL5qhMYiUtT7aakP+qFKBb5d/M9LNDb+zOiU
	iv5G+4ed9ReEcjueND9aMmxfYDsBTvXeXcYsGoA2pxjrci2/YxDvGBNNMvFQsGoOWiJhx+PNzkF
	S2tckRvPRF6aAXOwGIOcmlMRgkVU2oybL5JfZy1NJtoV/FElGZLfjMQZa4XQ==
X-Received: by 2002:a05:600c:a406:b0:489:1aed:1658 with SMTP id 5b1f17b1804b1-48fe632a9f4mr33070675e9.23.1778834967106;
        Fri, 15 May 2026 01:49:27 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe5694fbfsm84997545e9.6.2026.05.15.01.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 01:49:26 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>
Subject: [PATCH v3] thermal: core: Add WQ_UNBOUND to alloc_workqueue users
Date: Fri, 15 May 2026 10:49:20 +0200
Message-ID: <20260515084920.70544-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This continues the effort to refactor workqueue APIs, which began with
the introduction of new workqueues and a new alloc_workqueue flag in:

   commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
   commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")

The refactoring is going to alter the default behavior of
alloc_workqueue() to be unbound by default.

With the introduction of the WQ_PERCPU flag (equivalent to !WQ_UNBOUND),
any alloc_workqueue() caller that doesn’t explicitly specify WQ_UNBOUND
must now use WQ_PERCPU. For more details see the Link tag below.

This workqueue has no benefits being per-CPU, so make it unbound adding
WQ_UNBOUND, removing also the WQ_POWER_EFFICIENT flag.

Link: https://lore.kernel.org/all/20250221112003.1dSuoGyc@linutronix.de/
Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
Changes in v3:
- remove WQ_POWER_EFFICIENT: the workqueue has more benetifs being unbound,
  so just drop this flag and keep only WQ_UNBOUND.

Link to v2: https://lore.kernel.org/all/20260514142511.325446-1-marco.crivellari@suse.com/

Changes in v2:
- "thermal_events" workqueue has more benefits being unbound, so instead
  of WQ_PERCPU, use WQ_UNBOUND.

Link to v1: https://lore.kernel.org/all/20260514132901.275477-1-marco.crivellari@suse.com/

 drivers/thermal/thermal_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 2f4e2dc46b8f..0b322473deac 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1889,7 +1889,7 @@ static int __init thermal_init(void)
 	if (result)
 		goto error;
 
-	thermal_wq = alloc_workqueue("thermal_events", WQ_POWER_EFFICIENT, 0);
+	thermal_wq = alloc_workqueue("thermal_events", WQ_UNBOUND, 0);
 	if (!thermal_wq) {
 		result = -ENOMEM;
 		goto unregister_netlink;
-- 
2.54.0

