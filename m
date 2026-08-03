Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4272749DC
	for <linux-pm@vger.kernel.org>; Mon,  3 Aug 2026 09:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785750320; cv=none; b=RRQiAU2r+xGVjjogIGEbjaLjh6gQR2LtqrnTTzCp5dlkNxxsvmvIA1n3q0lMGUq/KHLS1m4TPyJTpPutI9cZcbackiJddVuPI067cfYJXm+I7Ssx8HYH2gSBWm4AeyBYJUsFs+4hod9wDpkoSHG6Kwzlp4TAi473RFmtbQrwybk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785750320; c=relaxed/simple;
	bh=8t6y60ki3WvBG4I02nVmPEeD2nL6qsnMaolT7hOv6CM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ewV3db9ayLF+Fh/3YVm67CLEDciXyFttxnxKr9MoB5KyEv+L1tzo7/+9Yp2QjS6YGdCGotbGjEYkOzS43D1ifkBsj9O6zlITOFhAmhVg0Xi3RHWV4jxmM1lSt5RrtceoJgiE29Gcud2hK6yhvTmtk9TkztPB1seCc3IEM6U8VtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZQuyDOHd; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YNaBQ7RQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZQuyDOHd";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YNaBQ7RQ"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6736sVgR3790743
	for <linux-pm@vger.kernel.org>; Mon, 3 Aug 2026 09:45:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KmS0i4+ikceJ7oOpqw2TVU+CULAM7RtzmwWI6IxadPQ=; b=ZQuyDOHdMIF6FqZP
	AirHbKY3TucuXt3RZxZ48Ojb0Fsd5u66kwsPlohSF84/WdxpweL0m8ZzfR9byR37
	UU51dC5c/JowpPXuU2R9Ocni4FymKEs9rpwjFWJ5tcCeE/APStEjTGdI/jN/NHGe
	hldVrCeI/bpb0Tq2hka4znRd939hAFPDrUpE8UPuhsYD6OQVAKSthngODVcL0oLc
	4sbNPYOv/Qr54sUk/BSoQ6BZM+QB1qvYf733ElK9rIEm5izjYfCopKBvRwwIZ4K7
	/JYyGmJ94iSp5/6QZ8JSF62W54vvBZw/dipfrcsiG1BZOC11AzlqrONVbb8l9QZt
	rgD9Xw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ftp4r0se6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 03 Aug 2026 09:45:16 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38f5ac7416eso3475712a91.3
        for <linux-pm@vger.kernel.org>; Mon, 03 Aug 2026 02:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785750315; x=1786355115; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KmS0i4+ikceJ7oOpqw2TVU+CULAM7RtzmwWI6IxadPQ=;
        b=YNaBQ7RQ2j+1wPclR2NlAj9aQl1AYMzo7ohCJ7KlD0FuYDnSqLFxc8DnBNPNaDab5J
         CIs4bAkmhok6wnBjWD/H96zbM+hM9VWVnlWLRJ6+apzyC2dA2FnCJ7625Vo8VXlahQRJ
         aEmPrclRcX9jnxfgYgQ/hK7UfUwm48hcFAGoyKcHleBk0Cw99/wsaoU7++LyCx8/60U3
         r6Dr+Z1bB6QcpDbYvQDvOVn9MlM2t5QCDXLXvS8K9noAdrtvQzp+4RBHIIgDQ4yPqgcq
         Rmlh4sb8IQsUw4yZtmqUsVdqsmpLZbK1P+f60e+RQwVrJ99YU+uh3+coGqWMxBN+tHgR
         Lklw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785750315; x=1786355115;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KmS0i4+ikceJ7oOpqw2TVU+CULAM7RtzmwWI6IxadPQ=;
        b=SGo9BqqU607H0YINZPBjlDkw3VWNCgaZ7GPCkrrwIpFAQdN1i94E1SGaj2dHep7CC/
         q8r6uya9fmmCa+n30Hrk+2ZkIFVJzHAlSBPJ1nxQ4nq0NvbRWYnKqIc/P+3FwdOpdxmW
         CUriz7h4x5RfhHdjaryNQ9Qz2QNclKxjJsaLlhRyJMCkG8QxOsnG/vm3SQmIEL7UDkZ4
         +s8G4aXC6q5KNQH79Ow5+e8fWUVUNqxTq4oHiNkFEKU3y5tFuQzx73Jpvd78jqVGRQ+5
         Az7yJdFph1nZCjTuW8M3GsMT4df8XLO9j1SuDp4L2IngzBcJaXFL5NCaBbYlaxH6l+Za
         Pd0Q==
X-Forwarded-Encrypted: i=1; AHgh+RoVQSFVnJnnrTud1WqiMd5NEZ27jnkyhsXc6esQXsAKQU9cOctE8EPNFlcgrbZhXJxID2Gze83+7w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxHoIzXhfS0qUHItKrBuTI8xWDIBsadnaOBfldUUIOlX3Q9++0X
	4E99O0Am6uIOhsTO46tHld8MhvaDsmAJRFzrh2nvAjLiG0MFFRRDHpzgaIaxfD71fs+6qwXThnt
	ag8QBH3+22iGRgTQFSzc4Z+B9LJxAELaeF32HbWOT9AQcl+9Yl9qt34DEBl4Hhw==
X-Gm-Gg: AR+sD13A0TU4WXARW3iHQ8KLnhKH6YoHtCQJG0rlM5mYCgvP0MT6MA0KzIY5Y3kEHkV
	cRppNvKXOn/VDECEBLVixNzqDkmYyQHaAcm9Ir8WcPvUfxmrFl6SIrqVVmeDe9R2jV37hZhmuzX
	TmN/bD9fMVVgnxCG03IZfBAV9OqpO3RaZxuabHzLculHj0Wn4L1ijxj7yJn6TQAJhKo6/J8NnLk
	gP+wrIhstqMT9tdNQvXzjRmKq0gu3BKHQNBma8KyzYJS+YaPi4+a8SQK2KiI+oSgxa+pN8cwoHn
	3V6zJjAyQx1em1NQJVMuiTHFQ/pMEz7HFS45Siz5jazwVJx5v2MiqpwHwpiTZG3wb4rsQvslgZE
	bFEScfcQizZxUsDLpYs8ZzfyoCX+h8rbESnA6
X-Received: by 2002:a17:90b:4f48:b0:387:e0db:bc31 with SMTP id 98e67ed59e1d1-38fbc56ca58mr7318551a91.39.1785750314663;
        Mon, 03 Aug 2026 02:45:14 -0700 (PDT)
X-Received: by 2002:a17:90b:4f48:b0:387:e0db:bc31 with SMTP id 98e67ed59e1d1-38fbc56ca58mr7318521a91.39.1785750314185;
        Mon, 03 Aug 2026 02:45:14 -0700 (PDT)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38fb2be6c8csm3660671a91.13.2026.08.03.02.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 02:45:13 -0700 (PDT)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Mon, 03 Aug 2026 15:13:34 +0530
Subject: [PATCH v24 03/12] firmware: psci: Introduce command-based resets
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260803-arm-psci-system_reset2-vendor-reboots-v24-3-889281373870@oss.qualcomm.com>
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
        Srinivas Kandagatla <srini@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785750273; l=7849;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=8t6y60ki3WvBG4I02nVmPEeD2nL6qsnMaolT7hOv6CM=;
 b=iEvQgWnrP8vQjP6P5IvdxVeReewecLzubAupX/0UmqFjxielVZ7Bfps9d6wl83I65tpVDLExu
 icKuZANXYNJAnxQRC8u0vwH19Ja3fDDxi5LUk8MoHzg1/dv03tseGKl
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Authority-Analysis: v=2.4 cv=X9Ri7mTe c=1 sm=1 tr=0 ts=6a70632c cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=njxsUegImOJjkw56WvUA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: xG5RqagTUc31jwp7lXC-fH_Mjmmd1kL1
X-Proofpoint-GUID: xG5RqagTUc31jwp7lXC-fH_Mjmmd1kL1
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDA4NiBTYWx0ZWRfX7k9JfRJLoCZz
 +2DPE7Ry1bgC3wJoCYiKdxYuyRXIc3SCnP4BTa4j2XorgmBf0uTEN669926lXR7JMfil6jeazC7
 LV1LteLuaieZUVlp+IvW+7sTuIZaOD8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDA4NiBTYWx0ZWRfXwLyMm84Zl0fb
 5t3jEIWuxETMsDib5Q36RjzqPKwZlXi/hg+/6AHsQiR4wWaHAijH8CRjNnXwgGyrwXztViiXUUY
 evdJsgEJMS8+nu1i1ulDO/UlDJghIfQRJ6+d9oLgYj+ugHDBhal0u59kTQMwr2CKiWn9XR75Bio
 3JJeye+WEvdBtDnUsOFtfWnOgoVzVPu0Mp62YPQ1FP0tfIGe9jRXlS6h4W8M9P4+k7Q8JtAQQNx
 h9BweRDMoyLXwOUdj+HMSULFkvHxAEKPaTlm9wfhQ86j9oV7DQniVdLVl0ZGvrngM6sB/hEH1al
 uTkChXF868cavLTRvBY0uex436tuVidLZmDhRFwwpkoVc6kjBza1JOpkzq5OGYVaWt6dRrE6CEx
 fVmucER6JfBoS4JJ6o9FmJyEoyPD3Yu6TDa95QhNj+H188yFIeaOqkWeUhaRV5+NymEgwJDJ23z
 HOyouuX3Zcn8IEEgNKw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_06,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 phishscore=0 adultscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030086

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
 drivers/firmware/psci/psci.c | 112 ++++++++++++++++++++++++++++++++++++++++++-
 include/linux/psci.h         |  15 ++++++
 2 files changed, 125 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index e73bae6cb23a..094303ef7c03 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -12,7 +12,9 @@
 #include <linux/debugfs.h>
 #include <linux/errno.h>
 #include <linux/linkage.h>
+#include <linux/mutex.h>
 #include <linux/of.h>
+#include <linux/panic.h>
 #include <linux/pm.h>
 #include <linux/printk.h>
 #include <linux/psci.h>
@@ -22,6 +24,7 @@
 
 #include <uapi/linux/psci.h>
 
+#include <asm/barrier.h>
 #include <asm/cpuidle.h>
 #include <asm/cputype.h>
 #include <asm/hypervisor.h>
@@ -51,6 +54,15 @@ static int resident_cpu = -1;
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
@@ -80,6 +92,61 @@ static u32 psci_cpu_suspend_feature;
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
+ * @reset_type: SYSTEM_RESET2 reset type, or 0 for a standard reset
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
@@ -306,8 +373,25 @@ static int get_set_conduit_method(const struct device_node *np)
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
@@ -320,6 +404,30 @@ static int psci_sys_reset(struct notifier_block *nb, unsigned long action,
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

