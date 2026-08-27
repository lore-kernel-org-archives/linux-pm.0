Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CFB4B04AE
	for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2026 18:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787853645; cv=none; b=FWSLy1ztdDPk9wDD3gZOISRQit0fZgCI3Nb02sMt6oAMHNZy0QQokydWPr4Rex7yXotec6ZepZgClDH7c45cVYBrITt1tETFk9ZYG3d5ztC8NosTlVYf04T9oNzB6ZIX06fU5bzNOdNmOphxPQ6M2xBsT2LRoetL2ZqawZUB8aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787853645; c=relaxed/simple;
	bh=NjCwN+DsAYC8C+NrLmOLrNQM+M1WYqvKKDKj63mj+98=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i06DHr2GIN6gKmNmIQggR5aYE/hUnaR9Do/J8aaI9Cmi/pSB2MXeaYRFNESR5zpZqxYJd18IuQWllpjmZwXQitLXhosddO3N718D6C6/mtjUW6DYwwCAJYXWzXv5QzzWWgk7UVTtDm/u1GYNhzoodmaU2hMifMBptq0AriBXigY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ppmv8yPK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WW02I8Vp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ppmv8yPK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WW02I8Vp"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67RHXnpX553945
	for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2026 18:00:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+QvdWGn5rqFtTcef6NfYXo2PfwQibN77OSCU6yboIRk=; b=Ppmv8yPKbb9PHUQa
	uo8WRtVl4iinZTO2w9ED9nUIJ8fEyPnMYBqDvE/P7e1vMbyjoWEzFH5549C/TIni
	CGIDYKmn+CnZ2ffU64ONax2SutM9EXNkp6HaAHb0uOimGMXcI71e67HFt7sy23bZ
	m9WqgUocbnJiH6C2p98B8+FluWdmXmRknFm8d/fxJaxHbRneFosHn6lMQMY7/jF1
	UvnZCVUfeUqzImgs4j0ZE39rtYaRYRLlWAAqYFMgZN/TijQc46Lttd5/aFEEB7Dp
	jRxNLA72WAb5X6PCfAgTV2JRuHF+U2WsZvFdiEq4uiL1crN1y9KpFaavKKF+1JLw
	yUUc4Q==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gam6fhqkg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2026 18:00:37 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38fa7b09921so356470a91.1
        for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2026 11:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787853636; x=1788458436; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+QvdWGn5rqFtTcef6NfYXo2PfwQibN77OSCU6yboIRk=;
        b=WW02I8VpuLYg1SRAR7E7d3sZrPyulyxkyvY33R//xkC9qNxLHVOZTRXn9jkTZt0gFp
         TRkDZZxZ1yKxTH5RXsOV33/xDQQ5SLPr6H2iuP/OqA3YJ+jqEV6MoNvJ4LsaZ/pMbdqG
         JrCAPgZE7u/o7AoCzAldVN6nMxCgm92kn5986MKWQW8uSmgQIDUrCNVPnVQTqJgs9s9s
         oJxweCx5c9x2tZTAbiQ8AXU6Rt0V/af847755CLCms41bdd5EF10xfi9S2qBxGhoevQ8
         uHmmXI+Fym2Fu45hcmFi/JYjb5DyyTYB5qq8/eEpAngcalqBetDVF0EUAAIGMcVUHajp
         Qaug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787853636; x=1788458436;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+QvdWGn5rqFtTcef6NfYXo2PfwQibN77OSCU6yboIRk=;
        b=fTxVMYFylaiGB/Bgqf9m1aNMiY1v441R1P0DzqtG1fYHbpQE+E3sf4J6dZRVVkoNjh
         qxLhCCEx0ssowIPb57dk6rRuR/FidSQw44u9JiGCLcNqIbqRdCtv4SeieVrjcSJbnyT1
         kaBo8vBI2y4jL1qy/rpy1GxjOLteoii3nRN2ET1uFrX0yFuE8UqHmf70hLBfKTHJW/6M
         DWWlf1eBcoMjS2SjIgFq/GQBNbfmprSgS8qP9Vutpwmt6xAvfbpJraZceG010+e1NErw
         tg/0V6l+UT/l7VNAigdPPECKl6FjuLLzavLRRd5yr6g8ur/R40G/d8URKMrFkpMcoIju
         y0Tw==
X-Forwarded-Encrypted: i=1; AHgh+RrklRpzghAVNrDtRtvTrflrzYqMP3T+aFGekhHsUSuvfOmlbLGi+EH9UQuJjXZOzLDomMl9uO4NAA==@vger.kernel.org
X-Gm-Message-State: AFuF++mPOZRQWDiut0G1lAbXzuaw1C/2MR550KKCjryzRUO23rZNgQt3
	NoqcCKNxi+D1Mk6Gql0RJNGAqdMFdZx3kdu53FFUDrrGYTZ0P1KxjHagO7hgFIxIOecmDM91IGS
	PzD2ZPymtrWZncZJ8OVCzEASLhQ18j2FmAPpr0CiseEPWBs2+gpIoMMG4MHgGaQ==
X-Gm-Gg: AR+sD12u1uWjPQmAI63PcJoDI9RSr8GdiVqDUyzDvqwCLlBioPYg+Xy+Rg3XT4LGD+i
	Co32rOIntA6LCKhCneOHECbD/htVNC6qvUVedUeezIobl6Iz76K+eKJsVqWxGrg4Rs7nEddRQfm
	OOQc4muNnMoxiSA593AZC19R57/kUYJxW1Khe7Kj2NPIrrO4zM6gLG1xlssdBObnrU7a32tr9Lc
	z8fiJIOWlzt8UagnPfRntkRMiDGSJY0kWlmD+z3QmP+2IlPGxgNO85QFyOl3o2jml8S/iVQlb0R
	9SQjTqD5ZWFkRcNqCzXBNuNzomc5VmSC09z1oC6SCnIeXBnHHvsYs000aDU7BqOnytOs0vH03mG
	YtXPafxGhJ+XhidbFapumuO+LK30XYiGCZw==
X-Received: by 2002:a17:90b:17c2:b0:396:b918:c2a with SMTP id 98e67ed59e1d1-396d0faa459mr1359101a91.12.1787853636354;
        Thu, 27 Aug 2026 11:00:36 -0700 (PDT)
X-Received: by 2002:a17:90b:17c2:b0:396:b918:c2a with SMTP id 98e67ed59e1d1-396d0faa459mr1358225a91.12.1787853632427;
        Thu, 27 Aug 2026 11:00:32 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141a905cf38sm27437523c88.12.2026.08.27.11.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 11:00:32 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Date: Thu, 27 Aug 2026 23:29:26 +0530
Subject: [PATCH v2 9/9] i2c: qcom-geni: Use geni_se_set_rate() for setting
 source clock frequency
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-9-091697dbeb02@oss.qualcomm.com>
References: <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-0-091697dbeb02@oss.qualcomm.com>
In-Reply-To: <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-0-091697dbeb02@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787853566; l=3297;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=NjCwN+DsAYC8C+NrLmOLrNQM+M1WYqvKKDKj63mj+98=;
 b=it9A0O4HyitFGzlN8icAAHt99GLQ4iEQWhvQvTQy1VFytbLLTb33k1x+gZt/2GLUyQamW0TmR
 qBFXMl3rJimAGo0vjRZviG9h3ZLpZX8wqYXM1VWD6awoH4nAqu23Rlb
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE1MSBTYWx0ZWRfX0lh6aCSeY29T
 TlTieHmgIXD2uaijb6p2W0qUnCGZaQUo18aRD+e/xkQ0Bb4d7Mst3ULdpnugCRu4J0zCAXT47Nv
 b18ilwIRnov4csXm94Xh8ZCOVbqXing=
X-Proofpoint-GUID: lR62JCj42TcvVMsi1iS4-tPN8PhLdTNP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE1MSBTYWx0ZWRfXw4GKPJj2YAzh
 EtZq/JBZJzRbwOtd0z91hDTVXyqzXkv7j55gF9kOyOivONJK3wFq5yOTVJIcABWGice6JTfZsc8
 JIFPR56mfJ4AD2JhswiGZGJdMTiXee3pxga+dIzs3QFG35KQ5t7FQ+3/bF0FeNgI3yyz48uphKU
 B88EfmvqGRPd2vtTn6zPUW2ljt2viL3uRNS4VF6NJOBWoGkyzhLwMs9sf1uMnn2W/uvbhRgbuGR
 oljGAhFb1DtgSw0uX58NVQIOjsWtwwy3eBNApZ8/UCTKJowhbXKGla66fknDMtmr3dvpim4kNBg
 LZV4NllaAluavP7fs8Jbl/K2ziK/U4Xps9M9WTXFaqNSnGAMy8iRxuyNF5olQXMv9vM+g9zp3nf
 Nh9Ry4b54gESdIJYMql4k2UFmZfBtFadWLxBDFdhuH0tPxiW4Jd59iRIBngBEO83hT2O1S8gzXP
 0M2WHZpu5/n8/LRtijw==
X-Authority-Analysis: v=2.4 cv=eIgjSnp1 c=1 sm=1 tr=0 ts=6a907b45 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=V8jFpX-JU2fdHFI84kkA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: lR62JCj42TcvVMsi1iS4-tPN8PhLdTNP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_07,2026-08-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 bulkscore=0 phishscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270151

GENI resource management may be handled either through the Linux clock
framework or a firmware-managed performance domain. Source clock
programming currently depends on platform-specific callbacks.

Use geni_se_set_rate() for source clock programming and perform the
source clock configuration from qcom_geni_i2c_conf(), allowing the GENI
core to abstract the underlying resource-management mechanism from the
I2C driver. This removes the need for platform-specific rate-setting
callbacks and enables a common code path across all GENI I2C platforms.

Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
 drivers/i2c/busses/i2c-qcom-geni.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
index 0b178701e1d1..deb0d822290c 100644
--- a/drivers/i2c/busses/i2c-qcom-geni.c
+++ b/drivers/i2c/busses/i2c-qcom-geni.c
@@ -16,7 +16,6 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
-#include <linux/pm_opp.h>
 #include <linux/pm_runtime.h>
 #include <linux/soc/qcom/geni-se.h>
 #include <linux/spinlock.h>
@@ -219,14 +218,14 @@ static int geni_i2c_clk_map_idx(struct geni_i2c_dev *gi2c)
 	return -EINVAL;
 }
 
-static int qcom_geni_i2c_conf(struct geni_se *se, unsigned long freq)
+static int qcom_geni_i2c_conf(struct geni_se *se)
 {
 	struct geni_i2c_dev *gi2c = dev_get_drvdata(se->dev);
 	const struct geni_i2c_clk_fld *itr = gi2c->clk_fld;
 	u32 val;
 	int ret;
 
-	ret = dev_pm_opp_set_rate(se->dev, itr->src_clk_freq);
+	ret = geni_se_set_rate(&gi2c->se, itr->src_clk_freq);
 	if (ret)
 		return ret;
 
@@ -985,7 +984,7 @@ static int geni_i2c_xfer(struct i2c_adapter *adap,
 		return ret;
 	}
 
-	ret = gi2c->dev_data->set_rate(&gi2c->se, gi2c->clk_freq_out);
+	ret = qcom_geni_i2c_conf(&gi2c->se);
 	if (ret)
 		return ret;
 
@@ -1228,7 +1227,7 @@ static int __maybe_unused geni_i2c_runtime_suspend(struct device *dev)
 		}
 	}
 
-	dev_pm_opp_set_rate(dev, 0);
+	geni_se_set_rate(&gi2c->se, 0);
 
 	return 0;
 }
@@ -1239,7 +1238,7 @@ static int __maybe_unused geni_i2c_runtime_resume(struct device *dev)
 	struct geni_i2c_dev *gi2c = dev_get_drvdata(dev);
 
 	if (gi2c->clk_fld && gi2c->clk_fld->src_clk_freq) {
-		ret = dev_pm_opp_set_rate(dev, gi2c->clk_fld->src_clk_freq);
+		ret = geni_se_set_rate(&gi2c->se, gi2c->clk_fld->src_clk_freq);
 		if (ret)
 			return ret;
 	}
@@ -1290,7 +1289,6 @@ static const struct dev_pm_ops geni_i2c_pm_ops = {
 
 static const struct geni_i2c_desc geni_i2c = {
 	.resources_init = geni_se_resources_init,
-	.set_rate = qcom_geni_i2c_conf,
 	.power_on = geni_se_resources_activate,
 	.power_off = geni_se_resources_deactivate,
 };
@@ -1299,14 +1297,12 @@ static const struct geni_i2c_desc i2c_master_hub = {
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

