Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C884734D6;
	Thu, 24 Sep 2026 10:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790245497; cv=none; b=PsO6+QcVRXwAQ3z8JaxZ81ABgDtBaPsNkNagd7z+dpl40iF//lmvOx4nI5GodcpHN+HiABZDoRalqehbxtI0tf686MvDIJEHRX8fz9+QQo+FEVY7Z+TkUIQGwdC4iylD9RNwZAHXGXBcu+VIFj0egzqnDx2KuKg6ppm7mvHQIrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790245497; c=relaxed/simple;
	bh=TMNeDMOvE1/qKxWRLHGVa8gUUJK5YiMBIWH8Vw1/qMM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fV3SMDSA6bpNRrbEf1Y3f/JFbVHEJe1S5FxzUD8jKxz0mNlN/plois0rE2CQsICHp14+YdQwI8PMQvn9VhGzhF+IaN6DNuXc+XjZoDO2t4+6xdYeupoUZGJ2+EpPVptxjqTDnxQvYmmZc4xK01H6WMacGOaohLuhR1SlNX4IXUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com; spf=pass smtp.mailfrom=gahingwoo.com; dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b=nyoBSMDX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=V8S5FlB6; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="nyoBSMDX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="V8S5FlB6"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 88EEC7A00BC;
	Thu, 24 Sep 2026 06:24:54 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 24 Sep 2026 06:24:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1790245494; x=
	1790331894; bh=mlW+027m2NZqDmr1cPnSb/IcZBiCJqwfW1Ay6cbek0U=; b=n
	yoBSMDXCIav8wrF3MpxD2M+pw9nLK4m+TZVzkDXEXqC6rq5iDdlDgm7bfuqATjce
	tSJPwLsKhToGFxav7rLpI2S14InjdHaHbzm+PHkfefjiHlvNhSjpJ6gC2SB1iOMR
	RMoxXgvu4l4M7Vq2D45gMh/t9OJ/gRq+6/IN5iOId19MUtvNTEmB9DqOIe0/ACpu
	NA8uE0kpYIyo496eKeH8NreFRIJFS6VuFM95TXEhxesxSSOMdZ14k6ZTk21h1rBV
	p/r0WrTKTtUU/04XGvru/u4XiCvSv9k+2Z3ju49eJ2rjg27JbZwUfIXrwrkdpOMr
	4S0syPDwUlH0PtmbuLwZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1790245494; x=1790331894; bh=m
	lW+027m2NZqDmr1cPnSb/IcZBiCJqwfW1Ay6cbek0U=; b=V8S5FlB634I+g+QQ1
	4cvzxqLGrqZdpaHNIXQ9hhQUhimocjqkLk8JgqOmVf5pjd8UpEF+Qfdy5cU2ZdQj
	CPr6spsKt0q7PVbInQUHcHU9AR3DZ6On1dvd9LHt7GA7yt/bAciDpwidfBiw6Tco
	1S7/8VgA5BUrz+kT+NCqNoPkOQKf+QFTqECRDVdidVWIQrl5RNGkqAUQS6za9zy0
	GDaKRnkuN9+22J3pFYfNAoxA1ruRbZwAo/asV511JKK0i+ze7wEvZ3UJuNKViJLo
	EYwUi4rqUiMMsQ99L8diLOd2CnwoVBBZB9qG8XDNxjEXLsygX1BhVRT3OQouFpW1
	KB1Hg==
X-ME-Sender: <xms:dvq0amxO4CW-Zr53ptu8W_okf5jIIRVBD8rJowaJGQTwlYCNJLFtRw>
    <xme:dvq0aiZMjghWuyZ3Bf5CIud1QWojQMAo_bEak7iP6IP59eszg8JxttBE0B9W9bCyS
    IqOAgjC6HkABQUHxeSdbYD6Or2IA62jGIevHwbfT-n6xSRhOdAsjiY>
X-ME-Received: <xmr:dvq0amLu3p6RzavpIRyQUDtifgtTnFDCILr20umt_vLA_-_dwaA50Zm2Dn686IEjT7MhsudJPw>
X-ME-Proxy-Cause: dmFkZTE5U9DWJ/1d8NZBV16bjZrXhnu9+RjSei8Egg+AJBodp1SsqcAZICkdFDYYk8PQ/z
    nbl5nAv32NCM/Rvob60jzzR/sJI+sbtZKf4EXYq6NkDnWs3QsBAvLEkGDZPcVAuKZu09hj
    kufWDx+OHd427BpEwAmDDK2HcwDl5PIVxykoKPNTzoVswPV46/qyR6Xp/JY/TaNWyTgMqq
    yMy5OLUd6yAzE6clJlYL4qCFZSrQCDEMACpcb7vwZPjxoszy3u6FTeAITQlCqDvBOfb2xA
    f1SHw7kF1Gfs8fOU43Noc1IHs7QEkTjIEBtZWO5SBQ25T666ulWx7WKsjltbKYna0Y/oq0
    eA7FxoFBfbFPEK71s28f3uysUgvoKKcWjAhElEIzvKnxO+Ho37/k4yYGqMIyDF+UuEaHt8
    b2G0GUIGp5LTf8POaNh2eZZfsOoOUyn3MZA15XICMExObVdJlpLT6e1v8ALwxKd6qk4Yv6
    uX5U6EhwCzAectZjuDt5jL8/JO7iYxz/Amil/KieYIs8NVFM1EHKvlzTgJHztAR5WgQDQu
    j9xmUWGionl3ujVGnYSEINx3637DHZ8LUc++oLh2+lb0Jhkoy2jMErDtF/3+swIKZquKFs
    H14Hw+XzAL+JT5mPNgxzEnYuAO6J0kALf738KmNXCDUzJz72n0oB105kTr5w
X-ME-Proxy: <xmx:dvq0agzLZEEq1AGl33gS4xxyqz1UlWR_EDNf9IJ8eBkHZvzm1jOsXg>
    <xmx:dvq0amPqgFdA7uYXH8aQndxkLyFeGbRN2BF6p7PI2s-4A6wNEf8KyA>
    <xmx:dvq0asuxQrFX1EqFiLLVlIakKJaxZDydHrRXqV1CEruxpJjIZnPRPw>
    <xmx:dvq0ar07uDmHwG9jFvb3ZGLUHQtjqhB3vc9fpoWsb6gP8ULb-RrJyQ>
    <xmx:dvq0asa3xD_vgQXwF87ZhbvzyBqXli8ylpGF5u7iWRRK46wWzZ1rsseu>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Sep 2026 06:24:44 -0400 (EDT)
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
Subject: [PATCH v14 15/15] arm64: dts: rockchip: enable the NPU on rk3576-rock-4d
Date: Thu, 24 Sep 2026 22:21:35 +1200
Message-ID: <20260924102135.92217-16-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260924102135.92217-1-gahing@gahingwoo.com>
References: <20260924102135.92217-1-gahing@gahingwoo.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable both NPU cores and their IOMMUs on the ROCK 4D, and make vdd_npu_s0
the NPU domain's supply so the rail is switched with the domain.

Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
---
 .../boot/dts/rockchip/rk3576-rock-4d.dts      | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dts b/arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dts
index 272af1012..93d59c0a9 100644
--- a/arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dts
@@ -722,6 +722,10 @@ &pcie0 {
 	status = "okay";
 };
 
+&pd_npu {
+	domain-supply = <&vdd_npu_s0>;
+};
+
 &pinctrl {
 	hdmi {
 		hdmi_tx_on_h: hdmi-tx-on-h {
@@ -779,6 +783,24 @@ wifi_en_h: wifi-en-h {
 	};
 };
 
+&rknn_core_0 {
+	npu-supply = <&vdd_npu_s0>;
+	status = "okay";
+};
+
+&rknn_mmu_0 {
+	status = "okay";
+};
+
+&rknn_core_1 {
+	npu-supply = <&vdd_npu_s0>;
+	status = "okay";
+};
+
+&rknn_mmu_1 {
+	status = "okay";
+};
+
 &sai6 {
 	status = "okay";
 };
-- 
2.43.0

