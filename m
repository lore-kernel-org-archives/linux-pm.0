Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F554C6F1C
	for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2026 18:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787853640; cv=none; b=Pb4tnT65UxaDEQ7nw0fLOdqOBtMh0qn/ULt3QLWBzd2fCTGagMpWbH+jDFT1+VrJzCvnSrI4Wg2E3fhOrPW6yPQk1mnLBShddf3HKTPDXPSWb8uUI+VlDiV9zdTYFgY0jEOfjBF/Yv3FOGhymDev2kITsb15AzBiCv2gHbWEyHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787853640; c=relaxed/simple;
	bh=w5pv/KNIEdlnHDT3uJaPurHB9sUygy6lp1p1Tpumn1I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uS97+jFB7yHpc+ICGplq3I4T8YKeIGOFFbMfVEouc4P9eglwvg9rJJtVjKeBP4Sde5+rHBslaienYabAOaGBbYHwTL/rsHqLKtv0fd24aLsLDM6XL15Q+UnH6LLQVaHPsnPoaOp1NLn7CjJDd64/Bg6lB7R80qBOge1i2Uvb2cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=C88KNkNM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Xv88aTzi; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="C88KNkNM";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Xv88aTzi"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67RHXcIj873684
	for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2026 18:00:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	98+ip0Wb3BBuztCCDHQ2Rp/wdTyxXqiBl8ycdGuMnbI=; b=C88KNkNMelO7r2sf
	yDI+hrbFKEWqA5Um2t1rGa1czu7xI43Yx9W7hJ87lOrl6gWht7X4Pcg2g+OWfqc9
	6/UQx/ZcQMIXaB4Uazh5RHUHB8BTSg7O72btawORm/z/dEQmfEsWiVqrHheUSQ5M
	DstzmUbvRXn/C5fuymm4IFcC+OF0jYhrIfBnemsXiEDSFGpuXGEybJocxPkbg6VJ
	c+BFiyizWQ2fxW3W8Q/lBbU2Hy+BKdoo/i49oDmEsNHbc/qqG+r5OBenGbYlWTot
	vYhILlD2tlOTEjzj7D58he9l717qb1NsjoYv0FVnFbTjbFWHpjh9kyClQZ/7Q13p
	oaLY5Q==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4garn0gjc1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2026 18:00:32 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38fa7b09921so355983a91.1
        for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2026 11:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787853631; x=1788458431; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=98+ip0Wb3BBuztCCDHQ2Rp/wdTyxXqiBl8ycdGuMnbI=;
        b=Xv88aTzieBgGv+hv33QAXbgSuaTg3PlDM+V2WOQwk7yf+nmI1N6o/S0bPWFHd4u5u8
         rKIS3kSdCDbm2ZiS9nq6AQC+UBrTkX8XOu0v7+U9L5dNQ51sTw8M4sPnTQru13fLkpzP
         9LOqoUCTI2A6HZebS8v3qmkADGTUtvWgDLAxfnOu5avr5iXlnUP/TUjFGruGvTnnSudO
         JBgX9MPuxRDDeVG9uBEJ6nLaRi0pKQNzOzAmNNao2F5wRYfZNcyUQOkFIM4pqxF2vzEr
         Te5qCDO8Za4yyVABLohk8W2R9gxAcsgIrJ24+X8u05nnr9GmbvUGecoMOXjFnMXzUfpe
         dyGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787853631; x=1788458431;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=98+ip0Wb3BBuztCCDHQ2Rp/wdTyxXqiBl8ycdGuMnbI=;
        b=Ahrb3rDIj3Z8asSqCQAnMRhU+Y8OxAIK78GtarHjD2i/BLfPCYYjiyBsDK7HDQVZf0
         F7DTUaI6T8uM7/HYoDU2y1APZQCzkh8sIMy6lg9qPLpKm3ViCkmXDJM4QN0nJ9GaK2PG
         qMBk3b68wEZApaRPivD1aWh43cdMz2Z6uxM5nfs0N/NmP8dnYiVZDhXfeGg3JCwn/vq2
         ZR9es/ukeP32813yr2KgRlIJiUc8xVSd0KHKMfWd87w/anBdPCptQscpxIyyYkuyzDJX
         q69Ixc7gjiN9jfiYNJm4ReGwghrqkscc6b8/AFCy7H0LqfH3Cf9SEBLzDzHey0ZCJ4tG
         3VUA==
X-Forwarded-Encrypted: i=1; AHgh+RrdHIDS3Rpdd5FSy+ZHpjD8PiutB60re6c1QASAO3lcWInzL98E+lNaKlvP/3uUiceCnunVzAOTPA==@vger.kernel.org
X-Gm-Message-State: AFuF++ngmlD61P2CF+LpaKuqUPUDtUwCc5/4uwoBXEnG4dxJlv+d17O6
	DldfdLJGYCgOGZKY/Qo3VC+cl5TAh8parLl0QVQSQO72CIAhqK808iCyurfAJ0fV/IsDXdE3/z2
	NP/yZnOgnZmGjZizcvFHAiyVw99aRs192xEc4eHqursYYkc9EyDXiOiBLSkoRoQ==
X-Gm-Gg: AR+sD10dQsWtMFrZWNwlgCyBLedtTmiMYr9EP3d5B11sux9XxwyDNCzq0jwMhB8yoIV
	CEwu9mbTXO7VgWOlruZNyecUojK0NpdCynSkWvSJHlWnAmD/9QIGZs0gHzkAGPmVoibOUxGHbLG
	0QW5G/X8SQ0W/cDmxN9sjah1bHL2ctkhp/iJ3zdkdvJKCU6pLho1Vx3HYH4oS93GprCFRVW8ORg
	93U47xjy4qvBgAQM8zrP/161l0mDv6fu44/IISnpU6Oy6V+OdoFbYTU6QxUOG1kDKPjqN8VRfA2
	A3gAzzCS5eyzqdXNwKvxt6wd+pnRPTSbGUL4I3EE4DHBSqygjq3SiFCfihV20DjKT69HHfhy0If
	rIPaTrYea4o2Ve7BCkmJN0de8NjqRNwtGVA==
X-Received: by 2002:a17:90b:5249:b0:396:40e6:f631 with SMTP id 98e67ed59e1d1-396d0e306e0mr1999501a91.3.1787853631158;
        Thu, 27 Aug 2026 11:00:31 -0700 (PDT)
X-Received: by 2002:a17:90b:5249:b0:396:40e6:f631 with SMTP id 98e67ed59e1d1-396d0e306e0mr1998281a91.3.1787853625847;
        Thu, 27 Aug 2026 11:00:25 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141a905cf38sm27437523c88.12.2026.08.27.11.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 11:00:25 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Date: Thu, 27 Aug 2026 23:29:25 +0530
Subject: [PATCH v2 8/9] i2c: qcom-geni: Use common GENI resource
 initialization helper
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-8-091697dbeb02@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787853566; l=3130;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=w5pv/KNIEdlnHDT3uJaPurHB9sUygy6lp1p1Tpumn1I=;
 b=RpUaUAw4SKyeq/cMnDINFjUHMhU8BrCF7nO0MIN9bUEOAtoiVOMD/WJLDNub+JvNeH6he/jUe
 5Mfv+iUwybdB1Cy0ZdXhE2WefHG4NrCHaa3XdNT4+Q6x/TuYvwULgFI
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE1MSBTYWx0ZWRfX7Lp5OEYwYaiD
 OriWxjvexwsa/uCTOf1+AnOaVkm7FAX6zCV1VSuaR+h4JGOg1RngC5yG4OnnF/FU9jvfROio80s
 XaYa6RJrE/5F9g9MdUkhxsBjOR5TAKBUacMDM+Gku0htMq/7vSNKztm38Vza9Wh+bFnYKdF8Vxx
 nj+9HCk4L37pI7th1xm6HGILXckILgZ0eLQztmz3KLO79Z+65rhi3gPT6UnWzboQ0JvnWkbd5Rk
 ml0x6XoebNut7F/5B08/diOzWJc2wx4bu97qps6xBveZ0XoP13bhamJacQDNz0/yJwu79Tq0xex
 S8FGxs3SF2kFx6KDTUbmvquwO8dX44LWUdPBQsVknGRZXMtHFOpj8QITY/IM7TG/wBJyY/pyBU1
 3Km4pB+pwpnlb+Qx8d27CgQSRKqKT3SLr+215ZWD+UMjs+DEOyb7BM0oJQyJFUjsj0YjmcmSzxk
 GDYzTAc3dsly+9ohZSA==
X-Proofpoint-GUID: _fFeXTgy4HMtbz0iZjKdg8jPXCdfu5DA
X-Authority-Analysis: v=2.4 cv=C+3ZDwP+ c=1 sm=1 tr=0 ts=6a907b40 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=2yxW5TxCEIWXvfGmYYcA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: _fFeXTgy4HMtbz0iZjKdg8jPXCdfu5DA
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE1MSBTYWx0ZWRfX5hn2Aj8Mwbmh
 BFY4ojhG38+w2ET2GUmcmfYv4POxjBR1h0OKaEKLQagJ/d1iYEirMECpxe0j8NN7HqLT7iSVH89
 LtztE1bZEfVtfCu7AvfDPFR3pgBqOxw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_07,2026-08-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 suspectscore=0 adultscore=0 phishscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270151

The driver implements a custom resources_init() callback for clock
frequency validation and bandwidth vote programming. Neither operation is
required for resource initialization itself.

Move clock frequency validation to probe and program the ICC bandwidth vote
from qcom_geni_i2c_conf(), where the bus frequency is configured. This
allows the driver to use geni_se_resources_init() directly and removes the
I2C-specific resource initialization wrapper.

Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
 drivers/i2c/busses/i2c-qcom-geni.c | 31 ++++++++++---------------------
 1 file changed, 10 insertions(+), 21 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
index a3b7609e3cf9..0b178701e1d1 100644
--- a/drivers/i2c/busses/i2c-qcom-geni.c
+++ b/drivers/i2c/busses/i2c-qcom-geni.c
@@ -242,7 +242,9 @@ static int qcom_geni_i2c_conf(struct geni_se *se, unsigned long freq)
 	trace_geni_i2c_bus_setup(gi2c->se.dev, gi2c->clk_freq_out,
 				 itr->clk_div, itr->t_high_cnt,
 				 itr->t_low_cnt, itr->t_cycle_cnt);
-	return 0;
+
+	return geni_icc_set_bw_ab(&gi2c->se, GENI_DEFAULT_BW, GENI_DEFAULT_BW,
+				  Bps_to_icc(gi2c->clk_freq_out));
 }
 
 static void geni_i2c_err_misc(struct geni_i2c_dev *gi2c)
@@ -1111,24 +1113,6 @@ static int geni_i2c_init(struct geni_i2c_dev *gi2c)
 	return ret;
 }
 
-static int geni_i2c_resources_init(struct geni_se *se)
-{
-	struct geni_i2c_dev *gi2c = dev_get_drvdata(se->dev);
-	int ret;
-
-	ret = geni_se_resources_init(&gi2c->se);
-	if (ret)
-		return ret;
-
-	ret = geni_i2c_clk_map_idx(gi2c);
-	if (ret)
-		return dev_err_probe(gi2c->se.dev, ret, "Invalid clk frequency %d Hz\n",
-				     gi2c->clk_freq_out);
-
-	return geni_icc_set_bw_ab(&gi2c->se, GENI_DEFAULT_BW, GENI_DEFAULT_BW,
-				  Bps_to_icc(gi2c->clk_freq_out));
-}
-
 static int geni_i2c_probe(struct platform_device *pdev)
 {
 	struct geni_i2c_dev *gi2c;
@@ -1199,6 +1183,11 @@ static int geni_i2c_probe(struct platform_device *pdev)
 	if (ret < 0)
 		return ret;
 
+	ret = geni_i2c_clk_map_idx(gi2c);
+	if (ret)
+		return dev_err_probe(gi2c->se.dev, ret, "Invalid clk frequency %d Hz\n",
+				     gi2c->clk_freq_out);
+
 	ret = i2c_add_adapter(&gi2c->adap);
 	if (ret)
 		return dev_err_probe(dev, ret, "Error adding i2c adapter\n");
@@ -1300,7 +1289,7 @@ static const struct dev_pm_ops geni_i2c_pm_ops = {
 };
 
 static const struct geni_i2c_desc geni_i2c = {
-	.resources_init = geni_i2c_resources_init,
+	.resources_init = geni_se_resources_init,
 	.set_rate = qcom_geni_i2c_conf,
 	.power_on = geni_se_resources_activate,
 	.power_off = geni_se_resources_deactivate,
@@ -1309,7 +1298,7 @@ static const struct geni_i2c_desc geni_i2c = {
 static const struct geni_i2c_desc i2c_master_hub = {
 	.no_dma_support = true,
 	.tx_fifo_depth = 16,
-	.resources_init = geni_i2c_resources_init,
+	.resources_init = geni_se_resources_init,
 	.set_rate = qcom_geni_i2c_conf,
 	.power_on = geni_se_resources_activate,
 	.power_off = geni_se_resources_deactivate,

-- 
2.34.1

