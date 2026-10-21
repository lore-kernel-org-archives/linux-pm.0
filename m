Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792590700;
	b=DZVrnPKIkexl1lx+DZ4m5Fd7vfpYv9wtL+WVrOZtZMrLc9uE7+s9VcvyGb3r1AurvW7H
	 90rHTmO5Y24ASSKbhYyVPEBK3pT2ZaF1cw/T0wpeEMSKIDh8/egRkR0e9AIz4rEDrXdn9
	 MHWOGYoBD6JixHsgdwW3YT5Yxd1mAh52zn90JbTW31xuhXiPi19fpTqABbNbad/oIe0rc
	 aJvXJHfY2CTIpKapLXM5+CJ9CAnhhmCe2SK4BSSklzTZTFySk41GD6AxDAXF8EtUVNOLe
	 4WOpJm0siByk4LDn9lL9e1KwphSgMK611msT9WugrbQyou3E2rE1EX/7icp741hrrJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792590700;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=eqzxsVu9ygVnO09BxDlCxM52wOxdPkt+JaIEaVUrlbc=;
	b=QwxoN1jUi6LHkPEr6Bbb21xENoSx0K0d6Rmh5KD//sdZT+CpqC0NuOxTYMFq5/X9OhXT
	 ODIbUVK33nLBJqswDA3rGwu5uf5QNEHmYkBvZ6H0PTzzBU+Pred87D4Z8Qku5tYf2MHE4
	 3GHer4uF9hya7sUNJHbmqaJizPyUt22MG02FKS7H/9IiPMp7IakanlkXM60iMZo+o5hrH
	 hPnlcfWIM752SlJVBP7JLRCevz6LRlPvZLYATcUkzX3PMWwypnOqsj8FX/wmiTvapi0fH
	 qlbY8em+R8SKypgOkAOGsObnNBOXIM0jZhaK0sfa4tp3zJdoGhPd8FjtV0zGLrnk35w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=m624ddMk;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=W5rXR1QQ;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF15606A335
	for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 13:51:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BEF15606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=m624ddMk;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=W5rXR1QQ
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69LBg7pj1568307
	for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 13:51:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eqzxsVu9ygVnO09BxDlCxM52wOxdPkt+JaIEaVUrlbc=; b=m624ddMk77lyR6LV
	Tr4BtUsxeTVQZZ7+weRwMyhScK7JyI6BY6JEQ6Z8dH3GDGSAq+a70ZzuvkB0lEwi
	bbM/eE4v2OTqCfLPVj7FZaxkJwpfA42aqO+cxinzaIuYprBZG6JNC9YWdRlRB7X1
	ybjOyObS5XiYeGVbijtbQsFbF5v+7AeBggp2W0RwFUVcTv55tSs2+jjvyw8bvURG
	GcOyT5OEarfrxjXl4CujBHv7wiRAhLmfa95YhSqnzde3Xc7smRJxcDk6N9gzpVX7
	4KaEbGkHtJic7ddYZ9rIZaPBWf6thpVBCRAGgRqdlSD63oAzn4gZx+UMQgD7b3T8
	/goIeA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4heda4v7ap-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 13:51:39 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-35cbea41088so1397331eec.1
        for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 06:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792590698; x=1793195498; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eqzxsVu9ygVnO09BxDlCxM52wOxdPkt+JaIEaVUrlbc=;
        b=W5rXR1QQ4P1brtJ5mPczVOt233PiA+qOpjx5BLiAEtMSv5AawrUkpf3A+0N5vFhxEB
         PfmOx/vDlrq7YjG/zAZKI7l62qQaILTOHb/trCPbqRr8WegLv0PvLQ3dpRHlWn3cuxNU
         ur8izxXZHvjjYnmOkn8Ekge7wp/pjWBHwYNedtFV40gnhxiZukhND6pjrph/+toDcIDb
         /EJ6wlYgOHGdd9GM/jwr9TYgtCekeuHkHHwLW2u3TPr9gWi2ghP3OVnrDMQFveizGyf4
         8aV7b+J7O5/Pa4dYxwV+F2M8VecGh7h8AkTvd0mHgyU/fjOITYOnPY2b5BHcfJnR3rwt
         LNvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792590698; x=1793195498;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eqzxsVu9ygVnO09BxDlCxM52wOxdPkt+JaIEaVUrlbc=;
        b=hEojfZ0MButFjWRIqB5ZKHjI0ic9VycEmVLxUAN8aETGD9SeXMJPW3cBCwKJzYAJ8e
         40Mw6fHqXhl4HGVcd07hYg5NiWQ+iBBaIs4MO49N8lbQGSH1rg6nx2q1tFiiRQrMRjni
         rNjcLu46Pp8fqj+SYSZlQ9Q0oB9tOnZQ6Mi0nmMaOHzUF/CRFq6VPAD4c3nHQuT1FhN7
         eM/GZ7SO2hGqwKqgdAxOpXpVv3tc1D8+oP+lyTw2AlwI5yaCAeJxUfFZ1SOy7ZByzrbe
         Bs30Aj5YWvwP95U1V5iIpjiWj1Aj83QcDBWGO9tememz1Os+ktc002dA2SvTwrwIRd6X
         0q2w==
X-Forwarded-Encrypted: i=1; AKwUvBztxVPl4MUZl/MxtfIahXhJztyN508ymNF5g/VQqcnk2uJ8JP/gJwLY+wmgJ3i480iwS9qb6mAuSA==@vger.kernel.org
X-Gm-Message-State: AFq9FYJ3smuNeERyElh7zZg4ojrf6nt/aZiRWfXzm9h9j0D2kcS+/SMg
	SgXkQsNamh9NEvWtaN6cs2HCkVAiSSj5SsG0c7DnIhrbdBZxiugOKhtIPtH/Y/u5llECg5C2PGp
	PPOGr8AVkNW7dEfcwitw4tYBdar0lHr47MEx+arnc2uPqzI8tgjLmErlZdzsbgg==
X-Gm-Gg: AYBFou2ORpXjCrstQHoqgHg9WZc98EjydrjyAa6dkNNqXYVg/jM2LVXCbmq5mpIqabn
	nCg5RvVeyXwt3dAl1D5Ljs6KCrahQ8GlrIt9hdgV35UxlS3Bf6aKVDQSX9EyD1jNhp3y38Bq/Dk
	TxwJLq1S68cTCbAW23XO3IVkYp4LuUDSRkpd/Hz3oR64clUpwyYubCza+ti+ayt7LcH6utpVzNJ
	blFGnXcotsatFZQ6EhzSB0c+WgWRpeEhy6D7sC73eV9HGyzfZB9xUnHSSfkrjniQZMU0CDzPWfB
	6LQZeczd8sJ2pvQlVBFEP+N7hFxXe0K3jMnsvsWuK3QM1/xMqsPBufnjHxS+2Cn3tJZOuDPGb10
	JzoLxTy73ouPEAQCVu7RK9pLnuyA9rMzrNw==
X-Received: by 2002:a05:693c:20c3:20b0:35e:60ca:81e9 with SMTP id 5a478bee46e88-3674d047291mr3705203eec.21.1792590698206;
        Wed, 21 Oct 2026 06:51:38 -0700 (PDT)
X-Received: by 2002:a05:693c:20c3:20b0:35e:60ca:81e9 with SMTP id 5a478bee46e88-3674d047291mr3705116eec.21.1792590696844;
        Wed, 21 Oct 2026 06:51:36 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36740cc848fsm7534332eec.13.2026.10.21.06.51.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 06:51:36 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Wed, 21 Oct 2026 19:21:22 +0530
Subject: [PATCH 1/3] dt-bindings: connector: Add PCIe M.2 Mechanical Key B
 connector
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
Message-Id: <20261021-pcie6_fix-v1-1-ad37134c35a3@oss.qualcomm.com>
References: <20261021-pcie6_fix-v1-0-ad37134c35a3@oss.qualcomm.com>
In-Reply-To: <20261021-pcie6_fix-v1-0-ad37134c35a3@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792590686; l=6589;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=Hcd8AhF5neUwdC/MlSlABuWRJC+I82zW/2oPCsLOsTo=;
 b=BDqVkQfSgirwVpNSh1XjiN+Moh+pk78Elv4J7qPXubw9pEpimWukRbglPMWE3LkhDGIvOex67
 9GsLG0RrSIzCM1br9Eask63qy/vFOezwJySTUIP9QdUriHMvnKxrlRa
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-ORIG-GUID: 4qQH5kveDhvRC-jv-nJpMC114Ba3SkT1
X-Proofpoint-GUID: 4qQH5kveDhvRC-jv-nJpMC114Ba3SkT1
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA1NSBTYWx0ZWRfX2qxjUDwi/m1q
 rs92bIs2EQuLDr0KDYTNmOF5c3yLKss68IH8Q+oPmtx5OwhbsmWo2nb/ftzhWK8C1RDX90Mmg3H
 ZVu47Ov59x9LRbH3E5EIoPJeItL5TWc=
X-Authority-Analysis: v=2.4 cv=R7aWitRX c=1 sm=1 tr=0 ts=6ad8c36b cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=nzPhZw1G-5J1C4WXyrkA:9
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA1NSBTYWx0ZWRfX5sWdhdWZ6i/3
 AkYltuuGbboPS6Cs72LCQNOtFXvD8CT2WhIYGOgUXi1yJ5tDgrf2AUrnCH7Ckt+OSJtk2qChYnc
 F3KX9JiKrN+zIuDTXnEO+63iK5TEx+Irj6EWTfQJDJ962/ndvp3BL3JSMITs+rl8+8czMOd8UBq
 Hs4haMNskQiuDc4Iud7cPqvE5wYx+eJe1aCG1enznFCuuJWhyAVNT6vZ2w/aMUozTxdfC3yk9Xh
 VWbth3gWJhykQI8svp0dn5ME+POF/sgKvRiMRN+0aM/e8CQSG4yFezro3lFTYVMGzRtgc9bHE00
 EyPBY33EY72qzJoAZx7uQWZkQqpW7QJ4vaTvBYNGadcPCcAS/dGZLQkiEl4MzSxq3Nbws92399o
 Joz0vhChhuKJdexS3rF5jgQzhUuk3Vev64qVv04QkXJB2UMVoglyM6kAOni95+L+rsWhDo8FcoZ
 xdcvuv8ML27CHXqpctA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_03,2026-10-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 spamscore=0 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610210055

Add the devicetree binding for PCIe M.2 Mechanical Key B connector
defined in the PCI Express M.2 Specification, r4.2, sec 3.2.19.1. This
connector is used to attach WWAN Adapters to the host machine over
interfaces such as PCIe, USB3.1 Gen1, SSIC, or USB 2.0, selected by the
Adapter's configuration pins.

The connector provides a primary power supply of 3.3V/VBAT, along with
optional GPIO signals for WWAN-specific power/radio control:
FULL_CARD_POWER_OFF#, RESET#, W_DISABLE1#/2#, WAKE_ON_WWAN#, and DPR.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 .../bindings/connector/pcie-m2-b-connector.yaml    | 146 +++++++++++++++++++++
 MAINTAINERS                                        |   1 +
 2 files changed, 147 insertions(+)

diff --git a/Documentation/devicetree/bindings/connector/pcie-m2-b-connector.yaml b/Documentation/devicetree/bindings/connector/pcie-m2-b-connector.yaml
new file mode 100644
index 000000000000..a7f4bcbc5119
--- /dev/null
+++ b/Documentation/devicetree/bindings/connector/pcie-m2-b-connector.yaml
@@ -0,0 +1,146 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/connector/pcie-m2-b-connector.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: PCIe M.2 Mechanical Key B Connector
+
+maintainers:
+  - Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
+
+description:
+  A PCIe M.2 B connector node represents a physical PCIe M.2 Mechanical Key B
+  connector. Mechanical Key B connectors are used to connect WWAN devices to
+  the host machine over interfaces like PCIe, USB3.1 Gen1, SSIC, or USB 2.0,
+  selected by the Adapter's configuration pins.
+
+properties:
+  compatible:
+    const: pcie-m2-b-connector
+
+  vpcie3v3-supply:
+    description: A phandle to the regulator for the 3.3v/VBAT supply.
+
+  full-card-power-off-gpios:
+    description: GPIO output to FULL_CARD_POWER_OFF# signal. This signal is
+      used by the host system to turn off the entire Adapter. Refer, PCI
+      Express M.2 Specification r4.0, sec 3.2.13.1 for more details.
+    maxItems: 1
+
+  reset-gpios:
+    description: GPIO output to RESET# signal. This signal is used by the
+      host system to place the WWAN Adapter into a power-on reset condition.
+      Refer, PCI Express M.2 Specification r4.0, sec 3.2.13.2 for more
+      details.
+    maxItems: 1
+
+  w-disable1-gpios:
+    description: GPIO output to W_DISABLE1# signal. This signal is used by
+      the host system to disable the WWAN radio on the Adapter. Refer, PCI
+      Express M.2 Specification r4.0, sec 3.1.12.3 for more details.
+    maxItems: 1
+
+  w-disable2-gpios:
+    description: GPIO output to W_DISABLE2# signal (default function of
+      GPIO_10). This signal is used by the host system to disable a second
+      radio on the Adapter. Refer, PCI Express M.2 Specification r4.0,
+      sec 3.1.12.3 for more details.
+    maxItems: 1
+
+  wowwan-gpios:
+    description: GPIO input to WAKE_ON_WWAN# (WoWWAN#) signal. The Adapter
+      asserts this signal to wake up the host system. Refer, PCI Express M.2
+      Specification r4.0, sec 3.2.13.3.6 for more details.
+    maxItems: 1
+
+  dpr-gpios:
+    description: GPIO output to the Dynamic Power Reduction (DPR) signal.
+      This signal is provided by a host system proximity sensor to the
+      Adapter to trigger a reduction in the radio transmit output power to
+      meet regulatory SAR requirements. Refer, PCI Express M.2 Specification
+      r4.0, sec 3.2.13.4 for more details.
+    maxItems: 1
+
+  clocks:
+    description: 32.768 KHz Suspend Clock (SUSCLK) input from the host system to
+      the M.2 card. Refer, PCI Express M.2 Specification r4.0, sec 3.1.12.1 for
+      more details.
+    maxItems: 1
+
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+    description: OF graph bindings modeling the interfaces exposed on the
+      connector. Since a single connector can have multiple interfaces, every
+      interface has an assigned OF graph port number as described below.
+
+    properties:
+      port@0:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: PCIe interface for WWAN
+
+      port@1:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: SSIC interface for WWAN
+
+      port@2:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: USB 2.0 interface for WWAN
+
+      port@3:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: USB3.1 Gen1 interface for WWAN
+
+    anyOf:
+      - required:
+          - port@0
+      - required:
+          - port@1
+      - required:
+          - port@3
+
+required:
+  - compatible
+  - vpcie3v3-supply
+
+additionalProperties: false
+
+examples:
+  # PCI M.2 Key B connector for WWAN with PCIe interface
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    connector {
+        compatible = "pcie-m2-b-connector";
+        vpcie3v3-supply = <&vreg_wwan>;
+        full-card-power-off-gpios = <&tlmm 121 GPIO_ACTIVE_LOW>;
+        w-disable1-gpios = <&tlmm 122 GPIO_ACTIVE_LOW>;
+        wowwan-gpios = <&tlmm 123 GPIO_ACTIVE_LOW>;
+
+        ports {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            port@0 {
+                reg = <0>;
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                endpoint@0 {
+                    reg = <0>;
+                    remote-endpoint = <&pcie6_port0_ep>;
+                };
+            };
+
+            port@2 {
+                reg = <2>;
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                endpoint@0 {
+                    reg = <0>;
+                    remote-endpoint = <&usb_hs_ep>;
+                };
+            };
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 7b5cab72d851..22cfd2b72e1a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21794,6 +21794,7 @@ PCIE M.2 POWER SEQUENCING
 M:	Manivannan Sadhasivam <mani@kernel.org>
 L:	linux-pci@vger.kernel.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/connector/pcie-m2-b-connector.yaml
 F:	Documentation/devicetree/bindings/connector/pcie-m2-e-connector.yaml
 F:	Documentation/devicetree/bindings/connector/pcie-m2-m-connector.yaml
 F:	drivers/power/sequencing/pwrseq-pcie-m2.c

-- 
2.34.1

