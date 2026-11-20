Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795202500;
	b=fU8iX/h62aDYkV30o8yM81ER3eW561e4fasa8CfOusbyi53z4d1p0tvZlC19r849xftc
	 NnifHfdyVzhN48JuHRPZid/s9AVN91fspfL67vx3Zw4AAcMgbNSM7l+5bQ0UrZULuYeCE
	 AmZ9wP95ACGICk1pnAiz4uXDwZLR5uMQ4cEpeccOQ+tT2tNXOORYb2PVwLd/L0Kc2BXPh
	 PG4Hy+D9n9TOv/qOEh5tYiWKVZq5YAJ3uCLqL4yTof/TM+NBv+bYQnl5Y+R2q9e1ltDqO
	 47MuZUK2D+3lPLuravKqkvJ20Rm1zJmSvi80aOolhlRELDYlz1K0VcfQa8IhXa8g3kg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795202500;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=qEVHtiKYBLIel8um/QH5PKwY2ZuAggHrE4chfoek6uE=;
	b=bMp24fZMCLbdPV7P1owxSSFUjKRMazhWsLEclWQyrppHCx0C/MI9yUvsRV+D6POTfiBv
	 y7Rp+OJtAHn+JZjAzj3ygQTqFcX5C2Fgusk8iLzFnKB2tcgThE+bBArRUwO+5x8lVG45v
	 2cRuaqPn8uRa8xXxvEh0IDC08/1eU1PxN3sVhuoG3fXMEFf3wK4bLLiZ5AhZRHjAhN4xd
	 QNwvYA7pMKezIFCImpIHpCPMrCR8mc9AoPGdUGPmnt8o0eJqIYGkMRW2P8dKtfQ9oz6gx
	 SYu0qYk2jjOCFyCt+txAY4ukNYHZtYGy0aa14I8Oyzfq36TmmVhsUCuhJg+nApeO06g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hMrXUZAR;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CC1606A6FE
	for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 19:21:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69CC1606A6FE
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hMrXUZAR
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4bb666304fdso22171215e9.0
        for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 11:21:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795202498; x=1795807298; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qEVHtiKYBLIel8um/QH5PKwY2ZuAggHrE4chfoek6uE=;
        b=hMrXUZARRGU59FPPHgFv4/IGmhhGJOHVMMpSO1vlaR+Ih+NlsThC7FRn5On4gWfx79
         WMyakxNhdUwTRSJ674ERC2DyAJpEY1TrEkGY0aXaT0eGDQy01Fl6gfcxrc1g2HOKMo0X
         7IMEUW8DQPbZ8B46kS7OZsK1oH3yrf49uY6eoRemcWpK8CRyu6N80NKu6A7p7Clpf8UN
         1dOOz9hXQkR7FkIpZOLY4BmeC5+ifv77XlvBtaM4xFPwwspKwLuYglrxGOexxhAtrtBL
         trYL5OJngGbZGlSdpkrRoC6nOiOjGbI3IiCXYxPXv1flEDvLtUhJqw6a5lF1yzT9azA0
         vFhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795202498; x=1795807298;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qEVHtiKYBLIel8um/QH5PKwY2ZuAggHrE4chfoek6uE=;
        b=I33kUTJ9e2TQfnqa6/sZBsfXR544hPoFf/WuXN8OTZ4JIw7l7Rr/wNPklAWub9cR5W
         lfBhv6pZmhkdapB/B2Fj0b8d/LGEs+ezuyPsbAvmLpt1BaYhQVtgmooWs6k50L/IJqgh
         7oUqVaClxP0kz/pR51f6TBxoxCldrDXimFQWxJq29Wi957zZ/eiS74ISZw0ga8cDMHGL
         rf1XB3kprGXo5x4/5hG5OA0v8LkaU8tBexiOsl061T5xAuxF8Bmu3MbpjWCpBUBPkTeE
         i/on7uUfkGu3v/ZK4730w7yRYJgfBRYPbyvwK701IV7NLDvIMb6GjdzMHZENCEpEPyRv
         w7HQ==
X-Forwarded-Encrypted: i=1; AL+hErGW6hxNeT6dev4iklDvqGerLu6Z0NuI5xzqeYQjlgqLqq3UhsgDp3UJy4osXzygqa4o8yIi6q2ikQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z9oy1Mc1iJYj9cYZ1d0uhAYLCGcYO1aW0wccYF67777pkHJnLWs
	4EFw5pIl/ar7A8Ifv2tdY+wSvH7QxuQSVmR/IbneazwX9KjlLXelPJsD
X-Gm-Gg: AYBFou25wgADs//QKQq5YPaxn6NUlTSJXvP95DzBHcFnsw4rpGfGj8ZN3iijxuXMEX6
	CJFIooqfEKfvK1klvTBYJmVCFnA81yXdxy9k68OaxIddRkcGX3lsxo3jAn2fV9afrMGMND09bM0
	9p4ngAC9ru6QAhU4Jy42oa4cxLGC58zqG458ZFe2Atl/395ORvgbb7UTkQ31u01AbY8+DZs7wAl
	4+qv2iI2F5+S400TexNqnjAF1aZxjie26r5d+Se8Eo9zXpMnajms9MLE26WFZzjCpWu3syrQfE3
	BPrsRQbe5kDNhop9B6Fh1fg5ML2wKsvyHQfuJHnCg+w8Zqgbc8Cm7O/NSlB2NpAPks8baxc/bMC
	UojnwAaqsCs1lqDcuGKTALMJNGgyXiL05NiOPuA71L/iVgxGyFynfDPlUM8pbWc671dvpgoX4P4
	rTtR/AjzJ5JrGHRapcdOb75lARfYXhR8opSiXmXF2oFl0q/nZ82PDV3kAvxBikp6MePkYkGMmbg
	DMpLR4l9kDshB8Ogd+pmJrh6FJAQix6gC+DgWH6SZ/Uf0YekUxyOOd4bPqc+4fh5+MZwqWUfiuZ
	pHT3MT20Q/33qBXuZQ69aRMhT4Xlxpa29aKJ6QI7
X-Received: by 2002:a05:600c:a085:b0:4bb:85d9:156e with SMTP id 5b1f17b1804b1-4bb8880fe46mr94748195e9.11.1795202497703;
        Fri, 20 Nov 2026 11:21:37 -0800 (PST)
Received: from [192.168.0.2] ([197.250.160.206])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6a67f204sm8405703f8f.21.2026.11.20.11.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 11:21:37 -0800 (PST)
From: =?utf-8?q?Stefan_D=C3=B6singer?= <stefandoesinger@gmail.com>
Date: Fri, 20 Nov 2026 22:20:55 +0300
Subject: [PATCH 6/6] ARM: dts: zte: Declare the HSIC controller node
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
Content-Transfer-Encoding: 8bit
Message-Id: <20261120-zx29usb-v1-6-b0433258e51b@gmail.com>
References: <20261120-zx29usb-v1-0-b0433258e51b@gmail.com>
In-Reply-To: <20261120-zx29usb-v1-0-b0433258e51b@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Stefan_D=C3=B6singer?= <stefandoesinger@gmail.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Lee Jones <lee@kernel.org>, 
 Ulf Hansson <ulfh@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Agustin Santiago Isasmendi <isasmendi.agus@gmail.com>, 
 Navid Ghahremani <ghahramani.navid@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, mfd@lists.linux.dev, 
 linux-pm@vger.kernel.org, linux-phy@lists.infradead.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1349;
 i=stefandoesinger@gmail.com; h=from:subject:message-id;
 bh=ShJdMtJccnJuS9VlQL1+Bdgxlkv6uh6Giop1oqviKs0=;
 b=owEBiQJ2/ZANAwAIAT0TvMhUTxoiAcsmYgBrAJ2XBrdRPG9C3eFKyU7PnA49Uabdls/WYzMcO
 WkzRMyqm46JAk8EAAEIADkWIQRDFvS2qgVbJ5UyXWw9E7zIVE8aIgUCawCdlxsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQPRO8yFRPGiK5Iw//cCN+OqmdHZIesFYbXSmmMdBzwCEi/5E
 A++ezMAgQAwIgDawlimHqrPh8v7KOZ21+gTKfEh7ncmonS3duzqqXvwBNE0ZWZJLuI6VB8oQrxR
 Spms7VnDkKnCWCJY9lwTNTZHiR06DLnlF+2DrauSlWa/6nEsPpIeO5t7IjWkdMC82Nx45kt2kTi
 CRIMWib3xl/OUol5GZ0JplSVHjEeawQNpdTHI9+iaGClORXVFFm6BL5FN+h7/OCFmRt7iqFhrg7
 3637vNdQgvX0WkYq1tg/tCsBt70ZDMbsgxdrD88lrKg1DvkCToKB5r5+KK2TlKEXAz8P1c6z/ug
 4R8tFWrCZxsZkzFTb1a8eLWVt8/3dI99n+163gd1Zu+4t3/AksqtGaMDgXA5ERJ2shUqZhFs/Xb
 q8G4njYOSnTSmqKoYENf/26Kw24xW/ttjqcWploIYjRp7vR82311DAoRXKTzhKZODzPbWYliMj4
 RJtZCS3ZazBCo84x1e5pyyQbQV+tcj8HuVm5jSfvIf2KqK6q7TvAYnooGaIrQo0Yu4LscP8xmwI
 ToFA0xXUfKHLdUVApN4c9tawezCexUY6fasofMNz7kToQ4wuTsKTm9NEFut8zjOFqv5m+xBpEAA
 Hrwn4mejfFyqzdQpJuSwZcy/rL9bARrA+TKCmztVmIi69bu2+A14=
X-Developer-Key: i=stefandoesinger@gmail.com; a=openpgp;
 fpr=4F9C2C8728019633893EBBB98CB81F9A72BBA155

This is for documentation purposes. I have not seen any board yet that
actually connects anything to it. On newer boards it seems to be removed
entirely.

Signed-off-by: Stefan Dösinger <stefandoesinger@gmail.com>
---
 arch/arm/boot/dts/zte/zx297520v3.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/zte/zx297520v3.dtsi b/arch/arm/boot/dts/zte/zx297520v3.dtsi
index 2fc888b10006..56d6b46a8ed1 100644
--- a/arch/arm/boot/dts/zte/zx297520v3.dtsi
+++ b/arch/arm/boot/dts/zte/zx297520v3.dtsi
@@ -199,5 +199,24 @@ usb@1500000 {
 			phys = <&topcrm ZX297520V3_USB_PHY>;
 			phy-names = "usb2-phy";
 		};
+
+		/* The HSIC controller exists primarily on older hardware, but I haven't seen any
+		 * device that is actually connected to it on any board.
+		 */
+		usb@1600000 {
+			compatible = "snps,dwc2";
+			reg = <0x01600000 0x40000>;
+			interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&topcrm ZX297520V3_HSIC_WCLK>, <&topcrm ZX297520V3_HSIC_PCLK>;
+			clock-names = "otg", "utmi";
+			dr_mode = "host";
+			resets = <&topcrm ZX297520V3_HSIC_RESET>;
+			reset-names = "dwc2";
+			power-domains = <&socsys ZX297520V3_PD_USB>;
+			phys = <&topcrm ZX297520V3_HSIC_PHY>;
+			phy-names = "usb2-phy";
+
+			status = "disabled";
+		};
 	};
 };

-- 
2.56.1

