Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989CC3E4117
	for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2026 10:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790676376; cv=none; b=ny2csT7Y0GjCyo/JW9MfphQeGz7AY5YP/5uOXdp2LV00XE8FGYJtPuQubVSwzN+Hk1KABOPjMgzz189MnNLM1hlIj9SVEqvnsnSvw9W7fiXmi9tIb9lovcKVSLp5kjNkFohDam/uoWmRdFWrnDp9qJ8XHTLUFdrVaIbJEOqx5pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790676376; c=relaxed/simple;
	bh=92VE8r9mzYOK8AC7tCzlvbIDtHDlmpg8zlN0tg/3Zcs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SVFC3rhryE6QkoTXYM7UyWH5MtygslWaCizEQNeV5WdbxVamh3h6NrFlpxRcPkOHUdlaK/VZ3GKByDww5vJsuKNXJ3B62VXyaOvsLQaUKHUyjiPEq0bxD2bVfUP3EFqDcc7KXXWzbdSghGKatdT+Ct4NOuZSC8NR42+Rrp0G8JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=tCmaeZVc; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="tCmaeZVc"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-488885c3844so436490f8f.0
        for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2026 03:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1790676369; x=1791281169; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eYE9Edgd99flwjX5TMY3XUDStNFD9sn4w1TpgBQJ6eA=;
        b=tCmaeZVcwD1h4SN5M1Br72TaRuAmYEW4hEWLCPrHRMeF5IQ+pFgP1Fp+luyWIsRoUa
         sm93UFzFNsNCxvaK/rOFbHeSpB8DG/GHYP2P+MizdkIImLgM2re3cPR9e8Hs/CTxa1WP
         qGNxNP/kDhAXUs+rd10VA5tCsi9/kvAb79EQo9Jyhz5YNkGPKGhYgXUDSNT3bAcIoXja
         Ej7l+WiittEMl+ZPLnHrQJvttXngWppVU1vC/ahPVVzX7LE8d1+rZICW57HFpC/ss9Jw
         gXYLFQnFX2rBKDTABWnTQC9uTs6zhWvQeW6FoujjErrU44uLwonaQRjd5y9s3rFFz0u6
         1sMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790676369; x=1791281169;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eYE9Edgd99flwjX5TMY3XUDStNFD9sn4w1TpgBQJ6eA=;
        b=avrpB8GqzhSpbbqKqF1ZJwT3eIaUSq8CDI9sapC2yJTvlP4iKplBkSmz6yEixh7E34
         CCViBDEHauthGFk8uqVuLBIi34rLV5LFFnu6PBYvjle9Nln+p4y8QiSlG23lnJt5Njjc
         Rnv2xECgH90/uB3z/SpaTSbgHQkop7R3ude8jX1GDDqHZ1jAan3MpZAkm5m573eI4qTv
         /RBa5PRNbBefoU4i9w95BDwogN82JOq+aP3Evn1BktQMHIjcvYxDJoSj3N2NTIFas/pd
         WTrb5HPiDV63kAvgOOGkjShZvr2I7M8L2xMTrzSoUpT/pLYDi+87zD4jA4JaJvoYof0p
         pOvA==
X-Forwarded-Encrypted: i=1; AKwUvBz2+d/EnzZwA81tpnIjwYlsLs4bjwDDZ6xrkG6y0LnH0o+xxGbzbK1ANss2HJcrF3q9Vq95vC5hJA==@vger.kernel.org
X-Gm-Message-State: AFq9FYKgsruy5ar2/0Stbax0hIpPsLSHiQAR9zOtGrdt5PFol8Ao93Ib
	1hFo1/3oOu1s5LVCu9bInfZQWiBEb3aEfsO8yB+c6CiPRGKwjgrwY4Kx6YSabMfZUyg=
X-Gm-Gg: AYBFou2Yx/EI4xuDVvU4vITJV4yGymo12NKtFKti+NO4TQgqnffZLxmQqRshvm3qITa
	N7/dvlLb2bM6wClOmv0cLtwJ2aCuzsy9KIcgbB5HDa9jBlCCWdL4EiOYvz462etHhPcE0k7D8Vj
	CLvfGX2ImKep43Eg52Q3Dmz4NL1UKHRDhS8h3fqWxMOkIJgfQfxH/nhJ7Hf8qXz7xQlcKZ0UfRR
	nzKuKqEiq2+htXyqNhScTPrHjIHPwizcw8I01RWLTedmPAIw+5RfXubgi7rsAB/Wdwet1Zpc/WY
	nr4NZCObb5on7yu/iXtah011oZaHqfbhRBILvKvvn9K8ot9KjWEK3859AQ+XkFlPT580LBl9YYM
	N1jMPr+4AdbpwGcepx5t/gpuIiTnfCp9MZwkA5urAeKaR9tgMgddZzTfkpGqCNsBVliazlzVQX5
	gev15ZMw+xXqrZ+xqycbyAzuUFvanMxwwxSD78qEe7xfYHExTLzH38Sf+L5fX44BaPW8nCAEgew
	3FGRJc13AXJ+Mqg
X-Received: by 2002:a5d:588d:0:b0:488:80ef:7fd4 with SMTP id ffacd0b85a97d-48af1b36244mr3851230f8f.7.1790676368816;
        Tue, 29 Sep 2026 03:06:08 -0700 (PDT)
Received: from alchark-surface.localdomain ([5.194.93.183])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48af502f79dsm2954995f8f.6.2026.09.29.03.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 03:06:08 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Tue, 29 Sep 2026 14:05:49 +0400
Subject: [PATCH 4/4] PCI/pwrctrl: generic: Fix leaking array from
 of_regulator_bulk_get_all()
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-regulator-get-all-v1-4-e887c66a47f1@flipper.net>
References: <20260929-regulator-get-all-v1-0-e887c66a47f1@flipper.net>
In-Reply-To: <20260929-regulator-get-all-v1-0-e887c66a47f1@flipper.net>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Corentin Labbe <clabbe@baylibre.com>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Bartosz Golaszewski <brgl@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: linux-kernel@vger.kernel.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
 linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, 
 Alexey Charkov <alchark@flipper.net>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=943; i=alchark@flipper.net;
 h=from:subject:message-id; bh=92VE8r9mzYOK8AC7tCzlvbIDtHDlmpg8zlN0tg/3Zcs=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWTt7m15s8EzK/JN78xJbtPerfnDtOuVWBHHzrrMAwa/9
 y66bdS0pGMiC4MYF4OlmCLL3G9LbKca8c3a5eHxFWYOKxPIEGmRBgYgYGHgy03MKzXSMdIz1TbU
 MzTSMdYxYuDiFICpfhvK8N9NU5T9zdJA/U0CAuc6PuwMPCvy3y0kJCg083aWzbRMpg+MDM2xKRm
 v2RbL/j/53Xr5u69rZfcnZjxZvzw9q34df2rwBm4A
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5

of_regulator_bulk_get_all() allocates the consumers array and hands it to
the caller, who is expected to free it at an appropriate time.
PCI pwrctrl never did, leading to a memory leak.

Add an explicit kfree() for the consumers array.

Cc: stable@vger.kernel.org
Fixes: 75996c92f4de ("PCI/pwrctrl: Add pwrctrl driver for PCI slots")
Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 drivers/pci/pwrctrl/generic.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/pwrctrl/generic.c b/drivers/pci/pwrctrl/generic.c
index d56171e0ee24..4b6cbbb52248 100644
--- a/drivers/pci/pwrctrl/generic.c
+++ b/drivers/pci/pwrctrl/generic.c
@@ -63,6 +63,7 @@ static void devm_slot_pwrctrl_release(void *data)
 	struct slot_pwrctrl *slot = data;
 
 	regulator_bulk_free(slot->num_supplies, slot->supplies);
+	kfree(slot->supplies);
 }
 
 static int slot_pwrctrl_probe(struct platform_device *pdev)

-- 
2.55.0

