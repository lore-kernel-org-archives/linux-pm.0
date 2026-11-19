Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795093413;
	b=Ba43heehxHXFsLna8RNj5iwzQpfsRGN/zlxXkI3TSfbcoG82VBnAl1+RI4AIwK4Oa0iR
	 o4VnUje5HhmLDRuVJjUrMP+j/WJdRCx0yPPhotk3cni89eCpcEVbbW6Vo0tvsAlFJbHa8
	 G/s+yTVPFJf0F0ickR7dKiDLnc5TjLgWoEWQ2sQrFZIuP1pFUrv2O1IDAXArxpMn7f1b2
	 rgiQk0IgclCANpZuyvhDGjanrF3W/RIf+QhAK+IzoIo/RzccE0U5GOHCiJWx7YMzpP7dx
	 IijXPrRBtmLnLWnbaOc5ozgDTwmp7Huy3tuv86vAIP1od3/p13baWum4x/AmCy3syxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795093413;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=o51PHHimL+ClplpmBAEFYhIc3zL6vyqqxZiEgSq/9kk=;
	b=c6s865dwcdqutJjFA5J6zUGjaiM8LDQwoEG3AXWfpiy0OTWvquJ4rbx7ARD3CjoXJ9dl
	 DfJ347EfO5OUR+7ZGh852kA7dc7KPw8uKyxcaqqhugdc28hIUzIcycHD1VFsOlb3uwd9Z
	 SARRJfyKGWLlzmGVR8vD4yGrqreHKJqMRF221Agy2XNStGKqjgC9P3exH6q3Z9ROIDnAx
	 MVpaKe+xKplyYtX/dsexRmSexnBd4ADIXhNAQ1CyI0mVo4ELUjQdxe+Rb8g/Vo5dd89CY
	 kiPx2Rr1ccdBd3F31AlcXDk3KbhYsLmxwVQJSUdKzLqVOWgiDkwb/uR13FZ4BCfVElA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=XIpGOD5C;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889F860A3804;
	Thu, 19 Nov 2026 13:03:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 889F860A3804
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=XIpGOD5C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1795093403;
	bh=DuZYc41EIsQ5vPMM6JdUB8Ec678Rzhjvat9GBAzov9s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XIpGOD5Cb5DjAA0ZabLiCv4ze3DgfMbJ2tpi4cFUqy03v2vs2HZqV9QyUpPFI9Ozu
	 nk8cg0TGMBP6VSX4rNsgUEAYf926lCNoaG7eygVm5W/otrQAZSB+yM63Qrz9duHfaN
	 g75Y+9phEsS6DodXEjmDPaaGPsz1gT5WL5klYvoJrQYvDyth37+hNkcMZKL20wfPB6
	 PHf9d3YDbNrn7zlKQuCG1LH97VDYRpQK6S1nHO/utaSO4sVrjA3t+Ez/HRRbcd96dy
	 Fv/Zot3cv6/GgxZn0XTEY97oM89kFbV93dfbKPbFxoCykLOW2w6raxC3YfL/VgMf0b
	 qmhkhM+zrCYSg==
Received: from jupiter.universe (unknown [100.64.1.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 3412717E0E2B;
	Thu, 19 Nov 2026 14:03:23 +0100 (CET)
Received: by jupiter.universe (Postfix, from userid 1000)
	id 985A448003A; Thu, 19 Nov 2026 14:03:22 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Thu, 19 Nov 2026 14:01:56 +0100
Subject: [PATCH v4 06/11] PM / devfreq: rockchip-dfi: add NO_INTERRUPT perf
 capability
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
Message-Id: <20261119-rockchip-dfi-rk3588-cleanups-and-rk3576-support-v4-6-517a68c008fe@collabora.com>
References: <20261119-rockchip-dfi-rk3588-cleanups-and-rk3576-support-v4-0-517a68c008fe@collabora.com>
In-Reply-To: <20261119-rockchip-dfi-rk3588-cleanups-and-rk3576-support-v4-0-517a68c008fe@collabora.com>
To: Chanwoo Choi <cw00.choi@samsung.com>, 
 MyungJoo Ham <myungjoo.ham@samsung.com>, 
 Kyungmin Park <kyungmin.park@samsung.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Sascha Hauer <s.hauer@pengutronix.de>
Cc: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, 
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, kernel@collabora.com, 
 Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1869;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=j987KwOe/JwubEnKA3HJbVtRAe1zsvHFfLC9STd9j4Y=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGr+85ptH5AWkEo8lZYozCO9+Jb5WpveWXhkK
 BBXUPKUWzznvokCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJq/vOaAAoJENju1/PI
 O/qahvwP/i0XIXshc8SFU0WKh64gHr7vP4+pamtVG8csttzBGw3zWm0ftVSzzrxbHyYDBoN/ZPK
 sc/B2ARTjXDPKNvhr7N5Qjawit8FxLKD0Ku7ynDVCEKCWVfBolhuf7LxuzlAmXplWkHt5AqVdZT
 NaW21sNx8oyh3xl2WZHtaRWafgqrgH1V4hJ7sdbLWku0iyn+n7gm0PBzbEwINd80ZW+lIIxT/SM
 H+bPkUuXJ6AsHQZgXdIyaZZMDm20hdhpuWSCTfeF2yVz9K2/IfJULC3pcrz3XUCLosQQOftLvtC
 RAinGD/KBYByD41ty2CwqVUFud6Qwl/xrL9sIp8OCM+5Z3mODQ4KF6A4PEhj9rCzYA9fATa2dY0
 6WMueaWwM0/QQyN/qDl5m87KIlfkcQkg4xdgaFGQj5BX4424A9Pzi7Gw8MNYr5yzJMj+/WTx9Pi
 mtVgSSb1joOZN1u3Q4/N72coYK2A8ZqvL1IxY8F6d0M+UYE/FcJYOqhzI3fATrXHjfOn+6ZIKBy
 Z3ehvwJozWJsV15OJpcmxqE7RxGlfJ1ANBYr1tEJ0yj1cUiGWrWNywdoROSfO4MaYNvFjsvTvCD
 xqmVB9Bmahk1d6mmJ7pPxI06jB383v0RTt1y43Y7H5i1wwwGfSNn6o3vQeZPq/C1SLE8jPwmPsA
 YMYrWjxLEl67yA8niMRonGw==
X-Developer-Key: i=sebastian.reichel@collabora.com; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

The perf subsystem's PERF_PMU_CAP_NO_INTERRUPT is a bit of a
misnomer.[1] Instead of meaning that the PMU has no interrupt, it
actually means that the PMU does not support sampling. On CPU PMUs, this
is equivalent to not having an interrupt, but for uncore PMUs like the
rockchip-dfi PMU is, no meaningful sample data could ever be generated
regardless of whether or not there is an interrupt, as it is not a CPU.

Since rockchip-dfi doesn't seem to make use of the interrupt the DT
provides it with anyway, this was probably never a confusion that
existed in this case; the capability flag was likely just forgotten.

Add PERF_PMU_CAP_NO_INTERRUPT to the set flags for the pmu struct's
capabilities member, so that the perf core knows about this limitation.

Fixes: 4d586b5724d3 ("PM / devfreq: rockchip-dfi: Add perf support")
Link: https://lore.kernel.org/all/20250619140442.GH1613376@noisy.programming.kicks-ass.net/ [1]
Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/devfreq/event/rockchip-dfi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/devfreq/event/rockchip-dfi.c b/drivers/devfreq/event/rockchip-dfi.c
index 0cdeb59e6d1b..43da602ef101 100644
--- a/drivers/devfreq/event/rockchip-dfi.c
+++ b/drivers/devfreq/event/rockchip-dfi.c
@@ -648,7 +648,7 @@ static int rockchip_ddr_perf_init(struct rockchip_dfi *dfi)
 	seqlock_init(&dfi->count_seqlock);
 
 	pmu->module = THIS_MODULE;
-	pmu->capabilities = PERF_PMU_CAP_NO_EXCLUDE;
+	pmu->capabilities = PERF_PMU_CAP_NO_EXCLUDE | PERF_PMU_CAP_NO_INTERRUPT;
 	pmu->task_ctx_nr = perf_invalid_context;
 	pmu->attr_groups = attr_groups;
 	pmu->event_init  = rockchip_ddr_perf_event_init;

-- 
2.53.0

