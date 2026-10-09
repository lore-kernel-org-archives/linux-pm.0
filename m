Received: from mail-qk2-f3.google.com (mail-qk2-f3.google.com [74.125.230.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C554F85CD
	for <linux-pm@vger.kernel.org>; Fri,  9 Oct 2026 19:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791575101; cv=none; b=eLMWuyHEU3X7A5XDuJQqoS94u0uJvEWxestU15kSxtO6dtJu9iIxMPR4HEB8M2qbWjNXELtnVAmO9Vq62p6Pjs3GFGJnSyveaAebUECW8/kgjoNTbmGo/Fb9NI1FkEDyXORJthSUK+MNzENmikIXXqFgSJKKwqUdaCbBIBFcSBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791575101; c=relaxed/simple;
	bh=6mQzJb6HQwk/MiupaE++x+vH8v5ByWD2TN9pKFcfIxw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iT1Qs7iVZzYNWPCluRG48/5P6CAQfzDvUV8yVTUPP3gI/cQ0nL7Bxi9x0r+FVnSqimT+HyqG++f8FGhQrg04q01mCiDgcSsQncSEAd1RFcZWJnV9XdSyY2EiRbxZNTIQa0+uiXDnQP4zlTLKGoe2KYx0EAOzPPQdvUqNT389v4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ic1GyZJQ; arc=none smtp.client-ip=74.125.230.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ic1GyZJQ"
Received: by mail-qk2-f3.google.com with SMTP id d75a77b69052e-5339079c84bso107071cf.1
        for <linux-pm@vger.kernel.org>; Fri, 09 Oct 2026 12:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791575090; x=1792179890; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=euHLhhJIoJOkj7GaOyOYBfCDgPoUg6f5MHX5Oe6p4Tw=;
        b=ic1GyZJQ7vPj7sQ4ZlHdVRRNLG+u0PfXoSGCWDjz3CrzXEf9dlrjyXBq/1LYJX+/zb
         zzLviggvjYuYJf+s0BQOz9em9YdAPLpouHjCLgWbGv1Tsb2dXsAW3ylUWhQWP0d6Zfc4
         p8Q0J4Iz0txmZoqetn4Aqdm175sr1zJz0rQcWXImZwvX92AIe0dv2RmRKM+Ks+Cad0b7
         z/BocPvOtDImHC/c/v6N2mJ++7B6VjdmQbbb57Vq8qynNepJ1wWp5PaWwlSTm+dFRay5
         bHW3jwVhv/SLIqJ/bngXWvVtQz9YWKVzJ24kCpfcn8nLz5Gir2pfJOh9BFihY8mLBNnb
         DS7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791575090; x=1792179890;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=euHLhhJIoJOkj7GaOyOYBfCDgPoUg6f5MHX5Oe6p4Tw=;
        b=TA1CMbxlcM93fA36btFIgvkt4YIv3a70GJqTCxEavnf6/ERy7cGlFmyb1pX+TzH/MP
         6A6kIOenqpz9d5qmkwJfiaJ39FApqiDKghih+AVj4PyfdiAZuODIh+ZviDaPrDITrJbi
         s5c2icW/ZxONBy8S3dTsa+LB9IQT2inllmw5wMg13SkaNKp3nrP9kFoWjOZlc3BlAq2d
         MBsQ1xnM2S3nM34XJAGOCmVFybkW9kjiNHnwWa5xhX4nrZwA1cgbWBkZaGrIVzvd5l+I
         RpoMdJ11dEB/AN+iU7mnp2T1QjKIg/CmCu4UuLGZlyv+dCIyuNwJby1e3tGKz5gluIGk
         7IXg==
X-Forwarded-Encrypted: i=1; AKwUvBxoS1SqiJf7U+It1kYnUExYZQO/9jT2gmXsUL3X/cm7oLXwwl5f943V9gk0C8aBnXrCLNwGEtpbWg==@vger.kernel.org
X-Gm-Message-State: AFuF++mxvfQYWnJQKi0FY9CpclAzCAbwmQ/jdnvznMJ9qLO7x4e74C/R
	6J8xtuYc6SLwjHtqxP+9xU0J35DzmUD57A3yJFUGwDiwdl4A4kejqpc+
X-Gm-Gg: AYBFou3ZBp8vGZ8NLSW30jjZvbVJAtwkQ8My27QMbo41F6Y88mDNeqbIMgaz0C9XG/M
	P/aXh25btTiWQMMO74FcDcTgTBLC1UwNIGIG/phlOYAID7q2nRdFXLoaeC6mUCzmYSbWrV8hnNR
	swLOege7edNnPDb+J/daSVbgCK/2hB2FQNOTZeavTNSlgi3x38uWHOAhfEwPg3xpjTntiQEuXf9
	GV7sLgoVlamI/w1wkVxOQXRLyp8YMVyYOTiS2+a+/3UtVQit1E67LwHH9xidoMsAJjhMgFKubtk
	ZgxgSqXm5T8sdj/65iV7Ten5XFQj1uomh5HffVYzm0ESxql5k4tiKmwX9ZuwV9C+2yLo81fW9Ug
	/yFqYrd3ZuCqUNrIYwyPozEs+sKUXTjk9j1EwG58wg2mryiHOIKwcJaiXnduC+DPAoTEhmSWdOw
	ut2ns9xLyA00G5d02v0lb+vWsw5Oz1R2aqBcS+rYQer94FcMAoltcgITH7l0diqPb2we+9eSyU2
	RMlGpcML3MkA+cZ41AtloyMTjIcbLi8CJEIecw8EmR7aE2GSj1edhQnQfOu/LJEW4nFaXKm5Jw=
X-Received: by 2002:a05:620a:4114:b0:93e:c173:f692 with SMTP id af79cd13be357-93ec1740673mr344729485a.38.1791575090195;
        Fri, 09 Oct 2026 12:44:50 -0700 (PDT)
Received: from [10.10.18.223] (wsip-64-207-253-118.tu.ok.cox.net. [64.207.253.118])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93eb98c5633sm259293485a.35.2026.10.09.12.44.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 12:44:49 -0700 (PDT)
From: Ryan Brue <ryanbrue.dev@gmail.com>
Date: Fri, 09 Oct 2026 14:44:44 -0500
Subject: [PATCH v2 2/2] arm64: dts: mediatek: mt8173: Mark the lowest CPU
 OPPs for suspend
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-rbrue-suez-upstreaming-mtk-cpufreq-suspend-opp-v2-2-ba13f826eae1@gmail.com>
References: <20261009-rbrue-suez-upstreaming-mtk-cpufreq-suspend-opp-v2-0-ba13f826eae1@gmail.com>
In-Reply-To: <20261009-rbrue-suez-upstreaming-mtk-cpufreq-suspend-opp-v2-0-ba13f826eae1@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Roman Vivchar <rva333@protonmail.com>, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, 
 Ryan Brue <ryanbrue.dev@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791575085; l=1277;
 i=ryanbrue.dev@gmail.com; s=20260906; h=from:subject:message-id;
 bh=6mQzJb6HQwk/MiupaE++x+vH8v5ByWD2TN9pKFcfIxw=;
 b=gj/o9tBfq/u6ETFIfGltk7J8BWOdbJWMwl2Y6rCdaGMSFsSW0ix2W8xJy55yWtCQ3zXD6INIY
 13nPrTKxq5nAiEXuBKEl34WBlW0aJ9qkX1kzvEvLJvSkxByDdA/pOB5
X-Developer-Key: i=ryanbrue.dev@gmail.com; a=ed25519;
 pk=KsUvVaP//v/2q+ZBuacc7cLbsyEYn+AD71Sn28oZWKo=

Both clusters otherwise enter system sleep at whatever OPP the governor
last chose. On the Amazon Fire HD 10 (2017), entering suspend-to-RAM with
both clusters at their highest OPP measured 63.5 mA, against 52.0 mA
when they suspend at 507 MHz. Mark the 507 MHz OPP of each cluster, the
lowest in both tables, as the one to suspend at. mediatek-cpufreq uses
it for system sleep, and a kernel without that support ignores it.

Assisted-by: LLM
Signed-off-by: Ryan Brue <ryanbrue.dev@gmail.com>
---
 arch/arm64/boot/dts/mediatek/mt8173.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index 78c2ccd5be13..7f1af15cb934 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -56,6 +56,7 @@ cluster0_opp: opp-table-0 {
 		opp-507000000 {
 			opp-hz = /bits/ 64 <507000000>;
 			opp-microvolt = <859000>;
+			opp-suspend;
 		};
 		opp-702000000 {
 			opp-hz = /bits/ 64 <702000000>;
@@ -93,6 +94,7 @@ cluster1_opp: opp-table-1 {
 		opp-507000000 {
 			opp-hz = /bits/ 64 <507000000>;
 			opp-microvolt = <828000>;
+			opp-suspend;
 		};
 		opp-702000000 {
 			opp-hz = /bits/ 64 <702000000>;

-- 
2.55.0

