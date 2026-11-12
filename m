Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794468033;
	b=3qhpo3hGFVMaCLCuCMwn6a6rt15xXs6gkY4Qsg8Sg/3ufjcDSyvQl2CsvS5yB2D4vWsc
	 GbEhq0qs16soSEi6SbBX1IFpiu6lEqM59WpJT6Graw2PexrDvHXMmxUpj4LQczDqPPVXe
	 FfNw9bTiJ7+O9H75VZZwvAFBxo0bo/o9krTTeh+0wXGVY71Tu9I8CExEr/vedVlu3bbms
	 n+frYZLzswF5/PTnKL3nOB3LL1igXbqhvIymk5fNpyvxvdUf0mMkwN3rFdDr+GyL9qRrs
	 kqrkuSE7j3MaG+c29Id+WgRWirVTaT94cTZnFT9YSmQwPZwJJN/pTGra1iqtW62BbqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794468033;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=WADlB89QNmzwJxrRLEaHqXVtl5b6bAp/OWZbUebu8cs=;
	b=FCh4CWSM03CD9L9JayH3NX4tszL0lBnhJaZmH8hBLHBD/lFAZTacICvP+9AWA50RQEPo
	 LX2PdlVdKou2jRCyVa1cieYTC+HTns1fYdu/zd7E8OzLC5vXq1jFSIN3g8p1x8t1KHY8/
	 f3Kn+w9afqiGzbsliiyb7TRVwMNjlZb1c7DW+j82EN/qcuCo9TB+a3Hd2rps3Ftok+AqY
	 81NfJ4Za2y1TMEMKjxH0t+XSHb0JtB7o5KIiVcOCL4l3SmWZnPl8cx+BuPPWPeBMYumvu
	 OT1GfMUoBJJ1c82iNSHlhjq8HiRrdh8it/5FO5v0s94eGXgsKTd5Crv1v7z+5j7Yuzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="cJoa/K2j";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kbZHbGgY;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC49606A884
	for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 07:20:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1FC49606A884
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cJoa/K2j;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kbZHbGgY
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AC2Za28903602
	for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 07:20:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=WADlB89QNmz
	wJxrRLEaHqXVtl5b6bAp/OWZbUebu8cs=; b=cJoa/K2jnnGUSfJMD2NFxQQiO1c
	zUAJQu2Mevi4ubNyvBBzNDXvMLCTZ9qd14149NTa8Bqb3VTzwslM1A29q7Pi0qUV
	XVpnQXoBkmmZoeq1JD6gYPCaNyIpI25Uem+Lwpyzoe0H379S4qMRrLAwVq/lIAfa
	O55Y5s2gzug26ew3zz8LSBByguGAAR1rSgnQXhneMS7d46sgU2JzDLDun3QLtttU
	yEFRDvkSJR+9p0RbIlZddxAQLb2RIx1BW+jAo3RNdJsOMK473a6lBuwhjWJszb0p
	gT25kq6rqEkK7f+DmLkHBm5oAbsuuliNSN0WYvlh7LOgO543QAeQRQDn9QA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvt1ubfcr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 07:20:32 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cd5e8574384so207436a12.0
        for <linux-pm@vger.kernel.org>; Wed, 11 Nov 2026 23:20:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794468032; x=1795072832; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WADlB89QNmzwJxrRLEaHqXVtl5b6bAp/OWZbUebu8cs=;
        b=kbZHbGgY8gHfXCL4PGpGD8quekRwQpAvinmYlovL8yZDoVgm+DtTMHWzA0YtbGJ7FX
         wOXknPPTnfj8yEOFM6KkgLlfL1OkY9AAFxEJJ8ovYrx2aDZxOGfDcWRYwGriwvpBRXRC
         1DYGw+fP/OhINWSHjjWg65N2vYExqinSbMWRM0cK7E7O83qZotuAvaviNRuyoCEmHN5D
         VD652bZWjgDzsOV0rOBqhohiy9k+C908PZJjhpHNCuOo9FR0XRs/dvr4KE8XrgsuFPXj
         LcZVvwYpRZy6CqdnvbhaP8NyG9Z1hKAvcVLAP5lgFaxVu38apPGWe/zkSb6z2ykMpeeL
         KSTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794468032; x=1795072832;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WADlB89QNmzwJxrRLEaHqXVtl5b6bAp/OWZbUebu8cs=;
        b=dfavgi9c4r/wYtWsWCZLlBLO8zldDJ/s0SDds9HiLJYLjAp9Diz7CEsEoam/gQNkxx
         KecLqmW0fAAuY/2E6yajJ/BDKGMX/a+x3gGUPE6yz5UR+AAiV7aJahtcbX1k6yEXX+p/
         vSwPwzbfgh0PvLjBQiefQ5afpJEhVeiiV6fUIrcxzbwH+KDHwQcLGP+Bq15PDAXHJn4n
         1wEYwuKq6SApmYXlcIJrNLxeXBB7C2Xpiil894bOzpE3fIXIV5gNKBh94oGmtk+OghTN
         6nLfk7cZOrcSSg0lP7KDSKDOfT1sU4ysa8vkjecZFsJKOrdRET0iWyzk4d8+XVxXE3ps
         leQA==
X-Forwarded-Encrypted: i=1; AL+hErFhxnciGRt4xEw7n/uRhXx+d42YMXpOxbickbShi0+MSxMvB4iz6GX7CMg1k+6jO49VQyrgFtVszA==@vger.kernel.org
X-Gm-Message-State: APuU4Z/YDi3Zdp9BPCXNivypUaYMhKw2UclL0rAFik3GAklOilmx0DwY
	IGY6Vcq+t7ruvxVE3iMObbgmoD0wLjzsEMBoV/twd5DSy8Q+o8voesXc+GrOzbqcLYk6HwvNkOC
	5DoCoG67iAoPgRBWt/0+O+9U3g/628WtnDxcgY6kGOnFL81neiTvTKMLMq9385w==
X-Gm-Gg: AYBFou1r1nUrJoYHQu88TKtOiFkR6MiX60ew1iqdKLAymJXWzhK9T25G9n3JIFwsv/r
	IWhKLDopz5JfELXIyUzFE6PEhYpVMmtzKgn2rNeYgVuMZTFmOmSRArLcoaiaBTmbO6uTD5xz2Jj
	6v+DnT5O/MpT9tK6lBQl66V+lNcVNY1/d4JgdUYMUUAWweWktGye3Rsi+7E/O7HOi1dQ6XI+mxF
	qQapqceY5v2musZZsIr6FdJwjEtelc3GUi/k/BZmS0TaWla8Z2KE1DH8m4sIFPfIhUMO7ksG0Lu
	W5ZvDMh1uqWabi2jxHN0mzlEpQ7IUiR3uyRrvEsyrq2no/1kzTIS6sKE7/a9kENhlP14Uqh2tkw
	WqAZWmLixz7U0V5glEYnJ5T5Xsoo1Q7aGT8AHsuausPPB/ryKfpVbI9kp10RQlXATZ4IvH66Rtq
	pGXQ==
X-Received: by 2002:a17:90b:4c51:b0:3a6:e61f:749d with SMTP id 98e67ed59e1d1-3b182de7309mr7512742a91.1.1794468031622;
        Wed, 11 Nov 2026 23:20:31 -0800 (PST)
X-Received: by 2002:a17:90b:4c51:b0:3a6:e61f:749d with SMTP id 98e67ed59e1d1-3b182de7309mr7512696a91.1.1794468031117;
        Wed, 11 Nov 2026 23:20:31 -0800 (PST)
Received: from sdciot-sh07-lnx.qualcomm.com ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197c73e27sm3149185a91.9.2026.11.11.23.20.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 23:20:30 -0800 (PST)
From: Linghui Wu <linghui.wu@oss.qualcomm.com>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>,
        Hangtian Zhu <hangtian.zhu@oss.qualcomm.com>,
        Shuai Zhang <shuai.zhang@oss.qualcomm.com>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Linghui Wu <linghui.wu@oss.qualcomm.com>
Subject: [PATCH v4 2/3] power: sequencing: qcom-wcn: support SW_CTRL wake IRQ
Date: Thu, 12 Nov 2026 15:20:08 +0800
Message-ID: <20261112072009.3815276-3-linghui.wu@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261112072009.3815276-1-linghui.wu@oss.qualcomm.com>
References: <20261019093911.3199891-1-linghui.wu@oss.qualcomm.com>
 <20261112072009.3815276-1-linghui.wu@oss.qualcomm.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDAyOSBTYWx0ZWRfX9LkF2ARS76EK
 EyJLzi2feYKmwX6jvN1Tb8yFAmDmDTfMNRdGwdSmUUXGxF+R6qy+Uz4bZpaKqNMpx8l7npdaqQp
 uOvqr/DDjAXofptg3zfLuRd3xA5z+kw=
X-Proofpoint-GUID: ddpD3Ipo8qH63v-hBsDQaTDk-vM--Utw
X-Proofpoint-ORIG-GUID: ddpD3Ipo8qH63v-hBsDQaTDk-vM--Utw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDAyOSBTYWx0ZWRfX8tILXTAPlzmx
 +Fr7B5nt61a8wx4+6uCY43CFXcgzOyufqbu1+O8JBVIusrSFcu2gXD0h53bDLUHUO+fyCGGkbt5
 YcoEPMFVeynOuYUD3fy//rrAf3k1p4LWPVL9Vhg0ERL7Dvsuo9ZKhT0CuzkQoSSr1pHL/J35z9n
 xpgA8tlP+FGBytlWOLemZLhASFN3yHSMhv1exLArZBkiQEjJaaI5i3FC4SZS1HRdhO8NXGbiGMg
 h6eXrfdltBYjE7nlifounlBXcVhVjCrO1wx3S1baD9darrXIDx493z7YsJemtEQVrj7V95G4XDy
 k8tnotKA4Y6orqKVPlZEUOjz5RKQ1RF/OqY4jIFri/l66qa8ltkf7oFFF6cRGLfm2FVdARvoDFd
 Q+VXGa0nhVR39/o1bLoD7fwc5+3ksc13kYRMRfeazGCgaI5MVvyWtkMmP7fkreRcCpD6e7+mBvB
 3Uq56lfuw01bSSpIP5A==
X-Authority-Analysis: v=2.4 cv=LvcHWXdc c=1 sm=1 tr=0 ts=6af568c0 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=d3QjpUUrb7QHECHc-BAA:9 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 adultscore=0 suspectscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611120029

Some WCN3990-family devices use SW_CTRL to signal that resources need to
remain available while the application processor is suspended.

When the PMU is marked as a wakeup source, request the existing SW_CTRL
GPIO as an input, map it to an IRQ and register it as a dedicated wake
IRQ. The PM core then keeps the IRQ disabled during normal operation and
arms it for system suspend.

Signed-off-by: Linghui Wu <linghui.wu@oss.qualcomm.com>
---
 drivers/power/sequencing/pwrseq-qcom-wcn.c | 36 ++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/power/sequencing/pwrseq-qcom-wcn.c b/drivers/power/sequencing/pwrseq-qcom-wcn.c
index e51b655add01..26b436df9b93 100644
--- a/drivers/power/sequencing/pwrseq-qcom-wcn.c
+++ b/drivers/power/sequencing/pwrseq-qcom-wcn.c
@@ -11,6 +11,8 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/pm_wakeirq.h>
+#include <linux/pm_wakeup.h>
 #include <linux/property.h>
 #include <linux/regulator/consumer.h>
 #include <linux/pwrseq/provider.h>
@@ -484,11 +486,18 @@ static int pwrseq_qcom_wcn3990_match(struct pwrseq_device *pwrseq,
 	return pwrseq_qcom_wcn_match_regulator(pwrseq, dev, "vdd-1.8-xo-supply");
 }
 
+static void pwrseq_qcom_wcn_clear_wake_irq(void *data)
+{
+	dev_pm_clear_wake_irq(data);
+}
+
 static int pwrseq_qcom_wcn_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct pwrseq_qcom_wcn_ctx *ctx;
+	struct gpio_desc *swctrl_gpio;
 	struct pwrseq_config config;
+	int wake_irq;
 	int i, ret;
 
 	ctx = devm_kzalloc_obj(dev, *ctx);
@@ -525,6 +534,33 @@ static int pwrseq_qcom_wcn_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, PTR_ERR(ctx->bt_gpio),
 				     "Failed to get the Bluetooth enable GPIO\n");
 
+	if (device_property_read_bool(dev, "wakeup-source")) {
+		swctrl_gpio = devm_gpiod_get(dev, "swctrl", GPIOD_IN);
+		if (IS_ERR(swctrl_gpio))
+			return dev_err_probe(dev, PTR_ERR(swctrl_gpio),
+					     "Failed to get the SW_CTRL GPIO\n");
+
+		wake_irq = gpiod_to_irq(swctrl_gpio);
+		if (wake_irq < 0)
+			return dev_err_probe(dev, wake_irq,
+					     "Failed to get the SW_CTRL wake IRQ\n");
+
+		ret = devm_device_init_wakeup(dev);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "Failed to enable wakeup\n");
+
+		ret = dev_pm_set_dedicated_wake_irq(dev, wake_irq);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "Failed to set the SW_CTRL wake IRQ\n");
+
+		ret = devm_add_action_or_reset(dev,
+					       pwrseq_qcom_wcn_clear_wake_irq, dev);
+		if (ret)
+			return ret;
+	}
+
 	ctx->wlan_gpio = devm_gpiod_get_optional(dev, "wlan-enable",
 						 GPIOD_OUT_LOW);
 	if (IS_ERR(ctx->wlan_gpio))
-- 
2.43.0

