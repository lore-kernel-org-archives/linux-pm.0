Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD3741A513
	for <linux-pm@vger.kernel.org>; Tue,  1 Sep 2026 07:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788246477; cv=none; b=QdsruqSVV5vMcbJH5O3CGHn/Ha6BCVgWzRPqXou+zxhMaF47btul6O5hHgEBN/zzidzuUA7dY4OGXO7KvsdN+/y+wAar5Tc1IvgnvT/qEI4txmyTm9171XAnGDxBWP4bEgsonjhjQSkYqUrkoQRqeAGXAK9nY7ukNmS0UCBl/zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788246477; c=relaxed/simple;
	bh=HpzD8eE93G0QF+A2LkG7W4+8iO6y5XPc4Rl8E5Fjv8c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M/OOzLAKaLOwPshXe3dB5m4qAA7p4n2D0Flp9IUfbtFKRd+1DArPPfamL7bV1X8QfP7QZtqUo9w+8pKqA6kkP6GkV6AgM86Zi2TRujB7MwTafHBKoGVOCbH4TKPM0odO041C8UIAYiVtyirAUQEQozJmKfgh2xjUSrbKv+C9Wjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dv8aySjf; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dv8aySjf"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3856d6fbcb3so604378a91.2
        for <linux-pm@vger.kernel.org>; Tue, 01 Sep 2026 00:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788246473; x=1788851273; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dCothkY1Rqth/F0B2N1+XSPKgmCrj36SkVxYCdKHFgQ=;
        b=Dv8aySjfpC9KTDIW1iEoYJgwexn0RdcqOgHq0hJ+t6qviKAaov/joQynfsnUYxYiN+
         qWR409b8vIG+EIH0IL7BSN5XeGky8YuYAER8iPaWECQFA0tGt3K0ce08D3XduW8KbMWW
         nyf6V7geYnZufbBcWxEiX+bf52A8WhqFO3TmX7KM2EWDZNIswLk3B5kr67JDztySQc75
         T9vw+9QhIBXgc4Yybja1niUd9usBvJXUZGYW0I7ninEub8y1jLaxbvELCeIyLk+oJd1w
         5UgT5nMcQ97YxHVN+UthgxIgS6iN3e6wfEMp1cCVV/jwtIIVALE12CyRQdoIyJnQHdPx
         /Zrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788246473; x=1788851273;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dCothkY1Rqth/F0B2N1+XSPKgmCrj36SkVxYCdKHFgQ=;
        b=FCXXYJIPhPc4+zSFoOHB5K7m3GdBCoUBt/asDKIZrf6f2u9RLg0XwZkFVctkPoVUIu
         YhJY72pRjqwMcSSCd8ecbCqA+HfF7wQB/gKg1xsuZY3ukETKxc6/Tk2Gd1QQ8uwsXj64
         fPrT3iMnoUMhPiPrBL4hhrgHaVEk7J9u3NBCWR1vwEUbMKBFMEV+tdAP3fcoyqkQLz2I
         2+clqkvZPE3zLnXGyjP5Kmaz97VYt1gmB+1pjRG4mOAC4jJtkk43xUMaBioMXUAjS8dD
         fnO8a6ku0bEk6K9kNKEGyYeS5wv27n3w37uk63N1LQyLu0eqx+aukdPBBwhUn8I0ACLD
         3nCw==
X-Forwarded-Encrypted: i=1; AKwUvByClFXiEfFVcFzJfzwRGaSsJrbc0OY87PRy1iz4Ka1hBe1diHJMnBx7cm/38Pbteb8Sqg8Ts3KkCQ==@vger.kernel.org
X-Gm-Message-State: AFuF++njlOFxaKDByOiE2b0ezW1g4Uq4hOvGIy88X+8q9SAgaceRY9hM
	F2xgVyhC5Rpo6TQMsbiSGB+sstDd5z3ajxmOWeJTj6H03+QWZKXEh1+r
X-Gm-Gg: AYBFou37f2SlQLHEvBNK7XXVLh63eRHJmmrnY7tQy0sgmPEK+KDVr8pSaIKqMU76PFx
	KZ5V0H23gYdvc6AR7Ag2AmFF0EqqnCXQNTVppjorkW3xn6CPZIDX42k0p1cYbOaO8L+2X6eMgZJ
	ZQBI4ZuWbfGYuc4YsVIwKJ7w2gmDCF/U7aBUCziN3FkCsbMTvg2UljBeIlcEjcpT1vTDA3wV7I+
	n3xGm/iJh7NMZrJp0JlXKlChHh6b3/nPGsCVgS/OgI5zH3ZxNDxhk97rvvYF7EEmhZccOIy1Jur
	KCe9yn7oPExnGIUML4czTis+G48LcWRg6kFvW9jPg5+rZeaUbwguend2wjyYCsnitox6pgJBaYD
	ydScAfFhUDCm8kktS0Ky8x52G2rjXr+vP6S8QU1yIGClwva2SpEmoQLkYwhvTRCSvQT7HMYzlFh
	+/suvfucvW58nGiinAdUBqa0DK45LcXW8YNDNjxJl1wvM7OQUUej3t/LaqhRV1mubBGzuxsxDqw
	7e8IIQgs3wNnmjlHYiUHao=
X-Received: by 2002:a17:90b:1811:b0:398:e86b:ce14 with SMTP id 98e67ed59e1d1-398e86bcf08mr15397552a91.20.1788246473340;
        Tue, 01 Sep 2026 00:07:53 -0700 (PDT)
Received: from localhost.localdomain ([157.51.207.128])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-32bdfd03e71sm18274680eec.1.2026.09.01.00.07.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 00:07:52 -0700 (PDT)
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
	tglx@kernel.org,
	ulfh@kernel.org
Cc: radu@rendec.net,
	abel.vesa@oss.qualcomm.com,
	taniya.das@oss.qualcomm.com,
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
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH v8 02/12] soc: qcom: socinfo: Add SM7250 SoC ID
Date: Tue,  1 Sep 2026 07:07:07 +0000
Message-ID: <20260901070717.20513-3-sreeshankar0910@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260901070717.20513-1-sreeshankar0910@gmail.com>
References: <20260901070717.20513-1-sreeshankar0910@gmail.com>
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

