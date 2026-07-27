Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB76A42BEB9
	for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2026 17:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785171808; cv=none; b=JKcJxy1h329EZCvH85EDBRawghIIDKw2dkWWI9M8NYLXrpajgwCHPT+XOUfNUlTM4VZKp8TnERewETAJRF23q+1G1yboMmgSBzLhT9Ipc8HeFvbzhnZYxt/NNo18N9h5Fp4wc4VQ0E7RNhd4sXZmT1tofXCmNn0Btj96stkA9mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785171808; c=relaxed/simple;
	bh=ahzgpGf1HnXdKsfjjYwTPKqO2eq9+LO5jD9pybpSgs8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=UPGjYgKSxy4nWiBHECYgJ3TvCFo2MVTQ+hHekzrvaOKDz3+pwtzn26QWfobTrsIOMSUGNNVSmoANr9kiDDR64FWC8DQBSxdo5IB5UxHElT8OBkQ0twRoRdSnmOJ/gva5P4CoKpvtpbGKlyU/espjssXkBqwRDT/cJ46k2s+I8rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LQVPG8qQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KOui70ZA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LQVPG8qQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KOui70ZA"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RDlmU04035389
	for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2026 17:03:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Or7okZhn12ZGuQOnFpzAys
	ifWDhcwnP59p0o6uqYVCw=; b=LQVPG8qQpSTnoTF7Eryamalz4wqRXkXoiWpNVS
	j5eATuldH13g3AXIzQMaS4Jihf873d9E9jJpy8GU8tT400tQjWJv4Hr39+hSKptU
	/zTccr+20L/6Mh064IHJKKQNJHWWmshD1XwOetwn4YAtIZCsRzUTpJVrCumy4ULp
	PQKpEkL4i7nuPK0WJX5r8OBfOE2agNu4k4brBriT52TBvdSJgtxjozR5Ot6hkqmu
	dMdZniG2wLBn/VH9fs5NDhTXT/hBqyPHhQZF2M7ncOXPnA+02pczKber4JZwGv5p
	/i/7644vM7lD8nGwogt0z5K8qyONCUfu+niH/O1OWrUkkHfQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fp30g2f9t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2026 17:03:25 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38edd45cbc4so3502481a91.3
        for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2026 10:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785171805; x=1785776605; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Or7okZhn12ZGuQOnFpzAysifWDhcwnP59p0o6uqYVCw=;
        b=KOui70ZAsKhKqic0o0VfAUUMl38N7QyHscRXzHhlrNxN+mhCY9na2AvQUTW/iVQtEB
         QWMjZFOX6r+j93qS6mok/YfPXyDD53snSt5clS21tHz5r5ECg3PmZcwMg4yEvH2njzuH
         mrOzYEMI0Xox009ehyordPAQpzlQ0Ihval069tohmnCVlC/yoQVFOAexmAMgV3LU0JfQ
         CI2dRRUUbTivNCm1n0pKhoFfa+nwiDQ+TAIbzmVzMTiPB3d3lsiKQoAIFyj+UxzkYDyc
         6Zhv60Pz09OeEpfmILOyHab2Os3UXepRojxdBXxZQAqfHNBGMOgcOQXM6Hgkkx9Vrb7A
         SiYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785171805; x=1785776605;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Or7okZhn12ZGuQOnFpzAysifWDhcwnP59p0o6uqYVCw=;
        b=Ajt4UM3I363eQ3qbFdfn2icHk/JwRi83oZitk9K+/64Z4oNbvuY+Z893+BiWHhvfGv
         qWxps8PkNg6vM2sDm9Qc/LXEW9ulTN+R1l/UiYF+WP7nUjbgfeFkbhkEH92h4vsQH0FZ
         yByMwPxX8/MKDwk3fF+/yDri+W6PGZAtC8rp3/4PTcr0HQn/GpaV5DWABFJK7d17pbx0
         WnkcTl3aKs0fMMNGFdeZsiAzUSnQNNsBFdEdI/UfCGvtpeWm9+qPZnKGR5aHGI1v9hxz
         VyCgrRrDiIk2R3Iw1j8vBDlN5/hnjSsus3Pn5nbZCF7hOk2iC1PTTwx1/6x4vF4jIfFc
         23Fw==
X-Forwarded-Encrypted: i=1; AHgh+RqUXhawmMa6aFT0JaOwJ7rJsszmeTFAyNOe/vTHrt+0fYV5BfHNNMo2ikTXLNDzgIK/xBQjHxv2Fw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxeCa3e2HaR88U1rYLeyXV3zE47Ou48DSPXu+s4OLfAgeX9jz99
	Aig2lfbDPbNbj7yZLwiHMxV0tqexGPfpDV0UY0Ela8cswWc8KM82vZxBkouvKObdkwzngeZxr9q
	uYBfWm/p89y0ZCe3Yc6KG25MP0k0fXeQqdlLO6tN3mXCYe7kqXErsk/auGtUsBQ==
X-Gm-Gg: AR+sD126c+cZzkTcn0OobGuwblrrDSM8+w2CAFYRZj3141LXkShNngY1oUUxb+AOjBh
	RdUsDdz0pnOI2kTM79SaSKpq9ALw4/bz9N7/0h67nR0GNGCz6tVmgr63kWoguJM8Jr8p+FV5QRe
	IZkKFg/khW8flcN99wclJnl/zdQl7u6/UMWCYQWbaUzq2/Srm7xQ+Gk3PwEJvJrDDGW+etdkfPe
	CjIjc2y8+j1MXCGf6uiFGxAvbVAiDBvLkviCP890KFdwiQc0CImvVmAldtrlEHSDUALviuoU8jZ
	n4eh4djl5ebLpmi96ghh5G94UbJi+EhO+2vRccowGUYryqSwq9UW9MwzpB5Hy+fro8EvDem2ga8
	xsemDPOsOmPcJkoJrBlgSbyROE1v6mSxp7A==
X-Received: by 2002:a17:90b:528f:b0:36d:7b62:4767 with SMTP id 98e67ed59e1d1-38f6493817bmr132807a91.5.1785171804387;
        Mon, 27 Jul 2026 10:03:24 -0700 (PDT)
X-Received: by 2002:a17:90b:528f:b0:36d:7b62:4767 with SMTP id 98e67ed59e1d1-38f6493817bmr132762a91.5.1785171803682;
        Mon, 27 Jul 2026 10:03:23 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc44cb92sm55706711eec.13.2026.07.27.10.03.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 10:03:22 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Date: Mon, 27 Jul 2026 22:33:12 +0530
Subject: [PATCH v4] opp: Use clk_get_optional() to avoid leaving
 opp_table->clk as an error pointer
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-fix_ptr_check_on_clk-v4-1-97969fa7826a@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAE+PZ2oC/42MWw6CMBBFt0Lm2xJokQa/3IcxzTgOUnkUWyAmh
 L1bdAP+3OQk554VAnvLAU7JCp4XG6wbIhSHBKjB4cHC3iODzGSZaalFbd9mnLyhhqk1bjDUtaJ
 QR53XrErFOcTr6Dl63+zl+uMw355M097ajdq7XkyNZ/wjvyiRi6ooZYWkEZHPLoT0NWNHru/TO
 LBtH/MFa23LAAAA
X-Change-ID: 20260727-fix_ptr_check_on_clk-43571fe363e1
To: konrad.dybcio@oss.qualcomm.com, Viresh Kumar <vireshk@kernel.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>
Cc: chandana.chiluveru@oss.qualcomm.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mukesh.savaliya@oss.qualcomm.com,
        Sebastian Reichel <sre@kernel.org>,
        Praveen Talari <praveen.talari@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785171798; l=6476;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=ahzgpGf1HnXdKsfjjYwTPKqO2eq9+LO5jD9pybpSgs8=;
 b=xdnHRgoFEab025j0qHhaV/LZByXjK9sGsgFXn4/ldPsbJ2xiaALdUhn1HE2vel9O7OzhyZlSl
 LwMQ2UQba0vBPU+/ZgB8PpsExZBgar11GWD5jVkj0/zwBgfw4oZw5Cg
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Authority-Analysis: v=2.4 cv=Wac8rUhX c=1 sm=1 tr=0 ts=6a678f5d cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=bC-a23v3AAAA:8 a=sozttTNsAAAA:8
 a=XDx8TwEyUzAHi6xX3fAA:9 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDE1NyBTYWx0ZWRfX0D2u9c+8sEii
 pZpVKstWTUZk35/5eSCm+1dcSXTG2Its12nf7TO+dmT2CGNWt6Mrs+tQDZomtQTouurfrjVDEU1
 atzstScPzZu9Eu+wbORhcMZOxXHnJ+I=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDE1NyBTYWx0ZWRfX7maDRRXeGcoa
 5YAUNandhQM1BkMEb1/0+aNnE5Coe7IW2jVU8TY6z6V2rSrkwsiPLyazvF+goaKnTgZT/c8QUPP
 MdLteWSyv7UsndzRpaI1CL+ajyD1yEgeTN+Z/7qlhVp+gv+Ha0SWWcFz7nsk7hVs+VTdgsTqE79
 +72nMdrlaRrxT3sF2X6V4yGU9dh6VD9iIyay6a6bgPC59EQdvg+VK7RgUcvzomQBN5cjNxivcom
 wM28pPdJXkhUAKtoIJ6E7lqnSqq0jS9uo9p52Ha6x1YLpUgwMlyvikCfg0TKZCtY51DBo2DZH+Z
 akRx1HR2kPHxBXXeMoJCdSrWTjPx9dJDNpPMBjg4oC+dl8vMXcZB+aQynwmNS+y136c3aSq46S6
 FJQren2qv67kEIkeHYCmt/y4FWdXPKRPrGlwIaGsIUPJcSdHC4mpmk3t+Tdxd3vV01w96UTkLJC
 hgDUAwDvFWM7qhtwpMg==
X-Proofpoint-GUID: OnFXAc8Xvj9cc5fJU8E2QCPANukPVZsr
X-Proofpoint-ORIG-GUID: OnFXAc8Xvj9cc5fJU8E2QCPANukPVZsr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 bulkscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270157

_update_opp_table_clk() uses clk_get(dev, NULL) to acquire the
device's clock. On platforms where the perf domain device has no
Linux clock and is instead managed entirely by firmware via
devm_pm_opp_of_add_table() (through
of_genpd_add_provider_simple()/onecell()), clk_get() returns
-ENOENT. That case is treated as valid (the OPP table can still
have entries sourced from firmware), but opp_table->clk is left
holding ERR_PTR(-ENOENT) rather than being reset to NULL:

	opp_table->clk = clk_get(dev, NULL);
	ret = PTR_ERR_OR_ZERO(opp_table->clk);
	...
	if (ret == -ENOENT) {
		opp_table->clk_count = 1;
		return opp_table;   /* opp_table->clk is still ERR_PTR(-ENOENT) */
	}

Consumers that only check IS_ERR(opp_table->clk) treat this as a
valid clk and pass it straight into the clk consumer API. In
particular, dev_pm_opp_set_rate() calls
clk_round_rate(opp_table->clk, target_freq), and clk_round_rate()
only guards against a NULL clk, so it dereferences the error pointer
to read clk->exclusive_count and crashes:

  Unable to handle kernel NULL pointer dereference at virtual
  address 000000000000002e
  ...
  pc : clk_round_rate+0x3c/0x188
  ...
  Call trace:
   clk_round_rate+0x3c/0x188 (P)
   dev_pm_opp_set_rate+0x114/0x33c

Rather than teaching every clk consumer API to special-case
ERR_PTR(-ENOENT), fix it at the source: use clk_get_optional()
instead of clk_get() in _update_opp_table_clk(), which already
translates -ENOENT into a NULL clk. This documents that the clock is
genuinely optional for such devices, and keeps opp_table->clk holding
either a valid clk or NULL, never a lingering -ENOENT error pointer.
_opp_config_clk_single() is only wired up via opp_table->config_clks
when a clk was actually found, and every other opp_table->clk
consumer already tolerates NULL through the standard clk API (which
treats a NULL clk as a no-op), so no other call site needs to change.

Suggested-by: Sebastian Reichel <sre@kernel.org>
Reviewed-by: Sebastian Reichel <sre@kernel.org>
Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
Changes in v4:
- Rebased on
  https://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git/log/?h=cpufreq/arm/linux-next
- Removed ret variable.
- Link to v3:
  https://lore.kernel.org/all/20260727-fix_ptr_check_on_clk-v3-1-94629ac7aaae@oss.qualcomm.com

Changes in v3:
- Added OPP framework maintainers
- Link to v2:
  https://patch.msgid.link/20260725-fix_ptr_check_on_clk-v2-1-7f269f7d33f3@oss.qualcomm.com

Changes in v2:
- Switched from guarding clk_round_rate() against error pointers to
  fixing the root cause in OPP core: use clk_get_optional() instead
  of clk_get() in _update_opp_table_clk(), so opp_table->clk is left
  as NULL (not ERR_PTR(-ENOENT)) when a device has no Linux clock,
  per Sebastian Reichel's review suggestion.
- Dropped the drivers/clk/clk.c change entirely.
- Link to v1:
  https://patch.msgid.link/20260723-fix_ptr_check_on_clk-v1-1-568a7ed87746@oss.qualcomm.com

To: konrad.dybcio@oss.qualcomm.com
To: Viresh Kumar <vireshk@kernel.org>
To: Nishanth Menon <nm@ti.com>
To: Stephen Boyd <sboyd@kernel.org>
Cc: mukesh.savaliya@oss.qualcomm.com
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/opp/core.c | 54 ++++++++++++++++++++++++------------------------------
 1 file changed, 24 insertions(+), 30 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index ab0b0a2f85a1..f2b2ffdb410d 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1582,8 +1582,6 @@ static struct opp_table *_update_opp_table_clk(struct device *dev,
 					       struct opp_table *opp_table,
 					       bool getclk)
 {
-	int ret;
-
 	/*
 	 * Return early if we don't need to get clk or we have already done it
 	 * earlier.
@@ -1592,39 +1590,35 @@ static struct opp_table *_update_opp_table_clk(struct device *dev,
 	    opp_table->clks)
 		return opp_table;
 
-	/* Find clk for the device */
-	opp_table->clk = clk_get(dev, NULL);
+	/*
+	 * There are few platforms which don't want the OPP core to manage
+	 * device's clock settings. In such cases neither the platform
+	 * provides the clks explicitly to us, nor the DT contains a valid
+	 * clk entry. The OPP nodes in DT may still contain "opp-hz" property
+	 * though, which we need to parse and allow the platform to find an
+	 * OPP based on freq later on.
+	 *
+	 * This is a simple solution to take care of such corner cases, i.e.
+	 * make the clk_count 1, which lets us allocate space for frequency
+	 * in opp->rates and also parse the entries in DT. Use
+	 * clk_get_optional() instead of clk_get() so opp_table->clk stays
+	 * NULL for such devices, instead of holding an ERR_PTR(-ENOENT) that
+	 * consumers must remember to special-case.
+	 */
+	opp_table->clk = clk_get_optional(dev, NULL);
 
-	ret = PTR_ERR_OR_ZERO(opp_table->clk);
-	if (!ret) {
-		opp_table->config_clks = _opp_config_clk_single;
-		opp_table->clk_count = 1;
-		return opp_table;
+	if (IS_ERR(opp_table->clk)) {
+		dev_pm_opp_put_opp_table(opp_table);
+		dev_err_probe(dev, PTR_ERR(opp_table->clk), "Couldn't find clock\n");
+		return ERR_CAST(opp_table->clk);
 	}
 
-	if (ret == -ENOENT) {
-		/*
-		 * There are few platforms which don't want the OPP core to
-		 * manage device's clock settings. In such cases neither the
-		 * platform provides the clks explicitly to us, nor the DT
-		 * contains a valid clk entry. The OPP nodes in DT may still
-		 * contain "opp-hz" property though, which we need to parse and
-		 * allow the platform to find an OPP based on freq later on.
-		 *
-		 * This is a simple solution to take care of such corner cases,
-		 * i.e. make the clk_count 1, which lets us allocate space for
-		 * frequency in opp->rates and also parse the entries in DT.
-		 */
-		opp_table->clk_count = 1;
-
-		dev_dbg(dev, "%s: Couldn't find clock: %d\n", __func__, ret);
-		return opp_table;
-	}
+	if (opp_table->clk)
+		opp_table->config_clks = _opp_config_clk_single;
 
-	dev_pm_opp_put_opp_table(opp_table);
-	dev_err_probe(dev, ret, "Couldn't find clock\n");
+	opp_table->clk_count = 1;
 
-	return ERR_PTR(ret);
+	return opp_table;
 }
 
 /*

---
base-commit: 391b4b1d5476a39058bdd24d9c69430386f79659
change-id: 20260727-fix_ptr_check_on_clk-43571fe363e1

Best regards,
--  
Praveen Talari <praveen.talari@oss.qualcomm.com>

