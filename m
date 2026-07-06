Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C3A47AF6C
	for <linux-pm@vger.kernel.org>; Mon,  6 Jul 2026 12:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783341915; cv=none; b=jXL2vBzt30yCjU9u2FSyLjNGtNwTdLsyQ+oAc2jxQ9eLLg/BYz9J1/qwk3SqIH3id0DXSWfWgDeNe27JfxU3heEXKGSchSiH6aqhRYZSeUOvhwMT0xpIRUkAI5eP3LbBXy4ip1lE9vkJrzk93DCch2EFzaHFnsQ4seIPwRqLXUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783341915; c=relaxed/simple;
	bh=+WcdvgZW/GV7zpd63JB9LAlXwRPQgiphP/JVsTCsf9Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LA67+rwxnovaUOkBz990cRRhyFb5Z4UvE4NCuqLAehEm0DHkPPaYYPE3WvFloaKa++8/C/JpF/Kr75m0VazZPM4lApffZ3xEGcueIyjrsu0d9NnBlg6ullFRvthqa2g7NPCQZX8Dnp1pUgAiIDpn9UecY7e4xHqypKDZuVMirtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ndHVMfvR; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HT+hlPqy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ndHVMfvR";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HT+hlPqy"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666AxYXA238981
	for <linux-pm@vger.kernel.org>; Mon, 6 Jul 2026 12:45:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8hgACBdC65jAViSHKJ8hvXSA6344SjOZiB+08kUdch0=; b=ndHVMfvRot9OESgz
	bmqfKntKEZvo//+p8zWxhoH09IW/KzihNN3W4EvwovRAKx1bms+1LnqsTZKGR9ga
	gxIHIN3cx8h4MQdN2yKrLJPsiaPAMpV3XcjA3009zEVj1O80C4Kpxi6Ev6ZAqFgK
	WpWeOc/IDpLzYVoOrnbVqRR3xxFSbp3nnmRUy9QyWMfPm6BSJJHEgTya9+9MQ0kD
	+0B+LXZQB+tvGXWFJ2qkPNHYK9JfPsnp4S7pdz1MD8SoEPz5KthgBBn/wdLOO9iE
	ufwTG6EeAqd0idJEi9ktHB6kUsfjGyJgdXApDL4Uf4fDDYpNgQdN8u0ezx3x0XO6
	d8QALw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f88t88yxh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 06 Jul 2026 12:45:03 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-92e9a2b95b5so463707385a.2
        for <linux-pm@vger.kernel.org>; Mon, 06 Jul 2026 05:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783341903; x=1783946703; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8hgACBdC65jAViSHKJ8hvXSA6344SjOZiB+08kUdch0=;
        b=HT+hlPqyUsgAAw5mWBP5V5W+pfWrsH07Fdln/67N5AaKCXGKl2u5FgN1A6LixHJ+jE
         ZcH+I+yF7MMPPOk2c9kWXnAmLCniSPw+HdSwjGFgssDNo7GRNa1XSsx4Q+PvO+diQ1Oj
         kj7xCs7CCjAT33Z2zwFf8lSpecw2dgbeUVq5hjGNE9vHHcaeVKvRqCCDtu+9TKx2mluw
         XEo2NxjVq6ybJZYmfrk6M7yj/jW5E4SU60fDaCI2Mc3dJBJPjmEkzBqaW/j1n1GxqIv1
         c5+ACG/VarRvyDMmCBMCvzHSPBvNFa3s/QnTyzohZFy3j/1RptKlA4dP8mkOLZ0IMfet
         oYQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783341903; x=1783946703;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8hgACBdC65jAViSHKJ8hvXSA6344SjOZiB+08kUdch0=;
        b=LqEpQG8a13nzXNRDIl3f8KqRf/I7oUfZJQwPh4EmD12nCgFd4YKGGrA8hHt84jESi5
         +aFj/uAjjMlOEp4lU0th9MqfxHkBTEU70wj1L0qakEi24QDYMsbeD9xHHmKO25sdPT0Z
         y24o7Eb4LZdaXkBk6ehJ8YGfU4A8Ps5wswTxne0Bltn/wXiugtR03KQXhUrL3A222VBW
         WlwYMQNdOgFHcJtnjH4oHFBmPf+uo6Bj8n/3BvTpDwwNXLyfaDDymLoTWie3gDUTCF1m
         INjL/RXXrFis2iznenxpeqEEMAJxjmuT1xrCa/0I1znouUYYtaChln2ubwqfhsBFMUit
         cGdg==
X-Forwarded-Encrypted: i=1; AHgh+Rrqc67iv7XXq+kbEEDzCKNHhP6FiOn4RPuaXlZxNw/eWS2YbEILcLLtXASadkmA7s91S4F7KoMTzQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwZgsveIkNSQQx0y4aW3PUVyFzhJg4XmudKARAKydKhyYLqlOk7
	xoikFBr8VYHMJyy7ZqeSAdpcesymq8HFtBWp4UlRTcPM/P1YK+xA2Css/UPANql01JA3Ug4zMy+
	g32n+YXV9AoHEmqchL1EhAAhSWuxCgwXCOW6i1FxcUh5KvnyClVOnYNnCUzpVEg==
X-Gm-Gg: AfdE7clTtgEBQIG2+GsNqs6bu0y2MUSRlXys5H4RpwalcJb0zX3vISFd/yv9SvKnbJS
	JiRciH1+VhU5WLCbZQ4w/snII4bhJyoYq2xvagQTME31hKSyQAaj8L55pUTsKgYEIidQvrC5Q+G
	yJ20AgJD85ew/0qmcjTzURaIjCt1QqXcF7zq3qq62l7i+a9pv3Vp9li0dQWzX+0vPvr55VFHdZO
	HWVrSsTeuLZ9B8Yq7cEB5vMlmSsxZEBPYVNb9yJdPouol9+e0aNUtfqzoiOA3teYNI74TUVVH6w
	dBOym1lytQVzKLF+Djh50C+1IU8QcGA1ypQayehTQ5iV6doj1GJqWVe2hAppYswk55oaEqcPx33
	4h8APlMHKxS7+GQK4OUsy8LCh3E6wrUwS70Bkq3tP
X-Received: by 2002:a05:620a:4486:b0:92e:6637:db3 with SMTP id af79cd13be357-92ebb5db477mr46123085a.38.1783341902664;
        Mon, 06 Jul 2026 05:45:02 -0700 (PDT)
X-Received: by 2002:a05:620a:4486:b0:92e:6637:db3 with SMTP id af79cd13be357-92ebb5db477mr46116685a.38.1783341902117;
        Mon, 06 Jul 2026 05:45:02 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:86f0:c42b:ef4c:d3bb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0a55be4sm22126539f8f.31.2026.07.06.05.44.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 05:45:01 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 06 Jul 2026 14:44:16 +0200
Subject: [PATCH v3 04/20] driver core: platform: provide
 platform_device_set_of_node_from_dev()
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-pdev-fwnode-ref-v3-4-1ff028e33779@oss.qualcomm.com>
References: <20260706-pdev-fwnode-ref-v3-0-1ff028e33779@oss.qualcomm.com>
In-Reply-To: <20260706-pdev-fwnode-ref-v3-0-1ff028e33779@oss.qualcomm.com>
To: Lee Jones <lee@kernel.org>,
        Mark Brown <broonie@opensource.wolfsonmicro.com>,
        Thierry Reding <thierry.reding@avionic-design.de>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Srinivas Kandagatla <srini@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vinod Koul <vkoul@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>, Rob Herring <robh@kernel.org>,
        Saravana Kannan <saravanak@kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Andi Shyti <andi.shyti@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Doug Berger <opendmb@gmail.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
        Ulf Hansson <ulfh@kernel.org>, Frank Li <Frank.Li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Matthew Brost <matthew.brost@intel.com>,
        =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Peter Chen <peter.chen@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>, Bin Liu <b-liu@ti.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Hans de Goede <hansg@kernel.org>,
        =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: brgl@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org,
        driver-core@lists.linux.dev, devicetree@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-i2c@vger.kernel.org,
        iommu@lists.linux.dev, linux-pm@vger.kernel.org, imx@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, intel-xe@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-usb@vger.kernel.org,
        linux-mips@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        mfd@lists.linux.dev,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2350;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=+WcdvgZW/GV7zpd63JB9LAlXwRPQgiphP/JVsTCsf9Q=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqS6MxkIvUW5KljT6xFge875O9WuwRepvZ/uG/s
 6o6vN4IqrCJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCakujMQAKCRAFnS7L/zaE
 wygzD/9GDta/x8WmSP7QOy6l0yvV7/uc7SVNI8SZk0/6EqQYppSZGt+f/ZQn7n2bhy1cxHgZ34s
 3vBKO/fX5ijfkM4Ov3o2x6YGnwXiwoO2TPjfM/6YHBlrfW1y+A8TwoPXIHgyDFPJxJ6PVQ+4gVJ
 /TK9YFAMFJLfxwURMyg2CpxiTR66hwOXPv9nxFXomOFD++/xJHV9pdzxgnfS2IWVtvBgDSWt466
 0bpd7XvxcC6qsIrSuP0H8ZqkCmAY9J+J1XuK93A4UHaQvVF1eC7dwMqhhEHqlpwTymNUbNJQD7/
 bT5qpqvGh8NmBUR9lXPWDtvejPorQDPOhPLJBFNBHCWCSZS29+1Ez5r9ZG5YryWI4cjaq14KBDN
 8k3TbdQDMjMDrsPoQhhTXZQzo6KaLjLdyc8lY+1G523oChbOOF7jgmkhpwdED6yulf0i7zZoSQU
 ygm/QABfr4ibjk8s5uHfaCo5bRazsd138pJesg0BKxivJxckX93Y7Z+fF7sMHKR11BeCpCb4VPy
 FkDkijjNDyiopNnw4UmM1KfleytMiaPMisGpJSoywFh75Z5yMp5kWMt5Odqgne/VT9Dr4rLQi/e
 bFVf8caUa5gPzaoiiuOdbyLor5PcG8kXRX0CzDVWnMKjA7CDypbfEzPWVn7dC+UO5KqKYMZAXiY
 FINuDuEMaN8BS7Q==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDEyOSBTYWx0ZWRfX5OZrMkFRl7JH
 zyTB75gU7BrFBbC4xDSoqh+quF0ffa6DWg30LM6Obr44qRcmG6lAp08RYU1YPNIzXFLHR+gtIsA
 VW034roYOd3Hlx4THw62lxaHG4Npuxo=
X-Proofpoint-GUID: NojXt7f_1hfNvESyWkvnHnhozdJOruJU
X-Authority-Analysis: v=2.4 cv=C6zZDwP+ c=1 sm=1 tr=0 ts=6a4ba34f cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=QyXUC8HyAAAA:8
 a=EUspDBNiAAAA:8 a=nFtAjRmdzOROD1nQPfEA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: NojXt7f_1hfNvESyWkvnHnhozdJOruJU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDEyOSBTYWx0ZWRfX2IuoVZINGUH8
 oiLYcFpfqIMmzNjmMZe3PL+F/wBzr81NYjHKCwqay1L/OVCH7Zn0kwk3LgPDoKJ9pW1kx6/A1l2
 B6+1g0MJA/valHTFJ/KEsdgVL0n/8mnH88tBFyN1j3VJbd6fGzPkqZRfLsUHNDappjOHo9aDalf
 2gvhsl5ctOGTzf8x9+I7zpWqXYM2SJUiYfvgvhrfBIGReR5RfOMh9IKF2Gj7zMZCnvzyMHWUwKU
 /O7SH6St3szfqyC7Yzq0RuJijCkb5C019u3gy0IRUo34NRQc+oEttWtIeSrK2/C7A2gD2Jvdn2H
 jTaaZe+WDdRd6P66f7fI3+CAhDzOhYaAJsCHDQF+NgBcOH/FkAirHknlacP8wCiJ/B5NJpggsgx
 A1rY6/UkDqL+GcwB6iDG99HFSfs091Nml9EOui4HaVk6rN0Oaw9UXBDX0BIijxLPrVbKUpFw8Bg
 +iEMr0PENTVd3p9XnzQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 clxscore=1015 spamscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607060129

Provide a platform-specific variant of device_set_of_node_from_dev(). In
addition to bumping the reference count of the OF node being assigned,
it also assigns the fwnode of the platform device.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/base/platform.c         | 16 ++++++++++++++++
 include/linux/platform_device.h |  2 ++
 2 files changed, 18 insertions(+)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 6520b70cf3052d683a2ecb1a0dd7227575546ba0..f24a5f406746b53ca9eaab9472f6dd1345e04ad6 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -730,6 +730,22 @@ void platform_device_set_fwnode(struct platform_device *pdev,
 }
 EXPORT_SYMBOL_GPL(platform_device_set_fwnode);
 
+/**
+ * platform_device_set_of_node_from_dev - reuse OF node of another device
+ * @pdev: platform device to set the node for
+ * @dev2: device whose OF node to reuse
+ *
+ * Reuses the OF node of another device in this platform device while
+ * internally keeping track of reference counting.
+ */
+void platform_device_set_of_node_from_dev(struct platform_device *pdev,
+					  const struct device *dev2)
+{
+	device_set_of_node_from_dev(&pdev->dev, dev2);
+	pdev->dev.fwnode = of_fwnode_handle(pdev->dev.of_node);
+}
+EXPORT_SYMBOL_GPL(platform_device_set_of_node_from_dev);
+
 /**
  * platform_device_add - add a platform device to device hierarchy
  * @pdev: platform device we're adding
diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index f037e4101c41dfdbf628d013348d7149ac519721..5333237ec58f30aecb05a3e160c7704fa07a0490 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -269,6 +269,8 @@ void platform_device_set_of_node(struct platform_device *pdev,
 				 struct device_node *np);
 void platform_device_set_fwnode(struct platform_device *pdev,
 				struct fwnode_handle *fwnode);
+void platform_device_set_of_node_from_dev(struct platform_device *pdev,
+					  const struct device *dev2);
 extern int platform_device_add(struct platform_device *pdev);
 extern void platform_device_del(struct platform_device *pdev);
 extern void platform_device_put(struct platform_device *pdev);

-- 
2.47.3

