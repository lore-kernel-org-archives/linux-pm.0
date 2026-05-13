Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E69E390222
	for <linux-pm@vger.kernel.org>; Wed, 13 May 2026 16:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778690671; cv=none; b=Ndc1OAfeou4Ir1WwA30C38W85zNL8sTHKsYfQV//BkWyoAvGTyBepObCvjlo74K9Kqd5vzbKsjYnTj8VmOZX0Eu4/Kl8I583soZxWmY0BjhIoszwiU73GreMMdsQ+gUwYRXL7+AMYvy8D0ZzAtILkBxLxZhTNwSXM4AAdFn5kLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778690671; c=relaxed/simple;
	bh=owGm+6Ms1s9d1BVzLgyFp+un8WuAsYAf6l9Aw77jkfw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=iY0NIbB8WdoGS5C8X+M53C0fZQR8DU4yX/VnZ/+LVpFjyf1i2hhFn6Epa4davUXqgqGo6S7aJ8PT+gKPO7wUIAvIrvxxojhsM7BJcsmURwVxWsTDKHuRIrh8S1lS2144axfvA9oNMaCH39Z21H2liR2RG0/efOn8y9XzoCIpL3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=okBjSjsH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QaJ+tAFG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="okBjSjsH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QaJ+tAFG"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64DC4gm13324691
	for <linux-pm@vger.kernel.org>; Wed, 13 May 2026 16:44:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=GxOv3DEpeFsG7lGsUZy6wV
	j3hN4O8w4tkjgP0Pww0/o=; b=okBjSjsHw5BOpXgK5ziJusqTYibbI6kIQpYBmk
	giLoWevafMpybboM+vGfOD8xMjXNy+ZJYLOlAp/kUl+r5c7wWiR9KQdGYb79jycM
	lQNyyEXf7OmwbBPmAY1I+y2lvbbfywFHr1Ab7fVNKgfozyXdCbIIKiSVRydK6EG5
	kyGJsXRxg9Yu1MB4g/QOuLeykYBO6s+qq3CwguXGfoDFzRx3bp8kTSPei/ObVaQs
	WufDZauE0fbf9DThk9H+PV2/DPmFCYv0xumXye7sKq6P+EquzGF3rwkf45D7y87c
	G5VU4h/3Cz6JoKoVgS+WacJW5ycpsfgeF42ZX5KNZfV2JPwQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e4kvdafxm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 13 May 2026 16:44:28 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-2eebb099efbso11677245eec.0
        for <linux-pm@vger.kernel.org>; Wed, 13 May 2026 09:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778690667; x=1779295467; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GxOv3DEpeFsG7lGsUZy6wVj3hN4O8w4tkjgP0Pww0/o=;
        b=QaJ+tAFG4J/pTJsaDGEHOy6rpQ0+R+z6nDS0NTS/n+uBq6RmJ+19fNdttXAQ42bwEo
         yAV0wDsmq7vuIAlGmG/3hN7DOkq7bMkcjcmOQATUv9z8R7IzgfgYIA98n3fVfyfTvP30
         aBC6EZuQAfBUyClVTm+kq0VvmZ1AyFtILI30zYBgD+fO50QtXoTSbjs714J6lRve9JBX
         VKeAmAQSdsybKg1Xru5b7W8ClEswVSYkSjVYgyx8LOzkJOnE19kpjmar5/XLGBHfVGH3
         xoQsch484dlIqgU0ZyvOA6RdAOUj0HrN72WDAVYUNhc/vuUwFvSgKOeVozZjiUwep8hG
         Qrkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778690667; x=1779295467;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GxOv3DEpeFsG7lGsUZy6wVj3hN4O8w4tkjgP0Pww0/o=;
        b=MGA7YKfbaL/OjRpIcw5wjc4sVXywsvDnryH2V8/UxiZef6BPGeAUilXOphDHO2iVAu
         ixs3iKOVkwZB5pQeRioHRQ+eNJu+EvxBAxyF203JQh/XSNcaOOfQZPGpL0/pmstw1BaR
         8lNxJKHMyribI2eNTjZDAsVubTvrwM68Fa1qRDa0AnQN/yQKF0zALJWHceIDzx+YM/BL
         FuPS18qmDBpnt/UIwS4MBmcSb/IEwgjD+XakQo26jObXWwadHrxlC6XxmBFJ8OtLkG1J
         gXGOfteHz6Bmf6eC8cziQB/bf6JWNZ0R59NwOJApgnoU4ZZPvMFvuxjtZsyc5Qx19REa
         zM8Q==
X-Forwarded-Encrypted: i=1; AFNElJ8NmIWBC7n4WP+7oXTFZFMWP3+evqN/FgCFIMQ07GgeYIR0QyxobLHmEzgyhJcNEWhH5hMImKNbMQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb0PZ/kS8iVrFQHYHZAIX2hCZlIdaUmEQgz3pyAXx/aSLcSZMk
	Ybf+zAdQrQ3ucnCjyvBLRERud54C6o35FeLmF7f6lKMvvERtx+9eGoWAnld3Nh6Iywz9h3I+6ur
	EkVBgfi0zHFFMGsrwThXn5pc/Mkw9oVXu06CRASCkNlVK623cvsWnBNG8Yy/CSw==
X-Gm-Gg: Acq92OHAKIiLuuTPDS7GpJGJbznoBYI4xHuG4X2F4P3RcIx3nvQM4hA92nIu90sE8Ni
	XsnxSOyAv7IfaAw8iWVMGFWs6LvFh+TCjND6cakY6dNgMuu3j2pzJ/PpChJO7EB1yaLhWX1oHhO
	s7oyddoY6XiiEaV3XZWM9r1Wab763q8C37/El0ZfnhnKK045zuXmRd6TKVoMF/fk91E6wbefNcT
	nj5Ii9aNtNCkZjbi00TQFa32cCSBy06izObk1lOOXxxDaSxj8zB3c6UbNk+7OLXIUAfqfzrCDRP
	3bUBO4F+hqtowGce6+blVog1PhWatyVQDVk1TUG2uuPzy7SvkDwQLC3olHm1mW+lpF7cvbFbiYB
	Pw77WslroPha4t45twue8DSx7S/kx7hs0AdSL+9JeK2Bzj6rSTpoxd8mAS7fR7vDe66HxESM=
X-Received: by 2002:a05:7300:a504:b0:2d9:7bc4:9578 with SMTP id 5a478bee46e88-30155e304dbmr1975304eec.28.1778690667510;
        Wed, 13 May 2026 09:44:27 -0700 (PDT)
X-Received: by 2002:a05:7300:a504:b0:2d9:7bc4:9578 with SMTP id 5a478bee46e88-30155e304dbmr1975276eec.28.1778690666940;
        Wed, 13 May 2026 09:44:26 -0700 (PDT)
Received: from hu-aletran-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f8864c37basm22570076eec.13.2026.05.13.09.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 09:44:26 -0700 (PDT)
From: Alex Tran <alex.tran@oss.qualcomm.com>
Subject: [PATCH 0/5] scmi: Log client subsystem entity counts
Date: Wed, 13 May 2026 09:44:18 -0700
Message-Id: <20260513-scmi-client-probe-log-v1-0-00b47b1be009@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGOqBGoC/x3MTQqAIBBA4avErBuwQvu5SrQoHWugNDQiCO+et
 PwW770QKTBFGIoXAt0c2buMqixAb7NbCdlkQy1qJaToMeqDUe9M7sIz+IVw9ytWbaNtJ42UqoH
 cnoEsP/93nFL6AFz84YxnAAAA
To: Jyoti Bhayana <jbhayana@google.com>, Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Sudeep Holla <sudeep.holla@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Linus Walleij <linusw@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-hwmon@vger.kernel.org, Alex Tran <alex.tran@oss.qualcomm.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778690665; l=1343;
 i=alex.tran@oss.qualcomm.com; h=from:subject:message-id;
 bh=owGm+6Ms1s9d1BVzLgyFp+un8WuAsYAf6l9Aw77jkfw=;
 b=W/Xp+gageC3TE/YpgFXFLe+pQ267y6ZmcjgpS00EQKpFmnevoEgeH6XSr277h756bxENsa6q3
 0CHZJDNRK41CRyitjcc/SiRtRARtb3XvVyWqFikd3hYiupPgngaWxsP
X-Developer-Key: i=alex.tran@oss.qualcomm.com; a=ed25519;
 pk=vKab/gw1fXij5UviWoglv+ho+H/oOiTHyETCLfayPE0=
X-Proofpoint-GUID: bZTxjvEeNl2m9FYx05hRBZYwK-vEV6wi
X-Proofpoint-ORIG-GUID: bZTxjvEeNl2m9FYx05hRBZYwK-vEV6wi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDE2OSBTYWx0ZWRfX6UkJ5VwDssKr
 S0zAfkQa4WcA38mxQ0iZh312aI4xr+Sng1jue1cQY283kOo5oEUFSQNv2UNRn69qDd8Dtllwsbi
 DlKV9ZoeA8bK0zHZysylzdQh/TLTiJEA+uMk85y8FaoRJAIhrsgJ+Ikjk4cIyizn1YEo/SQ9SJv
 oPW9cmCUu3YjeOnBiF77wQOq32EDRgwS7IJUEdNWkQ8ByKZaFav4W4T3L3QvT7NT1ehcHKGxmc4
 lpegYCa0ACJIzzWplHGbfXR9AXE57dMhP/rgVtG9YN2C9Uv6XTUKrw6l7v+zNYrzJMfIu9eYwFB
 t0Gf5ykrwH3S/XIrKL9HRrn1bPL/V6NGz020LDtnFzsEPDRv5VFSnZu1hlAgRaPUccvCiZ3N7JW
 41tqFigRt4Y9dwHeN6Ewj9NxgCL0gTl6l7T5tdnZOF1KKwOvQSIvyRmUdQpLXONcibYE85yBibm
 1uhcFMqx4vrISHJS58Q==
X-Authority-Analysis: v=2.4 cv=Iu0utr/g c=1 sm=1 tr=0 ts=6a04aa6c cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=0wi9YMwNQcJCIsSnl6QA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-13_01,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 spamscore=0 adultscore=0 impostorscore=0
 bulkscore=0 clxscore=1011 malwarescore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605130169

SCMI client drivers do not consistently log the number of supported
entities discovered from firmware. This information is useful during
debugging because it shows which domains or resources were exposed by
firmware during probe.

Add logging of the number of supported entities to the SCMI cpufreq,
pinctrl, reset, hwmon, and powercap client drivers after a successful
probe. This aligns these drivers with the existing logging in the SCMI
power and performance domain drivers.

Signed-off-by: Alex Tran <alex.tran@oss.qualcomm.com>
---
Alex Tran (5):
      powercap: arm_scmi_powercap: Log number of powercap domains
      cpufreq: scmi-cpufreq: Log number of perf domains
      hwmon: scmi-hwmon: Log number of sensors
      reset: reset-scmi: Log number of reset domains
      pinctrl: pinctrl-scmi: Log number of pins, groups, functions

 drivers/cpufreq/scmi-cpufreq.c       |  5 ++++-
 drivers/hwmon/scmi-hwmon.c           |  1 +
 drivers/pinctrl/pinctrl-scmi.c       | 11 ++++++++++-
 drivers/powercap/arm_scmi_powercap.c |  1 +
 drivers/reset/reset-scmi.c           |  8 +++++++-
 5 files changed, 23 insertions(+), 3 deletions(-)
---
base-commit: 1bfaee9d3351b9b32a99766bbfb1f5baed60ddef
change-id: 20260509-scmi-client-probe-log-173cf85d5563

Best regards,
-- 
Alex Tran <alex.tran@oss.qualcomm.com>

