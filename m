Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA32530E1A
	for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2026 12:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792069157; cv=none; b=Pt2zos3F0OmRrfi9mwc8gCJbkJXNlhsn+Un06OS09gekJaAuwGc0wWk3VQwoPK6/N4KVbCSixusjghdH+Ff47TFvN/vcQTHvykYkq5j8VQo5IJpqtzKuOCDwOW1dlBA2FSAKboP0zhxw0vsO9uqb/AKXDtWKOQMyE/QtNo2Jnu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792069157; c=relaxed/simple;
	bh=DFbeif1siwvLY3MMd4TdLfB4FjRIpjFhIHxBdIWFXfQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f9gtiQXGPgAD6ytbzVLWEgFDGJXczIbUnrpdWcrr0ayf/3kZVv/Gfgu/rHMEPBd8XHhKM2OJ1hH8lU2FDXWr1Y3+7Rnr1mNXoVJHlEPUrj/6RUNfhWne85oHIaPFETY9GNBKmrWYcNPYnBwZOOmD0LRyrafmAxrfRmU+0Z4Yp+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LBQGD8pO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iWrP3JrB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LBQGD8pO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iWrP3JrB"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69F9jVPF2416893
	for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2026 12:59:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tzm6AB9lq0hXcWvlWTSDwsYy5uYcMWQNCxs2piz67CQ=; b=LBQGD8pOGQ7+Bk+X
	vxrJS9EIOW/N2OsOJTtX82fZjOIo8io4JKaSTQ3OOnZc7cpIKT+7SYttqpZDYAfm
	3gvp++nUAWigsDNAsBmVkGn3kOntEi2ssyFFXiJa5jbjI4/HnryfDzkwEK2WtDHB
	olZ3T5edsY6cAYp6q+ykVvAdEYvZldA6G3ARD5oHkcqAONrR31/i4x5xj8SXnf+S
	3a4ysdXs0nHShUHx+go/QnEXdm9TuAXP/lm2aYz39IL4Dm7jHla2TpUqaN1s/IQY
	GCRJbx68LPxJWvoCHvhsPiXqoXVW6T/wOZvB2nG9w5xpA6ckVF6Xp/6Zhu8i1TlZ
	vLZB2w==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4haqdhj5q6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2026 12:59:15 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3ac575a9198so2260719a91.3
        for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2026 05:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792069154; x=1792673954; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tzm6AB9lq0hXcWvlWTSDwsYy5uYcMWQNCxs2piz67CQ=;
        b=iWrP3JrBjEQkphLCmKcjgh9mFFWCetpDDC1HBg5Oz5Bqdztbrh2ztBwqBiRDeBCZ/z
         pFRrKXwuArrATOFCUBdPzidvIKw593fuROPTvi31ToCmGG86VMjVFu3jX0kYvDt24fOs
         CcXlGmPmHSit9Pmt3VYWx6M9Bf6d4NSiYaPEkLuM1nwYUnN5Gafw+45fEgsk3lVgkcV6
         rZBmGiR1ZP66DM7V2fmR4b1eXT40zEXEU9sbllbJ9l+c5VnvUT/StqDzwgQWqz5ekYZi
         2LA5Af18prnEujc/5G9T/rmZfOOr5XDYcp8g1gSXayVYR5yPUznlOO2Pvp7bYTl+BuXN
         Mi3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792069154; x=1792673954;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tzm6AB9lq0hXcWvlWTSDwsYy5uYcMWQNCxs2piz67CQ=;
        b=Cdiet4ljHk15QjaufheeCsWLqm8acWY0kKLuuvIXwxra2Qaew1H28YL7LpydvDRT/v
         oItw+Wck/QqwhApcRyWqZOpSg/ZsnZjrUz54ty94R0GQ4NRiLJsRysH4/2Fc9k5fvEmb
         UpMhZhyf9AQuQeAMotYeJxKLQGgkHHVQzoPJKi8puD/bz4rTzifXOF1asByWhrdyxP9s
         /UbJhKq0Pgdn1JzfXl51jj++jXzpZI+4Wnxyoe1Goy1Ark/MdLmQ7uRFMlDSZoOrPZs8
         kyQ++QQd64LKwuuat/Rdprg8Qh/+SwLuAsdIwQdaEm7ojRHBwyxiI5wrasr/RmAoQBS5
         EJ0w==
X-Forwarded-Encrypted: i=1; AKwUvByN42fEeScLfhA1NZOkiXIjGj4IpcM8JVzqM7r7a+Wz7GuJyZdZjMy3t6izcj778gd8ooIOf1dZNA==@vger.kernel.org
X-Gm-Message-State: AFq9FYJ5Uz+zIKP6h++VWBUYJJT0aqjx4Ars8GJwf7IxabFLTAE35yHH
	m6vjHXnaZCv41pdNuea6y2LbYE7g8HJjLQ1a/ZG19xOhPDzHiOC8hSpjYv9SBeWG9o6FqCyegfq
	ES473peldNxptipJeisFOBnKg1E/GakvCGTOQAc6eafuhcR0mrEUDipOx7VDjMQ==
X-Gm-Gg: AYBFou1xUtos8h3H0+j1jLWCkFNaPGaK3fKGOAq6B3ImnIrg6hZOKwPyzYHMcSsF8W5
	HRLw2Guz9RjTAjhre214ha50+EXcrX5jJ+wY3il7JScLcrUGo1zfjSIWdP4dJ8+YaNbJZ4EeKL/
	bPhTyRTxbnDtYDOG3OaaqwRZDFGNmjYPEk1wir3hT2F9UBIrQWceWiXUkiObW7eQGs2PZpmqXIy
	5Va8wTUHNud2ryGTVRq2Sk9cAhD7ZxSDIo+KtFsOc64bLOBrf7ViocU5D3cizHd7PR0N16ZVUZ5
	sQbE5/B5jFQuVK8uj82lODTkv701SPM3nE7Htxnl6QsrY/jBUZtJcNBwuPLdr+wLIM2QT2L/+lV
	XprHfQ8SGSUCWjWr4QbWfO3bvOahuo+kiXQ==
X-Received: by 2002:a17:90b:384d:b0:3ac:97bc:4c7b with SMTP id 98e67ed59e1d1-3ac97bc59f6mr2382277a91.14.1792069154124;
        Thu, 15 Oct 2026 05:59:14 -0700 (PDT)
X-Received: by 2002:a17:90b:384d:b0:3ac:97bc:4c7b with SMTP id 98e67ed59e1d1-3ac97bc59f6mr2382180a91.14.1792069152211;
        Thu, 15 Oct 2026 05:59:12 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e8422b8d8dsm79691705ad.52.2026.10.15.05.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 05:59:11 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 18:28:25 +0530
Subject: [PATCH v3 5/8] spi: qcom-geni: Use geni_se_set_rate() for setting
 source clock frequency
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-derive_clk_perf_tbl_from_perf_domain_opp_table-v3-5-5da1096243c9@oss.qualcomm.com>
References: <20261015-derive_clk_perf_tbl_from_perf_domain_opp_table-v3-0-5da1096243c9@oss.qualcomm.com>
In-Reply-To: <20261015-derive_clk_perf_tbl_from_perf_domain_opp_table-v3-0-5da1096243c9@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792069108; l=3817;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=DFbeif1siwvLY3MMd4TdLfB4FjRIpjFhIHxBdIWFXfQ=;
 b=MAjUv8u6xRV0Xk8anMuKNPBJADNkMGHOAE/nSNJ7PYGexYasIwbbodDRwGZE82ThwEC0Ld4ae
 9ifbQpoguX3AWaObYGccS1F8ifkd8N9gMboimFft/lk2OsDFGizoY80
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA1MSBTYWx0ZWRfX8dyhgywaxAnu
 AP2ffX9626Kkt9JRfJyQaEWDdfA4UJtQ+bd+Bz4EfoWPxadhE16g4aH1ocOCo9kqYZsFmPXbNPR
 OE8sF+o0QPi5oIA8VsOgZEt5pkDM3aqA2OVjftrckk6f0/YFcmAGthlUQ52JGJb5cr4/v5FCken
 9M7yYkkfHbD+4YcwlfzLeuezc3hDoQicV4YVzZ8hUjAOuaMfTvr40TqoLqeV5ZmH/Y4q6xB6v+5
 BqMtdxyTzcqW/wYl20bjKl4E+BvdpeX/u8GsZRpgjf19PSfFaGNV3oaoOfueoRA72E9gQZ716fH
 4A4VJHTHUw92sf6yIpGQ72UTQpO9fEABN3tmMBcBjZbhKVcOH7dJUsF8/SgTFl8mlwXHq5S/FV/
 QhjJ9vaPmtyOjTNs3SE25Xrf3k2jHOjWn03Ws8yveZHVV2HBn/NcMUyseWJe+SQctCc7eNXCPLN
 BY007sCt+alcJIwCNnQ==
X-Proofpoint-GUID: XgOzkMkLY2tK7oPak5BWoKU_xYSLtyZB
X-Authority-Analysis: v=2.4 cv=DeeCOftW c=1 sm=1 tr=0 ts=6ad0ce23 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=V8jFpX-JU2fdHFI84kkA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA1MSBTYWx0ZWRfX7wH/4+wPnh0U
 W03eNfgNEsAkuIGwPCnInArjrAjFar974dGMsQAZz/ltaUT7ZQjLATmk846wUNO8b+ErPlbMxcv
 lHFUrCjSYmv1MssE0D0Cm/RtGXsHMMQ=
X-Proofpoint-ORIG-GUID: XgOzkMkLY2tK7oPak5BWoKU_xYSLtyZB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 suspectscore=0 malwarescore=0 phishscore=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150051

On the SA8255P platform there is no Linux clock handler for the SE
source clock, so the driver has no way to look up the source clock
index and divider needed to fill the GSI CONFIG0 TRE for a requested
transfer frequency. To work around this, firmware instead exposes the
SE HW supported source clock frequencies as OPPs on the perf domain
device.

geni_se_domain_attach() now populates clk_perf_tbl from
the performance-domain OPP table, allowing firmware-managed
platforms to use geni_se_clk_freq_match().

Use geni_se_set_rate() instead of dev_pm_opp_set_rate()
so clock programming is handled centrally by the GENI core,
independent of the underlying clock-control mechanism.

Acked-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
 drivers/spi/spi-geni-qcom.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index 91e75e213f92..cbccd6d8689a 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -18,7 +18,6 @@
 #include <linux/module.h>
 #include <linux/panic_notifier.h>
 #include <linux/platform_device.h>
-#include <linux/pm_opp.h>
 #include <linux/pm_runtime.h>
 #include <linux/property.h>
 #include <linux/soc/qcom/geni-se.h>
@@ -85,7 +84,6 @@
 
 struct geni_spi_desc {
 	int (*resources_init)(struct geni_se *se);
-	int (*set_rate)(struct geni_se *se, unsigned long clk_freq);
 	int (*power_on)(struct geni_se *se);
 	int (*power_off)(struct geni_se *se);
 };
@@ -155,9 +153,9 @@ static int get_spi_clk_cfg(unsigned int speed_hz,
 
 	dev_dbg(mas->dev, "req %u=>%u sclk %lu, idx %d, div %d\n", speed_hz,
 				actual_hz, sclk_freq, *clk_idx, *clk_div);
-	ret = dev_pm_opp_set_rate(mas->dev, sclk_freq);
+	ret = geni_se_set_rate(&mas->se, sclk_freq);
 	if (ret)
-		dev_err(mas->dev, "dev_pm_opp_set_rate failed %d\n", ret);
+		dev_err(mas->dev, "geni_se_set_rate failed %d\n", ret);
 	else
 		mas->cur_sclk_hz = sclk_freq;
 
@@ -850,7 +848,7 @@ static int setup_se_xfer(struct spi_transfer *xfer,
 	}
 
 	/* Speed and bits per word can be overridden per transfer */
-	ret = mas->dev_data->set_rate(&mas->se, xfer->speed_hz);
+	ret = geni_spi_set_clock_and_bw(&mas->se, xfer->speed_hz);
 	if (ret)
 		return ret;
 
@@ -1248,9 +1246,14 @@ static int spi_geni_runtime_suspend(struct device *dev)
 {
 	struct spi_controller *spi = dev_get_drvdata(dev);
 	struct spi_geni_master *mas = spi_controller_get_devdata(spi);
+	int ret;
+
+	ret = mas->dev_data->power_off ?
+	      mas->dev_data->power_off(&mas->se) : 0;
+	if (ret)
+		return ret;
 
-	return mas->dev_data->power_off ?
-	       mas->dev_data->power_off(&mas->se) : 0;
+	return geni_se_set_rate(&mas->se, 0);
 }
 
 static int spi_geni_runtime_resume(struct device *dev)
@@ -1265,10 +1268,7 @@ static int spi_geni_runtime_resume(struct device *dev)
 			return ret;
 	}
 
-	if (mas->se.has_opp)
-		return dev_pm_opp_set_rate(mas->dev, mas->cur_sclk_hz);
-
-	return 0;
+	return geni_se_set_rate(&mas->se, mas->cur_sclk_hz);
 }
 
 static int spi_geni_suspend(struct device *dev)
@@ -1310,14 +1310,12 @@ static const struct dev_pm_ops spi_geni_pm_ops = {
 
 static const struct geni_spi_desc geni_spi = {
 	.resources_init = geni_se_resources_init,
-	.set_rate = geni_spi_set_clock_and_bw,
 	.power_on = geni_se_resources_activate,
 	.power_off = geni_se_resources_deactivate,
 };
 
 static const struct geni_spi_desc sa8255p_geni_spi = {
 	.resources_init = geni_se_domain_attach,
-	.set_rate = geni_se_set_perf_opp,
 };
 
 static const struct of_device_id spi_geni_dt_match[] = {

-- 
2.34.1

