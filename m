Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3D34E9C30;
	Thu, 17 Sep 2026 21:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789679593; cv=none; b=shSbLsWNLyOaHPG4jHwIC52AxGEQ+h7cn4Ls541Q51zFMF78c9fw3O6/AhCxvrcrR2YbSJCw3ALQUBjKrI2c5/Ry2aEn5jVdTrtL7r998eOTLLnbR7CiAsl9R00eJg+m0YLCA5a02vXnbvFYQvRRKWho5O4l8CJwhpOAjmshzzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789679593; c=relaxed/simple;
	bh=R+SizyncqRzs4RCcj/HNfRyJr28NYCp0+mg4stLKRMY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=W5GZn72RLfJvwCsNq9XtGoS6DUD+KxNcQffZJvrNnu4HxpKsswWAF3IeYvCfph+0iyLiR6HLTq6rCGP+1r+r2I1JFLFSSl+DgTeqMGOGkufnwhX32pEnrm7Jkq64Lkr3ukaJ2i29e/xDANCJseZke0b+ez8uwA6oQY1WTaQKAy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oDpGxW/c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oDpGxW/c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F14F1F000FF;
	Thu, 17 Sep 2026 21:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789679591;
	bh=AEQ3+Fko84e980IO5IKlOLRqL9IvEcOHZBjrRhYU9e8=;
	h=From:To:Cc:Subject:Date;
	b=oDpGxW/c7eiIyB1gCw/gJkhXZsae+EJBC+aPVPCnkkfBFIqDQ1LMqEGaD66URLyn1
	 FQ2PehoDsWKxdLtGqWINUK7OmgT0lEgCZmH/QR2tZgNb9tzEmnSULZP0OotR5n42Ci
	 EvGcsJEdOwI1zcQazwj6u3wjMF5Uvo08f7UQwTR3NJeKm213syBQOcYnneUcRNSoE9
	 MAy5KLiOD8s3Apna1G61fGXbQkyuibhCPGMOhc/zmsxqgdLLMn0idhGR3/meyIhV4b
	 jnwr6tZnZgghRGcEsdP74rSkZUlqx5bAFEY1icbiNMPuEI6cCNKM18K6Wu7oI0Pc1W
	 PCrIiqqyHYl/A==
From: Kees Cook <kees@kernel.org>
To: Casey Connolly <casey.connolly@linaro.org>
Cc: Kees Cook <kees@kernel.org>,
	Kees Cook <kees+treewide@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] power: supply: qcom_smbx: Remove const from desc allocation type
Date: Thu, 17 Sep 2026 14:13:10 -0700
Message-Id: <20260917211309.i.765-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1703; i=kees@kernel.org; h=from:subject:message-id; bh=r/Yq118DXNdt++OJ+k9hUFeJCcuXwgA66344qidRmsA=; b=owGbwMvMwCVmps19z/KJym7G02pJDFlrwp8dXXXd2qPs4xx3vRmW/uGpfPwpokVRW3+z/VzCM NHqka91RwkLgxgXg6yYIkuQnXuci8fb9nD3uYowc1iZQIYwcHEKwESShBh+HLFlMJWuXbNUSYZ5 b/tvzuCpk9ids16XXYoo+1In03qJ4X/4/Xs+yfH/Fp6QnJoTn7l6i7PV3cA5V11Xrllv0s/rJsA BAA==
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

From: Kees Cook <kees+treewide@kernel.org>

In preparation for making the devm_kmalloc family of allocators type
aware, we need to make sure that the returned type from the allocation
matches the type of the variable being assigned. (Before, the allocator
would always return "void *", which can be implicitly cast to any
pointer type.)

The assigned type is "struct power_supply_desc *", but the converted
allocation type would be "const struct power_supply_desc *", as the size
was taken from "smb_psy_desc", which is a
"static const struct power_supply_desc". As there is no general way to
remove const qualifiers, take the size from the assignment target
instead. No change in allocation size results.

Build tested ARCH=x86_64 allmodconfig with GCC 16.2.0:
drivers/power/supply/qcom_smbx.o

Assisted-by: LLM coccinelle
Signed-off-by: Kees Cook <kees+treewide@kernel.org>
---
Cc: Casey Connolly <casey.connolly@linaro.org>
Cc: Sebastian Reichel <sre@kernel.org>
Cc: <linux-arm-msm@vger.kernel.org>
Cc: <linux-pm@vger.kernel.org>
---
 drivers/power/supply/qcom_smbx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/qcom_smbx.c b/drivers/power/supply/qcom_smbx.c
index 67fdb4335338..71c5448aecff 100644
--- a/drivers/power/supply/qcom_smbx.c
+++ b/drivers/power/supply/qcom_smbx.c
@@ -972,7 +972,7 @@ static int smb_probe(struct platform_device *pdev)
 	supply_config.drv_data = chip;
 	supply_config.fwnode = dev_fwnode(&pdev->dev);
 
-	desc = devm_kzalloc(chip->dev, sizeof(smb_psy_desc), GFP_KERNEL);
+	desc = devm_kzalloc(chip->dev, sizeof(*desc), GFP_KERNEL);
 	if (!desc)
 		return -ENOMEM;
 	memcpy(desc, &smb_psy_desc, sizeof(smb_psy_desc));
-- 
2.34.1

