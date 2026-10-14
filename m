Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50D74E77FB;
	Wed, 14 Oct 2026 12:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791980527; cv=none; b=caYiOW2XdOQR2DhT1GYchvLG0SoFIVWXgCfX5GQ0HIOl1BZzJ6LLVCmKB6KL1MCt8c+i63EcPCAM0xfPM9aL6FvD8RE69PjpZ35M9QTkGeeyl2vQbRMxSQybf47oDH/hWN4sb/21NidNvQXlx0oKk9IHeHGf03zW7xumraqH/L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791980527; c=relaxed/simple;
	bh=l2hxSRrfEfg5xlP53IOWlgbP5JJveQeewzodJ4+F9/k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tDve774q5AwFG3DvCxDAwB/lmpoPhdKx5OBEY9hutCdRbSfaeoU0l9zbkGEK53AYrm2P3M237G6SaIborebBk19Mpp3Bt71JKFnExIjHsmyicwc7moBCvCyUkoZPDbCbFoHhQMrF+2z4cNoQpcFHJRsZfYskj9M804x1+NQ90MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oyVE6Wvm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oyVE6Wvm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 427991F00893;
	Wed, 14 Oct 2026 12:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791980525;
	bh=isiJdEN+WBpPcWisqUi9VgLZtOwmnLbq50wufHG3o6w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=oyVE6WvmD+bxg0i9Y/Mrt8JSMexoHuz0ahdeklYQAiS6HVYFO3gTFntfzeqUgF3RZ
	 eMSslai14tWMJ9eKVXWrNUiIFSrjd3FPFClf+9jiTDZPPppe6DmBkqnJdXNH1eS2gK
	 GxvKLXR+0riqxTsYA30uVvDJpoTJZ1dpRca+KYmWs8ZuzcMLYVDf3RCVvIofMAp/Q5
	 neRmdceORWWlD635jPW2J5yRV4yZ1j2ECb6AIeZB/U6akC3UnlBj1r/oOCWGagRWBf
	 inm74qFM8tIOrqLAv5tz6esSvMLH4/XDwHTae8c23nvRCLbRdRn8/sIKa/3TlVVSx3
	 G9pYhgXm2hXCg==
From: Konrad Dybcio <konradybcio@kernel.org>
Date: Wed, 14 Oct 2026 14:19:11 +0200
Subject: [PATCH RFC 11/16] clk: qcom: gdsc: Make GDSC parenting optional
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-topic-qc_clk_dvfs-v1-11-3041b788e9f7@oss.qualcomm.com>
References: <20261014-topic-qc_clk_dvfs-v1-0-3041b788e9f7@oss.qualcomm.com>
In-Reply-To: <20261014-topic-qc_clk_dvfs-v1-0-3041b788e9f7@oss.qualcomm.com>
To: Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, Viresh Kumar <vireshk@kernel.org>, 
 Nishanth Menon <nm@ti.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Danilo Krummrich <dakr@kernel.org>, Johan Hovold <johan@kernel.org>, 
 Ulf Hansson <ulfh@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Abel Vesa <abelvesa@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Mike Tipton <mike.tipton@oss.qualcomm.com>, 
 Taniya Das <taniya.das@oss.qualcomm.com>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, driver-core@lists.linux.dev, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791980431; l=2279;
 i=konrad.dybcio@oss.qualcomm.com; s=20230215; h=from:subject:message-id;
 bh=TpP5WSw3/W6jAYPY71bptONXKHnLGxyUkXqeb6C74ns=;
 b=4oc3NnVW6D3L/SZLYKVvcMmXbasGmhmCrs66kWHkh45rDnC3F+8fHCTm8G7bKHvvzRe0rdBx0
 L+p+ntWXAsQBXqL45kPK0HOslYqadmOU51cIj38bWkNsTqJu8A7WYXa
X-Developer-Key: i=konrad.dybcio@oss.qualcomm.com; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Clock controller power-domain attachments currently become parents of all
top-level GDSCs exported by that controller. This conflates resources
needed to access or operate the controller with actual power-collapse
hierarchy.

Allow callers of gdsc_register() to suppress parents inferred from the
controller device and its attached domain list.

Assisted-by: LLM
Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 drivers/clk/qcom/gdsc.c | 13 +++++++++----
 drivers/clk/qcom/gdsc.h |  1 +
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
index b99d70149af3..2d0803e1eb3b 100644
--- a/drivers/clk/qcom/gdsc.c
+++ b/drivers/clk/qcom/gdsc.c
@@ -587,9 +587,10 @@ static void gdsc_pm_subdomain_remove(struct gdsc_desc *desc, size_t num)
 			continue;
 		if (scs[i]->parent)
 			pm_genpd_remove_subdomain(scs[i]->parent, &scs[i]->pd);
-		else if (!IS_ERR_OR_NULL(dev->pm_domain))
+		else if (!desc->no_external_parent &&
+			 !IS_ERR_OR_NULL(dev->pm_domain))
 			pm_genpd_remove_subdomain(pd_to_genpd(dev->pm_domain), &scs[i]->pd);
-		else if (desc->pd_list)
+		else if (!desc->no_external_parent && desc->pd_list)
 			gdsc_remove_subdomain_list(desc->pd_list, &scs[i]->pd);
 	}
 }
@@ -654,13 +655,17 @@ int gdsc_register(struct gdsc_desc *desc,
 
 	/* Add subdomains */
 	for (i = 0; i < num; i++) {
+		ret = 0;
+
 		if (!scs[i])
 			continue;
+
 		if (scs[i]->parent)
 			ret = pm_genpd_add_subdomain(scs[i]->parent, &scs[i]->pd);
-		else if (!IS_ERR_OR_NULL(dev->pm_domain))
+		else if (!desc->no_external_parent &&
+			 !IS_ERR_OR_NULL(dev->pm_domain))
 			ret = pm_genpd_add_subdomain(pd_to_genpd(dev->pm_domain), &scs[i]->pd);
-		else if (desc->pd_list)
+		else if (!desc->no_external_parent && desc->pd_list)
 			ret = gdsc_add_subdomain_list(desc->pd_list, &scs[i]->pd);
 
 		if (ret)
diff --git a/drivers/clk/qcom/gdsc.h b/drivers/clk/qcom/gdsc.h
index 2f9665b664e6..8275e266cfcc 100644
--- a/drivers/clk/qcom/gdsc.h
+++ b/drivers/clk/qcom/gdsc.h
@@ -86,6 +86,7 @@ struct gdsc_desc {
 	struct gdsc **scs;
 	size_t num;
 	struct dev_pm_domain_list *pd_list;
+	bool no_external_parent;
 };
 
 #ifdef CONFIG_QCOM_GDSC

-- 
2.56.0

