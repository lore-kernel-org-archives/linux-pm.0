Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF253A382F
	for <linux-pm@vger.kernel.org>; Mon, 28 Sep 2026 06:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790575861; cv=none; b=oEEnrfhhrfwt2ucebPqhBVG1swqPqoha98CsXOUXLRECFtsK8UPswg+BziOmob4kr9eznxUZ5jOwKVYgIXDh7ZQl64q6gIOfNiKTjzvGza0stAEg9EYGLkHFW3fFuJEt0QEdgonrz4bELN2OFzCtHpf1UjTb8LamXASNkto54EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790575861; c=relaxed/simple;
	bh=HY9fLa8u8u31BscwdrGeQccVQPGFQUgGa2K581SXsxg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UfV2LE+lFY+Xnx+LuHBZSzaqueLvA/PAz+UYLk3tws6kfHwbdjHkCmg5QuIFEAnNRHoT7tsCYq2HpQniQ0/DzS93QDnweFTuO9Ohu5yIki7nrZs0ZDt++Is4v5y6rU5Z9KXsmQRDjbUbCncHXJj6Jm3ERbXjr5KKudetECPuDhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hhYBREwl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=c8sygW0Q; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hhYBREwl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="c8sygW0Q"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68S5P3Y8674900
	for <linux-pm@vger.kernel.org>; Mon, 28 Sep 2026 06:10:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jfT8oPSA0cGLEFSCxt0NN45mGUPgAF14lIogeHiakWY=; b=hhYBREwloagq9SSi
	ckrfC4WjX+v88luweFvE//fkslVqCmhozicPepDxX3uxgLS5hRwHs6UtHpctnvai
	k4qy7E8wIxdPQ5SkTmwbWOcc4DknKhlO5PwfPItlaRwKWhA6LfPaIB7V4Btrv4ef
	EWe4EHcz3WSTOS1saqIKuMAu1Cq6cW+7u/GSmVdh5H9UtN830Ju8tWGD1g5cUals
	UyU4HnCTo2+/iwGTzC2dLVtr8UVMOYBOTbzBXpAIAYWRauFaxnCZi/LGGL1tGvo5
	ywyxI/mH1hkyBtwhUrHscjtccan8015nn940O5kh+DkKF3zpW0wTRpCiMbkfHOf9
	pQrRvQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyj2s04mh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 28 Sep 2026 06:10:59 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38e8e864ef0so2928111a91.0
        for <linux-pm@vger.kernel.org>; Sun, 27 Sep 2026 23:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790575858; x=1791180658; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jfT8oPSA0cGLEFSCxt0NN45mGUPgAF14lIogeHiakWY=;
        b=c8sygW0QQm8iMs94H3GXOD0ylJlirW/04z8QMqjMZrTH+OpknfWucSPAZR0j5gF978
         6fUvphPV3VobRF70IAZqRewWzV1MezMMZUUcTBc6FsRDC/6T+292J0naH3grWrGGghu5
         +B/ys8QIBd2ybQDb5B/5QSL5IxqPzN2FNWZDqNUcoXJGitS/gYqG1VJPVuOj9wCcZ0K7
         /Y6hznt38a4+h8HtzQPsSe4FGWDMhQlLK/a6Sw5J8LriJrtLL8ub8FAyIeQGgV45Q4Ij
         2+He5dNGdAN2H2NRrSir9z4yFaveQVS1zjyRzh7blS5V3cHOikT00y/saVX5mCW91aAg
         WpIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790575858; x=1791180658;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jfT8oPSA0cGLEFSCxt0NN45mGUPgAF14lIogeHiakWY=;
        b=jgEClD5NCnZ02gSrlFXSEDkrzqF/VH8YCeLJSxItBEEATFnVmO46Obzc+NTXXresjy
         ZCPMicx/UnN/6O+xHOJlhdF0uxwAvJ1NZZUc8ZeqKlphaDqFq+wrhXYhYdbVbaKAvySn
         Uo0sIIxDvHek1iio3/WdCp91zxaZDfL+WqqHnjoekWEqX/Efw5li6SNthjVyoYBVv2t4
         KIIFCSgSG686gnvBkZecW+dpcoLNoYpKsFIVBeoxPXzBBi3mchDiYERdINXBWtCohyB7
         07xEkMi/q5klWSW/CFzlejO5DJ35QWA+QrotGYsafSqCENw0xJpWVKKQnhbNHqyodRPJ
         4uxA==
X-Forwarded-Encrypted: i=1; AKwUvBw4lmFvVhxStsx1bZlcIa512PiX1tNiXddiB8lNeKIUfTSttc9f3t2SyiDjjAc7CMO5bg7ZKYdzyg==@vger.kernel.org
X-Gm-Message-State: AFq9FYJF5BEq/eIP2de1u0pnN3UfNrzOKZvXBg+U/ITVSyFqsKF43Dqj
	ZBFaLIddvWyvs2+j/uarIlf8l3DaT9vQWYD38JMMbmOLnRBYdE6izPACENfUct0xuSC3wVGRx7v
	dc7VzpjmnGSaQwfTANPu6Yc2Y64tjPXtj0QdDZ2fHs38FQ2/K8X4ufqrVpOOFQg==
X-Gm-Gg: AYBFou1YkId5SnnajYi9T4RulMoHs+EsArm6k26/T/0IqFjSae1KEjWP0gDbl3cAUAG
	EUvLUeHF1NaaNe1WryIGVbSh6/h4NXUT8jdYGQeL4fcF9T4pgdcrWqQrg5uFO0/m+b2ndPOGUl0
	YG+ZUTpngkcoafOEiELQwmmU787tspB1V5fbj/ve+BtBPz27J8uMcz2Ir+1HLP4KWkS1rOAnbkU
	OlOkM4VElbWvYCSAhIGsuO2iEnk3waFSaD82x2/KF+aEzUHOV7PCkxidlmGMmLq9hiigO2TC3Zd
	UOLb9ltxopEbB6GeUcBch7/bB8yyA3bUL9nN3zAaNJV2Y6/jwWgyA9hfr0wo/l31b9i3J2/Sf5q
	bhE8m6zFWtMcisyr63G3z5RtPiH5hA+vSAdS5
X-Received: by 2002:a17:90b:35d0:b0:3a0:df61:3fe8 with SMTP id 98e67ed59e1d1-3a0df614b3emr3891072a91.13.1790575857110;
        Sun, 27 Sep 2026 23:10:57 -0700 (PDT)
X-Received: by 2002:a17:90b:35d0:b0:3a0:df61:3fe8 with SMTP id 98e67ed59e1d1-3a0df614b3emr3891061a91.13.1790575856656;
        Sun, 27 Sep 2026 23:10:56 -0700 (PDT)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0b8efb156sm20040846a91.1.2026.09.27.23.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 23:10:56 -0700 (PDT)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Mon, 28 Sep 2026 11:39:20 +0530
Subject: [PATCH v26 08/10] arm64: dts: qcom: Add psci reboot-modes for
 lemans boards
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-arm-psci-system_reset2-vendor-reboots-v26-8-b24e2348e8e1@oss.qualcomm.com>
References: <20260928-arm-psci-system_reset2-vendor-reboots-v26-0-b24e2348e8e1@oss.qualcomm.com>
In-Reply-To: <20260928-arm-psci-system_reset2-vendor-reboots-v26-0-b24e2348e8e1@oss.qualcomm.com>
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
        Srinivas Kandagatla <srini@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790575761; l=2178;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=HY9fLa8u8u31BscwdrGeQccVQPGFQUgGa2K581SXsxg=;
 b=ISNKMf7RMjaU+bv5/aCDnX25z901Q9bqAKTDSWTlUTv61Ly921JCiACTAvjmSsgsSC7vVVaDn
 KfWEYUs+lA1AOkcX2OWs5xupnWc1Au1ilF9NORSNXjlWEltiZFYEAKp
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=ssWsJFX3OM9pkdoe4+guOfGPaulHOFt0GVnVlB6on+s=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDAyNCBTYWx0ZWRfXxqCV3JjGyzFz
 usyBHaC1wYZFD5MPXdelK8N9RRUFdkwIP94DlEErYavGUTxPEU1hIsW+gJ9Eco8EUWrmn3eSOJw
 L+NjFeM+ImbL2XYtPJ/Yw2GKj2ALrTzSOhFkr2SlF36uCoViuBmnpt+tuMVhbiClo50WQgP390A
 kgSrkr43dyD77M6iBr7X/W+TU52KzF4aacqEVJUPhmaDxFrh4d7WrPu3WeSrOssi/GQzX7nbTFA
 vdCryyq+o6tP2dVQiFGt41DDGvQKG32t4fA8thiZFIQYViHqFoIChJ1MPNDym/kyB9nKu0F40/p
 cqnFFh9TiySwGK61ijvt5r+Bo4LWWS9ZcH12LMt0naJtgoMb0oI1cS6cnEOTgxjMmKrE48JU/9N
 AWYhso6CMAmZ6ltufUDLM4UdwN77eDsm8HX6e+FzK/te8v7pKTPbBYpFxwB6c8mXwtkQrCU8t0H
 HHNzwJVDwfq52zui3fQ==
X-Proofpoint-ORIG-GUID: b9UkBqwuiQ7BpUcm73PQ4E225u_jU-A1
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDAyNCBTYWx0ZWRfX6kO7lrMfxAVC
 UkLJdek18JtCL9Pto907muJlQXlTrIDa5+C16a1NiiVhkXjVGB57O9Z2WbSfJJfMUQ8s1KyLBhM
 rtwLMe4urDuEJ2vbcWIEWziZWgkvbO8=
X-Proofpoint-GUID: b9UkBqwuiQ7BpUcm73PQ4E225u_jU-A1
X-Authority-Analysis: v=2.4 cv=TptzFzXh c=1 sm=1 tr=0 ts=6aba04f3 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=t9IVmYW30V31rltyR78A:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609280024

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
index a45485b54a5b..87d01acc7b5a 100644
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
index 144f117ba511..0adf9f02c8cf 100644
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
index 695eae1b7256..f0633b81a04d 100644
--- a/arch/arm64/boot/dts/qcom/lemans.dtsi
+++ b/arch/arm64/boot/dts/qcom/lemans.dtsi
@@ -550,7 +550,7 @@ pmu {
 		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>;
 	};
 
-	psci {
+	psci: psci {
 		compatible = "arm,psci-1.0";
 		method = "smc";
 

-- 
2.34.1

