Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F8C36C9D0
	for <linux-pm@vger.kernel.org>; Fri, 21 Aug 2026 15:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787326977; cv=none; b=nF3ndJ1Gf4JEc+BNSe5f2ETAZwKLp6LI1wcbIO5WHk8y4roqUbxc4N/LeS0iwyu9L7dJ1H1xhthmWLRGZGre0rN9P2aXI9ecLyXXqxpfc6ceRZxf8EqinQC8uQ18ir+rjk9Ws4LHEDOtGZm/DcsAA3rrVO87yxWZIrpDHgbEdko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787326977; c=relaxed/simple;
	bh=u2Yu4YBYm2njILlYS8QED4Q5XuAaD+AtoFT/SlvHqq0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Iu5tzNdxQY0Rtw0qId1ovJhcOJIgzl3dGH7ciVNnDGJHhESNNYTEabuzY5zdjX4TrXIXS6/xGg8vNhcaNcuz9aPt5bCnGGts4UaUPTVVIHo+uDAOgGTjiBKJr2hGYj3vgV2Tfms/Gp/hAbtP5JhIrfLMvojT7RC35LnSwoyeO6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jxw50x63; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jxw50x63"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-38e347638adso1020557a91.0
        for <linux-pm@vger.kernel.org>; Fri, 21 Aug 2026 08:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787326975; x=1787931775; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bEFzlhBjAhuEe8xovPGxxPJuQ8Ojqn67sRBJbsAP39c=;
        b=jxw50x63pNeTsZAxOlpgb+9Ks1v9WQEn/y/ca2XuPKv4XLCOZITDEkVz1TbhtrzUus
         U5heo3pC7HziMnNws0pimkadcLUafsBmfqbAF4y8tBfRDOZQt/MWnLgyfDi7nEbMlhhi
         YAEUj3utJ40kJVIuh0Imfol/i13FzsvYjU2wGrs3dGtftJ3h67BosK0G1JHhC18dTn53
         Jq9r55Cs/Vjo2tGexZ7gDSTK3MOdWxQX+rXhbN1FZueCJGjjNTUTswPZaX0bPYMxBgEt
         Plfu5eMOBQxuo08/784w40Lmm5pXskWjiYghHcmEPfapSI0YKwBkfPO7m1yGl60Yi5tX
         +c2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787326975; x=1787931775;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bEFzlhBjAhuEe8xovPGxxPJuQ8Ojqn67sRBJbsAP39c=;
        b=F+mA/hn6gfQsRWbcG6zzHTuCU9uAItilofQIKkPP06asjwZZA7s2HNukPneq1a+5yG
         96iwctmuHcGkzQKEyRta4orn/eCK81gFEAWNRTsGTow1vd6VXXlhbenILSH1xLADvQ0A
         eeXh/Ala8AVJiVexbL/t5tXqadpPc6BfrPcELeQ92sxSK2AuPlDOru5o5BJAm6MI9vsz
         mP2eXqXyCNJpZnKGR9kAkFQV/w05oUWQIXHWyMMHG7+lAqiqV9Z3cYA3VDwD+nehZg+O
         uQr6s45fx8WLCIEGh0Z7HoWdnpGM1LyX4JfZZ+XYcdK7V+r3pzKojGP+Dfha+UiRbRxh
         gBUg==
X-Forwarded-Encrypted: i=1; AHgh+RrAnQPKQ0TqYtfuywSYspf2WmhpEv+FRlYEIYHi1U2ii8rwFY8E9B96YBhXnOGpuP3l145yycoY0g==@vger.kernel.org
X-Gm-Message-State: AFuF++lOLo60qEwU6jS0CtiJcKS8iQPxu8dHevWRxwZrxm0+eLfjGe6U
	S2BPK0aUfN+Uhs1FtQHe4zz6XIZCM/Xi99J8ShgD5OEEsVqvt0F8nsrN
X-Gm-Gg: AR+sD101W3zYWBHzY5bWDhP2bHbQKOBZK9nKShahDesnMcOLbLZJBXiJ7S6jKmE7Yw3
	eZK//C/OT0kNd6Jzu6QeB7o+NHzWBH0oOY7l5Dsl28jmLiiEe+Bcklqq8i8X5HrM6keZC5stcjb
	9xbf0hZdD5jyE1VdwZyydJWQkfhc88YOm0gr+ooQEQGnhnybt1huHpjtyLWaxDXavEUsH5nEkhz
	JEqB7Fdr+oSTd3TDAhmxrFxuhh6I0TSx4A8FsmYL2bcV+2AcuPDVBsEX/u5qEy5yEOk6y4qMb7R
	kko4rEUxQex1XvxLB1jPezhb6kg9x/jdJ1KZfYHXEV2DeC3r92mtiVEJ4dkyo1aP/kLV0XdkSuX
	gYYOWjjJSTU6jIYsew1m91J0LA76eyRM0bdfLXSarwpaeOoifs+3ho71HsY6n7v/W1d2B6PQqC6
	fTMHTwqyrhwAMgYJMD5G3HPrfqDPDY9oGMMxVZQEV02TH6Q+x0Tsi1bS4SaKB1O8EXnnKgzJqLu
	YuF4QRwbk3I6BCjyg==
X-Received: by 2002:a17:90b:57ec:b0:38e:9045:babe with SMTP id 98e67ed59e1d1-395c354e8e1mr14045906a91.7.1787326974668;
        Fri, 21 Aug 2026 08:42:54 -0700 (PDT)
Received: from localhost.localdomain ([152.58.217.163])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1416ae5f1ffsm42903185c88.13.2026.08.21.08.42.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 08:42:54 -0700 (PDT)
From: Sreeshankar K <sreeshankar0910@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andersson@kernel.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	rafael@kernel.org,
	viresh.kumar@linaro.org,
	konradybcio@kernel.org,
	tglx@kernel.org,
	ulfh@kernel.org
Cc: bmasney@redhat.com,
	radu@rendec.net,
	abel.vesa@oss.qualcomm.com,
	lpieralisi@kernel.org,
	quic_tdas@quicinc.com,
	danila@mainlining.org,
	davidwronek@gmail.com,
	mani@kernel.org,
	robimarko@gmail.com,
	linux@gurudas.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Sreeshankar K <sreeshankar0910@gmail.com>
Subject: [PATCH v4 12/13] dt-bindings: cpufreq: qcom-hw: Document SM7250 cpufreq hardware
Date: Fri, 21 Aug 2026 15:40:29 +0000
Message-ID: <20260821154030.2514-13-sreeshankar0910@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821154030.2514-1-sreeshankar0910@gmail.com>
References: <20260821154030.2514-1-sreeshankar0910@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the cpufreq hardware on the SM7250 SoC.

Signed-off-by: Sreeshankar K <sreeshankar0910@gmail.com>
---
 Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
index 98eb36bff..2dc2c265c 100644
--- a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
+++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
@@ -29,6 +29,7 @@ properties:
               - qcom,sdm845-cpufreq-hw
               - qcom,sm6115-cpufreq-hw
               - qcom,sm6350-cpufreq-hw
+              - qcom,sm7250-cpufreq-hw
               - qcom,sm8150-cpufreq-hw
           - const: qcom,cpufreq-hw
 
-- 
2.43.0

