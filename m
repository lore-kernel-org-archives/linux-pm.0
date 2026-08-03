Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F13381EB6
	for <linux-pm@vger.kernel.org>; Mon,  3 Aug 2026 09:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785750338; cv=none; b=B3VuN8Fx09VhaKYBRcrhpxUzeOLm0dQSEjCyTF2rMujEAC7uH8AvU73qRAco8y1KwOb/hDjb9ckJozR9XfQlDIGoDK9LECIub1Qm2UIX6Gmu+Zt91zheZEHwGS6AySF0YSH4tvctQPz0YVq3L5igFApp7ds7qkPaIbtBQ+X5xMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785750338; c=relaxed/simple;
	bh=jx181RVT+Xa3QJe2eg0re3HefIe2r4k0bcdeIdeVIYk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VnqPIHzyIY+i4y2UEDYG+paQraILCqQzPou1tmx3j1yKV/deON+9kHu2njTFSi21QG3if1wHgK1tJnqXLtBQk57WcoGVVXlJbUGdg/KPaN5/WIo3PIR2CIC5eJ95EKJkNRi+bY34nVPt/sFpDyr/p1fFTDZUMbe2298ElGdMKIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CLhBfX3A; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Qjyi66Xv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CLhBfX3A";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Qjyi66Xv"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6736tRqr3960583
	for <linux-pm@vger.kernel.org>; Mon, 3 Aug 2026 09:45:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Yv45iK+EJbGOlrtao0TiTSTpdAWP/+S9LANR6C5Wz5c=; b=CLhBfX3AmtRTNkLt
	iIde/hqO/gts/Wqk2Mg8iV4Yoo4OYdP9JTLto7pabGM7TDY6G33LADCMuTL4TL+K
	9ci8OpngdrQyJqhnkhzlCEOqSyf18HQ5IIwFZhHpcauoSlPNdp4DxX7ntJimVTw7
	/MvxD0bYNzZRCyBbKGvG4A00iUXCUvZ8+gfLpXPn9vG/2eNDeKNzvp0CA0BILxYZ
	totClmRlREic6+ovDIMAluL/Wdz+m/k6pRTSqQdFbYZ8fQhgkekboSazWf2jgw19
	Kfh7oqzMALT82IpI+90f7QKG3KlqdU+mMK/OXk6K/ew3r7fzalDuhBehE+ExBjYL
	BdRiIw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ft9fajhwt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 03 Aug 2026 09:45:35 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cab041eced3so5125028a12.1
        for <linux-pm@vger.kernel.org>; Mon, 03 Aug 2026 02:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785750335; x=1786355135; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Yv45iK+EJbGOlrtao0TiTSTpdAWP/+S9LANR6C5Wz5c=;
        b=Qjyi66XvxLWQLzFRZujiGXg3hEwIFxYOfvSS2pVCIXTy/mzdwg1lE6rS7n+1MqjN/m
         uqRSt3oe4xeuHqc5/TTwf3iX5B9pOsnZ1oQWzp5SKGuf7d42rwJgS//6W0MRV6Hq9LWE
         yG4JBQ6B+gzKJjbz0a8ENuB8ukYlLZiJhWQZjJ9EgTq4mptMlHVprSWj+1/PoRLAW64H
         nL5NRmufafZPssKcG9/61TsrqEQbjIkJi/i8LE4c/Cqm0Hnojg4ICU9xV/o07YiqNxH5
         sB7dIVSTY4b+tLgRdhYYjM1RgwB1l2Hu+EVEuIJFGqjz5Qh77PQWhUrA4fHaHgRiRU8o
         aEVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785750335; x=1786355135;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Yv45iK+EJbGOlrtao0TiTSTpdAWP/+S9LANR6C5Wz5c=;
        b=mMVoBIVx2p3L2B0HGY/8MrnIoa1ldm6avMweZI87KX/aY3nDiPBxHGgplCg9irLCt+
         0RAEQcyZMr7x749HLR8Je00VRYIXjN7lOYDrlB7GJPJgnKggHW0wqfdD8ko776JRQxbd
         wFbndPa2StV8q8KYv9Z1VmiqW+6W8Xa5eZ4lhX3XHiFMPMTRByCiDh2L9218U5lHNwO9
         BlJqanL2tBuQGmFGOItO+/RJuQB1HApTS14BNvO5LwVCpVz4uGjIMCD5cfZk6vHkoX/W
         7n6V5zD4AMkHalmVCydhIJbig496GDVhFK6ejaPUblC0fPktMDIK7U0nSm/qqgd2JMNy
         /8/g==
X-Forwarded-Encrypted: i=1; AHgh+RrhPl5E0i1DHr966HKfX/L+35QLB+KEzm05tEVLPB/DkivwrYUCzvW0NdSu3qxXU7l0nIXAT1c2NA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzjvlAOW9diwwYcVlFRvFkdjjVb96ZJrjGVPiKiY+vGtlSwOz/a
	vbp9ftbgDKm2gCIl3Ed2QeqVSGcLCFuOTe9dmK0TXRRWck4YR84JZ/+AJUqTmSrjW26ymgJ0s+q
	JVf/CjJ4Vik0z6pwn741e9h3q0+A4pzPGSvLbTEN4qW9HUTVEneQBTUhpsXUf6w==
X-Gm-Gg: AR+sD13FfxgiFm6nYrnRqWV6Ku3mxwKShtG3cYezA0x4NWdU2hhmw67Q7IJIiIrfByH
	79wtk0NeBg5m3s/dO5TWwl3SEwJclgdYFb1AGxqiIeZDM25Qh1RcRBm/OfS/pOf3S50peX55oZc
	JdZxJGPE20RqQoCtpNYmALm5YfBti8OBSlzbm2YbfInZMIhcXftotVHPluAm+O8T6Ynbrjnkaew
	mkZG6okVs7RpCD8FR6MeL+OkeNrxLa+3NCE+0Byys0E7k5Lt8eWebMyulZc6Bcv0TlI4DBx7Stg
	pVFREtHN41Ndo7aG53ZP51+btDxciRcZlyIX9ajEZfXEt3IGAamoqcWooBO0cE04/2c70C573Lh
	cpX6ISyiMhPeu6X5rCueRCsTZ1iJfld/78GKr
X-Received: by 2002:a17:90b:3c4a:b0:389:8f6c:4d58 with SMTP id 98e67ed59e1d1-38fbc579dd9mr8679793a91.34.1785750334571;
        Mon, 03 Aug 2026 02:45:34 -0700 (PDT)
X-Received: by 2002:a17:90b:3c4a:b0:389:8f6c:4d58 with SMTP id 98e67ed59e1d1-38fbc579dd9mr8679766a91.34.1785750334150;
        Mon, 03 Aug 2026 02:45:34 -0700 (PDT)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38fb2be6c8csm3660671a91.13.2026.08.03.02.45.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 02:45:33 -0700 (PDT)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Mon, 03 Aug 2026 15:13:36 +0530
Subject: [PATCH v24 05/12] dt-bindings: arm: Document reboot mode magic
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260803-arm-psci-system_reset2-vendor-reboots-v24-5-889281373870@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785750274; l=3217;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=jx181RVT+Xa3QJe2eg0re3HefIe2r4k0bcdeIdeVIYk=;
 b=ZUjomEzxGruYUFbeJModicvv9K3qeDt+KCUFH3eB+ladIDrsKzjpKb5KbaPCEB6A/khOSHHtP
 VPUuqmEgLKlAAJBPJ9GFsYbZlfmyR95GIt/pHlobN6539b7mgJz2slj
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Authority-Analysis: v=2.4 cv=PZPPQChd c=1 sm=1 tr=0 ts=6a70633f cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=7Vk81bxoM4tuurpRRsYA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: TUqMULjXFG5Ue00pneJK5-ZaRII3ZMGC
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDA4NiBTYWx0ZWRfX+waL/a9c05L0
 RUUEmlvEnbFfMVRzRkYDpBsF9jfbEpTBT5BssiaNLCPFKhRRxl8LXHz1zIU+Uyd11/lvbi5Ddy6
 ZvEquNAPbguM4PEXG5nDU3soyEQzFqE=
X-Proofpoint-ORIG-GUID: TUqMULjXFG5Ue00pneJK5-ZaRII3ZMGC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDA4NiBTYWx0ZWRfX1gdubu70DYIb
 mLcdlUcgvPV4Cp4gPAzuM1XLxcp81KVYElZRep4JbiALfKMsjAuW6/JVa75yrvU4Dh/0vDfzjnD
 KvMfBmSD4rb4iHC4XsPYZbxX7yHjg9+8gfkdnIHMeoWvBwrCKvgkGeUJ64b4YIScVK6FPxC5fd3
 IDO8uVgwbapuEOIVbvEtm+ASpQJBGlE/4TWE3Ie2Y6NR82aDaEiWaWaFMBdI4Ox1Rr73dldbrYH
 9R7CF/4IUPz4BRrCsRIxJYZlWVTt4itR1+rWwWWdhXAVvOaXvT+LLrUGdKMk45Aquj/1hOsr45V
 2dmxFRVBscsvsrEhaTCXPfL8dpkr79bFp4y8TaYFv7bLdpBlNN5fPCTEKiVT5pMycIq7zAUTggg
 laDUM7PrLGcPCVo5g6q1m37Vv458r1GNFIPTAl98KYmMpUcp5MDx7usRj8HVVh2l9y70t0WIheA
 5/IINJLpUQZjfyPVWVA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_06,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 adultscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030086

Add bindings to describe vendor-specific reboot modes. Values here
correspond to valid parameters to vendor-specific reset types in PSCI
SYSTEM_RESET2 call.

Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/arm/psci.yaml | 58 +++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/psci.yaml b/Documentation/devicetree/bindings/arm/psci.yaml
index 6e2e0c551841..7d6a86690a2e 100644
--- a/Documentation/devicetree/bindings/arm/psci.yaml
+++ b/Documentation/devicetree/bindings/arm/psci.yaml
@@ -98,6 +98,41 @@ properties:
       [1] Kernel documentation - ARM idle states bindings
         Documentation/devicetree/bindings/cpu/idle-states.yaml
 
+  reboot-mode:
+    type: object
+    $ref: /schemas/power/reset/reboot-mode.yaml#
+    unevaluatedProperties: false
+    properties:
+      # "mode-normal" is just SYSTEM_RESET
+      mode-normal: false
+    patternProperties:
+      "^mode-.*$":
+        minItems: 1
+        maxItems: 3
+        items:
+          - description: arg1 (vendor-specific SYSTEM_RESET2 reset_type)
+            allOf:
+              - $ref: /schemas/types.yaml#/definitions/uint32
+              - minimum: 0x80000000
+          - description: arg2 (cookie_lo in 2-cell form, cookie_hi in 3-cell form)
+            $ref: /schemas/types.yaml#/definitions/uint32
+          - description: arg3 (cookie_lo in 3-cell form)
+            $ref: /schemas/types.yaml#/definitions/uint32
+        description: |
+          Describes a PSCI SYSTEM_RESET2 vendor-specific reset type. The string
+          after "mode-" maps a reboot mode to a vendor-specific reset.
+          A vendor-specific reset takes two arguments, a 32-bit reset_type and a
+          64-bit cookie. The arguments are encoded as up to three 32-bit cells.
+          Each mode property is encoded as mode-xxx = <arg1[, arg2[, arg3]]>,
+          where:
+          - arg1 is reset_type and must be >= 0x80000000.
+          - In 2-cell form, arg2 is lower 32 bits of cookie.
+          - In 3-cell form, arg2 is high 32 bits of cookie
+            and arg3 is low 32 bits of cookie.
+
+          All values should be provided as per the PSCI SYSTEM_RESET2
+          specification.
+
 patternProperties:
   "^power-domain-":
     $ref: /schemas/power/power-domain.yaml#
@@ -137,6 +172,15 @@ allOf:
       required:
         - cpu_off
         - cpu_on
+  - if:
+      not:
+        properties:
+          compatible:
+            contains:
+              const: arm,psci-1.0
+    then:
+      properties:
+        reboot-mode: false
 
 additionalProperties: false
 
@@ -260,4 +304,18 @@ examples:
         domain-idle-states = <&cluster_ret>, <&cluster_pwrdn>;
       };
     };
+
+  - |+
+
+    // Case 5: SYSTEM_RESET2 vendor resets
+    psci {
+      compatible = "arm,psci-1.0";
+      method = "smc";
+
+      reboot-mode {
+        mode-edl = <0x80000000 0x00000001>;
+        mode-bootloader = <0x80010001 0x00000002>;
+        mode-vendor = <0x80000000 0x00000001 0x00000002>;
+      };
+    };
 ...

-- 
2.34.1

