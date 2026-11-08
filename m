Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794121193;
	b=Yn+4r9LAWO9wk8wSETvNwN0mlcpkteZ5KaL4TgRXr+8fhE4DAa64M1/UVWSms/kyEzv3
	 Oe3fnV2rD76Z2+K+cQZFgKIh19i+98u+s//fe0kYeurkZq/sun/sNYe4Mw741q4eZJDIp
	 Nc+9JqvSvPwD7wwY+LWSkJbTcSfj22pt9eWEGSOgw6c/9z6p03SQasT1/VgPmWH6aRA15
	 YSzcoJp2SeR5hscC2z1+/E8LvFertHo/RM1hzg1bQeSzDc8Ny12tFAKCsDdba8/vwMA29
	 4xDSqfZGaZ0qDFLGaOs+50hAI1OIBQN+a97XDyrJZYlP+lntwMC7vk/y8jUAde6lfug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794121193;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=EfQbylsCpIAnslSqVxcBOCtEodurG+HUimJi3ylSZas=;
	b=sLK67exoFCvwd9BT8rNljnk95HGN/45OBe2acPzikvvx4edgutE0gfeoRFU0Foe0M1Dm
	 +EYprIVlK6omMmbY4pd04I9zOod5j6lYBxAH1OB9RN7zyU5qvh5UufWFyFCb/CVtp5nmj
	 C6RJ8zgkFX04PnVsvEljIeUm9Uop7q2gcj4GLqPRcmISuTUlspthiYzM60QkGcP2I3jrb
	 /AhCQjUO4RgeNE5LzenNofWFOLpw0rqCtM+V9GPAea4p0XVmf82MfUw125ocCji9YWdQs
	 9OaT3QFvPVikcH0RLl2q7ew5LU8wAXl83P86Uz6BVe6Khwy2F0U7fHQeRuw47ZP3fgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gahingwoo.com;
	spf=pass smtp.mailfrom=gahingwoo.com;
	dkim=pass header.d=gahingwoo.com header.i=@gahingwoo.com header.a=rsa-sha256 header.s=fm1 header.b="nyj/NjMM";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=mop2sp4r;
	arc=none smtp.remote-ip=202.12.124.144
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81CD606A31A
	for <linux-pm@vger.kernel.org>; Sun,  8 Nov 2026 06:59:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B81CD606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gahingwoo.com header.i=@gahingwoo.com header.a=rsa-sha256 header.s=fm1 header.b=nyj/NjMM;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=mop2sp4r
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 2C0771D00118
	for <linux-pm@vger.kernel.org>; Sun,  8 Nov 2026 01:59:52 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Sun, 08 Nov 2026 01:59:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1794121187; x=
	1794207587; bh=EfQbylsCpIAnslSqVxcBOCtEodurG+HUimJi3ylSZas=; b=n
	yj/NjMMexDg+rlV2fUiql+lwYWIfnNa8sqpiM7W4Z9SC4tY5t6zSdTRdLSmvKdbR
	HTRZUuJscZk1lAbbPW8qPjFwt8BIvGmJRuIVzAFrP5jcVfc7uJocXQtpVzk3IEhK
	NkDww1LgRMMKPwCx48waCQvARBizy8EYSk5uYVqcSGrXg7Evz0+65kp3hUOz+Raj
	O7fOkXi79Sr64wS+/pcY4iOpcX5FwG+8dfPIPVfvuhSTbQwf5GUXhtsLXw8Q3+bF
	wsoH8B3xnl2VXnthK5rNu1IlytuR+Zgj0JcAYeqOqsP+zX1o+hl4iKmaOxeP1rnj
	xMV6+rDZiBQ4/qjOOhv3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1794121187; x=1794207587; bh=E
	fQbylsCpIAnslSqVxcBOCtEodurG+HUimJi3ylSZas=; b=mop2sp4rvIQ9X7YQ9
	0RlubFjZzPyYf1YKy6iPIOLR9TsknTeruwkfFGEEFTbKop8uhIUjyDKkpRFlVTFo
	kZAkIflE2So4tri2zw2OedyxT2YYlMRTdJIyNTAJzlINg6b59udlahYBp6unyMDT
	GWKDavtrxUZQrc7XKy573IoOwk3kGZp6py63YPi8aYc/to7qpwEnioH2KMCd5pBc
	7qRsdDgYAKoez5UcXFwRhIt2PghWBk1/+Hq0HHojr6xcEIOzuXqimkMxQ5Y1zYLs
	BfyqXeBv+jH53algvrPu0z1tzaetgziq+lvBQnKHtp3l18iGgeUSW02tujr+XL/m
	QWlgg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=gahingwoo.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794121187; d=gahingwoo.com;
	mf=PGdhaGluZ0BnYWhpbmd3b28uY29tPg==;
	rt=PGxpbnV4LXBtQHZnZXIua2VybmVsLm9yZz4=;
	s=fm1:rsa-sha256:QHZ/uVHJW9s1eJFuVslD/GfeAfxZn5DN63Sc77oR947iT01
	PhHaGwpc/YOO+mRyXq6rfhoYJzZsXTNR78pvEYdrtQbF2A+qtBIGc9NFnYfjHCtJ
	UpdmDf5Q0rPS3iK9iwtEpcEY2UpKMrkVjTfjnjBvua/sBZDTBzIvPPXzmNgu4h6T
	NGv9P1g3jz6GjrL8SYX0kbXQI8HglwjL9QeFPuDCrIN4/oVUP8oczqeBv9pWHlmg
	8MdpKIqlTGyHjv4mkl8g8tPZMZ5Mp/BHlfPura9Q9KRRtGQ9fyBIyM4nh5frtwkY
	b+4+OizKlTgQmyF3EiYwEShEnqpAvsZH1SvIDCg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:i0uMcOJV4Txg3uXy8svWGAM+fGmcjkhIe099c7B65Vw=:PFJmZpPQ7hOYq6GyLPKUjFxHooG32hWaNu/MYQEiFdw=;
X-ME-Sender: <xms:4x3wasEElednTwhBg53F73pvHctZugiGaoVk1D4VKxGqnlB_Z2L61A>
    <xme:4x3wahe3gkc84wPIjapIbE8Xv71bWGPhN7GSSu2KmO2bqIirgd2A1z2zQo8AitQGI
    dF7OBM5Z_lU2eX6dEWSgIJaPLAPHYx9yRUb1GzDoJKFbpBoSHz5Vm9_>
X-ME-Received: <xmr:4x3wava6r1t9OqZ8JsqfspvhwZFlXzRnspVGs63b_2exYwuhdbyZKO_ywBRMgoD_YaaKTjW9>
X-ME-Proxy-Cause: dmFkZTFKhclCCJN9i5LFQp5fvn9DylL5PDR95+qcmUDEkBDvAaUlhVhO6JW1PTcA0oiilr
    afxU+kS37MwfkRVrV2sLhNS1OkBSH9hrpfUYkvEeAEfTx8oUhC1lvQdEqsrvfO12L2kPDm
    Y90xvEv61R5vWsABT3XVmqKcWsSTBPoQRHs33ySAWpN7mh8mIX7nfmpu6Q5St0DdZLVl6o
    GJpMHUC7TjUVqLMHfqfKk9SHn10f5lL6CdG6YeehrsosttZtbM1aNiFk46XYC+svmJcMBn
    4w1I3sJZaXrv8SSndHCWUOH7cbPZHBY65Sr1oZjnZZRxSV2wTTFO+3xU/Lmvhk4YCMlhrD
    d8VrwNk0rqjoxg0rgtVyiUIqLKvl1cfJCmGEQpGCCSL22Di3houcbmHV2KWk9Gy7CGyQFw
    LScFVe2L9bN00I9vTKwsVZjgHcuSIOcibMMaxFmdry5AP9zy5JqvB2t0A4ATAW9JhssOM6
    mgVMRSuTrFNRpqV8HyuLwsjFvVM5dgsfwsFu2n1yWX5cngVOA0D7sKLl7Kg6e2Js6RvUzi
    4jsiXM3XQ+Q4EbiddfEFl+Odx/6wkw+wPdtCPrbFf3rq5wIa0nWZ4KWoDn0Z4IbwuLFiyE
    Y7vGCUjrDzAcKXrXMFlDMtOUbixTZ/WK1uZn0idCqXESM0vCdcxG+tym3MYw
X-ME-Proxy: <xmx:4x3watIDd-7W-wCokvJaM3siszwMwqx_-aW02aVJJGeYYrja-HSrkQ>
    <xmx:4x3wamhDM260Mks_j3mCba8sCckeATFyz0cbF2gZaTDBw66k0vpm-g>
    <xmx:4x3wahsYJSPIUFBx2VTytSbRBPlrTHMdaJSBu_rwaWZ9zBVNVb6rcQ>
    <xmx:4x3waiEIIo8SXyfzC0Hmkoi1CWERb-FOJHofGcgpasGCJ73Uafv-jw>
    <xmx:4x3wavPkeJxdkq8E2gmNddFzhgkefGWv_tn1sVw4BJfejKmD9RQuJ0qF>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 8 Nov 2026 01:59:39 -0500 (EST)
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
	abel.vesa@oss.qualcomm.com,
	sebastian.reichel@collabora.com,
	sidong.yang@furiosa.ai,
	u.kleine-koenig@baylibre.com,
	chaoyi.chen@rock-chips.com,
	shawn.lin@rock-chips.com,
	finley.xiao@rock-chips.com,
	diederik@cknow-tech.com,
	alchark@flipper.net,
	leonard@lausen.nl,
	jeff.hugo@oss.qualcomm.com,
	rfoss@kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jiaxing Hu <gahing@gahingwoo.com>
Subject: [PATCH v16 01/16] accel/rocket: request the core clocks by name
Date: Sun,  8 Nov 2026 19:59:02 +1300
Message-ID: <20261108065917.135194-2-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261108065917.135194-1-gahing@gahingwoo.com>
References: <20261108065917.135194-1-gahing@gahingwoo.com>
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

From: Igor Paunovic <royalnet026@gmail.com>

rocket_core_init() never sets the .id of the clocks, so all four are
requested with a NULL name and each one resolves to the first clock in the
DT, aclk.

As a result aclk is taken and enabled four times, while hclk, pclk and the
NPU compute clock are never enabled by the driver. It only works today
because the power-domain driver enables those clocks for it.

Give the four clocks their names, in the order the binding defines: aclk,
hclk, npu and pclk.

With that, a DT that lacks any of these clock-names fails probe with
-ENOENT instead of running on the wrong clock.

Fixes: ed98261b4168 ("accel/rocket: Add a new driver for Rockchip's NPU")
Signed-off-by: Igor Paunovic <royalnet026@gmail.com>
Tested-by: Sidong Yang <sidong.yang@furiosa.ai>
Tested-by: Diederik de Haas <diederik@cknow-tech.com>  # NanoPC-T6 LTS, NanoPC-T6 Plus
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Reviewed-by: Jiaxing Hu <gahing@gahingwoo.com>
[Jiaxing: shortened the commit message]
Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/accel/rocket/rocket_core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/accel/rocket/rocket_core.c b/drivers/accel/rocket/rocket_core.c
index b3b2fa9ba645..5dd260bacbff 100644
--- a/drivers/accel/rocket/rocket_core.c
+++ b/drivers/accel/rocket/rocket_core.c
@@ -28,6 +28,10 @@ int rocket_core_init(struct rocket_core *core)
 	if (err)
 		return dev_err_probe(dev, err, "failed to get resets for core %d\n", core->index);
 
+	core->clks[0].id = "aclk";
+	core->clks[1].id = "hclk";
+	core->clks[2].id = "npu";
+	core->clks[3].id = "pclk";
 	err = devm_clk_bulk_get(dev, ARRAY_SIZE(core->clks), core->clks);
 	if (err)
 		return dev_err_probe(dev, err, "failed to get clocks for core %d\n", core->index);
-- 
2.43.0

