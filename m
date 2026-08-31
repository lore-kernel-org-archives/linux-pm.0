Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1D0356767;
	Mon, 31 Aug 2026 04:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788149393; cv=none; b=JbUnJraIY01mhO+ZA7J1mxjbe4XVreZrZQqWZ26BIMpSSnoUVHlAivbvCs+CUDs0NqFbqj9q/Tpjc7Gvkkloj98+h5uVAHywNjC1n7Spqp3gaTy5R2bTYvd8BStxC/xOearAp016jez8xqwq9yrKU5jMD7knAxc2e3f6Ykyo6xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788149393; c=relaxed/simple;
	bh=i98h2KyVaWOr/iBF7stkkIKZk/URJTaweBKbY2mKOOs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bGtff0DKLErnp6V9hzv3sw4uNsJo+yVIjG0VNFalhSsau1PBGcoDueNXp6Toi0phQvucYKJIq0mwbxc6UFMIyzAadsBMf9zrZq10rAS77LdSkQ6YNAKLthdikGd43c+hn0iwBaZ3LnVAFG6ngpwHSHiA8K/ZDj+/3KR2SgugziY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com; spf=pass smtp.mailfrom=gahingwoo.com; dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b=RpuX0EQf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CrAK4gPb; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="RpuX0EQf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CrAK4gPb"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6EAF87A0014;
	Mon, 31 Aug 2026 00:09:50 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 31 Aug 2026 00:09:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1788149390; x=
	1788235790; bh=EuzlYllSmAZP6yajMRsW2NaQ/7lmKof72TRcxeRmWS4=; b=R
	puX0EQfi7AtJ2V4r3WiOqNyjdmLwvbsrOtuXRljXnKxqyhuP0G2Qe6hyNT+LWkfT
	10rVD9XwVTFrtN07lJpGfd3IRIlt/x96jkYMZ3eXUL3Dj4QBu15kIn4hLTegD8xE
	XgPj/k4IOrCV/hYCjUwCWpauiCMmUVe3KWH0pg7EA8MMCaYgiGzafihb48eRt8pN
	6ozgdFyhhvV9EhgVnQUUiC+W0LaAUkH8NEkIQSHOD1jyYZrvNEje/JQ06fs5le72
	Bw6nqSo1gWGk8AtEB6Og5bYjIPbGBX58n1DjO91MH5ZCjzyMAcxDo2KpDP/JHaGu
	BOVCcfbUZhu96tEfqL+0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1788149390; x=1788235790; bh=E
	uzlYllSmAZP6yajMRsW2NaQ/7lmKof72TRcxeRmWS4=; b=CrAK4gPbj6j66pdIh
	XQEbFwWaRQQJiJYFMS4Ja9XR88LYTVJz7Q3KriJmIZmYCjEVZIcG8YUBU4X4PoHq
	YJ6Y5gr+lwcoCB4iBjwWYT/s5mQXSW4MFH3A3zKUS51SNe/kOXXTNZ3vMVbLIHgk
	We+RbYn424eWXGwGFZUDzaBLS305dHovaMwhPjKIniP6FBVrcK7plihjpdWGIiAz
	wTc2tuB83Yq4lVdnYKmUhhH7ib+kH0EUKV7wkrHBI4OM1TIvBc2Ba+tACV78z3VO
	cqczxcjsK3MH5gmlaXpaTH8jvl/fvYsPjUdHCeqWw5EgrrQLWYsW1bZEDB0nngWp
	cQkaw==
X-ME-Sender: <xms:jf6Uavr1MXqn8YZAIa6UHneOnHBJbxEajkKjkXEfT0mnq4jaHAoRIQ>
    <xme:jf6Uai-JGmr5nK_ZRn8NyhBd9zpnKvZEeJkCs-cI73oeoghx941MBLic9g2bCeMUd
    rWYOWvJvzSAsgtFCryiL4e_NQVY88OGVgJTxVYlNvSv1qycnNteMrLp>
X-ME-Received: <xmr:jf6UakMMsof-xMSdFmvGtKQbVQ-QSE9uzmSw9kR6Bk5O073Y1UoqkHG1gKo1aM5fxFt6EQs7cw>
X-ME-Proxy-Cause: dmFkZTFrmGdraA1wQ3u7fSC2szCs3dTKzi/Amki67rwemwxet7nxM0ToJ2yK8NWZy80VBj
    m9nFeJFSLUsMmp4v/avaroH3z5Dq6jG4k86bAf0y32LtQ7RQOAYU0EDi/Vek7cY9IfGAli
    KbguFiQRUm7Yej/X8Q7usb0aRYgmhdttAZZaV7gMFf/0gCkGbI0GMXhWHVbjxOciLjJdey
    nBHFTEwJHw6b/X1tteAoW5feajlR4udOAumKRJZOKSBxp0+HOuOhd3F7jLrJp4hskYXnWm
    Yfl8tng267MYxnNxKDOVFuoUTQiqdV/pQsZF1H5QJFaOThb9EnTKuskqcvPNlFdWCr/4ZG
    oWtZALAKNwaFh8GbgGOJ4tgmkNtHhsfG3F1DmtHBe82up1ge9mWg+CAi0zjl3RqkicmsXL
    8YHQ6+1hNi+42IwunpyqKiQqJBQlrMMy7Z5sKusOo4ogBtvKkNcYBPANqjfgtfKmlTWJDF
    jdXkxNFGqfIHMxcmVOUSPNXOn8T1X54Qj+q5IpX6HMSB4xL5O2yJYqg4/y/63dkvEtbsEc
    dBv28F/4IC9YltHiKet71xqBUZkPl9f910VteQahAQvMAm6pqjWo3RuNQEwWilkbKrPImj
    o/BjhGrbK6RhfiKB+p4RNCJFQlt0LN+DM7uHkaXT/n+2IEpJOG2uVsecdPGQ
X-ME-Proxy: <xmx:jf6UasnJpmmy1BjCE8SjIUYBn8M6-uRHYfjFjIPd8i2JqWpfPUAxqw>
    <xmx:jv6Uap8qjMybAUNUxqVMmfnGD3MyOhLBBp20NU6ClQJt1WRmqHOjbA>
    <xmx:jv6UalNXhOrPgVdkrhyhtoxK_c8eu4JeFnGjQVVOD4asjUCWlr5amA>
    <xmx:jv6UatHW9cReFQTNTGuK21ZuXOuM2RpyIrmQg21KPL_tEhp_MjswCg>
    <xmx:jv6Ualc0pMuDwbxMXx4R63frKfiOrPf_LRHEOd7EnA6SqJPN_MXV0QEx>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 31 Aug 2026 00:09:43 -0400 (EDT)
From: Jiaxing Hu <gahing@gahingwoo.com>
To: tomeu@tomeuvizoso.net,
	heiko@sntech.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	ulfh@kernel.org,
	p.zabel@pengutronix.de,
	ogabbay@kernel.org,
	zhangqing@rock-chips.com
Cc: royalnet026@gmail.com,
	u.kleine-koenig@baylibre.com,
	chaoyi.chen@rock-chips.com,
	diederik@cknow-tech.com,
	alchark@flipper.net,
	dri-devel@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jiaxing Hu <gahing@gahingwoo.com>,
	Abel Vesa <abel.vesa@oss.qualcomm.com>
Subject: [PATCH v10 09/13] pmdomain/rockchip: cycle optional power-domain resets on power-on
Date: Mon, 31 Aug 2026 16:08:00 +1200
Message-ID: <20260831040804.24111-10-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260831040804.24111-1-gahing@gahingwoo.com>
References: <20260831040804.24111-1-gahing@gahingwoo.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some Rockchip domains come out of power-on with their bus interface in
an undefined state. On the RK3576 NPU this shows up as a hang on the
first register access after the domain is switched on, and pulsing the
domain's resets at this point clears it.

Take the domain node's resets if it has any, and pulse them between
releasing idle and restoring QoS. The resets are optional, so domains
that do not list any are unaffected.

Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
---
 drivers/pmdomain/rockchip/pm-domains.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/rockchip/pm-domains.c
index 39988efd8..8f2fd8a83 100644
--- a/drivers/pmdomain/rockchip/pm-domains.c
+++ b/drivers/pmdomain/rockchip/pm-domains.c
@@ -19,6 +19,7 @@
 #include <linux/of_clk.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
+#include <linux/reset.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/mfd/syscon.h>
@@ -103,6 +104,7 @@ struct rockchip_pm_domain {
 	struct clk_bulk_data *clks;
 	struct device_node *node;
 	struct regulator *supply;
+	struct reset_control *resets;
 };
 
 struct rockchip_pmu {
@@ -692,6 +694,13 @@ static int rockchip_pd_power(struct rockchip_pm_domain *pd, bool power_on)
 		if (pd->info->delay_us)
 			udelay(pd->info->delay_us);
 
+		/* Optional: some domains need their resets cycled after power-on. */
+		if (pd->resets) {
+			reset_control_assert(pd->resets);
+			usleep_range(10, 20);
+			reset_control_deassert(pd->resets);
+		}
+
 		rockchip_pmu_restore_qos(pd);
 	}
 
@@ -861,6 +870,14 @@ static int rockchip_pm_add_one_domain(struct rockchip_pmu *pmu,
 	if (error)
 		goto err_put_clocks;
 
+	pd->resets = of_reset_control_array_get_optional_exclusive(node);
+	if (IS_ERR(pd->resets)) {
+		error = dev_err_probe(pmu->dev, PTR_ERR(pd->resets),
+				      "%pOFn: failed to get resets\n", node);
+		pd->resets = NULL;
+		goto err_unprepare_clocks;
+	}
+
 	pd->num_qos = of_count_phandle_with_args(node, "pm_qos",
 						 NULL);
 
@@ -931,6 +948,7 @@ static int rockchip_pm_add_one_domain(struct rockchip_pmu *pmu,
 	clk_bulk_unprepare(pd->num_clks, pd->clks);
 err_put_clocks:
 	clk_bulk_put(pd->num_clks, pd->clks);
+	reset_control_put(pd->resets);
 	return error;
 }
 
@@ -949,6 +967,7 @@ static void rockchip_pm_remove_one_domain(struct rockchip_pm_domain *pd)
 
 	clk_bulk_unprepare(pd->num_clks, pd->clks);
 	clk_bulk_put(pd->num_clks, pd->clks);
+	reset_control_put(pd->resets);
 
 	/* protect the zeroing of pm->num_clks */
 	mutex_lock(&pd->pmu->mutex);
-- 
2.43.0

