Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB014B8273
	for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 09:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792402780; cv=none; b=HffkSSvH6un/Z5DMeAOetL2HvFhzw7N47oW9vAQjWhRyDYww+IQhJjzOS+UUKvYH5HT52gpnty3LbDzAaYIpdIhlUFc0JgVDVypZeXUyUL7Jq3mdHrpt+D0dCWFVyorTM/9Wu1oPLXzNIpr/g+FEd0A04vcATMk8qwgTBdNqxdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792402780; c=relaxed/simple;
	bh=sAQjUxIjl8nvqblAqmHcPV7IsLhvqooON8HdUtzV9R4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fzna7SfO1SvKrdnDO0TILK+JBbD13afbjdigGT7DvsJ9Co06wWBGOjn97WKOTyfZmuPb/G3KLp64n0F8fF5Y/iFed/OLR6reT/gQd2sr1SfryCcQ/cu7Ld8aiY4IOW0QA+gTstbU55+JeSwX9wDSC1hsXrSGTwr8cfawTyHuio8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=B6c/Jr05; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ks8nCdRf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="B6c/Jr05";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ks8nCdRf"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69J8PCnT2193383
	for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 09:39:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=I+/LBRpEdI3
	GB5BT5qug2KBLpEPGdwxDFcSS+HFEn/Q=; b=B6c/Jr05z8UMPcAvpBGqFdob+a0
	aXhDXNejbcyyjTZiFKkiUIIwhIeFPqdSRIn4obWoxd31TMj1z6M1MTg7HFpgDYTV
	XIfGUhPtezrNoOlDDdvVyPYvhxpj4ACK4GdOYF1NaA2xgxRUy7+SP6ptcDgw+nM7
	/e64XAclVdbCuXySUfcxsXNKR3WynMLX0VGgk0rGNN2OSlStYEclWFc27uZ9VfXJ
	rCfKDNwbpYI9pjnT9rFk47rvkShmb2LWsE+qmYVmXkJCzuxl1TJkFrbdpmj/DdMW
	jcr9kLigzGZfqPfF5xCOQm62VpOVpdk4088kx8jeO5iH7c0t9vbtFPY/Isg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hd5w1a35n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 09:39:36 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3ac882b3e28so501249a91.3
        for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 02:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792402775; x=1793007575; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=I+/LBRpEdI3GB5BT5qug2KBLpEPGdwxDFcSS+HFEn/Q=;
        b=Ks8nCdRfqhyoHcq2FqO3i1rmXZVzsoEzCQSZrcJhgXOWwoaQBg/AKiM7MASBa4WuEW
         RoE8Ktns5+tZz9aPxucm/eoXS3jLkHp31zCYn/iyy80Hrzf6cxOHL2dLFOq/YYG8dIXp
         pE0uNF75jqE41HaMUtsDp7M267+xFEJ4/dVXKm7W1nuLrFoj6FDjkqkcSbP2j44oIv0V
         QKnWzc6hFSH4hHVNW2EHUnU5jLzZJKUselDsEdogAtD0yQgeMoE0ZHnQWQAwyP1Nwseg
         HZYpuaCA5aH4MhuSCnuSpqLkL6hzhKE5kCyaADf9zksCgDBMv2Bmjex4QR9rY345QVLW
         15JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792402775; x=1793007575;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=I+/LBRpEdI3GB5BT5qug2KBLpEPGdwxDFcSS+HFEn/Q=;
        b=WK1tTtqnetrR4hDqlsVlYd4HuOnWSl15QDB9sVOGziiBvvfA/9hOQOIuqm1Ap6GOX8
         NJPEr/frFldi7YYdmlUdxqYbUvv5r0Ec+DD7mom+q7YYZRGV/M2jOaUo+vPy7upIAF3l
         DgNWMOF2/tw/YuuFK5pjhBWyNh3825FC99PtrWtOM8+vDSLm0zmoJRouPOkg0omqt9XX
         kM1OdRaf3HPqmCOQYSOomnhNq2C3B2UH1bGd8fE8QeSA59d47Ucim8/8xGG8/hen80KW
         kHvpNUgd5UG9jv81s/mFA04fQN/a3cNCVF3nEricWzw3iyT75Cnd9Muc+1U3F2tCLZD7
         voRw==
X-Forwarded-Encrypted: i=1; AKwUvBzEXfR/CO+V+CRYWdzcDUA4iNuEh57dRd/1n2ioCXZMQZ7LtRMk5N8r7dIwPIo+az09qmA19iNktA==@vger.kernel.org
X-Gm-Message-State: AFq9FYLdBnceVXyEv65j8+cbKqQm9TWDkmT2BPFnXwdjbyHuvZmQ9H8X
	PvoY3bpvTfpbHyFttNdIXA3H+VVCSZexiw6TfocgBrnqv7koq5DQzwjC4et+e9CBi39KYqvfKC4
	i53P+otL0V+L83o27ZfMmjMU5n5Dl8A/E8KPMRx985NPSxgrKTo9BLjyoa7/jwA==
X-Gm-Gg: AYBFou01xhcRb35xvVhrDN+3ItKLCGOohilIhGcXGhRaEmcCFdqoTKzFlPGIPtkvCTP
	xS2oVdrHCWvhRtC0eWg+App6r/5TQp2cft9YSgQMv2lYtE3EZOhRO+sN+jbqaWFULT6cZ08NJv/
	zdUT8lq5blaCcnchOGemcxfXTuvyQ7lBz9xoFwXEB+OAIBhnwJMUWzfe1PIO2HLOeM6YZRk0s/h
	P0UrB+aaTL3T+eE3YZANRnYWInnrY4O9u6OyFFTtv+OrcCLZTFAMhlAHf7e2eJRSfQlaNbbLWnq
	D7V7lmH+esfKdUdmoXGEoj2Jt2YJ4ScNg7YV+Bz5qAInUvIbFi+hLf6W0svCBO1qyfibmaqWE+R
	332lrzyvv20NC/BrPjGeVzGjHYVN3
X-Received: by 2002:a17:90b:4c8d:b0:3a4:9d98:f980 with SMTP id 98e67ed59e1d1-3acee2a1df9mr10692193a91.1.1792402775407;
        Mon, 19 Oct 2026 02:39:35 -0700 (PDT)
X-Received: by 2002:a17:90b:4c8d:b0:3a4:9d98:f980 with SMTP id 98e67ed59e1d1-3acee2a1df9mr10692173a91.1.1792402774928;
        Mon, 19 Oct 2026 02:39:34 -0700 (PDT)
Received: from sdciot-sh07-lnx.qualcomm.com ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac94627250sm19758688a91.8.2026.10.19.02.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 02:39:34 -0700 (PDT)
From: Linghui Wu <linghui.wu@oss.qualcomm.com>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@gmail.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linghui Wu <linghui.wu@oss.qualcomm.com>
Subject: [PATCH v3 3/3] arm64: dts: qcom: shikra: enable WCN SW_CTRL
Date: Mon, 19 Oct 2026 17:39:11 +0800
Message-ID: <20261019093911.3199891-4-linghui.wu@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019093911.3199891-1-linghui.wu@oss.qualcomm.com>
References: <20261014121910.1509541-1-linghui.wu@oss.qualcomm.com>
 <20261019093911.3199891-1-linghui.wu@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDAzOCBTYWx0ZWRfXzSPGlQedYjmM
 pWT13YuKQqZpg4xHnS8HJVqs5fge6Du/xCos0md9ZQt055i/2jxdzm8hbNZX47kX9mf6Oy06VbZ
 uNrrw7TQIYO7N5CP3OXljkfvqLelwCQ=
X-Authority-Analysis: v=2.4 cv=KuPYSmWN c=1 sm=1 tr=0 ts=6ad5e558 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=GJxj0BfhqkdqIuq2HFIA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDAzOCBTYWx0ZWRfX7csVkurelFTF
 aXZ4w3Hdbdz+wCxZ/XjHvF6hdHscNZdKbqXkV2gr1kiU9yvfc011+UvaylNYwtW9hMZuomOszch
 DVF0bagTfrlmO3fNWFSn1zExEqxApGEKtrTFKRkBAyzm8phDz9w1OFKuXj1F3ISgTBFTTi1TSTK
 AhZE/xx/yXa9fN9MBm8cMQ/Kqb6xR5I6DL+vSeE+sYT+L/8uLJ6gA+UkEkhe6zX9Ji1szpOddnZ
 0NEIuw5DbKWIA3SNh+NNSzzajzF4KiK6Q9J+VMJITmRSBF7HtpLYoNY3c3QJtCOl/YSxpPLepXT
 49uGUFS4mT2SE5tzaKlqdGmv6QI7LNIOh4iNRhAy8CXbnd26qOmJ1soKwfyxXkA+c2Aw7uJgcg5
 fP6JwifaLIeMi2yZwz7lFIii6qo4yRUs1wmV9wnao9Fl1YCRnzvTg+XyIf4cKpORkrM6SvtTQvP
 hDQuflQ4jNjQSDM3x/Q==
X-Proofpoint-ORIG-GUID: bxIIjWPAvLCAvD-EITfx6FhtCDwrRuuM
X-Proofpoint-GUID: bxIIjWPAvLCAvD-EITfx6FhtCDwrRuuM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190038

The WCN3988 SW_CTRL signal can wake the application processor on the
Shikra CQM, CQS and IQS EVKs.

Mark the WCN power sequencer as a wakeup source so the driver uses the
existing SW_CTRL GPIO as a dedicated wake IRQ.

Signed-off-by: Linghui Wu <linghui.wu@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/shikra-cqm-som.dtsi | 1 +
 arch/arm64/boot/dts/qcom/shikra-iqs-som.dtsi | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/shikra-cqm-som.dtsi b/arch/arm64/boot/dts/qcom/shikra-cqm-som.dtsi
index 95eb7255fb22..c7b894b6126c 100644
--- a/arch/arm64/boot/dts/qcom/shikra-cqm-som.dtsi
+++ b/arch/arm64/boot/dts/qcom/shikra-cqm-som.dtsi
@@ -102,6 +102,7 @@ wcn3988-pmu {
 		pinctrl-names = "default";
 
 		swctrl-gpios = <&tlmm 88 GPIO_ACTIVE_HIGH>;
+		wakeup-source;
 
 		vddio-supply = <&pm4125_l7>;
 		vddxo-supply = <&pm4125_l13>;
diff --git a/arch/arm64/boot/dts/qcom/shikra-iqs-som.dtsi b/arch/arm64/boot/dts/qcom/shikra-iqs-som.dtsi
index ebc3052d57a9..5edcabd9dae1 100644
--- a/arch/arm64/boot/dts/qcom/shikra-iqs-som.dtsi
+++ b/arch/arm64/boot/dts/qcom/shikra-iqs-som.dtsi
@@ -85,6 +85,7 @@ wcn3988-pmu {
 		pinctrl-names = "default";
 
 		swctrl-gpios = <&tlmm 88 GPIO_ACTIVE_HIGH>;
+		wakeup-source;
 
 		vddio-supply = <&pm8150_s4>;
 		vddxo-supply = <&pm8150_l12>;
-- 
2.43.0
