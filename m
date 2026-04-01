Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3D53CF66A
	for <linux-pm@vger.kernel.org>; Wed,  1 Apr 2026 09:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775034941; cv=none; b=iZ25aCIcadz5YcweaY2G3lLNTehIXJPiALNGN2esQdGr+D1JA9SNb1icMHPhq8VbVsoXm7IvNispWl2XKZRRw5t6TDOYICUIrDjVW8IFRTU8E3C8ZdppoZXier5nexgtJdb3bxZyTLO2L8zRwvp+PYq9p2qQTIqMthpzwCbngIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775034941; c=relaxed/simple;
	bh=88dvcps1dv2WXNE+TIBwTsSm01dkH2Ji1OH6My5vMKY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=J5XqnwsLLhFRj2bz0FwnmE5ePjUeB/OcRBg291oisoHSaYyvL0cj8goSMQepFG4l+kWFIPl2v+gnyqeYDpav89veAb9l5p0YxBFTiYZpEQQ73kN9cgLR0+njziOAl88+4Wxst3lMWmmyvNp0cKEEmBbKwZX+HdmYrhx34LQfl2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Eye0V7bv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=U9J66q48; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Eye0V7bv";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="U9J66q48"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6317F25o4107118
	for <linux-pm@vger.kernel.org>; Wed, 1 Apr 2026 09:15:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=23oAQOYzkD0eXYAJPVUK8k
	5oiGtDoTeViqweGnAixQ8=; b=Eye0V7bvN2hi1m7czpS+vMwOyIWUTSJoq9PwFM
	TwwQ9phl8kzBPFZ5BLSWtabbpWWzmo0taNzcEoiqgNTIB10H2j/YUpCyDH3ohLxO
	hAC20VlS9o8nVZrXJv1Wz7kMpGPaUE+gMNXQ2NmGCtayZ/g4XPL+asfAFbsqBb/s
	mx1+06rikr4llLfyKvPfvwyiv+KkIPk2qc0C1KbTQjjLj1EE7tAlXvmZpi149qdG
	1J9HQ1l+DwhVeqrq8WTqnAlBJvYOz0eTd3pMGDvc64R3SZ31IukQ1JyflFR+wsf+
	Y9y+a5A8Mbc4/rae4znIS3jBXwQR4jQDUuQOb6wp6JJYqa8g==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d8xt90g5s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 01 Apr 2026 09:15:39 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-128ba70cc99so5349452c88.0
        for <linux-pm@vger.kernel.org>; Wed, 01 Apr 2026 02:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775034939; x=1775639739; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=23oAQOYzkD0eXYAJPVUK8k5oiGtDoTeViqweGnAixQ8=;
        b=U9J66q48mKprDzcvy6asyZeuZCATlEbxU9t1SIT1wpr6A6GYnmCFY3zzXblEVSxS/X
         371m5i6WI7p9FpD7Tbm18HOAvKbqsFou0B7GOYxrt6d9UWeN47IkhB0lNCVqC/KsBU1N
         +X7T2amvtkM3O1xHHR8Xlh5mXxl4AY25ajPue8gNribDaP1NldZOPnmq98x7d88bPvRw
         b8efK9xN7iyCEFSloPdfCxeOuui9zQWWGZXBggEXzUGxlNlnQLkYozwa4DwYItLD7N/g
         dKeGVFvKU2jUJyoG3hn5JYfp3J7dl/Rk/gvMKTw1Szx+wXRBxcwI0YXnGoC0HbsCjDLx
         SJwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775034939; x=1775639739;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=23oAQOYzkD0eXYAJPVUK8k5oiGtDoTeViqweGnAixQ8=;
        b=Wljs0I5yDdxySKpwfDD5yeLpC1dVEB0o3h+v7qcC6BjIrKfWwtX6VOhTbkG9KFKaHY
         Puj0RlLWYokq3lVNEDDBv8Ep1QaNF8ds8oAkJD7BDnb3RWQ4EFrBxcb+guuLGqiE5eGx
         trO5Y4gUTwoQMuFrqJ9kK7q9qOSGOpAJvu6txXHQLm0R96tGiAf1S7dYfERixQbelXPa
         0sD2frkYHz7K4AtAc+T8EeJmtB08UY8MRjrYvjZF0ue2+N2NHd3wWq/cEE2FpvJU9PTF
         sEdX8IflEeenpu1pvHIvgCYuLyJNBe5hyTPFUKA7f0qlG4adyGEFD1OBfBkMIOdnVZO2
         D6vQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6LbO1F7AhcQg4D0Nm/874UKGV4DKQbgLvZqIVifBIXwz9SoHItazRXWfbY6olc7bEsHl/JyN+Nw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxBzi/1GASmWEdP98wAIMl0ryKGEttNBYDU3TrPg98LIv5wE80h
	SZdnfh3pLHyHgr4aAejsPKkhm8PfEP3OK9esx4HgHDPdl5VoKf7kLgT/fgbOxT9IgCpnm0e6z5F
	t/V2ccinooeiaWZBfAqCVOTBOS06yJb+h+53p0ZVyrVOXvWSQPwHFBsja9OUWCw==
X-Gm-Gg: ATEYQzwFsgADOfC220b+z7xooJ1J1Go1Gw4lxzlWmF+Uf/GQvxvGjdqI2VjnoBzV66O
	g1LkhWqta8VMK12VlHEFij6gyCE7BsI0xB4Frf0p/iS8lRYM4FMh9TkLT5nNRZ8r+iSwGh5FV37
	1RJ/1DaGjSolEY+kJhwQoWYwBeUUrDfpQRngMSbJfk7WtF1qOe+LkjxqkzjRyITzbbpf+FjZAb7
	hQD7rA2XaYAc5NsASJGMsrfMmQ7J8zw8yZIfmVT9d2SiOLj0xS+h/aWqSG044XbXa5+WbDjrZ8w
	dTyMNSZTV/54rJFfft7p1cjoPXOqOdb6nGdaRfQBb6hneRxKJqx+KiMTUCjoNrn4aDr1l67wv+A
	E112AHXqgnPcR+U+dFZkWkpUa0tPSaWSpjWkzOTPY1m4EUg93I94FoLQtwLDw6YCtc48OizsZpA
	==
X-Received: by 2002:a05:7022:609d:b0:12a:6c19:d222 with SMTP id a92af1059eb24-12be65844acmr1420606c88.37.1775034938518;
        Wed, 01 Apr 2026 02:15:38 -0700 (PDT)
X-Received: by 2002:a05:7022:609d:b0:12a:6c19:d222 with SMTP id a92af1059eb24-12be65844acmr1420565c88.37.1775034937585;
        Wed, 01 Apr 2026 02:15:37 -0700 (PDT)
Received: from hu-fenglinw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12ab97efb42sm18285025c88.7.2026.04.01.02.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 02:15:37 -0700 (PDT)
From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
Subject: [PATCH 0/3] power: qcom,rpmpd: add RPMh power doamins support for
 Hawi SoC
Date: Wed, 01 Apr 2026 02:15:28 -0700
Message-Id: <20260401-haw-rpmhpd-v1-0-c830c79ed8f9@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADDizGkC/yXMSwqAIBRA0a3EGyfYh35biQamr3xBJdoPwr1nN
 TyDe29waAkdNNENFg9ytC4BSRyB1GIZkZEKhpSnBc95wrQ4mTWzNor1ORdFJTKJZQ0hMBYHur5
 Z2/12ez+h3N4DeP8ARAocyW4AAAA=
X-Change-ID: 20260401-haw-rpmhpd-b40a68a3ce79
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Subbaraman Narayanamurthy <subbaraman.narayanamurthy@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        kernel@oss.qualcomm.com, Fenglin Wu <fenglin.wu@oss.qualcomm.com>
X-Mailer: b4 0.16-dev-17187
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775034936; l=848;
 i=fenglin.wu@oss.qualcomm.com; s=20260324; h=from:subject:message-id;
 bh=88dvcps1dv2WXNE+TIBwTsSm01dkH2Ji1OH6My5vMKY=;
 b=9+MNExvCnXk74J/zr3GV3FoGi7mn/Ee0Y4xIYHx2sYmYW0eiBPsh11qwh2hGCwneLPUa1rN1/
 MW1X8GbOrZEC2zatlfigBX4Ow2vkCsngcTxtxGAgHSJsurg55UiNqmX
X-Developer-Key: i=fenglin.wu@oss.qualcomm.com; a=ed25519;
 pk=hJdt3E7o54lql+miD2GaxwF74cDyhgNwMbmFOZ46bRU=
X-Proofpoint-GUID: upGNfeDhhL_VoPLW4oim-cMPCtSKspJa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDA4MSBTYWx0ZWRfX1D7nuKEdRuZY
 /2xNX1AhKSiNB7n8RWs3NsLLuM498OGH0prZ0vpPx3jycQcP2htNT2eliqRg81EgMPAhn4FL2Pg
 cAl/GexvpgAs6j7WddTYYxh2AXeMIlHxZO83VUb4qYnILcBBdwSXeNPDf7c+MJBFnAxoe1eoyWB
 p/ymabwUaD5rYoZPsXgXUGtGFOyoy2dUSy44qvnpr/wxwSeeaE6+WOjBhrK6aLXK61FiL3moEuw
 SLg1KiewiCNigLny2XhKI/wuU+JfM+f8y9VCsg0CS75+mpqHF5YXorVvM+tieH9x3DmUVk+5qn3
 6V7CmvW31fF4dwgeP7b6Shkxg4v3irSymhhwyIRixjtoT4AHjUUW74NHOPhpkRLsdThRu2uLS17
 KhlWQDf4wck4Avhy++cZlDMrzxvL20I91L5ESg/463EOU0tI8eH3EaRO/7k5bZQra939YU1CIw4
 QdAGmmfaXOV6lLR49Jg==
X-Proofpoint-ORIG-GUID: upGNfeDhhL_VoPLW4oim-cMPCtSKspJa
X-Authority-Analysis: v=2.4 cv=PoGergM3 c=1 sm=1 tr=0 ts=69cce23b cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=3hnM6S6pKqKzLZp0A1cA:9 a=QEXdDO2ut3YA:10
 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_02,2026-04-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 suspectscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 malwarescore=0 clxscore=1011 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604010081

Add constant definitions for the new power domains and new voltage
levels present in Hawi SoC. Also add RPMH power domain support for
Hawi SoC.

Signed-off-by: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
---
Fenglin Wu (3):
      dt-bindings: power: qcom,rpmpd: Add Hawi RPMh power domain
      dt-bindings: power: qcom,rpmhpd: Add new power domains and new levels
      pmdomain: qcom: rpmhpd: Add power domains for Hawi SoC

 .../devicetree/bindings/power/qcom,rpmpd.yaml      |  1 +
 drivers/pmdomain/qcom/rpmhpd.c                     | 38 ++++++++++++++++++++++
 include/dt-bindings/power/qcom,rpmhpd.h            | 12 +++++++
 3 files changed, 51 insertions(+)
---
base-commit: 33b1a2ee3a3df63e7a08e51e6de2b2d28ddf257f
change-id: 20260401-haw-rpmhpd-b40a68a3ce79

Best regards,
--  
Fenglin Wu <fenglin.wu@oss.qualcomm.com>

