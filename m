Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C8136493C
	for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 15:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787583766; cv=none; b=G+JRbqUhJbr/EyW9uiyux3kdu6Iuw7yygiyrchyKZccegWYJYjFFwLIM2I93CA0wQx271UR6NDQ8WlKKTuwiUOIeLyrlJwpgYHf6po7Y/AGevMwkfS0fIjCCmzy32aP0syguDiggoNY3AP1oSq2hui9cWOeOqTroExbl9K1Ylrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787583766; c=relaxed/simple;
	bh=HpzD8eE93G0QF+A2LkG7W4+8iO6y5XPc4Rl8E5Fjv8c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E7sEV4JvL441SIES2i/nT60yNv7QqVCrw7eyYRS9ocUPbFOx9QLdbGrqqGf/4ONyOI11FFOz4JfpBDqo+qMAWSY/NgtCYEzpMv5m9aQQ5TgT1expzbdOjuuftcQU/qq94P1cHB5f+VcELEvvHBg+xQnZaChDvdxVIoJuw9skWbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q+bh3Wgz; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q+bh3Wgz"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-44cf70de986so2430765fac.0
        for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 08:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787583763; x=1788188563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dCothkY1Rqth/F0B2N1+XSPKgmCrj36SkVxYCdKHFgQ=;
        b=q+bh3WgzTyTYrKZx8FVskPZ5hSB6vgMgsa8qaI2vc1PLIJrhXXW3E4ZbS0/SGrTzUw
         Ek72S14/jPC3uPZdgO5pXW1A80Q8rjNpNBFUVxuwysCYoDPb62mdC+a1I7Tmh0FtbSce
         RYVf4DrJh6vI2fkpf0FrYF3gNjH8+mNAh528tppZmAbWOZxRE5vMZrmCclT2fXrdiCRq
         cDQYHaQi5Vgbi2LY9PePBwzlYe0DMqeL1VFsxh03Fqz2/0VQlRwUxzEzD/hQE50Kvo6v
         5EVk89sUZcg+uRyHyTSm8TQ3LgU9zVWSMnzLHtNhart314S2m2laBm1RmeKQp1/nc2Y1
         SocA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787583763; x=1788188563;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dCothkY1Rqth/F0B2N1+XSPKgmCrj36SkVxYCdKHFgQ=;
        b=gBm8U3ZZW+EArTpQr7KQxUbdtKnTWMhU6xkIBQwMJWJn8Jm4KTQLhv3ZHEuWYtVSTA
         C8C/c8VbqatWVrbBLgdRWASLlqsoG7UbbqHyuTrD+jC3UvsA5GH74VTFA2vT2SVoxzZ6
         X75V7AsVbBL+uMXk8V45Jl5F0n5ds+bcWIpWO+Ms0/swYOAbFrh6BPq5bynFg683SB6W
         zyQKMI/+4/hYzJVGnZhFSZPAnnjhdigZKSuQhvAufbkIwBFw3PNdake4q4yfEl7inXYe
         OsCigVb8AHQJxFh/qoMI8jUZtSTPx8Z6eKxhv6K2KnG4saZb70xkcLZiz3wy0NIVYR6W
         Y8Gw==
X-Forwarded-Encrypted: i=1; AHgh+RrW3wL6j9uztbcL+YqlOhGLkKSK9UL/ssIF0MZvC9J6hXYBiLGgOBZgcyf0awjpPM2fE9uka+KtGA==@vger.kernel.org
X-Gm-Message-State: AFuF++l9HK+iCQCyg2BAfN8IKPW6GtiNq0LPCyx5EXjgK4DiXGg0ayYI
	imsoN6EPX1rroJ7UmlYAhLCXaxkm32my4EBHkHW0t+1JCaR5lC52yHNF
X-Gm-Gg: AR+sD13FZBP5A7c7sjrsPTuue2JwaKX69DwNEgzalXcIfQg4eMgs3MRV+iiNrd2L9WU
	hAzZ3rwCwHIVdD8/eAle9T2F1lhbzuwYPt1BTG8E12aYHZMAZtRhuLecUHlAornMCDPCgUzQRdV
	omvFLRcUys+jWcOmHTdFT3X4dwZxOFrnp0eXGLYm030EHrOgwYLaJVgmxRk4bx0BEAXmQtvmMEJ
	xwf60B0v9eTC1zrdLp3jnTJCaGnYtj4mdtimwB43g0zQG+L5y6SF9d2u12Mkbidtiv/h3AEEL1F
	ZB54VqP7epsrJYn++Qf0MEllx0nMeNrw5w8oVAK8WElLXP0+OkCZvAR75cYU5uRunRY9qM3gAzx
	xWMnTUS/Zfa7ppku+Crcb3GuiJ532/aOnMEWZwAuk0Y7R+Xz6d2leh9kHQQ265UMFM1GVZjuOTo
	3EgKvOF2j4Fw8noJSF5cO7ryYUgSV8gcmH1UU84PR3WoxyIYF89zyHfxnvXSEBc2xqfI4c7BIhw
	YDFzrav0TKU
X-Received: by 2002:a05:6820:2f04:b0:6b1:4147:4e16 with SMTP id 006d021491bc7-6b16b39a036mr12301671eaf.22.1787583763368;
        Mon, 24 Aug 2026 08:02:43 -0700 (PDT)
Received: from localhost.localdomain ([152.59.223.115])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327f91d381csm30035247eec.19.2026.08.24.08.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 08:02:41 -0700 (PDT)
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
	taniya.das@oss.qualcomm.com,
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
Subject: [PATCH v6 02/13] soc: qcom: socinfo: Add SM7250 SoC ID
Date: Mon, 24 Aug 2026 15:01:45 +0000
Message-ID: <20260824150156.1310-3-sreeshankar0910@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260824150156.1310-1-sreeshankar0910@gmail.com>
References: <20260824150156.1310-1-sreeshankar0910@gmail.com>
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

