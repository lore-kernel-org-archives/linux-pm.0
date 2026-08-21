Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E96365A02
	for <linux-pm@vger.kernel.org>; Fri, 21 Aug 2026 15:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787326877; cv=none; b=s4gDOgl4xHKx+a+U6kx/j46Ay5nZWfIuMAKTBjsBEoSoQW5iSLDX/meqVpkCxVIC/Pg21kmD5JdoUbmjVRMZypKp9/uQQJWaNmAGchv+/e1v1pnB2AljG+2vuIRpJP90IMtbDhA8lKlDDT8KndAzQ/MkhKajv2hDeNjzmkPS0SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787326877; c=relaxed/simple;
	bh=HpzD8eE93G0QF+A2LkG7W4+8iO6y5XPc4Rl8E5Fjv8c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lUXHUBNQ1nL+73K/+Fd3k3elD4IMqOheg0LT5A4dEcisDvRSlpTtRgKTwRzp4t5ISohr7DnEQeA1iLX3bV4oQbt33GZJ81zhbsQ9Sx+MpRMo9D8LkCwWBfjTIthb3jCWV7clFf8oqjMLRAQ/sI+yFNGwNs20Q7rp98KBJIzK8cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B5wmzQ6H; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B5wmzQ6H"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-395cf2535acso688971a91.1
        for <linux-pm@vger.kernel.org>; Fri, 21 Aug 2026 08:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787326874; x=1787931674; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dCothkY1Rqth/F0B2N1+XSPKgmCrj36SkVxYCdKHFgQ=;
        b=B5wmzQ6H3qCVvb/kiwpVCc3GorS+NW2Zul14/aoQqZsgbRooEgmliA7t83ZK9QdaP3
         azNf1qIoB3/1Iuw1dHVJHqeb6mj5Trn9aYLwdHTAyxetxXR9euD6uQEvotKStzp1DBzN
         y66mMCumE1+NIiCyhQb2J8QDiPQYAC7DU3TvL9mT6JdYDrdqf/aa58lGYfzPWq7Okc/k
         pLRyGUo1bb12DoePiz7kOjyB1UCPcGRXEur+U1qwHsG7NhwV1d0NerBfHYOZ+AFToVAb
         ouJGEp+JddRzLWXtWNTSaGFDOgfz0rhDx1kswGF5bqTBK0sv61HQcM63wnCqzp+DGfdD
         GsqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787326874; x=1787931674;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dCothkY1Rqth/F0B2N1+XSPKgmCrj36SkVxYCdKHFgQ=;
        b=ewgKWM4OmMtP7axm1/OXsCXYh0dcsKYZd7dAKGy6mQRU64tckfiPMicMQDpfXerEh3
         3iMa8Gsn1sSbwRT1p6zqrZ+JrW/fyGWDigygqxp9D/TSdZM9yii9vAR1+9a++pFYS/Ps
         hpsVyuARh3Q4DAgRNEOKYhYQeY1h5i6JIVDORMejX2lKlxeqT7Isb6Z+bKOsz8u8Lh+C
         PvNuuvdcQ2ibos8qfxdpLMg00M/m6Wr3j9LMdr6xkBmm9kn1mupLPDygE8+AbuONTAS/
         wWp+aTWrRyeU9lw3En/v5meqIP0YtpOMAr37wREsKCeIvquZJP6LeghxP5OaRrBt2Nku
         I/ww==
X-Forwarded-Encrypted: i=1; AHgh+RqZgPDNwJP/x5i9kYkXhe4BaK6sTm/8wbPq9R0HGUdkk1Y9vB1cdNcrVVcS1VmJP2j4JzaDQIYaDw==@vger.kernel.org
X-Gm-Message-State: AFuF++mC6Kk91tkxjTgUQ9QhuzAP4Iou+BZysrQSy4xVZz/lxK6EeJbU
	ZzGAxUpQpE8xCXYFgf7TJl/XoW8gSjOzH2XsHNP2MXqtzisMhbtK9HOitzzvzM3wbyw=
X-Gm-Gg: AR+sD10npL6+5XEVVcT7d0MC7oBHVoiDxog9zHOa1YHVOPXDPXdzx/6BOljX510p0Tq
	j/mX8eRGXz/AKPN5IaN37HKckmM7ATa1kBni/dwVAdQz8LDCnDZB4v4qdMNxTv6cSifR9a/KBne
	xOsiTTafsx/4EbxoKl7BLWqTi3ReTHS+jMzXUO+ywbyOjE4K0x7WsO7AAeYLQWXCry4Sjn6hNSy
	SwnmQTu2t+G5y2mx9g5FLatUWpvf9hmS07bZOYVE3ZMDBm2rCVTglh90yl8WydcHiKEFP/UDTqT
	hXaUuNKzRhZbW0F/XHPltffWaogyIREPDowQXSZgEb3xhNdvAmL1DY5eQ6u16TF3gwR1O20wTn1
	t5/trfeaVl9i1V+6CJ13+hiGrbQAcSwyZeTbTjqicjhYhX9ThT41s2e31iU6+tApCIAajUVZCjq
	xXAQFDi0rvAAK/TusS2yqaCE7s+sfGUvydXkVmjXWlBmXze0eVJpg7qzHa8MfGE+J3ViEQoXfpn
	VFkSW8ZDHhR
X-Received: by 2002:a17:90b:388d:b0:387:d9cc:7dc3 with SMTP id 98e67ed59e1d1-395a074a348mr20056250a91.21.1787326873816;
        Fri, 21 Aug 2026 08:41:13 -0700 (PDT)
Received: from localhost.localdomain ([152.58.217.163])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1416ae5f1ffsm42903185c88.13.2026.08.21.08.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 08:41:13 -0700 (PDT)
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
	Sreeshankar K <sreeshankar0910@gmail.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH v4 02/13] soc: qcom: socinfo: Add SM7250 SoC ID
Date: Fri, 21 Aug 2026 15:40:19 +0000
Message-ID: <20260821154030.2514-3-sreeshankar0910@gmail.com>
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

Add SoC ID for Qualcomm SM7250 SoC.

Signed-off-by: Sreeshankar K <sreeshankar0910@gmail.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
---
 drivers/soc/qcom/socinfo.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/qcom/socinfo.c b/drivers/soc/qcom/socinfo.c
index 1836e226a..63ee5cd56 100644
--- a/drivers/soc/qcom/socinfo.c
+++ b/drivers/soc/qcom/socinfo.c
@@ -450,6 +450,7 @@ static const struct soc_id soc_id[] = {
 	{ qcom_board_id(IPQ8172) },
 	{ qcom_board_id(IPQ8173) },
 	{ qcom_board_id(IPQ8174) },
+	{ qcom_board_id(SM7250) },
 	{ qcom_board_id(IPQ6018) },
 	{ qcom_board_id(IPQ6028) },
 	{ qcom_board_id(SDM429W) },
-- 
2.43.0

