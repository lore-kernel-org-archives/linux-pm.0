Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ACAD481AB5
	for <linux-pm@vger.kernel.org>; Mon, 14 Sep 2026 15:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789398057; cv=none; b=sQvVqgnUS+HK3HXkmHnDupUWQVCitLrnDwAy7oWW7TJdD7hno3DYcNFR2LX7a6i+gOE8ewkSpobmurVFwxwXn3Bj9I78dP3dddH6v1euYxBRCD7HvOxnAY9Xf7fjOsn3kPlA2nSD58onA3mvxViWPG1Nke7yzjVdt6tbAg6ezb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789398057; c=relaxed/simple;
	bh=HY9fLa8u8u31BscwdrGeQccVQPGFQUgGa2K581SXsxg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QMe/hCsiTGnC428ltDkUYFuuKjXQI0gq7r653PHQAg7TjvauXNitJlLvl5kIU2do55w9wAvCLpHEuiPXAI1AI5vMCcJoI8nUJujwWua5DFChltliNJ8ZVaoshxeVXoKyntQdgCGVVjMsERYgL2EW2b/1HMPU1NXwhQjHsSCFtgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=P/cew2hH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FE+LpdhN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="P/cew2hH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FE+LpdhN"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68ED0YA9830686
	for <linux-pm@vger.kernel.org>; Mon, 14 Sep 2026 15:00:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jfT8oPSA0cGLEFSCxt0NN45mGUPgAF14lIogeHiakWY=; b=P/cew2hHZQT7dWMP
	dOgrhAfwUUqvNmkCA61QHC65RV6hkeEWLtXjiK10IczKYcqiVrxE1fQ/eN8P5k5b
	XCuTKUUb+qdOBOjbq5Rq9FckjgM8HQ4fapdpZW5haLnLuhOVFVCHD3pUfwztoax+
	OFSSn0tuK5dnngeoCKoj/oK06I/TdacobsbGxubKDSarCSDv1jGJcSizQWZu84bO
	auQT7FsR9NAhILViOX7aAvsHF1Q30+jUjTASqp3jwQUSTPWrt3Kv3gvkX3ppMS3i
	lqiAUoiHK9p7CPRd3weaNxFQGD1a9ATE+BWezwvVJu7RrU2Mq3NphWA76GXh5ePf
	Amv9aQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gp3hsu08v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 14 Sep 2026 15:00:52 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2d6df0a1e18so66920315ad.1
        for <linux-pm@vger.kernel.org>; Mon, 14 Sep 2026 08:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789398051; x=1790002851; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jfT8oPSA0cGLEFSCxt0NN45mGUPgAF14lIogeHiakWY=;
        b=FE+LpdhNLxSk55h5s4VuNjgFdJrV9qPNzRHASegypnzRfv5oQfMMc6O4k88hT8qwEM
         dgEbugT+4moo/riPVPZQmVwsYmo1iy/Tw1nuoIja7m/LDx4ptIRNww+iT5V6uc/YC0Jx
         RGnKxnjyNWOUNZaNgY/y6mpaIPrzuhxisXTdoz+ZXRyADQdYfhb6nzljlAHS69Hl74i3
         zxatiiuaZ+Krm3/SW46d+2D01FSVK9S1IgExpEu4+dAi7OztiR/0jf8KZjGb9KNN8Lq8
         bcRJefw8M0UZ23kIXqlbBuiDWSCuuWiby22thxbfkjJjY98lxEdLlMZX918lVogbJFan
         3CaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789398051; x=1790002851;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jfT8oPSA0cGLEFSCxt0NN45mGUPgAF14lIogeHiakWY=;
        b=MfMs7bxjLLSwqemelWmJFj3ZEIJfMyRX7lG7aWtHmPGEkuitBOH+UaYSmiCMKOwQI4
         Msv66B1G+9kVd9DaWCOXQZGRoCx6hNuTKt7PrQ37dHadfxDjvnEnwF4EgKP6F1elL19B
         Qiestm6FIRjAi8T4KdmudUNJvv8HaU3N9IcAGg5Qot37ALvSUslMuh/sgz3zKMS0LGi1
         pwXu5gymkh3x9q+mCuFwVpQitGXwOE1A9t+PTb7kUFvNlVKHgT1Re4lkKynXL80Uzd5Q
         MAML4zBgTjt0ZZ5YXf2fN4s+JkSyC5KwR4s5EfaIsUV8wFOJyebwCXAptegVyamcPOGc
         9gWQ==
X-Forwarded-Encrypted: i=1; AKwUvBy4ZC7Ua3JPQiApemzm4Y8C0nHFCv0FucDhpQBBjZCueNhzCOlupwf+QuYu3/g3fqyZDrcOkj+PCw==@vger.kernel.org
X-Gm-Message-State: AFuF++ly7MW4FulsdUTUwbCxHuy0BGseIdSsxeQqZPBtShZpBdRwsRAk
	D6YkMzhp0VoA+I7vk20WcmDqfKSGrZzLX4kGGwrJ3o2831HsG/5BlWI65kjP5dhqOWgFx9rpA5G
	m92kczuD3byLmHyijgTAxCKBAI5+V4BE3luAXzvte0tC64ze4vq2oFFBnFGnGbQ==
X-Gm-Gg: AYBFou0ongb5hKHOrBOJ+BhKVFuNR5e6Ht2sQVZvQ9dHB+6wFLDxSSd5nf8b9uDdQZt
	A7cngG7p6G/Rmz6RSBaX7EoA+Vf5mlOTiV4y9JDqHReeblDvbBeVddMqwyIBR3sxSMjC0EWEilA
	Gs0rA2kvIgI2hzllrhe1nH/FB6KNXuSbZi0t8f9h3RxnyRFp6iW3K4YeEAPUU29Fg+EHDkVHzRc
	ovgrfi+DR00QJ0y+8/blZkZiCt7j0dSLfSGHg2AzhllXqSd/+ZrCDWkE4sP5FBqSmFlLbjc1xoB
	lShsdzTcARE5wPQavw1xUz38I0ru2JfEQqviVdkNdXWCjFjvRwk0LIuP70p552ufR02w0woRp3J
	rh83TYk1fCUw5+klpfAcAl4hVorcI7BBTgl5h
X-Received: by 2002:a17:902:ecc9:b0:2db:539c:b7c7 with SMTP id d9443c01a7336-2dd6c75a41emr62769605ad.20.1789398051325;
        Mon, 14 Sep 2026 08:00:51 -0700 (PDT)
X-Received: by 2002:a17:902:ecc9:b0:2db:539c:b7c7 with SMTP id d9443c01a7336-2dd6c75a41emr62768505ad.20.1789398050872;
        Mon, 14 Sep 2026 08:00:50 -0700 (PDT)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd4007bd4dsm42943345ad.4.2026.09.14.08.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 08:00:49 -0700 (PDT)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Mon, 14 Sep 2026 20:29:12 +0530
Subject: [PATCH v25 08/10] arm64: dts: qcom: Add psci reboot-modes for
 lemans boards
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260914-arm-psci-system_reset2-vendor-reboots-v25-8-4aaf5c09b5c2@oss.qualcomm.com>
References: <20260914-arm-psci-system_reset2-vendor-reboots-v25-0-4aaf5c09b5c2@oss.qualcomm.com>
In-Reply-To: <20260914-arm-psci-system_reset2-vendor-reboots-v25-0-4aaf5c09b5c2@oss.qualcomm.com>
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
        Abel Vesa <abelvesa@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789397948; l=2178;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=HY9fLa8u8u31BscwdrGeQccVQPGFQUgGa2K581SXsxg=;
 b=fNw+c8n6DonkQZy6Ryg4I7jQGU3AwDIZpv1saXTAQP0uoDA44F09SQVdEZYzRHbUuA5FolYsW
 532efuuiRUfByHxOdaaphUQmNsImBGJ54C2AfORsbVFpdPXiRM8pMD9
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=ssWsJFX3OM9pkdoe4+guOfGPaulHOFt0GVnVlB6on+s=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDIxNSBTYWx0ZWRfX+AlQJWeDtUva
 2GfdAh5yWXb2OkG2xJg77UlcWJGlzti4QCv9GFT4LaYGGCujODTnn2ccvH77Y8aDF+0Cc6xWXpv
 wDWyoQkECJ7pnZfBgU9umFHy//sqlt8XYB8y2LTa6zUuOlRR26CZsSPagTRECNon+yNzAy2dxI+
 OVwEdAE4dZwUPp2Zus2I4n0VjnGWWhK6aZXfzMvEkANpJGMUNxk3gyEIUoqv7GwLyVQszfZAG9V
 HXc+9IC67YcWH1g2mUPnIdPogDsKeEtFWOCSXQmuaMJwT2eoFSk1zZXx66INvGiWYvCmRRQP2rO
 TR0JeWfG6z01baInn9BiiytaZdy/yd0XxTm/L+kAjpm7O0MbA/xhevW8bXIbHmVUhYYqq0TtABy
 Z90WppZy7KAQyyrDO4fEXe5fQiHyBd65v2Q1VPUsfkrTiFRzDmM/gdwe/ISMmnIRYVDyXKwHpFf
 88vslzwldJYOR65eHqA==
X-Authority-Analysis: v=2.4 cv=IZwSymqa c=1 sm=1 tr=0 ts=6aa80c24 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=t9IVmYW30V31rltyR78A:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: hgdhCzzC4tVRFKbpQ3BTSwS-VYXFe363
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDIxNSBTYWx0ZWRfXxbvMf+qOkX06
 p/hykppP4z2Ilz/LaQXy0rJ4buKUTP0vlQDNFsKVFxJslOzcLV3EvlVibci3OjOA940wWhatDKb
 mrafmnKDiH90d27LMbhmERjN9JQeF58=
X-Proofpoint-ORIG-GUID: hgdhCzzC4tVRFKbpQ3BTSwS-VYXFe363
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_03,2026-09-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 impostorscore=0 malwarescore=0 phishscore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609140215

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

