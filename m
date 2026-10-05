Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61AFA480950
	for <linux-pm@vger.kernel.org>; Mon,  5 Oct 2026 15:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791214203; cv=none; b=f59ysaPUQYrhBrgkYcS8SU/YTc6XUTI8qcha82kqUjMAAFFvG3rF4r5xydbsr/QbPS2rk2jCXWF1iotrT/EHeYPwjr5VqimflN71kLxym6YdijHEzyOel90Q5V7TzrgyMbi5gQ3I/kFTWEDVtZCWSM0eZ5KdU0ZH8jc3wVHBzQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791214203; c=relaxed/simple;
	bh=BwUtXltowY4TnBr1GJcGDAHCU9wz3VnoxRYwPd5575k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SxIJhNwDu7P9e2BCdRr2Gc/+C7ncReOclcKWRpEKpu8CWEdTUR7bJSGDRYBmTo/+YSfirLIe1vHJXq1tCsFyjtkWrbFrmG9R9wOYOibWQZDicqnhJhi+YUblik1NTC2mRMD++mwFxTT6PJ2ql1ofB3+A/vl30hEn8fb/KB3h1BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dH51bmpx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KfhQA6aG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dH51bmpx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KfhQA6aG"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 695EP5SG2515683
	for <linux-pm@vger.kernel.org>; Mon, 5 Oct 2026 15:30:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zN/XtAkfbnykHQBloZ5iJjv7Y+cRd4ccRdiM3rECfa4=; b=dH51bmpxdQowCa6a
	xq0HA1fLvbghJjXHjsLb+F0PUUM1Gde0wYCl1sz9E6SWbzVFkXjgPaDOHoY9hpDG
	lCLmyxDQ+brTadj/B0e78SAym/Vr85dIcEpQHLZUrPlQ3uTzWfAeKIr3iFOpzUIQ
	K3VQrbHjmHxLrneHbcPMdd3UmaZOLxCbZfHEz/7pmTs8T+x7mQ372yTttJDmco4k
	WP9FYbbKuDxcG4EdHGUE1wXR/tVoNawx+uYChb3w7aooBasanUsJq6U05DkuKx/5
	ChJ1h3KsARHcjpxa+uSR7Dpv9q7Tz5pcbR3iNeN8cqhCfMCRVc7PCqIxCHBI6SyB
	sqzOiQ==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h4bhg0v22-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 05 Oct 2026 15:30:00 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-86fa6b15ed3so2241976b3a.1
        for <linux-pm@vger.kernel.org>; Mon, 05 Oct 2026 08:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791214199; x=1791818999; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zN/XtAkfbnykHQBloZ5iJjv7Y+cRd4ccRdiM3rECfa4=;
        b=KfhQA6aGbUnYalfYwkvbShyeMNcKBexvFDglEaEo8HzsMT1ny3LDFosymaHgF9INzo
         lHD1eoOGpGtL4xZ3ISjFYX9+VkGjjSYdB3QbqeUhEEfPEC0bzLBbbtFu1aSYuTIqiQ2w
         JZiISso0NaDXWVTvuXZWfDa1PjmaCxTjAboqve1rPakPnltLTT0OVQsZBe3PKL8h0RgT
         uWxXL65Dx73SeVVWyewqpxO3c/gjSGnyp6Oix/4rfGtg1FulKU67JRVS8Mv+ZVOG6zkC
         VEmmXzrw5RTXbBqPyqCyHYXLf6gkzPxhBLFD9lyFzX9AXTMMUfFM46C/iyaajfhpzt07
         4NDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791214199; x=1791818999;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zN/XtAkfbnykHQBloZ5iJjv7Y+cRd4ccRdiM3rECfa4=;
        b=ATEnItoN3kY1gY0UffMkDCIKfL5OlvNSgEePhRcnfX4z+SDg/KvvwcITgx1WdyrGhE
         h6fsD/Jt3grT0bkyF3diL+VYgqoFUko2L3HD6/b0hyyAs73MNvakNsUhk00/jGA3YPQw
         LpiGkEF58w7CImAqQp8RPuYj0Lw6ttDKXFQV/ifficujHqCBlZD01RPM2jN1xGC5PnVD
         v/x5L+F2+MQwURD9RhJaEWEJC3M9nWXD54Q80ksssjErIQ2fiPqNyMGv0uoHjdQmHzwk
         48BvttDFRHjogPQ2EaS/OvDWUMpFQTPWqvLXsQuPV8P0K77U/12yqoW9/2uQuwj/H7YL
         sMTA==
X-Forwarded-Encrypted: i=1; AKwUvByXZyL/4IK24W4F6u5aNYc1uEX6GMVmAD6gv0E4nSokNJxc9IOiXHLVa47wJo2MEfZ+IuraJGX3Mg==@vger.kernel.org
X-Gm-Message-State: AFuF++k6XitcOsXI+K8wVqhDkHkrDQK1nWLEYmX5KrkqEN7x4dQ1gNUO
	E5ZFkyH3GSBzAYR5r61QK+gV9AxHp8DC05Wd1bHfkJoo+GJGWG3U3Brse+Sr8RQSgKw2dPOkbYs
	T3kCKETdYin2GWc0AY8BdCkXgXDqVXWcIo/8bQKrisfnjNL7gxbD3apclqY50ag==
X-Gm-Gg: AYBFou0uKEIIeQKE9I75LkKiS1sYH4yMJhalf33DuwJO6+rii34vr8UC3AH65B0cBm8
	cWz69uuoRHa9Vrevxjd7sbf0Y/9E2euUPM9JfzOsa55EA5kOXjCyu6xUtGLn0R6sBIgroBogbt5
	I1jDT/R9v+YkSHGyS9LisXUUgIcG/gjVxuYcy6K7SlHtJ33NLFp2w4VqI8F5LVjPFQXM5ZvW93d
	aC6CzNt4QfMcvMN+epAOtweq+lc5LsaW0C/AEw5FpCcfudj9jFL86oE6Ch8Q42qgxwHoR1n0CCv
	Z4dodkfAMKWJMFvI0PqHMv6Vr8iBGwVhbI9+p63ixgMsnEAjy0qarkUa8WcVFG0CnLC1qQOMzOc
	ANkT7kX4MAoDugGOFb7HtfdyEy1eN
X-Received: by 2002:a05:6a00:238b:b0:889:c4e5:687e with SMTP id d2e1a72fcca58-88af3cc9286mr10276683b3a.8.1791214199130;
        Mon, 05 Oct 2026 08:29:59 -0700 (PDT)
X-Received: by 2002:a05:6a00:238b:b0:889:c4e5:687e with SMTP id d2e1a72fcca58-88af3cc9286mr10276657b3a.8.1791214198669;
        Mon, 05 Oct 2026 08:29:58 -0700 (PDT)
Received: from hu-mkshah-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-88b0c792ce7sm3681528b3a.41.2026.10.05.08.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 08:29:58 -0700 (PDT)
From: Maulik Shah <maulik.shah@oss.qualcomm.com>
Date: Mon, 05 Oct 2026 20:59:42 +0530
Subject: [PATCH 1/3] dt-bindings: power: domain-idle-state: Add
 system-state
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-s2idle_state-v1-1-3c402c66f388@oss.qualcomm.com>
References: <20261005-s2idle_state-v1-0-3c402c66f388@oss.qualcomm.com>
In-Reply-To: <20261005-s2idle_state-v1-0-3c402c66f388@oss.qualcomm.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>,
        Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Maulik Shah <maulik.shah@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791214188; l=1581;
 i=maulik.shah@oss.qualcomm.com; s=20240109; h=from:subject:message-id;
 bh=BwUtXltowY4TnBr1GJcGDAHCU9wz3VnoxRYwPd5575k=;
 b=T256eb3yOc43IOM2WW9e4sYZwSd1iCVH6K4pVsVCqIOMCxxivcG67YBymLdUfsNQvKcZD4OKS
 Cw7wIfJPAr5A8JORGIcWWQRa92/RdtZP5PDmjPbTCq4baSUMp5F45zX
X-Developer-Key: i=maulik.shah@oss.qualcomm.com; a=ed25519;
 pk=bd9h5FIIliUddIk8p3BlQWBlzKEQ/YW5V+fe759hTWQ=
X-Proofpoint-ORIG-GUID: Nd3KfkEQIlh7xl7ECoN8yQeoqzahoDt6
X-Authority-Analysis: v=2.4 cv=GMGdgeNK c=1 sm=1 tr=0 ts=6ac3c278 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=Yot2Wvv7GsybDEU2oFAA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA2MCBTYWx0ZWRfXzQarLQpwbaLm
 0uT9bboPnHiKZErtzbIXwDlp2JE64glbN/wz1W/EAA5WLnifolaXThsZz+uw71nlK5L5mytMD3B
 auW9JiAjNj+6wo+cVuRT3KXpsJmbC/U=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA2MCBTYWx0ZWRfX6/9nhsHpxImS
 YHAzUuLstGT6zZ2RAAoFzfm4+cHboEBCdvJDDoKxbC91yUw3H3utaTwrGDtEwft/3GTULa921WE
 K7yOnePAB2geS9AvmBbc5O7/BHONH8d3BcMLTEUpMy++8jF6FHBQPxqsTMwBkaRd0JW07/nhSJb
 OQMJhQP/ejQ0lGsFmKGOM/kmNRdk/aGIW/nsw5JkhvU6a34EESMse11adz9PxyAaRP2jtbmHYTU
 Ug3u5+3FFgf/IVFZ8k5+cAe8+tyKS0fxpzMOMxjQgpQx4M7zvIVEEgyC/esD8Sts8lwkUolv5eS
 DMhOlqUqC+v3lRUbynb6CDhDvbqL+o/c+drk4aYimppIBH4OHvx5ftBcq/D8fsWVoATO3EN3KtG
 L+ZnRrZve0fUWXGqf0Q8GYispSoO0Ph0gPI/VqCtCIRG2LXo2cWia0s4sHwFi4Ew3Zr27gUey5G
 B6zrxaI3eIh+kth0Gvw==
X-Proofpoint-GUID: Nd3KfkEQIlh7xl7ECoN8yQeoqzahoDt6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_04,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 spamscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610050060

Some domain idle states require system-wide coordination and are not
applicable while the platform is up and running.

Add a boolean system-state property to describe these states.

Assisted-by: Codex:GPT-6
Signed-off-by: Maulik Shah <maulik.shah@oss.qualcomm.com>
---
 .../devicetree/bindings/power/domain-idle-state.yaml       | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/domain-idle-state.yaml b/Documentation/devicetree/bindings/power/domain-idle-state.yaml
index 4dd4f59bbbec..35dab3cd6aed 100644
--- a/Documentation/devicetree/bindings/power/domain-idle-state.yaml
+++ b/Documentation/devicetree/bindings/power/domain-idle-state.yaml
@@ -45,6 +45,12 @@ patternProperties:
           state will yield power benefits, after overcoming the overhead while
           entering the idle state.
 
+      system-state:
+        description:
+          When present, this state requires system-wide coordination and is
+          not applicable while the platform is up and running.
+        type: boolean
+
       arm,psci-suspend-param:
         $ref: /schemas/types.yaml#/definitions/uint32
         description: |
@@ -77,5 +83,13 @@ examples:
         exit-latency-us = <40>;
         min-residency-us = <80>;
       };
+
+      domain_power_off: domain-power-off {
+        compatible = "domain-idle-state";
+        entry-latency-us = <100>;
+        exit-latency-us = <200>;
+        min-residency-us = <1000>;
+        system-state;
+      };
     };
 ...

-- 
2.43.0

