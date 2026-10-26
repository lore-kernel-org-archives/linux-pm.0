Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793051131;
	b=avUagDZb21958u+zXF49fwThk5d3hHZW8X66Cc9sC/XZHaIBjnd1ItP7olA1/qmCbQvM
	 ObYr9qC20WpGAlHM5U1A+2EfVjdO/8q6MQOzo64eQExsNS/QgQ1f0iYBkFxRHS52wTK2I
	 T/WpCsnsZw000bDMSEkt86w7l1Ly/vI8Jw41gGkplsPSnKpyQ6BEGs60WlwHllATYBIsf
	 E9gsztN7swcBgKucg93A9gNiRjaxas9k3/xPC51i/4Yefi8Cod3fU3toJxTfhVjPj2ROO
	 20K9NT87SLmhAtUtUumaCCC8BIXg6Tpcktf+H9txericmgWYImlwu/tStWVs+rVn4NA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793051131;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=RxRxbLBQ5S84nbJ2Z24j8qYmciKanlUFlKBok3xXqSM=;
	b=gFa0fgFPsAP/AndFAiR9vPpptJEjOSV/+zpS2vB6bztpBTK1W+2AX9W7A1a7HinFHqWq
	 46GEiuyoutlqRT8dR7kq25zsgCnUoStvezOtgZw3+NVh+AybQmF6OBqibb1RRs5JzN8qJ
	 wSvRI++o7KS5lCYB4hgso4oK9mtAdc7y1rs7velSScutPXWv5Iy3ajbzDWQPJqd57tXJ4
	 R7M3wwSiVoB//btqVK9tU1VOYluO8PaucqzQPUp6D/jK6XUR+e1YRAsutmCzauSazYtQX
	 d/aPnU8KiJ4BsCBVGf5AYY0QRQiBzz8fCyD/vcbKyaIFmtj/9bwiAVzsND9jrWYIcog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=M3BEGRGA;
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F6860A261D
	for <linux-pm@vger.kernel.org>; Mon, 26 Oct 2026 21:45:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96F6860A261D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=M3BEGRGA
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-35cd4e8bdbdso5692553eec.1
        for <linux-pm@vger.kernel.org>; Mon, 26 Oct 2026 14:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1793051130; x=1793655930; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RxRxbLBQ5S84nbJ2Z24j8qYmciKanlUFlKBok3xXqSM=;
        b=M3BEGRGAH/Vn2SxAJ2DzND9XWJaEthgW/2MXtbTOVBhxXeA9DgmqzFakwsDvTIr4Nm
         7cB3fF0bUrpubPo+WWG22t5+1qoyUQRWDdijeDyKfjB/xcFfTQSWEy42gLuAnCIwTIE0
         PBlq477/agmjQqRSYYXMAKswTErSit3gwmpSc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793051130; x=1793655930;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RxRxbLBQ5S84nbJ2Z24j8qYmciKanlUFlKBok3xXqSM=;
        b=F23ofm3qtDl26/ztTh5aPUxBbDCOnCbG8p6N4ct8BnfNmmHCdc5nCUtYX1YNSyz6D1
         T1DD21nwl/ddS6P74V1qRSlH8YVumDlMhGxkt/14jJmnpaTYWZa98Ssz1ILhSo6X80eq
         hM9UUBA0hKVWrTsgkpJCpTI/+4F3Ysj5OebvSoe4sMM9tzOGjFQee1u2cL0kfdQKFJGY
         m0QYQjtdXqEAw7KgLurVGzpRSc+6k2lY8LZYCgaFREBJ1tY4HQZp+oKV8BHAQ3u27Pfq
         jc5aoF3n/vk/AddWzyh9U+8EL06XB9B8ch5Y90lyKKgCcep1P+rXxg+c5x7so6kdR88I
         T9jQ==
X-Forwarded-Encrypted: i=1; AKwUvBygXf1shSh9ACUw8U1s/5nUs0pLCiIkV5RuIbf0lHFU5bUwcvgk4wyRT2ASPeBdVnk7zU11lreTYA==@vger.kernel.org
X-Gm-Message-State: AFq9FYIlCXgKTfnLi2o5iSN4mceOqTIJy1iUs8bReegOzZ5/+2VeM7d+
	eQ4Y5K8EpmqEArX0DFpQ9zyN+N48QN5snw6eAE7taEmHCX89R+QvF/JmyTc/2aG3BA==
X-Gm-Gg: AYBFou2Tq62RbGFwa5qua/sEmVXmPeSspAH+ts6q9Sdmczm2Ddaqyxsb1S5OMV5rPMe
	RPKk7cs2rJiHoHBbQMxPgKk7g+XLiklluGvU7W98Q7mKa5pWo16hb2Ehtza6Vk3u3FmZALtX/m0
	gwVhGPzthe0PDnE2SIBAe/pr7CUWyp4NmAhjx/kvhHDAciaJavULAmjdt8lIqvB+WcQFAaeCDS7
	g9isr30vdWFLLjy/Fbfk8eGrKGZZu294KBmwQNG2IQstQt/WpU/j4Emlqu2rs7oxpPxT8cPMBin
	9sOR+FX3sQUQ65kfZs+388a/fWeDF8lU8ZadcH4F4kDlEgXOD2NKtXrCdxVO+8dv941VShOdwDA
	RGAkPyIRH1Dg1yLXy/xvYZWgsLfGo/jTHzRW5ujBI+hMPtvU8kJ8PUq/XVozAThkNdYfDPsP8jB
	/c2gGeqfQDwzIdUoMFxhn5G3j8Jn6SeuXgoEMGFAttQer9Odwf5u24kW2vR5HMlP554vltz5zZ2
	Bo4ueOfm7SX/zLcIjvfVmzCmv2j0JbWzHzXgnmA9rEgnzO105LlZs21VUnLivLwkop/9rm0a8oK
	DmT8rM+RUxCFUxPCx6Y=
X-Received: by 2002:a05:7022:eb57:10b0:165:55e2:2d69 with SMTP id a92af1059eb24-199377d8c73mr12569336c88.46.1793051129456;
        Mon, 26 Oct 2026 14:45:29 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:79c5:9cd3:db14:7468])
        by smtp.gmail.com with UTF8SMTPSA id a92af1059eb24-198a0f81ea9sm32064575c88.11.2026.10.26.14.45.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2026 14:45:28 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ulf Hansson <ulfh@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: Peter Griffin <peter.griffin@linaro.org>,
	devicetree@vger.kernel.org,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	=?UTF-8?q?Andr=C3=A9=20Draszik?= <andre.draszik@linaro.org>,
	linux-samsung-soc@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Radu Rendec <radu@rendec.net>,
	linux-arm-kernel@lists.infradead.org,
	Mariano Marciello <mmarciello@google.com>,
	Douglas Anderson <dianders@chromium.org>,
	linux-clk@vger.kernel.org,
	=?UTF-8?q?Jakub=20G=C5=82owacki?= <jglow@google.com>,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH 9/9] MAINTAINERS: Add entries for CPM drivers used on Tensor SoCs
Date: Mon, 26 Oct 2026 14:43:47 -0700
Message-ID: <20261026144346.9.Ibb4a0adecf127291198c372da631ff62b483a795@changeid>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
In-Reply-To: <20261026214359.3122870-1-briannorris@chromium.org>
References: <20261026214359.3122870-1-briannorris@chromium.org>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The Google Tensor SoC known as Laguna introduces a variety of new
drivers, with Google-designed IP. Add entries to the GOOGLE TENSOR SoC
SUPPORT entry to cover the new drivers that interface with the Central
Power Manager (CPM).

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

 MAINTAINERS | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 20bd4e03bb54..c997d23e377d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11424,18 +11424,28 @@ C:	irc://irc.oftc.net/pixel6-kernel-dev
 F:	Documentation/devicetree/bindings/clock/google,gs101-clock.yaml
 F:	Documentation/devicetree/bindings/mailbox/google,lga-mailbox-array.yaml
 F:	Documentation/devicetree/bindings/phy/google,lga-usb-phy.yaml
-F:	Documentation/devicetree/bindings/soc/google/google,gs101-pmu-intr-gen.yaml
+F:	Documentation/devicetree/bindings/soc/google/
 F:	Documentation/devicetree/bindings/usb/google,lga-dwc3.yaml
 F:	arch/arm64/boot/dts/exynos/google/
 F:	arch/arm64/boot/dts/google/
+F:	drivers/clk/google/
 F:	drivers/clk/samsung/clk-gs101.c
+F:	drivers/irqchip/irq-google-*
 F:	drivers/mailbox/goog-mba*
 F:	drivers/phy/phy-google-usb.c
+F:	drivers/pmdomain/google/
+F:	drivers/reset/google/
+F:	drivers/soc/google/
 F:	drivers/soc/samsung/gs101-pmu.c
 F:	drivers/phy/samsung/phy-gs101-ufs.c
 F:	drivers/usb/dwc3/dwc3-google.c
-F:	include/dt-bindings/clock/google,gs101*
+F:	include/dt-bindings/clock/google,*
+F:	include/dt-bindings/interrupt-controller/irq-cpm-google.h
+F:	include/dt-bindings/power/google,*
+F:	include/dt-bindings/reset/google,*
+F:	include/dt-bindings/soc/google,*
 F:	include/linux/mailbox/goog-mba-message.h
+F:	include/soc/google/
 K:	[gG]oogle.?[tT]ensor
 
 GPD FAN DRIVER
-- 
2.56.0.307.g5fe7bd680c-goog

