Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE059448BB3
	for <linux-pm@vger.kernel.org>; Mon,  7 Sep 2026 09:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788772340; cv=none; b=tVcqoYYnAzSPlPcss8GjEXD+KzdIRUyw+m4rmgNPgu3xgKSBypYubG+nTXFDKJq3Bb+5fqJVToe8U9zeuXAMeEqSs02+UHJUGnFmhKetf+LH6uKKCNzzxtcFzkNdfXkq+v5AjnH3Iu88a0s+M4f5qECkH1evMnKh+XvNKPCALCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788772340; c=relaxed/simple;
	bh=b9MDW48glDUZmeGUrBdJSpSkTxUVH32mO+7MhRF2Aw4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZFnQx6LdjMIqNFPfweqXguwKeiJjEN8cCGx3UTVOeNgJdCdJNrSkH/LNR79IgiS0hAj+6sEpTgloI3vUdvbCvsmZVfiui1ZynewZYtHmsQ8q6BFjdg/TWAPiMC1Dr/dWqV0q2TGfkltEkcRahehNnOeRW9uk3c42ZSSA0s/KW2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GfGMQbHN; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GfGMQbHN"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-39675172593so2609858a91.2
        for <linux-pm@vger.kernel.org>; Mon, 07 Sep 2026 02:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788772338; x=1789377138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RYuqmLgbF0OITlLbpgtoj67Jrnu3QvKmdHZgYfzFPaw=;
        b=GfGMQbHN7k8KCy/38hGUDA+Yg9XQarxxl7HrkBDsIVt9VzgY4Nx4p5/Q1AMXxLIyHJ
         E3xqwR3zODyWFGnKqSNtd2b/0Q2DPdA4Gi7dwjt01q3ZJkDHY5CJP4/DsrwPo97AtTLy
         mEo23dkAxT+S2Zl37BkZsMvloXxUevsY984ap8QkqUMS6PpD/HOgZU/u4I7qaU0tdLGO
         rsyFT5c1jp8WCR47Oq/atWVWtdAPH/+qGIMLWyoACue17qdMS53JGS82mgGwvLW7JE/v
         0ARtYRKRb30m+DJMGxfzOol1sqUnpgRn/YfQifxUcvyLavFmkYMamNqK8zZ4zhijf5a9
         zQ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788772338; x=1789377138;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RYuqmLgbF0OITlLbpgtoj67Jrnu3QvKmdHZgYfzFPaw=;
        b=iR8GURQfQkVytMkIjhWYVZjOLVPhV4oB7k8JYakk7E/6eC+PM80HYDo+5ir2Z2jqeX
         xCIGSx0Db6+bApretH1P7O9LmZUTqgcFJP21fVtAKwBbtMsTfO7/7aWzEaYIKuXTn/ZH
         bgUq5e8bPmhtMB9WzDyIEYHl0JsIAkYpqO+x/O7S2RjwQe/Ek2zv5MMgTDyKGt8kZP6A
         yqY3S84RggiJeP1ymg8D/hs2vI5ZR02X+Wy2dTOu/yieVm6I7lcVWPmf1zuQF4fT6mpz
         j25Me++WwOi8FUlUv1mB1ye0Cj2BbFO8KavAZc765sQB68LteYdvohj1Nh96EbNiYk4r
         kq5w==
X-Forwarded-Encrypted: i=1; AKwUvByrLb3+iYFbPweQzRokB20sLbkdRPu+NoQyZqcBNS86WOAXeqCtEcbWD7KsM1jqS2LfR2Wvd9whIw==@vger.kernel.org
X-Gm-Message-State: AFuF++lqPX2uqsioZHOd32OMzWB/QUmz+/p+yA3fLNPKSe+nVy4qfOyu
	vuM6fW/+H4WzSUXdkgHzAXEL2S8cd3jx+1ZxycWXsdXs3+3xmckPZWLQ4DcBFlYq
X-Gm-Gg: AYBFou10zqLcyvFKJ7EiHTWDOfvJf6L5s4nPRL0t9WmoX+HdzyFeLW8XtLQlfrReaLG
	8fh3KkoQWAYXX5aYidZpTbREzahv4DPVhRI3PROHUymbIjtpoMGJ/Sf9Q9iLHVrLJIGL/bNiZ+3
	/H5QNOCVfwjolTavazfZG51/bWQ1EZfPQtnCeB1VQgN6RcRVb/b7vIc5CRmjB13WztwN+2e/moW
	g+6RStbnAnyG1iTCg+7CvNsh5ZYL7zXBEklgUmcoVjvo/ChiO2aOQG+JkwzM+kWLXGjIm4L5THs
	Sz4e/R0COKyBzDRmjaUP3I4C+QJoE5MszaVh6KfKeg4uUREicxHRrwVvWVgtie/S38x+gVQzRcH
	y5WoJrrDThlhcbg+/R9Z6La3voHQwO3FPrv4cxQeaQRM4jSFSlis32nZ5EJ83ZHZTWpj1BlKp6x
	XXQCzTEpruJquAlK5z76TWpbYL/dHFMr/dl5CvYPsDDLnl7H6Je+yDgRRuTRuoh2hVwSQqLl24K
	z2sh2gculPSkQ==
X-Received: by 2002:a17:90b:264c:b0:36b:bec8:94c5 with SMTP id 98e67ed59e1d1-39b2612f7dbmr33136572a91.10.1788772338002;
        Mon, 07 Sep 2026 02:12:18 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339aa37dbdsm22450316eec.11.2026.09.07.02.12.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 02:12:16 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Santosh Shilimkar <ssantosh@kernel.org>,
	Sebastian Reichel <sre@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2] power: reset: keystone: fix missing space in error message
Date: Mon,  7 Sep 2026 14:42:12 +0530
Message-ID: <20260907091212.28352-1-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The two string literals are concatenated, so the message prints
"has to contain atleast one entry".

v1 added the missing space but kept the string split across two lines.
Krzysztof Kozlowski pointed out the string should not be wrapped at all,
which also matches coding-style.rst: never break user-visible strings,
because that breaks the ability to grep for them.  Join it into one
line instead; the result exceeds 80 columns, which is expected for a
user-visible string.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 drivers/power/reset/keystone-reset.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/power/reset/keystone-reset.c b/drivers/power/reset/keystone-reset.c
index 3c44cd6cee0a..491ba490b8ea 100644
--- a/drivers/power/reset/keystone-reset.c
+++ b/drivers/power/reset/keystone-reset.c
@@ -112,8 +112,7 @@ static int rsctrl_probe(struct platform_device *pdev)
 	for (i = 0; i < WDT_MUX_NUMBER; i++) {
 		ret = of_property_read_u32_index(np, "ti,wdt-list", i, &val);
 		if (ret == -EOVERFLOW && !i) {
-			dev_err(dev, "ti,wdt-list property has to contain at"
-				"least one entry\n");
+			dev_err(dev, "ti,wdt-list property has to contain at least one entry\n");
 			return -EINVAL;
 		} else if (ret) {
 			break;
