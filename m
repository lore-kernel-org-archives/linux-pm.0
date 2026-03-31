Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8982DCF57
	for <linux-pm@vger.kernel.org>; Tue, 31 Mar 2026 18:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774980165; cv=none; b=mFgRgpXwR9hTjGueb/eZ4iTx2ScJBwpzTUP5C0f5x3yw8XpqEsUyx8wKI9XSDo0XHmoFN79Rla+SG0HQi+/zu50zPeLfDd6Yx42XYyLAZNrZ/jakFyMFH+ZGJ1p9Jfsrbf36c3mWRTojfi8sdq6AKtPQDxQyGqf6pZ0bc8NHb0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774980165; c=relaxed/simple;
	bh=B80umtLIZS5subJgAr0wxYi+vOd9cDmQ2COsNCERNps=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fj6N/q/f6O2e0JKsBfv/30AR/c3lYCFIUMUXwAzGpBi8exRzjsWUcoSpSbruNVwpBquAhxsxyvPTp2+rtRBjpBIuR4yFeAxhjitFAN8oAFed2SnzQWIseMXx9EiKoBNcev8AawehzxjTEdxrCoTvk8rPe1t1JBp5Y6SXoXkn1xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=orb.net; spf=pass smtp.mailfrom=orb.net; dkim=pass (2048-bit key) header.d=orb-net.20230601.gappssmtp.com header.i=@orb-net.20230601.gappssmtp.com header.b=If0Hxwm8; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=orb.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=orb.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=orb-net.20230601.gappssmtp.com header.i=@orb-net.20230601.gappssmtp.com header.b="If0Hxwm8"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-354a18c48b5so5568472a91.1
        for <linux-pm@vger.kernel.org>; Tue, 31 Mar 2026 11:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=orb-net.20230601.gappssmtp.com; s=20230601; t=1774980163; x=1775584963; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sWjwEy9m9KvnFnDU5TKVoimvwkRXdMUl6feyPSdFKhg=;
        b=If0Hxwm8tJOrFO3fXFpXlJsHp5etCRn8n9DREFeIbprmuXezUPRkn4Nf0WvYJdwUZE
         tCvNcfrF9h7kB39l/wnBXPNHeZpMMnHW6Ghrpd/FNZBwhmSbfkwdFJSoEf5wA1aWjIka
         aEdrIkcoHXZrOcElslSO3p9E7tmDDIkvTMwVZd54zzSwzUZ22h4NrK9LMGZhL8l3kfJ0
         BuruX1u8jeRGqurgBIVh0240KGv7k/TKKfNnnLj+a58WDZNlSf49seltQToHsS46O1NU
         nbmchfPkfLCIstTP5ZRvUUyWoeqmzjELLKAB+w3B2nuuLzL6QcROr4TuaO6QgCmZhvh7
         dg3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774980163; x=1775584963;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sWjwEy9m9KvnFnDU5TKVoimvwkRXdMUl6feyPSdFKhg=;
        b=bb5VVe4vk3vpYb7kd/4Wz3ymetUWTwx+yiR0vlToSilgio56S4N0RWJLQjQOyWOhGR
         TD03igrAd8WwWQzDWlPVeSptI1VmnDeLqoAd87ouigEle91Q42rJuBMHxAILPj9Y9vN7
         kjoD6s/5x3ZP0QfdS+C5yOh3Q/XSNBTk43bKK8S4hCY2kLjiIto7Q/vSFA2fp4gSpA9U
         lfus8JKY1jkDaJ1OQ2XYHaOm5zq3so50cB0xFYQBjSOPbUsCE4qfcpbNtyLyiOSpR6wE
         WmK9hIa4NAdmhzfeI/Bon+meqRtB7bcF3wik5nKOXT4WcmPm7JxIzbix3XPG3bwUZLh4
         ilaw==
X-Gm-Message-State: AOJu0YwlISK1PkB41iBTTDrGSYfIYe/vLG7agFB70v9VKJXlz6eR4At4
	d8flpeSj/rbynxu3m0Fidswrpi57wLtzcoeHQUlg0kSkWhxB6yiLGwCV8YOHX6tmLQMHzdBgq6c
	KIz4R5D0=
X-Gm-Gg: ATEYQzx6aTSLJcigU87kvpaULiZlOfFKAeK3ZPMPjf4wicP7d0ajPtc4+KaVvSZhimQ
	EXcvkQHVAVuVg6q1FDlFuAuHERfoWuu0qdkS86ThtTEH9tHetPsRHPslGWTnXNLF0BgK/e/iGfp
	zf7C/7drXpyRDHxm+GhLd266rux2N3aJQfUUXIaLqCAZVCMMijSuBxx/qyU6cbZYGihi/HMZfSx
	X0G+LUvbs9OppNwvKAMglekePdvo1NZp1ZGabKXPutBcdAAk+v01UFJYsPNNvVTDflrFzsPqKCD
	nVJSrjxmKJ6bJIdkgn/+Gmdql7MNkUlQ/7h/u2YbJPQOdiuqalWwqacJfp3ItVTnhVj4uhdEL3j
	IDPpbbo0jIYVMAHyH7e9bfTKIuE3zxUBQZNGUo6D28RDJwUdFHRL3RCG7bJl/1jA6g47RPMy/Ft
	gQqovwRGXRi07IyheHDhIUYtS5K0Ifcl3+E3j9hxzB0oRTTCAllxoYuC5++0/XMbLed0BR89ZMo
	cdeeA==
X-Received: by 2002:a17:903:a86:b0:2b0:571f:6f07 with SMTP id d9443c01a7336-2b269d05c7bmr1235555ad.39.1774980163386;
        Tue, 31 Mar 2026 11:02:43 -0700 (PDT)
Received: from claude-dev.lan ([50.125.94.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b242680132sm125240315ad.32.2026.03.31.11.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 11:02:43 -0700 (PDT)
From: Daniel Bozeman <daniel@orb.net>
To: ulf.hansson@linaro.org,
	heiko@sntech.de
Cc: linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Daniel Bozeman <daniel@orb.net>
Subject: [PATCH 1/2] pmdomain/rockchip: skip QoS operations for idle-only domains
Date: Tue, 31 Mar 2026 18:02:22 +0000
Message-ID: <20260331180223.1682283-1-daniel@orb.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Idle-only power domains (pwr_mask == 0) cannot actually be powered
on or off. rockchip_do_pmu_set_power_domain() already returns early
for these domains, but rockchip_pd_power() still attempts QoS save
and idle requests before reaching that check.

On RK3528, the idle-only domains (PD_RKVENC, PD_VO, PD_VPU) have
QoS registers that may be inaccessible when the generic power domain
framework attempts to power them off, leading to synchronous external
aborts.

Return early from rockchip_pd_power() when pwr_mask is zero, matching
the existing guard in rockchip_do_pmu_set_power_domain().

Fixes: 1fe767a56c32 ("soc: rockchip: power-domain: allow domains only handling idle requests")
Signed-off-by: Daniel Bozeman <daniel@orb.net>
---
 drivers/pmdomain/rockchip/pm-domains.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/rockchip/pm-domains.c
index 490bbb1d1d..2eecae092a 100644
--- a/drivers/pmdomain/rockchip/pm-domains.c
+++ b/drivers/pmdomain/rockchip/pm-domains.c
@@ -640,6 +640,9 @@ static int rockchip_pd_power(struct rockchip_pm_domain *pd, bool power_on)
 	if (rockchip_pmu_domain_is_on(pd) == power_on)
 		return 0;
 
+	if (pd->info->pwr_mask == 0)
+		return 0;
+
 	ret = clk_bulk_enable(pd->num_clks, pd->clks);
 	if (ret < 0) {
 		dev_err(pmu->dev, "failed to enable clocks\n");

base-commit: bc330699801d3b4f99110365512caed5adcfaca3
-- 
2.43.0

