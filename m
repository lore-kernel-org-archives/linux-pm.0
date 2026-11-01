Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793512603;
	b=woo71QDLLQfY3w1eI87+cVePmDbayuZnjCAncLo22PN8n0l3ZMHNyMqViTsEB9JJCQgN
	 HM1tWL27qEMXNXuNE0Zx/YZ1coznFNgkLEG+USXCurI4NRXATRXc7xikyb1vjLwZflRq5
	 CCCPNJbS41BxxbIrS47gtzGZn+RXqEhgDUTa7+uXp86HDycProILLqGreVV5uE70gUI7W
	 1GCPX9biJ5RGZDdDryCxE7OWJVVnYJZEFt4gMdyUVd2Mg/vBnuGHJ/5Az0Dm916qPw9N/
	 TWgmrhqwZaZSoKaucG3EmexXTsilpfMn5etd5qg6FZLWL+0Au9qC5jg0aoLpz3mUALg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793512603;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=b/wjclTeccaXTJ9heCui57ECu6xJrxVYVlW2sWmjb3c=;
	b=WAF4ZzPPKNxxBdNtcsvvGAXzRkvEdImS90OWPE19ZL35EW08+ELqj8nQQ9ElR0wbuC3s
	 08QKdPqshZ6YlMZ9sdG2ZPJ/xH+j9RRMLOnyEA1WYa+j18C44vCUmNLXg1nksbrXfk5Ni
	 pvhhXjxVIlgEvjb9q4we2IayQw1rbntXdtvVcwq91uf/bsuIGWXZXHxGiM7QwamAD0zVc
	 5sWYVhhFFtMutIETRk9O1t+yjsBkfNTkP58yvoRgTmWh/r6iq9ThMcQ82Uke5mT23+JUv
	 cp7etrNq+T4abr1dggEDVF3MQ67YEdMJ67NpgMv+7+7ws4+CncIzLSnqMx3fILgzDLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gahingwoo.com;
	spf=pass smtp.mailfrom=gahingwoo.com;
	dkim=pass header.d=gahingwoo.com header.i=@gahingwoo.com header.a=rsa-sha256 header.s=fm1 header.b=MQ2aHMfC;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=TLUGFNwF;
	arc=none smtp.remote-ip=202.12.124.148
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7208D606A324
	for <linux-pm@vger.kernel.org>; Sun,  1 Nov 2026 05:56:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7208D606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gahingwoo.com header.i=@gahingwoo.com header.a=rsa-sha256 header.s=fm1 header.b=MQ2aHMfC;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=TLUGFNwF
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 877F21D0012F
	for <linux-pm@vger.kernel.org>; Sun,  1 Nov 2026 01:56:41 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Sun, 01 Nov 2026 01:56:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1793512600; x=1793599000; bh=b/wjclTecc
	aXTJ9heCui57ECu6xJrxVYVlW2sWmjb3c=; b=MQ2aHMfCEwxas7k3JCLXvYw0yH
	xJ2TmIH8veRukwpYn+wJ1Jc2YZGiKmV/xD4FshhssVS3E5HPesLjQ0laUsE2+OUf
	RwPhtm1bz20rKs7KgxdBVapZ4cSsOmmv4X9S10x0Qs0ud/lsVyshMxXUJmNTZiKz
	RrXo7Nhew3n7Ct6wR9iH+Xt/HYm5yFIAEOu5G4L0OhyHusRdFShGGg4id3nmcBY0
	0U1fsbCH23tavv6E8Hd7wEqHSENKZTNgf0M9tbE5GkAwHlPH9Sx3dQqBN2IeKqOq
	aeJk7CTEk1K1TtAjFFUBHYtsIcETNaRXLdsEXa1KCc8+NfpisaojZGXeJwuQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793512600; x=1793599000; bh=b/wjclTeccaXTJ9heCui57ECu6xJrxVYVlW
	2sWmjb3c=; b=TLUGFNwFEIwcZNefC4YTawNs/qmNEV9OhMtomdL18tTkBsO1gEz
	ZgIdU5ZYdbVjqTYZS9cbyyvkVz7ScdOsuQOjb8hDWrKYRY7gp6c0NvkMaOZAbVcF
	w7FH+A8Ue2r3Cur2jpmg0bP2xQVGI7CJQp2QKi/QYjKn3vg4ORSlryN2n8exKbCM
	3T9ryn2VwLIGIQFiEKH8tsaGXJO1DxMjkAiOLBmEE0wsqk53dqIT/QK464uSA2gJ
	+Fj6LwY+AHUYCZZg8JyY++60guXMGebMBKeNEMnc2QU7te1lGuAdM/7ryEBR3aX/
	Oljxlu0TLqVKkp2eWHXmiFG6KoG5blpVXlw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=gahingwoo.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793512600; d=gahingwoo.com;
	mf=PGdhaGluZ0BnYWhpbmd3b28uY29tPg==;
	rt=PGxpbnV4LXBtQHZnZXIua2VybmVsLm9yZz4=;
	s=fm1:rsa-sha256:oO80d96/rQ2X9AIIW9UDq5KedFhKwB3fc6KbtfSxelNwDY+
	yWMMJqfaY06/EffmoyX7017fFJXDZlNVUcony1tSqZFuufHhWlCLvuWwHikSyeQS
	OMpqOFViIx4iHSEEDnthMY2Q1+h1lY/GgcqWXVt8VPmdeFGtCTSmzKSJg6qSyJLE
	3ORxbV+u6pipXHRzRX71jAKhuAVIG/JfBPnVWXm8coV+zmd0dKp7X3iJxUgEW/MX
	17U26pEWOGCVVHSq6OPYWrAELcJZmQw+XCP+ODSNGINR3ls0uaUoMvG/mUWMGMrv
	id/6J0PGIUp/giL0dSbYYDRGBClsL5HnVFEVVrg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=9;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	message-id,mime-version,subject,to;
Message-Instance: m=1; h=sha256:RHkRorNz+a6AbjqnZ1BP49dnoJJCQvGyDUHV2H6LKMY=:F8p+aC33XU5PH3FjvO5qqx6/EycA5JwfiutE8tsgw+M=;
X-ME-Sender: <xms:l9TmagZUGOzFH_ZQxixo0Asoq_hVwQrk7s0TbA9IldCx1ufuM-qiNA>
    <xme:l9TmanOVksgsfHmwrbEcfEzNmY9w-2JpXo6cvshMNVQbK3kwwoui6TmTJfYSfd6nN
    HcbJ2CAa8ieT-0XB5fyNKzcucKG7xe5RchCvu1qLrUK1V5fXSXUGBHA>
X-ME-Received: <xmr:l9TmamUtBGEkZ_WqutseppmSEvENbHtq9M90mjwfZ6lm08mBB8mEJDE3HzEC0eUIXzeNwxkj>
X-ME-Proxy-Cause: dmFkZTFEd/d+c0+FBHyE9uEcy8IJSWfq69VkA1tRQSsKL6w0ZoA4mx6vMr4loSCw0Z38m2
    L2uMzipuy89SDtFSXpTnH63dgpY2bq4Z6PKE38wz6SYFmHhAIzTFA6XEIFLhJzZUmtr0X2
    ovaQ+hwNpMcVt+n/qrdlbCpWwp5cltashXQbVP3JBV/2Pbyh6kNiudG8dvGlQ224rthbbr
    cU7rSmHkaAzZ2y5tRoBgilrVkJAEqt30KarEY7WUSSsJc9sRnlBhzcO/ZLkwHpZtPSuAaK
    6VChvQEJaeAgvZpolKqV9L1etPoW9O79d0ZqsAScBkE+pjfhJkfwx6Dlh5HscL91Pmp7Pk
    sq2zbN/JRf8ZzURBBT3KsFMYFHeGsCLglYn+nQnBDi03HsxySzYWVvj+xphAJscmcR3oMp
    XJmYE7uMPrnf9Y9RGsUAJciPqlOrh9n4mTFtb4Nvszb+4Tb8MaBeqJzCtndXoqhyYgquxp
    ROKpmIjPTRmx6Jnh/6RvwHuejtPL5OWfD6eG0deq/AWMXXtzYvjJi+Mdm3udGq73d96Yk/
    kEu2gGiFU9XoqMtzkY5OJuY10SyjXsLFdbhroWfu/+HyqHdO/nB7NMrptJsV58+RyXjlQm
    BIZJvgTG/O+TPdJANEtqIEA7wipzIX8/Ly5LORdv7761HTzISmV2lnOC+F2A
X-ME-Proxy: <xmx:l9TmakJPWrHaiHPcOmiqDMp0yoU402NHRvSaB7_NDL7aQKwSHE6V3A>
    <xmx:l9TmapqhCzo6jS1cAO4Z0dfS9t17IPSbtXwycBjAuDxkGBUCW9UltQ>
    <xmx:l9Tmajz8GtsueCo6CjaDuWN6dS5w36R4chVZz-awB5OCFgFaLdttMQ>
    <xmx:l9TmaltbBOIk6Vmf8FEJ48Bqpr58UNEWX3rYy_BOztbQ8q_CwjxJ_Q>
    <xmx:mNTmapIDcqwIpRDCMAY2GXNtKfcSn-YMtonnqndfAg9EOnFD5rapTGf1>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 1 Nov 2026 01:56:36 -0400 (EDT)
From: Jiaxing Hu <gahing@gahingwoo.com>
To: ulfh@kernel.org,
	heiko@sntech.de
Cc: sebastian.reichel@collabora.com,
	shawn.lin@rock-chips.com,
	finley.xiao@rock-chips.com,
	zhangqing@rock-chips.com,
	linux-pm@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jiaxing Hu <gahing@gahingwoo.com>
Subject: [PATCH] pmdomain: rockchip: do not restore QoS that was never saved
Date: Sun,  1 Nov 2026 18:56:33 +1300
Message-ID: <20261101055633.101309-1-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rockchip_pmu_restore_qos() writes back what rockchip_pmu_save_qos() read
on the last power-off. A domain that was off when it was registered has
not been powered off by the driver yet, so on its first power-on the
restore writes the zeroed save array over the QoS reset values.

On RK3576 this is the GPU on every boot. Read back after the restore, its
QoS is all zeros; with this patch it keeps the values it powers up with,
priority 0x101, mode 3, bandwidth 0x80 and saturation 8.

Only restore after a save. Rockchip's own driver does the same with an
is_qos_saved flag.

Fixes: 074c6a422d86 ("soc: rockchip: power-domain: support qos save and restore")
Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
---
 drivers/pmdomain/rockchip/pm-domains.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/rockchip/pm-domains.c
index db3879846db6..d1c025bdaa08 100644
--- a/drivers/pmdomain/rockchip/pm-domains.c
+++ b/drivers/pmdomain/rockchip/pm-domains.c
@@ -97,6 +97,7 @@ struct rockchip_pm_domain {
 	int num_qos;
 	struct regmap **qos_regmap;
 	u32 *qos_save_regs[MAX_QOS_REGS_NUM];
+	bool qos_saved;
 	int num_clks;
 	struct clk_bulk_data *clks;
 	struct device_node *node;
@@ -474,6 +475,7 @@ static int rockchip_pmu_save_qos(struct rockchip_pm_domain *pd)
 			    QOS_EXTCONTROL,
 			    &pd->qos_save_regs[4][i]);
 	}
+	pd->qos_saved = true;
 	return 0;
 }
 
@@ -481,6 +483,14 @@ static int rockchip_pmu_restore_qos(struct rockchip_pm_domain *pd)
 {
 	int i;
 
+	/*
+	 * A domain that was off when it was registered has nothing saved yet,
+	 * and writing the zeroed array would replace the reset values the QoS
+	 * registers came up with.
+	 */
+	if (!pd->qos_saved)
+		return 0;
+
 	for (i = 0; i < pd->num_qos; i++) {
 		regmap_write(pd->qos_regmap[i],
 			     QOS_PRIORITY,

base-commit: 7649ba73f9e7e1e04d0b46213e39c79ae09dd55c
-- 
2.43.0

