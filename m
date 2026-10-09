Received: from mail-qk2-f3.google.com (mail-qk2-f3.google.com [74.125.230.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9844D501F4A
	for <linux-pm@vger.kernel.org>; Fri,  9 Oct 2026 18:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791570720; cv=none; b=cEJPJIwCaxBUOxTBqUCqhgMAE2PaJt2Jhz05910iWtxupgnqDZT/lGRQ9W3d3w5UDwHP3GY3Dz5d9FQXS2k6sxJzy1kP9aUvV4bbbS1cCpewNXsEtn8cUhx9SYc1gATs2M2vicLeuQ4sxuPGYZnV3PJirzSmdazMElCt7a6EwG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791570720; c=relaxed/simple;
	bh=zKnuEKqqe7edCKaus1RgpjuKXXy74FsY9bBojL49qiI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=erw6KUuJUgAQaClQ/xGJWGW0M3fy/fudgmesSUTv6nqCxXpQNRVNfpeS92yqZmKsfxTYSDWf4skvMaEftvucgyyO7FPRybVB6X1E8Y/UDvZcGZFCbPKQLS/pSJsixndN3YIn4UOWZlTdvVrPyrJQouwF52LbNBQfoWUB4ZmrAlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R8gWof0G; arc=none smtp.client-ip=74.125.230.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R8gWof0G"
Received: by mail-qk2-f3.google.com with SMTP id d75a77b69052e-5339079c84bso8075341cf.1
        for <linux-pm@vger.kernel.org>; Fri, 09 Oct 2026 11:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791570714; x=1792175514; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5+W1hX4qQ116GBN/dEZOF3zgezRpS4RsRBfyuf5dXS8=;
        b=R8gWof0GJHFYyCIgaBy1whxEwY4QTgNoKzzc/9stXixQtCybSBanNMorOBxkJiJYh2
         PdiuT5vOXZQUfryyPIA8MLclRWSf+OfY1Z7h33dVphSwgqUFnkkMOw1fWYe3iVfG0xlw
         2JTZvmcd+naHVt4j3mT7E+qSs6r1qzzY0CEMiMYKUMN3AQBz97H4BPKAua4Z93lXuKsa
         gDvtPqqge6F3utnTUh6vW6jmZjRZpTau8yiMXf0fv1/lRQWjNYsdLdL7zevLiQNhJKwT
         kj8OVAi8L1KAu/ep1qAiBwigCl3HYFLH3RRz0C6Eita7oZWI5GSLVN5u3PKqePzEozDF
         d+yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791570714; x=1792175514;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5+W1hX4qQ116GBN/dEZOF3zgezRpS4RsRBfyuf5dXS8=;
        b=sngF9rpawKFRHtmgC2jCrvWTz0h+v2N91iFicHvtboykxwqcTumowXRWcqWB9WP2N8
         XkW0DEF1vF2QhddcwMgYJsnGmQOlLBvx1QunnVUrF5lEpzMTwSzh3MYbAPmnSbKKTA+l
         WcFbKaMBGl3D0mChMcvNJMVWFgtSwz+G6FEVKTzCc3LJd0YL6EzRgdCVSxNQMljvYBZp
         axtC1UiiVDmRYxpDlsl+d5b789WzFoCiR0nUBOH1WMmdo+nJU3y2M8gKdKihbk67Bs1E
         NHPSxQh/lDnstemWJBNr6p1OEiV8g+A/NLLQQRvJH+batACxCd0pACkrVZ0JQgqpLcGi
         E9RQ==
X-Forwarded-Encrypted: i=1; AKwUvBxaGUK4r+duggURB40NAZaw11VT6GuhoNnyxTh+vqYO1OWmh/zUyrPyHWRqHhuOnSIvhdrMD1qm1g==@vger.kernel.org
X-Gm-Message-State: AFq9FYIfrT3eo+wRkMugT7qy3TVolXi/3+b7N0ioFgUWZhv2XYMGP/GX
	hRm/qSbja5X62QiGpGtSOI9wo9Wv2NVEtYomOZARtWWtcxVI5fiEU5bT
X-Gm-Gg: AYBFou2t2lfK1e2iSUn5HxvRVU8pUT6gBbryA2EDbdd0c/aCkYgsinhCa03PrBTv58u
	lyiFnvSQZraFFA8l11epxE4fq+0fWADuS6Ki65cTRpHcTnKbntS/ax7jRpdF1zCaEZ/OYq4FkOn
	+0Hwdv2oF/OA6vWNAP3WIDyamoOgZaOFzpvCvA2x5Rkc8DOaUyHBA+Ve/CsrndGBH5I8gcBRt5f
	Ob5oEbTvUaITsvXDElaSev7ckxZUrPl9UA2vaV8JP9z/g1+b3cw+rzQcFRJsZtFB13GjuQhwSXb
	+Bzw9NoQarXVkwJn21LDTURJ0BrdJY1y2hlvSXt2wfMBRQrwALfkbcZTnU9lG4dTEVLu85KUNia
	0gn+PIhovFxWoSkh/O+nLvusHUjkSLL6DRGZsv7m78AsZmfLHHvi6vZ8pD8aLEeX1CPBYQVyZKs
	/TjdgAuqJ4GcJAsyNrTZB/zbaPVHCmMyYGULtPa6FUZrN3c68s6+fq1pLnOemK/wjATidUFqsAu
	lFKCCYaUxIDzZnq11Y49kwloeS2SXJVZd48KGssr3BT2HNp/he73G6BfWe+VBH2Bg==
X-Received: by 2002:a05:620a:6844:b0:93e:7156:f814 with SMTP id af79cd13be357-93ec134f9f3mr293228985a.11.1791570714330;
        Fri, 09 Oct 2026 11:31:54 -0700 (PDT)
Received: from [10.10.18.223] (wsip-64-207-253-118.tu.ok.cox.net. [64.207.253.118])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93eb9898b5fsm245594685a.32.2026.10.09.11.31.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 11:31:53 -0700 (PDT)
From: Ryan Brue <ryanbrue.dev@gmail.com>
Date: Fri, 09 Oct 2026 13:31:46 -0500
Subject: [PATCH 1/2] cpufreq: mediatek: Enter system sleep at the suspend
 OPP
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-rbrue-suez-upstreaming-mtk-cpufreq-suspend-opp-v1-1-9100f79b4080@gmail.com>
References: <20261009-rbrue-suez-upstreaming-mtk-cpufreq-suspend-opp-v1-0-9100f79b4080@gmail.com>
In-Reply-To: <20261009-rbrue-suez-upstreaming-mtk-cpufreq-suspend-opp-v1-0-9100f79b4080@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Roman Vivchar <rva333@protonmail.com>, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791570710; l=1447;
 i=ryanbrue.dev@gmail.com; s=20260906; h=from:subject:message-id;
 bh=zKnuEKqqe7edCKaus1RgpjuKXXy74FsY9bBojL49qiI=;
 b=TKIssWZbu9V/Rs0l3vFTMGDGJenHiseLmnrhDQeH01mZIX62p3RKiyzvqCiREuXBeGpC/DcER
 7x+myhDBZs8CLEektz10sDGJuS0qBbKpqx4vsozFQjfwzRdJRvxM5Ep
X-Developer-Key: i=ryanbrue.dev@gmail.com; a=ed25519;
 pk=KsUvVaP//v/2q+ZBuacc7cLbsyEYn+AD71Sn28oZWKo=

cpufreq_suspend() stops the governors at the start of system suspend, and
this driver has no .suspend callback, so each cluster sleeps at whatever
OPP it was last left at. On an MT8173 tablet (Amazon Fire HD 10, 2017),
entering suspend-to-RAM with both clusters at their highest OPP measured
63.5 mA. With this change and the lowest OPP marked, the same entry
measured 52.0 mA.

Use the generic suspend-frequency support, as cpufreq-dt does. Tables
without an opp-suspend entry leave suspend_freq at 0, which makes
cpufreq_generic_suspend() a no-op, so they are unaffected.

Assisted-by: LLM
---
 drivers/cpufreq/mediatek-cpufreq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
index 052ca7cd2f4f..f9b1eca176eb 100644
--- a/drivers/cpufreq/mediatek-cpufreq.c
+++ b/drivers/cpufreq/mediatek-cpufreq.c
@@ -603,6 +603,7 @@ static int mtk_cpufreq_init(struct cpufreq_policy *policy)
 	policy->freq_table = freq_table;
 	policy->driver_data = info;
 	policy->clk = info->cpu_clk;
+	policy->suspend_freq = dev_pm_opp_get_suspend_opp_freq(info->cpu_dev) / 1000;
 
 	return 0;
 }
@@ -624,6 +625,7 @@ static struct cpufreq_driver mtk_cpufreq_driver = {
 	.init = mtk_cpufreq_init,
 	.exit = mtk_cpufreq_exit,
 	.register_em = cpufreq_register_em_with_opp,
+	.suspend = cpufreq_generic_suspend,
 	.name = "mtk-cpufreq",
 };
 

-- 
2.55.0

