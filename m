Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26BD403EA5
	for <linux-pm@vger.kernel.org>; Tue, 26 May 2026 17:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779816085; cv=none; b=Do+ZjiC4cIgKYOTiktXM05dID7FknfT4BSWqdSSmzGeFm840YmPoWIibdZ88SGOReOYpSbV6dbgX8TCN2OEnfT1boVeuxGB5uIQ1EIW7C2sD/fJYz9ywKEdzFVhx56yIrbNzbBFotuuyNG5NMjmusV3rSB14eQMm2ari30jrpD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779816085; c=relaxed/simple;
	bh=yjG0ZkPea0MQZB8Ro4nwY9C+0MtvN9vUu7BaeyXSwZg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=sSEl3JC6zY1AySWacNmrvv2GVlriI8PHsTB8sHYXpL6DmerCG2sXtqt98iWSuR/ZiVWobj0m/CBNp7sca2Ixr6SnyXlqL54WrSg9X6sUSR/fyEFmPpE6pglAnrmwjlHrtZRc5h8Uh5+wemPpiC6QviYUMQt6CvOryLkqpirK2NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=O/RNcKp0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HhxmCh8T; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="O/RNcKp0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HhxmCh8T"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64QH11IL3289778
	for <linux-pm@vger.kernel.org>; Tue, 26 May 2026 17:21:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=YXwhiw58O1/l3Q2qihgzAE
	f9+dmrEGGZSXucLn4h8Po=; b=O/RNcKp0Ff0VJITtlIWt86SHvPe5nLsD/zWJFi
	ipEwbmm+peJP2FLeGsa4GhfTkJQowVfeUAjMgM1pIL+7YUGFx2f3FliTA724bLZn
	PEbWm6JNVS0EEU1PEh6nVP1cK9D0N0ThoZwFeU6hmsTSsnc/T5Fs+WvOCyuVybaW
	D3lUJUysFSWZv2xZqKtTdvouItwSL1Hisq2ZQa4wogiTW2KCFIGJJdtAli7TtLmx
	ay12rItspVD2Trsr+h5l9xniKxKD9agoRJUMlglt1D6beRGADqR+UmJamQnEBQuk
	YyKEfbtE4mI75a8q0IrCCNtnkFoD26c81nTqIfJmKQRzEVrQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4edf1j880j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 26 May 2026 17:21:20 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2babc42244aso5915635ad.3
        for <linux-pm@vger.kernel.org>; Tue, 26 May 2026 10:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779816079; x=1780420879; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YXwhiw58O1/l3Q2qihgzAEf9+dmrEGGZSXucLn4h8Po=;
        b=HhxmCh8T63rU4WY6W19YXavtGJrA/0PxzYIxsyWZxhv56Xf/JW5JxML+f5ByiyUyo5
         tIPhm8U4fzIIRtU03f4yy8pcj44q4piYb+3VxfE5msFrLN4/pTuo5ctZ154om3XsGQr9
         1eHgTXsZBPZrlgxwJJKVg6EklzIk9A7TipKLpO1nK9xodSGs/nqLOF7Hc67V6K8wOBb/
         EO7FxJQ7k6vUWdeHB8+ItushHNLTtQEPTo3CkGeGAV0qahcfGUW6UVXtwEVRTMf3fpjt
         x8dLUyF81QYGfGeDIXS9DVAXrv1rvILvYsun/oZtn+HB4pSlLITsbbP88n9BTXaVOZud
         mT+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779816079; x=1780420879;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YXwhiw58O1/l3Q2qihgzAEf9+dmrEGGZSXucLn4h8Po=;
        b=TOMy1c/vLw+RslHEV/Ecy47vwlcymfD5au16oNndE0hiqC+0UbZBsqIZi87sPp/krZ
         OKVhy1FvaioUJVZsvEuMqNNUcs5H79IPsBH91oF3CHYjPxv8CMzI3SW5QsZSMPSTKNTM
         DlW45Wlu+SPnNCXgl0ZRb26b2296BvPKIpIexg0Abfara3XBptzTfv2vukkg1YA4V7Yj
         eUYgf1cQb2gcE3++cpjBoB5bRaHD4Heg28UUCgqokE5tJrmhdgo0XnJWYbpGGs3YBS1C
         Hj9ptOM4F3MQqBgVrw6yggmbXQY8i0tFbj95WkeXWe3+vK5u+mSgi1c8wqZNeWVJF0pS
         8eRQ==
X-Forwarded-Encrypted: i=1; AFNElJ/rB07rdlF/QA+P4A3QAR6FgahJf5iQ7zHoxc09iIaRcJwdUtrC5UzaLdOg4KDi5CRXaOexY0Jkpg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzVriaMkFbm3RNWDMJeblxCMRsAT8ikFAtIxX62tJAojTvAmPAt
	q51z0Orn1ngKUy2AWFK2SmiREvA+CxlIL47u/a0gWEdCCY+McYzE8HJX3N+85ZsZ6Qd49U1l6Ce
	ofEwhdhLUO6OVFN+QCbNo5E7VPfQw0DVLPLpspjqqB4kCKOAiNhIxX7yuSP8dOA==
X-Gm-Gg: Acq92OFSPIJXNJXFq02zv2ATCN23Bju8JUEXRGycrJ5DUmg4GZFWaIMcvMRf2lvxxb9
	3MvUswjabJCXGbITcqdZwm3AurD8nzK5fqDcq+XTT8aDhDJ9zJFpW64FKooExtVYtYV6zAJ7AAS
	0NocohYI7mLyGDWfoY04fs/gaYLlUGDNu/JYKzX4omv2WLkgbOddg4Xr4fnK/8cTgzkycUZhj/p
	Hvrd0SkwDYXo+HA8w/UOY1xc3xRcndE3hUROdSPl7wT7ZmnPvtWIiN+czRvZ/VIuaxdfBXwtVXG
	eY5ciJFIyYdlugb6bwkOBaJY3OtPD/j08u0dt8Z1NoL74CmgT3NiJF2kf3wCHsPve9cgMi+FSts
	Gj0BT3C2aTxQvX4ufsdQl7NJDwfK9Mv0zxhyKF5JXqs9J
X-Received: by 2002:a17:903:2284:b0:2bd:412:21fb with SMTP id d9443c01a7336-2beb033eeeamr221857285ad.8.1779816079325;
        Tue, 26 May 2026 10:21:19 -0700 (PDT)
X-Received: by 2002:a17:903:2284:b0:2bd:412:21fb with SMTP id d9443c01a7336-2beb033eeeamr221856885ad.8.1779816078749;
        Tue, 26 May 2026 10:21:18 -0700 (PDT)
Received: from [169.254.0.3] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb5695b83sm120401815ad.9.2026.05.26.10.21.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 10:21:18 -0700 (PDT)
From: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
Date: Tue, 26 May 2026 17:21:02 +0000
Subject: [PATCH] interconnect: qcom: Enable Shikra interconnect driver by
 default for ARCH_QCOM
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260526-shikra_icc_kconfig-v1-1-c589db2d023c@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAH3WFWoC/yXMQQqDQAxA0atI1g5oRKVeRUTSNGoURpmoFMS7d
 9ou3+L/C0yCikGTXBDkVNPVR+RpAjyRH8XpKxowwyorsXI26RKoV+Z+4dUPOrpHTYRlQXVeIMR
 wCzLo+zdtu7/teM7C+/cE9/0BjcEB/HYAAAA=
X-Change-ID: 20260526-shikra_icc_kconfig-97aa253a7132
To: Georgi Djakov <djakov@kernel.org>,
        Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>,
        Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
X-Mailer: b4 0.15.0
X-Authority-Analysis: v=2.4 cv=ZNjnX37b c=1 sm=1 tr=0 ts=6a15d690 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=oqfpOdYIzx1nRLC6xSwA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDE1MCBTYWx0ZWRfX6DEszIx6GwD3
 6DxPsPUI9iRkMu/vFcmxekXQEQWkW8OAL7OGObIIKVPDzzYK0JsJc6JODOxExLeMaezvNFaCVDt
 6DkUeEDn3oydl1V+dg86ZltP143YcJdXtQL5ebHNGpbAPMMnwNvupl8vJek9qxEXa8weF/7MKbv
 zujq7Pe3+mUp9zzqMe18BEyZc3B1N6bGuzkqnDfBM0sPmimWlICuH6jWElDCy9uyJaoNJnCIsa/
 FS+s52v4BInyLMkj8GP7LFQ0SxLbxnjyrD8YABGd1EahhzxPcDJo6UptDvNE9ge/a7eqxy6FPt9
 wGbYl22QDxES+0TtWJiRTRP5+6moPd5flK3sfUr4RaF2CoHJ6EVO/vuLsBFmnPzXSmqKxGcWnrk
 S8F/X2AKe68KW6fRSWkVkqUBpncQzV7OZ7zirmbp0upfdQHjttsS/eq81I80QLpIcjXNAKSQpUR
 t7Luzfiy6aWeqpDP2Kw==
X-Proofpoint-ORIG-GUID: kBC6plzIJnP1gjgFxKMWH4aQ7heVR0ud
X-Proofpoint-GUID: kBC6plzIJnP1gjgFxKMWH4aQ7heVR0ud
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_04,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605260150

Interconnect drivers provide fundamental NoC bandwidth management
required for correct system behavior. Although systems can boot without
them, power and performance are impacted.
These drivers need to enabled irresepective of the board variant, design
or configuration.

Enable the Shikra interconnect driver by default on ARCH_QCOM by setting
 "default ARCH_QCOM".

Signed-off-by: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
---
 drivers/interconnect/qcom/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/interconnect/qcom/Kconfig b/drivers/interconnect/qcom/Kconfig
index 5b8a094ca4ed..baec7eb4c24b 100644
--- a/drivers/interconnect/qcom/Kconfig
+++ b/drivers/interconnect/qcom/Kconfig
@@ -333,6 +333,7 @@ config INTERCONNECT_QCOM_SHIKRA
 	tristate "Qualcomm SHIKRA interconnect driver"
 	depends on INTERCONNECT_QCOM
 	depends on QCOM_SMD_RPM
+	default ARCH_QCOM
 	select INTERCONNECT_QCOM_SMD_RPM
 	help
 	  This is a driver for the Qualcomm Network-on-Chip on shikra-based

---
base-commit: d387b06f7c15b4639244ad66b4b0900c6a02b430
change-id: 20260526-shikra_icc_kconfig-97aa253a7132

Best regards,
--  
Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>

