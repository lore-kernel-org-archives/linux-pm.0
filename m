Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144DF4C0404
	for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2026 17:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787853590; cv=none; b=sdsrGYrJp0xebTIYPT4tLqEIZxGm2F4vJ2Qq9h5sryXVZsSVl7ykxNrs2H30D9FMQv/UHnGHNFN8elLhhpSoA+76LTfXroK7P2UXCVUKA8wolSs81gRiOVgzFIESs7Q0GkuoqfwwKhs1gwLo26+04enLEc6ekSDDqAosEFUkgHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787853590; c=relaxed/simple;
	bh=AdwimWmojgUMjxZge10azUFM2Iq4ZF78vSGW37hlcsY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j2JqJQoj0+NwV9MqfjPQ3NP4VNHoTJElk8oz7BaIdqeWObqYbPK0LoJMSmwliJNjLamXRYFDsQ5i+dNiC2mMFNiECac0pT4fOnBbA04DfeRCgDo32VMqofxUlPJxstdpvilAWu1Irhgi4qvtA1MzuoNgjas5hSkk2j/zD2Nxigk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XpmrNDUr; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=U4HjNyu8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XpmrNDUr";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="U4HjNyu8"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67RHXkCa419885
	for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2026 17:59:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iqu+QcbOtbM8Rimddb61w33ixiI0vj6whMYuEwbL0po=; b=XpmrNDUrTP07n6Om
	zBk1IGwXBnu3yb6XzL2oGK7gsqtUKCn6hDgZyCHHa7L5FhB/hQj3Nv1jb7iQrrzc
	1sA39PPj2avc4zoUd1+AqtAYOghG335Xec0aadP6pH5ylM8IGqxx0bk0RBuHe/Mq
	NF0fQaRf8nWdCrOLWyg26rbTv8CuOBxtiZdh6oYgIFPt59lqWaywE0xV3iZHd3gN
	4rBZGHoAKI15tzYYyKgx2xn/UrNbV9pI8hrrENjTdKkKlMkXS17y8oPLCKY5Uyn1
	rRQ3sYupp9dbf2YMGE/xvwJNkYee1Turn3TvMRFnAc4w4i0aFS2qk7W1BnZ6PInG
	YwQBDA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gagjftpqt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2026 17:59:47 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38e4758ab46so393281a91.0
        for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2026 10:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787853587; x=1788458387; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iqu+QcbOtbM8Rimddb61w33ixiI0vj6whMYuEwbL0po=;
        b=U4HjNyu8rrZVc3jMyBDxEn2O0251uvAUIHfJ9WifGgtbUTfTcQ5xM8Uf9cA5FsSvPh
         PNnkpmtRWKpvlBKgSsAILSrzchzdeSx6lAMiaV+fPaE89l/eE2h+vC65rk740rItWQSB
         yl8DiRjB16WKzCbCLIDLn2NxaIpRjKCK4l7oFB3t7M3uS/RF4A2C2QU7B+2CnDYuXsN8
         4JqhA+XLbKO80gqqHeNfiGwLJ3KqFC/Cy2HPrnhjlJY9e9anC8PVkGJI9YLYGOwegoAU
         I3qIRNk+YpCLkGQKadxXLj9Nf2cOvmS4bn2suYNOMa6hYxHr1jt58v8Vyr9VylpHS0Mh
         azAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787853587; x=1788458387;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iqu+QcbOtbM8Rimddb61w33ixiI0vj6whMYuEwbL0po=;
        b=dHQ212B7zgzbA19StHMxpJj46T/SbXtdcsVejNuluRHFlPRSiF9Z4B6Xlx7L36dek/
         7KPi5EbsB0tzih7paOtXUnneFbpJTXT9KmD2QwlS7fvmVLP1M6vqtI/Xw0cv7cBsY/qj
         c8OfI90/NB9zlMdKwzCx1eYVp9fKotKH1fOkW8GnElKdopcqzbKLYtOOxBcNwRm2EKTv
         KMzt1XBD1R8htZkqAxmwwRyuRLbGUmeE6V4mTVcRiSFzj2agg6KH8epmj6Rf7x4VVOSQ
         N9N5ofbYn2/kticsF+7YVhjgaU8qsO7wbTsso0um2RNanX1lUlGQyVuHuN8aocito+OP
         awsA==
X-Forwarded-Encrypted: i=1; AHgh+RrF6GC4J8sfCm1ylEnFSa+tXgJo3fr73QLFNSLR5a3ITmku6VmWrto6/xt3ozdfFrYhNRavPq3mrw==@vger.kernel.org
X-Gm-Message-State: AFuF++lSCSwL8/qfeQl7+8n4mtL46Xez1KtsICwrOZUnHf80OetXgf86
	BwEwRC4TmYLYAuVtt5YBQmNaZ7SmEJSY36tcdTzCyo0fGsQGX6J4Vynm2/G0jq3Xmb7NCeGEu4N
	BFQQNtOL+A7W8sjfqit7MFCuLtz2RjF66xOHQK0K6QTivMek3/Kh11q+I+/jH5w==
X-Gm-Gg: AR+sD12xrYF1cNsZrFNzZMxJX6bYxQvaidwOqb8PD6U45CwwsGUw3OHfgM/5YzaBSVD
	ajN3U2m+y+yBVwF+syUDH3u86ik9pBCmolv31vjLTifWHsGCImcEl2pIgW5FzC9aHenXcP5PCR4
	46Pstmuah+/x6jUOGuPIz/VduxrjCt4xPc+oBUPhsVcHJjK8of9rrEX28BUTkSiZ6ucNu2oj/A7
	UrcE8YvLtXiID/206Vp8L4HJx900WCjUvNGliVEV/tTex1i4sfCFjEIfliyVcsZyvsXlspRoFvW
	mb83tfmNBfi+vwovYhgr+SRZtVLOaPThg5+c9xqntFRiWmqQZvG+kxc8jNHsSW55BEn39H7bND0
	WMGxhdJes2gKwW/UtKqY3mLIISDiMBeef/w==
X-Received: by 2002:a17:90b:380b:b0:380:f85c:94b4 with SMTP id 98e67ed59e1d1-396d0f2391cmr1736497a91.7.1787853586851;
        Thu, 27 Aug 2026 10:59:46 -0700 (PDT)
X-Received: by 2002:a17:90b:380b:b0:380:f85c:94b4 with SMTP id 98e67ed59e1d1-396d0f2391cmr1736384a91.7.1787853586253;
        Thu, 27 Aug 2026 10:59:46 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141a905cf38sm27437523c88.12.2026.08.27.10.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 10:59:45 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Date: Thu, 27 Aug 2026 23:29:19 +0530
Subject: [PATCH v2 2/9] soc: qcom: geni-se: Populate clk_perf_tbl with SE
 source clock frequencies from perf OPP table
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-2-091697dbeb02@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787853566; l=3349;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=AdwimWmojgUMjxZge10azUFM2Iq4ZF78vSGW37hlcsY=;
 b=xDUNaR1wqkINGiOInqWE2jn/v+OQHLBDBZ+Fh1roliGz9vW+grwzgz+g46Wp/y3TBYYP/MmbW
 uAIRm9TQvphA1WS8qhacIvgyjp2JvGqodTTkFyYqG2IdHsmXGD2eSj6
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-ORIG-GUID: l4QRc6gA5cqmfpJqJsp278HSz8uLKYX5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE1MSBTYWx0ZWRfX8OgvSjEDGnQW
 8VqCqwTx0EB7GXjgTR+fqdeCLsM2+KSk/zw7muLL0T8D6g4XkvxXAN3Q2PKSQTOiqjQ9rVmX2J+
 mq/3KSjzsPq6ljecxxcUhVwpqViD1epoW1kIHtiaMH2ylOZS9G7cjExdiFH1AheqAbVBLPKeX8g
 QqZ7cWYC2/bLSAbglvslHGrp16LWAnoIBUh6/ghJlSXx+SWi8KWIa/6A91ZyVNf6EB5w9yKwDpw
 Bu2tNUFJYLbZq8A+Yct+Ena/N9WvaWUykJu+scEO/+/Iz28fOUgdvk7dLvlRSE9Y7kJz6IrFd71
 Q9Xh+gibkLVMdSUZ/MX/SX51UF1yUb8WAMMF1KhQ+SBVzw1MwelWIaFpso0weJtlucZzwpPVkUN
 n7xuzI1aLyq4AskuPbQuo75yJqzzpVXFgdRnx49zEG6kfR0ENtdznrEOQh3F9WfEy2ESowkOjHi
 0N+OO8u18E+/YY2A4og==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE1MSBTYWx0ZWRfX84o1FGuxnzHC
 1E/z2vd/JO1dyqK0kLnjYwZfRUF8d/Bjd71c5h8WSBFoGPYi1Kf3196SaxnLYYhCm7KXCtF9KNR
 Xz54oKO4QG/WaOvgW7XsTQS1VLKjEOk=
X-Proofpoint-GUID: l4QRc6gA5cqmfpJqJsp278HSz8uLKYX5
X-Authority-Analysis: v=2.4 cv=dd+wG3Xe c=1 sm=1 tr=0 ts=6a907b13 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=CVJBOM8IPza3kUTEG1YA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_07,2026-08-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015 bulkscore=0
 adultscore=0 suspectscore=0 impostorscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270151

Currently, on the SA8255P platform, protocol drivers attached via
geni_se_domain_attach() treat each OPP on the perf domain as directly
corresponding to a protocol value such as a baudrate or requested
frequency, and simply request that OPP via
geni_se_set_perf_level()/geni_se_set_perf_opp(). This does not allow
computing a source clock and divider combination for a protocol
requested frequency, unlike the Linux clock managed path which derives
this from se->clk_perf_tbl via geni_se_clk_freq_match(), and then
applies the matched source clock frequency with dev_pm_opp_set_rate().

Change this by treating the OPP table exposed on the perf domain
device as representing the actual SE HW supported source clock
frequencies, the same role clk_perf_tbl plays for the Linux clock
managed path. Populate se->clk_perf_tbl and se->num_clk_levels by
iterating over this OPP table in geni_se_domain_attach(), so that
protocol drivers on the firmware managed (SA8255P) path can also use
geni_se_clk_freq_match() to pick the closest supported source clock
frequency and calculate the required divider, and apply it with
dev_pm_opp_set_rate() the same way as it is done for the Linux clock
managed path, instead of relying on a direct frequency/baudrate-to-
perf-level mapping.

Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
 drivers/soc/qcom/qcom-geni-se.c | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/qcom-geni-se.c b/drivers/soc/qcom/qcom-geni-se.c
index 873bfbd6b2b7..447b9cc6babf 100644
--- a/drivers/soc/qcom/qcom-geni-se.c
+++ b/drivers/soc/qcom/qcom-geni-se.c
@@ -1155,7 +1155,8 @@ EXPORT_SYMBOL_GPL(geni_se_set_perf_opp);
  *
  * This function attaches the power domains ("power" and "perf") required
  * in the SCMI auto-VM environment to the GENI Serial Engine device. It
- * initializes se->pd_list with the attached domains.
+ * initializes se->pd_list with the attached domains, and populates
+ * se->clk_perf_tbl from the OPP table of the "perf" domain device.
  *
  * Return: 0 on success, or a negative error code on failure.
  */
@@ -1166,7 +1167,12 @@ int geni_se_domain_attach(struct geni_se *se)
 		.pd_names = (const char*[]) { "power", "perf" },
 		.num_pd_names = 2,
 	};
+	struct device *perf_dev;
+	struct dev_pm_opp *opp;
+	unsigned int level;
+	int num_opps;
 	int ret;
+	int i;
 
 	ret = devm_pm_domain_attach_list(se->dev,
 					 &pd_data, &se->pd_list);
@@ -1175,6 +1181,31 @@ int geni_se_domain_attach(struct geni_se *se)
 	else if (ret < 0)
 		return ret;
 
+	perf_dev = se->pd_list->pd_devs[DOMAIN_IDX_PERF];
+
+	num_opps = dev_pm_opp_get_opp_count(perf_dev);
+	if (num_opps < 0)
+		return num_opps;
+	if (num_opps == 0)
+		return -ENODEV;
+
+	se->clk_perf_tbl = devm_kcalloc(se->dev, num_opps,
+					sizeof(*se->clk_perf_tbl),
+					GFP_KERNEL);
+	if (!se->clk_perf_tbl)
+		return -ENOMEM;
+
+	for (i = 0, level = 0; i < num_opps; i++, level++) {
+		opp = dev_pm_opp_find_level_ceil(perf_dev, &level);
+		if (IS_ERR(opp))
+			return PTR_ERR(opp);
+
+		se->clk_perf_tbl[i] = level;
+		dev_pm_opp_put(opp);
+	}
+	se->num_clk_levels = num_opps;
+	se->has_opp = true;
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(geni_se_domain_attach);

-- 
2.34.1

