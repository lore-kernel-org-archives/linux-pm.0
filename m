Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FBD355F41
	for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2026 04:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785125800; cv=none; b=uv7K0NbMKhrMaMin0JauAngd8q0npdAsBe3tpRyMqBbk18Z/eotnhkOarljl1boN9Lo9JexFdJL/ent+nNd85UkDrU+FAUzBc0gwlOZAMUz6IT+kRd2GvTN+mTss72eQCTQ2UUREqeW1CexowccjOtZZPBvwJDF19HEfdEBANpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785125800; c=relaxed/simple;
	bh=vTgw57gEbNXXoQ27XK+/fcfhflhaBxNt+xdoBYs9C+4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=YyD4ufWBLBHiXflUwcc93cSEm/AfqyLgbhJQ0Q1DvLt8n9+E0BbjEXrPFfhFlLgLU6gWwQK3TlhvJB6d1kPhYG5wyGPTqjPeD4N/DihSsVh4DHonLJhX3jrM1k19VqJbFpotlOdCk5Tsvn1mqQm2e5arTgOrAX9pD0sp3FNVK1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Tv5Lplah; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XLEg+RYm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Tv5Lplah";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XLEg+RYm"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66R3I7c23605924
	for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2026 04:16:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=n+K+VWO30soBLFytNSDhh5
	hPOyqHp+P+UX4v7jKzrRQ=; b=Tv5LplahINfu5ETnkZ7T6sqridr1LDyXuSM4HN
	pgIMFlcVhnVA70xf3bqnI7woHNHkH/8oQUhT0SFSNojr4SsinMSGpWlk9cyBw/Vj
	RHnE4oQQQlmgQBdzHvOdSjna9kGRNQk3Yjm79Fg7f6AXqUoMtoipgTdaKLq0LApN
	fVNbPWTFY0mREanKv+Zdbvga7RSJV11Bm4CePDJx3MQxZqehvDqSRin4l9mzsMRU
	t+i7um1G8+DrSl/v658GYjWKDojkj+eoik3oYfkpbS9NTGg1aed4l+0Kf4o79jak
	QGgOakywNiOraRwAISvQRj1OaoMwQWAeGLSCElgtq+OY1Jrg==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fny9wg4fc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2026 04:16:37 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cb5ea36f969so2614849a12.2
        for <linux-pm@vger.kernel.org>; Sun, 26 Jul 2026 21:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785125797; x=1785730597; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=n+K+VWO30soBLFytNSDhh5hPOyqHp+P+UX4v7jKzrRQ=;
        b=XLEg+RYmkrC3dXdyesPwa1/xt21NN1opUvJ4V/nbsFT/GJPj3Bk7kTohNzGWE8h9RT
         fN1mJz864PO3RdFX/VdkLTRMDt9lg5y5WWvb24QAQkkcSUJRwnO0+EuMHqHOoHXUEG8o
         orna0IdyHAPZ0LuDc072aooM7kXwj4BA5TVm20TQQxvVIHSjofQcw1ZRW3Bf+hVOAkP7
         68oXhYpk3QSBr8gt/xh9sYwsLzTeY73N+jsaW1TczVb/oaeGaY48V/brCSFlBm/Iq3/D
         IEnpHt744j6DM/n08Y1MG9ExXRBk6F2MXJRfxyZe54ZoSm8LeHlyQCCUghJ8RPH8P3c4
         etWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785125797; x=1785730597;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=n+K+VWO30soBLFytNSDhh5hPOyqHp+P+UX4v7jKzrRQ=;
        b=tGOZdZQLYdUelGF/52uYzjpMt+TlJpbK6tj4Z8dDOzC2kF08BqmeYeDBAj3ysaRNEf
         6ljh6CV2a2KsPEwBI1OkhgkO92eBNfc0J6wPpqn1NQItwjInIhKv/w4gc0XiwLyy+9HI
         TojIMgkdUvSbKf/8Z03n9EDTj89lE33N0NGPXowKnIJd35fAUpVKSJplm3r39kf6ZPmp
         fFONSEbK67AOQ0fQODF+5x1Um6ntfNdGZMJK6MLZnnBKY+I3UB0P6DSm4Avf5oDNN7cJ
         lw5H0fhgts1Z9dsZLOAgB7zFQ1IEDpJKci6n6Sbv1DiwMpQT/NmH1UD4xUICbU1v/iT7
         sSDw==
X-Forwarded-Encrypted: i=1; AHgh+RrQ9ufIvYylgWUmAXDhh7rOLXPK7C4ACDH+f6oS2K1bA1adMKpsWqmE8ey9+wLiX00l9Gi/Vtzvzg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi3I9nkP+7L704adwFU0heMqKs2LvQrh9gq5k6uSBbHNVU2spr
	DWVDXAlkfsVI9da1rJ1uSTy9ZCzD0nMcgzGPcp9x7HwmLoWblkWrE/TOp7c263Kktj8bQzhMNV9
	1eqK4jVPBwBrOhvqLOSW7phE+9kRkwqzfMbU6aqZgEv1fDpXsDd944OF1/DsnWw==
X-Gm-Gg: AR+sD10KlpAdZH1KFh3+jDyRR79VkJOP+IOmvh4TjEYdwUg2WPvwAuBqkjTrT49gfnb
	UKKj5LK276S4pXniUQOw1K0ytjKX/Wym0KFH9ZxS0iJqocZX2zkfxTGvm/ZfJ64aLaYKBoSevkN
	b/+GpFAgIJz9Vx1a+fRTtKlZj4qJ1wckUqn6oahTZpmQ1UZ0HQRmkIgrq4/gVI/+rbPK9N7xr0j
	Aj8+ENKzUzlXSOcbBxwCZhf8u4gjA1kXuuNWuwDc5c4HtMwPLI6vNeiDxDsvqMTRp/SYwk6mqsh
	2UwP/bmINa5lrP8OL1+5O4RluSrCvsKSnSNC3INo+mk41w8wM7fulD9vH2KfoQCI0KytaYwlFYC
	UJVgQXRULn1GA0K2VOzzl8hQTD2Ft0y9DAw==
X-Received: by 2002:a05:6a21:7118:b0:3c3:7ac4:dac7 with SMTP id adf61e73a8af0-3c67e071be1mr6656052637.45.1785125796809;
        Sun, 26 Jul 2026 21:16:36 -0700 (PDT)
X-Received: by 2002:a05:6a21:7118:b0:3c3:7ac4:dac7 with SMTP id adf61e73a8af0-3c67e071be1mr6656019637.45.1785125796296;
        Sun, 26 Jul 2026 21:16:36 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc579819sm22629953eec.20.2026.07.26.21.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 21:16:36 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Date: Mon, 27 Jul 2026 09:46:29 +0530
Subject: [PATCH v3] opp: Use clk_get_optional() to avoid leaving
 opp_table->clk as an error pointer
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-fix_ptr_check_on_clk-v3-1-94629ac7aaae@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAJzbZmoC/4WNzQ7CIBAGX8VwloaCQPXkexhDKt1a7A8V2kbT9
 N2FevGg8bLJJN/OzMiDM+DRYTMjB5PxxnYB2HaDdJV3V8CmCIwooYJIynBpHqofnNIV6FrZTum
 mxoIwQbhmwDhB4bV3EHar9nR+sx8vN9BDdMVFZfxg3XPtTmnc/UlMKU4xF1kuocik3Imj9T65j
 3mjbdsm4aBYmuini/9w0eCSJRX7UhaMleyLa1mWF6vw/owdAQAA
X-Change-ID: 20260723-fix_ptr_check_on_clk-603605c3e350
To: bjorn.andersson@oss.qualcomm.com,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
        konrad.dybcio@oss.qualcomm.com
Cc: mukesh.savaliya@oss.qualcomm.com, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, chandana.chiluveru@oss.qualcomm.com,
        Sebastian Reichel <sre@kernel.org>,
        Praveen Talari <praveen.talari@oss.qualcomm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        linux-pm@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785125791; l=5881;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=vTgw57gEbNXXoQ27XK+/fcfhflhaBxNt+xdoBYs9C+4=;
 b=tGak9tO2d49qj6j9uvooUPnrD7icrqQ5WXhlHhP0scZY/RFTAz/V9NL9fVdTornirEwByI62S
 bZAgBOkky4NBAVX7kYu4PRm8eO+LNRnuE0AqPKZ7c9wddP8sb3OGw4T
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDAzOSBTYWx0ZWRfX4IPDNCL4OQvC
 nUO+5GAJEuWD4Xgx6lgza+5OH0B5agiA1VDPlqKJmBKMCrP3odFDgNBYLGQsUBP/B8P8hMY95gt
 hnx/LGUEXcN0/oEEVFZr2773Yqne/zUHt/cl/1H9uPr4qu6Wv2qnjeEMoo7+j2K+UjGjWLkMRvI
 uPhX+TDJzx8g+uPirHcNlJC+QzOV9rgE+wa1Hr0l656JVKr5M7g9VOIjKmUBaZNs0wmIed1TRwj
 3fj681ezPUBoGXUlRBq7bX3ulaK/hhYe3vcb6oIKD7BtLiXMdLuDTKFIe8lm2mfhztnljxT0F0A
 oPZOcGBU5DyK+SS2Y+HbCHMtjhslUqIJ3B4/+Tgwl9gH1r3q24qIPM/SXAALubGVZNvwkXAYcpQ
 YLhz3gJWl5o0xTxD9O3eXLpzTKKd/pkk95ZNTfAHGTa7bsgQ/Weq2oEKsdx5V5Z6uv4I+Obxzau
 kBGmB8PkIp+0W49Mo9g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDAzOSBTYWx0ZWRfX8OpSgP6ClY3x
 0lwo9isQQ4cPDHM17qF7EH8kOVwyRKaAoEmJYvO34C2WUKfDejsU7lOI+1NR5tjveFzUEQK4Bwz
 0O+ZKKbM2AvhToz4cK4vAez+ZrQY3mQ=
X-Proofpoint-ORIG-GUID: GulTEuBuselKWCYZl-MwDSYi7--LeRTs
X-Authority-Analysis: v=2.4 cv=E4b9Y6dl c=1 sm=1 tr=0 ts=6a66dba5 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8
 a=E6oeNcGg-Zm19Bj38ucA:9 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-GUID: GulTEuBuselKWCYZl-MwDSYi7--LeRTs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_01,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 priorityscore=1501 impostorscore=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270039

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
Changes in v3:
- Added OPP framework maintainers
- Link to v2: https://patch.msgid.link/20260725-fix_ptr_check_on_clk-v2-1-7f269f7d33f3@oss.qualcomm.com

Changes in v2:
- Switched from guarding clk_round_rate() against error pointers to
  fixing the root cause in OPP core: use clk_get_optional() instead
  of clk_get() in _update_opp_table_clk(), so opp_table->clk is left
  as NULL (not ERR_PTR(-ENOENT)) when a device has no Linux clock,
  per Sebastian Reichel's review suggestion.
- Dropped the drivers/clk/clk.c change entirely.
- Link to v1: https://patch.msgid.link/20260723-fix_ptr_check_on_clk-v1-1-568a7ed87746@oss.qualcomm.com

To: konrad.dybcio@oss.qualcomm.com
To: Viresh Kumar <vireshk@kernel.org>
To: Nishanth Menon <nm@ti.com>
To: Stephen Boyd <sboyd@kernel.org>
Cc: chandana.chiluveru@oss.qualcomm.com
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/opp/core.c | 51 ++++++++++++++++++++++++---------------------------
 1 file changed, 24 insertions(+), 27 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index b6966e509f7d..80da241d40f5 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1591,39 +1591,36 @@ static struct opp_table *_update_opp_table_clk(struct device *dev,
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
 
 	ret = PTR_ERR_OR_ZERO(opp_table->clk);
-	if (!ret) {
-		opp_table->config_clks = _opp_config_clk_single;
-		opp_table->clk_count = 1;
-		return opp_table;
+	if (ret) {
+		dev_pm_opp_put_opp_table(opp_table);
+		dev_err_probe(dev, ret, "Couldn't find clock\n");
+		return ERR_PTR(ret);
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
base-commit: b4515cf4156356e8f4fe6e0fdc17f59adab9772f
change-id: 20260723-fix_ptr_check_on_clk-603605c3e350

Best regards,
--  
Praveen Talari <praveen.talari@oss.qualcomm.com>

