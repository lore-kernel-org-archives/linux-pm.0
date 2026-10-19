Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50D849B44D
	for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 09:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792402764; cv=none; b=A0OV/TN4D56lk3/mooMYFu9euEiuiMU685ZCubp5xgvpPBvf+EhFdUT4AirOvLu6NCFMO4woJgjXvgZcGSowvVydb7rOZhdlfakPR4kbaGqtZwU6nSDQseXj2bsfl3DpF+VSOS/9pDm0k6B1GSPgEJxoK+nuQAKsHgSTpIl+tcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792402764; c=relaxed/simple;
	bh=I8YGh9EA8mdehfClcMuTGb+WumIem5wJNu4LocA+N6I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W/+YTqWxlOwtLNcSerwOlLiuynxRWrtHZBeHzVNQ2tY7ZPvhKsATX8B1DX0KZ0TLbbvYELew9RnBVwDiZQL2bIInEZ5KQQLTNMUWwZaeedrBQojmLVdNjNQwRZlJ61Nunxkg30iwEX96yhyqByFXaymgrvKkf+L2z8VtIXninJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MI6X8foJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KNmWyb+8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MI6X8foJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KNmWyb+8"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69J8Osov1665658
	for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 09:39:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=CO3dX4XR59N
	PcnLzqS3CmOLDW6/A7dkcb3QefX/Y1d0=; b=MI6X8foJacqsgxr0c8hfBZac+k0
	QfIKw9uM9H5zC3HL/UvwEjJw9OguFljPHmYJKF9A4ys8/Pt26Fa/WGV40BHyUwCd
	1ikXa/VjhyBrskVuw9GWjQoHKynD/B8M0wNxcDs6Po3d+UCt0UU2R7VcDqAzyeVI
	B0Wce8EPB0dTPtxyAYNcpgj+RbQ5zPVkHxoBHOYEQ1cynzOFQbl2MgdCTirbpVbv
	baU7dYsToVebNdpw0rEGvgTEp/eMjUSTs82uYqdj1N6zc2XH1U0ehr5jVFWhgeyl
	SbgPb5zuLdgnsriI1mPsiBCazojUlSU3H0jf/H9a2om1dm7GE4PS2Woi8Mg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf3n0dwr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 09:39:22 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3ac4b53979dso801483a91.1
        for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 02:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792402762; x=1793007562; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CO3dX4XR59NPcnLzqS3CmOLDW6/A7dkcb3QefX/Y1d0=;
        b=KNmWyb+8XTShSwjTP7oyitHrKlXIcsRc9mkhtMbtFnitbdfKMtY8sioPyPvO5gaABe
         lKH665poOhJtMTMqZUfqSZZWUdHtl7/zhJz/wM5Ovi34Xyv5MPsK1JTHul13wdxndLVb
         mB9oaZSb5zwPJqx5N4IS/2OKiOSQc53k48Sqz4NmwQMOW2UOIxJLrcPdIwRW9maRxar9
         lyebhITpr8fQn7PVWnKKXdWyP01GngWsELbAK+cuR9aOlPUDSkajM4+m1MN8WFT7arS/
         uFsOVYyfcOuJZefnbJcBf3/8ckwqA/D+UbTUSjAleG+36AhpeWEf98XhC9a6GmHyc3H9
         RxLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792402762; x=1793007562;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CO3dX4XR59NPcnLzqS3CmOLDW6/A7dkcb3QefX/Y1d0=;
        b=Y9LttA41NTfyjpFlzXWRYlGIcYO+n1g7mvNAJlLeCADzXUfd82Y0VXLcUXjEKd0YoV
         UsDTvPxHlNFOcJryA/mUrCBXE6qAtFGhVEsehLyhD1WiZhAKRCcZ8Ys5awSk4a/n3iJn
         bIVlY45pbDyIBc+onI27nr99sHoNYWI5637kZvmXT4djBQm/gT3KrIMMkFJQKqAP0GmA
         dyHw0DCi2hRLbW7LK6QJxRVytn+zlfqZywpVTeWKWlP8IPI1Ges6Z3su05ZpERWuLXIf
         2XZinV/b3SC834dVZWTVkqNE//vvYOrze5f0tuUMRkYMR3Bytjzg9bRnVs1FfAl9KAk4
         Xl+g==
X-Forwarded-Encrypted: i=1; AKwUvBwF77HrzLdxhBjl5W3AFU62Vn5oIJOAB0ZajBlbQobk4YF1wVNNXCG76TXaJ/KbB8w/5qzGao3DZg==@vger.kernel.org
X-Gm-Message-State: AFq9FYKan18ZpeDPgZIRaU6OxvcN/QveMFIzsGzyq8AZEG0qiPoQ3bsj
	AtwuAQS8O5gQss7ZF+t3W0ERHSzFi2wcYTwpH5LNhZRUPJj/P3f60FyLmqGn4yxp20U/7xr2dET
	h7GZpOnIZPC7rn+7NB1nh8rCAl2JlIfyXeOw2IfPdTPbTlXYPSkz/TA+GSy6NHsQwtt0EwQ==
X-Gm-Gg: AYBFou0Olqn0Ej1fj4elYU/obeLKJNel9wScBCvRBvJzul6S4RdkCwvdP3kU04dEq1l
	4WeJc2U+TM8jE8cIA5AEAr7kYcLjgL4qKQTFoodrztuPuX4NrOT4yyDkoAR9Yp8fmh838mivLR/
	hTxQUSakbExPHqWvahSWkFYRc1+A1ercD1xbIyoaEYBoQHmOoDAmJY9o3yXHyJOEIz6Po8P65uJ
	Fkuwzu83SYTX/e8mEiOjO/RetG74BYrmQFoXlGFnXRmyrimRao3CE9LMzBpB8O8Bl4hXSs/NaXx
	8mlcIDqc6bA4oGV74ZpX+9uDM1rW8DFVa1pTSwEuie1fzqgjYUQp64FV9lsUKIYv59dswh3TZby
	pM1bORpFKoevTkMSPtOag45Wg8P8P
X-Received: by 2002:a17:90b:1a87:b0:3a6:e1d1:e511 with SMTP id 98e67ed59e1d1-3aceec3d0c4mr10747917a91.4.1792402762275;
        Mon, 19 Oct 2026 02:39:22 -0700 (PDT)
X-Received: by 2002:a17:90b:1a87:b0:3a6:e1d1:e511 with SMTP id 98e67ed59e1d1-3aceec3d0c4mr10747882a91.4.1792402761700;
        Mon, 19 Oct 2026 02:39:21 -0700 (PDT)
Received: from sdciot-sh07-lnx.qualcomm.com ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac94627250sm19758688a91.8.2026.10.19.02.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 02:39:21 -0700 (PDT)
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
Subject: [PATCH v3 0/3] power: sequencing: qcom-wcn: support SW_CTRL wake IRQ
Date: Mon, 19 Oct 2026 17:39:08 +0800
Message-ID: <20261019093911.3199891-1-linghui.wu@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014121910.1509541-1-linghui.wu@oss.qualcomm.com>
References: <20261014121910.1509541-1-linghui.wu@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDAzOCBTYWx0ZWRfX2amYSP/xQF4V
 iVDQRtqrWfxOsnuQUWj5vximg4Y2kJpd+Qi2O5NwQRZtAH0zO+QhuefKza34auAVm9lhDlAATG6
 CtviZqCpluzH5uWHDfKqbbkIt9jw6Qo=
X-Proofpoint-ORIG-GUID: 6LzNvEDvmIVFBpHFfRYQFGbFPdlmcx52
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDAzOCBTYWx0ZWRfXyIliuDt4vIEn
 oqs7uiclzM8s961CnT1v6//6HjyREg15SJWLvVDK+IIxefzI6yh9BJdSvKv6BjH7FbfFnp/xCZL
 SUAMm+vRSu3j/q4ESg/b3R23l/cT+jpVe2XT/Z3xMIVbk+SwmyxZF6QOH5GJT5ORPtRL8RLMEat
 34nmnKkXCA+l01wwP+0HTJvR7JMTClwFB9CUUAbpJCQBCDvtYf3HhZhzWOoEnjhI8AxiDcPNR2G
 s2JcXpss/wZCU/4xoKLiWQ9E8GnHuJUGwVwVfskmOmKBNJH1qZd4TMsGsPieTihMUbmgYq6v8Nr
 YqMgYhZRvVbhv0ljFnxF6i3uIcSHma2Cjq+qq1bzmKMhpSl+ngbEIecBJeCINchbO1PqUVMXfrQ
 PV/i0mEopnceMsKC0iFlYqIi6Bmso+gOwKxunPnkELZrbLoXEhheGTHPdN30a8xfgUE9SRbi8Lo
 Clbx2JcRvUoFC+sZN9g==
X-Proofpoint-GUID: 6LzNvEDvmIVFBpHFfRYQFGbFPdlmcx52
X-Authority-Analysis: v=2.4 cv=Zf2IpcVA c=1 sm=1 tr=0 ts=6ad5e54a cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=hnRN73myjJn4I1-c90oA:9
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 phishscore=0 priorityscore=1501 bulkscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190038

Some WCN3990-family devices use the SW_CTRL GPIO to indicate that
resources need to remain available while the application processor is
suspended.

Teach the Qualcomm WCN power-sequencing driver to use the existing
SW_CTRL GPIO as a dedicated wake IRQ when the power sequencer is marked
as a wakeup source. The PM core keeps the IRQ disabled during normal
operation and arms it for system suspend.

The series documents wakeup-source for the WCN PMU binding and enables
it for the Shikra CQM, CQS and IQS EVKs.

The series has been runtime-tested on qcom-next and kernel 6.18.y on
Shikra hardware.

Changes in v2:
- Derive the wake IRQ from the existing SW_CTRL GPIO with gpiod_to_irq().
- Drop the separate interrupt description from the binding and DTS.
- Focus the description on the functional behavior.
- Rebase onto next-20261014.

Changes in v3:
- Use the "dt-bindings: regulator:" prefix for the binding patch.
- Drop the RFC marker.
- Replace the "must" wording in the wake behavior description.
- Report runtime validation on qcom-next and kernel 6.18.y.

Linghui Wu (3):
  dt-bindings: regulator: qcom,wcn3990-pmu: document wakeup-source
  power: sequencing: qcom-wcn: support SW_CTRL wake IRQ
  arm64: dts: qcom: shikra: enable WCN SW_CTRL wakeup

 .../bindings/regulator/qcom,wcn3990-pmu.yaml  |  6 ++++
 arch/arm64/boot/dts/qcom/shikra-cqm-som.dtsi  |  1 +
 arch/arm64/boot/dts/qcom/shikra-iqs-som.dtsi  |  1 +
 drivers/power/sequencing/pwrseq-qcom-wcn.c    | 36 +++++++++++++++++++
 4 files changed, 44 insertions(+)


base-commit: d419d682257d813f6cb7a28e42b35d0edf4ad038
-- 
2.43.0
