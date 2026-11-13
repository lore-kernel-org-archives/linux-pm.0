Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794545741;
	b=1H8E271AM5OJ1SV6+HTpNHe00x0JOeJOA7CTOLHPfBdz0dpqG7BZ5/z8AFKnLD9YxYsW
	 vHkqCszUIAWS6ILF5go/6NeyVvXSbGljiE2rZh4CCZFbyeRQpvsDQljpgGgzhERVTI0T0
	 OLW6xluyo8xYl6PgmMms6YpOr2SFiqij47aEZxlCzIJIDURvZozMy7uayGs1FrIuZF44D
	 VvGLl/lhRgSxnCGfGJogurOp8ER84i7CGlMl8QrNRnQK0vqtSk8X3TlTb/qa4+4pZJ3tO
	 38+zkpQ2N/tmrz4Kdx8UKEQTTK2v5DfeBvAT/OnmCM8XLp09Cl2JYhbTjGc/LkZ+HIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794545741;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
	 Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=lIx2CS6fCKzreivxpI3mpRmL8+uVjdMEVbrcvV2S/hc=;
	b=y6Z+D0xkOYBeEADsntu8uK1WW9xGsBCtmSJkjFtZGWzDSBZeRtR8hpEgAx93+mHmm9gh
	 6OXFj9oVgz5YR3haajRUwr7Iyyv56RSasKEzIqAj0mW/nMzUD4xMZJB/Ra2mUHbSoXlJG
	 E05ZPPSNqYu940cc8WrAm5zMx2H10TPXVucU2ExSw6AiPYhtyIr5kLTep3mDxdg7iuBOI
	 syTRJs2bGas97/TjTAaI5ZxiHHQ/Dr2/xy9jkCmfVFJXdk+6hlO0tw91/B5MTQlhe1ZRM
	 xFWFdhDKa3NiXru80k000OKwdBNd08GooWHNI3HU1vdSwsVqnCnKGAAMiZsnIs/VzUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=daFS2vY3;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=T4yh41oD;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE33606A31C
	for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 04:55:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DDE33606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=daFS2vY3;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=T4yh41oD
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AD2KKtK3273986
	for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 04:55:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=lIx2CS6fCKzreivxpI3mpR
	mL8+uVjdMEVbrcvV2S/hc=; b=daFS2vY3tyzzpbHxBcyvg9JvBDBwIna96I7QNn
	dVU7jaOdRvYClEabSoM/8bNUlcN7wh/N+vteKMT0XKmuHqskSSUKRUmxmK5iWs0r
	dApJaVx00VcJFk5fvqKzkRNGudCO1LCdfj7lIBcEqihTkH+UOrVuNwIu/wqq4NMY
	Kl2jiPf44mW7NyAFxPmTJ4FvTtfVHH8xKsxCGrrYcmpVtUuSJCTfPPT1SxNAeoHg
	nWwBsfQzypRYZh+n63bQ/6CCZB8/ERTL/h2N8lGNSIHNkevWiUFb0XyLt0oQW2aY
	IswJEfj1AcGvrNX2PwBqBEtGP18Oz+vnewkiBQiahTOs+lDA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwqufgrtv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 04:55:40 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2e942b1cc86so5601885ad.1
        for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 20:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794545739; x=1795150539; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=lIx2CS6fCKzreivxpI3mpRmL8+uVjdMEVbrcvV2S/hc=;
        b=T4yh41oDdiXb+vsbtQO/66WyQmqt5b5xUQLtoWFPViXMuLIvZw1HoHSBrpudbeeNxK
         Xiq7boykSSH+VGapAFcnT9IX43mbTiUTcgI7PVbK1xwkifUhw+d+QdwjQeGhTy2tUVXS
         F5eNDV2FvyIaxT1F+BHslptbqsX4ZZJv5zTm3LApoPkd1uZpRqWOPPmgRKBO2o8BzfnV
         wEs9sUQPuEECBxtYWlSy2DYHB6ucq+uG8ydVA10XKOUD9qhLImLpfmseyPbnp2tuVc4j
         x4AOkbBqiLPU1b+DtusAombiE7KXN/rWl/Mx3aUu0eGuVkVRwDC5vyVIwPh6OKeS4SS1
         qQTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794545739; x=1795150539;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=lIx2CS6fCKzreivxpI3mpRmL8+uVjdMEVbrcvV2S/hc=;
        b=u9zE+5bCgOcG3qB7EJlYTydX7t1UPwJyiAEtrtT0pANw3OT9JeWcUkBbNNqRVD7xeD
         cZBGTklx1bAay6zfytkBTKNnohw1yg5XKz8uuf2zMxG6+ME80mlus7DhL5NYryzMfKRx
         F2jVz/flTPSptGv7Yk8wR+XBoYBZq/qGR7kQKf51Eb8edv9b6O9n29yRO4cd+p5QcdI+
         l9lX7ZCFUojVacjDB0xAootnWPYhDoB5LxhUGkvuW1zecshM3vbvIi8QfHArO02sD9q3
         S8iTJ1MIC1faScG2eIKdqIcgYvoZEpj7hu5GsprnJvEtIm3fFErv5bKsuro/N26PF48j
         lpGw==
X-Forwarded-Encrypted: i=1; AL+hErE+jh1MI19Yfqlo3q+Mk/7D7Cl4xjfIvtku1zE22rM3oCxDwp2sznREcGyOLLKrp9CUmch6LtjWdA==@vger.kernel.org
X-Gm-Message-State: APuU4Z+JbgBbuLJky/GgvPaKi9o/lIK23rQQb4U+jvMsSuzPWMRrc51d
	/t3Ger/iw7hm8afWmYOAUDWMhHIMBP1VHgtUgsHuk4O6Quxdes5DHwcpyozxSF0Ax38VLVHD7FE
	O+DfigMWRd3GOUHwJJ4YNQIBkmfOHWOul46yVWasKUdxShluVkvckTQm/bUU8/A==
X-Gm-Gg: AYBFou0sS9iC3XPmCfLlhauY02K6Rs2YvZ2C6NPZ0pvPjVpARmgTPELmUWjQ6l7DxrS
	oblY/MXflf2HxfqF982xQQ5gsdDUdInk4UaYhtlCfRmHykDY2srlTweWyO8Nv7FNY9ZNePmFIzy
	YqP0gkYAjpSuQNt0oAXJ7vgPcRODKH1zMqnCnKYnzlCutK2ND+nNq8/+Are0uDhFZwhUzCRgR32
	g3Wr4hO0JWI2WJZfI18Pf0a5UzXtct2BnVOlLSEtat6Kt29YVzszunUSxRdgcFT+zYZ5pEcTAjA
	Kd0Pc+O40W9QzZ+YN+xQXGnTMf41IZ82tN7mxfL7r2i2k3Fy6EV32dtbbMjLGEq+WNbMmhDGRl9
	+vk7jmWEPS7XC7vmBK/6toKCs4NCsrX3UOT/EB6PGSheK4HWduzW+qbujfjhsfuEPFY7x15rvDe
	7r
X-Received: by 2002:a17:90b:5684:b0:3ae:521e:767f with SMTP id 98e67ed59e1d1-3b1b0a49a8fmr902246a91.36.1794545739346;
        Thu, 12 Nov 2026 20:55:39 -0800 (PST)
X-Received: by 2002:a17:90b:5684:b0:3ae:521e:767f with SMTP id 98e67ed59e1d1-3b1b0a49a8fmr902226a91.36.1794545738813;
        Thu, 12 Nov 2026 20:55:38 -0800 (PST)
Received: from hu-mkshah-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197d0fdbdsm7739875a91.10.2026.11.12.20.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 20:55:37 -0800 (PST)
From: Maulik Shah <maulik.shah@oss.qualcomm.com>
Subject: [PATCH v2 0/3] pmdomain: Support system-suspend-only domain idle
 states
Date: Fri, 13 Nov 2026 10:25:24 +0530
Message-Id: <20261113-s2idle_state-v2-0-ad604182e7e7@oss.qualcomm.com>
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
X-B4-Tracking: v=1; b=H4sIADyY9moC/1WN0QqCMBiFX0V23WSba4yueo+QcPNfLtTV/imF+
 O5No4tuDnxwzncWghA9IDkVC4kwe/RhzCAOBbFdM96A+jYzEUwozhinKHzbwxVTk4AqqaUxxkn
 tDMmTRwTnX7vuUn8ZJ3MHmzbH1ug8phDf+9/Mt95PffxXz5wyWlnJhFXKVVqfA2L5nJrehmEoc
 5B6XdcPk3VKo8EAAAA=
X-Change-ID: 20261001-s2idle_state-6484bbbf48fb
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>,
        Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Maulik Shah <maulik.shah@oss.qualcomm.com>,
        Kevin Hilman <khilman@baylibre.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794545733; l=4313;
 i=maulik.shah@oss.qualcomm.com; s=20240109; h=from:subject:message-id;
 bh=h+OJXS5GpG4CzdSwZr2uBBdlCOkcwJ/oouQ8a6ggKp0=;
 b=LBVhYye/0VIMpScQ4j/tbHUueTory6C/vc5CyqmBBCJSAl7K3uo4+SgPfL/7UrvaRuaMMWByO
 quEhUuqYTk4BG0yCSI9mcz4hRWer6Dh/K/K7oSJedBU7vYB4cM+RImQ
X-Developer-Key: i=maulik.shah@oss.qualcomm.com; a=ed25519;
 pk=bd9h5FIIliUddIk8p3BlQWBlzKEQ/YW5V+fe759hTWQ=
X-Proofpoint-GUID: PqhW95KPc7l95Cfv86vITVPDr5Hl-PGR
X-Proofpoint-ORIG-GUID: PqhW95KPc7l95Cfv86vITVPDr5Hl-PGR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDAxOSBTYWx0ZWRfX7yYQ3UmkGEKY
 YVVa0WKfgAw7CdCSiwXadYDajDIijkucXxFHkPDiISA0D/wmoK+oybrTTsz7b8GCdcgj9xDQ/uv
 jM1h1JyJrmb1f9RA4vf5seU7R+9YXp9OvLxjHXAIbgTJGVbG/G1+fGUEH4Jrb4eMLxA3Syhcmx2
 grFVpLkhMGe48szpXby3hJPXWqIjiy/zIL7tJjf9hEev25UI153cIs97dqQAoadNC03Hp84+Hzx
 w/5lsYblQOVT5VWziVWOh77WEQ/y9I4hLDA8BK9agAH5tw6fVC5WFyNYI11LOKXm6NkW1INWYp8
 KN6tKvtobtzZ+ga7vkO/eBqlygWrw/DAsG6VpKcLNik3o/sF4qbBuzggK+E+APTNk+0mPh8/pvK
 JtO8ErNfZR5nhwhqF1DWsW33YLvt83Way8+an9vvieA9Gz20wkT1Wu2GsAm467kI4vr+zWt9q9d
 K9F+wP9H8U/ccJudQUg==
X-Authority-Analysis: v=2.4 cv=XZocX455 c=1 sm=1 tr=0 ts=6af6984c cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=ZTPrOM7BHbsZ8Di_hkkA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDAxOSBTYWx0ZWRfX6K9iwZSP020S
 ednsNpp0g3lpdhs9bFb3XDN2HDpTyf4J17OxehB9RM9ntlUI4XEtstfkQJk4cn5stFZ7pC0Zpeq
 RcOEsE9nBuW2vaIdSYh/tXyWeJkkCLE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 malwarescore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130019

To achieve the deepest CPUSS low power state, which can lead to chip
rail power collapse (CxPC) on SoCs such as Lemans, Monaco and Nord, the CPU
subsystem (CPUSS) and the Safety Island (SAIL) subsystem must be powered
down together in a coordinated sequence. The Safety Island (SAIL) is a
dedicated subsystem responsible for safety-critical monitoring and control
functions, and can operate independently from the main CPU subsystem.

This transition is divided into two stages. First, firmware requests SAIL
power-down through IPC, after which SAIL waits for hardware low power
handshakes from CPUSS. If an interrupt or another condition aborts CPUSS
entry into the deepest low power mode after the IPC request, firmware must
bring SAIL back out of its low power sequence before any CPU can resume
execution in the OS. This recovery can take a second or more.

Selecting this state during opportunistic CPU idle can therefore cause
substantial wakeup delays and repeatedly interrupt SAIL operation whenever
the CPUs become idle. SAIL must remain operational during normal system
activity, so this coordinated power-down state should be reserved for
system-wide suspend such as suspend-to-idle. Shallower domain states
remain available for regular CPU and cluster idle power management.

This restriction concerns when SAIL may stop its work, in addition to the
transition latency. Idle-state latency and residency values alone do not
express that requirement. System suspend does not eliminate interrupts or
aborted entry, but provides the context in which coordinated SAIL
power-down is appropriate.

All domain idle states described in devicetree are currently considered
during the regular idle path. This limits which states can be described in
devicetree. Due to hardware constraints, some domain idle states are only
applicable to system-wide suspend, including suspend-to-idle (s2idle).

To allow these states to be described in DT and used only during system
suspend, this series adds a boolean system-state property to domain idle
state bindings and a corresponding system_state boolean in genpd. The
genpd governors skip these states during normal operation. The system
suspend selection path remains unchanged, allowing these states during
suspend while retaining the existing wakeup latency checks for s2idle.

This series applies to cluster idle states with the "domain-idle-state"
compatible string managed by genpd and its governors, but can be extended
to CPU idle states with the "arm,idle-state" compatible string if the same
restriction is needed for CPUidle states too.

Signed-off-by: Maulik Shah <maulik.shah@oss.qualcomm.com>
---
Changes in v2:
- Explain why the state is limited to the four-PMIC Monaco EVK and is
  not supported on the two-PMIC Monaco AC EVK.
- Push binding example and DT latencie/residency to the realistic values
- Use lowercase hex for the PSCI suspend parameter.
- Link to v1: https://patch.msgid.link/20261005-s2idle_state-v1-0-3c402c66f388@oss.qualcomm.com

To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Ulf Hansson <ulfh@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konradybcio@kernel.org>
To: Abel Vesa <abelvesa@kernel.org>
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org

---
Maulik Shah (3):
      dt-bindings: power: domain-idle-state: Add system-state
      pmdomain: Add support for system-suspend-only states
      arm64: dts: qcom: monaco-evk: Add suspend-only power collapse state

 .../devicetree/bindings/power/domain-idle-state.yaml    | 14 ++++++++++++++
 arch/arm64/boot/dts/qcom/monaco-evk.dts                 | 17 +++++++++++++++++
 drivers/pmdomain/core.c                                 |  2 ++
 drivers/pmdomain/governor.c                             |  6 ++++++
 include/linux/pm_domain.h                               |  1 +
 5 files changed, 40 insertions(+)
---
base-commit: aaa2f954c21b205a0bcd0961e5b2be4e82e58455
change-id: 20261001-s2idle_state-6484bbbf48fb

Best regards,
--  
Maulik Shah <maulik.shah@oss.qualcomm.com>

