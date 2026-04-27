Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C6B3A9017
	for <linux-pm@vger.kernel.org>; Mon, 27 Apr 2026 17:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777311360; cv=none; b=VAK/IYQjOr5othERpWwJEdiSrpgXbZ8NkGwh/jELw/kE/zyfBbQRjph1K334aUo7LY4mBPJScLe9Y1DY/RRSwlEfkCi91JpuLbSth9WHfnf9cimilK+G8tpBXFbhLRE/CUc5WNvpOnQv6/cSmE7JMcOkaLxjj1pnmeaZWGBxzWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777311360; c=relaxed/simple;
	bh=IJaAfFoD68Hrp8z3QWdwMvJoK/M04B/XNqX7mDYzhJk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qFbpxS+tnweod30ZC+gH84hSlCYk5whA3VcWvZe6yT5F2EsJyUo/eN9guCXKTM3bvjBshYwFNCtHE0GV+YVYNDN3gckcDwC2snSCIzmf/hKW+iye+aRyW6c5sqZhzc5M9aDkY6g9ZwdiAGMVXpGlX5tLX7PzCLm/bUozEuwBRVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lCz2QCez; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Hc/HVTz+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lCz2QCez";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Hc/HVTz+"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63RDpZuB665643
	for <linux-pm@vger.kernel.org>; Mon, 27 Apr 2026 17:35:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+CUiM8EWNjsOey3D4G6szxSNMyY47RvHNq1zFsclMX4=; b=lCz2QCezMCNeSYCU
	dLbGk4kqlKhZdcmkwgfG6iSUrW8Wwks7bnL/QLRt5pyP3OP5z0ehCJWxc5GWeD1g
	HUgICg9pMNEd2M/02RwvZ1YyDRFCGPa0xuMXDKjshmKJX2m6wKZTt5rUw0i/Prek
	0GP7xCF7f20uLp4K6eLgOZ5u3JrFSy913GqS3qNBPsS7HvrQtaL9LmLQylCvMH5H
	wCGbg9NojDwUXg1KsZ7V7i48XmbtAGTlOwi+RIm67AXL6VJBwJhbH5fujEaGislg
	+f3M5zDYTw2XZdjBAAob3LLxZpoq/4I6zGLXzr669Fd2TaqAAWs16V2ePeeJfwzv
	AMWmcA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dt30n2j7q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 27 Apr 2026 17:35:55 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2b2e6ee9444so113288265ad.1
        for <linux-pm@vger.kernel.org>; Mon, 27 Apr 2026 10:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777311354; x=1777916154; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+CUiM8EWNjsOey3D4G6szxSNMyY47RvHNq1zFsclMX4=;
        b=Hc/HVTz+xsEQz0XcWjg/H2rahk1N7W3TMTA2mdei+PZBAB07DOQzKDX/cA84u1g9WD
         ZbsaFwaJKaB1YblK4DND3I59tlpqbTgzH5thP0ekli1JYRHKaeqDtNo4NrezmV937RuF
         P2jPSQ6vh9VQyiAkWFijHwJUzkYDHqvjVh1LHk1c6odxTz5bxuckhjum9fpYzZ4wQ78X
         QypLuwHfypzOtaG/CSkfme09lEaH9ca1lvT8NNqX4w6yAbAry4oCHpdxLL57lM/nbpQH
         5Wm1ybWji0+IjYApfzYKxNcEei+QAqeMULYP3wNK/jrLvMTwsY21V57TZCwhmzVB5mI5
         8fNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777311354; x=1777916154;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+CUiM8EWNjsOey3D4G6szxSNMyY47RvHNq1zFsclMX4=;
        b=VzNWy5n01xxigJLt3EzZnjaZmcAa/u3rWhd8kFMJanL/HToKOuEXWDb0CDUX7jh4qR
         g2GRslH/HAELtJmVLjAoQlwl1R9rV3AxJ0xVL9D3afD7LPdFFOge3fSA0frQ4ou+l8Mw
         q/tEFSclvWX6Zv+dWMlSztNSnAJdSJq1fVZiFBcLDA/KA1eh0tl7jfNNucU+BXQb7HKe
         6SbmUV6FFDP50BLblBwH5fUOc7eWql7wAw0iMEaIFA/rftbDOdnnD2JF2/kntfJcbwVL
         jPb6DhpvjETjVTgrvmTQyYuJx6GDgSS5k51Px1GpZm/q6HfRj2NCPqArajeJUezdc7wu
         ggtw==
X-Gm-Message-State: AOJu0Yyr0yWE8jb/Ke4mnTFg1dPZtml/f2C497Eyk/EvCy0ji0Ng5fz6
	Wet5Ff2Fu9+Z8QiJ7UHjG8tloliNeWze6qQUWcQ2SFVsf6u2bujJJGVGJDZqLX315UCnY/VabjJ
	JA4dPT5vEzCmdjK0qs1zmFamiRiR8/tmET6mIXFLz18ZUDMM4GMADI6FIu3OL0b0LNgmscA==
X-Gm-Gg: AeBDieu2Kvzyee0hSpbg64FcScvTF7RIbWhyMdx89PDYFT0+QBcgmCtOh+9+lDh9hEt
	Vh0bgLOTkSfC7CkR9wdnaMyIAyYQJnK8dA9WwVRFz2z2MTMF+ZDxkEG0qvw8rdNMUz+lRTuVX6S
	0N+WIuLQSu/Tay7GhafWfHK5a0NQ76yFJUOfCcAwrtxO5aNqvD9bKyKUWLUXIVyB2a67IZ7YZPJ
	cjDZwaZZLNpyVKPR+7tRhqUpQi4sOzOcaUcd1bC9SLfRX3ZimfOHcrNHefFEQBxQYted1OSmeJT
	5gQTFsROM2P7ZeI6kA4J8O7MyKJzCmG7BOwaA8noVfbR15fVlY5of8UetCI0+enAcWKZhgqQ29h
	T6mAXrMaFK3niCS2G3FCZrf56dSgr3le4xgXxCsaXx1suV/RjsU5iZ3D7e4bycbqHHJhm
X-Received: by 2002:a17:903:3c44:b0:2b0:4f16:22f7 with SMTP id d9443c01a7336-2b97ac74404mr518845ad.16.1777311354034;
        Mon, 27 Apr 2026 10:35:54 -0700 (PDT)
X-Received: by 2002:a17:903:3c44:b0:2b0:4f16:22f7 with SMTP id d9443c01a7336-2b97ac74404mr518555ad.16.1777311353383;
        Mon, 27 Apr 2026 10:35:53 -0700 (PDT)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b97aca8369sm329115ad.75.2026.04.27.10.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 10:35:53 -0700 (PDT)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Mon, 27 Apr 2026 23:04:44 +0530
Subject: [PATCH v21 04/13] firmware: psci: Introduce command-based with
 magic
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260427-arm-psci-system_reset2-vendor-reboots-v21-4-dcf937775e73@oss.qualcomm.com>
References: <20260427-arm-psci-system_reset2-vendor-reboots-v21-0-dcf937775e73@oss.qualcomm.com>
In-Reply-To: <20260427-arm-psci-system_reset2-vendor-reboots-v21-0-dcf937775e73@oss.qualcomm.com>
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
        Srinivas Kandagatla <srini@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777311301; l=6677;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=IJaAfFoD68Hrp8z3QWdwMvJoK/M04B/XNqX7mDYzhJk=;
 b=C1CJp2wthLFqASyPaBoz2bmtc5z3yh2Vt0xyY746fg44zr0TjDFSpuJDS92BW6Jsg0sUhMzDf
 3hqs005mGwXBPy0tEuBhaWKEwjimbSOSNCPq+NE7ukFuc7O3+sNU6/U
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDE4NyBTYWx0ZWRfX5VWeDZmV2ZWT
 ZFMIKxEWWPqHtGA7bPxpY62OW1FYX2LjJkPEyHeYuv5Xy1jTlgMjYT7sMXTr95YiBcVvAwBHOaX
 urdgZUMA9uNG0zqD6hWpw5LBtq9W04iL1BJeOtteUIUz/xGJ2qYCGkH/k2JPBfP7c4LdIlhHVMc
 Qvu8ZF1sRsEcTzmL0kQ8a+Ue4DTw6LsX5AppnseYwA2iUr/du7tIwViYz2HR2a2byLUaFmoGwwI
 0Q8CzfL5KAygTdOk3Ocb27x/2OXge3GaQ1e5vKHDGmS4AIY3NUXFG4ZL2sijT638xQqRCWBty0t
 miMyfD2vcxt95iAex1EHWMAZ9+Q8wu1vLu+5baZN7zG2iQM5CKCsLlKir0xLlcL8l4IbZTLEqig
 djBwelkzSMlrHkYdu7nSp3Bxiz0RYgz9J7y+uDAckxrRDjseuLN1hjVP5Iqw0U2mVus4uQayjHy
 NfiWfiP06lCOWVixM0w==
X-Proofpoint-GUID: a5pDu9FIWlNtKyhERPQDFlvxem4eeLpV
X-Authority-Analysis: v=2.4 cv=efANubEH c=1 sm=1 tr=0 ts=69ef9e7b cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=dfwn7jY9AU0u4DHcGkkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: a5pDu9FIWlNtKyhERPQDFlvxem4eeLpV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_04,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 spamscore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604270187

PSCI currently supports only two resets - SYSTEM_RESET and SYSTEM_RESET2
ARCH WARM reset. The reset patch is selected based on the Linux
reboot_mode variable. The PSCI specification now includes SYSTEM_RESET2
for vendor-specific resets but there's no mechanism to issue these
through psci_sys_reset().

Add a command-based reset mechanism that allows external drivers to set
the psci reset command via a exported psci_set_reset_cmd() function.

Define predefined reset_types - PSCI_RESET_TYPE_SYSTEM_RESET to map to
SYSTEM_RESET, and PSCI_RESET_TYPE_SYSTEM_RESET2_ARCH_WARM to map to
SYSTEM_RESET2 arch warm reset. Interpret zero cmd_reset_type, for
predefined reset-command selection via cmd_cookie. For non-zero
cmd_reset_type, check for valid vendor_reset_type and set the psci
reset_command and cookie accordingly.

Disable PSCI command-based reset by default and treat invalid reset
commands as no‑op. psci_sys_reset() follows its original flow based on
reboot_mode until a reset command is explicitly set by
psci_set_reset_cmd().  In the device reset flow, psci_set_reset_cmd() is
called in reboot_notifier phase and the device reset happens in
psci_sys_reset() which is called later in the restart_notifier phase. If
a kernel panic occurs in between these two phases, the reboot should
take its original flow based on the value of reboot_mode. Disable the
command-based reset in such case.

Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
---
 drivers/firmware/psci/psci.c | 75 ++++++++++++++++++++++++++++++++++++++++++--
 include/linux/psci.h         | 19 +++++++++++
 2 files changed, 92 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index 38ca190d4a22d6e7e0f06420e8478a2b0ec2fe6f..cb37c39e2b4b1d99f0080f6a5cd6c92a070beda8 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -51,6 +51,16 @@ static int resident_cpu = -1;
 struct psci_operations psci_ops;
 static enum arm_smccc_conduit psci_conduit = SMCCC_CONDUIT_NONE;
 
+/*
+ * Encoded reset command:
+ * bits[63:32] = cookie
+ * bits[31:0]  = reset_type
+ */
+static u64 reset_cmd;
+
+#define PSCI_RESET_TYPE(reset_cmd)	((u32)(reset_cmd))
+#define PSCI_RESET_COOKIE(reset_cmd)	((u32)((reset_cmd) >> 32))
+
 bool psci_tos_resident_on(int cpu)
 {
 	return cpu == resident_cpu;
@@ -80,6 +90,35 @@ static u32 psci_cpu_suspend_feature;
 static bool psci_system_reset2_supported;
 static bool psci_system_off2_hibernate_supported;
 
+static u32 psci_fn_from_cookie(u32 cookie)
+{
+	switch (cookie) {
+	case PSCI_RESET_TYPE_SYSTEM_RESET2_ARCH_WARM:
+		if (psci_system_reset2_supported)
+			return PSCI_FN_NATIVE(1_1, SYSTEM_RESET2);
+		return 0;
+	case PSCI_RESET_TYPE_SYSTEM_RESET:
+		return PSCI_0_2_FN_SYSTEM_RESET;
+	default:
+		return 0;
+	}
+}
+
+/** psci_set_reset_cmd() - Configure reset request for psci_sys_reset()
+ * @psci_reset_cmd: reset command encoded as cookie[63:32] | reset_type[31:0]
+ *
+ * Save reset command.
+ */
+void psci_set_reset_cmd(u64 psci_reset_cmd)
+{
+	reset_cmd = psci_reset_cmd;
+}
+
+bool psci_has_system_reset2_support(void)
+{
+	return psci_system_reset2_supported;
+}
+
 static inline bool psci_has_ext_power_state(void)
 {
 	return psci_cpu_suspend_feature &
@@ -306,8 +345,24 @@ static int get_set_conduit_method(const struct device_node *np)
 	return 0;
 }
 
-static int psci_sys_reset(struct notifier_block *nb, unsigned long action,
-			  void *data)
+static void psci_handle_reset_cmd(void)
+{
+	u32 psci_sys_reset_fn;
+
+	if ((reset_cmd & BIT_ULL(31)) && psci_system_reset2_supported) {
+		/* PSCI SYSTEM_RESET2 Vendor-specific reset */
+		invoke_psci_fn(PSCI_FN_NATIVE(1_1, SYSTEM_RESET2),
+			       PSCI_RESET_TYPE(reset_cmd),
+			       PSCI_RESET_COOKIE(reset_cmd), 0);
+	} else {
+		/* cookie part of the reset_cmd decides ARCH WARM RESET vs SYSTEM_RESET */
+		psci_sys_reset_fn = psci_fn_from_cookie(PSCI_RESET_COOKIE(reset_cmd));
+		if (!PSCI_RESET_TYPE(reset_cmd) && psci_sys_reset_fn)
+			invoke_psci_fn(psci_sys_reset_fn, 0, 0, 0);
+	}
+}
+
+static void psci_handle_reboot_mode(void)
 {
 	if ((reboot_mode == REBOOT_WARM || reboot_mode == REBOOT_SOFT) &&
 	    psci_system_reset2_supported) {
@@ -320,6 +375,22 @@ static int psci_sys_reset(struct notifier_block *nb, unsigned long action,
 	} else {
 		invoke_psci_fn(PSCI_0_2_FN_SYSTEM_RESET, 0, 0, 0);
 	}
+}
+
+static int psci_sys_reset(struct notifier_block *nb, unsigned long action,
+			  void *data)
+{
+	/*
+	 * Command-based resets are configured at the reboot_notifier phase.
+	 * If a kernel panic occurs between the reboot_notifier and this final
+	 * reset, ignore the command-based reset and let reboot_mode drive the
+	 * reset flow.
+	 * If reset_cmd is zero, there is no command to handle.
+	 */
+	if (reset_cmd && !panic_in_progress())
+		psci_handle_reset_cmd();
+	else
+		psci_handle_reboot_mode();
 
 	return NOTIFY_DONE;
 }
diff --git a/include/linux/psci.h b/include/linux/psci.h
index 4ca0060a3fc42ba1ca751c7862fb4ad8dda35a4c..c2458291a3faf5ac89b1528dae2c9b805a2dd075 100644
--- a/include/linux/psci.h
+++ b/include/linux/psci.h
@@ -21,6 +21,21 @@ bool psci_power_state_is_valid(u32 state);
 int psci_set_osi_mode(bool enable);
 bool psci_has_osi_support(void);
 
+/**
+ * enum psci_reset_type	-	PSCI_RESET_TYPE for SYSTEM_RESET.
+ * @PSCI_RESET_TYPE_SYSTEM_RESET: Standard SYSTEM_RESET command.
+ * @PSCI_RESET_TYPE_SYSTEM_RESET2_ARCH_WARM: SYSTEM_RESET2 architectural warm reset.
+ *
+ * These enum values map PSCI_RESET_TYPE_SYSTEM_* constants to reset strings
+ * issued from user space. When user space requests a reset, the cookie
+ * carries one of these values, and the PSCI reset path translates it into
+ * the appropriate PSCI system reset call.
+ */
+enum psci_reset_type {
+	PSCI_RESET_TYPE_SYSTEM_RESET = 1,
+	PSCI_RESET_TYPE_SYSTEM_RESET2_ARCH_WARM,
+};
+
 struct psci_operations {
 	u32 (*get_version)(void);
 	int (*cpu_suspend)(u32 state, unsigned long entry_point);
@@ -45,8 +60,12 @@ struct psci_0_1_function_ids get_psci_0_1_function_ids(void);
 
 #if defined(CONFIG_ARM_PSCI_FW)
 int __init psci_dt_init(void);
+void psci_set_reset_cmd(u64 psci_reset_cmd);
+bool psci_has_system_reset2_support(void);
 #else
 static inline int psci_dt_init(void) { return 0; }
+static inline void psci_set_reset_cmd(u64 psci_reset_cmd) { }
+static inline bool psci_has_system_reset2_support(void) { return false; }
 #endif
 
 #if defined(CONFIG_ARM_PSCI_FW) && defined(CONFIG_ACPI)

-- 
2.34.1

