Received: from mail-oo2-f38.google.com (mail-oo2-f38.google.com [74.125.231.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC533B27C5
	for <linux-pm@vger.kernel.org>; Thu,  1 Oct 2026 16:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790872094; cv=none; b=Iomlu0wcgeeKGMlbULslq8agifEv1zIH4C2/+NstwcBJ3ErDfVQb1mDCbrdYrnGp0s39RccsM7Uv7HUgMbVGg2u2f5Mw3g9mCPvsS83PgeGM+a6Nbof3x2h6y9aioRdcwkVWfaGtPHZUQhKGlGzqsUQQq2J+Qo2mjUpDy4+s7ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790872094; c=relaxed/simple;
	bh=tG1TLUxM50Fc6ERYAstbHPygf9Ktpow2w1vRm5VRnjc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gP7+YZYRGJoARt7pmiwoJgmh7PSuGEMojFD0JUM12TVUw8vNsc52Bua7JhZOi96r0HRkC/aeXoIS49Tc9c1/eoO1mrvLoXWMu4PaDmV+6og0ZGhE6pe87y7pR1PqHneeKJedBfNdl9coDCJLDVUWiuMpivKnoM4dzmH5qDgKNPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IVLc/A8l; arc=none smtp.client-ip=74.125.231.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IVLc/A8l"
Received: by mail-oo2-f38.google.com with SMTP id 46e09a7af769-81f707db14cso3013991a34.2
        for <linux-pm@vger.kernel.org>; Thu, 01 Oct 2026 09:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790872091; x=1791476891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Z1upg+k8spX2bUmtfIe5RHFhSTkILh8SV8rlR73FFnE=;
        b=IVLc/A8lK3ySaC6uPovNxZij1bNWLENAae5KATWvvDiv3cranpqOY7HiiuI/0Y232s
         weeKL9F5Jr61dqVsShwMOPtbn61rzdg9g3CPlAINDi+7coEXlJs04sKqPUcSTJzOrIKQ
         UK6oj1xFLtX0zn9VV7OsgwWiXlo46YoVIvrtL94xQZ6kxZPKtJl9TvY+TYY/nilg3Pti
         qhrjwUb2p2lL2uN/MMymIvwnGvoG+WLh2C8EXrdHRnKAX2Yue6E5Jz5cTVLMh1yuVODJ
         591giDvO5VO6DjACVmrCWaOK7jdEqpflTpJa5lkalRejrutBxHC+KwyqRCJGP1HCYQk5
         TSdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790872091; x=1791476891;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z1upg+k8spX2bUmtfIe5RHFhSTkILh8SV8rlR73FFnE=;
        b=zqfNsfcxdXVqWRF4BQiQuBF7l7G0w8LS46KUurfOFnB9NxBbL5rkelypcm5ksjpZmv
         AIN2P0KwMr1QKRDW0rvZQxPUuhyl7AbO1wx1OVYqJ2nXUPk/FH9fGe8q5RXyfJdIiXXD
         uS0i9bxxprN7izp/QJrecZF/bt1+TeexvMqJVarD7bklP2KXxJIjAsmT8VZ7GHuQ0pi+
         ashGUW1y2LuiQ8w7uI23Yj39GKhH4cCna1/OonSG7Ku+ndSQT+NQNzau50HuDCqUg1Un
         jqhbUunJGX2ZaagffTwehVmCNqvwGY/kym+HYSf9ht8pwCzfocLjdQSO1ZdhuC6UEzSV
         2AuQ==
X-Gm-Message-State: AFuF++nA9AGHhr6cDlaR2/zChdyDC96BqNCUIlcHjs9ixDjNJ3LIbEru
	ADSM2qSGyTilKOBAlJX72Vvt6DC/wsLbdiP8VZDz5LOnXa73MTnQijX1
X-Gm-Gg: AYBFou2kGbWVFwwgX6/VS9EAEoHsFxzopF3cG/++Pl1aXNPwfoqKbdtbRzrKwMsTmtn
	TCGpxTZkSz+XmwK/qagun6efP00H0oKl/hQnsnzdJDYACu9u+lwCoYLPGDNLde6e3RA7FszFs1+
	DjUOmnawkJ8hiNlHDFicFNfh/vRoUQNcFv9tjQENPoYBVShdX1KpfI2gs0r9DsntcvJp267jfxu
	ewxP85G+2jRzJsawSwl09vvpETddOfhXdUJKQKy7XFRr2ijY9ETurS3F3KdH13IjbbBryQLOP/n
	UVrAqHJXfmMNHhDr8nzYDLh5JiPuvWPu0DVyLt7MF+wCQeAalbOWmrp4K0f6IN9TNbLabCtd/hn
	TAekR9isuW6WStuum4kwRvvo2fpKx00J8UsyGVBKkGS/wUXpwjQj6AU/QiXBJTGWFtjmTfC1qUL
	xPwzaz5fcKwAUh3QBfHH5bKqoHwYWk3lryDhldaVjj2WGe8AdIx+8IAsHsOYhjGD8TgUjW8GeEM
	q1QRMFkTdIePWByaeS6lakyu21f35kgpXnrtcphJ2oYbqKBxa0FnT6v8ZogXYs8lFezHD6C1g==
X-Received: by 2002:a05:6830:270e:b0:80c:6371:21fb with SMTP id 46e09a7af769-82282a72582mr154136a34.16.1790872091352;
        Thu, 01 Oct 2026 09:28:11 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:301c:f8cd:a4cd:e25d:fdef:4a3b])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8227a66c6dfsm219239a34.23.2026.10.01.09.28.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 01 Oct 2026 09:28:10 -0700 (PDT)
From: Aryan Sinha <sinha.aryan03@gmail.com>
To: Nishanth Menon <nm@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	Ulf Hansson <ulfh@kernel.org>
Cc: linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Aryan Sinha <sinha.aryan03@gmail.com>
Subject: [PATCH] pmdomain: ti: fix device node leak in probe
Date: Thu,  1 Oct 2026 21:57:40 +0530
Message-ID: <20261001162755.50666-1-sinha.aryan03@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

for_each_node_with_property() takes a reference on np each iteration
and drops it on the next one. The two allocation failure paths return
from inside the loop, so np is leaked.

Put np before returning fixes it.

Fixes: efa5c01cd7ee ("soc: ti: ti_sci_pm_domains: switch to use multiple genpds instead of one")
Signed-off-by: Aryan Sinha <sinha.aryan03@gmail.com>
---
 drivers/pmdomain/ti/ti_sci_pm_domains.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/pmdomain/ti/ti_sci_pm_domains.c b/drivers/pmdomain/ti/ti_sci_pm_domains.c
index 949e4115f..9cb6133fd 100644
--- a/drivers/pmdomain/ti/ti_sci_pm_domains.c
+++ b/drivers/pmdomain/ti/ti_sci_pm_domains.c
@@ -262,14 +262,18 @@ static int ti_sci_pm_domain_probe(struct platform_device *pdev)
 				}
 
 				pd = devm_kzalloc(dev, sizeof(*pd), GFP_KERNEL);
-				if (!pd)
+				if (!pd) {
+					of_node_put(np);
 					return -ENOMEM;
+				}
 
 				pd->pd.name = devm_kasprintf(dev, GFP_KERNEL,
 							     "pd:%d",
 							     args.args[0]);
-				if (!pd->pd.name)
+				if (!pd->pd.name) {
+					of_node_put(np);
 					return -ENOMEM;
+				}
 
 				pd->pd.power_off = ti_sci_pd_power_off;
 				pd->pd.power_on = ti_sci_pd_power_on;
-- 
2.46.0

