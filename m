Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795654419;
	b=vZLiRYkiFnsADddks9KnpMmrbi1BmMttZX8XQL8zPCW9C3oxoDfrJdCoe97+KsvXhXFQ
	 OSZGaOOd6zgDnTj+mtMTLtPcetL44WvoZMVGBg0xc6q1ClLhZSrvW1ZICvzaGER29uxbK
	 UVnsnAUe30HuZjgoNBY85TsCdjZLPwidnUNQBhAtnaNLCyLE3g82dE56za1LJHgJX3gsI
	 nmwiLAMnZovddGXd1wkbmfAvxHBnAZma/dWfF/q6OYvs7+VahJBNDDitbLoqc5LP46Ksb
	 leVtKP9I6QRTdQL41X5AdLU5wx2RpS8XchTGIFZIBeN15I9z+J1+pai4BQGtzXCRlEQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795654419;
	h=Received:DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-Id:
	 In-Reply-To:References:MIME-Version:Content-Type:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=9Aotji1bql8zF+cwWe5ycVMLLsexz6kp97BBy83KPIc=;
	b=0enfezBV2nU3MyAjuSYRpd0hWnKjjEDX2Kwg7OIBnqRO/3ZQ848uB/T5qaQoaOJ46c69
	 ju7WM+pKufbUNFuwTS12nt+2DyBgvgbYy3EUXZYW4s57DJd5XZHNaU3/9c/kcQ6Xz77/I
	 g07vTsdA2A9oOZBu3JABKSwlvLWxT9a4AxoUFQ5kdrJAjSyE1znE9qk18mRic2usZlei3
	 U3pwm7yZnmcTnMGQmIH+TVu2O2mYgJsI1gWVDSQ0TkOsuQ5a8pwG53p63V0+qyyrexAm6
	 ykgKcSRNd5fj6hJzuxXxC+kVObhaHGSeiKEusZiT3mRbS3BaHd0DAR9tfx+egpaLvGQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="A+6Jj6Z/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25AB0606A697;
	Thu, 26 Nov 2026 00:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A+6Jj6Z/
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795654418;
	b=d6QfRXjSrvvItr/6+cadxAKZsoG7FrUwCzpclttemOKQEJ70+s5UbJvPpbmFtFGnlYoS
	 lDVOpy3EOaU3Z0ExN26PZkRbszVRdvCh0POPhvpVqVAX//scVCNGXVV5rv9IE4LXXxAST
	 H7Kfe2mr3M5USIep+kBW1sDQsSu6cc3LoATytkMcrfPsHGBThSsjSS8KsMPT/YWlls0hF
	 SaHQVpTqqhD6qv+bOkxWEbawVU/Ts6MPOLoB+PAQOJzU3aPo5+VjUP4PWzQvBk0xRflTw
	 5CvCCLdbaQv1K7RlvSJE1a+ZNBZ9IHVLmdIhbOARus7lQnONE5j6TbZwgCs7PZaixWw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795654418;
	h=DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-Id:
	 In-Reply-To:References:MIME-Version:Content-Type:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=9Aotji1bql8zF+cwWe5ycVMLLsexz6kp97BBy83KPIc=;
	b=KWQ4qk7Zibmd0PFylKjhXmIX7xYYgBAEvjSUTjaoZI4orCDEkXPVDKs14ob+9+8RbOZ7
	 onMo90rMcaaWgxvDVG1ghgCQen7flUwyjpdK4h7iccJhH1kC4xHwhSj/+51TKV7uNmNtg
	 fVO+nwdutZ3LqQ11c9FUxmihnsqOizrDqRFBoDrVpCMPm294KYTNlHzDmEoZ+ZRByYYb1
	 XROVs1nYQSAi36VA74dZAsC/3RfTYA7K7eoaQ6PbgSWI0LO7Tq21Ue6PrW7FbnNtVmBED
	 tx1sv3VHaLLTDoZrXztPu+hG9cTSlBPHdUFJcHUzYYzLqnbJeOP5/Rgfko/xpGpYLxw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 7F3F61F000D4;
	Thu, 26 Nov 2026 00:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795654418;
	bh=9Aotji1bql8zF+cwWe5ycVMLLsexz6kp97BBy83KPIc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
	b=A+6Jj6Z/9PXSgpr2AaDPkLXxvjSaLnwhCyGp1VaPVt6arcGVt0aDUEwzEIF+aknEd
	 8XNhIOwppq6ui/9h/CkwVuxBpWosc7WzjI3qh2AO4Sip4MdLu+nCgQVA19nUC9JpEd
	 vyZD8HMhIIGqyuY+WCP1voFhDwVGYWNEZAv881M7r5VqoVbe/T5qQPXrOPIqejCiRR
	 ZoQIiqGrkVPTuaOjvDh5jj+OMM4gLxXuKj5Ye0Pl3fySXVaF4VQgrZWNX0S7fgxt2n
	 oMDKSCfhcqo9fY24qdJAgcsltbGaYVR2O9ywManIUWocS9Jej54gPMcq7MTEqpUg20
	 OW7r/dbVqcZ/Q==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 074694D134;
	Thu, 26 Nov 2026 00:53:23 +0000 (UTC)
From: Ilia Snezhkov via B4 Relay <devnull+iasnezhkov.gmail.com@kernel.org>
To: daniel.lezcano@linaro.org, rafael@kernel.org, rui.zhang@intel.com, 
 lukasz.luba@arm.com
Cc: matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com, 
 linux-pm@vger.kernel.org, linux-mediatek@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] thermal/drivers/mediatek/lvts_thermal: write
 LVTS_CALSCALE in lvts_ctrl_configure()
Date: Thu, 26 Nov 2026 00:53:22 +0000
Message-Id: <20261126005321.71799-2-iasnezhkov@gmail.com>
In-Reply-To: <20261126005321.71799-1-iasnezhkov@gmail.com>
References: <20261126005321.71799-1-iasnezhkov@gmail.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795654401; l=1283;
 i=iasnezhkov@gmail.com; s=mindone2026; h=from:subject:message-id;
 bh=DfpU2QqoC6gb2t4TCCBuYupqgxwpLO6QVGeUXzAFNXc=;
 b=2bySduS9R3VaEm073Or1qqjPHuTmVrGNaFcC5OQ3+Hzxz0rBhNpPxGJrdIyjy0OFVMdrBP23H
 VOVIOeoOk4oA+ttzyrJlMXKFNcbVolhIaKRP+68BAlRlYpSfVYocuvB
X-Developer-Key: i=iasnezhkov@gmail.com; a=ed25519;
 pk=hQgXfiWi4ukk2jh4BHu1vRVhg9BUivo//AFp50AKMag=
X-Endpoint-Received: by B4 Relay for iasnezhkov@gmail.com/mindone2026 with
 auth_id=1643
X-Original-From: Ilia Snezhkov <iasnezhkov@gmail.com>
Reply-To: iasnezhkov@gmail.com
Content-Transfer-Encoding: 7bit

From: Ilia Snezhkov <iasnezhkov@gmail.com>

lvts_ctrl_configure() assigns 0x300 and LVTS_CALSCALE_CONF (0x300) to
the local variable `value`, then immediately overwrites `value` with the
LVTS_MSRCTL0 filter setting without ever writing LVTS_CALSCALE (0x0048).

Remove the dead duplicate assignment and write LVTS_CALSCALE_CONF to
LVTS_CALSCALE(lvts_ctrl->base), matching the comment above it and
MediaTek's downstream soc_temp_lvts initialization sequence.

Found and drafted with an AI coding assistant.

Fixes: f5f633b18234 ("thermal/drivers/mediatek: Add the Low Voltage Thermal Sensor driver")
Signed-off-by: Ilia Snezhkov <iasnezhkov@gmail.com>
---
 drivers/thermal/mediatek/lvts_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index 350fffd..e034c6c 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -1197,8 +1197,8 @@ static int lvts_ctrl_configure(struct device *dev, struct lvts_ctrl *lvts_ctrl)
 	/*
 	 * LVTS_CALSCALE : ADC voltage round
 	 */
-	value = 0x300;
 	value = LVTS_CALSCALE_CONF;
+	writel(value, LVTS_CALSCALE(lvts_ctrl->base));
 
 	/*
 	 * LVTS_MSRCTL0 : Sensor filtering strategy
-- 
2.54.0 (Apple Git-157)



