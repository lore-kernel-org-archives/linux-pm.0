Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D1D35295C
	for <linux-pm@vger.kernel.org>; Mon,  8 Jun 2026 05:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780895163; cv=none; b=YcAxoK/czWqvSVJgd91gjfYMv4uiPY083ujmUZWjlwpjipBu5JLyUz8oPIyBCW+SfRkHCxZl9gUOYM93NmKoI4Gxgam9hWroDZQwf/ib978lGRpYsj8ZNvhXcZFIaSXybtqQvMApbTVXeXdH7p2xgkO5rvKMs95Kn5dGtdByS6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780895163; c=relaxed/simple;
	bh=0wKTHNlDJp0L4K8AyG2qz8CpJ4CZ8pskH0AsiWABxHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LPd93Bfa8XtADI2KA/e7Y+WgALZ5m/AhtIM077Ra21L48ddXwamsKIGyHROZZfXh+LsG88a6daxd/8pvSAOJvU9ZZEVn//GKWhbpGpLvjVin8XQqiZvKuDJrt1l+j3+l1PZz2g/uYDgC6ZGNUbiXX3B9EL3RVWkeiQxD3gtPAsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MOkoHAU4; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MOkoHAU4"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-84234c83142so1496387b3a.1
        for <linux-pm@vger.kernel.org>; Sun, 07 Jun 2026 22:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780895160; x=1781499960; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vyAIUXjw4gQB5sSCj4eOpRr2MuOQteh+bl1WhDK1GiQ=;
        b=MOkoHAU4YmaZ2xRPPDW2071cpyl16Fj06t6yb4LJ8CFp+JRXXS6DriDKNk0fTym41w
         at7Sxu3VzDA0QX0YVSTAjFJ5vSn9VCDpVa5WBERtSNS1jszrEZacVJIEFzhO5ZCqOddA
         YMTdps3Vi3sdMPpqMFNKvuFIO6m1Ua1I6GI2dqhS0vPhuR9uFdubh/v42+oWLdDC3mgW
         fZ0c7/Kobcmrl8fIMjU0LnpNuwEgnTny85PMZjQQRDU8sWczsgZD0/SmpXGZTZ0wpCpn
         T05n9eO/g5cKujTm/OoDyAAuyt5uusajRNtSdICCf4WTm6/55HYpoGfzAvsUZA0LmYv2
         fAeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780895160; x=1781499960;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vyAIUXjw4gQB5sSCj4eOpRr2MuOQteh+bl1WhDK1GiQ=;
        b=l1V4a70qVt0RhnAG5wdKwP4nhqHq2htwyl1xwq5nRH/szhy0B+ZZ8i3BZY2CTWb7jf
         BJ/jbJs8Fv7tsGZYz95+EX9qLk/ukThKgtpijSb+DSeUIGXq4qZ57WYXDv1BqDb/LRwQ
         vBBI8QcBCWqStZz15TN7JXDec4YOPXEoILdhlPW+xBGbXqKt5XO8zQyKwAWPldKunbR1
         NdSUKB/0oAnaHaoCHvNDn1IG0Dm3ILIKNnFMPwB84//f3aB2MZ+o/KjcBzwTfOKTq4XN
         CttApVeJ7EojecvOkO+3NuiJasn8V9+LhP0hJdUWTpmREuMoA2ZR+gCRu6gUTA6yPXRT
         hJ+A==
X-Gm-Message-State: AOJu0Yxza+ytP8o3l5JpD5oLFRXrnD6psCfPqGJ7PRbD3U7vuIPDs+yL
	TW8ABS0+WSH6rzKmDDWVvgViF556gbOFZn2kl0eKcHFcar3plI6Mc/vSBGe4Lw==
X-Gm-Gg: Acq92OE0h0FaOFJAByomb3vy0cqJoPdhdF70L0xxCdl8fKaNRbVTa2qdV4hU7ai8jBN
	60HQAPVVvXJzomOmqZFIpQxk80LpbNyksrBBVNZmeBsduU+tqNgnx6dpWuoQyX6sldgQWGdcvD5
	7VsxQ0hu28gW0e64DVyWEspkb3So61YVVtwYK4CQcHVNlXrgcjbk8E3TmsdD54tK7IbX/M8vFgZ
	EL12OPsA9D6ftVsyCxVLEDBdnk9XGz/0EsOD4NXeED3sxgg6NM6BI3gm2hMTI+/DE+Z47rvarFI
	bGIaOYe8ZVuDNrqcuQPy4XiL5tq44UNtrpdJvH3R5liAJr49JDNjqCHoqmPVUOMXP5q8iM7dOmf
	8GebuHT2LTLvFqhZuOOuOcdZOFSRXCJmcHN8o38rVLLhKUOlQUq30RFx4u8T0DejLSNhNF5fhka
	vIaTcMuFcEm9DWGIsbaW+WxhZac/wZikvQmLRF7NuULpjVwpgOJlORAQ1Fvi2RlvEBQufYcCvN9
	cgx2iD1QbYozKMa8OaiRtNCp3SblC148plrcR8D9sq9J6R/c8SlX8pd
X-Received: by 2002:a05:6a00:3e05:b0:842:5711:9a44 with SMTP id d2e1a72fcca58-842b0fb8bfbmr13310504b3a.36.1780895159887;
        Sun, 07 Jun 2026 22:05:59 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84282915fe8sm16728565b3a.54.2026.06.07.22.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 22:05:59 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-pm@vger.kernel.org
Cc: Georgi Djakov <djakov@kernel.org>,
	linux-arm-msm@vger.kernel.org (open list:ARM/QUALCOMM MAILING LIST),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] interconnect: qcom: add COMPILE_TEST
Date: Sun,  7 Jun 2026 22:05:42 -0700
Message-ID: <20260608050542.6167-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow non-ARM to build this.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/interconnect/qcom/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/interconnect/qcom/Kconfig b/drivers/interconnect/qcom/Kconfig
index 5b8a094ca4ed..e6a65ca611a0 100644
--- a/drivers/interconnect/qcom/Kconfig
+++ b/drivers/interconnect/qcom/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config INTERCONNECT_QCOM
 	tristate "Qualcomm Network-on-Chip interconnect drivers"
-	depends on ARCH_QCOM
+	depends on ARCH_QCOM || COMPILE_TEST
 	help
 	  Support for Qualcomm's Network-on-Chip interconnect hardware.
 
-- 
2.54.0

