Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794929787;
	b=qh3n1rpELk5AwWdjhCJidlH6/87Y3endQFEaEFKar1RoZ5uEA88T8/L16PMUz/KFLYM9
	 FdrIuYX+ga/y/yo+QZK4H3MV034pMJdtC9zK6YCsZPYwhHEraxU7FSWHEBDMrm/KKQqm5
	 Mq15EL27ouXofZxQYq2cfG9Nh1dGQgs5X+N/tUBYViyA8KzRimz9qdXHvNyIv5LMjQW/c
	 6D8al9dG4EImsYWqrrO0akq+ERaDF5V2sBqKy6HpvwrAObri7cWdAtnJaZhPuxSJqwHaF
	 WkgkvrnMTFtNajPsWO+sNWV6cOT290bLMVaMget/zEFQsjk2YCn0zQR1NfgMaDN8GXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794929787;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=eqH6cZQiGjLhuS/2ILWi+rrdkrrjhLjr/7WBe6GgEY8=;
	b=0lHKFhza2Nvq6EQ2OdCGYiYnyO+KsDKRWO0SgeB2aoMGrb1Gy6Dsf6ul2GyIc96Q+j3s
	 rNSygJ/KT65QIJr8QLDc+nFtGn5+xpiSBhJFIGJbg6XAyu2pQ48jyslIrt5Nzyk26eIl+
	 7MSAVJgTCLmiPs1QrZEejrMYD6Ybz3P0IyF0pCh+pU/iN+zcEoI/abjpfxQ9bJTRVEqEf
	 4ZFOA7ZMkBYrkni8RQxyhfpBdrN9w8Tn9QHNxM5ItPmkAiNZOTS+zNN2ABS0ya0DWmU0z
	 ExY7l9/XdznIoHPBmMv3FDjgeSIIZe77xjlsPpqTqUuzJvO9ZNhY3oCDyurKC+NGlbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=U0103C45;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97F4606A331;
	Tue, 17 Nov 2026 15:36:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C97F4606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=U0103C45
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1794929785;
	bh=EiBEmR3LHY+sgbARPDBZaZQ/gKkn1le95Y+SIanav9Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=U0103C45bXHqaXdtslgU/lln4Khf8Jn8Je14+x0F+uQlAQsOJALDbKShWPsiNtDfQ
	 ibpU5xUzMAHb9RAAnnId1Cdae1OmzlV1jT1CwQ3AmQb8qR+QQi/k3PlhmmFUUDOQwK
	 cmOvfWOINIBAhzBjrFVXQyLDEE2jJknnD/kNLdhI8a+OxuRsL5blQJYIf0/P1PqUWt
	 HbRM/VPKEnoUgvrYttYqt5nnc8YVnYReoCwf29gL33/qi1HhVy4aVFiaPmuTa7t3Hn
	 jUue0x3NRqSnyd/FpyViOsmY58nWAJlEb5m7Dx476aajGR/6LulVjL/y0YdVYHlIKg
	 gj2jQ7yj+PBXg==
Received: from jupiter.universe (unknown [100.64.1.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id E228817E11EC;
	Tue, 17 Nov 2026 16:36:24 +0100 (CET)
Received: by jupiter.universe (Postfix, from userid 1000)
	id A055A480035; Tue, 17 Nov 2026 16:36:24 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Tue, 17 Nov 2026 16:35:40 +0100
Subject: [PATCH v3 4/9] PM / devfreq: rockchip-dfi: add NO_INTERRUPT perf
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
Message-Id: <20261117-rockchip-dfi-rk3588-cleanups-and-rk3576-support-v3-4-32ff1546b0e4@collabora.com>
References: <20261117-rockchip-dfi-rk3588-cleanups-and-rk3576-support-v3-0-32ff1546b0e4@collabora.com>
In-Reply-To: <20261117-rockchip-dfi-rk3588-cleanups-and-rk3576-support-v3-0-32ff1546b0e4@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1865;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=D5QqaQ5H3Rmhk0ZavI0Pf3JPtYfcwnNt6k7hxKDI/Gk=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGr8dHgvCRs7tMBXBCK4g5Of2ePwScgpdOV96
 mQHMZX4OaYV44kCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJq/HR4AAoJENju1/PI
 O/qa86cP/0xndY5AkCv+lLJSeOWcAOT1yHGWXPr4LXZIY01COwNcac/mrdYD3CoJkewn8ZT/LW6
 mbtci7U+g6+S54rNLgujECFlGg2ryfhyamV0cgWowOTVu+HBvrA3X5V/G+cg/vp6QPKJYELuH4P
 DgWgso69jWWNgLuSYryy1wdXU/VvPdi/o22Rq7BM2VB3meEHwyTqtIQndDxDqcHguTDPlvgFCq0
 HkcvNnMGsww3oCD5mpiekSIMP7wvhNp92NVxxW1sCkV10w8N+rTAXJwbrEuBcpj1SWiRbt1VDaH
 zezvHwK5shoZyZ82YiWicPc1N4MMnBdA+xQQNFHeCJKn5lFcUGSehmC1C7KGWIavjiKVWN/viSW
 vkOKM+f5X8aH7k2hmDcUIvB7yk/PZbsSjdy3gfGYKX85M7lX7UJNnFtAXN1jxMdUICheeyYl8eJ
 Xp89G7UiKSWidx+DlaFEI6d+E9LruyeaoZ5dAu7RjjTHiNH9BPHfZJAC+uj4TIRHoInGhyoA2B5
 J+101MUzGAkbnCecuseJbq3t5YTqxvj5S/zdDa3WVVTusRsubNcBTnOcgFCdmFVfDIbVZgekgub
 uX7+bWtx+8pfklKEwFmHWVydWl8jVYhPhRAoA+GnHaIl4fsk60awvV5Uke38gGcIE2uv4RwXO2u
 6EUjM4/3Ti18Jb/18+lAssA==
X-Developer-Key: i=sebastian.reichel@collabora.com; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

The perf subsystem's PERF_PMU_CAP_NO_INTERRUPT is a bit of a
misnomer.[1] Instead of meaning that the PMU has no interrupt, it
actually means that the PMU does support sampling. On CPU PMUs, this is
equivalent to not having an interrupt, but for uncore PMUs like the
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
index d02a01188ea2..eb47a1f622b1 100644
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

