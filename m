Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795779757;
	b=2hfWhe9UAlIncELaFTM5G9Zk+kZdiJw0UtwvDJNYJU9Ravi/IBE0C+ELaYkoyMpE3RAT
	 l2XW4hnfklKf8SNuPcwr9NS85QNZLLXHPzJOpnNzbbJ3UiXxOj5YTWd8MhfzkVxncuBaw
	 H1XiQRBExV4Xy8zj7fCpXlik7LQxoUDi2M3Lji586ePXoKxB6pHZz6ierVeawsvKeGz1h
	 Hm914MAqb+nXm+Isz9DIGtctBKI3PHp6gg2QpaMkPKxK/z+khe4YelRu/7K1cjX9KjHfr
	 t+hEmWXLtdNhqfYB4CTC1lii+k8KTJEXlWz04SyI14tkviL+/UiaLCHv/NqPPiYQMDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795779757;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=uGFkSr0D3dGgZgMuqCO9paKpAWb6eQRCIZMkdTJXxQY=;
	b=ivu0TIvtU5/EtjcyJ81bScU/EuMwg+c4L/6WqN9yErfPSM+NBAELjqf+/64sJWVScOfu
	 2da1zHo36VIwO3Pm8iQd7+2ZaS1I+LRn26IYMzb/4CCemAjU6K14bE6kCUDqMg94Q7tw5
	 L4HLUr43DZgZjnUS1sodH0Es3yY9PK2XSO15Np2+7ksXVS5t9S08RfsgPWetDt2saua9k
	 uYFFvpvlqelP+EuuH2vfTG3LD2L3rw5aqHyMv1m348TjHS8xc+jftyI9imMADB1gr+/gB
	 6VbEUFBZ9aqDzWXgEMyYQyIphSUSPCWUru68Ixgql8NDERjzctfyYabueC1PRWQU0jg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="Lamcc/54";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=LgTFteEk;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D974606A338
	for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 11:42:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5D974606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Lamcc/54;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=LgTFteEk
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARApCn12906553
	for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 11:42:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uGFkSr0D3dGgZgMuqCO9paKpAWb6eQRCIZMkdTJXxQY=; b=Lamcc/54wQL/K9js
	UF2d4S5in0GGP537bI3vJQmVEuSPleY/AXkJ6HPgHrEBLJ8R/GggrD9T7jPimiJl
	2BI3lILBADjtpNJ029FUeH2PcFcHtIcB01IcyymmDXAtADkKeXQ+wDOajodGM1Ou
	PCIoNkkW1C4lLsziZeOcEvtLJ/DbM5gN0U7ogGmQHXTTDowzIk9+gBbLe7OCiTsp
	MKRis3n2n5D8cmjj77mFOqGwH7cc+d8DBmX/EazTq3Kz9YyfhRaM0ZRS9saZS4iD
	oOVsaznfnRN+8kB1Gz+zKw0yWQzFd7QrjocqBmKaCjRV96bfUaAK17VTYfF4WQqT
	rtqBfQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6rf93b5h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 11:42:36 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93f5844e383so1174541685a.1
        for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 03:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795779756; x=1796384556; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uGFkSr0D3dGgZgMuqCO9paKpAWb6eQRCIZMkdTJXxQY=;
        b=LgTFteEkVBTh1eHOKwRXsGlS5wsUwGQOKFHhwptttWKedu0iZCzQWwPxhKvqAIOrbC
         u+UANxURAOKUvfxVJ3zZA4ijBYNb3hJoQuwIedQHJ3Gv+MNECprrUPOdh0+wTBdoL5Ou
         UTTZ5C9Y32F4gV+OvOCYgL97ETYzCR/xkLQj/s95aEIIiIU7xEyGMCxZj5krKf+NCdBk
         2oC1i99xzPV4xR9EPJ9OYKcG8spFcDxIuPLM8Op+380UcUpCGyUUH1zffUf7fowdTbnh
         SLMU+It4t0jjPQn0JCSQD8qqxwH1/4o+9cl8XNTYFV49y5wTzCScVeyxrR5mS3I+cFoH
         wOWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795779756; x=1796384556;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uGFkSr0D3dGgZgMuqCO9paKpAWb6eQRCIZMkdTJXxQY=;
        b=2KPOLUsVbmMWl6ptNFhPCiiNFnRR0mlgeUMfv/woBM2VyUhjDN6V9hX9rTdv1kNVqt
         aOqTwScbTLkwIUKjHF7IiSXOGljnKZHv2yWgM278zt3Q4VcAeXsMCiJqUDxaLMDLfQxR
         pV1hkWa9eBhxBuVbl5lLNvwsX6GONC6DEoZY/jZpZjgcveX6LAD5Ymh5h0W70jXT5BP0
         qOnumpyoIn2qbvxpyBP3kFQc5nuiNXrB8CxGUk7rjqz2vZMOz7p3VaxoJN4dBzMabFQU
         u1Zu434riwaiebRAqJZ+uYM0jgGCRtwmit5AoNlFGiTPMLJWTI60n9nB0uYntBvSf+DT
         NM0A==
X-Forwarded-Encrypted: i=1; AL+hErGVo2f9frZ6Nc5JJW+so+JT/OK/lkSc0fnlm7r6slajaQtFpBeqzCRC+ZlMOfvFej47XMQ3T19D/g==@vger.kernel.org
X-Gm-Message-State: APuU4Z/Rd/t+cneui+zGZWl5BzUOOKm+RK1lDAsEo8xVnG+mPUX++DND
	PefmTUplabETEuLJN9MCsS4J3SrAsz1F6STZf9gkC/rQmTmlbjiHSXneX8vOqmbU/2syRn5s0EL
	VZrG3hB1jL+kG9stV2H23aAHLTzqgGfBnxkF8ynJd5O984kAWIUADoAc2e2/URA==
X-Gm-Gg: AZFdTZfpMY0TIzrV+812X1/wMNP0YZuxu9seYfT5kv/vz4x2SN8UYF0/kPj0LkU0PxP
	DHu1Q50rrkSIlhBuc3h3t6Z40bQJWftr+Qx0QYNiEp1pXYr1uv1ZUowBbyd+iRUgh6XeC8bwz9x
	PtkDFjRUTa+jgYOOjX3h+d1WDUzofxlc4Eh3PExvGkqC5XZxTvzAXoMe4RUv2/dNj8vczc/hfB2
	rLJfx8wKCHmLn4wVykOcOmfIQ7eYinbMSZAPJ3zWJmCauTWwXu+sM3JXrdUYQX6kDTgE+sh99+F
	F6GNWnMjbP7axUhimsFyxO+TK723g9Yoey2fXRvlZ58FIYPJEfvkqVi8VWBQnBfuSl8NY2w3rSy
	0LX49pgHdMLqd9ZurxShzyusYEYhxxXqhuPwGGFtRTbS/DBUrTni7FR2yrsXlTrU8BcyCIkZL/8
	XxCDDKsqqTN9iskJODvvrQ5IDfsl9Z9mWxx2wBUMvF29qm35Bbf+FkuJBld0OoxNU=
X-Received: by 2002:a05:620a:2a05:b0:93e:942f:b8b1 with SMTP id af79cd13be357-949bab0eb61mr4514401585a.64.1795779755685;
        Fri, 27 Nov 2026 03:42:35 -0800 (PST)
X-Received: by 2002:a05:620a:2a05:b0:93e:942f:b8b1 with SMTP id af79cd13be357-949bab0eb61mr4514394885a.64.1795779755103;
        Fri, 27 Nov 2026 03:42:35 -0800 (PST)
Received: from brgl-qcom.local (2a01cb1d00dc7e0089167b9b97a26c96.ipv6.abo.wanadoo.fr. [2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6a67f204sm56457254f8f.21.2026.11.27.03.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 03:42:34 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Fri, 27 Nov 2026 12:42:29 +0100
Subject: [PATCH 1/2] dt-bindings: interconnect: qcom: document the RPMh
 Network-On-Chip interconnect for Seca
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
Message-Id: <20261127-seca-interconnects-v1-1-a31bf9b36ac4@oss.qualcomm.com>
References: <20261127-seca-interconnects-v1-0-a31bf9b36ac4@oss.qualcomm.com>
In-Reply-To: <20261127-seca-interconnects-v1-0-a31bf9b36ac4@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Tyler Baker <tyler.baker@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=10396;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=tuwZG5zIa9MymVCxB+cLK/+IndGpDinZ8qo4Jty2D8c=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBrCWynvJAF7jvgeIXWq06VzFwEQXGBzfN+eoO8S
 fZqUjnYvIKJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCawlspwAKCRAFnS7L/zaE
 w4ELEACikjOUZPpILjD0meqzJiYbTPHGrGpME6hSQOz+3tIccBMknZr68RSWCWm436Ueh1i1huU
 iFmvkgSmopqeomujbgvo76tkR228HuI+o3ZSj41eJo7Au28RHPRUG1IezsLHrVfPjvZEsvcEsJw
 UgwV6yIBsvUGPmXn8CASpB1fVfYv7S2NNylurBVfpuEQu1htOTkZNnPC7gfle2825P7dgdmDzbL
 5zxj+zOoqsP4+EiPIK9rj81b1XpUw09JzJxNBhEL+ieSIe/6TUPPY4gAtRuvfd8ovEolnEZG0l9
 9fXiS4R9RvPq/o7NzNiHUYUOh1Dg3kQLKZiHJhpy/YUh+I0H2RgVCiuz3PjozJ48WI/0fCTEd87
 M5Qu8GPUgWoxtbGmCqN8buomETk72xUk4qYtnjpSiRBo9wbDkdwr+iF37hKyrm5iZpH3VAsY8dd
 7iZis101Jj/yFjktuuiVExhiCg4HJeb7EaziHtjwa13AfkeQZvEMXukpfE68MZUWvg6sqG/pLFW
 PdjC2uoS7cXiC1cKGlwDOkXHurJcJXZ70ReLR+vcNqEgk/nCPMyVKl3CVjp2pY8lLbW6LAv433r
 Vh3Jrc/PMxpmYu35k2OCAPa2bgsT/30+Hg+y2YN52VimhkKOpMcalorzw2otnB+EKc6eRJrgg5y
 pah1vZMVWWHNihg==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-ORIG-GUID: EMLaAAeG4yYaDk6w3MSpVVZDBnjFkWJj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA0NiBTYWx0ZWRfXxa6tk5KYPxQN
 7LqoukRIOLo39hnoqagmgOWGWHzggFEHVONdoHSEo1Q/daL3eWb8Kxe9JChiGZCZE1h5FA9gICg
 LwzCV+ggUjEBYejLKzsi5I80DEipI5Ck8GUoQ8YVNJV4s0tWwL4hia7BnVUTuuq7bZP8D/vxMMk
 +cW1R9yEMeJVi9Bzf0kA7uaLH/Ml/uchYJrCi86XZWITgDPYbnX8Lfd6hlBLyiqMi4I7TN6d2LM
 j2nKTOELJOK87bSvKisvsD6jYbjomfhwO5dlEpeGcMlllLrkwjGKVUg7+Q5siaGfUum0Y3bJlRh
 VR0h37hDPcddgi5MQQzp2J0uhD8y5bLsNwYgs04OJOKZRrHYhx741cAQLA/dV1FFEsRty1HzPLS
 kOJmXVaxKxDqwDMfzEbQFCU3bfZ/T4ma0IoyKccL3Z5bkN3kr2hxp2VQqyGOa4ZswRnrV7uQ0En
 9Q+vBVxtOoupcdlm9Yw==
X-Authority-Analysis: v=2.4 cv=cpkOAF4i c=1 sm=1 tr=0 ts=6b096cac cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=gEfo2CItAAAA:8
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=0rS-6sZIjqaa7SBlqhgA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA0NiBTYWx0ZWRfX/yC93XinIPsu
 Bqrd6afj1EsYOCxkRhF0rMj0j7JXVwKAjYEli4ERVGdZZPvNYdt+WkQlTFEVj1WTdma5cs5OU73
 YoA7ew/UuEGz0F0ZFEp+rAZ4GbPbY24=
X-Proofpoint-GUID: EMLaAAeG4yYaDk6w3MSpVVZDBnjFkWJj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_02,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270046

Document the RPMh Network-On-Chip Interconnect of the Qualcomm Seca
platform.

Co-developed-by: Tyler Baker <tyler.baker@oss.qualcomm.com>
Signed-off-by: Tyler Baker <tyler.baker@oss.qualcomm.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 .../bindings/interconnect/qcom,seca-rpmh.yaml      | 141 +++++++++++++++
 include/dt-bindings/interconnect/qcom,seca-rpmh.h  | 191 +++++++++++++++++++++
 2 files changed, 332 insertions(+)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,seca-rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,seca-rpmh.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..d655624833890607600cf768d03bc2d1b6947ae1
--- /dev/null
+++ b/Documentation/devicetree/bindings/interconnect/qcom,seca-rpmh.yaml
@@ -0,0 +1,141 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interconnect/qcom,seca-rpmh.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm RPMh Network-On-Chip Interconnect on Seca SoCs
+
+maintainers:
+  - Bartosz Golaszewski <brgl@kernel.org>
+
+description: |
+  RPMh interconnect providers support system bandwidth requirements through
+  RPMh hardware accelerators known as Bus Clock Manager (BCM). The provider is
+  able to communicate with the BCM through the Resource State Coordinator (RSC)
+  associated with each execution environment. Provider nodes must point to at
+  least one RPMh device child node pertaining to their RSC and each provider
+  can map to multiple RPMh resources.
+
+  See also: include/dt-bindings/interconnect/qcom,seca-rpmh.h
+
+properties:
+  compatible:
+    enum:
+      - qcom,seca-aggre1-noc
+      - qcom,seca-aggre1-noc-tile
+      - qcom,seca-aggre2-noc
+      - qcom,seca-aggre2-noc-tile
+      - qcom,seca-clk-virt
+      - qcom,seca-cnoc-cfg
+      - qcom,seca-cnoc-main
+      - qcom,seca-hpass-ag-noc
+      - qcom,seca-hscnoc
+      - qcom,seca-mc-virt
+      - qcom,seca-mmss-noc-hf
+      - qcom,seca-mmss-noc-sf
+      - qcom,seca-nsp-data-noc-0
+      - qcom,seca-nsp-data-noc-1
+      - qcom,seca-pcie-cfg
+      - qcom,seca-pcie-data-inbound
+      - qcom,seca-pcie-data-outbound
+      - qcom,seca-system-noc
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    minItems: 1
+    maxItems: 3
+
+required:
+  - compatible
+
+allOf:
+  - $ref: qcom,rpmh-common.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,seca-clk-virt
+              - qcom,seca-mc-virt
+    then:
+      properties:
+        reg: false
+    else:
+      required:
+        - reg
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,seca-aggre1-noc
+    then:
+      properties:
+        clocks:
+          items:
+            - description: aggre USB2 AXI clock
+            - description: aggre USB3 PRIM AXI clock
+            - description: aggre USB3 SEC AXI clock
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,seca-aggre1-noc-tile
+    then:
+      properties:
+        clocks:
+          items:
+            - description: aggre UFS 0 PHY AXI clock
+            - description: aggre UFS 1 PHY AXI clock
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,seca-aggre2-noc
+    then:
+      properties:
+        clocks:
+          items:
+            - description: RPMH CC IPA clock
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,seca-aggre1-noc
+              - qcom,seca-aggre1-noc-tile
+              - qcom,seca-aggre2-noc
+    then:
+      required:
+        - clocks
+    else:
+      properties:
+        clocks: false
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    clk_virt: interconnect-clk-virt {
+      compatible = "qcom,seca-clk-virt";
+      #interconnect-cells = <2>;
+      qcom,bcm-voters = <&apps_bcm_voter>;
+    };
+
+    aggre1_noc_tile: interconnect@1720000 {
+      compatible = "qcom,seca-aggre1-noc-tile";
+      reg = <0x01720000 0x23400>;
+      #interconnect-cells = <2>;
+      qcom,bcm-voters = <&apps_bcm_voter>;
+      clocks = <&nw_gcc_aggre_noc_ufs_0_phy_axi_clk>,
+               <&nw_gcc_aggre_noc_ufs_1_phy_axi_clk>;
+    };
diff --git a/include/dt-bindings/interconnect/qcom,seca-rpmh.h b/include/dt-bindings/interconnect/qcom,seca-rpmh.h
new file mode 100644
index 0000000000000000000000000000000000000000..d72b5d385269e4b576aa3f04b6a112ea237ef08e
--- /dev/null
+++ b/include/dt-bindings/interconnect/qcom,seca-rpmh.h
@@ -0,0 +1,191 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef __DT_BINDINGS_INTERCONNECT_QCOM_SECA_H
+#define __DT_BINDINGS_INTERCONNECT_QCOM_SECA_H
+
+#define MASTER_QUP_2				0
+#define MASTER_CRYPTO_CORE0			1
+#define MASTER_CRYPTO_CORE1			2
+#define MASTER_CRYPTO_CORE2			3
+#define MASTER_SDCC_4				4
+#define MASTER_USB2				5
+#define MASTER_USB3_0				6
+#define MASTER_USB3_1				7
+#define SLAVE_A1NOC_SNOC			8
+
+#define MASTER_QSPI_0				0
+#define MASTER_QUP_0				1
+#define MASTER_QUP_1				2
+#define MASTER_QUP_3				3
+#define MASTER_UFS_MEM				4
+#define SLAVE_A1NOC_HSCNOC			5
+
+#define MASTER_IPA				0
+#define MASTER_SOCCP_AGGR_NOC			1
+#define MASTER_QDSS_ETR				2
+#define MASTER_QDSS_ETR_1			3
+#define SLAVE_A2NOC_SNOC			4
+
+#define MASTER_EMAC_0				0
+#define MASTER_EMAC_1				1
+#define SLAVE_A2NOC_HSCNOC			2
+
+#define MASTER_QUP_CORE_0			0
+#define MASTER_QUP_CORE_1			1
+#define MASTER_QUP_CORE_2			2
+#define MASTER_QUP_CORE_3			3
+#define SLAVE_QUP_CORE_0			4
+#define SLAVE_QUP_CORE_1			5
+#define SLAVE_QUP_CORE_2			6
+#define SLAVE_QUP_CORE_3			7
+
+#define MASTER_CNOC_CFG				0
+#define SLAVE_PS_ETH_0				1
+#define SLAVE_PS_ETH_1				2
+#define SLAVE_SHS_SERVER			3
+#define SLAVE_AHB2PHY_0				4
+#define SLAVE_AHB2PHY_1				5
+#define SLAVE_AHB2PHY_3				6
+#define SLAVE_AHB2PHY_ETH_0			7
+#define SLAVE_AHB2PHY_ETH_1			8
+#define SLAVE_CAMERA_CFG			9
+#define SLAVE_CLK_CTL				10
+#define SLAVE_CRYPTO_0_CFG			11
+#define SLAVE_CRYPTO_1_CFG			12
+#define SLAVE_CRYPTO_2_CFG			13
+#define SLAVE_DISPLAY_1_CFG			14
+#define SLAVE_DISPLAY_CFG			15
+#define SLAVE_DPRX0				16
+#define SLAVE_EVA_CFG				17
+#define SLAVE_GFX3D_CFG				18
+#define SLAVE_I2C				19
+#define SLAVE_IMEM_CFG				20
+#define SLAVE_MCW_PCIE				21
+#define SLAVE_MM_RSCC				22
+#define SLAVE_NE_CLK_CTL			23
+#define SLAVE_NSPSS0_CFG			24
+#define SLAVE_NSPSS1_CFG			25
+#define SLAVE_NW_CLK_CTL			26
+#define SLAVE_PRNG				27
+#define SLAVE_QDSS_CFG				28
+#define SLAVE_QSPI_0				29
+#define SLAVE_QUP_0				30
+#define SLAVE_QUP_3				31
+#define SLAVE_QUP_1				32
+#define SLAVE_QUP_2				33
+#define SLAVE_SAFEDMA_CFG			34
+#define SLAVE_SDCC_4				35
+#define SLAVE_SE_CLK_CTL			36
+#define SLAVE_TCSR				37
+#define SLAVE_TLMM				38
+#define SLAVE_TSC_CFG				39
+#define SLAVE_UFS_MEM_CFG			40
+#define SLAVE_USB2				41
+#define SLAVE_USB3_0				42
+#define SLAVE_USB3_1				43
+#define SLAVE_VENUS_CFG				44
+#define SLAVE_COMPUTENOC_CFG			45
+#define SLAVE_PCIE_NOC_CFG			46
+#define SLAVE_QTC_CFG				47
+#define SLAVE_QDSS_STM				48
+#define SLAVE_SYS_TCU0_CFG			49
+#define SLAVE_SYS_TCU1_CFG			50
+#define SLAVE_SYS_TCU2_CFG			51
+
+#define MASTER_MM_RSCC				0
+#define MASTER_HSCNOC_CNOC			1
+#define SLAVE_AOSS				2
+#define SLAVE_HBCU				3
+#define SLAVE_IPA_CFG				4
+#define SLAVE_IPC_ROUTER_CFG			5
+#define SLAVE_SOCCP				6
+#define SLAVE_TME_CFG				7
+#define SLAVE_PCIE_DMA				8
+#define SLAVE_CNOC_CFG				9
+#define SLAVE_DDRSS_CFG				10
+#define SLAVE_IMEM				11
+
+#define MASTER_HPASS_PROC_0			0
+#define MASTER_HPASS_PROC_1			1
+#define MASTER_HPASS_PROC_2			2
+#define SLAVE_HPASS_AGNOC_AUDIO			3
+
+#define MASTER_GPU_TCU				0
+#define MASTER_QTC_TCU				1
+#define MASTER_SYS_TCU_0			2
+#define MASTER_SYS_TCU_1			3
+#define MASTER_SYS_TCU_2			4
+#define MASTER_APPSS_PROC			5
+#define MASTER_A1NOC_TILE_HSCNOC		6
+#define MASTER_A2NOC_TILE_HSCNOC		7
+#define MASTER_GFX3D				8
+#define MASTER_HPASS_AUDIO_HSCNOC		9
+#define MASTER_MNOC_HF_MEM_NOC			10
+#define MASTER_MNOC_SF_MEM_NOC			11
+#define MASTER_NSP0_HSCNOC			12
+#define MASTER_NSP1_HSCNOC			13
+#define MASTER_ANOC_PCIE_GEM_NOC		14
+#define MASTER_SNOC_SF_MEM_NOC			15
+#define MASTER_GIC				16
+#define SLAVE_HSCNOC_CNOC			17
+#define SLAVE_LLCC				18
+#define SLAVE_MEM_NOC_PCIE_SNOC			19
+
+#define MASTER_LLCC				0
+#define SLAVE_EBI1				1
+
+#define MASTER_CAMNOC_HF			0
+#define MASTER_DPRX0				1
+#define MASTER_MDP0				2
+#define MASTER_MDP1				3
+#define SLAVE_MNOC_HF_MEM_NOC			4
+
+#define MASTER_CAMNOC_NRT_ICP_SF		0
+#define MASTER_CAMNOC_RT_CDM_SF			1
+#define MASTER_CAMNOC_SF			2
+#define MASTER_VIDEO_CV_PROC			3
+#define MASTER_VIDEO_EVA			4
+#define MASTER_VIDEO_MVP0			5
+#define MASTER_VIDEO_V_PROC			6
+#define SLAVE_MNOC_SF_MEM_NOC			7
+
+#define MASTER_NSP0_PROC			0
+#define SLAVE_NSP0_HSC_NOC			1
+
+#define MASTER_NSP1_PROC			0
+#define SLAVE_NSP1_HSC_NOC			1
+
+#define MASTER_PCIE_NOC_CFG			0
+#define SLAVE_PCIE_AHB2PHY_CFG			1
+#define SLAVE_PCIE_CFG_0			2
+#define SLAVE_PCIE_CFG_1			3
+#define SLAVE_PCIE_CFG_2			4
+#define SLAVE_PCIE_CFG_3			5
+#define SLAVE_PCIE_DMA_0_CFG			6
+
+#define MASTER_PCIE_DMA_0			0
+#define MASTER_PCIE_0				1
+#define MASTER_PCIE_1				2
+#define MASTER_PCIE_2				3
+#define MASTER_PCIE_3				4
+#define SLAVE_PCIE_HSCNOC			5
+#define SLAVE_PCIE_OBNOC_DMA			6
+
+#define MASTER_CNOC_PCIE_DMA			0
+#define MASTER_ANOC_PCIE_HSCNOC			1
+#define MASTER_PCIE_IBNOC_DMA			2
+#define SLAVE_PCIE_DMA_0			3
+#define SLAVE_PCIE_0				4
+#define SLAVE_PCIE_1				5
+#define SLAVE_PCIE_2				6
+#define SLAVE_PCIE_3				7
+
+#define MASTER_A1NOC_SNOC			0
+#define MASTER_A2NOC_SNOC			1
+#define MASTER_SAFE_DMA				2
+#define SLAVE_SNOC_HSCNOC_SF			3
+
+#endif

-- 
2.47.3

