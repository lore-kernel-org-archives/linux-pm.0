Received: from flow-b1-smtp.messagingengine.com (flow-b1-smtp.messagingengine.com [202.12.124.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A003740961B;
	Mon, 24 Aug 2026 11:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787569854; cv=none; b=U1PnaQfbnMvgV1XfZFwR+iYzzlL3ekt6rrJvhEGaMHFZ2T2dL6mUuMKZfB+Lm1Obxyao6gcAOuHrWoZE3pY73kbW6UyrQDBFBzsi+cmSrl89pBrbUkY7m8LyOLiNm+nAW0ZUd089GZaBs62zX8nZinf3R9Y8U37oZBA+Z+q6G28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787569854; c=relaxed/simple;
	bh=BINA7y08BvXk+5tFUCvn8rDGzX4PaIC66daBZMXhtDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RBTCZypAmV2d0xGJmuFcE/QWB5V24lpVuU0wBPSwzYBoc/sBcJzs2Q+5UJTbNsTYrvA4SkFR7ocfNAMxyaAv62a5BwPbY/oluPVgPybd6BVgBqUEiQoJZxqzMZNbK4Fnq70pyLJOmZhQ69Du7O6/afYA7LduI8l5K9kf+qryBl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com; spf=pass smtp.mailfrom=gahingwoo.com; dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b=UZPHpISu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Gtr6IdlL; arc=none smtp.client-ip=202.12.124.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="UZPHpISu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Gtr6IdlL"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailflow.stl.internal (Postfix) with ESMTP id 188421300135;
	Mon, 24 Aug 2026 07:10:51 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 24 Aug 2026 07:10:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1787569850; x=
	1787573450; bh=fS23uuCXhX5KBwhj1s1IBkURLfoPr5JSNb7BdIodlrI=; b=U
	ZPHpISuNKo9w7NsNxgl6BG7j2H58GpeKitmHUoxqzBW+AGiFF/YVOztR9XW1/cQ2
	/cAXM5XkJDhjypP1V9/b7Tp7wu6v2PCwqDn4zfwiW/lZZ8VQIDHE+noDKSf/nyAp
	uhn+FLPiJ70gsGg217i51UaIXinwkheT/4PRpx6ONuAu9C/KWrmIcxvb6tjNoVAP
	/ccfPXDXEpYR2JT7QKVepqCo2xiYapkHynBQXx7fHdYbx9YnmOHzgXvlQS3HhvhX
	JhMHYnenbci3bKjKqjTO8nAuWdjs4QjLpVwFY1K5iQqgmOh5oOwlvUU+S+km9oDp
	C7Lq9NHtzJwu70ARammqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1787569850; x=1787573450; bh=f
	S23uuCXhX5KBwhj1s1IBkURLfoPr5JSNb7BdIodlrI=; b=Gtr6IdlLFo5ejsTxG
	1eidgQSjppzXex0atfR3sqhpYLwfRRbxQqgVdVMT5IxPEWM5aWdhBAs7+qN/mYe5
	qa4kmWrOXe13mDXKSKrx2ZUXzP1RtG2HXfH05+igTkasN167D2exc5CF9Tush5Qc
	eVLRGYHyyEwOPJqzouN9TC/lm1HrYBsU94FVq+LmH2Spc/XSt6oum/rVPADp2lVz
	mzRd3uQl7IqdNc5HJIxtHmn1z2itpjHJUG+ZRwHV08YjLrnuo8gLO9H1cG86AiQ+
	fURsvsH22tsqdwyKxSON7hCvx2nIuoBbZrlOmtsFNPPiKmeQGTeHtXscRMIJCF9e
	BDbBA==
X-ME-Sender: <xms:uiaMapTWLFIxvPoaCRo1dnSvMBkUbs80JOicpQa8lBP4BleQG_DJXA>
    <xme:uiaMairUMo9hR5wl2pmwNTUgPt5H4Jc-DT3UlgKRzXIQDwD3afUTKO_LiIuIyQJdr
    AZDJ276mNs1RfxSG8c89bMk2zDxkwBL3BBaTCjugvR7759nWwG8maw>
X-ME-Received: <xmr:uiaMasIY0vzz8oEPTUy8FdCnod77BgrlHj2Je6YYGnm_JFhZN-3hQLo8kWy2WFAvF1r-LojDRQ>
X-ME-Proxy-Cause: dmFkZTEt2gBugJtB8YdAQO+aerkdLtvOUYoJ//IB6cDd1MOKFyvdoo19DoYWXq4Mp4hwHS
    sE6hGGhD8jZUQBFwSAEaqbrlLtNQJOHU12L29C7L5mnTVCRDAkeZmIOqYt5aFhTZMqqF3G
    unWCdor0kTLNZ6dWF7cUnC4Ml9JFy0XsJkLfAerTv9dDlmfLQuI7Z1HUYFax+IrCJ7fGCI
    XLH+e8l5UTeju4F0WLIDQKTm3VKh6I0RUAfiZDqICKkcn0tjqfxr5W0qSqbmY3m8OLjF81
    SRCTZ/Jk/x6QsFPKWShpc/DZt/tSPSQhu7KTzKKLnfU9kSgS3yyLa7Ees1TsHDveRaSRFZ
    VkHAQqHB0yHtpm18nQBMeubpDVk5asb76oGya6rJ7skhNtAIG8S2FUMYS/++wFpV0zC/Kd
    Qyzk2m8f+tOf/hlI1+LPS7p2GKUZ1vW6uZmnQ2LCxdfRZLnTs6GrwGJ1uZQ6P4lp8ETYwf
    Keh6O1q8VoIktl2gxycFx5E7VZmAQG/0ENIYMPGfcQMNjnpcfcGXaAI9ZW5PHfq+Nii2iF
    wCaEUXHzbV+G5NqvpU72vQvCZmymvvvQ9YzTLA8CtYIgwov7xfKZTxnG79PLRodZBnnZsg
    Ydq5wgpMTE4j+YhVBEgMXj2gyAGMmcI71tD575P/+Y0VFkcIvpjTjBLCP5wg
X-ME-Proxy: <xmx:uiaMatONO15d2lTrnvxDnxcrUGloQuDQTxfRal-C9Tk6olSLK0aLDQ>
    <xmx:uiaMavrJ0o_Tjz4Rr2PntL4Efx4b9Go5ufOVLD35x9wN2aD5SWmRfg>
    <xmx:uiaManHhiO_32vrTFvBmFsyTdXVn-NpJz17N-vcguS3PQIydWHBD5w>
    <xmx:uiaMasI-UOjiNgLjppnGp0NVjaw1hRR5aLjpCClaHAkIjb7yP30aKg>
    <xmx:uiaMauJfVfK-gHRbFmO8XiaH_9QOUnIfH6hCRwD07_X474O9JAoGc4PJ>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Aug 2026 07:10:43 -0400 (EDT)
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
	Jiaxing Hu <gahing@gahingwoo.com>
Subject: [PATCH v9 09/13] pmdomain/rockchip: cycle optional power-domain resets on power-on
Date: Mon, 24 Aug 2026 23:08:58 +1200
Message-ID: <213e3746a36f821798d3fd3e5d832d89dcf2ddff.1787568944.git.gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <f1805c2bce56c89d8ace35f67c665b24bab90965.1787568944.git.gahing@gahingwoo.com>
References: <f1805c2bce56c89d8ace35f67c665b24bab90965.1787568944.git.gahing@gahingwoo.com>
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

