Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4983E0C71;
	Mon,  2 Mar 2026 16:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772468969; cv=none; b=ClKA7Bg95dyee/0QH9bd1WWFZ+DNBSbC9X1TxBIX7E+fqnIqAmwwkB8TIzWiDN0zIDuwVa/rb3BquioJqUUZH0ECmYKHpTdvLlssLMVhOHleqym9boTJriUzHG1hUcDuB49bB/Lo1JW1QJfJ8q+9cdD1MlzSKoaeRALGv35AjUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772468969; c=relaxed/simple;
	bh=NnNVhciZ+OeoyJYyEx22r9S20DC6u7nMNN6WCTZJ8xk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fsSxnBOmdCN0KLRwkC1hF/ixpPlIvRDRgpBm8vMrVj2nMs/yG6oGalb0zGDD599dH3Y++9/k9YN1mfumH5j2Fc5z3IohK1md0XoeasXWNYN43nBj5gccbuD5Gn6y50n0DCnB22WOyrX8IZtwqK/jl2HcFQMStvPz+cUAGBv9m6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4BF7C2BC86;
	Mon,  2 Mar 2026 16:29:25 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Ilia Lin <ilia.lin@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	devicetree@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 3/7] cpufreq: airoha: Convert to of_machine_get_match()
Date: Mon,  2 Mar 2026 17:29:07 +0100
Message-ID: <cc76137755d93af982bf255095adafc7d523692c.1772468323.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1772468323.git.geert+renesas@glider.be>
References: <cover.1772468323.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the of_machine_get_match() helper instead of open-coding the same
operation.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Compile-tested only.
---
 drivers/cpufreq/airoha-cpufreq.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/cpufreq/airoha-cpufreq.c b/drivers/cpufreq/airoha-cpufreq.c
index b6b1cdc4d11d6962..3e7770860d13c8f4 100644
--- a/drivers/cpufreq/airoha-cpufreq.c
+++ b/drivers/cpufreq/airoha-cpufreq.c
@@ -115,15 +115,10 @@ MODULE_DEVICE_TABLE(of, airoha_cpufreq_match_list);
 
 static int __init airoha_cpufreq_init(void)
 {
-	struct device_node *np = of_find_node_by_path("/");
 	const struct of_device_id *match;
 	int ret;
 
-	if (!np)
-		return -ENODEV;
-
-	match = of_match_node(airoha_cpufreq_match_list, np);
-	of_node_put(np);
+	match = of_machine_get_match(airoha_cpufreq_match_list);
 	if (!match)
 		return -ENODEV;
 
-- 
2.43.0

