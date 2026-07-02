Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73823D994
	for <linux-pm@vger.kernel.org>; Thu,  2 Jul 2026 06:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782972545; cv=none; b=pHITIfFpCH2nf8Y7NIrc36Hnd5NThZZde/ODePHMLCDmHDE4mBDRPoOFEtLp2Cp/MZuXjBJOkDWSYvrkGsWRWN7BJ+2MpCxwVav6fIu5qMuNII9VjIPCdjWCCL3bqTJ7gnonj03J5xZyuCti9eWwRN/er3lnrroM5qWj6xF73YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782972545; c=relaxed/simple;
	bh=CxSDGrGNPrn/f5+nMWjh2s3LE8mRw+4kULPIPcanjEs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RwcQPM7zfPWfvx+fwfusucZNlCSljAQAJCGv7ySzJ8xd6N9733G51/aJWTdMMyLUM8Twusc2UGqL5xGO8CxehpYlWX2gDuhLzbSm85te7SmSjKGK5l4k10jn8RmCOadNaK4X+sJQyUxzRxKENyEd1VhVQJ7KuN6fdq5NHDRg6LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JifBqT1L; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fxLgeSFG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JifBqT1L";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fxLgeSFG"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6621KSP62957685
	for <linux-pm@vger.kernel.org>; Thu, 2 Jul 2026 06:09:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8y6oQ4O1PrHXWEquRWNJMTThi3u0P0It3nfZ4zz+tEY=; b=JifBqT1LvVgFjwZg
	ezTrDVhyLhJXX0QuF0ziavDPerD7oq1/rxigVFJ3V/IsEc8moq1Xql70d4lHeZOF
	5xlVUPmeITaDF0rBHy0P8qnPbStKJFfllGCs31+YcHATSBAZyb2GIpueIc5FcX/W
	362dAIlDQMajXB5ARtP5IZ49209SfUoeMiQKn8BMWa27+5NaUbil0A8OvL4c/e0F
	sTJcwolybOFXr1aDsvYjmmVZvXIrqfr1lyV4VuoR1J9OOzK3kl+Je4ZihUqo/C20
	dE0iKz5mOPV7qnnYJSViXYzswGNUzS9h+cg97m55Skj7qSl7XujW33y3yeICD3cb
	mf4YHA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5630aqta-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 02 Jul 2026 06:09:03 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2c79e5de32cso17523195ad.2
        for <linux-pm@vger.kernel.org>; Wed, 01 Jul 2026 23:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782972542; x=1783577342; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8y6oQ4O1PrHXWEquRWNJMTThi3u0P0It3nfZ4zz+tEY=;
        b=fxLgeSFGnJYFcFqTLlxWheonIDSdpk0k7OnBi0JFEi6VLai4/dHsE1OSSp21bi+htA
         GNH8c7diZZ4W6Lfhy81Arq6lE9ra/6C/tOU3oUTP4eS6ImFJ+jRj7zZo7rJM2IGSAuuE
         hDyWTCdh99RNwSZnTYduWAuncxj4cKE7JXvseyACdLcxeuo703ZDMPugPnG90gQjoSdc
         5azqu2bIfqaaAmewbvbkFNVbaobFBhvl67d8y7SuScZgSrZiyF90xvA/DaTq3sjTpPi0
         ks1MTKdj03gU/a+kVW9GwIGsWjEeR38uTq0qp1QkCzba8e+OOdlOdkk1iQXHujGnuLPb
         x2/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782972542; x=1783577342;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8y6oQ4O1PrHXWEquRWNJMTThi3u0P0It3nfZ4zz+tEY=;
        b=Sy5443NQwvo0vDeD3IFiTOgNf1vwz4KehkbnZ7xxCh3/F3wUpyZ33TRHaSRfs6yT9S
         Aq2c7YZBgW8oRMnbh1uyF5eA3D/fr2tAI916191fmb+WrXu/CMb9niL9DBv+3p8D+VFc
         ORdraV8qGnCQlsrIUCN5QDHNg/U43aaxzP4RT8ETwZCz2A/EvSpV/U3d7ZMrhQYwLJAi
         UcqF8AU6mjFK0Ged9DZz+6hsPo7xlXGv87Hmjh163jr5/N5Zn/1a/Idl5+LmD5X/SJv2
         g7hsONTveJJmB3+ySUGB/4OcB9RhKfkSc02L3SzQ9O+I9k1Hkl77QEwHoFqlGeHI4Up5
         rubg==
X-Forwarded-Encrypted: i=1; AHgh+RqhjZzWUDTBf7v8R1zIyPlwlp0DSWO6SIBXuXzKGQ9kTj8S4vi//9XzvVVKMszL4KCOhh3su+wNbA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyJT7iUMtwp20TldsbJiAkgTrQqREywCrCF1xOZKDL6n9ZcQF3F
	e09Cifhxs1v8aAh3ZC6bSaiXc7i2ZTh5YAkKWBtE1IamCBlQo2+HVzTiuksSVUkMPPGzu8Jc2iv
	x5xiD5fZbTrNmTx0+U3HfxSn/VOmV7qJz2mZf5Dbi9Z8UfTCRVizoC3e+2P2Ynw==
X-Gm-Gg: AfdE7cnT+9d3JycDSa6rXdy2IP1YJqI0clx+do+2lqkimXi7yyRIa8LDFp2RPyhLosC
	VKKFto5AIdEEF9SCdIib0IFl7g6GCrgv3S7grEq5zIslxZGjxd5X8OzOnyavyqnsF0cZh9YvuvW
	ZT7vSWvnkkcDR599kyAmUAZRaz/jUsI83N3bpoFXhM/wGP+phg+96/vjOimfOshoIhxPx3+Y6xK
	JuMUPzK4lMlHB7RWIjss/oKUAT/4gPINAy4LJ0oBkFe168P+hRb3d7ymFh1rQoAnkNWQrVHlTq9
	6Ilt64OYTZx8X3xqQ8EU76XmUZMv0XI9dlabtSUqHOLx4flxv4PbDw5pgXfgAus3JArrKhS2R3w
	lbbQAAMtwm4PvOb763SD7O7acxrICQkGwCxAuO9Po3BtQ
X-Received: by 2002:a17:902:ef08:b0:2c9:c517:d078 with SMTP id d9443c01a7336-2ca91206866mr36377105ad.36.1782972542458;
        Wed, 01 Jul 2026 23:09:02 -0700 (PDT)
X-Received: by 2002:a17:902:ef08:b0:2c9:c517:d078 with SMTP id d9443c01a7336-2ca91206866mr36376615ad.36.1782972541758;
        Wed, 01 Jul 2026 23:09:01 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ca9aa00970sm8176325ad.71.2026.07.01.23.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 23:09:01 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Date: Thu, 02 Jul 2026 11:38:22 +0530
Subject: [PATCH 3/4] spi: qcom-geni: Fix missing error check on
 pm_runtime_get_sync()
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-fix_sticky_-einval_after_pm_runtime_api_failure-v1-3-6ddc317011c0@oss.qualcomm.com>
References: <20260702-fix_sticky_-einval_after_pm_runtime_api_failure-v1-0-6ddc317011c0@oss.qualcomm.com>
In-Reply-To: <20260702-fix_sticky_-einval_after_pm_runtime_api_failure-v1-0-6ddc317011c0@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782972515; l=2738;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=CxSDGrGNPrn/f5+nMWjh2s3LE8mRw+4kULPIPcanjEs=;
 b=6Jd/edVSwto4JfXJn9C1CNeP3ZrYJorVj/+lQfjhM3eBpq7nj9Sz64curfgbvFcomrkaqnKAs
 rSW0rF3e78zASWzrMeaF7WeA/dMG7nPpk91R20jLXdbcMAIESp4T/c4
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Authority-Analysis: v=2.4 cv=JdiMa0KV c=1 sm=1 tr=0 ts=6a46007f cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=rPJgdety-6tgKaoqdU0A:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDA2MCBTYWx0ZWRfXw2zw1v5sx6Ay
 jnp5n9NikFO8Sv4hub8AGHJM4poaWEhX3M2xxdZyBrOzRuIYCmt/dTex8pGrrg0wGHOnOcY1BRm
 yduo7dF7PW3jPq2fUUKUxUsGorw/Qzg=
X-Proofpoint-ORIG-GUID: Y2FGZfiqhWLWn6l_8ou4ipnW8t6TA9XK
X-Proofpoint-GUID: Y2FGZfiqhWLWn6l_8ou4ipnW8t6TA9XK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDA2MCBTYWx0ZWRfX9CkFBeLylivO
 7FJdDdDeo8DgmfoIsZEtQ9rp6KmM611ghoCQESHLWKgZLjBkNB1lP04Ds58ig9q74W0RqFDJEM2
 7xUAgoHI8It2lm7/QFBZT4utud4sRzfQRg3uGTv9je7BjRf9JGDJWm1zYr2ghDVf8zNoAEazjpL
 lDqTs0bUzAcaKMUK4KEOc1vBwx74V73vgSqzLyhOM/Z3gcQF/A5Ui+/r+X9vtTukicrweM5qY8O
 ioFLXwqkoJLLTcdmV2BESO+X/6YSV9jWcvWzlZ83KUTHeSquiXotMFPtLlBX4FExy1Zg44ug2mz
 v6E2uCC35UKJy4kJRioqPkrB11tY0Z3bC6GVC7V89ih77OLdBnhNrKCeGmevHiMsu1BpXw9JRDq
 jR6L70fuJUkd5+LMQp1lmpDWrJeIrAvrYTVZSGaOcoGTrWEMrDyFZHk5NvNIkIqWGm9giKeWNxo
 rGgEJ0aBM7KGEzOO+cg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 impostorscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 adultscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020060

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
 drivers/spi/spi-geni-qcom.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index 26e723cfea61..a55a3afc0ebd 100644
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
@@ -693,8 +698,6 @@ static int spi_geni_init(struct spi_geni_master *mas)
 		writel(spi_tx_cfg, se->base + SE_SPI_TRANS_CFG);
 	}
 
-out_pm:
-	pm_runtime_put(mas->dev);
 	return ret;
 }
 

-- 
2.34.1

