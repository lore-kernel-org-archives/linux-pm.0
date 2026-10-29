Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793264494;
	b=OXmmFH9KfiBNJ1W+8Ur362J3Qyk+M+55ENA4NR4oo+xHxEjHPAov9xl1D++5y/YulwXV
	 Rj865gplovXC9CB83mYFCSjpESXHGapdUJv2XZC6KegePUdjRTnEbEOVR1nS3SOgr0Cz/
	 qoOlWBrWpIj56N4nA4LIjc4F+OVGGmFPXKN5vIdPoN6GnOIqhqfi+aobrbxi8tzrP5+qh
	 zZAP4BidLmw11gWabpZcMOT9G1/Rjt3jU+ZsD1zjCCnBf8Y7CiC6UuXRljvsDLPvTQc1f
	 IMv/OWe+74mHbSF+fuBPbCykP6pb8sJztKmAhMXjEebrLBzACunEQHoje4DEu8v19Dw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793264494;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=J1AjugNwDJzjs+xQkbp4ehvji0wa+l9yzMvacsY5C5E=;
	b=VaLz7qSZwwHFUjcxGGxxVKR3r/meXzVEmDlcDozNFuPliY4aMrUk7vUgH2gjwsMiITye
	 i9RV2387gbz/iymffsfAg1oB+l0lMCrvMv1aldsPScr1spsX9w6QvBKHkz6aU3DeHHcNg
	 db6BIKScgJMiGkNaUcHaOjgcPZV2+4L7ssyooWO3Pw9N1tFY0YgPubAWFbbKd17AiKn16
	 GpTiOWYk3uXVVjldpMBkEnOF/yHGQd5V1HDogBitf7ds94PW5DuZqcQ7QOzemRxgSI/nt
	 UvPF5088rn4TQ2XuZp0oQWYqNUjVymuUoAUO5O9EsSZO8vcv/rZRAJu8GeGHfStd/DA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=pFbiZO6v;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Wbb0PJV3;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA54E60A2607
	for <linux-pm@vger.kernel.org>; Thu, 29 Oct 2026 09:01:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA54E60A2607
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=pFbiZO6v;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Wbb0PJV3
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69T8vAZv2273168
	for <linux-pm@vger.kernel.org>; Thu, 29 Oct 2026 09:01:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	J1AjugNwDJzjs+xQkbp4ehvji0wa+l9yzMvacsY5C5E=; b=pFbiZO6vEHd37Mf4
	aPk7x5rtgQgQzTI0uIcCo8udu1t70gGkCy0dbKxjFU15tphlbAbu/bIEbb2F+YLj
	bhs3vJYcP+TaIizP0RYpT79qBWCy3+fc0YPPWJ8x3Z85JAew0jeJ+bHpTBN0DNHk
	qZH6KUKCiVm0h+2PKLDJasBWSJaIDg7CH98w9I001vYftvQ3nNFsAu8x+mqX8gi/
	BESM1eMOA8pqmY5ObVqu5M9ZL5sjxAQt7b9grzFRoCmHUU+7ixBpTp2nMDRKlt8M
	5tiYbo+P6eKFYJ+T6LQxJ7+1YnrC9xJtzN4EV/9teBwUgAjz0eFmekNZ1PjfExz6
	vOFGpw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hm31b016u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 29 Oct 2026 09:01:32 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3ad91787a1aso1421093a91.1
        for <linux-pm@vger.kernel.org>; Thu, 29 Oct 2026 02:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793264492; x=1793869292; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=J1AjugNwDJzjs+xQkbp4ehvji0wa+l9yzMvacsY5C5E=;
        b=Wbb0PJV37PpJD34mb56jdvxNXc0WppB9LCXtuhrpV7Uj6WTJhyOUMSVXb5sGvJjfOg
         6dKGoyf8ApduA/Frxx+gj8cUhY8sv9Epe3jML266JWXEG2SxjvGqb68StogmFMQSY674
         n6K8AMWKIdDdN5p9lyQgBk5QutrfJw+v7vde1ZvHaQoM5YmT8PDmyf+QPVDw+A7Dr4UM
         tQng1oFLbDBNrpYqUa8dt5LmThCghgC0sawiiYsLfJqWMXhEyK4gMOemJ47EvS8WaeVO
         l99mHH7Uq63iXp1lFeRt0WaPD1PIvk2S0EqH87He6um7FLuLQEDhw8scEQky69KkVLhf
         6RUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793264492; x=1793869292;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J1AjugNwDJzjs+xQkbp4ehvji0wa+l9yzMvacsY5C5E=;
        b=Ihv8UiVTkO1C1bTKvrASNx/EY9pZuAKOuVwo/T+m6iNgmNww4az9sfPB45dulJHTQs
         DMSostlmUJ/OIgOoBA+GPpcxlDTCs2/P3labgWzmIHuVfStCbC1nS30OLAb3/Rm8HzJ8
         l3daUiyZJStAJXZYDdruoBR1DtQg5t0aoa++qQuwcJK1f8PbfcDLHkXY+4esXgAh/VLZ
         MnVcc8iPbgH6hdGhJ4fkSVfdqRx16HrEkfMBpsqroQRnVRqUu+Q3twoWAjupsYfarKJp
         HDG+aukzbT7lT0GjyRPaCEbuz3MOj01fNPpirhy5PULoByjRbrODOthSKTxwYObqgNN0
         pAgQ==
X-Forwarded-Encrypted: i=1; AKwUvBzQ6VpfmL+5k+DWmmvZgg9IVAcxPzpFNjBF2AiASLzibMVNKtLAn0VnfoAcEtGQEbZHc6knVQIMuA==@vger.kernel.org
X-Gm-Message-State: AFq9FYLsOJoiAsQLFL9S7f0rTu0Edhy0NRLRCg9pa+CX53Qs0qrtNn3M
	nu0TMIwmB2nLi9j4E1pmPKwahJKJ0tvHVWDtNqwXPWj9q6F4sAxRbE2hTyBp8CS10TIQ3EnsioR
	36bsxyOXbFPYfLEhkS+C0kxsnOEev6ebnYvnNKHIU9CmYJ6H3cmWfqsjz1eYEGw==
X-Gm-Gg: AYBFou2q/QlJOvbwsrYZ3n6227wgzBT/476sQTbQFgmlevZkLGAjTG/IKj7q0LZ/Cyj
	hukJy0eqDJakWZ0fF6Ih48CEPtxT7WTmukfW+/LbujKoxrek70WMVfnOetEacesCrKlclyi767/
	PtDEmA1IVt74Nr2J/pD3VAgNA/JdUpjXGkMlaWgxOwH2PD/+d7DO8SiY+CyVTPYTHqSctiATuut
	JaU/buSvtZAAJUi43FB3XAco1Ot8L6pYrN9AI+OKiL77Nr8TTSMrLEzQpNzMW011Nllrr9Oayme
	k8Fw3QY6hJmuGMZ5IhmX/M5Joci0Ovs2Plm7Ih2Kv7KS9aRlrStqrJShPhhZSlPIEZUN9UufeUB
	YdIL/AS7idfz8dXtsOdIKCicxF9Qg89a+G69kfWoZA543y/rubEvMO4rav07RfWFtnpGJMUX7+z
	KY6LShrBKt
X-Received: by 2002:a17:90b:57e3:b0:3ab:413:49bc with SMTP id 98e67ed59e1d1-3ae58123796mr3475462a91.37.1793264491966;
        Thu, 29 Oct 2026 02:01:31 -0700 (PDT)
X-Received: by 2002:a17:90b:57e3:b0:3ab:413:49bc with SMTP id 98e67ed59e1d1-3ae58123796mr3475424a91.37.1793264491388;
        Thu, 29 Oct 2026 02:01:31 -0700 (PDT)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e7ad710sm3197385a91.3.2026.10.29.02.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 02:01:31 -0700 (PDT)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Thu, 29 Oct 2026 14:30:56 +0530
Subject: [PATCH v27 02/10] power: reset: reboot-mode: Add support for
 predefined reboot modes
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-arm-psci-system_reset2-vendor-reboots-v27-2-fa4b3ff1359b@oss.qualcomm.com>
References: <20261029-arm-psci-system_reset2-vendor-reboots-v27-0-fa4b3ff1359b@oss.qualcomm.com>
In-Reply-To: <20261029-arm-psci-system_reset2-vendor-reboots-v27-0-fa4b3ff1359b@oss.qualcomm.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Moritz Fischer <moritz.fischer@ettus.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Christian Loehle <christian.loehle@arm.com>,
        Lee Jones <lee@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        Pavan Kondeti <pavan.kondeti@oss.qualcomm.com>,
        Abel Vesa <abelvesa@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
        Sudeep Holla <sudeep.holla@kernel.org>, Andy Yan <andyshrk@163.com>,
        Ulf Hansson <ulfh@kernel.org>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Andre Draszik <andre.draszik@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>,
        Srinivas Kandagatla <srini@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793264458; l=12507;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=tsGYxJOD4Vu3FTmqMMEQjH4CevO7Efp6sGhzAhy4qxQ=;
 b=GZDPC7RTuwxjpU7T974A7m/ikZ1Mg623D0lqnhMsg14hjlUKgjZ0sODG7KsJywojOOBPWyn6v
 /H32hKhIKYqDIsvJ6LPAjQNCESLPq6sHX0XZD44wfkZn6tp0f/vEVCc
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=ssWsJFX3OM9pkdoe4+guOfGPaulHOFt0GVnVlB6on+s=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDAzNCBTYWx0ZWRfX00ePWF++YQzh
 glAXJlvwuD4Lm40hGRIxMe5v/sBxVsiEkiI6sBWZ6i/6GNQJ/+Mu0OuGakpdoObb0Alwrmam7rU
 EmAPZR/6w4R9tjKmtx82i2CmlLaxIbw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDAzNCBTYWx0ZWRfXzseWOQEc8biF
 Dis6x2KV+SoW/61dcmzdL6rKLIlPuImaL7yEDaUm7rXA0JIz1EWCSZKoeJSHcQYB562RDTJv7hj
 SNZIYZWkKUxoVOe5kYABADg23g60iC023hodNjvBpTtgtYH8hZ7TQRFOjBJUBfPMF7QsWYtwk+j
 sTez8kkAUlpIhic/nFOH/I2SXrdbtZO0hEmMuLnFimH+ARVuSjxdY2MA8ENqr4EdQBPJEUDCiPy
 e2lh2pn3QOmENW4F1kav4hZ3kC3IJOxFz0zPKf8CD3V+/0P+WBcFPnNIIeCamNUoXR0ADYD82xc
 8267MQNiL8bE+CDmauLLHAZu4QlvbDTMeLxWVfkz5/8E6kDBkMkLJRCKfdD5wA5+y0uy2dLFkbT
 HdcnXG/iy37pu0rW0C6LQPIU1OGI6Zidzzs0jByVMOpPlSiNltKcYsIgp04Zix01c5SO4oft5BG
 asXiQQVtO3SIAfxyfjg==
X-Authority-Analysis: v=2.4 cv=A8T5rKWG c=1 sm=1 tr=0 ts=6ae30b6d cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=S_7UqdFmbgqGN4e7PDYA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: eSG1uOC8p0EIpbeFDwORg8r9OrcDUD1W
X-Proofpoint-ORIG-GUID: eSG1uOC8p0EIpbeFDwORg8r9OrcDUD1W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290034

reboot-mode based drivers can define a reboot-mode by adding it under
the reboot-mode node in device tree. This limits such drivers, to define
any predefined reboot-modes statically within the driver and creates a
dependency on device-tree.

Extend the reboot-mode framework to support driver-defined predefined
reboot modes. Add a centralized initcall to initialize driver state
along with predefined modes.

Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
---
 drivers/power/reset/nvmem-reboot-mode.c  |   7 +-
 drivers/power/reset/qcom-pon.c           |   7 +-
 drivers/power/reset/reboot-mode.c        | 192 ++++++++++++++++++++++---------
 drivers/power/reset/syscon-reboot-mode.c |   7 +-
 include/linux/reboot-mode.h              |  26 ++++-
 5 files changed, 175 insertions(+), 64 deletions(-)

diff --git a/drivers/power/reset/nvmem-reboot-mode.c b/drivers/power/reset/nvmem-reboot-mode.c
index d260715fccf6..700732ed0f5b 100644
--- a/drivers/power/reset/nvmem-reboot-mode.c
+++ b/drivers/power/reset/nvmem-reboot-mode.c
@@ -51,8 +51,11 @@ static int nvmem_reboot_mode_probe(struct platform_device *pdev)
 	if (!nvmem_rbm)
 		return -ENOMEM;
 
-	nvmem_rbm->reboot.dev = &pdev->dev;
-	nvmem_rbm->reboot.write = nvmem_reboot_mode_write;
+	ret = reboot_mode_driver_init(&nvmem_rbm->reboot, &pdev->dev,
+				      nvmem_reboot_mode_write, NULL,
+				      NULL, 0);
+	if (ret)
+		return ret;
 
 	nvmem_rbm->cell = devm_nvmem_cell_get(&pdev->dev, "reboot-mode");
 	if (IS_ERR(nvmem_rbm->cell)) {
diff --git a/drivers/power/reset/qcom-pon.c b/drivers/power/reset/qcom-pon.c
index cd7ba680b841..55aaa99d88b6 100644
--- a/drivers/power/reset/qcom-pon.c
+++ b/drivers/power/reset/qcom-pon.c
@@ -84,9 +84,12 @@ static int qcom_pon_probe(struct platform_device *pdev)
 	reason_shift = (long)of_device_get_match_data(&pdev->dev);
 
 	if (reason_shift != NO_REASON_SHIFT) {
-		pon->reboot_mode.dev = &pdev->dev;
+		error = reboot_mode_driver_init(&pon->reboot_mode, &pdev->dev,
+						qcom_pon_reboot_mode_write, NULL,
+						NULL, 0);
+		if (error)
+			return error;
 		pon->reason_shift = reason_shift;
-		pon->reboot_mode.write = qcom_pon_reboot_mode_write;
 		error = devm_reboot_mode_register(&pdev->dev, &pon->reboot_mode);
 		if (error) {
 			dev_err(&pdev->dev, "can't register reboot mode\n");
diff --git a/drivers/power/reset/reboot-mode.c b/drivers/power/reset/reboot-mode.c
index 328fa37598df..fd61de226383 100644
--- a/drivers/power/reset/reboot-mode.c
+++ b/drivers/power/reset/reboot-mode.c
@@ -30,12 +30,12 @@ struct reboot_mode_sysfs_data {
 	struct list_head head;
 };
 
-static inline void reboot_mode_release_list(struct reboot_mode_sysfs_data *priv)
+static void reboot_mode_release_list(struct list_head *head)
 {
 	struct mode_info *info;
 	struct mode_info *next;
 
-	list_for_each_entry_safe(info, next, &priv->head, list) {
+	list_for_each_entry_safe(info, next, head, list) {
 		list_del(&info->list);
 		kfree_const(info->mode);
 		kfree(info);
@@ -119,6 +119,80 @@ static int reboot_mode_notify(struct notifier_block *this,
 	return NOTIFY_DONE;
 }
 
+/**
+ * reboot_mode_driver_init - Initialize reboot-mode state
+ * @reboot: reboot mode driver object to initialize
+ * @dev: backing device
+ * @write: write callback to program a single magic value
+ * @write_array: write callback to program multiple magic values
+ * @predefined_modes: optional predefined reboot-mode table
+ * @predefined_mode_count: number of entries in @predefined_modes
+ *
+ * Exactly one write callback must be provided by the driver.
+ *
+ * This function must be called with a valid @dev before calling
+ * reboot_mode_register().
+ *
+ * Returns: 0 on success or -EINVAL if callback/predefined mode configuration
+ * is invalid.
+ */
+int reboot_mode_driver_init(struct reboot_mode_driver *reboot,
+			    struct device *dev,
+			    int (*write)(struct reboot_mode_driver *reboot, unsigned int magic),
+			    int (*write_array)(struct reboot_mode_driver *reboot,
+					       const u32 *magic, u32 count),
+			    const struct reboot_mode_entry *predefined_modes,
+			    size_t predefined_mode_count)
+{
+	if (!reboot || !dev)
+		return -EINVAL;
+
+	if (!write == !write_array)
+		return -EINVAL;
+
+	memset(reboot, 0, sizeof(*reboot));
+	reboot->dev = dev;
+	reboot->write = write;
+	reboot->write_array = write_array;
+	reboot->predefined_modes = predefined_modes;
+	reboot->predefined_mode_count = predefined_mode_count;
+	INIT_LIST_HEAD(&reboot->head);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(reboot_mode_driver_init);
+
+static struct mode_info *reboot_mode_create_info(struct device *dev, const char *mode,
+						 const u32 *magic, int count)
+{
+	struct mode_info *info;
+
+	if (!mode || mode[0] == '\0') {
+		dev_err(dev, "invalid mode name\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	info = kzalloc_obj(*info, GFP_KERNEL);
+	if (!info)
+		return ERR_PTR(-ENOMEM);
+
+	info->mode = kstrdup_const(mode, GFP_KERNEL);
+	if (!info->mode) {
+		kfree(info);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	if (!memchr_inv(magic, 0, count * sizeof(u32))) {
+		dev_dbg(dev, "reboot mode %s with zero magic values\n", mode);
+		info->count = 0;
+	} else {
+		memcpy(info->magic, magic, count * sizeof(u32));
+		info->count = count;
+	}
+
+	return info;
+}
+
 static int reboot_mode_create_device(struct reboot_mode_driver *reboot)
 {
 	struct reboot_mode_sysfs_data *priv;
@@ -160,11 +234,38 @@ static int reboot_mode_create_device(struct reboot_mode_driver *reboot)
 	return 0;
 
 error:
-	reboot_mode_release_list(priv);
+	reboot_mode_release_list(&priv->head);
 	kfree(priv);
 	return ret;
 }
 
+static int reboot_mode_add_predefined_modes(struct reboot_mode_driver *reboot)
+{
+	const struct reboot_mode_entry *modes = reboot->predefined_modes;
+	struct mode_info *info;
+	size_t i;
+
+	if (!modes)
+		return 0;
+
+	for (i = 0; i < reboot->predefined_mode_count; i++) {
+		if (modes[i].name && strpbrk(modes[i].name, "\n ,/"))
+			return -EINVAL;
+
+		if (!modes[i].count || modes[i].count > ARRAY_SIZE(modes[i].magic))
+			return -EINVAL;
+
+		info = reboot_mode_create_info(reboot->dev, modes[i].name,
+					       modes[i].magic, modes[i].count);
+		if (IS_ERR(info))
+			return PTR_ERR(info);
+
+		list_add_tail(&info->list, &reboot->head);
+	}
+
+	return 0;
+}
+
 /**
  * reboot_mode_register - register a reboot mode driver
  * @reboot: reboot mode driver
@@ -173,7 +274,7 @@ static int reboot_mode_create_device(struct reboot_mode_driver *reboot)
  */
 int reboot_mode_register(struct reboot_mode_driver *reboot)
 {
-	struct mode_info *info = NULL;
+	struct mode_info *info;
 	struct property *prop;
 	struct device_node *np = reboot->dev->of_node;
 	size_t len = strlen(PREFIX);
@@ -183,52 +284,36 @@ int reboot_mode_register(struct reboot_mode_driver *reboot)
 
 	INIT_LIST_HEAD(&reboot->head);
 
-	for_each_property_of_node(np, prop) {
-		memset(magic, 0, sizeof(magic));
-
-		if (strncmp(prop->name, PREFIX, len))
-			continue;
-
-		count = device_property_count_u32(reboot->dev, prop->name);
-
-		if (count <= 0 || count > ARRAY_SIZE(magic) ||
-		    device_property_read_u32_array(reboot->dev, prop->name, magic, count)) {
-			dev_dbg(reboot->dev, "reboot mode %s without magic number\n",
-				prop->name);
-			continue;
-		}
-
-		info = kzalloc_obj(*info);
-		if (!info) {
-			ret = -ENOMEM;
-			goto error;
-		}
-
-		if (!memchr_inv(magic, 0, count * sizeof(u32))) {
-			dev_dbg(reboot->dev, "reboot mode %s with zero magic values\n",
-				prop->name);
-			info->count = 0;
-		} else {
-			memcpy(info->magic, magic, count * sizeof(u32));
-			info->count = count;
-		}
-
-		info->mode = kstrdup_const(prop->name + len, GFP_KERNEL);
-		if (!info->mode) {
-			ret = -ENOMEM;
-			goto error;
-		} else if (info->mode[0] == '\0') {
-			kfree_const(info->mode);
-			ret = -EINVAL;
-			dev_err(reboot->dev, "invalid mode name(%s): too short!\n",
-				prop->name);
-			goto error;
+	if (np) {
+		for_each_property_of_node(np, prop) {
+			memset(magic, 0, sizeof(magic));
+			if (strncmp(prop->name, PREFIX, len))
+				continue;
+
+			count = device_property_count_u32(reboot->dev, prop->name);
+
+			if (count <= 0 || count > ARRAY_SIZE(magic) ||
+			    device_property_read_u32_array(reboot->dev, prop->name, magic, count)) {
+				dev_dbg(reboot->dev, "reboot mode %s without magic number\n",
+					prop->name);
+				continue;
+			}
+
+			info = reboot_mode_create_info(reboot->dev, prop->name + len,
+						       magic, count);
+			if (IS_ERR(info)) {
+				ret = PTR_ERR(info);
+				goto error;
+			}
+
+			list_add_tail(&info->list, &reboot->head);
 		}
-
-		list_add_tail(&info->list, &reboot->head);
-		info = NULL;
 	}
 
+	ret = reboot_mode_add_predefined_modes(reboot);
+	if (ret)
+		goto error;
+
 	reboot->reboot_notifier.notifier_call = reboot_mode_notify;
 	register_reboot_notifier(&reboot->reboot_notifier);
 
@@ -239,7 +324,6 @@ int reboot_mode_register(struct reboot_mode_driver *reboot)
 	return 0;
 
 error:
-	kfree(info);
 	reboot_mode_unregister(reboot);
 	return ret;
 }
@@ -272,7 +356,7 @@ static inline void reboot_mode_unregister_device(struct reboot_mode_driver *rebo
 	if (!priv)
 		return;
 
-	reboot_mode_release_list(priv);
+	reboot_mode_release_list(&priv->head);
 	kfree(priv);
 }
 
@@ -282,17 +366,11 @@ static inline void reboot_mode_unregister_device(struct reboot_mode_driver *rebo
  */
 int reboot_mode_unregister(struct reboot_mode_driver *reboot)
 {
-	struct mode_info *info;
-	struct mode_info *next;
-
 	unregister_reboot_notifier(&reboot->reboot_notifier);
+	reboot->reboot_notifier.notifier_call = NULL;
 	reboot_mode_unregister_device(reboot);
 
-	list_for_each_entry_safe(info, next, &reboot->head, list) {
-		list_del(&info->list);
-		kfree_const(info->mode);
-		kfree(info);
-	}
+	reboot_mode_release_list(&reboot->head);
 
 	return 0;
 }
diff --git a/drivers/power/reset/syscon-reboot-mode.c b/drivers/power/reset/syscon-reboot-mode.c
index e0772c9f70f7..7d3a95e8dfd7 100644
--- a/drivers/power/reset/syscon-reboot-mode.c
+++ b/drivers/power/reset/syscon-reboot-mode.c
@@ -45,8 +45,11 @@ static int syscon_reboot_mode_probe(struct platform_device *pdev)
 	if (!syscon_rbm)
 		return -ENOMEM;
 
-	syscon_rbm->reboot.dev = &pdev->dev;
-	syscon_rbm->reboot.write = syscon_reboot_mode_write;
+	ret = reboot_mode_driver_init(&syscon_rbm->reboot, &pdev->dev,
+				      syscon_reboot_mode_write, NULL,
+				      NULL, 0);
+	if (ret)
+		return ret;
 	syscon_rbm->mask = 0xffffffff;
 
 	syscon_rbm->map = syscon_node_to_regmap(pdev->dev.parent->of_node);
diff --git a/include/linux/reboot-mode.h b/include/linux/reboot-mode.h
index 29ae39935d69..560d8b4d67ac 100644
--- a/include/linux/reboot-mode.h
+++ b/include/linux/reboot-mode.h
@@ -4,14 +4,38 @@
 
 #include <linux/types.h>
 
+struct reboot_mode_entry {
+	const char *name;
+	u32 magic[3];
+	u32 count;
+};
+
 struct reboot_mode_driver {
 	struct device *dev;
 	struct list_head head;
+	/*
+	 * Optional predefined reboot-mode table.
+	 *
+	 * Must be initialized before reboot_mode_register() and remain valid
+	 * until reboot_mode_unregister().
+	 *
+	 * If a predefined mode name duplicates a DT-defined mode name,
+	 * the DT-defined mode takes precedence.
+	 */
+	const struct reboot_mode_entry *predefined_modes;
+	size_t predefined_mode_count;
+	int (*write_array)(struct reboot_mode_driver *reboot, const u32 *magic, u32 count);
 	int (*write)(struct reboot_mode_driver *reboot, unsigned int magic);
-	int (*write_array)(struct reboot_mode_driver *reboot, const u32 *magic, int count);
 	struct notifier_block reboot_notifier;
 };
 
+int reboot_mode_driver_init(struct reboot_mode_driver *reboot,
+			    struct device *dev,
+			    int (*write)(struct reboot_mode_driver *reboot, unsigned int magic),
+			    int (*write_array)(struct reboot_mode_driver *reboot,
+					       const u32 *magic, u32 count),
+			    const struct reboot_mode_entry *predefined_modes,
+			    size_t predefined_mode_count);
 int reboot_mode_register(struct reboot_mode_driver *reboot);
 int reboot_mode_unregister(struct reboot_mode_driver *reboot);
 int devm_reboot_mode_register(struct device *dev,

-- 
2.34.1

