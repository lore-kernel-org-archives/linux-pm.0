Received: from flow-a8-smtp.messagingengine.com (flow-a8-smtp.messagingengine.com [103.168.172.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0894A0C;
	Mon,  3 Aug 2026 09:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785750133; cv=none; b=pLzbmoqAt0pi93ILhdLqrVYo5A4S3SaNOAHCks+I8+SnP1kwc8t7G1Xf08lZQArHpVOlT+gKBjwIUyERFgoS4mjNxPNiqTTRmYcDeEC9S5Gwp0O0tT3drYBzKBCnl+SDAM0XArlf31zGb5bzsk97HkZnZepl2GZAXs7ghf8FMCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785750133; c=relaxed/simple;
	bh=NYWeX1zT+UWLIEpQ6DXkvnWhzoaOxj6r57zcKYjDIXg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qgKjJddFfdQnRaZVFAgI9SXd1Az+NUF3JIkwc9kCpxEk86PJUYUzy+KKqjWM3WdvrwobJTcdsbHQmZ/0/Qo7njaItq/+0iq7+Utgh/1CJxnfl1zsjxN1t1PiY9uyKuRI6sSOVRCndaFRWAW1MFQh/mpjlqqw4E8RUI4b7mK6f9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com; spf=pass smtp.mailfrom=gahingwoo.com; dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b=MciCjb6Q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gBTserxC; arc=none smtp.client-ip=103.168.172.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="MciCjb6Q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gBTserxC"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailflow.phl.internal (Postfix) with ESMTP id 1FA5F138007E;
	Mon,  3 Aug 2026 05:42:11 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Mon, 03 Aug 2026 05:42:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1785750131; x=
	1785753731; bh=vfiH5V16AyO9stikNxuMC7UErEwVoICawUpn+9ckh+U=; b=M
	ciCjb6Q3VntZWJBFZT4daNuBP3KseLRFsSHgcvXDNZfG5jYvJdPO9jHaoDFFEXP7
	8EEAoTQBi21bSeKWaYicmI5TVHY6JRlho02H0yuURY56agk3D138VJotNzp2Fepk
	wduxmmjxVNc+2pYSRJGXO/3pK53V40IY0rgDXozyUo2ASOVV35REt50q/kWmly6V
	XiIFbhPn4mUp68f+VdKEl+WXkNco9L0sZph6ZewnGsmVXR5kKMbja5Wu3ZskkT9J
	0XFlOnrk9h938VLzLR5dFl0St2CN/zM3WDag4zcc9PrrLZh5qWliK6IOQ0lxO18b
	9OlOmntwoE6w3DzpRt9Vg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1785750131; x=1785753731; bh=v
	fiH5V16AyO9stikNxuMC7UErEwVoICawUpn+9ckh+U=; b=gBTserxC+XXloIhpS
	up+nD3ExNFFV+QUvHvfQ7ytrk3CCKO5sdYNT5Xm2lcXdhNIQC8/uFAQryKcvmm3K
	bqgSrwvPp26hKjWAhz2p1MKPJY1cNnPPS0pd48E+u9bagwlGMPEAO4z7hfpkKM53
	TtvCbhAuZ2jowk3gS876PJtgcXuofLwF+zgLJwDVbj+XgeQmC2zUIk2WZ5x/Nfyx
	lkzgbOmPtX4Cn7KW2OZrFdmghQ2IDbLgoX3ljXETmT387RWmgbe4hX8UEBCrbaF/
	e7XYTs99j6r2dfGdRItCb4u2gaDj/fLjnqOV+pHt1JsD4SWWuY4SrYn2UPJXtul1
	o221w==
X-ME-Sender: <xms:cmJwakk3rXbBOdD3utjG0WyN40835YjLBAHQ6CFgLamAXz_O7Qxjtg>
    <xme:cmJwaq62Ey0UG3-eBwMgVeFLBOResII_u3a5BWrdS8JFk9HbqDMrL3ljC7cnEseat
    T-YLbKWtdtiPXFoZiqCNzKVnQoTaRu996B5goVnXkKGgsf-sCS5uE8>
X-ME-Received: <xmr:cmJwaqU9tz39dh-JfZJPU7mH_IADvE2VWL-yAeZh1UE9m6OyVdypKVVJQCZUTdX00PuBkMt9ww>
X-ME-Proxy-Cause: dmFkZTFjY2LyPb/9LfXn4QCibSWxeeRWJF58tfvFoO1JpUYwl/f8fQT4gNNHDkwtzTG3mW
    QB9Z5E2ZaiRLdwTk7Bf1cP6j2q2LuyYXAyG5SuQy6DwnGU1S0GzExnzN4TJrhwhfA2voA2
    n2K0qQ7ZhvGfjI6tOvBvuW8sUUpow6OyrJ4H8Jm+8CF5bCgHVQ4I3VQwTEXeIHlOg0F+vh
    Iqy32CoHpA615dyPNJOIbTr8Kos0tW88p1VITCDcWhI1Pkk+5LOtOBwFm8TmwIOzW5PsEo
    tPufk9ICYRNR6HPn77DziTnrKAnrLZzqwRBloqTdNsqFLZVnL8NzKJLgMxCkSg4QeWk1lX
    ZCi92cTzOwqDdGNi9OjQjzmEHR/ibLFkRVAgedwPclg+uAcYVpexktu7i2Nyaj7OvyrSXt
    qmpz2CbtKoAmZkXQXWKY9DByt3JvdcU9gQuP/gT1Knf1RuwDnQmKtbFm0a+IvHbu8JB4/L
    VxcE5PBr6x90ohNH59xPiM5dKu0/BItIrVsjEMRLCmKudBTdOS5pkvH23YdtfCkXmo792c
    oJ0rFWsJcwx7UNMQDtFS2hli71Nmxd9isR9ya7U+kWUCpGSAlYn3tgKcEFcLAh6Sv85FIO
    Tdiv1mowuQB4hotyxK+13T+Zapc/BJbiU3f0xN7D9IbShoAD3u7nO4uqWJaQ
X-ME-Proxy: <xmx:cmJwam8xkpxIlomLZzLhU8oznL01ZKAr6ICldVnMypvKjIfdNapgSw>
    <xmx:cmJwavjTtlX0P4G5cQFFhyit9-KrhMT5O_5Lu2Qnas6-K1_B3ysbaw>
    <xmx:cmJwatXButdmtYdy9LAIz_T6SPD1vgVwA9lfhM7ulouX6zilsQodcA>
    <xmx:cmJwajvqNKY-3VZQzWACyqA2ctoQ_mMjhQuJ6wK6kmyDKTKVgbFy0w>
    <xmx:c2JwagezJk__qhSaMb2_K-3Wfm7h7pi58ouLMI9HmvIuMRMyIyOo3GD2>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Aug 2026 05:42:03 -0400 (EDT)
From: Jiaxing Hu <gahing@gahingwoo.com>
To: tomeu@tomeuvizoso.net,
	heiko@sntech.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	ulfh@kernel.org,
	p.zabel@pengutronix.de,
	ogabbay@kernel.org
Cc: royalnet026@gmail.com,
	alchark@flipper.net,
	chaoyi.chen@rock-chips.com,
	krzk@kernel.org,
	will@kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jiaxing Hu <gahing@gahingwoo.com>
Subject: [RFC PATCH v4 3/6] pmdomain/rockchip: cycle optional power-domain resets on power-on
Date: Mon,  3 Aug 2026 21:41:22 +1200
Message-ID: <20260803094125.3285895-4-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260803094125.3285895-1-gahing@gahingwoo.com>
References: <20260803094125.3285895-1-gahing@gahingwoo.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some Rockchip domains come out of power-on with their bus interface in
an undefined state. On the RK3576 NPU this shows up as a hang on the
first access after a cold power-on; the vendor kernel cycles the
domain's resets at this point and that clears it.

Take the domain node's resets if it has any, and pulse them between
releasing idle and restoring QoS. The resets are optional, so domains
that do not declare any behave exactly as before.

Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
---
 drivers/pmdomain/rockchip/pm-domains.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/rockchip/pm-domains.c
index e1857f878..82051f600 100644
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
@@ -688,6 +690,13 @@ static int rockchip_pd_power(struct rockchip_pm_domain *pd, bool power_on)
 		if (pd->info->delay_us)
 			udelay(pd->info->delay_us);
 
+		/* Optional: some domains need their resets cycled after power-on. */
+		if (pd->resets) {
+			reset_control_assert(pd->resets);
+			udelay(10);
+			reset_control_deassert(pd->resets);
+		}
+
 		rockchip_pmu_restore_qos(pd);
 	}
 
@@ -857,6 +866,14 @@ static int rockchip_pm_add_one_domain(struct rockchip_pmu *pmu,
 	if (error)
 		goto err_put_clocks;
 
+	pd->resets = of_reset_control_array_get_optional_exclusive(node);
+	if (IS_ERR(pd->resets)) {
+		error = PTR_ERR(pd->resets);
+		dev_err(pmu->dev, "%pOFn: failed to get resets: %d\n", node, error);
+		pd->resets = NULL;
+		goto err_unprepare_clocks;
+	}
+
 	pd->num_qos = of_count_phandle_with_args(node, "pm_qos",
 						 NULL);
 
@@ -927,6 +944,7 @@ static int rockchip_pm_add_one_domain(struct rockchip_pmu *pmu,
 	clk_bulk_unprepare(pd->num_clks, pd->clks);
 err_put_clocks:
 	clk_bulk_put(pd->num_clks, pd->clks);
+	reset_control_put(pd->resets);
 	return error;
 }
 
@@ -945,6 +963,7 @@ static void rockchip_pm_remove_one_domain(struct rockchip_pm_domain *pd)
 
 	clk_bulk_unprepare(pd->num_clks, pd->clks);
 	clk_bulk_put(pd->num_clks, pd->clks);
+	reset_control_put(pd->resets);
 
 	/* protect the zeroing of pm->num_clks */
 	mutex_lock(&pd->pmu->mutex);
-- 
2.43.0

