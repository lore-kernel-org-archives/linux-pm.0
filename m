Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DEE03DDAE9
	for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2026 05:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792041655; cv=none; b=Yxi5jOJpVK2hm6+tJbSM+rZtKQ+t3N11cFktZOpTp5QuCOFsU5qeomdmH1BKRv7p6iT4EjM5AABn/V6GPyi2kKy8ni/MU1Nvm1jMRNUEjXfnehCcwih051RR0Edqen6WIJecFMq95lspH864nGoCBZ+GG4jdu4ItGVgryWWdlvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792041655; c=relaxed/simple;
	bh=6sYp6gwLdM8q2X0kWDCuDxQHrC8+z3UsdjNuoTgAQ4E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VBTWOU4sxPExwCyH8NLVhDMm3AV4RTUiapP+orwh3eNhaITkP2qzhTLhz5FIX88bBu1k0LhtpEA0XNoxHu727RD3LzavunB3YPWOkW4CPjBdK324cDNn3FuX+sQ7X0BtHwok5NTP/EWFLqN/wnG3XAB/igTatKKfYgFVyjcGELE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gTDZn2Mk; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gTDZn2Mk"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-353804b591eso8598796eec.0
        for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 22:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792041651; x=1792646451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jvcz145bWmmDM17NuFw1MIOBpRinQuOt1aSfmpsmn2w=;
        b=gTDZn2Mk/PS1sTuvi90n4mjXrrr2ikyhlmgrnzrZwnoZYcCVtBc7Q8gy+YzYHp7czJ
         gEEjmVsTjcC/Hccd7L0sIBTkahQcrRlb/Y2SvNN2/ka4U2GmKbpCbBGnyNHO28rRObwW
         E6/npQwf2X9LyWggYeQYSbcYND1k3JGwovcam5rOHvnctN/mpEemfuxu3T5ChrEXeUpm
         G8ZO8UVW6QCbGeSmr+i7E2tgl1iKK6xlrhvovZWeMVZ4FCV8ZmIDhZqqvgIoTOBuwvVO
         KmDtf+1CUdxS6cwN+Z05FMaDyb5TG2wBKTqXcV8Kh2HFYFyhTQMn+hA+MGLdVxR7NiXb
         mXKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792041651; x=1792646451;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jvcz145bWmmDM17NuFw1MIOBpRinQuOt1aSfmpsmn2w=;
        b=ccLQO8rkxOxZrvSRf5M5ZeXuX8Bb146pv71OYovrmHUI8gO7o8T9HR/WaaXdkND0y0
         cffZzAEPjLCydMKvSitbjsnY8AjSyVqaWOvPq7uO/b8j3kZZhr3mXnzaF+07EV2tWnsf
         2lGsH0ua4qBgKgRMlUx/NtsXG+hB+mvkX87AsBTI/BfN35xBJCRBcrtfaI3rlyaKAZuS
         6G859TlAZm0pyPr4t5OAgosPk2wGZtAu9C1eusiEy+C+iH0SfBd0IKLwEI3+L7y19HzV
         J48AfEwylg5VV8QI9zBFh06zr4vyXBRCBSEi+XNZtTtxF/EUEAJ0DEPvYrWdgoHEzZuW
         ijkA==
X-Forwarded-Encrypted: i=1; AKwUvBzJouHLO00QAjc5sZT0JKmNgOF2Jl1chOK9VS1b5XjseohubfJJNSsiWMvDF40uraEDf3d0f1w9Vw==@vger.kernel.org
X-Gm-Message-State: AFq9FYIB3XXkTSfwqFAdfXcABUXpll7ihKEp6xC7J1xMgQGDVebBVT9K
	HCWz9tWTVfev+jq3qu5cNd4hjOSFx5qRC+Edm56YZbKoin04HR//5n54
X-Gm-Gg: AYBFou3MxyVJ/2nU9tSSd0N02EtuEf0HZ3JLrBLaAPJCxqGM8sU8BIO+2lu0t3xxcNa
	wQFi5ZAD5ea6CuTMWhQ52Sc1VGDj0QQBfDLB0hj9eCq5GhG/b6qlZyWQ0+gQDpPUhq7mc/GwcdI
	vh3xo8rUYjhSCn6xbI/WlrFVaUbUIZZpHkeC3FfTCef9sTMmV81Qd52M9wdSpSvD766uUSLC5Qg
	gaaUzNjt3DvOhRsyZp6gteR+Cr4rGpLEJUDHDtzpUXursRxhFzBF0G9R8WWzdLgshvqRPEQePXz
	dTiG9k1Xb/PLoYg/lyymZdJfQk9n6vyOgiMH7ym6GPReMso7j5YHwqXhiFb3qyKsrQh92fitQ7p
	urvWPvRcKtaMetEutq4/x8fUezlYzXGE3OvvhXtSO+yPsfZt95Q7rKMOwRMpV5J71PL/MHvnuxF
	kAV/IMnyr0gEI7XwB+PKvLU/yLdhTux1sE3CIHWhJAwR2K/UbPJQfNG4S8Ak3EUjXbtLXWyajpi
	EKf4B5b609BDr/fNeBzeGIBm6t3PnLXRV0KLqtkxLAOL2qLzkHw50M=
X-Received: by 2002:a05:7301:6e98:b0:33c:e74:4624 with SMTP id 5a478bee46e88-3537e112919mr25527157eec.27.1792041651470;
        Wed, 14 Oct 2026 22:20:51 -0700 (PDT)
Received: from localhost.localdomain ([152.59.223.102])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-35de709d928sm12923112eec.25.2026.10.14.22.20.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 22:20:50 -0700 (PDT)
From: Sreeshankar K <sreeshankar0910@gmail.com>
To: andersson@kernel.org,
	sboyd@kernel.org,
	bmasney+clk@redhat.com,
	jbrunet+clk@baylibre.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	rafael@kernel.org,
	viresh.kumar@linaro.org,
	konradybcio@kernel.org,
	tglx@kernel.org
Cc: radu@rendec.net,
	danila@mainlining.org,
	davidwronek@gmail.com,
	mani@kernel.org,
	robimarko@gmail.com,
	linux@gurudas.dev,
	linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Sreeshankar K <sreeshankar0910@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v10 4/6] dt-bindings: interrupt-controller: qcom,pdc: Document SM7250 PDC
Date: Thu, 15 Oct 2026 05:19:24 +0000
Message-ID: <20261015051926.13752-5-sreeshankar0910@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261015051926.13752-1-sreeshankar0910@gmail.com>
References: <20261015051926.13752-1-sreeshankar0910@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the PDC block on the SM7250 SoC.

Signed-off-by: Sreeshankar K <sreeshankar0910@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 .../devicetree/bindings/interrupt-controller/qcom,pdc.yaml       | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml b/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml
index 8162a49d4..c30b88589 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml
@@ -50,6 +50,7 @@ properties:
           - qcom,sdx75-pdc
           - qcom,sm4450-pdc
           - qcom,sm6350-pdc
+          - qcom,sm7250-pdc
           - qcom,sm8150-pdc
           - qcom,sm8250-pdc
           - qcom,sm8350-pdc
-- 
2.43.0

