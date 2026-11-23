Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795412454;
	b=EOaqgS9VSroxTDPiJ1AKKgr+BvtAsLOdOvLD9OOLYPExPdZN4l+syZ5Y585RdpNZOcQ+
	 feWnrFHONt9eMVM9fCnvZ1u4uEyvrEy1aFFkWtd7npzz3ox/7MxZipREZOOrV686PfPH+
	 qr8KMiyzhvM40gvl4XzurfrPmpdFR5yumlOOcGqEHEUvFE8JqT0UlmmLPdg6zvR4uFkTF
	 bSwfftJvZz4bTsI92CGdC708Xj9zjf2LU4PbLjDeFsS6EjhZBP/DlJKrv3juIQpdcYUbW
	 cFkv23g4ls0GBsfZav+hIBNvR/EDQIUujlPwl2TKf1W5PddjZPl3YzgooKHzuipeFNg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795412454;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=B00ZpNTnW95K76WLzVJcGeEMmqqcMXZtAIVmVUEeYqY=;
	b=ftRd2d8s9kl3Qv0hHTvGxQfMZZfzfCtKOGGNjINErvx1ISu111g6S9hO1EfbfQQXOtMw
	 lHauC4I2Ck/vC280od9/5m+cHurcVK69xfk3cE7gRIA1m2F9QeE4gIng2xf9679Ue/o4m
	 qZH8uVssdy/MsCuYUBFrgG+7oVrNMbk0KC0pDinIoU4dOVEQxBXyFOqYn7wfo1q8Pf0Vn
	 k1aTwRgWYg7kBA/ia8KZkvmafTEUBv0fP7J6I4qRERJdTLkXjQRRI9SfbnlCpKy275/6b
	 oVe/YtZ3Yv6DooCW/wy1Ssadt4gQxFs02D92dlfZWoz5UjXU+bm+AI/+dIMsACO6saQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OQsJbY1Q;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD13606A321;
	Mon, 23 Nov 2026 05:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OQsJbY1Q
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795412454;
	b=jTwIKT0VdNChcMF54cRUNxjiTZmRluTdiUaUC6tmDchyuihja8pZd7NQh1/+LoeTEHJB
	 Y9d9Dtfr15l2vMlXSXdtVl9Yjr6OE+iFXymEulvfyDbP3oBpV0Kj+zB1Vv2aQZ5LePICV
	 2XauxClSA9mG4RHr4URnBrzBua1t6RPzrZNad7LT2rZ85tZMgJlVtjw+4OsjDwl9WsalX
	 uXmqGmBHZytyFFUs7jpclycR7MMtD/KxiKW5ATvZfXMJ5SyQ0Esxi6YuPy6xor97D1jAN
	 veMu6AHO5jMx+n9TEmgjBJeWpZ/HRnoRH4mP7/jGHCjn7EPxWKG+FlHfGw0K9XvZ78g==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795412454;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=B00ZpNTnW95K76WLzVJcGeEMmqqcMXZtAIVmVUEeYqY=;
	b=3ONUEq6wh2g+DXoQg9cvV5ph87KNnAWYBTEFygafq6HrEEDG1qKDUAR7j5Et7nGVw+Oa
	 9fY6BJl9C4hLD+MpW2oQweq0ByZaMkFu2jaqea1gyKOn/rRxpXFE1YOpowiwAGNVtedGm
	 uQ9vnmW2fQzIBx8ZKNG1EL40QtQDFI+WWs8MpGhAeY8tO4yC31iM37mQL5SHL0xsZ1mAi
	 2pr6xpeZul+9AEymvFq0AKwZXG/D0ZnvGyiCKcaeF7drMpOgaZ/Z+0+N7XnTcEAVx2Izj
	 drUWKvFLOSSD71QzbpazDGc2riIDuj3dm7CGQbo2joAOqeWKR+wVge6dS/THGQJfzxA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 4248B1F000C4;
	Mon, 23 Nov 2026 05:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795412454;
	bh=B00ZpNTnW95K76WLzVJcGeEMmqqcMXZtAIVmVUEeYqY=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=OQsJbY1QGAEMFHDeOlF2q1P3jOCJIlSBbo6oftjpDwRAjcOD/DgUIzLs8/MSRrAYQ
	 54rs8zCpO93n5WOr3ZtON7yzRYFhjfnJGpuj/ZZUUFR7EXR1fmyVc/5NjzrmC6N14I
	 FgknvNXRIZyI5584dc4uQrhZ3+7NHtejCPI4HTSZbcWoJ94RSRYG3i4DwwSIRmqIru
	 U2nRMXjbMJ1v7R9g2YndTL8nTpdzZjX90Y16BfdIQjfCiOOCifAF+Dz7NTX1a6IJaG
	 03oXkRsRGCsL3r7HSPtE54fUPOMk9I9CnJxfXez3BVpaXYxz3/5r+DXHtPz/FY6PPh
	 VbtSO1qTTUl6w==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 9820C4C376;
	Mon, 23 Nov 2026 05:40:44 +0000 (UTC)
From: Suyuan Wang via B4 Relay <devnull+shyckless.gmail.com@kernel.org>
Subject: [PATCH v3 0/3] cpufreq: Fix leaks on probe error paths in three
 drivers
Date: Mon, 23 Nov 2026 05:40:42 +0000
Message-Id: <20261123-cpufreq-leaks-v3-0-1f1e3f4f5a7b@gmail.com>
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
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANrRA2sC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHUUlJIzE
 vPSU3UzU4B8JSMDIzNDQyNj3eSC0rSi1ELdnNTE7GLd5KS0FFPDFBPjpFQLJaCegqLUtMwKsHn
 RsRB+cWlSVmpyCcgQpdpaAJratyFxAAAA
X-Change-ID: 20261123-cpufreq-leaks-cbfd51d43be8
To: viresh.kumar@linaro.org, krzk@kernel.org, peter.griffin@linaro.org, 
 rafael@kernel.org
Cc: linux-kernel@vger.kernel.org, zhongqiu.han@oss.qualcomm.com, 
 alim.akhtar@samsung.com, linux-pm@vger.kernel.org, 
 linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795412443; l=1356;
 i=shyckless@gmail.com; s=default; h=from:subject:message-id;
 bh=hCDTxIrRIBEJ8uzexGJBO/WMptBy/NJuSC/LPl/uuvI=;
 b=wTCgJpRhXo1QfJzkQpiNEKvF1DBjx7RADIcqO2hnQzXMu10hFoPvG/xJFlPQaU/cNielTXIYB
 HuvkjZehewGCGNLvItHDc8oV6YBZnWfhqbBlPn4xgw93pKkp/bc6wMm
X-Developer-Key: i=shyckless@gmail.com; a=ed25519;
 pk=pMtccVGiWES3bV+7YBFuBclkvq2n2HBHQ5azaBrK2lY=
X-Endpoint-Received: by B4 Relay for shyckless@gmail.com/default with
 auth_id=1498
X-Original-From: Suyuan Wang <shyckless@gmail.com>
Reply-To: shyckless@gmail.com

Three small fixes for resources that are not released when a cpufreq
driver fails to probe: the cpu clock in highbank, the three clocks in
kirkwood (also on unbind), and the regulators and register mappings in
s5pv210, and its reboot notifier, when cpufreq_register_driver() fails.

Found with a static analysis tool and checked by hand. Compile tested
on arm (W=1, multi_v5 for kirkwood); I don't have the hardware.

Changes in v3:
- Add Zhongqiu's Reviewed-by from v1 to 1/3 and 2/3 (Viresh).
  No other change.

Changes in v2:
- 3/3: fix the Fixes tags. The regulator and reboot notifier leaks come
  from e8b4c1986efb and fe7f1bcbff91, and e0e5b2b4f427 did not add a
  leak (Zhongqiu Han). No code change.
- 1/3, 2/3: unchanged.

v2: https://lore.kernel.org/all/20261123-cpufreq-leaks-v2-0-29277f2f0ddd@gmail.com/
v1: https://lore.kernel.org/all/20261122-cpufreq-leaks-v1-0-96fc17ff7339@gmail.com/
---
Suyuan Wang (3):
      cpufreq: highbank: Put cpu clock if clk notifier registration fails
      cpufreq: kirkwood: Put clocks on error and in remove
      cpufreq: s5pv210: Fix resource leaks on probe error paths

 drivers/cpufreq/highbank-cpufreq.c |  1 +
 drivers/cpufreq/kirkwood-cpufreq.c | 15 ++++++++++++---
 drivers/cpufreq/s5pv210-cpufreq.c  | 12 +++++++++---
 3 files changed, 22 insertions(+), 6 deletions(-)


