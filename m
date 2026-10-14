Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9C93C1D57;
	Wed, 14 Oct 2026 12:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791980568; cv=none; b=jPMHOiQqW9tXjqyUyFgO2kstyQ7O6u60lTFmmajjDw1mIIYrrLG+qVFolBlj5w53ioHIS7buYKkhhgE+eiDMgI1msq6lewNy49vAfcJzQ6AioEiKzPC3ToEg6xmPkjyJm+6DJ2RPaDEbuLtJ0vXdw7g7posxWMucVzzo0KPFFwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791980568; c=relaxed/simple;
	bh=C0AuXOYVIX3SJQk8O8t8YMbpPksBw3fAZUMYh3OrKWs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DizrD0DbofvnWp5R2Rs54Q5tZkYXB0olF2Ed+tQhn/DotEu9IebbKMPIR8uGwK85fjeFuyVsW+zhcuaLxttBW8uShg49KbspwAuQW2J8GZdX7gcxkRwyY7XZa77OAdiIGa8oM4SBpGwWS6W2oKCY9NgoFBLAUsW1a0930Q83/Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BohjXmdn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BohjXmdn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63EDF1F000FF;
	Wed, 14 Oct 2026 12:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791980565;
	bh=pHX9ybtNOoZoHyalnI3wqrfXCE0lCt11ARC5PRUUPMA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=BohjXmdn3nXJeTV/HdX18JhNwKK+av8E6u1yZm+H7TAwDnt3zfmiSYaiRZllYUNGJ
	 3qlC46GhbKGxugOkwEMuvkOuxNocjIohfeDYs73oBAVistWFf/0Ibg23jRe0X+PpYS
	 PWy5SRX///i3nBdgVq/us9/bFbWltIBM2ejDLG2uKkra29sxlWS4ddB6N2vvyFpLiN
	 WVY02xDV3Zgs8chYoLstqsfa2UOPE9yEMFBWQ2vczNV1g0mEkPZoltAEaHx0ccCiSO
	 gSEIl5Z91gwTG/aacBXB/gAptIm/yyTIF5j3+5/AMvFU+BBIK0EgiqELHKtQ9qm7/7
	 CKHDHb5//QboQ==
From: Konrad Dybcio <konradybcio@kernel.org>
Date: Wed, 14 Oct 2026 14:19:16 +0200
Subject: [PATCH DNM RFC 16/16] pmdomain: qcom: rpmhpd: Stop forwarding MMCX
 pstate to CX
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-topic-qc_clk_dvfs-v1-16-3041b788e9f7@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791980431; l=2651;
 i=konrad.dybcio@oss.qualcomm.com; s=20230215; h=from:subject:message-id;
 bh=gO5tyqJ9cYj7edhaytQi9N2HvrglJaynkzUYRfriPsw=;
 b=RlXw9QgMZ3KEw0XI0YzqSA78JO99o1s4to3WJ1aJmx1yrsqCPILLTXiw9MNg/ojuAd56XSPa7
 x+I6Y4kUTOoCobQv8tfyIdiX6nhkYCKlOMzCG82daeV34fy4kswE1xb
X-Developer-Key: i=konrad.dybcio@oss.qualcomm.com; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

MMCX needs CX to be on, but it does not need CX's performance state to
follow its own. The GenPD parent link currently forwards that state, so
raising MMCX can also raise CX when no CX consumer needs the higher level.

Keep the parent relationship for power ordering, but suppress its
performance-state propagation. Apply the same policy to MMCX_AO and
CX_AO, leaving other RPMhPD parent relationships unchanged.

Assisted-by: LLM
Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
Because of the current PM topologies depending on this behavior, this
may not be merged without filling out clock DVFS data for all platforms
first. Additionally, the MX coupling is more nuanced before SM8450.
---
 drivers/pmdomain/qcom/rpmhpd.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/pmdomain/qcom/rpmhpd.c b/drivers/pmdomain/qcom/rpmhpd.c
index fa8fed5bd3e5..4d9463b4d5df 100644
--- a/drivers/pmdomain/qcom/rpmhpd.c
+++ b/drivers/pmdomain/qcom/rpmhpd.c
@@ -37,6 +37,7 @@
  * @level_count:	Number of levels supported by the power domain. max
  *			being 16 (0 - 15)
  * @enabled:		true if the power domain is enabled
+ * @parent_flags:	configuration flags for the GenPD parent relationship
  * @res_name:		Resource name used for cmd-db lookup
  * @addr:		Resource address as looped up using resource name from
  *			cmd-db
@@ -54,6 +55,7 @@ struct rpmhpd {
 	u32		level[RPMH_ARC_MAX_LEVELS];
 	size_t		level_count;
 	bool		enabled;
+	unsigned int	parent_flags;
 	const char	*res_name;
 	u32		addr;
 	bool		state_synced;
@@ -154,6 +156,7 @@ static struct rpmhpd mmcx_w_cx_parent = {
 	.pd = { .name = "mmcx", },
 	.peer = &mmcx_ao_w_cx_parent,
 	.parent = &cx.pd,
+	.parent_flags = GENPD_SUBDOMAIN_NO_PERF_STATE_PROPAGATION,
 	.res_name = "mmcx.lvl",
 };
 
@@ -162,6 +165,7 @@ static struct rpmhpd mmcx_ao_w_cx_parent = {
 	.active_only = true,
 	.peer = &mmcx_w_cx_parent,
 	.parent = &cx_ao.pd,
+	.parent_flags = GENPD_SUBDOMAIN_NO_PERF_STATE_PROPAGATION,
 	.res_name = "mmcx.lvl",
 };
 
@@ -1223,9 +1227,13 @@ static int rpmhpd_probe(struct platform_device *pdev)
 	for (i = 0; i < num_pds; i++) {
 		if (!rpmhpds[i])
 			continue;
-		if (rpmhpds[i]->parent)
-			pm_genpd_add_subdomain(rpmhpds[i]->parent,
-					       &rpmhpds[i]->pd);
+		if (rpmhpds[i]->parent) {
+			ret = pm_genpd_add_subdomain_with_flags(rpmhpds[i]->parent,
+							        &rpmhpds[i]->pd,
+							        rpmhpds[i]->parent_flags);
+			if (ret)
+				return ret;
+		}
 	}
 
 	return of_genpd_add_provider_onecell(pdev->dev.of_node, data);

-- 
2.56.0

