Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795547635;
	b=bqPgHuNfFRmyge7uxa0CyBp7AQFpZfpYw/c8pJXDLYC0DycekFNmSVqpomL3Y6qcacFd
	 NTbysCuoIA1F/Y/1ET0iq70muUVwtNIIpgp/PhUQQqO5MX/Egou7U3SyDHR+mnmpa4MjB
	 oP3Xb5/H30Fso5dZEKc6wo7Q4GHP9sHXVmo1eXgFKCHtHmsyjfg9If6SWsg/Yc5ekkIsk
	 fPeMDJtsVjAiOxUNMiN6d6ConW6unMe+s93Pk19NvDSS4hdmNFBm0AxnRuJcKlOjanlZC
	 wPj4qPVUxsIbQS6K7uPDiArKwY4/1VwUnQhGrux4RqVN7A+KCQ0sxAu4bd+8ZW+Cjkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795547635;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=vtcXd26CBIIDN3LfpX4nHV3TvJWIXKwwyZF0T/tbLeY=;
	b=Jqgrye+Ckx35zJU7ge3nvf1jrSB7UtfkMYXAa0VarPnxu410NhbqnVsyvAkP3dIsTbFs
	 NFv2aH2XDz4Gb6QTnd33GgeQeKmPhwGNxmhNj5gsnfm3RJ7Q/d2vgZbtUfZeMYL6u1PBS
	 4Sql+QDklYFpxCEsdQrxb/dGh1fZnuVtBodfIzoJRghQiEj87oOwSYefDMr34AZlMln/s
	 Wq1mIBk9vf2UBkPlJetYoKK87TER3Myed2xcfuqgfdlhOLgJ/jZjCkg9cvNvcPA+LkPzO
	 wJzlrItW6ca5rtC+Dg8hKlk7hFqZNsz7XHcS7PrQyRzaBz1JsVpXPgn/Wev53/AzM5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=orNnxcsJ;
	arc=none smtp.remote-ip=209.85.167.176
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B1B606A32C
	for <linux-pm@vger.kernel.org>; Tue, 24 Nov 2026 19:13:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 04B1B606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=orNnxcsJ
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-4ed6d69bdfaso2703245b6e.3
        for <linux-pm@vger.kernel.org>; Tue, 24 Nov 2026 11:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795547634; x=1796152434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vtcXd26CBIIDN3LfpX4nHV3TvJWIXKwwyZF0T/tbLeY=;
        b=orNnxcsJT5wLRMmayn7EAo5FOU0Ktovo8gRz1+OSCFk7pNnaNHxplKx1IJDdcsM9hh
         ShcT+m8DtooZ83MhT1AO4OIO0lPKMRI4+Q32Ne9zetkY5hfQ21xMQ1QKkTub9IEnOBco
         YDfJ0sv3GWjsMQabzHsixzL4i7quoNVRlrF/nmkNO6AlON2qw5Z7xaaz9o8xXzIOTH7S
         70N9b0tW5zIzoOetuNGU06riYyu/YxBPJL2W89MbFbXY05HcLxQsWgTj7gF0aZWm9qVH
         yZ4wEBRkmGhFMNxOo7/JDlIeKXg1W57igrcnB6uT4NjWd1ktTy3vJfexEg9pv2d3d9gh
         BinA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795547634; x=1796152434;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vtcXd26CBIIDN3LfpX4nHV3TvJWIXKwwyZF0T/tbLeY=;
        b=SnZscGYuYrp86oGK3IPNDyQP5SC0ywWaJK4qdAFPOaOYmDBwGyTWG/1trkd0Vuk4Uj
         caUqfwATmTNZJYBjFYlnFy5cYPYbAnwxVTWy74X8z97Rf2rnxuH4o92kR7aDEYnaxszO
         ovUdWGhZyMAjj8koUo3SK0lG3i86/Gv7iZq7krKOk6PhUaraTD2HREWjgBa6iugSGVbe
         8X3DZNMFV0Audf23b/IFWo0KVcddrMrJrJlaEY3006nk09P2xfnl4mJY4Ow638czw83t
         DKx0/S8xnL6LLjdfFsbG5nGq6rIMi2OIOImictGE7Nm9DOS5koZEwMSA752pDt4SiTw5
         SVEw==
X-Forwarded-Encrypted: i=1; AL+hErHYtgVVyoKWHNkfIxGm0cC64fecqEJYq46f5JbNPdYt/nCKQqLoQoEQS3Qzb3M7bj0hQDVNS7YAUA==@vger.kernel.org
X-Gm-Message-State: APuU4Z+eizQPTfxhHmq3SOnl1wVpvJHpsxAPXFWxmVtOkSL4KpxwAmvg
	MFGOdvzOIDQ0gJTgdGXCfVUcyuioGZsgv3KSGiWb76kShQucqw9z5GQi
X-Gm-Gg: AZFdTZdBFBPoX/a0Zs0TOML8BejKmvGvT2Wi+Xjr31EmM/5NGzHJBBQ377Re+QAsbWa
	eTC5ej/9YHKGvVtmcADc/4sp+Psh8rzrdCmvaA512P4FYuDCSv/eO9s0lSAzRz5BwUX339qyCJb
	Pp/lEh97VxyYgZKmewUFMD7az3tolUjd4gkdgwtI+hmJC/rqeO9zgh0xVKUQ5lE64+S+ztAh5uE
	Qxo0nCG80u9Hl+JGU+ooJ9uQ0bUcSD6eKMPbhCGLxvyGIeYGf2BYt1OIICl6BMfIaAmrzaxaCoM
	NLN+QjKatjuwOX7YwktxG9UO0apKnyT0bwBebbpUHoCM2u7dI3WTy3VEbkpGwuOvFxDJ+ASWcL8
	AfHfUcu8BqlLh5r9pl4asow2d/sIDeOo16XkWe099Qc/kQCRhdOsfdLxZkdKn/3PF5W3E1iVksQ
	L/V5+O3ak6BHHRxg6qcldHMMXdbQm47b+eY66Rsp5r83nqJ3r9AFD+adV1JJiKss7wZe3BQsYI3
	MeY26tMROvMz6a96Tb+dEi7TmBG5Ml3xUE+kEPDyBFyJGmqBJUOBWRcSxaPkDUGGKDX8UHhLOYa
	7VG7CfW2K6Zj/NW30YrylFZbeZEUoA==
X-Received: by 2002:a05:6808:19a8:b0:564:36f8:ee76 with SMTP id 5614622812f47-57a06b269d2mr16096285b6e.7.1795547633773;
        Tue, 24 Nov 2026 11:13:53 -0800 (PST)
Received: from neuromancer ([75.28.21.198])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-57a362575fbsm12774058b6e.17.2026.11.24.11.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 11:13:53 -0800 (PST)
From: Chris Morgan <macroalpha82@gmail.com>
To: linux-rockchip@lists.infradead.org
Cc: devicetree@vger.kernel.org,
	shawn.lin@rock-chips.com,
	linux-pm@vger.kernel.org,
	heiko@sntech.de,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	sre@kernel.org,
	t.schramm@manjaro.org,
	xsf@rock-chips.com,
	Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH V4 3/3] arm64: dts: rockchip: Add Battery Gauge to Anbernic Vita-Pro
Date: Tue, 24 Nov 2026 13:13:46 -0600
Message-ID: <20261124191346.434143-4-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261124191346.434143-1-macroalpha82@gmail.com>
References: <20261124191346.434143-1-macroalpha82@gmail.com>
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
index e66803b5399c..2203e092e8c8 100644
--- a/arch/arm64/boot/dts/rockchip/rk3576-anbernic-rg-vita-pro.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3576-anbernic-rg-vita-pro.dts
@@ -954,7 +954,26 @@ hym8563: rtc@51 {
 		wakeup-source;
 	};
 
-	/* cellwise,cw221X battery manager at 0x64 */
+	cw2217: fuel-gauge@64 {
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
+		shunt-resistor-micro-ohms = <2000>;
+		status = "okay";
+	};
 };
 
 &mipidcphy {
-- 
2.53.0

