Received: from flow-b8-smtp.messagingengine.com (flow-b8-smtp.messagingengine.com [202.12.124.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B003E44F3;
	Fri, 17 Jul 2026 08:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784278523; cv=none; b=nR3WcGzUqaHw3t5no5ZzzjWPn2NuBhgth7YwXJKcO8zDbPbUGYIqVq5JgIH0CQCgiWONAqQShi22jvfd/Ups/U8EXSGjPjVGcsT2rFm94RubGZfmwI6vRTdoV4hM/5+2xOj2umqAlSJ3OO5382i1jBw8Nn7N693eq1F2OOatTeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784278523; c=relaxed/simple;
	bh=xwyTtf8+JfQD1dpFKE+tIj/qERhLNymFR9/Nw9qnYNI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RQotDr7BpEHILhrXI9omEz7Cc0MTQnPn9kpQ46ezMxW8xgMZjp7+KmD8GWo4Q3HL6yFGsmBgjx5w7Vgqp0Aiuu/RMZLDHKcuv4GSDsWdq7FC37q1LMiLqlITd85n/JiUg1n5ZA57vUjdXYwtuNZsjSTB4Q3FeadnR19Vgjs4Bhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com; spf=pass smtp.mailfrom=gahingwoo.com; dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b=EgKc7488; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=c2N3OeLE; arc=none smtp.client-ip=202.12.124.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="EgKc7488";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="c2N3OeLE"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailflow.stl.internal (Postfix) with ESMTP id 999A013002E9;
	Fri, 17 Jul 2026 04:55:21 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Fri, 17 Jul 2026 04:55:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1784278521; x=
	1784282121; bh=Zvd1osMYewGqon41SsFYB9MFb6slH1HcdKHtX5RAEpk=; b=E
	gKc7488I5Z9VTl7QMWXAF/psMQGuTz+k6DzFkDtAGftumnkGTZfPk2hkAncjLENy
	3lhd+L/wvAV+XUcWtlBqrHwn+s0Ptx3qMEb6EBdCH2cIee+3P6sk/vOURW+EgVq9
	UB41pWP9mMx4qIiuvzzglXlEyCdQnFKwtbCnfnoG9hX+JHHAnWgGHy38UYsPmYyl
	w2FFb1uX313jG54k9GbVvswxVZDI6FqJ3B/oOwQIAwYhYKNcDJETZHF/1Mh5RuLj
	C6ETziDGp6s+mtmZo9GMsnX4xv1sA5kJdPq0bri+aR2EkdYFiIJitjBE2Tv0RN1K
	HBvKSWRdbBfLKrgyBb15Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1784278521; x=1784282121; bh=Z
	vd1osMYewGqon41SsFYB9MFb6slH1HcdKHtX5RAEpk=; b=c2N3OeLEOynyxMYUC
	uxfQfjDMA5BKinX4c5noX8w1esmnWz6udH74WmYHNk6ijpjIyYSUC6JeJ3heqsW8
	+X9qarILtjVfgUKbDdG6OZFZO95Ompz1vYt97/hBxxEJkHxjhMojT8GRDwqjaBbX
	p347mov/v+8CGtA8l4iE6+ayXlg3ZPf7SutFipH9kxejEBPVJQPYCb2/h2Akb5L7
	NKY78pA4xhlGqQXpH3twO+qDTPXjme8bEFlgPFBRx1FfNi+p47b0LcUlsweUwaz4
	qPxi/VXQA3ZIBWfGG7nyDmVZhxTK7aVaGXBPX7xX2lldUDzvLPXBiOk7PXjaNqHF
	tCtUQ==
X-ME-Sender: <xms:-e1ZaoVfHSjGr1nlzAKFMGWoA5RK0prc2QUfW2FUjNjNVS-R6MLu1g>
    <xme:-e1ZaqQQA-bVOBEHyNh1qnX3EWAbXpdZg7HEETfVhVrPMO4Bje_DT2yTd2GS_38n6
    QG-eHX1sR7GVVTH22BVqHRL_oXPCWyPNsyVtSkc1-4M0K8KdTnw_bk>
X-ME-Received: <xmr:-e1ZauJX5JIzCi9JD54MACly-_OVPhXCvAkAeF0WEx1kMHhOhKMHh19qK0lFe6LClM5dIjEZUT5uDwmXUvc>
X-ME-Proxy-Cause: dmFkZTFS7GW/vS+PGg3aNaRtXNWwH13wr4t6a3PsYvzLEfoa0d1tCLQMk4kuPOyqJxWYg8
    zWRgYifu3Q3qEvL/I6D+A7sONbehMF6Fzv0Jx15W8Bp0zPI2L6EoHnTvsn7KCzlmdcjq5Z
    AMiUX8pm/4UU/5q2rly/ctUYuGrpfv6aggolOMe4+7cw+YQgQv04wJ8otXu77hR4cT4fFc
    rauulgYGXJAH/ttinZ2FdpHwYOQghdgc8wZDZhtrydZHcBfVIkqxRabCZivPsjLLb49//R
    HUixI1q1RTZqMytwufV0grN2inkZxcvjyE8RnYSpDV3z9U1hNPWgMeNXqfzcYN3TNROTMi
    g6lcYmPvi0ApJCuAabf56PdATqWvLMqqCJcKwwqf0txVfcxEFd+NU5gwyCeb3MzCwQHT4s
    EYXLpjKzizp+/UuGKB61wzx+QKsc4bJ+eA7Tcughh+f+oX0EK2E+8ajqxfHbtGhkgMdraU
    j2th4GtLuUd00xhVbvRlL17mbuXgmQPIe9KShH84oXetiVFix/VxRfbJKcEiu+tPu/4qAy
    6LzMCGZJzCC1rlQBrFP+2s18jy5eOZIAJrxhuQdL/iREbdthHA9uD4/9o++C0Vyo1Cw8lp
    6h4ZTMPnLU/gcmGCjyf19X1ADFp+MT0enTqyJ9/FtLX4vM858uFBQaTmIZkg
X-ME-Proxy: <xmx:-e1Zaj0w8i3RrzWEFcY0cU0LA94nT7bQjStr-o09z17slP2zF-n_rg>
    <xmx:-e1ZapLuDEa9Ai3K5-cem91ym2X2ttXYudxavBycRNLI2jl11rKsEw>
    <xmx:-e1ZarnhOgaW2dVFhx5xqBl6qj9s1vXpHOhHHWAa7fjvQEVJpa5DVg>
    <xmx:-e1ZavMFedxs_IZnYYaxtmNo7DwoKzbKJuDKYPp6VtNWI1I7ZxDd7w>
    <xmx:-e1Zao_01By5GE1USQQXBduANFFQiDaHpbJdzBRF5QXfuV3sR617AdTI>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Jul 2026 04:55:15 -0400 (EDT)
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
	ogabbay@kernel.org
Cc: dri-devel@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jiaxing Hu <gahing@gahingwoo.com>
Subject: [RFC PATCH 9/9] arm64: dts: rockchip: rk3576-rock-4d: enable NPU
Date: Fri, 17 Jul 2026 20:50:47 +1200
Message-ID: <20260717085220.3212274-10-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260717085220.3212274-1-gahing@gahingwoo.com>
References: <20260717085220.3212274-1-gahing@gahingwoo.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable rknn_core_0 and rknn_mmu_0 on the Radxa ROCK 4D. Supply the NPU
rail (vdd_npu_s0) via npu-supply; it is marked regulator-always-on for
now because the NPU power sequencing is still being brought up (see the
cover letter) -- happy to switch to proper runtime control once the
compute path is sorted.

Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
---
 arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dts | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dts b/arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dts
index 272af1012..09d2fc98b 100644
--- a/arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dts
@@ -442,6 +442,7 @@ regulator-state-mem {
 			};
 
 			vdd_npu_s0: dcdc-reg2 {
+				regulator-always-on;
 				regulator-boot-on;
 				regulator-enable-ramp-delay = <400>;
 				regulator-min-microvolt = <550000>;
@@ -869,3 +870,18 @@ vp0_out_hdmi: endpoint@ROCKCHIP_VOP2_EP_HDMI0 {
 		remote-endpoint = <&hdmi_in_vp0>;
 	};
 };
+
+&rknn_core_0 {
+	npu-supply = <&vdd_npu_s0>;
+	/*
+	 * Power BOTH NPU domains (NPU0 + NPU1) like the vendor's single NPU node,
+	 * even though rocket computes only on core 0: the CBUF->CMAC read path is
+	 * only fully powered with NPU1 up. rocket attaches the multi-PD list.
+	 */
+	power-domains = <&power RK3576_PD_NPU0>, <&power RK3576_PD_NPU1>;
+	status = "okay";
+};
+
+&rknn_mmu_0 {
+	status = "okay";
+};
-- 
2.43.0

