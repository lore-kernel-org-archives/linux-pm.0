Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B295394798;
	Fri, 10 Apr 2026 07:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775807976; cv=none; b=mDiZYKp9CHG54DbCzXPXB/tyEuCkansihAgyr1/q6KXHmVGYdh2bY1B5rztUKAd20Ji8LQKJRRYDxGTptXZjVLdn9B5saA5bEPD6lPShYjYP+8kaVkMV9yjqxnIgugADGFrkPfHf9C9QJR+NX1pjZFd3m/ZXZUnVOfQ9173y8RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775807976; c=relaxed/simple;
	bh=FeITDC/Wu3yb3H+8bxUK/EofL6or0jSpsm7kf+klLiw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=e/8ykAKEi+WM2oTbVAAtt8Azxi33rwby9s/2d4hx4dNEShIQ7S4IklybH07ytYMjpLMrYOUSiMXqsxx/i3QI3HYkkHJp8wWSHc5WNsax2s9WOLfh0FOr1x7ULhrhfyUAOuIj64fU2zZf2bGUtsEWc1ERlqeCvIuveIMYai6EY+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=u488TrHC; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=biA2xEQm; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="u488TrHC";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="biA2xEQm"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4fsTjH6R8Hz9tVg;
	Fri, 10 Apr 2026 09:59:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1775807972;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pdMupNV8SQH25nPQgo6yosbWJa8EJVott5NjvgAdmzo=;
	b=u488TrHCmC2oDwyTMhsyVBFs8gADJoiSDdU2t574byHJQc9Vr2hOSfxDyaBhboCzdM2O5k
	Hqx4NVEuGXK7P9fQQy4nGrtKZmfaQQmknlNQ0pDTCqKAJHHFuDJrNST7uQTcp40zwRXTyC
	ICZokpnMagDR29zDKkamlzJomrJY5ne27hcWEfdDqqCHshV263x6HuOnxDmb79UkPJruh/
	KqCPVOSMd0oQL5Xn/ONTQc3EfpOnEcqUsDpJkvS5OIICT9CJNdFesajsLNd1qo3s10njCV
	92a3/5VsIazTfjQcQjWcSfKp1G/8LJ079OUrCMGd/5akTa1Nl7dOPGLJuQLmnA==
From: Shuwei Wu <shuwei.wu@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1775807969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pdMupNV8SQH25nPQgo6yosbWJa8EJVott5NjvgAdmzo=;
	b=biA2xEQmEhQXECUxzgwRWNqDC/XpwfA46WJ4ZigDrPZ9Jg1YdErE6TohQKLcjL35ACqqcS
	V73yTbyBhpJqFmolGnyL5fBjBFbXI3cFceP9qXgwCrv2xc9JggMVl7xrHMY+oExkVEIdtX
	vTooqolPRjjmtxWA6fxQ16WKzXO1fYwTU36InJYNpBibKwO23/D5I6raoK1M2Tk7D5j2GF
	IVTK0q8tuqAHWlKsFpuoVkwlP8XeQsuuvDbOxjFozKD+DoxihimjOKgH6QZP9hbv2jlXP2
	WB+n030Fzx6dOnrPgqY/k0/5rkX2YjY86vgMU0HyuiuLJe+mL5iKdKEHEhNs4w==
Subject: [PATCH v2 0/2] cpufreq: spacemit: Add cpufreq support for K1 SoC
Date: Fri, 10 Apr 2026 15:58:21 +0800
Message-Id: <20260410-shadow-deps-v2-0-4e16b8c0f60e@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJ2t2GkC/22Qy2rDMBBFf8Vo3Ql6eCTZlJL/KFnoMY5F49i1X
 Dcl5N+rOF200OUVzNHhXFmmOVFmbXVlM60pp/FchnyqWOjd+UiQYtlMcqm54gZy7+L4CZGmDAq
 tdMY6Z1CzcjHN1KXLRns9PPZM7x8Fujwe2eSW0BdkWwmsfaw7I3kg5BojWt9YG8l20ijJja9rN
 JLu3IFydptKWz1vJpJryJMLNKQFJgFrDRxspxuMjbJC0H5OOeTFzbswDi//QxRHeBMQTm9QtGE
 VIMD54CxGTVLr/eDSyY+X3TgfN4R3maDwyqdthULX1CAWddVF5LYcugYVCiVVh0bo2PkixO4l+
 pSXcf7aMq9iS/GjYP8ULQ4cShGPwQRuyP92YIfb7fYN/KHkcrIBAAA=
X-Change-ID: 20260307-shadow-deps-3582a78aa756
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Yixun Lan <dlan@kernel.org>, 
 Yixun Lan <dlan@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
 devicetree@vger.kernel.org, Shuwei Wu <shuwei.wu@mailbox.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775807959; l=2567;
 i=shuwei.wu@mailbox.org; s=20251125; h=from:subject:message-id;
 bh=FeITDC/Wu3yb3H+8bxUK/EofL6or0jSpsm7kf+klLiw=;
 b=IkShTdJXqbof0FcLu6L47SjTOGt8Zw2qonrPSlXJWOd+dzJWOF0NpmeDdsG2nWglcOhBz51/D
 ITsJQIALMUkAs9IyoPhLm66F+Qkg5zR5VdlPUHT+R/co7dYr1E/ZRml
X-Developer-Key: i=shuwei.wu@mailbox.org; a=ed25519;
 pk=qZs6i2UZnXkmjUrwO5HJxcfpCvgSNrR4dcU5cjtfTSk=
X-MBO-RS-ID: 1ff74546b71c080cfd6
X-MBO-RS-META: 1d3df5xeshc6anpdtytt7tkp3r3eh4z9

This series enables dynamic voltage and frequency scaling (DVFS) for
the SpacemiT K1 SoC using the generic cpufreq-dt driver.

Tested on Banana Pi BPI-F3, the execution time scales as expected
across different CPU frequencies:

~ # echo userspace > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor

~ # echo 1600000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
~ # time awk 'BEGIN{for(i=0;i<1000000;i++){}}'
real    0m 1.07s
user    0m 1.07s
sys     0m 0.00s

~ # echo 1228800 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
~ # time awk 'BEGIN{for(i=0;i<1000000;i++){}}'
real    0m 1.40s
user    0m 1.40s
sys     0m 0.00s

~ # echo 1000000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
~ # time awk 'BEGIN{for(i=0;i<1000000;i++){}}'
real    0m 1.72s
user    0m 1.72s
sys     0m 0.00s

~ # echo 819000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
~ # time awk 'BEGIN{for(i=0;i<1000000;i++){}}'
real    0m 2.10s
user    0m 2.10s
sys     0m 0.00s

~ # echo 614400 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
~ # time awk 'BEGIN{for(i=0;i<1000000;i++){}}'
real    0m 2.80s
user    0m 2.80s
sys     0m 0.00s

Signed-off-by: Shuwei Wu <shuwei.wu@mailbox.org>
---
Changes in v2:
- Move OPP tables to dedicated k1-opp.dtsi
- Enable OPP only on BPI-F3 with cpu-supply present
- Link to v1: https://lore.kernel.org/r/20260308-shadow-deps-v1-0-0ceb5c7c07eb@mailbox.org

---
Shuwei Wu (2):
      cpufreq: dt-platdev: Add SpacemiT K1 SoC to the allowlist
      riscv: dts: spacemit: Add cpu scaling for K1 SoC

 arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts |  35 +++++++-
 arch/riscv/boot/dts/spacemit/k1-opp.dtsi        | 105 ++++++++++++++++++++++++
 arch/riscv/boot/dts/spacemit/k1.dtsi            |   8 ++
 drivers/cpufreq/cpufreq-dt-platdev.c            |   1 +
 4 files changed, 148 insertions(+), 1 deletion(-)
---
base-commit: 5164e95565d3fd508ca8a95351323f5716dfb695
change-id: 20260307-shadow-deps-3582a78aa756
prerequisite-patch-id: 154bd4f720ce5065d58b988de8f273207b44572e
prerequisite-message-id: <20260206-spacemit-p1-v4-0-8f695d93811e@riscstar.com>
prerequisite-patch-id: 5da3e75b18291a5540d4f66d7a0600fb8975ef62
prerequisite-patch-id: bcf41917414ecef8cf743095d130f6004c32f6a5
prerequisite-patch-id: cfe3800f8c791ec4c63e070af9628e88e0fc31b9
prerequisite-message-id: <20260305-k1-clk-fix-v1-1-abca85d6e266@mailbox.org>
prerequisite-patch-id: 7c7fb9f87dba019ece4c97c45750349a7cd28f3a

Best regards,
-- 
Shuwei Wu <shuwei.wu@mailbox.org>

