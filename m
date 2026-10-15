Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25AD6522EFB
	for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2026 12:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792069142; cv=none; b=ivaAfHGjkKE1WRjGG/9oEgVuETxgbY93vlIfRswaMGlgg8hm4SGE7ilXbhJwi32+Cj8NuGhJqYu4l/gRVmaMI/133FqNBzaPUkxEK/QftRDhI0o2xpbARudih9Q4X//FyQI7yTQgJBVYnjTVHp2NkIbERRDU6wmlDuPErII3m3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792069142; c=relaxed/simple;
	bh=IfB0Yx8qIxej6QlE/yP3xJHhbwTmYhCiqc6qKYoTiIo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PAuDBrYVnTCqi4AMwWqWn1Nwnlo3IandhOXBieQSoB+eARpNJiQzzQO5yFgzGu5aWTFNahxHVoqwUuHpsp7FNGuaNKCJBKyl/DqKmtb9gudT3vqQVbK/XSCsNJSmd+yG6gohNCq5C4o0YSg+uFoYOT45/NjF3VJwX5V71cPpejc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=R33TJxhr; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=djwn+eqv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="R33TJxhr";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="djwn+eqv"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69F9jOPm2114144
	for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2026 12:58:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cdafT9IpEe/qFVZ9tLxGA53KW5ipDMs+AxnCUnfifFg=; b=R33TJxhr9jNjXlaM
	ZlAkymb3LdVxZWYyu5glml/gQFZBgYVAL1WNE/QIabtRi8geFH3Z9ZrNQ0OEMiq4
	gDzfu8E6n4ifDtkycbiC4+DhU04xnLD2HQ/QYeffDKuAh9hPk7Q1aDe7fmF1Sb+R
	e7uanS19PfOB6HLcUzoVaRtAwyr9+qfL66FTNTT0kuHw9RiW4ZRbeku4HCjhYDtx
	nciDCc5oopJHMH+UftFQ9ep42x57wWMhu1ykpjWSCMbaQGJfIU1Sz9XwkH5jN33j
	tQJjA8xjd1hF9UxBzMGWI5gmrRf1/4ngqaX3AuYm3u47SYwyQKiqVR8o/Zy3jae7
	84AQDA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hajmyb4ma-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2026 12:58:59 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2e8ba4757baso20018575ad.0
        for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2026 05:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792069139; x=1792673939; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cdafT9IpEe/qFVZ9tLxGA53KW5ipDMs+AxnCUnfifFg=;
        b=djwn+eqveYOtAeJBlOesUTdhMskTBAHkWM9aYqyxqyMGzvt/D20AjSSdewaqT3ciuS
         akb9X+ijHFO/1AIw3zJvMPDEIQnGYyz+IWl73r/kbRhaj0Eg+cni6HAVy6jcLLsHvMFW
         BbeLqGbHrNdyvH/ah+53/tUKwEuLXB/82Bs42t5MQc3gKJwzQb1KTd+w0I5WmzC+yRmj
         q/iQ0wLuiPM2RwmClnHJqO1U8ww5nvRmQ6ySowEWj0suHCy+C6GZMWOs4JkeOQuCHCZx
         dM1ngaeEfpnDMCYpTJ/ROQehnPKM8ZVljkrjAZK528TcQdQlANlJS3FFcgz+VZPmBKlt
         lVPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792069139; x=1792673939;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cdafT9IpEe/qFVZ9tLxGA53KW5ipDMs+AxnCUnfifFg=;
        b=qvhd+nJYrYh55klQMyqpE+eDILHqa00SEryv/M0fSzKLX9VhUJZC0I3xwSdw3SN9UC
         lSJbcvjv8WvHDmhCEjua8JvjdC3G4UnB1au2pTOlVlqQPRcGWYf/Oi2FEc0VScIVurmx
         5RFuYyvXhn0VwSc/gOsfYTz9NUSCmPd0L/hBFf81XgguOjr406PoO2fOk0/BLztwngPF
         YZuJhQLMuF+Ksm7mYoMaqNhz2bEg8VPTSByx+QpItZqZlmqweQL5Jd6fRB3zdSfZv3aO
         Uxn/2Jntj+fVnCjv04ALpGLQ66nAh+7Xf2Vzo8G71U7LhLyrzNhPMpwxp+ytAvV8zs/P
         6QGA==
X-Forwarded-Encrypted: i=1; AKwUvBxwMh3VW5MuCspL/XgnaVdLFfDTwf7YpFsOAcbHLpc7b8b+T72pSNzZQiwHSJGoZvRxwz0rhg4hnA==@vger.kernel.org
X-Gm-Message-State: AFq9FYIrqSAHTuHjYSmPazC6DcH2/H99TdGkeDCRr7MmnRhdLZ0Qu+2q
	gXRnvFoQew+1qdx+spczzVhYKxTJNvKIEOXNJPtZxgvNTokTYT3/cjiNr73mDW1y/8BALSHTok0
	BWow2D4DAleiF0Xe78oli/tkV1SNcunouAY7wqEcWOklmFQ2p2CQxqTFq8ytecQ==
X-Gm-Gg: AYBFou0L7gBOaSpiyDyKMh2MWZYO7xOWB58R09MfrY+NbMMufklAhYB5hE1tJrc2o8i
	uiOOKEnChKTjGsXsANv+vc17+UxL+isc4MSGpV+4dVH2aRCbYIlIm5h3ZG9bKUM0tt8YWIQC9+9
	SYJCjIO/hzdPP7Wxps5l+XJytxWoM/I+J2BO6VmOZ6DWXPgRgelRsEWITfCf6bWwV0YUAOj9+bw
	a8yeUikHw3fKW99DwdyTCqIt0kgkHOPMI5hBw6zBbKPRGOUBxhgFgl8uII72ERhRqWhhDARh247
	MlJD0X79wE4SH88dEJ/BbMiBRLv5As9LNKwYW0hEOjfo6+g1eC+hgP4tempSciPNUONMjhWEoxh
	CkVmnT5lt98NZYZHWvEPQXH8EpVhxRvuv5g==
X-Received: by 2002:a17:902:e844:b0:2e9:3dd2:a90c with SMTP id d9443c01a7336-2e93dd2c030mr46203625ad.20.1792069138738;
        Thu, 15 Oct 2026 05:58:58 -0700 (PDT)
X-Received: by 2002:a17:902:e844:b0:2e9:3dd2:a90c with SMTP id d9443c01a7336-2e93dd2c030mr46203185ad.20.1792069138151;
        Thu, 15 Oct 2026 05:58:58 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e8422b8d8dsm79691705ad.52.2026.10.15.05.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 05:58:57 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 18:28:23 +0530
Subject: [PATCH v3 3/8] soc: qcom: geni-se: Remove OPP rate reset from
 resource deactivation
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-derive_clk_perf_tbl_from_perf_domain_opp_table-v3-3-5da1096243c9@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792069108; l=1581;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=IfB0Yx8qIxej6QlE/yP3xJHhbwTmYhCiqc6qKYoTiIo=;
 b=Zd6cbJzhVcfg5m7L592QpSVIs3TRLPdOEmoQnflylQwBkeX2I0dQtln64gsDM/IUxq1NCdFzq
 zvQKI9Tl6pCCXzMkBBOYEO0FnTGm8FbKdcm+SuJek/e5nZsnofoLMfw
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-GUID: SueI8fRl9HeY5Ip9Ed3u3vIfD_w_ZgUw
X-Proofpoint-ORIG-GUID: SueI8fRl9HeY5Ip9Ed3u3vIfD_w_ZgUw
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA1MSBTYWx0ZWRfXxHFQt64sGpoc
 cw5377bWkU0flF/PiEs9c/eA1QRMreC4WuRC9nfL69eieDDIr5DigEM0A5oZ9FP4Su/ayKOm84j
 ZrPJyHoH/OGePn81igowOFwwRQ8Iu7E=
X-Authority-Analysis: v=2.4 cv=TbQDJhQh c=1 sm=1 tr=0 ts=6ad0ce13 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=dehDsB7WAhqrwfXEkZwA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA1MSBTYWx0ZWRfX1C9JqRK344pW
 uMubp5/dq4hBowSKbRc5Mnc1CIxTmtS922X598Xy1GffgA9wR0Chc3ryr7K/gCvRFgBF1HbqIPR
 VX+LUWQhMeqNz1C+0esAeBJOjmFfKxZipQKeBs3YKdWR/FIJrDyqy3kgXM7SVIQm6PUvcAekoYu
 QlJyr47p/wvEq2yWVhU6qzpkgtP9akFtFh1Bt7ok6Hk0wsbIDdSSJZy2an0Ny1lyVQOunjYCf0O
 m1flmPskWmXqKP/Hvyu3lcS1F2O93UBIWNGLq/XzAfc9gpr59R457xF/av7UQZ4akAlGe2SScBc
 4uG3SwABOeKYQYsFDh4pcPYAPV0uJGxUiMvAw33fjN2K8EPdlz2gv+fZa3kbMjJDdeKxok4khI6
 IqQRgpy7VPcI10VBmPLidKqLkKlMBLaEfTtufE3O4ElhGu3IKJCOr9Mada2KWAVuENyipAVD/Qk
 JG84CYqf8TSPX63vyRQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 impostorscore=0 phishscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150051

Remove the dev_pm_opp_set_rate(se->dev, 0) call from
geni_se_resources_deactivate().

OPP resource management should be controlled by the consumer driver.
Additionally, clocks are already disabled by geni_se_clks_off(), making
the OPP rate reset unnecessary during resource deactivation.

Reviewed-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
 drivers/soc/qcom/qcom-geni-se.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/soc/qcom/qcom-geni-se.c b/drivers/soc/qcom/qcom-geni-se.c
index 97905bd6d363..6163c19c6cf8 100644
--- a/drivers/soc/qcom/qcom-geni-se.c
+++ b/drivers/soc/qcom/qcom-geni-se.c
@@ -1043,8 +1043,8 @@ EXPORT_SYMBOL_GPL(geni_icc_disable);
  * geni_se_resources_deactivate() - Deactivate GENI SE device resources
  * @se: Pointer to the geni_se structure
  *
- * Deactivates device resources for power saving: OPP rate to 0, pin control
- * to sleep state, turns off clocks, and disables interconnect. Skips ACPI devices.
+ * Deactivates device resources for power saving: pin control to sleep
+ * state, turns off clocks, and disables interconnect. Skips ACPI devices.
  *
  * Return: 0 on success, negative error code on failure
  */
@@ -1055,9 +1055,6 @@ int geni_se_resources_deactivate(struct geni_se *se)
 	if (has_acpi_companion(se->dev))
 		return 0;
 
-	if (se->has_opp)
-		dev_pm_opp_set_rate(se->dev, 0);
-
 	ret = pinctrl_pm_select_sleep_state(se->dev);
 	if (ret)
 		return ret;

-- 
2.34.1

