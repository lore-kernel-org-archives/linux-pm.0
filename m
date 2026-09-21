Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC0B33937F
	for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 03:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789961865; cv=none; b=ZR2kRyJHCPZCnTcH/o0U9xYuBWfvgwPNhKuQO24QFQ/9gUaHXBLtJ6/BV8bfvE6AXxfJkp7rXvCW7oFvqSgJUDtM5vWKctH6Ld3etCqYznxoDa2x2NIQNU8xjFug4nQwUP9ZsCwl90Uh9ppBozN76xmmsjzhk1wFiwK3Hi18eQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789961865; c=relaxed/simple;
	bh=k13YmX7qihqE61VqxeV0hzmnuwQKmXHbWHJrlo38j/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I1BgMerHG1OPwtPXbRkIttjl6gv7cUVsrii7Xa9G0FsJYCpYblybPD3CGz0DjJwO3Rk2f9v+aYG+lwz2GqJs8PuYQsRCToo+LyzJp0//w2bpB9UWw/tcN4HrWvZ87hwinUniqxkiSRSkuloy8SXIQXRwtUHUoVNIhRz6QxVimMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GZAlgQ+V; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GZAlgQ+V"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d747f066d8so8995705ad.1
        for <linux-pm@vger.kernel.org>; Sun, 20 Sep 2026 20:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789961863; x=1790566663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2A7bjFDm34OFInSMA2wk1n5UqXeKw0k+y9VVpS6ySqY=;
        b=GZAlgQ+Vk+O2eYl0o9woOpsI2b7977sWu43s9QgsRftQG727HYYXGSBYL0ytxwQSvW
         h31WTWwXYSC4ZEvHBEQ8PROzAnSQUIQ4LVJ5egXZ7YS0D76Z9KtWVLf1lAeBPgxtUm5A
         0oHW1HjI9QeH78IxtyVNEwRSllYHOOeJSylijIlPat3GKM69DFCr+dXt7eAqEQ5r3ztP
         pxqRINvvea3SG8myOt/TEh6UDvsjxhWBidWl3MDb0eD6P0ZL49nMj+GTLegm42NknUtR
         gHFf7TJ3DPd/AfprJLTSCqlTkV245oyl2Mi3FXd3OeuBxHx5X3VFe6pvRHmI2/5XXeWc
         zP8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789961863; x=1790566663;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2A7bjFDm34OFInSMA2wk1n5UqXeKw0k+y9VVpS6ySqY=;
        b=hdEkKcXO+/K2SeQzUBb16ZKZv8dILUiJhvBIqFRg7ovvv20P/2fH3NTCHcS7cYI29c
         1I3bGvN4k8gzP8hIWFB9g5oMmAcjLlZ5yVhCtyDE98IT1QptteC126GqiPCdB/peJh1V
         pzPULc5SnF2oRVogLmrfxrFujdYh/mhk9cMcSUrJtOW+Ey609PjasEF4M2HR3ItcROU5
         vmzfR2sWhOQICcGvZ1ZR+nU2ZqbKjMOJT60HAH0YIuvEzNqm1xstcwjNfLyWQKsrY8ZV
         BvLha+HYUvGbojRIb3LDjUzLyTPPEYy3WcSPitypK/gBpEadT2RpTr9RBuISCRzUqcnx
         czUw==
X-Forwarded-Encrypted: i=1; AKwUvBzXYPAQCc0bUA0QJBzwmcaRqhBnHxTkyvcMBw2x+OJ1HuiB0vsCoag5osxemV5AJdELAayhcrAvxw==@vger.kernel.org
X-Gm-Message-State: AFuF++n/nIxejEI07xE/mXPBRgZuJPSGvpouxb4dC/Gr0C+/ttpClE3B
	Mk4Yma7MFgumkyNfQeraiGc5lrhAw/QFcSnEiOK65rKG0zAPvKQL/Xr0
X-Gm-Gg: AYBFou2sjjqgkWMS6+lIkvEWEa2UD/ZbC26YLjT5wjLc8fErN4xHKphYvIsjK3XVRLn
	w1lI0wFOZVrr76nEWMQU1K19I3hNVRNjuz7ipaZj8jHlOxlakdDWqphS802lHgeBB0jhrOgDHiU
	86JrYoZ/+PNRXspbmoM10QbdV8EHrF9USJjoyGYKskgpqPYfSmWgspIECHhdgMMYh80n89Tdtcj
	fXwAhBgZmB1SFODL6Qs+xnwmT/cMF/k5fxZwQrZBlpTNqrO3F3kM6rNA3CDW/bVgZFvQh0rr41B
	t20K78qS9RP3gvJytxy3IxAV3wSZu7nFRIzy6XRYimUU16//aAqJfRkIbnqe/A4YWjYc0ZSn86h
	vW/hb0HcUA4GmYBeITO8TmuFP/I0KyeLw4dJqPngo70Irv/nuOJK5gMOzecCpglUwNNcn7shith
	u7RWZH0CfecPsPjM3AsLDisiN54Fsn21XxxE4ypJ/wCxP1vXrXPx1j3wtnPC/yEESnTmLRIc70n
	xIc0puueDhKrA/3tR+twQdvg3yS1BTrZA+EFFyZtE37XlG0U2QBddxa0MIXnDR2sw5ASng84ZfP
	9mcdiNitLPFWFQA=
X-Received: by 2002:a17:903:38c7:b0:2dd:c100:2517 with SMTP id d9443c01a7336-2ddc10025aemr64473935ad.32.1789961863038;
        Sun, 20 Sep 2026 20:37:43 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ddc18032d5sm25966515ad.83.2026.09.20.20.37.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 20:37:42 -0700 (PDT)
From: phucduc.bui@gmail.com
To: Ulf Hansson <ulfh@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	rafael.j.wysocki@intel.com,
	Jacky Bai <ping.bai@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Peng Fan <peng.fan@nxp.com>,
	Xu Yang <xu.yang_2@nxp.com>,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>,
	Ming Qian <ming.qian@oss.nxp.com>,
	u.kleine-koenig@baylibre.com,
	Marco Felsch <m.felsch@pengutronix.de>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Guoniu Zhou <guoniu.zhou@oss.nxp.com>,
	linux-pm@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	bui duc phuc <phucduc.bui@gmail.com>
Subject: [PATCH 3/3] pmdomain: imx93-blk-ctrl: Use pm_runtime_resume_and_get()
Date: Mon, 21 Sep 2026 10:37:08 +0700
Message-ID: <20260921033708.14433-4-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260921033708.14433-1-phucduc.bui@gmail.com>
References: <20260921033708.14433-1-phucduc.bui@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: bui duc phuc <phucduc.bui@gmail.com>

Replace the open-coded pm_runtime_get_sync() + pm_runtime_put_noidle()
error handling pattern with pm_runtime_resume_and_get(), which already
does this internally.

No functional change.

Found by manual code inspection.

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 drivers/pmdomain/imx/imx93-blk-ctrl.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pmdomain/imx/imx93-blk-ctrl.c b/drivers/pmdomain/imx/imx93-blk-ctrl.c
index 243ce939ba68..6d4c55a85c64 100644
--- a/drivers/pmdomain/imx/imx93-blk-ctrl.c
+++ b/drivers/pmdomain/imx/imx93-blk-ctrl.c
@@ -152,9 +152,8 @@ static int imx93_blk_ctrl_power_on(struct generic_pm_domain *genpd)
 		return ret;
 	}
 
-	ret = pm_runtime_get_sync(bc->dev);
+	ret = pm_runtime_resume_and_get(bc->dev);
 	if (ret < 0) {
-		pm_runtime_put_noidle(bc->dev);
 		dev_err(bc->dev, "failed to power up domain\n");
 		goto disable_clk;
 	}
-- 
2.43.0

