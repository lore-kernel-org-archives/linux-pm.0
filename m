Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90189403B1B
	for <linux-pm@vger.kernel.org>; Fri, 10 Jul 2026 10:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783678399; cv=none; b=udyflbBQdiFS+U5USshbZz8iGszDawzI9zlfI4l2+AIH3UubGflA48KUP69E9AIdiHNbZ41RXAdJHtYAOaa/T2lXaa8UdqUaYC3LkFEvKwakRJvGuIVRktSc7jrGTtlmSQAaz2Ry5k+wygz3G0DWYuqCyfd1nlaziMQg89VxCVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783678399; c=relaxed/simple;
	bh=jBBnW6WFudmvEPdq0uOwfkuZMk72McbQneZaQOFjN3g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ngIyjPy2rWs1HFZZjJ8ucsWq39yLGjZ5JcyPzG/1ZFwHFUavG3Dv7DSFct5mqZaUOpPik2MXOFjKjf4ZAqhIh+ndXydJe1oUavk2F/c0nuRe8MfpNh2c2eexX6l2bnaio877RT3BigIfV4LcjcTMrEOkQ7GYvdliRPuGVGTQGFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=D7jSSXxD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EMzbeo/c; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="D7jSSXxD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EMzbeo/c"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66A7eIhZ190744
	for <linux-pm@vger.kernel.org>; Fri, 10 Jul 2026 10:13:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bV8KvWCZd21k3Re7nM7YSXO7CD2b03uTu9SGUiG6fXI=; b=D7jSSXxDPyx7uc6c
	4aut/MjSt5s4Mzo56LBaDDp/ojDd+7hkhupviKT2yW+Y4y5ScIXedvmacZ5cOLVu
	Hl1D7tmH/lXOq0BJDf2mps/LWCqQwZjf4K9dHtBamo4Piozxf0RUCBCO1n+OMSFr
	c6vlLOnhnRlFs0dX/yXT81oKdGcygN6KOvBICbI2oyxIeuXEDg2nMZBCgFZvqVHl
	bJJDZq5MYygMRpLo+5rbFcc/QAbYLEDK9Aa4eStt1q2XWBT3cxaoC6l3X9FqbfNV
	B9akTnIkKADUyl2TcaLz/6yYBGRw35WELJtBv4T9pRqdi84DHrmRUhw1UPPEjmqb
	vEOhug==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fas6n1chf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 10 Jul 2026 10:13:16 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8485d853b08so1708280b3a.1
        for <linux-pm@vger.kernel.org>; Fri, 10 Jul 2026 03:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783678395; x=1784283195; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bV8KvWCZd21k3Re7nM7YSXO7CD2b03uTu9SGUiG6fXI=;
        b=EMzbeo/cDv0BIRw1g/40EZVxgzleV0Y/zx34+jVsgj9OKH+qdjvL1qCLBc39v3vLd1
         4s3ltt3IQU7886Ju5Hfy/9v8eQJt8uSwkQNGgXHMHz4pZQG3jwyanl0kxnhpXWU5pCHP
         CiIvYtts0NtqGo3NNPUzOB9uc4MUTaZe8EUjIleZnCMp8mq4sXyAzCGMuIUdn2EW1hZJ
         XkvT0BREfGyPIjLG+KVLiJyiI54Hy0/nyOMRGVdmvIxRZwc9UxGcvK2vn++koReGVMJH
         OVyari5WG9DkdQ8Xb75TbtnthVJSvhQfsMPudFqKKhMwz/X9Knp+xLXmAXNlGsmef6W+
         i5VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783678395; x=1784283195;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bV8KvWCZd21k3Re7nM7YSXO7CD2b03uTu9SGUiG6fXI=;
        b=NnHrCIc5E/m0whloT9fu5hpEXmd8n3OrZA2maXw9+aPm8h0AIoV4/gbbmUy8rsT07A
         pl32mODkb5PtiGe/5018RrcHdfmT1fvLZauPSC1PYrZNkjlClNofRy6xN4pxvB8IYw+j
         iVdOR5rlo86P3TfoGTxj4aAEXSlMm+6fWuVnqNo5Quc5D2jH7JT1WUUSnUoZ7pCZnRSL
         Z7QaI7WdmEOcfY2CCxwSAkGEQo9Y9v8qaXvfviWDoaP+8doxGkeAx3G9NT6yA46gCt6+
         NO+i1YNsuJ6o3QWMkYNqywFoVh4V4nlWibyyj0xkr5KMjv2zuUyCmI8vCq36aQ3QnHar
         /5sA==
X-Forwarded-Encrypted: i=1; AHgh+RrrDAlrUMgjjpM+PK5juh+0UBLlKEF0+ZTQmVb2AjDOU0bPjK76OGd9/qeuCl4tbmCQSX3kLw1TtA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzwuCPkeezc13EE/uohUDADrGlMr1Nu+KOOAFQDnsRnUXbt7quZ
	JUzCnPrbXh/CKNUeW8YJdmbIYEjBA+1lbfbScH45xykzfg/sw6hW/yGhMDGq96drbrFTv9eBTF9
	HcWveNxXH3nEHMkZZXooLoPbt0KIKJLJPa1PI4GYDQ65+tG20LnpiLBBZbufPVoMa9+1EUA==
X-Gm-Gg: AfdE7ckIR+3BnNhIvFWN5R5GvkpvBXK5NSWnyAGR0CwsFak9YW5yI2gX48LuDl4e234
	AXiSltLHLWLnJ6wjNHIWxWcp4MXqf9Ut3xrC4CJHdkHaY6DgNzNgFMVk1AcItJV4Ti0CWuYydbq
	XeHM0DrLfSWWaGseBBheub4D+N9rqSqijyVuU4YPUc9ymh7A/ml72lB4sYmWm5cptGUULxB0BXH
	Evbpj7wOjVNr3MPlx2e/X5oE8KtBMNDxCCfbrKndwwOOO4diBF3uGghS9VE0OKnSgBJuhn8fTBQ
	ZQ2ga0ufYfH3qtA9bU4Y1QhpkNKd2dllbTSGT27kPiaUoms53YVs8m1gWSA8itkRJaEzkI4cyrC
	JmK/GaKN5d4ADbNmtRpnMfr2EMMgH6B0LwrMguzTtrJjl
X-Received: by 2002:a05:6a00:748d:b0:848:4754:28ea with SMTP id d2e1a72fcca58-84847542ddcmr8408571b3a.12.1783678395446;
        Fri, 10 Jul 2026 03:13:15 -0700 (PDT)
X-Received: by 2002:a05:6a00:748d:b0:848:4754:28ea with SMTP id d2e1a72fcca58-84847542ddcmr8408533b3a.12.1783678394806;
        Fri, 10 Jul 2026 03:13:14 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6d7a96fsm9977815b3a.46.2026.07.10.03.13.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 03:13:14 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Date: Fri, 10 Jul 2026 15:42:44 +0530
Subject: [PATCH v4 2/2] spi: qcom-geni: Fix missing error check on
 pm_runtime_get_sync()
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-fix_sticky_-einval_after_pm_runtime_api_failure-v4-2-be81d6c15043@oss.qualcomm.com>
References: <20260710-fix_sticky_-einval_after_pm_runtime_api_failure-v4-0-be81d6c15043@oss.qualcomm.com>
In-Reply-To: <20260710-fix_sticky_-einval_after_pm_runtime_api_failure-v4-0-be81d6c15043@oss.qualcomm.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Danilo Krummrich <dakr@kernel.org>, Mark Brown <broonie@kernel.org>,
        Alok Chauhan <alokc@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Dilip Kota <dkota@codeaurora.org>,
        Girish Mahadevan <girishm@codeaurora.org>,
        bjorn.andersson@oss.qualcomm.com,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Praveen Talari <praveen.talari@oss.qualcomm.com>, linux-pm@vger.kernel.org,
        driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        aniket.randive@oss.qualcomm.com, chandana.chiluveru@oss.qualcomm.com
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783678373; l=2859;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=jBBnW6WFudmvEPdq0uOwfkuZMk72McbQneZaQOFjN3g=;
 b=SSyJjUgoguSeWg251n1KeZRyWrsQz325hAFIge4pglnHKXOmA/4WhEFet02HX4KH0aFHdds4U
 EjWuQGXvQiMA9czhxSLubFt5mAGm9HlMXmX3P8zySnpjyq3aMfxrwsM
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA5OSBTYWx0ZWRfXxI6U6Y3JhDwl
 H9hRpsVoVWfsFz8oalZmAPq/YisMiwTR85d3UIgcf7PLaOT13FlA5ycHW4y5XmKYk5+hlbRvUHp
 mfygYp+hTcuTOM5Yw4wL3HB3ZC4iDhM=
X-Authority-Analysis: v=2.4 cv=DYgnbPtW c=1 sm=1 tr=0 ts=6a50c5bc cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=rPJgdety-6tgKaoqdU0A:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-ORIG-GUID: fOCqG5b28EmzqccNCNmeIhtE61WXPESt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA5OSBTYWx0ZWRfXye83otO8f43u
 tN7qftRt6tjECQ25w4FkjB8Il6PG6l4+mJAgCGTva7BsQ2PTI5CUEDpTtr58Vnm8n5jxovqf0C7
 oFZ8hxhNZ9ZWK8tM1ixZUY5BlJJjcplBOD6lQsPRYkwcK45zr1sLYsUU7sWKNt5R+uAui4bN/Sb
 1CZeP7gRzokv7sY/TSFeZ2v4FJQ/9jHI6NjcA4jMBOifG24q57RLY0ASa5tVYK5Wmaum+IlWXje
 uRMqwCMRO395RiQmMQG1ogtHB0YAEs4z0JcQLRTwXPubxYzeJAxxizwJRLoFuHJDQ10mwY8kqUp
 +CIWbTd8kzCFtS9E6NmuI6ODkxvKRcaCggEHnOFTb1CTXsOQSo24qq/YvtoEU5Quh8eA53yw0m6
 yVpUxfQrr20ShGMYUkIgM3/qy3iMhLCup5eVIHLB/NF84GRmSGZY11sb/0vdoXXbzIsNUmFkcxZ
 3vz3foYIPNwXApdypvA==
X-Proofpoint-GUID: fOCqG5b28EmzqccNCNmeIhtE61WXPESt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_02,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 suspectscore=0 bulkscore=0
 clxscore=1015 phishscore=0 malwarescore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100099

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
Reviewed-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
 drivers/spi/spi-geni-qcom.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index 88ac0833351c..2914d781dbf5 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -622,25 +622,30 @@ static int spi_geni_init(struct spi_geni_master *mas)
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
 
@@ -673,7 +678,7 @@ static int spi_geni_init(struct spi_geni_master *mas)
 			dev_dbg(mas->dev, "Using GPI DMA mode for SPI\n");
 			break;
 		} else if (ret == -EPROBE_DEFER) {
-			goto out_pm;
+			return ret;
 		}
 		/*
 		 * in case of failure to get gpi dma channel, we can still do the
@@ -702,8 +707,6 @@ static int spi_geni_init(struct spi_geni_master *mas)
 		writel(spi_tx_cfg, se->base + SE_SPI_TRANS_CFG);
 	}
 
-out_pm:
-	pm_runtime_put(mas->dev);
 	return ret;
 }
 

-- 
2.34.1

