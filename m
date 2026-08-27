Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC843F8251
	for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2026 18:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787853611; cv=none; b=Qfr39oARQ+h8Glj2opkPS7T0amEd5m/JwBQk5pOHosKpvZ75dNzd4YSdvIfsW8utc3pNaWZbAtHmnv69VLUb79kavtMeTzi4Nzo+M7s9UKRBCd+A4LO8ntTrUzR0z2ZE+bgTMbArfo1GhzbjEilS8X8ttXxVQnEufl4cQvXXNYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787853611; c=relaxed/simple;
	bh=FBDw/I4Waykly4lZ3CvAqJEIzFElSwmZ1beXrSZKiUM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bNni1b2nklVDI9fJrUQaLtpqK7heyZ5Q0zcjNOSA8PDMALfpCTSnGszoskDEOECgdJnR6yoeFJ1PuzdBgL8EOkOP11AsBCtZOTit3na6yDaN4snA9ygEIQe1ZoI4S3BiHKe981kafViV1goUhuMTtnHtXrBhZ9zd0Nexz3v5GCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pDQZIbHU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KmKqGkGZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pDQZIbHU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KmKqGkGZ"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67RHXd1v313737
	for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2026 18:00:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	B6gN3x8PKcm1sNfVijcrAK0H0yaVuRFKl9zQpFpFyM8=; b=pDQZIbHUJFoO0VNv
	eLtmuCZWX+K91CL/bR6Gxfkg3W00iGUL+3F8bY4OQ9aMJ+dUJfSXaPAcAOUo70x8
	kfJaERqNh+dD5h44D1P1of3B76gFEEc+xyfid8SvrUtgEKnK234l55y/URLtWOXU
	hz1MLLB08hffmyiExn94SkWFcdBWI5PC8ES1q33DxkTDF5IBs/AhzziPYglDV9ux
	zYpWLLfCVT1NB4RgoljWFcjRuxsOTokKAdmE3igRN97keIM4En4oSlAraqxL0Kn+
	Y6793eJlXfNSeTn2Ekwfm12EnyTZEGGu/dCuDqpCO1ZXaRs9SHVUk1nrsL+eiDhz
	WjhGqA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gak561x3w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2026 18:00:07 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38e475f83a2so331651a91.1
        for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2026 11:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787853606; x=1788458406; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=B6gN3x8PKcm1sNfVijcrAK0H0yaVuRFKl9zQpFpFyM8=;
        b=KmKqGkGZmuI9P4ao4MbPR0riSnabSa/EMPeQVPTmSfA2X1mrF9Z93bXEJGCSmNEKPJ
         gWVFKmiOfXr8G4d5fu53XYDMUkt6A6ivl3mOLtvaYqQXVUT3Nhs6fWKIwl65S1vV7ELh
         Kv6MXSQ0g97njwHFsJdmT/YG98BGYfV3XpEgYdmROGhaf5wsfVMPJOz/F+7nR0B9h5AG
         8ECEoWNcWmmFQoT7z5/cf4hnt+a7B13KoXYa1+HIrrVgRhZzaqL7A+t/h43p+AZA//6M
         rBfKuUPJ2enikTR779bZNk4jctmXibj1CeU/Ag9IYhxp7zQgj3uWBa9jNaREdjUDmwEJ
         HIBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787853606; x=1788458406;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B6gN3x8PKcm1sNfVijcrAK0H0yaVuRFKl9zQpFpFyM8=;
        b=Pj1YbDNa8tFcereVOvrLLmSOdNTFIMdAN6a2lmeMk2p/6ZSOUhoqeOIOPHtojpYwtQ
         Ni6pbITjgc/8Ogp4QbPmeP8owFe51X4njeVaQbtVU/vhqoDETIwAWXLLqQJ/XTbcuJPk
         TFu49aJ15aRlJ43dddbpbcBJ+SPggqUV73xa6ddaLkbIAjTzk9S465+XEJAftt0SZ6Du
         zFcn3vggfwzrVbV85zxWIRO8L6ryZ6x8KY6CskeDeD7KRJcSjIRQQIZDcvIiiZKlpdSq
         OLE4I+4QCE7Phf+Xfy25u0pIJz2AHEQLHmNJYcIXcCdf4uc9J03qKGVyaXYZ5AWRH+h6
         UqNQ==
X-Forwarded-Encrypted: i=1; AHgh+RqXAMswiXkaT1dvT/28VEHw7wiUwCVDhURWoBGVuPDI/l3Qb1HTZ7wNiRPJvrCQe06UbKPXKGB6ew==@vger.kernel.org
X-Gm-Message-State: AFuF++kJwTWbiWV4u6/DNl4jj1PyF232BrxkUvbO5JMQXKF0PVuiKBfD
	v/ZZdNSGfRJD/pgFJjzBy59lyPKDw3FgYVvlg6YM5wkYek1VI4fu/WlGy/aRSIDLDGdyDfafrOk
	WjS9xbsqkXKg2vuj0ZPs4Fn/NZFjYfRio+Gve7VlpU+uMXtH5oIKvNOlhpUtRkt5xPonxrg==
X-Gm-Gg: AR+sD13wUj25aFLAyP5lRojuKG377MGbbxZ9nH/0wWfo/ztljK+Q/2zYKhnQAKawekn
	6rIm6b3AiQyQ20gOSkHvzIJPFwfhiZOGum/aWGxeCIVKg9RYtEWZH1jrfsK9nixUF5Ql865XfRH
	UcFBOJSVyeTlxYvYFokQzqDiqoJK1hJ3v1vPFKg/1B3i5+NrAqfCFpAbwwOOKHXn8cZkp0n4ad3
	9Oy6J91MvmhzMFXuqUTyEKbgPZDLOLZULgK/fYAqo755r+HwUQIjOj57cJqBM3wWACHY+V/3Fev
	OFYZ321eXWDiIZelBlu2OYIYnVQSdCzxPxBahtzejvsqw9Qv/ohy6ycZytYAnPge34WB4WylsbK
	7oZD9RQDxzXkUXEvACBQWMI3jRBcTQpEEIA==
X-Received: by 2002:a05:6a21:a09:b0:3b4:61f:1fec with SMTP id adf61e73a8af0-3d26668474amr1671805637.2.1787853606508;
        Thu, 27 Aug 2026 11:00:06 -0700 (PDT)
X-Received: by 2002:a05:6a21:a09:b0:3b4:61f:1fec with SMTP id adf61e73a8af0-3d26668474amr1671648637.2.1787853605873;
        Thu, 27 Aug 2026 11:00:05 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141a905cf38sm27437523c88.12.2026.08.27.10.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 11:00:05 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Date: Thu, 27 Aug 2026 23:29:22 +0530
Subject: [PATCH v2 5/9] serial: qcom-geni: Use geni_se_set_rate() for
 source clock configuration
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-5-091697dbeb02@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787853566; l=4351;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=FBDw/I4Waykly4lZ3CvAqJEIzFElSwmZ1beXrSZKiUM=;
 b=VgT+A7/GZ3REIZN+WvvXjm2mcwdMPEtOIvgaOslmKLbXnHIQq4y29ZStj5qCPOq4RYkmX7ljr
 HOmcb3nAFZ0Da7puZcMuSC0WA2YWZwrcgHSUyzzEkCpxqrXAY+WlvJD
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE1MSBTYWx0ZWRfX+bXeq9w43nal
 f9RBvDlJ0sFS3HjTIlcpipYVRqvZl5rPNiJmLfS7hqahi9G2eElnoMi/JYQGRtgIfS3OtGO7N0A
 2s6nYiXniGm8agMAelF4JhoFO4fCXyw=
X-Proofpoint-ORIG-GUID: MEPf0tnQy1YsGjTRsTgBz_kEzbZxSf8-
X-Proofpoint-GUID: MEPf0tnQy1YsGjTRsTgBz_kEzbZxSf8-
X-Authority-Analysis: v=2.4 cv=G+Ms1dk5 c=1 sm=1 tr=0 ts=6a907b27 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=_eeGUSGHzPgYkwSUgSAA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE1MSBTYWx0ZWRfX4XxFcjHvlOf3
 3W/epocystpSlOs0n1rzgKHl+yioV8/qCPDWHuv1zI2bbnke4Sht1r5Qs32wStTe6Dubgw/E3lE
 ZgmFXm1n1ggvNA2wprF6YMq67SInInPkPI4/OHCMs/23ppWgNoRPqMqf/G1Jm4N4yttt8OMneYn
 GAijYy6K0+kLgpC+NbMiSe2dGAivH1Wmx8kFYT3xlQN/Jx1RgkpCZVD71XoAasA7JyVdNQsANsJ
 2C7flpYmljG09n+KCEyGhTXaCxOhukp3ImD2xjmYoyC54u/uMguHGmM5crq6I6xtRMHJyC5j/rQ
 7VuDbW3DG4k6JX5V4a7NLeNLeG0Qr10DwUqK69kls+OgOcgmMo9JvQmwec+ft0XcmC7KaFTtbtG
 vZW81pmR1rcPblEi6y86nfOz5dNeWPIC+anvPGrM39qUWk9Rhk8t2e/VGMQq+40N5BnUrad+6+v
 +hT7Te2ydeZMObwZMXg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_07,2026-08-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 clxscore=1015 bulkscore=0
 phishscore=0 spamscore=0 impostorscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270151

On the SA8255P platform there is no Linux clock handler for the SE
source clock, so the driver has no way to compute the divider needed
for a requested baud rate. To work around this, firmware instead
exposes the SE HW supported source clock frequencies as OPPs on the
perf domain device.

geni_se_domain_attach() now populates clk_perf_tbl from
the performance-domain OPP table, allowing firmware-managed
platforms to use geni_se_clk_freq_match().

Call geni_serial_set_rate() unconditionally from
qcom_geni_serial_set_termios(), and use geni_se_set_rate() instead of
dev_pm_opp_set_rate() so clock programming is handled centrally by
the GENI core, independent of the underlying clock-control mechanism.

Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
 drivers/tty/serial/qcom_geni_serial.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 3633723acef8..23ecd137c521 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -114,7 +114,6 @@ struct qcom_geni_device_data {
 	bool console;
 	enum geni_se_xfer_mode mode;
 	int (*resources_init)(struct geni_se *se);
-	int (*set_rate)(struct geni_se *se, unsigned long baud);
 	int (*power_on)(struct geni_se *se);
 	int (*power_off)(struct geni_se *se);
 };
@@ -1474,7 +1473,10 @@ static int geni_serial_set_rate(struct geni_se *se, unsigned long baud)
 
 	uport->uartclk = clk_rate;
 	port->clk_rate = clk_rate;
-	dev_pm_opp_set_rate(uport->dev, clk_rate);
+	ret = geni_se_set_rate(&port->se, clk_rate);
+	if (ret)
+		return ret;
+
 	ser_clk_cfg = SER_CLK_EN;
 	ser_clk_cfg |= clk_div << CLK_DIV_SHFT;
 
@@ -1513,7 +1515,7 @@ static void qcom_geni_serial_set_termios(struct uart_port *uport,
 	/* baud rate */
 	baud = uart_get_baud_rate(uport, termios, old, 300, 8000000);
 
-	ret = port->dev_data->set_rate(&port->se, baud);
+	ret = geni_serial_set_rate(&port->se, baud);
 	if (ret)
 		return;
 
@@ -2039,15 +2041,19 @@ static void qcom_geni_serial_remove(struct platform_device *pdev)
 static int __maybe_unused qcom_geni_serial_runtime_suspend(struct device *dev)
 {
 	struct qcom_geni_serial_port *port = dev_get_drvdata(dev);
+	int ret;
 
-	return port->dev_data->power_off ?
-	       port->dev_data->power_off(&port->se) : 0;
+	ret = port->dev_data->power_off ?
+	      port->dev_data->power_off(&port->se) : 0;
+	if (ret)
+		return ret;
+
+	return geni_se_set_rate(&port->se, 0);
 }
 
 static int __maybe_unused qcom_geni_serial_runtime_resume(struct device *dev)
 {
 	struct qcom_geni_serial_port *port = dev_get_drvdata(dev);
-	struct uart_port *uport = &port->uport;
 	int ret;
 
 	if (port->dev_data->power_on) {
@@ -2056,8 +2062,8 @@ static int __maybe_unused qcom_geni_serial_runtime_resume(struct device *dev)
 			return ret;
 	}
 
-	if (port->se.has_opp && port->clk_rate)
-		return dev_pm_opp_set_rate(uport->dev, port->clk_rate);
+	if (port->clk_rate)
+		return geni_se_set_rate(&port->se, port->clk_rate);
 
 	return 0;
 }
@@ -2116,7 +2122,6 @@ static const struct qcom_geni_device_data qcom_geni_console_data = {
 	.console = true,
 	.mode = GENI_SE_FIFO,
 	.resources_init = geni_se_resources_init,
-	.set_rate = geni_serial_set_rate,
 	.power_on = geni_se_resources_activate,
 	.power_off = geni_se_resources_deactivate,
 };
@@ -2125,7 +2130,6 @@ static const struct qcom_geni_device_data sa8255p_qcom_geni_console_data = {
 	.console = true,
 	.mode = GENI_SE_FIFO,
 	.resources_init = geni_se_domain_attach,
-	.set_rate = geni_se_set_perf_level,
 };
 #endif
 
@@ -2133,7 +2137,6 @@ static const struct qcom_geni_device_data qcom_geni_uart_data = {
 	.console = false,
 	.mode = GENI_SE_DMA,
 	.resources_init = geni_se_resources_init,
-	.set_rate = geni_serial_set_rate,
 	.power_on = geni_se_resources_activate,
 	.power_off = geni_se_resources_deactivate,
 };
@@ -2142,7 +2145,6 @@ static const struct qcom_geni_device_data sa8255p_qcom_geni_uart_data = {
 	.console = false,
 	.mode = GENI_SE_DMA,
 	.resources_init = geni_se_domain_attach,
-	.set_rate = geni_se_set_perf_level,
 };
 
 static const struct dev_pm_ops qcom_geni_serial_pm_ops = {

-- 
2.34.1

