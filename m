Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741985304D8
	for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2026 12:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792069149; cv=none; b=LZ/wrON7jWdiY0wB1zlNNFy8sPsNyRR7ygHuY50ltYwAOLOKF+vWTtwjRdcyI/35Y5mBfEUmYB8HAy1i5gX6r5mU1+fAmC7b7gjnenkE/CtM3JQIkG2ruTFCf5Ch+GWSpFH1Vuogodyyu24AvxPV2jM3oAmKq6Me59P0iXvOBR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792069149; c=relaxed/simple;
	bh=D5hDXPqe2PtFIqZaUJ2ZeOjQJToEsTsjm2AhJE0Nzdk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Cbv7HRAcT+bb9BZ4mawl48/lPZsNPJiwH4hHBftsHyW4vGY0331J7vbKBH8PRehXLmbkwnPVt2aRE+B82zAfssKR6pElxLwEBrjv0rf6h4iQ9cUiPrcPYYuxdiz64QwdMnJX/bK+2zEKGsG2pLI9M22fQXm0hr3V6g/7mUZ30Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dqQmgL6v; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ie7BNMKB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dqQmgL6v";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ie7BNMKB"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69FAPw3M1596384
	for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2026 12:59:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NS2pUTAJCmRHLkgfAwlsRgGb53nRJ44v/R3W8FvO4mI=; b=dqQmgL6vp4PFkhuC
	CS6MnN8QxsWP5+oi+CL+5Ppxaz4VgR15olqIliTcpLSHquVdu11wWamEaJH6X+rJ
	HzrazjJTKFCvmdZvh8csqzLkKmCOBQp5NSHtkqOAzUuODetnSsZ/3+ABPXvy2rHN
	gqObXhNofizvk/gbrmj4ZdvOk09vzjc2nqsBQKBdbsEreJfQ1EuMl4FFjuWrSTq8
	8f1HUkFWJ64sf3o3A0sMe36CJVq6yzqLpWE8h0lymf3YOptc7M5xsfw6LId/IxMW
	ae6qZaW+Cfqp9n4HCpJ6ImhMUnWkQuxGaCYVOLYdeWWnju42jcpUVT06qMDuifuL
	Sezoyg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4haw2v8hp2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2026 12:59:06 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2e93f67358eso17930765ad.1
        for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2026 05:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792069146; x=1792673946; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NS2pUTAJCmRHLkgfAwlsRgGb53nRJ44v/R3W8FvO4mI=;
        b=Ie7BNMKBrmT9E0qz4a2SnH9RtX85Xr4AtPLcWtYxz8dJwK08kltAJWRiEhThVdsX0/
         6FHgcK5spWtFXhiRoBKobv1/8YCSYtHPt/jHcNIlsaWJrKkWtfkCKC7OCQGmVmrqVHfj
         +p1yRmS8mgCDKNdFm1P66szE232h5uk2hFMOkRjVLwmKVl6M655biIBjDrcObOKm8s/j
         NNIg8UBK/4qy/nQ1lAw34AtLp2iT/JIx7CJQqYRsWA6Kvy2YzKxYg6sRNTt6EUHwz71J
         Ez4bnfpGaJwu/Dobrx+X8abxIbdbn4jl7cNSkz2oJv/vKrOE8ml/pWMW4sdiJs7Zsjgf
         u9fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792069146; x=1792673946;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NS2pUTAJCmRHLkgfAwlsRgGb53nRJ44v/R3W8FvO4mI=;
        b=vkzfyFOx0+xwvubniftaQzXOKYwUhqP/YWSYD4PyPWTHzZalkJMz2vFZgy5CiTt9cR
         /XzU368GGm/4xpZoNJyPA10tc4Kbgr44ADwVE1tokzA7SUmkwTaqO22dgaqgC/UaY60X
         cplwwJq7YokIzUHHfLmHvPKav7kEopE06+wLU3IVFmTALFIFmmzLsU6vkAvk5NOoiJNW
         bzUzG1pb/qNpdSD0KLQhGhZ5CuMEPR9+Xyq3PvDndD3zkz6fZ6lKU5DolvzpmwpspjMX
         GnKE0DG/hr4LhWRVdq29v5JbFXa668BAe+6pg61vQrsMAFXkSmXux5XgpndySm6j7Lyg
         13JA==
X-Forwarded-Encrypted: i=1; AKwUvBzx/Xxfv+PaQj79OTCzUxaAFmTfRpeatWMCQN4S4tqLqp/Zn+NQLJROXpnZ/uBXh8Cdf+QU4eQo2g==@vger.kernel.org
X-Gm-Message-State: AFq9FYKqE+AHp9JOrgwDCP54wCAmVZaJZ6QRtsl485flG7w01zKu3rlL
	7iY2/pozJgQTMi3tu7h3n8NwrmJPYOmxlJsS3o1CGncnLfJqAjgVXzS/O+JoQChmlI/rEjx2ROw
	24KQ/PZ2WRhvG7YQcMgXDstqO88VwwFxrCFZ6ihMiPo8sHhn+2ZtgczGraFm9OQ==
X-Gm-Gg: AYBFou2OR54fph/1uxVwu5TDK/NfPktwMLQcYMikADzdlkpdPXUrw4X8eaKv8qDkBvm
	bblcZz66kSTbu9A5RMSjWM/5/UpMLUela9t3CztXw0PKXGbCKcw4x3JEuTR7gfi7R6GK+bGBdz8
	vEtRnb4OLyEzdbgZLQnqeLMTk0sqqa7tzpqOdYo6JMGHpghcHGZvu1fZuZUFeEYmdi0pRsuQONV
	HjZKi6XTZUs16S8rlswVEWGJN4sguuuHABiOy7WGP4CDb6jbi7c5KAtKBlVOHLS7z0dW+6njnZt
	6GgEP4RSwzXmyHYGfeJ8Dn+IFJ6QoRaeUWkiJOs27/GLEAdf7xLY3XC/3O4bYmXC+9d2CVCuNrR
	oh+i9nH6FG2BRs0y55aCSaohsty4OSYSsDA==
X-Received: by 2002:a17:903:950:b0:2e6:136e:f264 with SMTP id d9443c01a7336-2e842dfd193mr157615355ad.50.1792069145927;
        Thu, 15 Oct 2026 05:59:05 -0700 (PDT)
X-Received: by 2002:a17:903:950:b0:2e6:136e:f264 with SMTP id d9443c01a7336-2e842dfd193mr157615175ad.50.1792069145289;
        Thu, 15 Oct 2026 05:59:05 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e8422b8d8dsm79691705ad.52.2026.10.15.05.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 05:59:04 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 18:28:24 +0530
Subject: [PATCH v3 4/8] serial: qcom-geni: Use geni_se_set_rate() for
 source clock configuration
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-derive_clk_perf_tbl_from_perf_domain_opp_table-v3-4-5da1096243c9@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792069108; l=4422;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=D5hDXPqe2PtFIqZaUJ2ZeOjQJToEsTsjm2AhJE0Nzdk=;
 b=Q4kkifXtTtFt+/FI1kJOZPyXpAvkQJINudlhQ791bX1hDNv6w8bQVqILWfb0Sqwd3nTpWAdio
 zufOgeYtOUXCyNV78WhYHNUkCWyL9FbCQlPQV+thGdv3SeN3VsB8W0L
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA1MSBTYWx0ZWRfX+Ky5WATBYXUT
 h3NzyJkMJjh29/LUIDtVGWrXQqc6V6M6Svu4O3/d12dg7ABog44I/lXotjPUa61oiUjXU/yHLTA
 8d5xGxyn3VwX+eEK3zbnluD/poME2FqoVVAZcrCqto06ITfxz3D49Sg7g1ZHl3QyFhWh+0Ls0Xt
 sYlJ6X+wMvfUSYt3WwtLN4w/yDJTZos1uC+MLAs6ipsXaYx8Kq90n29MrIHnibTiUBnu/p5PWsR
 N+vx/CXjxXXwKX0KsiLiy2xqyx7kQBEZmV0gBaxQW51IixZRxhMEJpcYWusYR3HbJLlTQI9/bVt
 dOlsZ3VnpzYsralFm8nzazrcst5jrHBH5eHzpeGVk8dMWfmuK1ji/P8oQDBIahCc2Y5GE5qEznw
 VNxOY31kAMyHCb59JJtCinpCsmTBg/+UQrCRQ98NanGzgQ8J6X9HjZy9Vrh7hyf/vZmplr74A1m
 XXtFK5CkcUel8PwPYrQ==
X-Proofpoint-ORIG-GUID: HNN-fRl8UR-R6aAXdBTWE2jVkqObQ64r
X-Proofpoint-GUID: HNN-fRl8UR-R6aAXdBTWE2jVkqObQ64r
X-Authority-Analysis: v=2.4 cv=G/CJgNk5 c=1 sm=1 tr=0 ts=6ad0ce1a cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=_eeGUSGHzPgYkwSUgSAA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA1MSBTYWx0ZWRfX+D9Gr1lfpG4Z
 IaatZOKqqs6UG5u7SVv9dbemb/SP2yXgmzRLxOVeN3fMDlg/7DyJ2jc+egsYGwyKMonruZIqSN9
 38r0Nqm1QO04Vl1nM0nOLysATuFvgss=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 bulkscore=0
 impostorscore=0 suspectscore=0 adultscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150051

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

Reviewed-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
 drivers/tty/serial/qcom_geni_serial.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 4a6f526340b8..23e423009255 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -113,7 +113,6 @@ struct qcom_geni_device_data {
 	bool console;
 	enum geni_se_xfer_mode mode;
 	int (*resources_init)(struct geni_se *se);
-	int (*set_rate)(struct geni_se *se, unsigned long baud);
 	int (*power_on)(struct geni_se *se);
 	int (*power_off)(struct geni_se *se);
 };
@@ -1461,7 +1460,10 @@ static int geni_serial_set_rate(struct geni_se *se, unsigned long baud)
 
 	uport->uartclk = clk_rate;
 	port->clk_rate = clk_rate;
-	dev_pm_opp_set_rate(uport->dev, clk_rate);
+	ret = geni_se_set_rate(&port->se, clk_rate);
+	if (ret)
+		return ret;
+
 	ser_clk_cfg = SER_CLK_EN;
 	ser_clk_cfg |= clk_div << CLK_DIV_SHFT;
 
@@ -1499,7 +1501,7 @@ static void qcom_geni_serial_set_termios(struct uart_port *uport,
 	/* baud rate */
 	baud = uart_get_baud_rate(uport, termios, old, 300, 8000000);
 
-	ret = port->dev_data->set_rate(&port->se, baud);
+	ret = geni_serial_set_rate(&port->se, baud);
 	if (ret)
 		return;
 
@@ -2051,15 +2053,19 @@ static void qcom_geni_serial_remove(struct platform_device *pdev)
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
@@ -2068,8 +2074,8 @@ static int __maybe_unused qcom_geni_serial_runtime_resume(struct device *dev)
 			return ret;
 	}
 
-	if (port->se.has_opp && port->clk_rate)
-		return dev_pm_opp_set_rate(uport->dev, port->clk_rate);
+	if (port->clk_rate)
+		return geni_se_set_rate(&port->se, port->clk_rate);
 
 	return 0;
 }
@@ -2130,7 +2136,6 @@ static const struct qcom_geni_device_data qcom_geni_console_data = {
 	.console = true,
 	.mode = GENI_SE_FIFO,
 	.resources_init = geni_se_resources_init,
-	.set_rate = geni_serial_set_rate,
 	.power_on = geni_se_resources_activate,
 	.power_off = geni_se_resources_deactivate,
 };
@@ -2139,7 +2144,6 @@ static const struct qcom_geni_device_data sa8255p_qcom_geni_console_data = {
 	.console = true,
 	.mode = GENI_SE_FIFO,
 	.resources_init = geni_se_domain_attach,
-	.set_rate = geni_se_set_perf_level,
 };
 #endif
 
@@ -2147,7 +2151,6 @@ static const struct qcom_geni_device_data qcom_geni_uart_data = {
 	.console = false,
 	.mode = GENI_SE_DMA,
 	.resources_init = geni_se_resources_init,
-	.set_rate = geni_serial_set_rate,
 	.power_on = geni_se_resources_activate,
 	.power_off = geni_se_resources_deactivate,
 };
@@ -2156,7 +2159,6 @@ static const struct qcom_geni_device_data sa8255p_qcom_geni_uart_data = {
 	.console = false,
 	.mode = GENI_SE_DMA,
 	.resources_init = geni_se_domain_attach,
-	.set_rate = geni_se_set_perf_level,
 };
 
 static const struct dev_pm_ops qcom_geni_serial_pm_ops = {

-- 
2.34.1

