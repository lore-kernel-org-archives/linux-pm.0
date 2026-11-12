Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794468023;
	b=M27GwOMUT1t25h01wDU7gh0WGP9h7WBYWeL/uorG1aC1Kp+1b1trGR+v/9kBP11/k/1B
	 4JmwAHCFmS9Z11rQMV4+mXVG47BjGwxWph77LOEl2X1T6K/w8equapIb2n0Xi1iPWePU4
	 rjvLuNiebZR7FYLCJP3fztKxMvV/kPqMr0wNqxC9oDnFTo1Lx2eDqF0ja9cXBtKiHC4LS
	 L5Fh3oti2ZOhbepfjF2k1D6yFZFyqHzfVpBW/OnsytvAzLAhUjLY+aPPzN/7Mter/lXI/
	 n0zPt1BRUfSCd1M1ijUgwHgx6dSsQteIPbrgh6G9TwLlX+gvRol2DphvEuTXm0M8NgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794468023;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=i9jbtsLDZsS4FE9dYCV+4UGl52plCiZyJEyDlwed5Yw=;
	b=ktSYxTnHmSjOQWX0JbDFEwsMvi9aV1pC9u1OYsSjIpbN8XLVwBw+OFDXi2uAoJhvXznV
	 jPERBMwpaftdjV8s7ASnQCKM7VI3PtD/kFmTcFkLKrxr2+//ptnY1uw6rLDt2Eaz/OlJr
	 jO/Q3A2lUaGzDM3UpjqFfmZsB5c44EBiXnRqwvoOCXJ4OWzaWJOHhgV5KZ18HXlL5Sgge
	 lT8+rJc/xlWdk3Xj4vmprAfeYZ809HT/zm5czMkS/P3S8ClIJk3eCrOxFUN2OZ5yk6tKi
	 KXZASD4jyKiRTNpaZ7WE/G06hqFJaotBChxnYLWXKJl7IZC5ufo1UmQKF3S9sr+9zlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=pKCBwgYw;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZwykinUd;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D1C606A339
	for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 07:20:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 04D1C606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=pKCBwgYw;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZwykinUd
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AC2ZQtI4092474
	for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 07:20:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=i9jbtsLDZsS
	4FE9dYCV+4UGl52plCiZyJEyDlwed5Yw=; b=pKCBwgYwBrnc/LxUl1E/mt5JksF
	tdlEVy+2HRxQhIjIY79Z7zmU6XbZp79c1JqTYYCF7IFim/q40yJ3b2+64HrLpS+T
	UQKlNTUsnCx44Kz6rK6zeTM0hVAgT2Jx8kCO1GE6VPbTpnsT/jZuAqZU4PmWc/Ir
	2ql8Voi9P5wr9oXDF/HmNREpFBDzm+yWm/HhS5fpoxaAFTxZcBiPjZlDjXMJ547u
	3XRMh1JK3Z1TbhiQA6zwonZIenU3qIQ1HbgAbbirDaTXcaF6eCiqYhY4sVWe3LSa
	jfCVWHKJojLfdZPlj221wCCfLQuAwdUbXeuGf4JC0AxbStE26VC4TfpQbuQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hw0m8hppy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 07:20:22 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2e9a4052726so3707815ad.0
        for <linux-pm@vger.kernel.org>; Wed, 11 Nov 2026 23:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794468021; x=1795072821; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=i9jbtsLDZsS4FE9dYCV+4UGl52plCiZyJEyDlwed5Yw=;
        b=ZwykinUdbLtRi2qdcSWDBINHpcS6tBsTqcvPJe1gYyoO5ndV2/Rs+vCo5N2is6A4/g
         jWZkr1nzaJj/x/6v52qVAL2ZM7Hgr6llhiOqT72vHbNpnzpIXFMZVGxNxzNahTetNS7N
         8wJZx4qm6bSqoL+U7mxrHgl7F9WO+dOMobv+pl5JhAElydLDBp3N/xjQwi07MRvkFX9I
         LRgMlacLt2SPCofncLeWcdzTBEOQs2wSUHHiorSa0KKM2vK6iIGX6uLZkUsUYm/gZH4e
         0zj3UZgLS8AFDidSh1YaD0u8BH7pcyGbDDrJ9J7XZ935uortET3JZ4Jj6xEfR78pel82
         uaRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794468021; x=1795072821;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=i9jbtsLDZsS4FE9dYCV+4UGl52plCiZyJEyDlwed5Yw=;
        b=hvarznSUAanQCqb6qT4IAP1ksnFBPQGpL6f5yL4/GCQDTv/5W+VzG6Xah0CH7OeHeS
         5XSh4caeuRbO5FItqoIhlMYyB/KIltEjlZJPi0X/Rtc/8H1pN+GpJ1HxGXkONngR0c7Y
         LypqrOX0G9feAyp2AQL72340Kh4c5qqUg7HYTx9jjb9fjkOymWD03VI+Z9jZ/2OdNqOG
         NaiHYI2+CwVmETNDFfHqtph4+ilf2WOsz/GFtn8ClBKYUj2AtkAW18GbKsDzQmlzEram
         +Q4EkkP5aTX256/+nST4J8hjBX5esapo8VEJjPQUUFCR+mhOlNj8txjIIV0k4oLrGKtS
         OelA==
X-Forwarded-Encrypted: i=1; AL+hErEL0ngHAKMFcypl/qZFCzuI9H8hqvn1gij3njAgcpOk9JADiDo+78HZcsgCXfH5pjrsbf3jfx0iKg==@vger.kernel.org
X-Gm-Message-State: APuU4Z/cXRFiDYzqtElWFyzkggDDUY6+m1A0vTj77oJmitlY/aH61fI3
	IfFYK9rpIkoYyaITGAkjCEgs9FIYVjSM3/zCwztUSfboaxyWamGWM4VFms4B6/E2jj8f5Gm1TcH
	9KHipacjkJQxt9/yOt4kbOavB0BrygURawZMOf/Dm5298OfVINxQ1ycWEgh88UA==
X-Gm-Gg: AYBFou2Dyo2CuOXv9qzG86fKmdLL0i+X8ugO1zhybnbDQrrP/eOmSPnHiOMfGfc+6YQ
	RKXMmD/V+lq1K/xgeAkHDICCzLHdKGeuDHFYVvLqxkf0HblQ6orNpUVpPmjD4J9EMAJ8arRMQ+J
	AkBH91qLxHV32Feb2QQfxy/Ypie33XjGhUNB65HlHMU/iVWcqOLxZfnbnPEJfgUVrTB/ah+yrEL
	Je9aAxwi6gIRK9JdrUHOyumJVH93jwzBJ+jkRaYSuZ4LPfIY0EvTXPmkmJLUZ6IprWSN2e0ZZ96
	0aKZHURcjb0/5he06CnvZthgzApsmwEUHYBxVV/T3BGBdExec215BuYe/vy/Qy2KGnBgzEN7bux
	ROyiFV3LlydXkxEH8WLrGTkgmxOS8oxsAnxN+mQxXmwYOuCxs5vggydEQPqJpjAGlFrsIcseJ5i
	KjcA==
X-Received: by 2002:a17:90b:4b0e:b0:3ab:be66:ddc5 with SMTP id 98e67ed59e1d1-3b182f3642cmr7324454a91.6.1794468021432;
        Wed, 11 Nov 2026 23:20:21 -0800 (PST)
X-Received: by 2002:a17:90b:4b0e:b0:3ab:be66:ddc5 with SMTP id 98e67ed59e1d1-3b182f3642cmr7324412a91.6.1794468020967;
        Wed, 11 Nov 2026 23:20:20 -0800 (PST)
Received: from sdciot-sh07-lnx.qualcomm.com ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197c73e27sm3149185a91.9.2026.11.11.23.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 23:20:20 -0800 (PST)
From: Linghui Wu <linghui.wu@oss.qualcomm.com>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>,
        Hangtian Zhu <hangtian.zhu@oss.qualcomm.com>,
        Shuai Zhang <shuai.zhang@oss.qualcomm.com>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Linghui Wu <linghui.wu@oss.qualcomm.com>
Subject: [PATCH v4 0/3] power: sequencing: qcom-wcn: support SW_CTRL wake IRQ
Date: Thu, 12 Nov 2026 15:20:06 +0800
Message-ID: <20261112072009.3815276-1-linghui.wu@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019093911.3199891-1-linghui.wu@oss.qualcomm.com>
References: <20261019093911.3199891-1-linghui.wu@oss.qualcomm.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDAyOSBTYWx0ZWRfXyR5tQjdQTZy9
 ikTua1EIBHzXPB8FeS9EpQn5SOOm+0HgxVnDpdZBd6TGYbgHoPOH4LdPaKbHv0BSYLfBQ3j6uk8
 n+9z1u4Jv12Addnew9o0ybx2wmvThZ4=
X-Proofpoint-GUID: Y50gi1djnwiYmtgGzIihGE6FxhqhAF0s
X-Proofpoint-ORIG-GUID: Y50gi1djnwiYmtgGzIihGE6FxhqhAF0s
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDAyOSBTYWx0ZWRfX0Q9Cwbirhyfy
 TzhdZ6G25+UJM9Mrly//DAq+7fSJckydoEqq+HyyomXQ+Cc/Na/w32FqavC7v4Ik9HYNg89e0oD
 fwqcsgiNvfMG72Y4/+4KttnQyIZdpPUaXusBFB8LWaF7d09pQyNhkTuYnDcw6XfBzHOBdhOYHcz
 0F8fKytTVJWdYeBmHKoi6J/eYIr8id6uC7csFPVMEoBg9UkhK4T7mVHfoYjTUSzoNdYAFFACcic
 yIEJ2t925Ggy0nrsU01kjZ529G+xEilY56k3ijQbUx6Cy2Gi/QVm6v8WmhPax0P1jruceMH0Q5C
 yEerqL0Zw79WLSSObAM9ArK+vW8dt51yUPOusZFSIGTORbSXe/yBenAxcwK9WGVJeNiO9WiN8dK
 cFk5My/aZjPDbySjMFgnxlmqCsqOp04WuHOcbbSTmfq/DLMzuz/Ty+pfTGyvwRTiU9vpZc0oCIx
 jy2UFvojfOYBbyATVjA==
X-Authority-Analysis: v=2.4 cv=Q9dHcI2a c=1 sm=1 tr=0 ts=6af568b6 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=FZ15NAR4OWdYCF8lCvYA:9
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 impostorscore=0 adultscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 clxscore=1015
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611120029

Some WCN3990-family devices use the SW_CTRL GPIO to indicate that
resources need to remain available while the application processor is
suspended.

Teach the Qualcomm WCN power-sequencing driver to use the existing
SW_CTRL GPIO as a dedicated wake IRQ when the power sequencer is marked
as a wakeup source. The PM core keeps the IRQ disabled during normal
operation and arms it for system suspend.

The series documents wakeup-source for the WCN PMU binding and enables
it for the Shikra CQM, CQS and IQS EVKs.

The series has been validated on linux-next on Shikra hardware.

Changes in v4:
- Rebase onto linux-next next-20261111.
- Revalidate the complete series against linux-next.

Changes in v3:
- Use the "dt-bindings: regulator:" prefix for the binding patch.
- Drop the RFC marker.
- Replace the "must" wording in the wake behavior description.
- Report runtime validation on qcom-next and kernel 6.18.y.

Changes in v2:
- Derive the wake IRQ from the existing SW_CTRL GPIO with gpiod_to_irq().
- Drop the separate interrupt description from the binding and DTS.
- Focus the description on the functional behavior.
- Rebase onto next-20261014.

Linghui Wu (3):
  dt-bindings: regulator: qcom,wcn3990-pmu: document wakeup-source
  power: sequencing: qcom-wcn: support SW_CTRL wake IRQ
  arm64: dts: qcom: shikra: enable WCN SW_CTRL wakeup

 .../bindings/regulator/qcom,wcn3990-pmu.yaml  |  6 ++++
 arch/arm64/boot/dts/qcom/shikra-cqm-som.dtsi  |  1 +
 arch/arm64/boot/dts/qcom/shikra-iqs-som.dtsi  |  1 +
 drivers/power/sequencing/pwrseq-qcom-wcn.c    | 36 +++++++++++++++++++
 4 files changed, 44 insertions(+)


base-commit: aaa2f954c21b205a0bcd0961e5b2be4e82e58455
-- 
2.43.0
