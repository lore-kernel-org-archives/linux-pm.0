Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B6039023C
	for <linux-pm@vger.kernel.org>; Mon, 31 Aug 2026 18:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788202319; cv=none; b=FoY69caoqXfOpOAKK0TpFb+QnVm1M8DZCUvTkO5Lykymr4j3pEB0xklGsT14TSazCWKZy7wX4xe8zDnQipYBoI4khBioLgJouY6Qa+WEkN0uzl6zOsd0SjcYuVkSgmPgwqAM59i7VRa942wPyZcLNrrZiNQ6Go7q3ckBHa9SKlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788202319; c=relaxed/simple;
	bh=8hjCPq9667fX+V+iDArjQoIU/4NOdMM/TkYRxWB89Ro=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=VrRo54aXMsLh+xvVTaYIJQohXKDErVRXAGZZWHw/sUzQ0+OjU4b/Cwue+Rmiqn9MkDIv2g6VI74Q+1o8nayIp9Df2OaIZFcyWt9k3VlcxwznlXvFvxE2ZvkL61f2fJjU25ZLnTBL+bw+zUnx/B3lTOR7ehnDRLkZZMpg+yZr4EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=YZaSTnSS; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="YZaSTnSS"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-853e2610bb4so177403b3a.0
        for <linux-pm@vger.kernel.org>; Mon, 31 Aug 2026 11:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1788202316; x=1788807116; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=AthMoz/AgoYLHvPsWwEymdR4bUCvaR6JITk6QxJBrPs=;
        b=YZaSTnSSqoBAjJAUjm9bA/0KUmr79iQ4LgdtD6rxVJ0R1l2XL30wMC5hyGA/Xy3sIB
         MCnR/4jzxvN7WMQ0yGMEMfwSeLmV84QppkZaj3xe/k5ioJIflbkKyEBa3rEFNDHMB22M
         +p3zmABVhJlPwa6DoyWa8i2fvetVltQ9EIYrOUmX/uSh92gznwRI3pK4zlTvhviaxcNv
         ouLXy62b0Rr4h9KwKl4LSaspFlF4/3vPtrK2lvN2TIXr1qkcuKt/FCusFYtowz2HRU0Y
         f/iHLCgUc2B7BF2Xd+aD/AQQwItWMCMxt3N60oQtlwVFF2wIxciZvIRC1jpxtDs+RY7K
         Qe2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788202316; x=1788807116;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=AthMoz/AgoYLHvPsWwEymdR4bUCvaR6JITk6QxJBrPs=;
        b=bHAtH+EKff7d0vWMfGsCXuctamUp1FCzRj3OQqG+LGy/iOIM4j/hLguXcrp1By0fN7
         ZvQ2InUdCLrBMSWHY1j59vuzL8fGUsffMiEMZdKBDeFRxwuYBU8HIKJwkrUoC01vqf2v
         LrVK2pgXeXCekkVuGyMgDEOej8G+yGTkjwz0vD2CVsen3nyhWZnF/Rq/VEBAFT3URD0U
         zSwlgXiPEzJ1TtiuzIc22IeGb9uGaI4q3i3R1pqvGq0a1sKgwpGtbqfkckHNLM672tkq
         H7jqZJplP0FsuFSBqJhjR8uWv/WGRVNeBKnQKF8eTSedd9CbQH3CbfVM9+E0VLqjsWh+
         8OaA==
X-Forwarded-Encrypted: i=1; AHgh+RrHwOAWawVDzgYxEGFcwWzP9J8lXv9j1QhS0qiddKeSvdOPFpQOUBhQ7BJUUIwC3wyot9WdVG6O6Q==@vger.kernel.org
X-Gm-Message-State: AFuF++mM4DYNjNJmzPEraU3Cbh3wKXBcCarRinbXkiSJy0DbNJg/10NJ
	utU2Pg5hCQ45BfYABNNQ3wVq28KjBEQbtBT0CfLfx11H0hcHq0rVowLinbeA2TZzRUA=
X-Gm-Gg: AR+sD11JNYRbme5tlQC9P1lczpvTNA79erGiC42ngSrnvz4oTGlERtA/rN3ZYA/5Edn
	Ee+W7SjP9KUPsLejd79Tf7QeIK8pEwdGMETSfsG/8+vXa0yfQLlqMTivmLzBeKOiPNLw5+VPbP7
	dn8F+YYACbo94AjLTFjycKsDYUvqgr/fni6ch7MZNDNpXEaeL5lrg1XCzoQ/68VeXdawDIISSgD
	GIKOHzZf8bFDKy0iP6QW6W5QDbEDcC5iBfoLijgS4rvvKxl6gcux4pw8Iikqt7gYmZ5jta2Ozhd
	sL+asC9SbvOmE1Vz9eyjFpcIIrBNN1eAGMqI4ufRP0i8hTp4lIffMkJZN4AeinzEyJapSE+0Fzg
	qm7KzB7dFQFTpOGhdFvL6Wh5nalUIKn4nToKmoFWDP/y9az+plMJuqzzq6vXdNFYHROMyAiwEXX
	Vm+q0DHMkaRluEII+0HcdVl3OEx9HUTGbbvbUEOkLKoUdmp3P43CawJyUdr1/ygczTj2g9
X-Received: by 2002:a05:6a21:e38a:b0:3bf:9bd9:cf60 with SMTP id adf61e73a8af0-3d816bf48f7mr264453637.6.1788202316392;
        Mon, 31 Aug 2026 11:51:56 -0700 (PDT)
Received: from localhost ([71.212.197.238])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-cc1f3312146sm4820179a12.8.2026.08.31.11.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 11:51:55 -0700 (PDT)
From: "Kevin Hilman (TI)" <khilman@baylibre.com>
Date: Mon, 31 Aug 2026 11:51:47 -0700
Subject: [PATCH] cpuidle: psci: Assign domain callbacks to all CPU idle
 states
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-topic-lpm-psci-domain-callbacks-v1-1-4a47d95c9c79@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAELNlWoC/y2Nyw6CMBAAf4Xs2TU8ohB+xXAo20VXKS1tISaEf
 7eKx0kmMxsE9sIB2mwDz6sEsVOC4pQBPdR0ZxSdGMq8vOZNVWC0TghHZ9AFEtTWKJmQ1Dj2il4
 BVaOGnHSth+oCqeI8D/L+HW7dwWHpn0zxm/0bnuclreOhQa8CI1ljJLbZWp8r9FRAt+8f/+q1c
 K8AAAA=
X-Change-ID: 20260831-topic-lpm-psci-domain-callbacks-a8af0cd7df35
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 Sudeep Holla <sudeep.holla@kernel.org>, Ulf Hansson <ulfh@kernel.org>
Cc: Scaria Kochidanadu <s-kochidanadu@ti.com>, linux-pm@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-rt-devel@lists.linux.dev
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3203; i=khilman@baylibre.com;
 h=from:subject:message-id; bh=8hjCPq9667fX+V+iDArjQoIU/4NOdMM/TkYRxWB89Ro=;
 b=owEBbQKS/ZANAwAIAVk3GJrT+8ZlAcsmYgBqlc1LhSNw7ZHa5daoTtWUSucRYeVlg1NKgX/Lv
 +fkTVpOXDuJAjMEAAEIAB0WIQR7h0YOFpJ/qfW/8QxZNxia0/vGZQUCapXNSwAKCRBZNxia0/vG
 ZXHbEACEedr/5CrU2dyNFywhe4xoCG2oZWYaMNNVedr2DV2qBNM/y8IPPDSmDW9eVGPE9Qx+UK9
 yfiT6WMJiyPXx2YW7Wqz5XT0NaoZ3RxsVMi0+0BVi8lODZpxVU3424FFFsxw/tJ6myEF03kCz1k
 zBgyc0EYPtIGpTZX7o0bCxmjZ6MHYhiGq7CZhI/TNrbkpHHod0QmGAHjc1cNJEAMS+eZ5VF4emX
 eape3/S+wLti5Td16kcoUAfkGlCh8YIU0Ju+Bir4tPx/rskaCmfF7zQAnTEsg3DW4B45g03kMaY
 xyzoyPWOX3FSlPXa5iVRXYla0G2AC+N5mjZjGXA/xcsdHsO4nxNm/MZ9kXrLT/kWuHCpXSO6pQC
 2La6HyJ4v+17QgAkkhZ3wFDFxbPk1J41tO9J4dJJclKRxDd7XmNEIUcPoGyvvmd9cb/fY72MKns
 IWRBRpXW7OXMTbFICTJgM7GYMYQ/Kb9LNQkGR15owJLtvgYsJjgrB0tsNKXDqyOfAZX4YIywqoS
 /HvYzFELx5HvyWCBzj9w93lqkqLCFV3a4MAgJocVA6h8d8EGIk9YBC6+LNNSV1koxHHh8icFy65
 Vnmn01ok5luOs7YVOHAr8OXHp0ysDdJU5eCllOwQJ/k5WoZ5TKS7+WBrQXs1G8O3Ftao345mjbe
 ILgnjOOeaWUwD/Q==
X-Developer-Key: i=khilman@baylibre.com; a=openpgp;
 fpr=7B87460E16927FA9F5BFF10C5937189AD3FBC665

Previously, only the deepest CPU idle state had its enter and
enter_s2idle callbacks set to the domain-aware implementations. This
meant that if a QoS latency constraint excluded the deepest state during
s2idle, find_deepest_state() would find no state with enter_s2idle set
and skip the domain idle path entirely. Similarly, during normal runtime
idle, shallower CPU idle states could not trigger cluster-level domain
idle states.

Assign both enter_s2idle and enter (non-PREEMPT_RT) to all non-WFI CPU
idle states so that the domain-idle-state logic is triggered regardless
of which CPU idle state is selected. The genpd governor remains
responsible for honouring domain-level latency constraints independently.

The enter_s2idle path uses dev_pm_genpd_suspend() which is safe on
PREEMPT_RT. The enter path uses pm_runtime_put_sync_suspend() which may
sleep and is therefore still excluded on PREEMPT_RT.

Suggested-by: Scaria Kochidanadu <s-kochidanadu@ti.com>
Signed-off-by: Kevin Hilman (TI) <khilman@baylibre.com>
---
 drivers/cpuidle/cpuidle-psci.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
index dcf20ea5ef5e..db9aa57c51f5 100644
--- a/drivers/cpuidle/cpuidle-psci.c
+++ b/drivers/cpuidle/cpuidle-psci.c
@@ -250,6 +250,8 @@ static int psci_dt_cpu_init_topology(struct cpuidle_driver *drv,
 				     struct psci_cpuidle_data *data,
 				     unsigned int state_count, int cpu)
 {
+	int i;
+
 	/* Currently limit the hierarchical topology to be used in OSI mode. */
 	if (!psci_has_osi_support())
 		return 0;
@@ -261,14 +263,22 @@ static int psci_dt_cpu_init_topology(struct cpuidle_driver *drv,
 	psci_cpuidle_use_syscore = true;
 
 	/*
-	 * Using the deepest state for the CPU to trigger a potential selection
-	 * of a shared state for the domain, assumes the domain states are all
-	 * deeper states. On PREEMPT_RT the hierarchical topology is limited to
-	 * s2ram and s2idle.
+	 * Assign the domain-aware callbacks to all CPU idle states so that the
+	 * domain-idle-state logic is triggered regardless of which CPU idle
+	 * state is selected.
+	 *
+	 * For s2idle, enter_s2idle uses dev_pm_genpd_suspend() which is safe
+	 * on PREEMPT_RT. find_deepest_state() will pick the deepest state
+	 * whose exit latency fits within the active QoS constraint.
+	 *
+	 * For the normal idle path, enter uses pm_runtime_put_sync_suspend()
+	 * which may sleep and is therefore not used on PREEMPT_RT.
 	 */
-	drv->states[state_count - 1].enter_s2idle = psci_enter_s2idle_domain_idle_state;
-	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
-		drv->states[state_count - 1].enter = psci_enter_domain_idle_state;
+	for (i = 1; i < state_count; i++) {
+		drv->states[i].enter_s2idle = psci_enter_s2idle_domain_idle_state;
+		if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+			drv->states[i].enter = psci_enter_domain_idle_state;
+	}
 
 	return 0;
 }

---
base-commit: e5e04726cdd043e309677071ab1b65a4b18f422b
change-id: 20260831-topic-lpm-psci-domain-callbacks-a8af0cd7df35

Best regards,
--  
Kevin Hilman (TI) <khilman@baylibre.com>

