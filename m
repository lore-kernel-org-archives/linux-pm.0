Received: from flow-b6-smtp.messagingengine.com (flow-b6-smtp.messagingengine.com [202.12.124.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726843E0226;
	Thu,  6 Aug 2026 06:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785998127; cv=none; b=J+OR1QYRBriXVJ5PpO0Pw9TG3NFU/8Bm9rC53LzLNF0F9BVv0VnoIQyeVtW06R/SR9pHlfK+M0LG/XLB5DTQjsL0JCLe0JcvywrzJbbdQzbjGVTOdVKMhMo8D8/IjnBAVf3x53Xr0sj85hqqNOCMCRaDLeSW9TiJl1ighsf2pyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785998127; c=relaxed/simple;
	bh=MOAl+6wW7KPWYXjQOBWfhd8nNouh77QqKrD9SZCDtqY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MtNM80TtsNQ7Am8oD5EmBIYgDMCsIdoon3QDZhRgf6Z99cWH/cZMHvAbnTk0573Y/OXerJWjHiW4nynMmQdp/f8sclQhLuRANslLCcUxKSP9n03bkiLFjZYqfKc1v5PJTomrZrRnQAD8YS0yJyfRAz8QZC1hN+lwH1qvT3UJa4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com; spf=pass smtp.mailfrom=gahingwoo.com; dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b=h6B4S54D; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QXdrD7w1; arc=none smtp.client-ip=202.12.124.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="h6B4S54D";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QXdrD7w1"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailflow.stl.internal (Postfix) with ESMTP id 27EC513000EE;
	Thu,  6 Aug 2026 02:35:21 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 06 Aug 2026 02:35:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1785998121; x=
	1786001721; bh=t5ehuwu+R3IZPenGVdecVG/3J4bVeduLS34R82/gLXE=; b=h
	6B4S54DEmnsTWv0PL6EAxWtuFVr4XnZw6vwMZyxfdAgdXwcM+Yy5XfXXZHH1FpG7
	XCwMGxaoZmuOsx13HGyrUBOe0UZinYj03xHMguoBDKkKWlRwEba6FrSLAh3HLSn1
	v2HaLuqaEe7MFPEQioEetuS42/tFznMZhw77zNCmWjFUI1WGIAbP18MBFr+NDDgc
	HB2dbTuCjbtG3ntDNbnDGjsKE0/HnxJCRlhqjsd9rvdLxViSwPbt0Wm0BdzZpY0z
	OSG7yu65PGTOAm3wtTVXOdLnHEXyhQ9NklABB3fDqx3nMTEVmu6FgER/p0MY8qtu
	3b8oRAdv6oJQ2FJ2mbhWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1785998121; x=1786001721; bh=t
	5ehuwu+R3IZPenGVdecVG/3J4bVeduLS34R82/gLXE=; b=QXdrD7w1A3DX4irO2
	HaDOxTuy5YHbI/yQZ6pPBQFsjJyv9tdB5NsXAb4IIePejY9yDwm7KpstmsOi/VyE
	/YgA8pjETb3fltVJd/dG+FY22G08hhttzAUjNTq3vbVOf0nnCZfoW4XJV9MI2+B2
	t9343Buf16WL0D26WngIm6mC/2XKY6lsA+xb7J4gnqqkrjMg48iMbkMXBbvQwaF1
	BBap1tiMiIeit6ENJ6G2AxNDk4suV0HvgSJ3NzVsnZ8fSYZn4iyj5rcI6rSX48sU
	1hL4r7bPVFCoWFWD7/CcmkQNPFgLaUPDt2wW3pcm08yNl/B00aLkYWJsMVnyB/vX
	mVPBQ==
X-ME-Sender: <xms:KCt0akkr-DBy9bHH0TPprtmLwznHRk3OFHe4I-I1_U7CMW47qxPpAA>
    <xme:KCt0amlQJC6ioUj4Jf1VmY00sgVVv0kPjMnQv8QhXCjcYMXdp7vAnbn9EgJEDCPNv
    IwEnrOVushgzS_Tku7qlN5QDAItPRzlbyRQu2S73LKhUXy0gcOgyjqw>
X-ME-Received: <xmr:KCt0avgt3QfC5gCavSRDijWQMWSAtmVaELT1M2jfV3I4ANwoe1cBL_Uit3Rp17O1vuZZFaDZ2Q>
X-ME-Proxy-Cause: dmFkZTEh6EqLEron4P620rfA50oje5pogyeStsqRC64znWcm/DBV15Jp+RPu9rfpq1CYYb
    UFmLU5UCxdxDCYby+qIAZtXGI2PUlpFQNXwfYq4ttCgPHbGa62/TDDwxKwLB8tX7dfhqau
    EbUP3O00RQtnFbFjlgrSaMtfjvGvqyYuejLHQ8kaCQjYwTQGvwYjMVbSb1Jvpanl+FPpuM
    SqFyNQH/92jvSpo2kN70zd3lo4jOKuY6rGBanj09NT9Qpf7fxDVsJep1Tqo9Yuq62YMLgS
    +erfmDCU3gBbJvDrolUKAZwfNdHwfv2Y4EHW05E61S/1zu1MOw9sAC69rBYAvxBuvfJpKB
    sNgktNu3xw1nGoj22GO+W5T0Zb8CV2sxrjpp1wE3z55hR72lGdowyUxua6a5gOeMQPWFX1
    rhLvLAUvSzocQG+U+2+Ub3ixXuyTQVuV+6bKEyf9DgcUrsb5p6DAT3QodELnLoX0HVMwrO
    H3YJqFAkuf8kh7CNVI6UBYwhhFwE9wgAd1gGTPrwrFKgxYq/88cuKb0JntJZ5uvQqMT1+3
    FRK20EEFiCltgqE3GCusWLJW73x1g1FPsp/i8m9WbeVpaVRcZcPduuY0RcRa+pShIoEF8l
    9xoCD8hDThmoa17aNn0oGid8xP+hYOUzeshnWHi0N1E01mm3enTZnsAbR/9g
X-ME-Proxy: <xmx:KCt0aoETGH45_keAmp2hX8jf3UEXneob5wWRU-P2Ase-O1-3pQswqA>
    <xmx:KCt0aqYpIYTuAbaN0IwCN5FkTsse0B3ejo5KNClAJ0_qQVCP2hj4jQ>
    <xmx:KCt0arM8_mp3F90BTPnebF9ZBQMrkzJtTOMqDM_r3-5mpBA2nv0uQg>
    <xmx:KCt0al0pr0gInJrXgsElBGu-DENKQZt7AEImn99SlxhXMLDGX50Q_w>
    <xmx:KCt0an1y38ibLZ-0tLpn454tDsDhBRptQzAG2ke9BzU8dVv36N9Tbsw7>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Aug 2026 02:35:13 -0400 (EDT)
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
	alchark@flipper.net,
	chaoyi.chen@rock-chips.com,
	diederik@cknow-tech.com,
	dri-devel@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jiaxing Hu <gahing@gahingwoo.com>
Subject: [RFC PATCH v6 5/9] pmdomain/rockchip: cycle optional power-domain resets on power-on
Date: Thu,  6 Aug 2026 18:34:09 +1200
Message-ID: <20260806063413.350184-6-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260806063413.350184-1-gahing@gahingwoo.com>
References: <20260806063413.350184-1-gahing@gahingwoo.com>
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
index e1857f878..4eebb5d99 100644
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
+		error = dev_err_probe(pmu->dev, PTR_ERR(pd->resets),
+				      "%pOFn: failed to get resets\n", node);
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

