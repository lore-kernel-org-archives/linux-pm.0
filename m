Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4FBF347521
	for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2026 17:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784049519; cv=none; b=pW8GL2cwBoxUtrrZDi3hBrFGNcJxVgozu5nMLfeK0XFC8XdkwaXDahfO3P4xFj9jRMfjdSAgzAcWYiF4ii22Mjk8ZtcA56lFvLkXvPNCKpM4uvyfvJsMAhm8xXnpgpNw+lTBi+leW9izyHqWdKqYd5WTuRPenWPhgpdRF1H4EMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784049519; c=relaxed/simple;
	bh=Z/HoJXdAtZ7QJgARbgQpZ4UcAlYil6V3oBtsMpR4ihE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hSfJWcx8GcoTiUH1nvcwM5gRwndtIVR0TNbTeMUkV0DNh6gA/j7CK5FWN9c8/3L4yMpTd2RFZp8Yzef8YuJKjYYJsxNDZOuS4nMYA/SgvCni1j2eKDMC/BTXqWKeZAEdPkShLot4z5ylsRzgbUBqwB/7ULvC6zl7W89BjIqGdVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SyMiKhuB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dDFy5/bk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SyMiKhuB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dDFy5/bk"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66EG6v9b975527
	for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2026 17:18:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Lgh4YODdsRL2iadze+USZ/JyD5VPsxlZsZRCppKGG/c=; b=SyMiKhuBEFGFFMOG
	LAglW1TGtpv/TspKS7Wg3pvdduKYdbbfmGDlAH7ZKt8tBULqrXsn9uiHVVJkDgoG
	W+B9IpwImW9+7Yn1J0t5CeEhONPr8r5gxb1vOFFGPWRDiXINfSu6IhY+XMvE9OLN
	RMTd9uyxtWqVBfl/ZDUuqhXKNL80/B11nO4AqON2iXz5ghYKsCQcKRqsMKqBnJJ+
	pY0P5grkstTY4pn+v6idCcmd+u2VfipEYrotii3oFGfll7NjymxlsXncsMuVzvZH
	6A+G41QOBNlW1UHBofIp1ZcElq0iuK3oR/CXChgkp88QfmAr2TVMyuwXZmKyQiZk
	+w70Fw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fdgeq2dba-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2026 17:18:36 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-84a3514f912so4530852b3a.3
        for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2026 10:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784049515; x=1784654315; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Lgh4YODdsRL2iadze+USZ/JyD5VPsxlZsZRCppKGG/c=;
        b=dDFy5/bkVoGgkwxNBq+RqB/aezs7hIVfpFLn0f3cPa0bIk4XGEACMQA9vul24jUJzE
         KEc34VARLBfBJdP+K9llZattCCC6ekDRTB5kdtLLEtb/JOh/EUNPwd1MVW+h7W2tEmZT
         YK/olDffu7t649rhisbWasscu1DFiDTnIc1tIw+6Cu/zMQ6B7Ruf6YIcFzcDkZ0UEKCZ
         PbGE62FCJ1fS9rq2xYoiw5ldGAMSFS3YcYGnZhshtzB4b0VuQpucMdm0hXqGXK9rTELM
         h/Qx9hs4iX5df/0FYOZzJ93BHOlmHBaQeOWf3aN5gQTBxMtoNihWH/1EkWBqeoLVsa0W
         F1ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784049515; x=1784654315;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Lgh4YODdsRL2iadze+USZ/JyD5VPsxlZsZRCppKGG/c=;
        b=SwXX8uewW+rl5mwclbHuCajEHLa6IUMv6ajajP6PikwkuxyxKiUva/gi/gJSthedn+
         Q7Bri4UuLNh0WqXND6Bc7nptgH7Us483eWT26i8zQaWtFVckl0nxNKe7jgo+Yoa5B8y7
         a5MvADf4tTlbtP35rbelHK3lZe8+lI8zC+7pbvYoi+MAy6Ht/uQSspAspvzoPvdFJmgy
         +R3BbXNpZXwhP4BDYAxbm47dMD1P9+5F+DijC0X1Fp36fuF6+sfxghWorLv5fHNYeQww
         Htiri8H0rJaDEhMfT8FZH+DAorU+aDebzBbPpOru+EHlaRyKNFYl8n6LnQthiEkfRslb
         1eBA==
X-Gm-Message-State: AOJu0YydQKFjd3geBC+48kslctwKXCuuTS6kp+N/+W91U7Mo1VyKGjJN
	46Xq8JHC2Cu/28ifzHeyYH+582dL26MWQDj+edCbZxcIP/IoIfL2sa6C3lhUqG/6ZZbXrL2g2W8
	VHd8pavopagTIxUQN5JL+DW5KyPLUqvn3bh/xtMhvQx3I76XqMSuGlr0syuLVqA==
X-Gm-Gg: AfdE7cnvR50bFV7iku3kjSUUiJnRTo0G7Puo821sf5wQDyx8B824OMPjWfI/sAV+oEf
	WmYXCOn48pqEFUEc8dkY/unHDb3STM50VUfQ/LSAeexsZqPqbyFxpn25PPH5lWLoX6KLddwGMA+
	rN7Chlzi1C92TgmyExPF30qHvOlPR7zsNHVVYbV1u/OBZd/1H1kw0Wc2wBuYDlq174huajAbBNT
	jW6X2MDq3BinagQb7ZXPFU8b/DaVQqg+JAxVxwRBwpdxLh/34j67wXECn4WeZcd/pF4OXBWM/ql
	YlNM0kItaZrJGdjCDkaz5otOJVJ9R5eBjn8d4rKjPnPEvz7g92Rd6EM5FGeyUpzO3r1B/x/yKa2
	+pwNanOcKusjCVo4PYSwFDgc+LTnndzyOKVVvOxXrkxrwQFA=
X-Received: by 2002:a05:6a00:a0a:b0:848:2f73:8ffb with SMTP id d2e1a72fcca58-84a51658d90mr4261328b3a.68.1784049515427;
        Tue, 14 Jul 2026 10:18:35 -0700 (PDT)
X-Received: by 2002:a05:6a00:a0a:b0:848:2f73:8ffb with SMTP id d2e1a72fcca58-84a51658d90mr4261285b3a.68.1784049514895;
        Tue, 14 Jul 2026 10:18:34 -0700 (PDT)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84a5bfcc2e5sm731773b3a.56.2026.07.14.10.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 10:18:34 -0700 (PDT)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Tue, 14 Jul 2026 22:46:39 +0530
Subject: [PATCH v23 11/13] arm64: dts: qcom: Add psci reboot-modes for
 lemans boards
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260714-arm-psci-system_reset2-vendor-reboots-v23-11-e7453c548c21@oss.qualcomm.com>
References: <20260714-arm-psci-system_reset2-vendor-reboots-v23-0-e7453c548c21@oss.qualcomm.com>
In-Reply-To: <20260714-arm-psci-system_reset2-vendor-reboots-v23-0-e7453c548c21@oss.qualcomm.com>
To: Sebastian Reichel <sre@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Christian Loehle <christian.loehle@arm.com>,
        Ulf Hansson <ulfh@kernel.org>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Andy Yan <andy.yan@rock-chips.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        John Stultz <john.stultz@linaro.org>,
        Moritz Fischer <moritz.fischer@ettus.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Sudeep Holla <sudeep.holla@kernel.org>, Ulf Hansson <ulfh@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org,
        Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Andre Draszik <andre.draszik@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        mfd@lists.linux.dev, Srinivas Kandagatla <srini@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784049398; l=2178;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=Z/HoJXdAtZ7QJgARbgQpZ4UcAlYil6V3oBtsMpR4ihE=;
 b=NaGRjqx/cA+/1xxaf4JRY1stuUiBVDE4/O5+Y6k9ajUNbjjxsYWFrascqLHoEHnRcwwMr0haC
 V0njs5oGlkgBrHPIGEO6WpR56MRLhWFK/13OcpxwoIQxt5U9fMLpEoP
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDE3OCBTYWx0ZWRfX/AkCXp5vtLUf
 fI235reCz4Pl4esmyUYzRz9S+cRsUOZ8UppEK6I5Jm/6k+71IkB77zCHYKg3Fsrb8VCJa0IOU7G
 juLVgpBGhWpBcoGgNt6/7bxj+XcsMEoEmyOgYxZhU73B7kdlaS7vbqESR6/RnmFUPLHn/O6H5LF
 8OSNATSEOmaulbAJL8QM0oxVGYo1ptotyieQwWmjeru2UN5t7GqzlT8WDy8tnOSXDVaP4Ln6ytL
 df/ZZe+rjcjTXzNRsT++WCa9wG5Yuk2rqsWa+9YZ+iQzCzlrKXQk/0z1q5fGQ0a/uPdy90aTZUf
 j4BKT0RPgpzdruChVwerLsA/6R8x6WgNoOe7qxZlFgbuW8O6V37QAgDa8jnNc0/VifLTCapbmFU
 olKfOV86zD09L26BOBB3tJoHJZl5bKB0vDtd0QqyGRwXJjwOAiuJV9yGJ8gQQIrGK/iM2D4pcIT
 ahaZ1qrgGltgHKTBOlg==
X-Proofpoint-GUID: LXgsP4Iuyxal2VFt9ZdWR5d_jFFdvb0K
X-Proofpoint-ORIG-GUID: LXgsP4Iuyxal2VFt9ZdWR5d_jFFdvb0K
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDE3OCBTYWx0ZWRfX51ya+0Q6ckLq
 OA/7U3a5kC7kv1Xf/HIixre+CFQgpQh/vn5IsFGR0zzcL1hZLUzyA7l1phANgSAXUcurof8+OaV
 fNgbpFw+PaCmRs9EMsZjvVnjoTky1T8=
X-Authority-Analysis: v=2.4 cv=V9VNF+ni c=1 sm=1 tr=0 ts=6a566f6c cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=t9IVmYW30V31rltyR78A:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_04,2026-07-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 suspectscore=0 impostorscore=0 malwarescore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140178

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
index 3b0539e27b51..55a3fac0c4c6 100644
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

