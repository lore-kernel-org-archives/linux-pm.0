Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1101C337BB0
	for <linux-pm@vger.kernel.org>; Thu, 18 Jun 2026 15:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781798211; cv=none; b=fKeEnb3edDuS1gUVZLbeiO6VD0TfkPB5Xpbfx2CO9p/vvjgiG8dDYCaZZL040IOnj7qK8HGG8/1Vq3d17OrSsis9pktSp0r6msEe8revtU3IQUll2eyIt19QB8KdOtUoJFrgtn/oFwNYDJGf1o/RIdrfDGgIb5equgeGuZEAiSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781798211; c=relaxed/simple;
	bh=ISo22YJnXNXqaVnPUdI2iwKWaaF1NM0ILyuyDS+MJCk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=okoI5I4CaN9Pqbn8JMmnFSkGpRHpfc3ASFIdDds0MdoMpQki7EZ4lz1bdBxx6nuK7xCYGAJmtyvYxj5eyAD9z5Dkbm2c92ZIgm7YSOVvyNB+pZKCCT3OSLI4MNcw3Ej2hdNgn0RHv8+5zF+V80fzuQN81Ww9RmsK0wBaf+8xKe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HMEMYtpU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Sse376YP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HMEMYtpU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Sse376YP"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65IFpxY52259569
	for <linux-pm@vger.kernel.org>; Thu, 18 Jun 2026 15:56:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/dDt5YgHrQVTFxBlDvUvkUD1S0U2BleXm5ZDJEm+gpk=; b=HMEMYtpU19n4fkV1
	DQ37Sr1kDaOTWB/nWmvLonPglOnDbbEK8K+ZHjGmuf1oYnizmR4qzxhH8Um4/xTn
	GzAoy3tPV1X6X7wJjUDx0LRDgXSBr5IfcEf8QStMbGZM/2GQG+S+L1BOXvs5Ze65
	1P+yGX97azGWM6SHP4yR3BgzxcU3EDgXS3b6Q8hjSetrRP5vAmSpWJ3eyRKo0Rkv
	duA+cpOdN4Dqo0oKjtjK/rq2UVuGZHe+LGmfnyg2k4ieWpWxs1ss00sODjm+Sijf
	pHJQW2SiUinz1bpcstciCx3dnKPgWRP9mT453bdZVIreLV0nqJt76xOQ+fe/QjJ9
	AGL4yA==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eux2jw9ua-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 18 Jun 2026 15:56:46 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-1382674ba2eso1919182c88.0
        for <linux-pm@vger.kernel.org>; Thu, 18 Jun 2026 08:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781798206; x=1782403006; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/dDt5YgHrQVTFxBlDvUvkUD1S0U2BleXm5ZDJEm+gpk=;
        b=Sse376YPExR+7s0Tz2BAlSM/FPPDm57lP3mbbSccTGGSKMwbYpJ8lJ3P906ymPWko3
         N0oKS1g48w1sRDw0FV3VXYbJqQ+HOJB45hcmS1tyn9pvASNwwMU/zkUUPCL49zTLRgVI
         v5RCiiNjEIreZAc2Y7/Tv6pYcG1SlNyLb+7SjR7IZSfADXYsuB0y9A3bc3BdCE1LLlsJ
         yljdDktIzXyceDIvgLggvs2/qxXQNxkn8kKNJAGSihBswfcTkwVrnY3RYwM9tPUrX4jb
         aXzakm1g9f16tpsjZsTUSxms5N/762MNHh9q6xe00uRKsoDQxkTXwOs5xrmz+tEL8CKi
         T+NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781798206; x=1782403006;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/dDt5YgHrQVTFxBlDvUvkUD1S0U2BleXm5ZDJEm+gpk=;
        b=T0P1VUfF1m0oKF8gZei9flMxytilF8T5LJPJsewUY9vbgcJtQO1Z0IJBfpsuGVfVko
         pkk9ETeqvXJHp1VPwpsEiSjViG0/7gNo6qaV4mHErVIVoy85CRZyXdxCb1NlYkBoQKcw
         wOWF2sudUPQx8KgnwTa/mw8PnuVROoBjezH5B85aUuSiUvI+g2bj6TFCyhBFnyHKDFW4
         TVvESy29/ZsJ8+kP534w/LBcSFpMrkI+8xTkSWUIN7+8vDCyZPK3uKaOo+iB/GfwF1PU
         MP09tLVsDoLhG04UL9sAnajsfHCMGoW/jLuIkf2mTey/JBwdActfK4/ZPKOb4FwP6ViD
         kCsw==
X-Forwarded-Encrypted: i=1; AFNElJ/09o3UADy0fkz9U8+x6fITaA23k/ym+jEAmtksPwRzIivu88DZXHw+LXP7tVP0IgIcN6pXAQps2g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxCDCwBxoQw0BA+SXd8FeL1peKPcotqJPLjeQCsIcYF8MAp1o8R
	ANO1l0+fIIjZnl4mK7rIFuVe5swr9B6/iIrl0yarhDRud06x0GiYFXGTdOzmiRW+QxtDHHFarpu
	F+FpHkzuuEgOKxEdKtvKU8E5L19egKRQdgc1VlOx93VQjFytN4ZSXyN7bwhvkXg==
X-Gm-Gg: AfdE7cnX1SqUmg+zL3G3ShDbxXqOaxukpdJ2Nn/woPn9P2NaiukPk+HY9Nz3SOM6X1E
	poIjs6LnOPHI1mbi9yY5EsupQPvVX5v5AGJio9wCexzv1O3UWm+QTd+WknT4ZN4VzvWNiNJ+rNp
	CLWPAheyNsBWb0HTl1vvX1gf0n0albGScQNxpUh89tEOZ+62ZeF4jLl110caFE67xLr2p+POZGH
	7lQSKtuyx7+76KO+ntWYjoqT1s+K8y+6YI49FmC5f/7wG2nt4lrPe0XaQnS/HZega5m3+dus5sH
	jJ6pQ4Bpgv9tfZk6GY353UCmJg177uFsn5LFqVTg/NXs6nTQYvHOGK8ZBv0ziEIZrZkkttbwmKP
	BPUMmazJ4JZiDltwXYaZ/+8BnBWv/7jb6Ex7+R/j8gYZTDnFKfNSq
X-Received: by 2002:a05:7022:e0a:b0:137:8bc2:f501 with SMTP id a92af1059eb24-139a20b8f2fmr156778c88.7.1781798205859;
        Thu, 18 Jun 2026 08:56:45 -0700 (PDT)
X-Received: by 2002:a05:7022:e0a:b0:137:8bc2:f501 with SMTP id a92af1059eb24-139a20b8f2fmr156745c88.7.1781798205339;
        Thu, 18 Jun 2026 08:56:45 -0700 (PDT)
Received: from [169.254.0.13] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1384b9110d3sm19671267c88.5.2026.06.18.08.56.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 08:56:44 -0700 (PDT)
From: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Date: Thu, 18 Jun 2026 15:56:35 +0000
Subject: [PATCH v2 2/2] firmware: arm_scmi: request modules for discovered
 protocols
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260618-scmi-modalias-v2-2-8c7547c1be21@oss.qualcomm.com>
References: <20260618-scmi-modalias-v2-0-8c7547c1be21@oss.qualcomm.com>
In-Reply-To: <20260618-scmi-modalias-v2-0-8c7547c1be21@oss.qualcomm.com>
To: Sudeep Holla <sudeep.holla@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc: arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Hans de Goede <johannes.goede@oss.qualcomm.com>,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
        Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>, Frank Li <Frank.Li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, Guenter Roeck <linux@roeck-us.net>,
        Jyoti Bhayana <jbhayana@google.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Ulf Hansson <ulfh@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        imx@lists.linux.dev, linux-hwmon@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
        linux-rtc@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781798198; l=3118;
 i=bjorn.andersson@oss.qualcomm.com; s=20230915; h=from:subject:message-id;
 bh=ISo22YJnXNXqaVnPUdI2iwKWaaF1NM0ILyuyDS+MJCk=;
 b=5f2jzig78+7i8GOi9XkZud3yAV6oYQt+ilyEeUyLhW2skjQn50HhCx+V7eK5vQ/uA0ZWG+L0c
 UxiYpJMAspCAqqob00Y6y3CAenu9vXBzFSvBJJIOzsu/L/kkrEbLYzL
X-Developer-Key: i=bjorn.andersson@oss.qualcomm.com; a=ed25519;
 pk=VkhObtljigy9k0ZUIE1Mvr0Y+E1dgBEH9WoLQnUtbIM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDE0NyBTYWx0ZWRfX/swDGiXtdEFP
 sOhXDSoawDBeilx67MDnHci1niIcIZbzkEyYQjCkEHjC4/d+YgR1GfZgOHybAaY0n7hqSeYlYVf
 xBFnQfJvr8Zz5bq+cI4vMacOD2vuKugnRKFuZZeSkLRZML+9nRsYNnf4+qGPJv315zX5nVA8RV4
 WE6HOfFuSh66/EZ4dcy0XxtgIXW3UsIkcxQdZfDm1EQ0xKq6zPMQwz2KpUDUrbhkb9tdOUXVB78
 3uYD8MjIwxwsCzh/WTed/imLEWnvabvEcqumtLLd1jZ5ewymzyJJXoDE3Hd7vzY3N3b3/RAfBoD
 3Qr01mvC7iuDerwY/rDIsG000TwAEAdXBHSyVMjiJjydnZ4iOf4mC/jfyiP9i37oKLJNH6nfE8+
 wjvpN1tesIvfEC3MsTCUJq6C6QowLS4ysA8FjBd8mtqkEsmE0MdKTDKB/WpRbrQ14kAeDUdfCl+
 6gw8G05oAtt48TNPFaw==
X-Authority-Analysis: v=2.4 cv=Fsg1OWrq c=1 sm=1 tr=0 ts=6a34153e cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=SFLdN7fYUvWWIfk3OzkA:9 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-ORIG-GUID: wAx0pgx1fGAUP7xbcNNM7UypZaBqRCWH
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDE0NyBTYWx0ZWRfX7Q4I85W9ZWXA
 o2Hn0aHJRSy2/Wxlc4YK/8XU0Md4+iIUSfuFiPZGGI6/yRmvXbjQCBdqwG1gggmW5VufrFUazh6
 f6otNZkz/cnxdn/yLWTiRSgJNeGLUI8=
X-Proofpoint-GUID: wAx0pgx1fGAUP7xbcNNM7UypZaBqRCWH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_02,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 bulkscore=0 suspectscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606180147

SCMI client devices are created from SCMI driver id tables. If such a
driver is modular, the core does not know the driver's client name until
the module has already loaded, so normal device uevent based autoloading
cannot break the dependency cycle.

Emit a protocol-level alias for each SCMI device id table entry and
request that alias when the SCMI core discovers an implemented protocol.
This loads modules that have registered interest in the protocol; their
normal SCMI driver registration then requests the concrete client device
and the SCMI bus matches it by protocol and name.

This allows e.g. ARM_SCMI_CPUFREQ=m to autoload on systems that expose
only the SCMI Performance protocol node, where the cpufreq client name
is Linux-internal and not available from firmware before loading the
module.

Assisted-by: Codex:GPT-5.5
Reviewed-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
Signed-off-by: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
---
 drivers/firmware/arm_scmi/driver.c | 2 ++
 include/linux/mod_devicetable.h    | 1 +
 scripts/mod/file2alias.c           | 4 +++-
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 0fd6a947499e..7d33fab94e28 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -48,6 +48,7 @@
 #include <trace/events/scmi.h>
 
 #define SCMI_VENDOR_MODULE_ALIAS_FMT	"scmi-protocol-0x%02x-%s"
+#define SCMI_MODULE_ALIAS_FMT		SCMI_PROTOCOL_MODULE_PREFIX "0x%02x"
 
 static DEFINE_IDA(scmi_id);
 
@@ -3363,6 +3364,7 @@ static int scmi_probe(struct platform_device *pdev)
 		}
 
 		of_node_get(child);
+		request_module_nowait(SCMI_MODULE_ALIAS_FMT, prot_id);
 		scmi_create_protocol_devices(child, info, prot_id, NULL);
 	}
 
diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
index 769382f2eadd..2cc7e78e35a3 100644
--- a/include/linux/mod_devicetable.h
+++ b/include/linux/mod_devicetable.h
@@ -477,6 +477,7 @@ struct rpmsg_device_id {
 
 #define SCMI_NAME_SIZE		32
 #define SCMI_MODULE_PREFIX	"scmi:"
+#define SCMI_PROTOCOL_MODULE_PREFIX	"scmi-protocol-"
 
 struct scmi_device_id {
 	__u8 protocol_id;
diff --git a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
index a5283f4c8e6f..40a37b6bf1ad 100644
--- a/scripts/mod/file2alias.c
+++ b/scripts/mod/file2alias.c
@@ -852,7 +852,7 @@ static void do_rpmsg_entry(struct module *mod, void *symval)
 	module_alias_printf(mod, false, RPMSG_DEVICE_MODALIAS_FMT, *name);
 }
 
-/* Looks like: scmi:NN:S */
+/* Looks like: scmi:NN:S and scmi-protocol-0xNN */
 static void do_scmi_entry(struct module *mod, void *symval)
 {
 	DEF_FIELD(symval, scmi_device_id, protocol_id);
@@ -860,6 +860,8 @@ static void do_scmi_entry(struct module *mod, void *symval)
 
 	module_alias_printf(mod, false, SCMI_MODULE_PREFIX "%02x:%s",
 			    protocol_id, *name);
+	module_alias_printf(mod, false, SCMI_PROTOCOL_MODULE_PREFIX "0x%02x",
+			    protocol_id);
 }
 
 /* Looks like: i2c:S */

-- 
2.53.0

