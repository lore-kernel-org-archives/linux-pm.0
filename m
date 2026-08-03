Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872D63655CA
	for <linux-pm@vger.kernel.org>; Mon,  3 Aug 2026 09:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785750389; cv=none; b=QPU2YzCGPcCQZo00cQuVTxkq0Z7/4DHEzbHjU/4j14O2lqTQcCU4cGvptx4pVjXhHHcM5fOqymVDUwCiM2CPP4EIDz6WUmWvWFQQRBkebCxzoVjYFQeGKl8DGid/ixCQsUb1KlChuKRZpYgSNByTFAtiBK9xdShHapmCV7EDvlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785750389; c=relaxed/simple;
	bh=eX0gyJVSoiIZC4uU3tt6tpOvtTx0GJUfdT5GBO9fTMQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sK5vii8flh62ofx278KKlIyhzCGdNLE9+8edHPJnd8E5W7FKHHcL/RliyUP34ysEu0e47nKd9j+lBvjRe30Q3KgsCsQJSJVumjliza84ZFahr61Pps7Z6yFazUSuSJnAwLBtwYac4PQ+jmONWSgkioMLf18g88ildt+AIZkX8qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ljwniybB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hfiM9/1f; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ljwniybB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hfiM9/1f"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6736bDaY3956927
	for <linux-pm@vger.kernel.org>; Mon, 3 Aug 2026 09:46:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RkbUYnG5QVUwJjpx/m9+iBpC8gUP3/hJ5OfATJdYexg=; b=ljwniybB8G58AIXW
	p/ACoAOs2h09mwEO+AJP0ukYht9lNoqDX+L4DsIfDm2tJwQm+WzTUVwYKSPqsczN
	nZmoEPasbwOwXUPFtrR4sgucdpVAT+wYdZEoYHDn6jy5GhAUtCnnRfk6lJerEqTr
	p6hC/waAu05Yll1Vhei58EkbweInvItTDmNCwvqscXMwMyje4E/xkKC2D6bq9DU6
	zsnbAlqBH7sD/LGOkAXW1PYNBkkxiWyuVHoAqEINhw8EQf9+YoVqU/ZWSvkserqF
	kna5soRi9/n03t7be2zbat68tMUskFgE9HigAwfRl10hg4HLYtIPU3HFBAjwVyHX
	TADBAw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ftnvngue6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 03 Aug 2026 09:46:26 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38dbe39ce62so3055991a91.0
        for <linux-pm@vger.kernel.org>; Mon, 03 Aug 2026 02:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785750385; x=1786355185; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RkbUYnG5QVUwJjpx/m9+iBpC8gUP3/hJ5OfATJdYexg=;
        b=hfiM9/1fuLbCWJ0lczIjuezKclwgNjmc3e6gbH1gMyfxQnIQ41VbhD7/t+5BaD+MrR
         27aaTiYGPimu4cVNZkpxbbn+Hy6Q7X3a6vxlMuFmxkiRUXgSgZG8IqMHiEDNN5sTbcd+
         4rjJ9Au7xF6SnOTlLzrRBRBdGGL8NXN92O9sopRoZvbwGM9tR398vTLRczAFCh4nG0rv
         2lmIUt1s5Kh/zzoIyhOVHVUYSUJBLv8dOonkj0XJwSlLASxAs5KQJyeKoxvnBGBL/kTm
         YO7j//RSr2If7jsx/KJpQLgLsdEzkza/73fxx/avgibP0+CEvINptz4gzy0wq+xNBmKt
         kO2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785750385; x=1786355185;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RkbUYnG5QVUwJjpx/m9+iBpC8gUP3/hJ5OfATJdYexg=;
        b=knhaXRBrEt6eFfX7xHA3J26NCW9mAD9kjdQcuPGdlUxmZLn3lD9x4PXd6QfdQuAW2+
         3AJwYPuIluOqh59koWUfLxD9tjT61kkQ0pPhxS//eckLjdXJHhMnRF/iQmM052hGAXyn
         qv9++f7wLN61Ok+iFR4ikQzZBQbrInC8GpiLzix9fp6dySph7A3iVmPxYLwBTLlfyW8l
         QqGfL2joC9O8dtku/Bdxqj7ZpexvRq6vUVWqBBmpLN4HfwDC1NBzXfYdJ75d2CRWkQGn
         tH1BIyn9QGHl6Acks//cpXz46sq8hvB1xg0zfIsQ8ok4fVItFU4wpleiHNLWGJ9J52cx
         cB/Q==
X-Forwarded-Encrypted: i=1; AHgh+RrNGl9C1sbde0u+DwCp9vGKD5XbWFslrnEuGKiZFVh27M2JioHdg4OF1X7bkEGwTcTx1QLHbpV94w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxS0GpVw2aZK9YczmLfA0/epwerc/JNTUQNj3tipZ169Lwik6LV
	rw3YwUGFPI953R3O3xbIsIALe7Z3P9XSH/tAO7gSvHw+nMlZZdOWC29+i2w8ifpNHmKFUpycR0W
	tkwB8qQU+jNJOINX2APdjZa8NUBCjyx7DUWi1c4KzkAZvA/+4AwprsgZ8KrZHVg==
X-Gm-Gg: AR+sD1280fMtNh3g8kqmO3gY/R/5g3tnpBtK5rq6NudrEU42GmYKTooVLuy2Ddcgans
	UBqUvP6dKiNzTPMZyywYMa5wtG6sU8lD2Yc96ZjJUloN4BQF93NNAhoGPQrXfIhnL41WwDAw0lK
	saxuuQX4Hqz2kdn309JiHptDbZb++5qVJsBQ+lfrkOC7/dbd6BwwjzG1BIOULnbTsdmQLegl/q9
	lisgAm0nYc5tCj6SAZiXu/AZP4l+3DTZhzkAJG4RrHsJHZTa7+9opjigugl+hRLAYZw/3AfKyeS
	S0q/n874gP6Ko09B499pLdBjxD2lvTpFI+BQSjBjP/lQq6qAwgjEBJ4wYhOPbZCElWSU5HQmVp0
	56XxeX1ehgQEAUQj5vJFjy+EJBnuq/jLDYRF7
X-Received: by 2002:a17:90b:1e46:b0:38e:4f42:d0d6 with SMTP id 98e67ed59e1d1-38fbca8e5e6mr7069166a91.12.1785750385366;
        Mon, 03 Aug 2026 02:46:25 -0700 (PDT)
X-Received: by 2002:a17:90b:1e46:b0:38e:4f42:d0d6 with SMTP id 98e67ed59e1d1-38fbca8e5e6mr7069120a91.12.1785750384847;
        Mon, 03 Aug 2026 02:46:24 -0700 (PDT)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38fb2be6c8csm3660671a91.13.2026.08.03.02.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 02:46:24 -0700 (PDT)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Mon, 03 Aug 2026 15:13:41 +0530
Subject: [PATCH v24 10/12] arm64: dts: qcom: Add psci reboot-modes for
 lemans boards
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260803-arm-psci-system_reset2-vendor-reboots-v24-10-889281373870@oss.qualcomm.com>
References: <20260803-arm-psci-system_reset2-vendor-reboots-v24-0-889281373870@oss.qualcomm.com>
In-Reply-To: <20260803-arm-psci-system_reset2-vendor-reboots-v24-0-889281373870@oss.qualcomm.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Andy Yan <andy.yan@rock-chips.com>,
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
        Bartosz Golaszewski <brgl@kernel.org>,
        Sudeep Holla <sudeep.holla@kernel.org>, Ulf Hansson <ulfh@kernel.org>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Andre Draszik <andre.draszik@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, mfd@lists.linux.dev,
        Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>,
        Srinivas Kandagatla <srini@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785750274; l=2178;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=eX0gyJVSoiIZC4uU3tt6tpOvtTx0GJUfdT5GBO9fTMQ=;
 b=RINqxFXiKRYq0XQfmxM1CrYk2MUvveTibsQb+NSF/OZeeVCPI2iDfg9IvXNAtieahlF3sAyLO
 IGXmJGGc147AIH6szVfuhfSfGdVZqIIEioAPxE+NSIFUkr3ZbV73cx5
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Authority-Analysis: v=2.4 cv=aoaCzyZV c=1 sm=1 tr=0 ts=6a706372 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=t9IVmYW30V31rltyR78A:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: tHDlFXUJ5o_MSjARk8gyWHu1M-IYddBu
X-Proofpoint-ORIG-GUID: tHDlFXUJ5o_MSjARk8gyWHu1M-IYddBu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDA4NyBTYWx0ZWRfX7q4nQN6LcSE3
 /hNqeSfRRnNqK7GaA08wRuKrlAwsinLJMClO0IbmZ5XnnBtiE9Q8GJZMKMuv9OU4i27Cxcd18Am
 vWmiVyLrinhIqKHnsLZlkD7I2mQsCbwGUKBVIfG/AuUdQXQA6KSnfaeH1E+7Tfht2uLbN10yBGn
 AC+R35af/XtP558OWKEMzt/U3vXQsv97uuytTmCJClXAN1OaCksnKGDiRZ3D/5IpCYojcLpScet
 W5l4SGfvNINaKDGa+lA2JAWWjWlh2u+f8EOBTuwUa3W0w3APjh9b7xTSRW90uTTJkkkdxIaEBwh
 /bWhTggjbJlV74ZIse2jO89uIbquya19SiHjU7EKqk5U/WoZ6TjF7Y2F+rIWpJYB26Ude78/DcI
 vOCfnfzZa1yxSMhN3CTk0AkoijKmHOXs87XBUcss4yisKd6ujKRgpgkKq4B4utPSG2DbVNDHSUg
 P0J/ZReuKuH1T7NXCdw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDA4NyBTYWx0ZWRfX68/a0feZw23z
 V4DDNfzZQKiogV+4v3X0JhXDoNcqSTOg9KtOn15yAldFXAojMPUEgWYNTs4jO9Vl2EGiadOp95b
 c7SboDHQqnuIEz32hlLahEOCHSeEwEU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_06,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 spamscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030087

Add PSCI SYSTEM_RESET2 reboot-modes for lemans-evk and
lemans-ride-common(sa8775p-ride, sa8775p-ride-r3, qcs9100-ride,
qcs9100-ride-r3) for use by the psci-reboot-mode driver.

The following modes are defined:
- bootloader: reboot into fastboot mode for fastboot flashing.
- edl: reboot into emergency download mode for image loading via
  the Firehose protocol.

Support for these modes is firmware dependent.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/lemans-evk.dts          | 7 +++++++
 arch/arm64/boot/dts/qcom/lemans-ride-common.dtsi | 7 +++++++
 arch/arm64/boot/dts/qcom/lemans.dtsi             | 2 +-
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/lemans-evk.dts b/arch/arm64/boot/dts/qcom/lemans-evk.dts
index 0c53640c42a6..3baad102270d 100644
--- a/arch/arm64/boot/dts/qcom/lemans-evk.dts
+++ b/arch/arm64/boot/dts/qcom/lemans-evk.dts
@@ -911,6 +911,13 @@ usb2_id: usb2-id-state {
 	};
 };
 
+&psci {
+	reboot-mode {
+		mode-bootloader = <0x80010001 0x2>;
+		mode-edl = <0x80000000 0x1>;
+	};
+};
+
 &qup_i2c19_default {
 	drive-strength = <2>;
 	bias-pull-up;
diff --git a/arch/arm64/boot/dts/qcom/lemans-ride-common.dtsi b/arch/arm64/boot/dts/qcom/lemans-ride-common.dtsi
index cefb8ff00806..cc96442403e8 100644
--- a/arch/arm64/boot/dts/qcom/lemans-ride-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/lemans-ride-common.dtsi
@@ -800,6 +800,13 @@ &pmm8654au_3_gpios {
 			  "GNSS_BOOT_MODE";
 };
 
+&psci {
+	reboot-mode {
+		mode-bootloader = <0x80010001 0x2>;
+		mode-edl = <0x80000000 0x1>;
+	};
+};
+
 &qupv3_id_1 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/qcom/lemans.dtsi b/arch/arm64/boot/dts/qcom/lemans.dtsi
index 17bc5bcd9d09..cde157f6d7c0 100644
--- a/arch/arm64/boot/dts/qcom/lemans.dtsi
+++ b/arch/arm64/boot/dts/qcom/lemans.dtsi
@@ -549,7 +549,7 @@ pmu {
 		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>;
 	};
 
-	psci {
+	psci: psci {
 		compatible = "arm,psci-1.0";
 		method = "smc";
 

-- 
2.34.1

