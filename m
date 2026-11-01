Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793542734;
	b=VWOz+Mlb0mChsXzsvnXdXVv+YJa6qWlOMFzOQTsLxsj3qYG9QKz/zun5km5suaoVYHcS
	 35YT5T9pEEFc1mPkIa0uHcefHVmLgjzdHzTQW1S85i5EPZnpoV7IozDPNKiEjDLury838
	 hY1V/7Yo6bu2vTRlzW/Thji/8X4XGhPlb94xRlWInmkGQyK6GmfxHniGoQaB9xl6cQtu6
	 xtCNr1DwmrWzH/invFFeg425lCRU5frNj/W7IlM/oZYU3kRw9FhP1Qmydm25CKmaQ57qF
	 rtK579hA+WW4IogAuri+at0gZf9nHzZRTsy+sU7DP7YokckZcETZq08D68Z4NWgVOgQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793542734;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=u9blQz8scr94PPwQuvxtmWBvDZvQKZN89+CtuQld/I8=;
	b=3m4ixm6yoXAJdbnh3L++Ki7aPBFuz66SDxBCIi/TcLXCRpHBov7vcyYQafYxZZIRKqgM
	 rL6NRGP0f7AJLFDNqSKiHpy9wjxNbWMnX/h8t471jGPGc7akXIcbilzaecBTG7GXHAQY9
	 N4Y16eR8DW3/1cT3Xwg7TGfQJKs7wwKSWrkvO3KLm2CFrRCw/1ZRhTvgaYvkwpU2v/KFA
	 vPKrJX9Tw6HxuGPIyQ+cdzxAWJsSjFgJtN28N7Proggk/ckycuKaUTTOxIZElp7d0pmdX
	 rjMdeOoSncAlOVlb2G8ghqtZ86rznOfSF9S6d12FjEE4tWKmXI+8/vB3hJJ3sFe/eQg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MyoFOvpY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D817F606A324;
	Sun,  1 Nov 2026 14:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MyoFOvpY
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793542733;
	b=lrCoHnExH10xVtgZvXvEI3maMlZNomnflimfiWwLcBJlZgLM4tlz9sMteS7cDOCK6MD5
	 Qeo5u6Skj8LZArJvW+ShA6rtYVWnFJOdQRj0zEJ12f1RBO83Cr1W3vHHNJkjoyYPt37Yr
	 w5o9LbyZw878jcBtfNQ35PeV3MoRF6KmtONuBCi8+DL2+JvPWVB4FkUg++MZbDK/4rmci
	 IAysjhGW+6IbjLgo5CKkJEWcZUozICWXVDN3JPFWj3PevxUOFv3SkkoGjVrelqfqFfRBg
	 idqBwYMeXATDq68RR+lYGanH8+VcIw/TwHTS6cGgwXbNJ1VzDG1YXqvlL3mVQP09NlA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793542733;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=u9blQz8scr94PPwQuvxtmWBvDZvQKZN89+CtuQld/I8=;
	b=IjDNpVTwj8UUf6MdjOoHD4JqbWid8uXHIPqtIncja0vbVN7ZJA4vsh/JOvCQeqtZXboR
	 wGyRS+qYDmmywB6t6Cjoqnmjv2X9jiLf3cHlWM6M2l4B+wnGaGSk7qz/CBB8YlM4Clag1
	 izYsvoZPKmGmotCLVQl/MUzjcyKROqkRq0lNWBFJuj0W2xDu8Sy5R7OKtWwSXIpyFtEct
	 FGW00NVO5NXvT8NUIFbS7cTC+mcUe0lXFzPleNCqUK0FzohEp2xDMXbhndYEKDgaSDuUh
	 naCYH5ci75cmfh6qN/4TNhXPS9jdaJVa6k0vEPkMOS4biw2c5QIyeMfScO/9wu5h42w==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id C40971F000C1;
	Sun,  1 Nov 2026 14:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793542733;
	bh=u9blQz8scr94PPwQuvxtmWBvDZvQKZN89+CtuQld/I8=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=MyoFOvpYjCLhcgNFe/CsyHFkNlZRKKS/Q7VvTNrfJX/G2kP0wXd9zXn42XjQ0Znj1
	 ezeye7kBVzikfJrauOwDIHcBYQmECYP9Cw8V4MUSoM8tBvA/gj5TkS/+FKn0MN9S9R
	 p6pbN2woV0KZmPul0j1pQqRe0WZf65wdlm8XoHVKwya2WMkP5gE8etwAwX199UYzQK
	 Rmg2beP1Xj1G9cXnGVKi+Hf1NzWAhpRUvWfKxw3ENYAC9R75G7qXkWEUitZvjeuD4r
	 w32ESnzSDsD2RZs6fPZ0hTwjGcV5FvYxkiEqGM6/6d1VkeBcWS8bFg+jppY7womumH
	 34tQ+pt3i5a+Q==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 2682046196;
	Sun,  1 Nov 2026 14:18:52 +0000 (UTC)
From: Cunhao Lu via B4 Relay <devnull+1579567540.qq.com@kernel.org>
Date: Sun, 01 Nov 2026 22:18:51 +0800
Subject: [PATCH] pmdomain: rockchip: Roll back power-on when leaving idle
 fails
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261101-fix-rockchip-pmdomain-power-on-rollback-v1-1-59a45783e33e@qq.com>
X-B4-Tracking: v=1; b=H4sIAEpK52oC/yWNwQ6CQAxEf4X0bBNKDAd/xXhYSpEK7G66oiaEf
 7fo8WVm3mxQxFQKXKoNTF5aNEUHOlXAY4h3Qe2doamblqgmHPSDlnjiUTPmpU9L0Ig5vcUwRY/
 muQs8IROJ988yEIHbsolPf0/X25/L2j2En4ce9v0LSn4eh4sAAAA=
X-Change-ID: 20261101-fix-rockchip-pmdomain-power-on-rollback-c11e1014ef11
To: Ulf Hansson <ulfh@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 Peter Geis <pgwipeout@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Cunhao Lu <1579567540@qq.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793542731; l=3895;
 i=1579567540@qq.com; s=20261015; h=from:subject:message-id;
 bh=n1GcdQjuTTwBnd/fyanWdo3GZ489PQSz5kGsPzwhT6c=;
 b=WxN7YfRzAeNe1ZbUpfFSZuvt9IaBjnFYOkoxDM/kiTSJpQsS8rYk6w2T9ZihIRiBvYWzq/PIR
 G6G1ODclGVOCL94vn9bNZUbkOUdldTj8Ov1ct0Cd54Y0Hq6VYpix9zm
X-Developer-Key: i=1579567540@qq.com; a=ed25519;
 pk=sUTWrzlIwT4C7ctjNfVZAzzg0G7QUn2XxRGpYsw4RtM=
X-Endpoint-Received: by B4 Relay for 1579567540@qq.com/20261015 with
 auth_id=1177
X-Original-From: Cunhao Lu <1579567540@qq.com>
Reply-To: 1579567540@qq.com
Content-Transfer-Encoding: 7bit

From: Cunhao Lu <1579567540@qq.com>

When NIU idle exit fails after PMU power-on, clocks and the regulator
reference are released while the domain remains powered. genpd treats
it as off and may power off its parents.

Request idle again and, if successful, use the low-level power-off path
before releasing resources. This preserves saved QoS and notifies
firmware while retaining the original error.

If rollback fails, resources are still released and genpd may power off
the parents.

Fixes: 6b2690df3f03 ("pmdomain: rockchip: fix rockchip_pd_power error handling")
Signed-off-by: Cunhao Lu <1579567540@qq.com>
---
This pre-existing idle-exit failure case was reported by Sashiko AI
during the RK3572 mainlining work:
https://sashiko.dev/#/patchset/20261022-add-board-ok3572-c-v1-0-0b0fd85a31ee@qq.com?part=10

If leaving NIU idle fails after PMU power-on, the domain remains powered
while genpd treats it as off. The error path releases the clocks and
regulator reference, and genpd may power off the parent domains.

This patch requests idle again and, if successful, powers the domain
off before releasing those resources. It preserves the saved QoS state
and original error, and uses the low-level path to notify firmware.

Validation:

- All 48 host simulations passed, covering power cycles, idle-exit and
  rollback failures, QoS preservation and error propagation. No sanitizer
  findings.

- Hardware testing on OK3572-C: 20 patched and 50 unpatched NVM1 power
  cycles passed. Request-write injection caused native idle-exit polling
  timeouts. The fix powered the domain off in 3/3 cases; the original
  driver left it ON. QoS and the original error were preserved, and
  retries succeeded after removing the injection.

Persistent rollback idle and power-off timeouts were also tested:
resources were still released with the domain ON and genpd OFF. These
failure paths remain unresolved, and genpd may still power off the parents.

AI assistance:

- Codex / DeepSeek V4.1 Flash were used for:
  - Reviewing and adjusting code style to follow community conventions
  - Automating tests
  - Collecting data
---
 drivers/pmdomain/rockchip/pm-domains.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/rockchip/pm-domains.c
index db3879846db6..170f140601d0 100644
--- a/drivers/pmdomain/rockchip/pm-domains.c
+++ b/drivers/pmdomain/rockchip/pm-domains.c
@@ -644,6 +644,29 @@ static int rockchip_do_pmu_set_power_domain(struct rockchip_pm_domain *pd,
 	return 0;
 }
 
+/*
+ * The caller holds the PMU lock and transition resources. Use the low-level
+ * power-off path to avoid overwriting the saved QoS state.
+ */
+static void rockchip_pd_power_on_rollback(struct rockchip_pm_domain *pd)
+{
+	int ret;
+
+	ret = rockchip_pmu_set_idle_request(pd, true);
+	if (ret < 0) {
+		dev_err(pd->pmu->dev,
+			"failed to idle domain '%s' on rollback: %d\n",
+			pd->genpd.name, ret);
+		return;
+	}
+
+	ret = rockchip_do_pmu_set_power_domain(pd, false);
+	if (ret < 0)
+		dev_err(pd->pmu->dev,
+			"failed to power off domain '%s' on rollback: %d\n",
+			pd->genpd.name, ret);
+}
+
 static int rockchip_pd_power(struct rockchip_pm_domain *pd, bool power_on)
 {
 	struct rockchip_pmu *pmu = pd->pmu;
@@ -678,8 +701,10 @@ static int rockchip_pd_power(struct rockchip_pm_domain *pd, bool power_on)
 	if (power_on) {
 		/* if powering up, leave idle mode */
 		ret = rockchip_pmu_set_idle_request(pd, false);
-		if (ret < 0)
+		if (ret < 0) {
+			rockchip_pd_power_on_rollback(pd);
 			goto out;
+		}
 
 		rockchip_pmu_restore_qos(pd);
 	}

---
base-commit: d89e1d186ec9271bf78e62771779e9fc03bf0fc3
change-id: 20261101-fix-rockchip-pmdomain-power-on-rollback-c11e1014ef11

Best regards,
--  
Cunhao Lu <1579567540@qq.com>


