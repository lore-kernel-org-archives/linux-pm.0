Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795789665;
	b=CaXrvQycyUEB3KaFIYJtJCb6V0XNhs/jy0FJHWlUPnT0iap4LQG80Y1DvEzLRY1Lj6Az
	 M6Ko2DYRmQBdy0gJuyJSZ+m6kAhkI+zLezfAAX6pFnBH07S7VnDH+utpCYV5OQZm8pTP/
	 W0/TVb50N7JdmRlg3Y5wb1p6Xi1bVlsWIhNC9QU8VrWidn7oqGePjmRgTJx4DkVuSGI7n
	 akmVsOUULQ48Srof0pbHpjeFn7kXl9BWP5KGd80qzG4l/Ql4il+EmngA/xe5rszUHSUH0
	 zGQZIFLcQW1y9qJ8G8WnLhS6Fy6MJ8l6UyTGwYWvU5ClofE4nGqwhP75BHvdpjtT1JA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795789665;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=uEMw2lhJoodtkrvH+DpCLwm1Juvj6SN0Fvh2M0KWgiM=;
	b=uLDGsUxRPN2nfLPR7D+IoJhQzTXJME9q8ztgeuzicH0EPG/W39z89y/8P8S9WlyTj7eV
	 O9NGacORft1L7VtmRSxO7hhVigmP8cbxW/HzwYLggsFFoV6fOm9xs8RYZzGU0bezy1T90
	 sY34dxBSwwRIpKpwfzyQLrdwavk7X92kjb6VleTtfKdA4t3ehu5aZF2jUnjqu1r5xQees
	 mb/wSkyLzYRP/XyNJvdRqIDnh13/O98MXHtk0WH4MkfJ5Epmugt467KjFrYSLrQ9WHyem
	 StPoE8Prm8IfAu7Aky/qC3ImMMQFGlkGVmwcWcLO2y+tfBkxQnQqb31AqlDG4Nd1bhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="ENXDvpX/";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=h9LFMLX2;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CA1606C2E0
	for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 14:27:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73CA1606C2E0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ENXDvpX/;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=h9LFMLX2
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARE1YgT1971372
	for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 14:27:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uEMw2lhJoodtkrvH+DpCLwm1Juvj6SN0Fvh2M0KWgiM=; b=ENXDvpX/Uc/bNtqe
	pcF4/Zxmz8OgmagkMXxBJsfDARQgpgXFnNyfIRQcKrJogS9UzgiqWyfdIlQZ77ZV
	NZs7M3bUnpNnXIe2UMYN+9pC1itEvKM0Kn1EnPrLtGpbK+5DN1Esne7euDa9uedj
	57oDXiCBtcy4UjUP4hem6XHHAh+i15whdQND0Ri/naQQpR5EfuH4MJpDh/PZTdVS
	omcVLiPscNIc8U9bO1K96TNHhsBqxg3X8TfNfLaA+RBL9o6FQJEvZH0BDnNcN2qm
	WZDS9A1r9ijQTzIggfdppDblXwk9B0E/F/5zZN4j3dyR+LzXqov1MYK8xHfnktvp
	WtNi7Q==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6u55ubyf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 14:27:43 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2f0467a525eso61251725ad.2
        for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 06:27:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795789662; x=1796394462; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uEMw2lhJoodtkrvH+DpCLwm1Juvj6SN0Fvh2M0KWgiM=;
        b=h9LFMLX2wrwmGf1oJXWGdGMR6R6yZsLR2e7JGaMi0hMBqf1vKjtQQZ9l1SIHTbWNLS
         5x9nZtQs0rdczO3FMTL5pJhI858rE8U/IuWQxU1Q6Lo3p0buq0aI0ri/3K98jKjg56be
         2G1bF6BEGbhjKM1DUicUFW2KWhuZkcXTZJOQi0ObxnXjy5OyUsq1QIw4CCQ0p5W1Ib4g
         pDffaC2CqbHfJXzw5u0L5lQoVRKXA4RO2wcjOeahDNQKDUTOc5nPAbNHk4m78JRZ6NdM
         X9HwqNNxFdHAUp6uwkKzQgQ0opRdfBeCPR1HVIeJmZH8D3kwrphprhtXmPnOFjTQISzD
         iEBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795789662; x=1796394462;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uEMw2lhJoodtkrvH+DpCLwm1Juvj6SN0Fvh2M0KWgiM=;
        b=wOFYsOem/aWubdbsyJRTPnbElenXtCPZM7bNMJoyUa5K9MU3Fq5uCC2ixlcA3SS4Mt
         02YzqV8FhP0Mte9Q0DJCPO6FJvwA2gDdeh+XYHOfcvy/JJ7xdG/cp55jQ5R+Zw0r417v
         fpdlagaxSzsUpr+ba+d4ob9ZejEY3dUQtksgI9utY8PeLqrnzJr6lcFVnu/Z3PeaGrzh
         zI21Xsg4XAlpfQ8vAG+X0AxaruUFeNwl+bfIZTuO2LVaO3jlqEGNrnKV3TjTEOuyrAsS
         18JEImTMhLK2vB7B4GQCULWZtKr81EIoCI5fFIWPkDPOrU7WyujlLiDXTDJEthSENB5t
         DBnA==
X-Forwarded-Encrypted: i=1; AL+hErGbwj9fv7qNVBLXTKlsgrMVb5P0xI+k6JcnLooHTI6xl90tAghkEOhnOb0Wh1KOao10l985HhBVIw==@vger.kernel.org
X-Gm-Message-State: APuU4Z/dotqfiue0v2kvmKt/rte+NMgwiyP2GxC8FKIDohvRmxk/Q523
	O6moMnI+XHwjms/Tpi7y/XBgcf0T7++Ga9Pv3InhwGUjpFqrLUF9g5Fmyt4WmFgGbgb+Lzj7Zay
	9FQaohMNrXTTUEeA723xfbCGxHfxi+OsUDkcqBaMUSh/kP9dB1FHaObSe+FcAsA==
X-Gm-Gg: AZFdTZdU+XBaxIKNC8HdroD+txqsxodUfKRgQ1/yR7ymMqxtrXBG5IEzIi3uTfjXnkR
	U9N7MZaRAeFJb7APz5BfFrLr6Oq04dJxoOMWNd4mGLzwRHeOALrDIbs5Z7XqtltKDOnNGhSp6oS
	YncaWHb9YC0cWwfq0IMkK1f5FPONpM5mw/mgX+PelrlJmG2SdGBUngivNSpqT+ogpMLv/TJPHDJ
	encNWn5wAfm0dfMjYVfTS1dnSGqUuf8G0EwY6GBji40fDEQSdE0lPUkwpIFbIdX5y7FXJZW8/dj
	KPVPJuepfq1OwvZ+faImzm2oKffTIwkJrHY1rq9fskbwyoxk3ybTwdJgQD4RzUm/XjNM9Y/Ars2
	bgM8wtJgr5dALjeafHH5v36gZ/kaYt6QSgi5v6hgJRBVXu35Iydz91lR8iEUMh5MhQ4MPbwqX/m
	TGu51mP10X0Q==
X-Received: by 2002:a17:903:2984:b0:2ef:f656:2db8 with SMTP id d9443c01a7336-2f03f1a49ccmr254184765ad.30.1795789662027;
        Fri, 27 Nov 2026 06:27:42 -0800 (PST)
X-Received: by 2002:a17:903:2984:b0:2ef:f656:2db8 with SMTP id d9443c01a7336-2f03f1a49ccmr254184385ad.30.1795789661500;
        Fri, 27 Nov 2026 06:27:41 -0800 (PST)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03ee84285sm120324055ad.3.2026.11.27.06.27.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 06:27:41 -0800 (PST)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Fri, 27 Nov 2026 19:56:56 +0530
Subject: [PATCH v28 03/10] firmware: psci: Introduce command-based resets
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261127-arm-psci-system_reset2-vendor-reboots-v28-3-da05a33b08d8@oss.qualcomm.com>
References: <20261127-arm-psci-system_reset2-vendor-reboots-v28-0-da05a33b08d8@oss.qualcomm.com>
In-Reply-To: <20261127-arm-psci-system_reset2-vendor-reboots-v28-0-da05a33b08d8@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795789617; l=8137;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=yfPrLsKko5Gv66TXus9j/mTCGhTszpPbkRWeO3+zgec=;
 b=7HYOK+PPPPXBwd4SUWKSfEGXzBTJKTJ2b4gfvPygJje8l2n2eJnuLu0kf5Y1hZyVYrhBnYjpX
 fYNaFs8568kDs7TN5J3NJh1EY/gurtcePAzCcidLObeMvlQTgo/lA8p
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=ssWsJFX3OM9pkdoe4+guOfGPaulHOFt0GVnVlB6on+s=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA1NyBTYWx0ZWRfX8ufva2XLuZO9
 roAERK+DChSaTo4QNawL7sO+X7pqyJsSM4J00XATSoDqeRFQlcYJrzownAE9Q681xw8NeyqvOgK
 Hff6FUf+BFiSd+epZUOa8ScrTHy78sM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA1NyBTYWx0ZWRfXwugAQa51KEtb
 NLDG6k7TniAhqGc6UW0OvJmqQKp0JR2BquPdG6qhT+bNVZhzPpTBs52vm8FETKdSqDbQF8waSvN
 RpvwdZJZptsEbjFqXBRPKivrl4EOJ4DWTsTPj/yFxjFkN+Aas+p7yszLPWczvnDTInUHDnekwcU
 R/+AVHX2YpM3Ga6wkb0iopCXabzRpsXGu0bZ/qoXSzvlh6Q/AEpiUf7HqYbvPhy/07wAh/K1W6e
 3+lKjepea0tBv4Z6pxgQsFDyV8azuYI9zHoOJzOI0LiHkEX8oaiUCmBR3sH8DVa71lBt8KTbW7n
 TRDUIRWSTfpyqhhs6V47POAXDFm4TaY23ICUUDxuThnFQo8ONb55vhIIkEvVDAgmA51IDWbL+Xo
 LOxXeDPEohmYmj2Rl+X2/blYbmKL0JInRvnRW9iZaDiWH9pRKtx3MB/b1PnxZHlweORzy8WWRAT
 DHV1E0ZSk/1Uhrd1fLQ==
X-Proofpoint-ORIG-GUID: u-BQeAUMELXWksUtAeOifomfzqvPSnGl
X-Authority-Analysis: v=2.4 cv=Z795j3RA c=1 sm=1 tr=0 ts=6b09935f cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=njxsUegImOJjkw56WvUA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: u-BQeAUMELXWksUtAeOifomfzqvPSnGl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_02,2026-11-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 adultscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270057

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
 drivers/firmware/arm/psci/psci.c | 117 ++++++++++++++++++++++++++++++++++++++-
 include/linux/psci.h             |  15 +++++
 2 files changed, 130 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/arm/psci/psci.c b/drivers/firmware/arm/psci/psci.c
index 01b1ea6a1c655..2ee3b01011a46 100644
--- a/drivers/firmware/arm/psci/psci.c
+++ b/drivers/firmware/arm/psci/psci.c
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
 static bool __maybe_unused psci_system_off2_hibernate_supported;
 
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
index 4ca0060a3fc42..e81b1cdeca519 100644
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

