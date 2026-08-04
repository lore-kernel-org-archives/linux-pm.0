Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C67D4BC001
	for <linux-pm@vger.kernel.org>; Tue,  4 Aug 2026 19:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785873534; cv=none; b=mRaLib133nj98see8bG1d0vUn3/EGhuFIxvUGcfJNhvEuyVvM/P6yOdazC4L9nCIrtXTsnui7LhIqqUtN96Vzfb9R4x/bqF3L42PgDEATqvB0fJXWaPq1R6beMgo4Femb0SAojKEbNxJT+MbFdINN6xP1EBQxkGetJLoGP1Xjcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785873534; c=relaxed/simple;
	bh=PEW3pWPW2yxbK9ZgACWK44vjXfKNskPlikOmgv7qqng=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VApwBTSHRsCJBuPN7tMH1W+dH6mf/Ul+5UrzZFZClBVn1Gbt3Kw3BqlDwFSqYP6yQZmeTW8MXH9Exw9+ojvyAdUwYxM9th0ADaM55BG0hbElCTzjsxCScESziNP0pAavYKnKeSAjxKuHvxQrL9lAzDfacp1E6lmB0Fkypc1bgaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=k8LaNiFy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DP2QjqCu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="k8LaNiFy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DP2QjqCu"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 674JljQ8701802
	for <linux-pm@vger.kernel.org>; Tue, 4 Aug 2026 19:58:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wdAr2VKcV5cr84m5kR2RCjRBgbEXI4fcK1UWAE6nPm8=; b=k8LaNiFySCNA8zMy
	pXuUMjypcSqFFyzFypasx4p5zkAn/YoIZrTJhwBn86tQtPEYgQP9xMusZNUtPUWh
	7DZoVYfXQw8+N6UufHHSBSgSMfVIUydcICn1UZ4n6xBhCOng+7HuRKARhMUjwdSz
	rmQYABSV8hwYOaJ/Uz6bzIZ76e48AG/JwcBEFvo7V/WodrEE9S9+0M4bjr3oVP2F
	/6uDVU6f/SF9wMfPvtDVv+9elKeuOteFvsPbPskZgucWFGXzbvoXMjV4AAsfgfqk
	5HeuDU7h6X+7fm1HPvaxHiw9ocEH32+bObbalW+b5+AtAIhCiI2R+NQo8fpaspUv
	rlWCOQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fum3n8t6b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 04 Aug 2026 19:58:52 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cb5bdd8450dso97288a12.0
        for <linux-pm@vger.kernel.org>; Tue, 04 Aug 2026 12:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785873531; x=1786478331; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wdAr2VKcV5cr84m5kR2RCjRBgbEXI4fcK1UWAE6nPm8=;
        b=DP2QjqCuqo2ysFOD4gaqcVcAdNshJVSZWZTDORAvu2yv8TvO3t95CZ87XsDYOclnmc
         Bge0CSfd1RYO37uYbduWzXTmjyjNA4tYj7VewHwgFSRHMeSS1xzqfmkjYnn3wvKnNZtz
         zm7A5b32MimnJlZGxTn7H7oIgOXlJWPqe0aPLM7E2WhZruAD37uy3PtVIgXjki4mMqVg
         XF5roj9ELiojbR8SfW8USqSRq+aSl7JdXF0Qya972xpf2kWgh6a5LdnhCENStE1dXC7H
         ahctgW3xi9htog7zj2917DkZzHLjaKRN7081Y32O2gI3E5TFgXb53siFhv/DB2JiYz3p
         udvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785873531; x=1786478331;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wdAr2VKcV5cr84m5kR2RCjRBgbEXI4fcK1UWAE6nPm8=;
        b=I4QsXWMjxJ2zR7SHM0tP2QimnAzYI5Ef51SCAMTUZeqlw+79CvyMLE46kvzmwt9LEB
         JYlcbUvI17goK9R+X4Nwi7m24V5S75mwbBC4ujPHsNmbZzDwv7E/tI4AzXKmedRRpxaW
         9Seu5GVzSthpphzBupEWqPC3FaQ6wFA1ermDkeoj4c5szrCGgUe5m0ZteJ82Kwh/U5BI
         E09/UJlNMBNxkUAmnlU85s9pagXQTTd5jJgJb9F15xfoFXOgarabWI7bl4M1JSFdt/av
         Phf8xrNzQ5EowFwSZddonWDC4+riB4NXJ+W1+aitOlovzRSGiMJGILCkTpoCbwyxVx7Q
         5Amw==
X-Forwarded-Encrypted: i=1; AHgh+RpPBWwQOsOo8DwpBmw+TNn5mX719hXwsA5+vChFgR+qy3xep4qAPdA3DzSNgdAkoGbaV4opGdgnew==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3EJrzkNWoEapmBId/SkYsE5xGbn7jKE8IXVo1afbimVZPqqyi
	vUglTIFpDOaLu5XJerhpuYuKeUUx972zaFxmtKIOqvMG/0/l6ICAXVnIiwTHPg6shxLQU71b6AT
	1CMSM4AA9/lHZdQl1PLzjs7OU3T8rttQUyfXtg5z3DEac/7Tm97v4XOehqZK7hg==
X-Gm-Gg: AR+sD11m60r5XRdXQ3707ZlNwitgznE5Q/3ERYBDo01W0Gj4nVO+huwE/+56Ln1FWC8
	Myi8cMD2UXN2gKsm7Bz3O+hRIAt5Y7/rshR5wrYGSrOWW20QX+EAvuDe2DT/e3MecX1QeFWd1Qv
	6kTrc/4KyQ72l1NEEOlzZIKBGdQ5K0vJzxk8n4pVf/gtog9G2FsJ5x0blasL/HHVX7EDdKF+slG
	AXSbcyFLYZ01xnhWE1mAHrGCXLEfIX7RvS5ysqnzmwYI+cple1yNVeRyxNvlXbMIDQBPae1oF9h
	c6ugLkMBFRL0Z8kIeCtb4QnZBVrltai+60Pg1CQcuWv8XTsJH3VYKOihFmZV6hlt6apKcjslQaT
	a27lAgrLhiWyLAlJmzQ8pzWMDvlFtFfQY/A==
X-Received: by 2002:a05:6a20:2449:b0:3c4:2fe1:fa36 with SMTP id adf61e73a8af0-3cb86029556mr985063637.36.1785873531026;
        Tue, 04 Aug 2026 12:58:51 -0700 (PDT)
X-Received: by 2002:a05:6a20:2449:b0:3c4:2fe1:fa36 with SMTP id adf61e73a8af0-3cb86029556mr985023637.36.1785873530336;
        Tue, 04 Aug 2026 12:58:50 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315867a68fdsm12316636eec.25.2026.08.04.12.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 12:58:50 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Date: Wed, 05 Aug 2026 01:27:45 +0530
Subject: [PATCH 7/7] i2c: qcom-geni: Use geni_se_set_rate() for setting
 source clock frequency
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-7-61171ab1cdce@oss.qualcomm.com>
References: <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-0-61171ab1cdce@oss.qualcomm.com>
In-Reply-To: <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-0-61171ab1cdce@oss.qualcomm.com>
To: konrad.dybcio@oss.qualcomm.com, Sudeep Holla <sudeep.holla@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Ulf Hansson <ulfh@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Mark Brown <broonie@kernel.org>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>
Cc: mukesh.savaliya@oss.qualcomm.com, chandana.chiluveru@oss.qualcomm.com,
        arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-i2c@vger.kernel.org,
        Praveen Talari <praveen.talari@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785873474; l=3035;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=PEW3pWPW2yxbK9ZgACWK44vjXfKNskPlikOmgv7qqng=;
 b=PONuwlbFYsiFqYceOtHQJdj11K7I7oLQ65HO6yCuf5x2ClKcFH/kiYsDzTK/wSVOZeBPvEfwC
 b5xPyxzpYFxCqv9DEc6UG9LydYfd111EEuQhmTzt5eJptXxSTzCPphg
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-ORIG-GUID: r6ob5sO5Cfa6NWGxlxBUkTav-AMd_1VP
X-Authority-Analysis: v=2.4 cv=EvjiaycA c=1 sm=1 tr=0 ts=6a72447c cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=jg7x1Z_fmygP-IZMYzcA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: r6ob5sO5Cfa6NWGxlxBUkTav-AMd_1VP
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDE2MSBTYWx0ZWRfXwN9qhPYKW4ew
 V74wp27yi9wss753WYbmmnZnTpAuhJvx65YQLu8buLUGyerBVBuTHBK9B2lUozzaYpN9mn7g0la
 iPz0LYk2/PhspiPSxLxQNd4QmxnCpt4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDE2MSBTYWx0ZWRfXw1DbQiK5hm1S
 arlfY5+yV+3fmec3OmNpMSSIxEgJ7F9Mw+TPk0tyWdtUH0mEZpBMMsjTEFrqK3TKvvUoyhQd5oI
 ze9dfsx7qo4foIVjpXdw6FLSIwI9R8R6ONLuMizeq2Zf2lYhhhrLuhZssfC2caZgkkXMaBXWA93
 5KN9XQjVKxJQ5wHE/vGg5nxMvrGvnCK9YELXGbs+FqbMUAhA/y3TkLM1eC4th2oD9NAWPhz8Vfh
 A1Gg4zhhA/7TqHefY2d4CpW9VmvIRRjg9N0HzM7LzgWltZt0y5Q2RVTpJmyu0en9oReegVbCiNf
 JM1VRAlsDPv7Ni8pqJoHRLLDMeShQoOyP2fZt+CjZypxLBx2WNYCYPHdi4JMky5hho70u1V9uOJ
 OW219B0howM2rkZUdTklr64uPx0s9LYkeALcgWtilQlWNPsAngV9MNhogKEf0Ep0gQjYgqqp6J/
 fwKgoUbFGm5BKYLhxdw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_05,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 bulkscore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608040161

On the SA8255P platform there is no Linux clock handler for the SE source
clock; resources are instead managed by firmware via a genpd performance
domain. The I2C driver therefore relies on geni_se_set_rate() to apply the
fixed 19.2 MHz source clock frequency expected by the SCL divider and
counter values programmed by qcom_geni_i2c_conf().

Call geni_se_set_rate() directly from qcom_geni_i2c_conf() so the
configured frequency is applied to the correct device (the perf domain
device on the firmware-managed path, or se->dev otherwise) without the I2C
driver needing to know which resources_init() variant is in use.

Drop the now-unused set_rate field from struct geni_i2c_desc, the
geni_se_set_perf_opp() usage on the SA8255P variant, and the unused freq
parameter from qcom_geni_i2c_conf().

Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
 drivers/i2c/busses/i2c-qcom-geni.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
index a23554d101fd..4561e2d235d5 100644
--- a/drivers/i2c/busses/i2c-qcom-geni.c
+++ b/drivers/i2c/busses/i2c-qcom-geni.c
@@ -213,11 +213,11 @@ static int geni_i2c_clk_map_idx(struct geni_i2c_dev *gi2c)
 	return -EINVAL;
 }
 
-static int qcom_geni_i2c_conf(struct geni_se *se, unsigned long freq)
+static int qcom_geni_i2c_conf(struct geni_se *se)
 {
 	struct geni_i2c_dev *gi2c = dev_get_drvdata(se->dev);
 	const struct geni_i2c_clk_fld *itr = gi2c->clk_fld;
-	u32 val;
+	u32 val, ret;
 
 	writel_relaxed(0, gi2c->se.base + SE_GENI_CLK_SEL);
 
@@ -233,6 +233,10 @@ static int qcom_geni_i2c_conf(struct geni_se *se, unsigned long freq)
 				 itr->clk_div, itr->t_high_cnt,
 				 itr->t_low_cnt, itr->t_cycle_cnt);
 
+	ret = geni_se_set_rate(&gi2c->se, 19200000);
+	if (ret)
+		return ret;
+
 	return geni_icc_set_bw_ab(&gi2c->se, GENI_DEFAULT_BW, GENI_DEFAULT_BW,
 				  Bps_to_icc(gi2c->clk_freq_out));
 }
@@ -975,7 +979,7 @@ static int geni_i2c_xfer(struct i2c_adapter *adap,
 		return ret;
 	}
 
-	ret = gi2c->dev_data->set_rate(&gi2c->se, gi2c->clk_freq_out);
+	ret = qcom_geni_i2c_conf(&gi2c->se);
 	if (ret)
 		return ret;
 
@@ -1272,7 +1276,6 @@ static const struct dev_pm_ops geni_i2c_pm_ops = {
 
 static const struct geni_i2c_desc geni_i2c = {
 	.resources_init = geni_se_resources_init,
-	.set_rate = qcom_geni_i2c_conf,
 	.power_on = geni_se_resources_activate,
 	.power_off = geni_se_resources_deactivate,
 };
@@ -1281,14 +1284,12 @@ static const struct geni_i2c_desc i2c_master_hub = {
 	.no_dma_support = true,
 	.tx_fifo_depth = 16,
 	.resources_init = geni_se_resources_init,
-	.set_rate = qcom_geni_i2c_conf,
 	.power_on = geni_se_resources_activate,
 	.power_off = geni_se_resources_deactivate,
 };
 
 static const struct geni_i2c_desc sa8255p_geni_i2c = {
 	.resources_init = geni_se_domain_attach,
-	.set_rate = geni_se_set_perf_opp,
 };
 
 #ifdef CONFIG_ACPI

-- 
2.34.1

