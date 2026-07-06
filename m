Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3445041F7E0
	for <linux-pm@vger.kernel.org>; Mon,  6 Jul 2026 08:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783328034; cv=none; b=eKAKxuE4QUAqLiDqhQGACBpDEveOVPuk6bxaSSiBi7B53Bn/yl1J8P1HitbHg5tXXLLm6qrSHu0tA2x9SBUWwDhzJeh05ESulhubXUe8szQ2LVHqjmGWXCptVEIH+wFr9LZYXSMMr/it27OJEuCzD/ug+NUd0sPnt+ruVovOWGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783328034; c=relaxed/simple;
	bh=0ufInVUVLfFzq8y2beOLns32ovlcfJNcUR5C24Dtp+I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SGj1p0Cx2bxMnUo9Zkcuc3Z1q+4ChUA01EsoAvnBcynnCkuw9MSZIgDAI6ZHCAa2rxgR50i/6VaROCiq89AY0hB4xYrLVavYhfYrhyNmXmL4rz/oiuwhnIVFrIfbLhDEVaBGsa87wBqRt7RK6IBc0JXbZtHahjiTDy11LjSsXWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=X+SUIniJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=exHy7keO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="X+SUIniJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="exHy7keO"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66684vr54006749
	for <linux-pm@vger.kernel.org>; Mon, 6 Jul 2026 08:53:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3MLeedBrkkia/qCCz/UPFtN7ntKyyH0lh9E88vuT4PU=; b=X+SUIniJ5e76N3KC
	4okub6IeNfLol0638NNvmRBHBEf/yZRoV7W6kmQ3kBZZJ+ReJNEiBVm9nf1zLwZB
	+PpvOUoOg3c4XOwhemASgDzeP+jIikkx4dpfOoPQadY3I+iEGEMGVJS3ElVaFW7m
	up+mxV8NYu5tHP2NWk9ArysC7f1y7gLH3Q+kHeKOtVaqg3fAufJMJEIL2gz4gP7J
	8PcD/NpEjm2KQWn/VkL7/oCY3QKL87d/QHpd44GgyhbUDIXVlT2lHKOzRoSjTwjT
	0C9BC5WVr4cLrm9dMhDKNe8hd9QRxf9qOMoq9xOpCKMAtzzBalq8UoOMqfDgWFE3
	I3BiFg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f88hs86x0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 06 Jul 2026 08:53:42 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c8894570b58so1932109a12.3
        for <linux-pm@vger.kernel.org>; Mon, 06 Jul 2026 01:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783328021; x=1783932821; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3MLeedBrkkia/qCCz/UPFtN7ntKyyH0lh9E88vuT4PU=;
        b=exHy7keOBcznT31dWTDiEPZbv9WEOYQz7Kl2bmDkfFOIEf4RaSn2/ar6P4FY62UahW
         VfG7Q/MGWRoyEJicOTeh1bkBj1aF7bMvFk9+AHem4vFu2QGTbz7MTSexS7oQwfgdYKi8
         o8xQzOsqvN+dlPTAKhFbF8EQIH2Ud10byEC4XlFFrHuExphbtSJZKHqq7Xen/bw0PPSe
         AFxtTt+zimkez6eDEVS1RrAn0ex4AzaU6q/OewqaO94Hwb1Wop1jmNBmSpWJuUsPgEil
         cjGYJ0rhq3ZTnnZ6OcQzGIhYRWLEmXaELO9Kzc6DgomDeOHffvM5Pa9Um6BFjY9V8gq5
         LP7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783328021; x=1783932821;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3MLeedBrkkia/qCCz/UPFtN7ntKyyH0lh9E88vuT4PU=;
        b=Gk1B9uRmTRAYBHXPTA1Kksgf+sV5f0Cz+22gM49p0GAdN/vVcr43gAhWJx0fUUz3Ga
         4eiEF5oBeM08WVrBp6T826gpo91FqDLcAMemHzpyzxjm3uIMpPBShGocjU8TTAwzndDe
         +9MzHbZXw94MuuRboJCU6w3oncz3MMWzfCoZgQsPD+BdZyOLwrvBymeznApDWbU/o7rr
         txRl1A43QdVDdFCa/VkSp1VFfHEgU1ikUI372qAQP5nkIpKXoeQSrhmlJHCfWkm15g29
         Qa0s735+1jyqIgT93iTJMpbbMjYuPiGHdS14Ew+bVDlj57RCBt7ONxmKTWiW3iHuix37
         NDhw==
X-Forwarded-Encrypted: i=1; AHgh+Ro8a8DWG9W8F3XiPKVstzVT7BBB1rBEdfosZCteTDSSyymYu2ZiYY1OSpFiI6zuaUh2zvw2bJsY4A==@vger.kernel.org
X-Gm-Message-State: AOJu0YyuYluvXPQkR6bONlIx+FOlEnIcbdzNEYGQNMAWzNNCFHvoLNTU
	ApU6g+xXykHu0LV6NQKS+ZDeqEBhzyTp27HgeNqnPGINEjSzY423wLvbHGS1TnkZutVvF7je7FZ
	JMGfdl5xMGCC+gURWDiw13lO0pP+75fOen9T6O1iZWbIzmhcnD/H/X4NmsTXqQA==
X-Gm-Gg: AfdE7cmsyHAcWvc1J0YJkgrVf8wZhXuReGZXlOOQ8m1H68fMcU79u6okHWs8sCmqcmp
	yE0q7RynmOaUGpJt9rkbPv5koBojucTrZ9TFN2HJBaDeNGzYqH4JCteou1tcV4AfKApGlAGvoZt
	4AZH4vN3r7YxhAjd2WinZgcaiZq0pnKsieuQATIdagU+n32mpCsP7hJt24HI1ESdq7/VDcQDL/S
	derrXtDGGdsK1kBbImqHr+T07ckNSg38Y1+FulvSBi5lWvHeF/1nxkC4vZy9C7NIY+29wzGPjZh
	E9NumfQiBvZBhEWHUdG3urZNf/Wy8PeFaYMMMjVi92fQ80vhUepHNt3hL3Eca8FHVIdw39N6jx/
	HjdBIkakfNzVTnN6HWn9RAbl9WFeoa56lDgLwSahYvFym
X-Received: by 2002:a05:6a00:909d:b0:829:8942:2c93 with SMTP id d2e1a72fcca58-847f6d6708emr8249565b3a.9.1783328018686;
        Mon, 06 Jul 2026 01:53:38 -0700 (PDT)
X-Received: by 2002:a05:6a00:909d:b0:829:8942:2c93 with SMTP id d2e1a72fcca58-847f6d6708emr8249531b3a.9.1783328018026;
        Mon, 06 Jul 2026 01:53:38 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6b9e12csm3411834b3a.21.2026.07.06.01.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 01:53:37 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Date: Mon, 06 Jul 2026 14:23:10 +0530
Subject: [PATCH v3 2/2] spi: qcom-geni: Fix missing error check on
 pm_runtime_get_sync()
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-fix_sticky_-einval_after_pm_runtime_api_failure-v3-2-92feb5a7b926@oss.qualcomm.com>
References: <20260706-fix_sticky_-einval_after_pm_runtime_api_failure-v3-0-92feb5a7b926@oss.qualcomm.com>
In-Reply-To: <20260706-fix_sticky_-einval_after_pm_runtime_api_failure-v3-0-92feb5a7b926@oss.qualcomm.com>
To: Mark Brown <broonie@kernel.org>, Dilip Kota <dkota@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Girish Mahadevan <girishm@codeaurora.org>,
        Alok Chauhan <alokc@codeaurora.org>, bjorn.andersson@oss.qualcomm.com,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
        Pavel Machek <pavel@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Danilo Krummrich <dakr@kernel.org>,
        Douglas Anderson <dianders@chromium.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        aniket.randive@oss.qualcomm.com, chandana.chiluveru@oss.qualcomm.com,
        jyothi.seerapu@oss.qualcomm.com, linux-pm@vger.kernel.org,
        driver-core@lists.linux.dev,
        Praveen Talari <praveen.talari@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783327997; l=2819;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=0ufInVUVLfFzq8y2beOLns32ovlcfJNcUR5C24Dtp+I=;
 b=Lxpi51lVQh8CfIa0DMGsvzgVX/5WK/vUmhHZ4ROGKQqbLRm7Qj+Ah9siSBj3Pxzi85bbp/reV
 PsSrkkU61iYAUyDE5ufd+3sw/mfgU22Cj97wfFqxnnPNeiq1qCBJbVQ
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-ORIG-GUID: S61LXxKPqdOiIuXvMhOpTpcJeMaDfb_H
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDA4OSBTYWx0ZWRfXyWzkOlnnGSct
 rtwhxd87WQToFXRGe18UknBWSmIJZK+usezwVLXWtUZRosg+YE7OFKNdTMaZffe8t42T2BQmqoy
 3Oxd+fXePzyN04UBBtYHV+Jvlbf9LxWCrNVwx1cdExq9EieqWIA+gzWgq7XcAh0J1iALCUD1bkK
 74sKHKWbBogPFmoxhpw2Cx3KORSPQTrQhA6uVMMSjXm/otiLxh1+zNEcY6mz8TVZEW3mFXlr5nV
 fDAEfhe2WecE8TUf5n7Dqo3YhujVJQQT0O+mn1gikgyJpdN3W8/xnfenrSJZhpg/XWfH06ilgQ/
 cgzJqql0/VTiIwyb11C2KDltEcuOEtMV+PZNnJ3DFtwSHaOb4UjoHYAQB6/ygAsf5RorW8DNpIp
 WWHKsHj1QFiI0kFFSbnjFxp6O/fEGK5tXoZPQI4Dy/fdADGMlTDsmS3fhyYEFnW1LyLxdC6hx4+
 h5UOD7lT9uSY9wyDEzQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDA4OSBTYWx0ZWRfXxVQExOznY1dO
 DdBwGbAoiusseVcaCLfCmHcacHpMjj1OzZJ0tbN/09Znc2zRgvphadDViORijLl3mtiIStZcdfu
 HzPeQM+wuGKXMV1irQBnxELlVEVmCVI=
X-Authority-Analysis: v=2.4 cv=XIwAjwhE c=1 sm=1 tr=0 ts=6a4b6d16 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=rPJgdety-6tgKaoqdU0A:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: S61LXxKPqdOiIuXvMhOpTpcJeMaDfb_H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_02,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 bulkscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060089

spi_geni_init() calls pm_runtime_get_sync() to power up the device
before accessing hardware registers, but never checks the return value.
If the runtime resume fails, the function silently proceeds to read and
write hardware registers on a device that may not be powered up, leading
to register access faults.

Fix this by replacing pm_runtime_get_sync() with the
PM_RUNTIME_ACQUIRE_IF_ENABLED() macro and checking the result via
PM_RUNTIME_ACQUIRE_ERR(), propagating any error back to the caller
immediately before any hardware access occurs.

Since the macro handles its own cleanup on failure, the out_pm label and
the corresponding pm_runtime_put() call are no longer needed. Replace
all goto out_pm paths with direct return ret statements and remove the
label entirely.

Fixes: 561de45f72bd ("spi: spi-geni-qcom: Add SPI driver support for GENI based QUP")
Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
 drivers/spi/spi-geni-qcom.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index 26e723cfea61..392accfd8515 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -613,25 +613,30 @@ static int spi_geni_init(struct spi_geni_master *mas)
 	u32 spi_tx_cfg, fifo_disable;
 	int ret = -ENXIO;
 
-	pm_runtime_get_sync(mas->dev);
+	PM_RUNTIME_ACQUIRE_IF_ENABLED(mas->dev, pm);
+	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
+	if (ret < 0) {
+		dev_err(mas->dev, "Failed to resume and get %d\n", ret);
+		return ret;
+	}
 
 	proto = geni_se_read_proto(se);
 
 	if (spi->target) {
 		if (proto != GENI_SE_SPI_SLAVE) {
 			dev_err(mas->dev, "Invalid proto %d\n", proto);
-			goto out_pm;
+			return ret;
 		}
 		spi_slv_setup(mas);
 	} else if (proto == GENI_SE_INVALID_PROTO) {
 		ret = geni_load_se_firmware(se, GENI_SE_SPI);
 		if (ret) {
 			dev_err(mas->dev, "spi master firmware load failed ret: %d\n", ret);
-			goto out_pm;
+			return ret;
 		}
 	} else if (proto != GENI_SE_SPI) {
 		dev_err(mas->dev, "Invalid proto %d\n", proto);
-		goto out_pm;
+		return ret;
 	}
 	mas->tx_fifo_depth = geni_se_get_tx_fifo_depth(se);
 
@@ -664,7 +669,7 @@ static int spi_geni_init(struct spi_geni_master *mas)
 			dev_dbg(mas->dev, "Using GPI DMA mode for SPI\n");
 			break;
 		} else if (ret == -EPROBE_DEFER) {
-			goto out_pm;
+			return ret;
 		}
 		/*
 		 * in case of failure to get gpi dma channel, we can still do the
@@ -693,10 +698,7 @@ static int spi_geni_init(struct spi_geni_master *mas)
 		writel(spi_tx_cfg, se->base + SE_SPI_TRANS_CFG);
 	}
 
-out_pm:
-	pm_runtime_put(mas->dev);
 	return ret;
-}
 
 static unsigned int geni_byte_per_fifo_word(struct spi_geni_master *mas)
 {

-- 
2.34.1

