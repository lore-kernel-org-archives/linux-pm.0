Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1562037998B
	for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2026 10:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787826996; cv=none; b=JEwIKTq2l8gmg2Hw5+xxzW+1Vpj/1E96SawBVPkDoWllu3OEEU0TirZccKh5FeGf0X4TWpJhatMuYb6PleG9JwQn4tAntMmev5YdvxfdMJtJx4jeS9vSfthFcWdSa/bgptwDA7Dnllk0n51tGBqSSsZWoikTb2MRJ+ma07yjDcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787826996; c=relaxed/simple;
	bh=R8NdFiTTELsNPWU5Kfh3V0If350yDqkrd80DIpjhzBo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j7di2biaq7UNlUfb7baqx8EyyvG5LdJetzikQgTz4s3axYiqj14kTmKivV3US4hjNgTABFOB7uj2b4SNxPnYVIvbgQeAOWH5L1KUt60dx+B4g4DeL6FgHQRG5gIZ7pW/46iZpzm+w0pEvuvBOAIhrXnSTPJd2D3w3PUTlTrEQlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OOgPKaVk; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VmIieSEK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OOgPKaVk";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VmIieSEK"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67R9I6Mq2462491
	for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2026 10:36:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=49BmMEhz3FqoDnV6VvO1AkxNDAyy7o57JLC
	z/BedGoQ=; b=OOgPKaVkAxVfVboRi0fJHNcCevK5jbr/9SFhmGMyWJacehZ6gRk
	gUr4t88ttFd6jyicMhKxFv7LvqeztWMGst4sK72y6hX9z190lNyyCQ5/FtZ8LV9U
	nv1RPHc2bjDldsooc7eyPWIHMQgVGxZP+6vx8F8+UWWqD+Y9hwL8+7XeMmOyn523
	ZxgGF6QNdJD2iZ8cdwBYJ6kYy1drfQDVBTFM1dV56yuwSgIjiQKzbLVXWeXZeSGz
	MqZuwLIBBG9tYWXkYCiRAECerrMTPqMN1hTpkadlHLZ5KUWDEJkz2PjmwqsK4jJa
	2exqHdD+qhwnVox+yKLDrwYtiNewA2Tq6Kg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gaa3bj41m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2026 10:36:33 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cbb467e56aaso521518a12.1
        for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2026 03:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787826993; x=1788431793; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=49BmMEhz3FqoDnV6VvO1AkxNDAyy7o57JLCz/BedGoQ=;
        b=VmIieSEKbPzwWKawSNnGX/I0sf1ZRwzyGOr7oD4XS0YZzive235W0bSXkihTgvCUUa
         uS+BrCq+7tvdTnp5JIBfSyA9gnCQHfkPIYr6e7ZGWMVhsTdUu5SBTfMS2R4BvIn6y0aF
         W44sPzPTmcUrColLLMExaz8gwjwQKe3sjPVP87nHPbmyCwjZcdWV6Chmq4ZmOSLw9rBo
         pHpklruhG3ztBQpqk+VjxGY9XWQ5vkJerOsxKFSL0vQl1fxE8tx08RyxZ8DmmnrcKnUp
         k6pMpQ3ONpyhwA9ndttOzY+vaIyQeA/gGfwx2G3O7sh1ll8x2VjF0jNYuLSAFZtyw6m7
         OIFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787826993; x=1788431793;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=49BmMEhz3FqoDnV6VvO1AkxNDAyy7o57JLCz/BedGoQ=;
        b=MUo/ifrDrq6VGq0E7ThoBrrLEuNVQcAeKMK+03iP7ZS4JI33WpFR4VWrDeyTAJs7RH
         y9X+NgA8a1mhK93M3KQ1WOqiYzdh+XkRfbW37KMrz3RGNUmoPpp+jC7/BKHOaqd0csyK
         hILvtOixJylfmrpOvdP0JnRQQ1WIz0DJZJqw3XDsyGm1y2s4vlpSIYFnMgIEVlrCWqpF
         ef7EGVqMpvWJzdYqSCnmEfLnzDN1lldfs5amH8XoKLvhuYKUKSeb44l8HD4qXXUv3etB
         XOPX/MTtp6MNhXT4ATLouxnU5SZkgFttBkRAtU49RLMEuYuTjjQAOD1Oma8RhfzE0d3D
         3JPw==
X-Forwarded-Encrypted: i=1; AHgh+RpptapdVhHbL7D3vgNnboPvlTsJckpA++6OC3SZ5ngzddSiYWevPeg6GT7Qu7SXEc++wFruRzZhpw==@vger.kernel.org
X-Gm-Message-State: AFuF++mrNnSQRea4CArkcfMoWs4LW/ypMug574AvQwtfz+4/Tk7pRrBI
	TgDEDgDrKf+fOUjm57fx4YZMiIjjZZJOyEpfT1QohaIJKzsMAKJWQDGku5eT/0VdaZLrnHNS5sD
	bhGIazS0JHnLg0J25iDXHkn9d/PE9tvKofrUsv8ILzHuY1EOz+Iyz2AUE9JpQcA==
X-Gm-Gg: AR+sD13wHzru7x0Uh3002Cmx7UITcO8ik8glmZFSPaIfh3XXMmWPdlwsx/uM+PItAcA
	ohF1lgQJxzTxwAK0cw2CNE8EmDOmmqtSriNoNYT84BtaA1vh6K7VaL0b2qrprmRCdT3IwIzcc4T
	9jt7FSc5A3Dou1p6CGCEWc7hwxrzlbWwueycbUMl7KIPAx/DUiNtSzcx921hTwuUII2HGXv13V8
	CNLbbXy/l2hEnWL9J54YHKU+OsWtADnTQbrHyFGmX//Ply7aaEheA551b7dAfiKXUliFGYUdMXh
	tuIPCi8pjuaH2ia0onG8u16xKZBfS77IfI1er821xWgbZz/4pZd6CyfumNk+Y5jRK1jg5/xmIMx
	HtNDNynUBnZNhXgnZxH3dTvaW8AA8XbuGsAEP7yf857p5idkiLX49O2phVav5
X-Received: by 2002:a17:903:46c5:b0:2cc:9179:335 with SMTP id d9443c01a7336-2d707a5d142mr256847335ad.8.1787826992887;
        Thu, 27 Aug 2026 03:36:32 -0700 (PDT)
X-Received: by 2002:a17:903:46c5:b0:2cc:9179:335 with SMTP id d9443c01a7336-2d707a5d142mr256846265ad.8.1787826992414;
        Thu, 27 Aug 2026 03:36:32 -0700 (PDT)
Received: from QCOM-aGQu4IUr3Y.qualcomm.com (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3283d9e5fb1sm29831430eec.25.2026.08.27.03.36.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 03:36:31 -0700 (PDT)
From: Shawn Guo <shengchao.guo@oss.qualcomm.com>
To: Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>
Cc: Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>, Vinod Koul <vkoul@kernel.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Shawn Guo <shengchao.guo@oss.qualcomm.com>
Subject: [PATCH] thermal/drivers/qcom/spmi-mbg-tm: Import IIO_CONSUMER namespace
Date: Thu, 27 Aug 2026 18:35:55 +0800
Message-ID: <20260827103555.883018-1-shengchao.guo@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDA4OCBTYWx0ZWRfX776MVwCcYvHt
 L+c5hsqNB//Y9j7s5zGXVTp7Ffq5b+XTJCkH0LmWifpyPRJNpUmoUT/veUUwGs2zTOGBCvB2BRH
 SzR+0jtXRzqImqd4LF13BDOt0EOCEtVgvJrySg1rvP2KIwxRYJdmDf72pZou89P+vwTwY06oiXT
 kjsz4CQro9P0gOSQCyXVSXBYRPOT6EbNP66hEL99oQMnlGUkdm9Lk4hvcV5S+6rh3vCc8tbF3yh
 kUUX1mJnlbU7HbTx4imOV9/uSLSpgpp1RXOeEAEix7CCkRltOoJ8gRlvkC/gPDWxd5F4GjjPfUF
 XnjjwdAcojtCcH+AgKgqSE7F96og9gWf2s+uUAGtqgjdLKy5+KN39IHmO+1UPCNf8Ql69cwEYs6
 yQHGUs0ZpfUGuqwXX0TC+rdx2CY6Xs013BEyGyYS5jNGanrDq5N49e878lXerUBMbaH1bwWc37y
 6ReejsuY8nf7eg9+ltw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDA4OCBTYWx0ZWRfX8xUcf4pG876j
 +OMUbANxxetGIIQNBDyshCLjgnHJvfb9ynezQycRa1voJj24OcwiUupx4ryGypMngykHzW/CDn0
 dgGAV64fGhqnlZHIni0JM6fPm8kvyBI=
X-Proofpoint-ORIG-GUID: VOA4pMtrfu_CNAfYrakz4_ygts2hNIes
X-Proofpoint-GUID: VOA4pMtrfu_CNAfYrakz4_ygts2hNIes
X-Authority-Analysis: v=2.4 cv=KbfidwYD c=1 sm=1 tr=0 ts=6a901331 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=4ZI4452vc5jSn75PgjkA:9 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_04,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 bulkscore=0 adultscore=0 malwarescore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608270088

The IIO consumer interface symbols moved into the IIO_CONSUMER namespace,
so consumers must import it explicitly.  Without it modpost fails on
'iio_read_channel_processed' and 'devm_iio_channel_get':

  ERROR: modpost: drivers/thermal/qcom/qcom-spmi-mbg-tm.ko: module uses
  symbol 'iio_read_channel_processed' from namespace 'IIO_CONSUMER', but
  does not import it.

Fixes: ebf1d03dab96 ("iio: inkern: Use namespaced exports")
Signed-off-by: Shawn Guo <shengchao.guo@oss.qualcomm.com>
---
 drivers/thermal/qcom/qcom-spmi-mbg-tm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/thermal/qcom/qcom-spmi-mbg-tm.c b/drivers/thermal/qcom/qcom-spmi-mbg-tm.c
index 0492d5eeca01..012eb2a5f31f 100644
--- a/drivers/thermal/qcom/qcom-spmi-mbg-tm.c
+++ b/drivers/thermal/qcom/qcom-spmi-mbg-tm.c
@@ -252,5 +252,6 @@ static struct platform_driver mbg_tm_driver = {
 };
 module_platform_driver(mbg_tm_driver);
 
+MODULE_IMPORT_NS("IIO_CONSUMER");
 MODULE_DESCRIPTION("PMIC MBG Temperature monitor driver");
 MODULE_LICENSE("GPL");
-- 
2.43.0

