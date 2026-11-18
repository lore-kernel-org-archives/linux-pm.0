Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794992628;
	b=kesUVjnak9LxswOZF3Jzeor1SmA/OZTDXsE2uc2tRvXOP+aCUsRfOQrFHkS3YfMf2h4d
	 cOCQPGYLwU5Q2fPIK+I2xFlHkiO9MbSlej2A3kB8ezIQQZl2NMAeT4r1jBUn/+UsEQSmu
	 pvW7HxqpkEzV8SHIQMCwa2K7celw62C8mWHjwYE67uieZ1jxUdSzC7ZIVZ6QiR4lZF5I7
	 hPh1iAQmdftHBfxwiojVN31VekUJKfGx/R3l6dL4VwF0ZjNylaNM1tImzyTdsw3mDIMl6
	 XeXG6mgnG9RFEEJgo7oyDRn0VWUsnGmuhdFX/FsL/pAZSa6rnLa7ziKGF2gnGLnavAw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794992628;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=jOW5o5razoH7JZilM4XOTCBHa7GM+dbv2PqjZiPktqg=;
	b=0dynAzsD3zi7QOD4UcEiFZIORSLotfsOhVTazfSiwtZktjsDOtfMzZS1EMKVMepRxrQE
	 V+Jinl9jVHKrNbBRptlbD3GlN6qHgB48AEnQZSYv/ZvID3qrTLgJ52FvwPBAsKtqbuPbF
	 T+IfX8j9LyeymdCfEm95WvuGd8gne0gWFhVltSGrsWxUC7jVOBlrYVANK232tYdrTaZeT
	 UqvQs+RrP21X/BlJoSSOudeyy2Ui44vbPcWklVVrfHZ0njtCiJ5FGK6iKeS91wuNu1VHA
	 wz74dp29K5ROkoNUjuqWpHT1vfdp5XWMfslVRCFvOFMClXlf2sQ6FztSLuqFJrmnfKQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Dgmn1fRk;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B343C606A31C;
	Wed, 18 Nov 2026 09:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Dgmn1fRk
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794992628;
	b=jiyylxlxcF45E37ZMl3JX1jgojwugjhykVHSCAseeQI6dTSEsZuDBcOt7ioQZeOFJ+JN
	 Of8j8vbUSVXsTEUdgpBkImlXf6jJaZp082SbjeOom78hTkcFMEGLJiRvZC6Fkvj00vWz2
	 KiVoG7cLd/NHg8gtFj8wtP0qXtyX8Ysd+cijHkSoHkzsDCJi186MBUYcixd0XMb40f8NR
	 PKSIxsFWUiuRDYuGctmpXZa8LOCkQYeH10xVWiezhjTBAta0VM3R55j+HP/ySmoBIp6Uy
	 smA5FkR/l2GTR6DoRdbE0bjoJgrrXE72W9VrpvdpzzlwQtaMY/1siEKZ0PUDYoUogTQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794992628;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=jOW5o5razoH7JZilM4XOTCBHa7GM+dbv2PqjZiPktqg=;
	b=vPSNDL/8L08kncJOT3yvnysHOd6HWN5aP+JQMX8n4Tx+eQ1iDiGMTdcIVd1ox0dMhZuB
	 6IJEsobs01T7Zk6q7BR6myCagKjrQVTDDu+bFpJS79m9rbUhAOmS0seBLGEnb+lXFPNZP
	 PcsyFywQfEIFAuHA5PDgbILGQwQg68fe7Fo1+g8AOFYDJgF7h+ly4GsiGJBIeJ74mZD9V
	 PLSZYA4Ptd8bn61QyQ0XIj8mQpOUf4F1vT8jy2r2vx3mZk/+Pc5fFAzkJTJCY7RftN2zt
	 h5gm8oB246J3R34KBXm09hfkuHlCxJKI0EivkaU+vFdKZuLDMskWId34/f4WdmZ9iTg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id B9FA71F000C4;
	Wed, 18 Nov 2026 09:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794992628;
	bh=jOW5o5razoH7JZilM4XOTCBHa7GM+dbv2PqjZiPktqg=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=Dgmn1fRkE1Rp6vbBuXL3bNKLudKpbeZ04XCEG9mnKAgFHs2+l9cC9uFBpoEknRVRA
	 NhrAyg9AzlWTLn8ioXkOQ1+bZE8kwbGPxYnlKw15tZcY3pTMyaG1eaMKzkeSWy+1GT
	 fcNIZxUgXlwdpZgvr+AySP2QazeuylWi9fUI86DtRcokNzYqN4UFTzL4Pnv7pL84jC
	 iMoIgcHyAPvvYXhvboMoypAa5JpXxbsAXDgZ+SOkRuP5BxpYdI/NG5GOl9niQ98ghi
	 daAPwhVR3/0EQ6QH/Vf2bjRHCIRVr2HzNblKv4wc4pXWSsXQ2uZI9vRoQBD06/z4KY
	 21AwNq0W/+KDQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 1AAE04ACAB;
	Wed, 18 Nov 2026 09:03:47 +0000 (UTC)
From: Cunhao Lu via B4 Relay <devnull+1579567540.qq.com@kernel.org>
Date: Wed, 18 Nov 2026 17:03:46 +0800
Subject: [PATCH v2] pmdomain: rockchip: Roll back power-on when leaving
 idle fails
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
Message-Id: <20261118-fix-rockchip-pmdomain-power-on-rollback-v2-1-3e4e93a19996@qq.com>
X-B4-Tracking: v=1; b=H4sIAPFp/WoC/5WOSxKCMBBEr0Jl7VgMH38r72GxCGGQEUhCgqhFc
 XcDnsDlq3ndPbPw5Ji8uESzcDSxZ6MDJLtIqEbqOwFXgUUSJwfEGKHmNzijWtWwBdtXppeswZo
 XOTA6nLqulKoFhUjBz6hGFKHNOgrRbelW/Ng/ywepca1fjYb9aNxne2XC1ft/dUJAyM8yy4+nl
 NKUrsOwV6YXxbIsXz5+zsTtAAAA
X-Change-ID: 20261101-fix-rockchip-pmdomain-power-on-rollback-c11e1014ef11
To: Ulf Hansson <ulfh@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 Peter Geis <pgwipeout@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Cunhao Lu <1579567540@qq.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794992626; l=4100;
 i=1579567540@qq.com; s=20261015; h=from:subject:message-id;
 bh=iNwwI4s6GSLy+qcCrFrOUdp0m3/C5bTABfIfePwVyzQ=;
 b=H63KA2kbZQ2Udd1ZDZZGo9Hi68SF/NWCbC3+XwmNAXq8T/k3dsQ+VxVWUvmFLqYBBiUmgoEex
 xw75v/1FNqUD4mT0epcOH217F8bJF6A2hMLTH1oMBT5JU4Fy1okbdl4
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
Changes in v2:
- Rebase onto the next branch of Ulf Hansson's linux-pm.git tree.
- Link to v1:
  https://patch.msgid.link/20261101-fix-rockchip-pmdomain-power-on-rollback-v1-1-59a45783e33e@qq.com
---
 drivers/pmdomain/rockchip/pm-domains.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/rockchip/pm-domains.c
index 6abef60a5b4c..2c021784316a 100644
--- a/drivers/pmdomain/rockchip/pm-domains.c
+++ b/drivers/pmdomain/rockchip/pm-domains.c
@@ -648,6 +648,29 @@ static int rockchip_do_pmu_set_power_domain(struct rockchip_pm_domain *pd,
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
@@ -682,8 +705,10 @@ static int rockchip_pd_power(struct rockchip_pm_domain *pd, bool power_on)
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
base-commit: 6f5c8ec9302c5ad8904dbdfe8cf2a538ff835572
change-id: 20261101-fix-rockchip-pmdomain-power-on-rollback-c11e1014ef11

Best regards,
--  
Cunhao Lu <1579567540@qq.com>


