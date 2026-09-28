Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B81F3A6F04
	for <linux-pm@vger.kernel.org>; Mon, 28 Sep 2026 06:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790575808; cv=none; b=mg1uEiwWRKrBSHxIcI1tifTc8V5NTsXtOKzb6Gpe0Ll/rr2tq15yf+ST6CLQBvMmXAnOvtmSfK4uxSj1JzErL/R6sbN9U1R8A9gSdbuGg8KnZ2xPNgxrp2vdNZiyZDFxoCJZZxECcPcU0AEawXR6p2/zy6vfK6DLNWQXH0OwZm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790575808; c=relaxed/simple;
	bh=ePR4OuoTlUavycOVnXKN78dPp96WxpPQP3RUTs/YnxU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QGUUhdpl/HOmysPXa/qiDiLkLRxg0Otk3NxNHcRKBMBisokTJlQzr8Br99n2tqiMQhi4z9t7TrKI91x/mmWtyQ+FyLIv9nuqz6v7WXPYnTGhEHmthDiSNEhbpsKISQRa+TR8jIIm4LMftCV1CnNJ3u085r4leWHlFzkuBr9zXNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Iv7cx0qX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=V1bZRMPe; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Iv7cx0qX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="V1bZRMPe"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68S5OwhG673855
	for <linux-pm@vger.kernel.org>; Mon, 28 Sep 2026 06:10:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6c7FsVt+6kZf0MJjLIZNdKyh8QTMehkeel45ASz2OUw=; b=Iv7cx0qX1gx7MWz1
	WSCBwfI2KXy/oCxPYSdLE9KzjlFsVMJgZTqAtyWkjPe/rWV4KggO0qcT1WJdk7GK
	drS3tLzeS5PVbG6i5NrygohuGdoN1P3qYcRBZDgHqU/ftGQQVTTdiwxPfO2mKgLP
	XABYkF+DrsMpY7zPN1jcGDCWIMNwyZhncM2EOrcgQbxevzLlDeCnFSmhSqEoM9/H
	lLT60CiA8lAM+GzvgKGkS0b3oap2wIwkYZ87QyoQAeoH+/MBEYxkomL7788ZTs9b
	iww+MI5Z+ptw7G4kSBePbNxNYYIrN1UzmfnQQw5j+E/AazGsxd0n71LFAOKAaz1N
	FoxuFQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyj2s04fa-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 28 Sep 2026 06:10:05 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cee1ec30f2so26142835ad.3
        for <linux-pm@vger.kernel.org>; Sun, 27 Sep 2026 23:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790575804; x=1791180604; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6c7FsVt+6kZf0MJjLIZNdKyh8QTMehkeel45ASz2OUw=;
        b=V1bZRMPedb4lzYUX+iEg/7cRc5zmQVYUabufPIcobELNaiQ1UoLMbIWQeZlKMyC3vI
         QH3SNgeFClw2KaGFLGwBSy8e6DwJ7fb5rkT+Dl4a2f1ypBo0lV0GsvRx5Nbx4LkGSfKk
         mso76rqkO5lrSt6+teVco146Pa2PCGen599aXjaqVBAFlTDEpXrtvDJF8CugdO4Grc3p
         wqZUlYNQFicB8w8oGkNqmwyvM2i3HAdYQ3UKsP7mG3zlEGA+SjOl/65M4073SiioqfiP
         zM3yJRT4eGe8nh/z4dg0Om+b3HdsnS8tz477tH55hylSpZZFvXIGzrCYBo2gkLzp/o0b
         h3PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790575804; x=1791180604;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6c7FsVt+6kZf0MJjLIZNdKyh8QTMehkeel45ASz2OUw=;
        b=HNlyhCo1eb5yLbmdKTz1KsPB7BZdeABGmwUsD7y19307gPJ+4FUrRsQWOig8AkVW2C
         lslR8u0SkbYebqK+MHuQMJY9aXajrWZNgfJSyQ3ruXdl/dx8UHC7haoN6oLVyye0xFST
         L9DYEZ3+UrXzpSZckJrwxFHloTJnGPvXTFN302SzmxCp85VgMgC5y8Kn2Sz/Ub/WObpm
         THLmQyk5kiFANLIYHVXcXmNJO3BbGy3j1ne/1UOj7WM6p2zRROlPJivcuJ8tvd1hmk3W
         WExAXsI9c/te7I5speoapcyDRZ/zp/S5gzoLTG9Ux3Woc9ZpmQn/bnzrqNwjRug/6XMj
         QEOw==
X-Forwarded-Encrypted: i=1; AKwUvBxJb+duU+2j+DLOxUCX4BZM4BHRj7v/WiVMZP3GUf9tDUdSkhUwIZVqc7XkxL5dtclQH7O1/b9Dyw==@vger.kernel.org
X-Gm-Message-State: AFq9FYI9BbVtIG8WSm6RFpKPBa4IIg3ZXqNMt7Zu/p9fAQ0EHN3+N+lA
	fB+d3fCl7S6ED5DPtALFsV509KvCWwm0rBAxilzwOzXvcbr9v77ComzSjYVPaZgyS2EVp3utNby
	ypD0zWAUq7V1zaps07OsyL6aG8vuTetwypiSuwwNUHqzqZyvFO6LBgXrpsLpaEQ==
X-Gm-Gg: AYBFou1V4k3XEnbMwk0/mBWlk/JLOEyYIclvGyGjXW7Zrkzf5HcrXS3XuUPYvLgf7vy
	8WFnOeGKrXpTpOpq1YcVRLFuD7ToQGtI+lDs9fyi9Ik80UDpmmeAs02WZJHZkgx5+IB3h/b7/h+
	3uRtnbTon1FIYxAmFcBkkbW1Z/0Yo3yQd1kVASEvdy0go1hywYNLcoH6jmhrfmkn2AhO3cVwhOG
	oz7kYzGrgYnhtjVzA8wvDopuAZZmJpTlSCAKPORGwAPvaf4vE3G/iJ961GHJOd+TfYaF+mbWTgF
	ciG427iTH0EbuQcWZ4SDKeWQ4/IB7+jKRSqONWcgJZGz8VkjJL5zK8LxkcW00mrbXNJPW5Uh0ru
	MhxBImpxB6KqJZH57OLMBYM5Z+zFNv/KGp5JU
X-Received: by 2002:a17:90b:3888:b0:3a0:cc33:2287 with SMTP id 98e67ed59e1d1-3a0cc3324ccmr6288168a91.6.1790575804348;
        Sun, 27 Sep 2026 23:10:04 -0700 (PDT)
X-Received: by 2002:a17:90b:3888:b0:3a0:cc33:2287 with SMTP id 98e67ed59e1d1-3a0cc3324ccmr6288122a91.6.1790575803829;
        Sun, 27 Sep 2026 23:10:03 -0700 (PDT)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0b8efb156sm20040846a91.1.2026.09.27.23.09.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 23:10:03 -0700 (PDT)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Mon, 28 Sep 2026 11:39:15 +0530
Subject: [PATCH v26 03/10] firmware: psci: Introduce command-based resets
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-arm-psci-system_reset2-vendor-reboots-v26-3-b24e2348e8e1@oss.qualcomm.com>
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
        Srinivas Kandagatla <srini@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790575761; l=8099;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=ePR4OuoTlUavycOVnXKN78dPp96WxpPQP3RUTs/YnxU=;
 b=GxnsJNhmONXIPvOcYSq9f3MtvcokFzprH757PwLANhDRUhmbthb2ITWlhn8L+U+kczUilSCAA
 AGrmTNDr15kCs6TsLosRm8AC9SVkbqj/4vxhMgZwkABCpu5moTT9X/j
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=ssWsJFX3OM9pkdoe4+guOfGPaulHOFt0GVnVlB6on+s=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDAyNCBTYWx0ZWRfX/Od9sBff1FVM
 RTUOzsdwx2uTeZKuV2RLjWKe/ByHF4EG/wWgklKKqlX6CFsqwrCNvg3hd0vXDweKzaR8DBDBHWM
 45bpFPnOMYsvsNtJAGzBkHpdGRXXRJKe4yr2JVlOqdCXqZ4K5Ycksk1O/3YFxCq5y13Sx6T5QDE
 i8O3kK1kP8F4BPnBBnC9kMmX2ruZUYWoMPpwRYz7t+Tm5saf9oXib23cxEo4l+oUZ3AlqVXeurV
 1zQvkiUhjdHP1m70Es/Xy7QH1Z8vfJe3nkMBBjYpRLEhWz3LDSthPZc/KO9AAHaQAbuqQgVQDpf
 un8ZCD6+qzovYVaqgW3R37psoXd9cNyGqcVdgzbjj9116YSoScvHYLOxPHYsSnbifuTtaV2dUN4
 /jtw7Qm4OJFn1zDr+wmdswK7GDqr7jEkdANgCYGYj+6uRSXafX7g1aEU/cKxJ4ZXpnPR4WpVobP
 zUiA5U4zSw9z7Ta2jSg==
X-Proofpoint-ORIG-GUID: d0tnmWrxgHC4YQq4Tk0brV3kVmE0-JC8
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDAyNCBTYWx0ZWRfX+Oaf5zgXoGg4
 p7D8MvpYeCwKNpIbORcmjyM10LsTblPYCTwhyapr5fO97DpH0jyITrKYaf/GlaWvB8TOrFI//iM
 GUsywfLofw2SBmGNoHfw1hCGnYYcoO4=
X-Proofpoint-GUID: d0tnmWrxgHC4YQq4Tk0brV3kVmE0-JC8
X-Authority-Analysis: v=2.4 cv=TptzFzXh c=1 sm=1 tr=0 ts=6aba04bd cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=njxsUegImOJjkw56WvUA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609280024

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

