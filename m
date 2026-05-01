Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219A73806A0
	for <linux-pm@vger.kernel.org>; Fri,  1 May 2026 09:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777627137; cv=none; b=FtR9vy08N+NQ12cSJn9bd9xoEYOwArpgEtaegYp9umSShz9KsEddd/Hn38XgDyFgcMxwdJbTMLcKXgPF1spyn2Z8HubfxawkfvRA2xUItRE9kZ9+6RrUO+fyLbnpGJ9YWe1mY6MSLof0gdNOPDGyEQfHhPgc21z8dL1hmpAQbAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777627137; c=relaxed/simple;
	bh=XcfJhcCYTkjzBCvg/Cxuww7QqKifGaagi9xIyyI67cY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MLVxvwGUVIaman0FWz/Yqf8AowEZkz/MpNZXrCNOlQDVA190fILI1hWWBmr7pfzr9Vga+UTTEAZV94YQpTddJ/cXha5sgCIV4PndnKdBqml3Q6cPjWbvdxmhgWq1cA4G/15J9LUSZOBwr8COI/Gl/6kCC3wQ7uYkH8aAQKJfJ6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=UmFMgQ38; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="UmFMgQ38"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-449d6c68ed8so1073220f8f.0
        for <linux-pm@vger.kernel.org>; Fri, 01 May 2026 02:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1777627123; x=1778231923; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZnuErBRIZTrfkelR+38i2qfJhgtaQ07JLYCEdmx/1ig=;
        b=UmFMgQ38nVJ/7i+khKEJsxD3GRutbNe3PNGcY5YY/XzZs/AE2Hp9KL50iJ9hPe0S1W
         NlwTiiQ7eYOMW/uRpxKHacoOu8xkBe1f0bur6yjdfIuCUTvEAMcMBXZi2zVathZbyIjc
         qW0GdJPpqhGq5dAGfL5gEh9D5hKTBantio369Yh2ThDrwHpFEzQgLXHfw9nBUKxyu0mD
         cmuNxQVO5CRhaKrxOcjyK8rVzAE2JIowROne/CiskazjT8W9iGu+cP/+rEPBAdsInZkn
         TFfWO8PHzgRYjqxFiLQzYUBw225rZrDdcRu5bR9OOS/tHShTVQhokAkAVzdHNLuAKLv+
         Q6yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777627123; x=1778231923;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZnuErBRIZTrfkelR+38i2qfJhgtaQ07JLYCEdmx/1ig=;
        b=bdEoCRkR7tSL9NJ5oR6ZTUg2T86HhPuLV0WvgxDe9h5nb5Otc0AvtQVzyRYvQ5ZtT3
         gRGEOo74/QpBCzIHyPGg659C05G4ZoZzZ146KcJGW5++5Ot+d2+PCc6PLhrdD9kGiPOE
         cnzdmOD1/sAYtpspzSzuL/2CgAi3fttNzq+PHiQxfW0euS+gr18grU2wClYAv6SwF7VM
         yxVXqrnitbPqLMr9SD1L8X1G3tDmDfU+a4m31pda3ccx76eLE8Wk+TM672YtZUCAlJei
         sEl1nF3XkvTNa2dlkg6uL79Gs3W7NG+fTiU5B2gq+en9bSO5XhXYcOzCT5O/3uoXiORY
         q0iA==
X-Forwarded-Encrypted: i=1; AFNElJ/dq+AgCdMkt7ixn22UiCLF7c+Wx8sl34xw+FxBAT+8IZFTWRYKFJyS7QfexooQsq82Npf90AywsA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyBIDI76szfAy17n3/gvc1o6HjoN8/5WOcUWZaeUlCl/RMLpMe5
	QEQ9cgPpsEPKJnGfiWRBg0MEBxqJI/zKNVfCWoeO7YHP99y3JHTtwWiRRdEm4inilGA=
X-Gm-Gg: AeBDieuUm4xsB7adSFwaPW+UVbR8wuvFOroVqftf9idHj5NDqd5o1Yy6Je5UFDty0Ik
	hRpKHIW0/g7e+VV6Ok+ulXF4KM7mlY/vflb8kiMKgvI5yVDZtikdAojvMWK7Bud+nqadCcUVMxt
	WgByljwZLdwWvLcdGBzZDrPyaWWF1MlcqEUJMkz0jDof+A3J4qw9pC1y5Lfyd/4zSzWfNjlUV6i
	qIQwgxRNF72oTKHTuVvg+UbaZellkCCH9qG9JY/VO9NSnMPlGSTPfZXjK8JJNiM6neZ7ogUDn7S
	Tfo6DlJ8gC6kPW193eEanSscRj3+lyb9v1g1bOaYsEYufQJhMdLTHx+ycgL+Ti82toVWK9fGuc9
	eAp77/eKjGyJuVySRcvxHBVRk3aMXHQd9wM79t9bXYWWAxVE72U8lAzqxTEWDS2ta20sAdQTDV9
	8eQE+3zW5WQeu+2OGhbMrUe9QXA3QjK0qx9KWD63txQxojOw6A6rpR4LWY2If67seR7KQhpdW8X
	gp6utFH
X-Received: by 2002:a05:6000:22c2:b0:43c:ef4f:79dc with SMTP id ffacd0b85a97d-44a857c070emr3502853f8f.8.1777627123520;
        Fri, 01 May 2026 02:18:43 -0700 (PDT)
Received: from [192.168.178.36] (046124199213.public.t-mobile.at. [46.124.199.213])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-44a98b76fd0sm3820787f8f.35.2026.05.01.02.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 02:18:43 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Fri, 01 May 2026 11:18:33 +0200
Subject: [PATCH v2 5/5] arm64: dts: qcom: milos: Add interconnects to camcc
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260501-milos-camcc-icc-v2-5-bb83c1256cc3@fairphone.com>
References: <20260501-milos-camcc-icc-v2-0-bb83c1256cc3@fairphone.com>
In-Reply-To: <20260501-milos-camcc-icc-v2-0-bb83c1256cc3@fairphone.com>
To: Georgi Djakov <djakov@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
 Mike Tipton <mike.tipton@oss.qualcomm.com>, 
 Taniya Das <taniya.das@oss.qualcomm.com>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777627112; l=1001;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=XcfJhcCYTkjzBCvg/Cxuww7QqKifGaagi9xIyyI67cY=;
 b=RVgZP6zl4igJW2UZF4EhCIuRsywJ8TJPAYhxRoM9TMx2tC4OgST/C3rBNwMdp80Ll37kF/tYZ
 MYGuDVYg64VBfwf+ZTJzwnsyd0MuFm5A68MD5NmQcV2KBVshRvgGaqL
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

The CAMSS_TOP_GDSC inside camcc requires an interconnect path to be
enabled, otherwise the GDSC will be stuck on 'off' and can't be enabled.

Add the interconnect path so that this requirement can be satisfied by
the kernel.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 arch/arm64/boot/dts/qcom/milos.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/milos.dtsi b/arch/arm64/boot/dts/qcom/milos.dtsi
index 4a64a98a434b..80208bc33730 100644
--- a/arch/arm64/boot/dts/qcom/milos.dtsi
+++ b/arch/arm64/boot/dts/qcom/milos.dtsi
@@ -1923,6 +1923,9 @@ camcc: clock-controller@adb0000 {
 				 <&sleep_clk>,
 				 <&gcc GCC_CAMERA_AHB_CLK>;
 
+			interconnects = <&mmss_noc MASTER_CAMNOC_HF QCOM_ICC_TAG_ALWAYS
+					 &mmss_noc SLAVE_MNOC_HF_MEM_NOC QCOM_ICC_TAG_ALWAYS>;
+
 			#clock-cells = <1>;
 			#reset-cells = <1>;
 			#power-domain-cells = <1>;

-- 
2.54.0

