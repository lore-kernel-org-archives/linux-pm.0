Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92CFE483BF0
	for <linux-pm@vger.kernel.org>; Mon, 14 Sep 2026 14:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789397997; cv=none; b=R2OFRGMY4yqrZP6SWoXkVO0VQq6ZN1GaBRh7hUXTJJZBIlB6zCmAT4vUzRdrS3KXZkhElQuL79+geKuWqi1tdb5eaiMP4Cw/ODIaTvrIikEKt6deQ85/snTADS8ceGyawwa7U0y1DwpsbpDxBWZ4H//bBimaScARmua4UHZBQ/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789397997; c=relaxed/simple;
	bh=ePR4OuoTlUavycOVnXKN78dPp96WxpPQP3RUTs/YnxU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kCgl6t5cv3WscatMxV7nFAjA07bfDosMio1eBOgnaJ9F9CQB/w8m0j8LSIB8TOm+wGo37DXEX2BOyY7cJY8Wggb5XQQoaYEqN7iv3cPTartzQid/PsoynWshqVQniBZBmWnGSanq42dGD4EuVDlhyc/VQ2IT6m5/Ps3dxXAeVvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GoCAFsnx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UKsqMlz1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GoCAFsnx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UKsqMlz1"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68ED0ZGc830765
	for <linux-pm@vger.kernel.org>; Mon, 14 Sep 2026 14:59:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6c7FsVt+6kZf0MJjLIZNdKyh8QTMehkeel45ASz2OUw=; b=GoCAFsnxwvqsRPJy
	M068qtSqBrT7jINXMCTsyAjvgaGjQfrw9CHwF7DRrWamA8c34NHD8SQNvpaM9sGN
	UJCwT/rhmbG0U1nnpkf/U+FYF9Mi3iavGYzdmJ5dy3BCT9W6IihTgd5MljZrPKNg
	CsBMS1fe9GUpObjLbn+eT4LTSsZbpWhi80vPjwAdBQnOxezGlvB92vy4m2va6QnU
	XgkdBbLDopuppz6UgEIIJpVEORTJtlMSymNaFhl1YQT6aLRROliVvaIQvu6973++
	eo6zAVux+0N05lu/+QNPfvlaurqrkOFfNq85DolayJ8j63GLv2fj97pIaIzuBha6
	QxV92g==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gp3hsu02f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 14 Sep 2026 14:59:52 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38dbf293831so7714560a91.3
        for <linux-pm@vger.kernel.org>; Mon, 14 Sep 2026 07:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789397992; x=1790002792; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6c7FsVt+6kZf0MJjLIZNdKyh8QTMehkeel45ASz2OUw=;
        b=UKsqMlz1F0Z2BeDA4nBuPhj6TzY9ER9G4s9TtngqOpHBVHgBhNqaOCh9SsKszqSAnp
         KRnz22Sco031VRjRH50fUDqquP6Ghbjv1QMnu0YIV7d1S8I7lnXAIwiky9it8wygektJ
         YakfXuM/htkRcP93BYQmwrY+Jdfi6qLfjUkjaBDlW2lyv9dv4oZkdnrAQOWn32U6MZVT
         D3mbwOCEDEbXevYz1EZSsHpQpkzqXgBsnf5mGOdYt1ZAqYDs87L6CVpZLoGdtyjuub8u
         OjmevqZwui7/JhLfM5Gfm5XsObLX6sFbUoCl9h2FksN7GXGNWiw+NV2RN5tF17Pflx3u
         6WQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789397992; x=1790002792;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6c7FsVt+6kZf0MJjLIZNdKyh8QTMehkeel45ASz2OUw=;
        b=KkLkaATDGuJvxUbI2/srCVKVSXEaPMYwQ+fDIJNZNpnOuZnNsjKET7u2/wQxv2R33v
         3GFsRU7bhQ5qb6bLrq2UvA2yibmPmmHOH5G4k8bGyx92nbqOHpNzDaIXaAMQuI5gSApp
         +yfJg1lTA7qZy4W3jIMtt2cfDBEZRUWDFs6xCuhwzOtbwpXsk97mkyEDbPMKwcdtnHER
         Lg6z0BRLoQSDG/LvbboVCE+W7NY4PaLpooP+vJaMRyeR0H4hM4J+9Cc5Ku7QWlQmRQVj
         QyNuGzsQQf2NehHKEjtngP6R3CrjEguxr6xTGSsAVoA2SAjoSA6XZLGZn+cQhdqA2gW9
         4Zpw==
X-Forwarded-Encrypted: i=1; AKwUvByv5oERF2BXedE3KJawm10KODGeRrkgdZPhQ+7xc9LscXCIRrcAYca7nLH/5t3Ub3J4aQ28kiEYHg==@vger.kernel.org
X-Gm-Message-State: AFuF++kMB2Y+qEfRSFMJIKgDQAlb2jSv21T8L3ZPkO6wQutr47KEnhQM
	kIwOAcaIdlg6pNvm8OKTBy2wLJy2kJXZMG5sCzOOUYd6Xvo0JNN16DyvQ1PEOxIWaTFdqZLkEAR
	0V8kdUkK5zg5E0ZNUdQlXqj0+rYpNqaZOiIHSWWcsY4NFee9UlhpQa4KgMYlC4Q==
X-Gm-Gg: AYBFou25pTwazIgYoV8UdLckBb3Bm1kWrMR5K6UnP6qZWGEZFHuAwd7uWrxHMx8owEe
	rs4gjLHRfAIBgMAVkojVYTkr6MGLgNSwekYZZVGYvuJYD8aSb48+ZcWRIxFYbxjmgisd3Y0EZDl
	ErDdgX8Evxymg/LFgcCOe7K0SnxiwxGBFkPt0mBfYHy7L58cBTuHI+FX/ck/ENk8bJyXW4QpoWJ
	9pJGqk824LBpkKVVjrqAu+KbrIOX/mrwoW1D7bxmdtt81+YPYGNd0o2LkznKvsm07RMFoKWuXIZ
	IYQhMCWhWKw7uoUmO1x8VK4eLNvFaAbmCdixNZ1hz0CoZpB/3RlIBm1npUipeHgC46DBrSgH7sh
	ir019oGMhMQtg21OafuTvMSlpa1J+ld9ghONR
X-Received: by 2002:a17:90a:150:b0:39d:eda9:febf with SMTP id 98e67ed59e1d1-39dedaa1a80mr3695058a91.18.1789397991976;
        Mon, 14 Sep 2026 07:59:51 -0700 (PDT)
X-Received: by 2002:a17:90a:150:b0:39d:eda9:febf with SMTP id 98e67ed59e1d1-39dedaa1a80mr3694994a91.18.1789397991523;
        Mon, 14 Sep 2026 07:59:51 -0700 (PDT)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd4007bd4dsm42943345ad.4.2026.09.14.07.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 07:59:50 -0700 (PDT)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Mon, 14 Sep 2026 20:29:07 +0530
Subject: [PATCH v25 03/10] firmware: psci: Introduce command-based resets
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260914-arm-psci-system_reset2-vendor-reboots-v25-3-4aaf5c09b5c2@oss.qualcomm.com>
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
        Srinivas Kandagatla <srini@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789397948; l=8099;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=ePR4OuoTlUavycOVnXKN78dPp96WxpPQP3RUTs/YnxU=;
 b=CJxt7ThA3ijgEcBqAnR0lw3czXy1gO1zix8W7Xfhh0XqKkZFux15Zr2jI3plrrUw39TAxF6Bt
 3jet7ZQ/MSXB1hsGElQziD7bv8Aq81yS680bBY/kfpAu0pPn6DWAHh6
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=ssWsJFX3OM9pkdoe4+guOfGPaulHOFt0GVnVlB6on+s=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDIxNSBTYWx0ZWRfXyX1jOuY9o5eL
 LNKxeX3p/syzklZgsfDYFw1O4YoMwArkZwLNrdI0cIeCgDrAEL88d7aokzIpvvdGEvtL443OKLA
 xeCMXHmL/5FjJb+oRnRHi7bdFKIxCqLnvtQG1bYcTXmVZIqVaQPCO0DbhQzlyuWOKgtZcV0RCr0
 xYvMaJpXBItPRPU2eB7Mjwe0cEDDhozAJ0M2+i59UKrNa8fwueHqmudWa6G2t1mW9zTxmJzAG4V
 I0aRc0fSUZw+yh4FwMQIQi5kOiNnypYFIwWgroj7614Oo4k35xdIlflA3SU2ghYmjyHKi7tArWL
 OxmuDG+KA6UR0AO6PpxDusImMugH0lWIP83DUutm9E2Prc54uv0eAAlSVtdeOZjPy4uK0kH78tN
 SKP5v+yXATWl1Tkz3Pf61DhwrZHgvXzK1qFnRcIEPUifaeR+uMGC7K5uthA1TyHN+GtK48A3yzb
 CBD4agS7M+WWygjlLyQ==
X-Authority-Analysis: v=2.4 cv=IZwSymqa c=1 sm=1 tr=0 ts=6aa80be9 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=njxsUegImOJjkw56WvUA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: 0FsBLwSN7a1FrAtOhLkTuFz9jzByrEWU
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDIxNSBTYWx0ZWRfX3+0D50IwSmGn
 9mzqMrAMTIP8NmHeYl4aMyxbNbGrvNfr6CTmP4fLxXnfsQvLUZpStm10rdVzHLJydH9wj58F02H
 vIake1dItGV1wmmKbN4oGoDQxeVottk=
X-Proofpoint-ORIG-GUID: 0FsBLwSN7a1FrAtOhLkTuFz9jzByrEWU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_03,2026-09-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 impostorscore=0 malwarescore=0 phishscore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609140215

PSCI currently supports only two resets - SYSTEM_RESET and SYSTEM_RESET2
ARCH WARM reset. The reset patch is selected based on the Linux
reboot_mode variable. The PSCI specification now includes SYSTEM_RESET2
for vendor-specific resets but there's no mechanism to issue these
through psci_sys_reset().

Add a command-based reset mechanism that allows reboot-mode drivers to set
the PSCI reset command by passing a reset_type and a cookie.

Add support for the following reset commands:
  - SYSTEM_RESET2 vendor-specific resets.
  - SYSTEM_RESET2 ARCH WARM reset and SYSTEM_RESET (reset_type = 0 and
    cookie one of psci_standard_resets).
Unsupported commands fall back to the regular PSCI reset path.

Default to the existing reboot_mode-based reset flow unless a reset
command is configured. If a kernel panic() or a emergency_restart()
occurs after a reset command is set but before the final PSCI reset is
issued, ignore the reset command and follow the normal reboot_mode-based
reset path.

Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
---
 drivers/firmware/psci/psci.c | 117 ++++++++++++++++++++++++++++++++++++++++++-
 include/linux/psci.h         |  15 ++++++
 2 files changed, 130 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index e73bae6cb23a..d489ba5d147c 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -11,17 +11,22 @@
 #include <linux/cpuidle.h>
 #include <linux/debugfs.h>
 #include <linux/errno.h>
+#include <linux/kconfig.h>
 #include <linux/linkage.h>
+#include <linux/mutex.h>
 #include <linux/of.h>
+#include <linux/panic.h>
 #include <linux/pm.h>
 #include <linux/printk.h>
 #include <linux/psci.h>
 #include <linux/reboot.h>
 #include <linux/slab.h>
 #include <linux/suspend.h>
+#include <linux/wordpart.h>
 
 #include <uapi/linux/psci.h>
 
+#include <asm/barrier.h>
 #include <asm/cpuidle.h>
 #include <asm/cputype.h>
 #include <asm/hypervisor.h>
@@ -51,6 +56,15 @@ static int resident_cpu = -1;
 struct psci_operations psci_ops;
 static enum arm_smccc_conduit psci_conduit = SMCCC_CONDUIT_NONE;
 
+struct psci_system_reset_cmd {
+	u32 reset_type;
+	u64 cookie;
+};
+
+static struct psci_system_reset_cmd reset_cmd_data;
+static struct psci_system_reset_cmd *reset_cmd;
+static DEFINE_MUTEX(reset_cmd_mutex);
+
 bool psci_tos_resident_on(int cpu)
 {
 	return cpu == resident_cpu;
@@ -80,6 +94,64 @@ static u32 psci_cpu_suspend_feature;
 static bool psci_system_reset2_supported;
 static bool psci_system_off2_hibernate_supported;
 
+static u32 psci_get_sys_reset_fn(const struct psci_system_reset_cmd *cmd)
+{
+	switch (cmd->cookie) {
+	case PSCI_SYSTEM_RESET2_ARCH_WARM_RESET:
+		if (psci_system_reset2_supported)
+			return PSCI_FN_NATIVE(1_1, SYSTEM_RESET2);
+		return 0;
+	case PSCI_SYSTEM_RESET_COLD_RESET:
+		return PSCI_0_2_FN_SYSTEM_RESET;
+	default:
+		return 0;
+	}
+}
+
+/**
+ * psci_set_reset_cmd() - Configure the PSCI reset command
+ * @reset_type: PSCI SYSTEM_RESET2 reset_type, or 0 for a standard reset selector
+ * @cookie: Vendor-defined SYSTEM_RESET2 cookie, or a value from
+ *	    enum psci_standard_resets when @reset_type is 0
+ *
+ * For vendor-specific SYSTEM_RESET2 resets, @reset_type and @cookie
+ * must contain platform-defined values.
+ *
+ * For standard resets, @reset_type must be 0 and @cookie must be a
+ * value from enum psci_standard_resets.
+ *
+ * The reset command may be configured only once per boot cycle.
+ */
+int psci_set_reset_cmd(u32 reset_type, u64 cookie)
+{
+	if (!reset_type && !cookie)
+		return -EINVAL;
+
+	if (!IS_ENABLED(CONFIG_64BIT) && upper_32_bits(cookie))
+		return -EINVAL;
+
+	scoped_guard(mutex, &reset_cmd_mutex) {
+		if (reset_cmd)
+			return -EBUSY;
+
+		reset_cmd_data.reset_type = reset_type;
+		reset_cmd_data.cookie = cookie;
+		/*
+		 * Publish the command only after both fields are fully initialized.
+		 * Readers run from the atomic restart notifier path and must not block.
+		 */
+		smp_store_release(&reset_cmd, &reset_cmd_data);
+	}
+
+	return 0;
+}
+
+bool psci_has_system_reset2_support(void)
+{
+	return psci_system_reset2_supported;
+}
+EXPORT_SYMBOL_NS_GPL(psci_has_system_reset2_support, "PSCI");
+
 static inline bool psci_has_ext_power_state(void)
 {
 	return psci_cpu_suspend_feature &
@@ -306,8 +378,25 @@ static int get_set_conduit_method(const struct device_node *np)
 	return 0;
 }
 
-static int psci_sys_reset(struct notifier_block *nb, unsigned long action,
-			  void *data)
+static void psci_handle_reset_cmd(const struct psci_system_reset_cmd *cmd)
+{
+	u32 psci_sys_reset_fn;
+
+	/* PSCI_1_1_RESET_TYPE_VENDOR_START identifies vendor reset types. */
+	if ((cmd->reset_type & PSCI_1_1_RESET_TYPE_VENDOR_START) &&
+	    psci_system_reset2_supported) {
+		/* PSCI SYSTEM_RESET2 Vendor-specific reset */
+		invoke_psci_fn(PSCI_FN_NATIVE(1_1, SYSTEM_RESET2),
+			       cmd->reset_type, cmd->cookie, 0);
+	} else {
+		/* Retrieve the psci reset function from reset_cmd */
+		psci_sys_reset_fn = psci_get_sys_reset_fn(cmd);
+		if (!cmd->reset_type && psci_sys_reset_fn)
+			invoke_psci_fn(psci_sys_reset_fn, 0, 0, 0);
+	}
+}
+
+static void psci_handle_reboot_mode(void)
 {
 	if ((reboot_mode == REBOOT_WARM || reboot_mode == REBOOT_SOFT) &&
 	    psci_system_reset2_supported) {
@@ -320,6 +409,30 @@ static int psci_sys_reset(struct notifier_block *nb, unsigned long action,
 	} else {
 		invoke_psci_fn(PSCI_0_2_FN_SYSTEM_RESET, 0, 0, 0);
 	}
+}
+
+static int psci_sys_reset(struct notifier_block *nb, unsigned long action,
+			  void *data)
+{
+	const struct psci_system_reset_cmd *cmd;
+
+	/* The function psci_handle_reboot_mode follows reboot_mode based
+	 * reset flow and psci_handle_reset_cmd uses reset_cmd based reset flow.
+	 *
+	 * The reset_cmd is configured at the reboot_notifier phase.
+	 * If panic() or emergency_restart() occurs between the reboot_notifier
+	 * and this final reset, skip command-based reset and let reboot_mode drive
+	 * the reset flow.
+	 *
+	 * The function psci_handle_reset_cmd invokes non-returning PSCI SYSTEM_RESET
+	 * calls to reset the device. If it returns, either the reset failed, or the
+	 * command was unsupported. Fallback to reboot_mode based reset flow.
+	 */
+	cmd = smp_load_acquire(&reset_cmd);
+	if (data && cmd && !panic_in_progress())
+		psci_handle_reset_cmd(cmd);
+
+	psci_handle_reboot_mode();
 
 	return NOTIFY_DONE;
 }
diff --git a/include/linux/psci.h b/include/linux/psci.h
index 4ca0060a3fc4..e81b1cdeca51 100644
--- a/include/linux/psci.h
+++ b/include/linux/psci.h
@@ -8,6 +8,7 @@
 #define __LINUX_PSCI_H
 
 #include <linux/arm-smccc.h>
+#include <linux/errno.h>
 #include <linux/init.h>
 #include <linux/types.h>
 
@@ -21,6 +22,16 @@ bool psci_power_state_is_valid(u32 state);
 int psci_set_osi_mode(bool enable);
 bool psci_has_osi_support(void);
 
+/**
+ * enum psci_standard_resets - Standard reset selectors for PSCI reset
+ * @PSCI_SYSTEM_RESET_COLD_RESET: Standard SYSTEM_RESET command.
+ * @PSCI_SYSTEM_RESET2_ARCH_WARM_RESET: SYSTEM_RESET2 architectural warm reset.
+ */
+enum psci_standard_resets {
+	PSCI_SYSTEM_RESET_COLD_RESET = 1,
+	PSCI_SYSTEM_RESET2_ARCH_WARM_RESET,
+};
+
 struct psci_operations {
 	u32 (*get_version)(void);
 	int (*cpu_suspend)(u32 state, unsigned long entry_point);
@@ -45,8 +56,12 @@ struct psci_0_1_function_ids get_psci_0_1_function_ids(void);
 
 #if defined(CONFIG_ARM_PSCI_FW)
 int __init psci_dt_init(void);
+int psci_set_reset_cmd(u32 reset_type, u64 cookie);
+bool psci_has_system_reset2_support(void);
 #else
 static inline int psci_dt_init(void) { return 0; }
+static inline int psci_set_reset_cmd(u32 reset_type, u64 cookie) { return -EOPNOTSUPP; }
+static inline bool psci_has_system_reset2_support(void) { return false; }
 #endif
 
 #if defined(CONFIG_ARM_PSCI_FW) && defined(CONFIG_ACPI)

-- 
2.34.1

