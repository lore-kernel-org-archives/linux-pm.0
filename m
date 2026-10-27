Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793107078;
	b=Uia/IovCFMU+yLhj6qwlr0ktl9+lbb41Sq4VkWLAwbpLu2xeBM4Q6TeroLetebf+Yiw5
	 xY71VpIt6CbtKST3JTfm1IJNPY0RpNwvm25OGYyDf4KKy489heMcnGOFFOPTZb2Nfg9y9
	 3Wa9z0KxccZwpBjEaFVflhHFsTkbaaJLvqu3qnHrUOzarVHnGY/bqlrBMmc4QGzeEdssc
	 HM8rwrNV04Hh0QFjE4OQa6LYIQrFkZDXqdRn46SU5zYyBi/20TX3ajOybgeW26ZESLXZc
	 z89ymdBZoNxuxFO279gsd4gKV0tAeQPPKOxQsOqIl2lu5xDOVYrwgfk3FlwjtUuTiQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793107078;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=v5imkjHoPJbbt+/z4S2k7d3KU80DTB4+TLzvQNOFtwo=;
	b=12wv8HrMIrdPq6fLgRX4SMc4N9qKb24HaLVys9EyZBL2cnVyZKRp6h16paYktgGcV9cH
	 bN9YoQmgl2+BpjkkdzO+K1RlkHu6nWjNwtQO/Lps42wmoO0lTvN6DKmRjmvcS+x/OZtzL
	 5te/VZ3xQQhYmanu03lsreMKyaAPdtlVFKGm2HLHdpg44aXXFO1YwlmHzWmuAv6jKS8gd
	 jkCcil4Xl7qNxBtNS3fzWmBKkFMmdZzJTy7Uw0+qlPNhQCM6z7TLg5PfIBQU9AoPMCKsa
	 TmVX2coUB6VzTaecUcXhUeDS3R+EYoNetCIEu//OmBAQt/ZGyDpE7QiZ4B0/FVX5y8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=s0WvgH8Y;
	arc=none smtp.remote-ip=209.85.160.43
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5607C606A332
	for <linux-pm@vger.kernel.org>; Tue, 27 Oct 2026 13:17:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5607C606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=s0WvgH8Y
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-49ddddefadbso1806524fac.1
        for <linux-pm@vger.kernel.org>; Tue, 27 Oct 2026 06:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793107077; x=1793711877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v5imkjHoPJbbt+/z4S2k7d3KU80DTB4+TLzvQNOFtwo=;
        b=s0WvgH8YRKiJDaQJb+/kYIoeelgJyDsCiNXBBqBdIn7cwdLU1FGzubr0w+UjIhMbQH
         KPwDA482RpwlZSUK5dVYxAlWXwYABc2m7JkbGRRUolTWReUl9y+ZY92AVGtTxMcyXNRc
         ndMnDD28EyMX2NaQgOazSi9pZoKO3oi+cUXLQrxuHgUjXwjRSiB4C6M/Y6v/VI7haCJU
         3xVYYWQOwv4yAMqaMnEcVMWly6ebxpJfcRAemuLAWbhTO/Bjru4jVeiaPftBJIP8upMu
         I8lLTINJ2qc8g9qLqYjDGdLMXfQtc/dcLfVu+MFU9eEBcDl4lW9S6fDLd5cij0ecMjNG
         cqHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793107077; x=1793711877;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=v5imkjHoPJbbt+/z4S2k7d3KU80DTB4+TLzvQNOFtwo=;
        b=MLrTcLkVNYHU0rcBoeSUBvQVMWgiZD9eXVK9Wy8NYB7Xyx4Ou19HnhOyquPCfrUIGg
         05nE1Kmh7k6ND6Urd53pXLLMcBhbY0Wgn8hNH0IlQnhr08Hd43l2xYfoBD739iedV5Mz
         tZhWzQ8xO8egvoN8X8ERZ5pS5goX4UNV06S8mzZSyQZ1wQySm8IbHy32+NIKkvqDsl6l
         /UpstvOkHOAzX3NSz8mvxWnKJ+hrT5Sjerf+/uVr4stfcQpXgHglX+8Oc/cM9isS0f3t
         GuJfvO3IzxoYKsXpkq9zQP1SE6NDmDDYiFPju4SANrqlviMvbw2Rb8Oml70+czOJTmtt
         6Mtg==
X-Gm-Message-State: AFq9FYKNgo5XN/JbtORtQWGNEiEP9UEDbdVMVgKYjMcP5Q/CgDG22jEj
	iXt16glE4z74hoXXT7fykSuUyJx1TOo2psmF3e0RtsOxh1McKxsSnyZGcf9Hdfbj
X-Gm-Gg: AYBFou0STBRvDj5R6uyAhMpYkRzblizdQDwYt8H0fG6UEVHI2Fwah+VJ3LQsu9gJkCU
	OcLhtVHBfkt/3iz2qiKxIrl/z1y9nT+bG7sFxkR5UX13LSpgGj1JRyYI3Ww312v1+IypCv/5Rps
	N9aK21k6WWKp6l/jdsLhvjnX8IRauSLTRtFTLBhRlXJZA/t2MNzeC4XhY2sOEtlGIpSasrdppZU
	AmIH2fPkYrFLddKmLWWwaUtF9EEkPXWmUc3YgzWk+S7jf5jyCaPFqXWo60QHR4D6qJoj2iGKSnL
	0xDZicKF/CuqnClEOKU6chqq03AS7lYVh74ZYWrtTkhWx/6mMPvL0wcGjna/ocUKaNPDfmEpda4
	9o/RvGXFiYKwSYMBdRlt/72i7Nkpx+e+e2iTADkBFjgHau31Nnz0MZR36m3Y+ZmBpo7rDsMBWHI
	TqVjHzDjycCnilNXkB07iSzFgou1yNoUAAT6TpmeR4+rOPdytr1ZO7JTbyzY3mhuM1ipn/H6Mq3
	lPPPRwMBjGV91d6Rgik7wyWoeiRrJjLbzuna3TrClg2t1sNneXQDtU/3mm+BaZ8ENoYpixPixRQ
	Aw==
X-Received: by 2002:a05:6870:9f16:b0:47b:df9f:6c0 with SMTP id 586e51a60fabf-4a83f1b8661mr6536028fac.4.1793107077365;
        Tue, 27 Oct 2026 06:17:57 -0700 (PDT)
Received: from neuromancer ([75.28.21.198])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a8b74c0a7fsm23412fac.2.2026.10.27.06.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 06:17:55 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: linux-pm@vger.kernel.org
Cc: devicetree@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	heiko@sntech.de,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	sre@kernel.org,
	t.schramm@manjaro.org,
	Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH 3/3] arm64: dts: rockchip: Add Battery Gauge to Anbernic Vita-Pro
Date: Tue, 27 Oct 2026 08:17:51 -0500
Message-ID: <20261027131751.1724448-4-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261027131751.1724448-1-macroalpha82@gmail.com>
References: <20261027131751.1724448-1-macroalpha82@gmail.com>
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

From: Chris Morgan <macromorgan@hotmail.com>

Add support for the Cellwise cw2217 battery gauge to the Anbernic
Vita-Pro.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 .../rockchip/rk3576-anbernic-rg-vita-pro.dts  | 21 ++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3576-anbernic-rg-vita-pro.dts b/arch/arm64/boot/dts/rockchip/rk3576-anbernic-rg-vita-pro.dts
index e66803b5399c..5c61467eaa03 100644
--- a/arch/arm64/boot/dts/rockchip/rk3576-anbernic-rg-vita-pro.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3576-anbernic-rg-vita-pro.dts
@@ -954,7 +954,26 @@ hym8563: rtc@51 {
 		wakeup-source;
 	};
 
-	/* cellwise,cw221X battery manager at 0x64 */
+	cw2217: charger@64 {
+		compatible = "cellwise,cw2217";
+		reg = <0x64>;
+		cellwise,battery-profile = /bits/ 8 <
+			0x5a 0x00 0x00 0x00 0x00 0x00 0x00 0x00
+			0xab 0xb5 0xae 0xc0 0xa9 0xa4 0xcf 0xaf
+			0x96 0xff 0xff 0xd7 0x9a 0x83 0x70 0x69
+			0x65 0x65 0x65 0xb8 0x81 0xd9 0xaf 0xd9
+			0xd2 0xce 0xcd 0xcb 0xca 0xc7 0xc8 0xc5
+			0xc2 0xba 0xa8 0x96 0x8a 0x85 0x7d 0x7a
+			0x7f 0x88 0x92 0x93 0x94 0xd3 0xff 0x5f
+			0x20 0x00 0xab 0x10 0x00 0x91 0x68 0x00
+			0x00 0x00 0x64 0x3c 0xa0 0x89 0x00 0x00
+			0x00 0x00 0x00 0x00 0x00 0x00 0x00 0xb2
+		>;
+		monitored-battery = <&battery>;
+		power-supplies = <&sgm41542>;
+		shunt-resistor-micro-ohms = <2000000>;
+		status = "okay";
+	};
 };
 
 &mipidcphy {
-- 
2.53.0

