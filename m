Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BC73B4EB3
	for <linux-pm@vger.kernel.org>; Mon,  3 Aug 2026 11:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785756434; cv=none; b=neXLW3d2wGcX1LNwBHZD7itHyOBauj32nIY5Q9k6gKJ6qDK+yn/xs+FSbeFI1S5WbWDc5PLFVNKF9ZvCBeeUmKBj1nyAKWLFqi9x2QYr+goZ6rNHsvuhjvabHTnHyqvUEQJ/9TqBtaT2zCpVCHpD9rdpBKkslaZRP7JUdlhALq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785756434; c=relaxed/simple;
	bh=MAGtAwoZZ9/KBD7dfnxmL/0ZbK1M297G9aRHzJ6B+1Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JM4ORaKc+kqIQJKbRsG60gnRKqmWEsg2Majgwbb95v0cNzGE4PDCYCS/yqDRJZ77hlQocWpjSZOtIxjcvIQQtvTLxbas7cmkpfYaJ63EVFNKf0oYqeCvLiD6G7DOqOYBaRQoxRH0UGviRmIGHkhygptEOlbF/+GLLhFDGo6VPs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ks1fbyx/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Gp6+BtrY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ks1fbyx/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Gp6+BtrY"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 673AYirJ3758610
	for <linux-pm@vger.kernel.org>; Mon, 3 Aug 2026 11:27:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	h0zi8v7YJXcqF3J00o+I1vc21/xnxZ/VIetcLEzZqpQ=; b=ks1fbyx/+dCzNfrE
	wsFmfE6uXVwhx15kn4tODQMaS0V4joN9f/0j4xYSZaQm7iNfxS3rvLahFv7KAMoN
	hZRmZ4TammC/x/fulF7d8PTddUnR5SqWJt2+BJljUu14UuQ1qCAEzC0LwyR+oQLe
	C+3UdKLKMm3axWPSYbdp7c4x8ObRe2cQfzQdbXuFqViXtXPvX7axMJC0c/zn9ION
	dkhKCBbZULAcQVS/fMw4ycAiGULdnpq6UYxj4PR3gaCMFdLzYOe5TEarIQ+pNvrU
	B7FBosvXPi9XKED2pZwGUGQHbV4b9xRZlv6Z1tSaYkJR8yJikcjKTQ5BHV4zA+Aq
	qYSHaw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ftnrns8ex-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 03 Aug 2026 11:27:12 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38e4758ab46so3801277a91.0
        for <linux-pm@vger.kernel.org>; Mon, 03 Aug 2026 04:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785756432; x=1786361232; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h0zi8v7YJXcqF3J00o+I1vc21/xnxZ/VIetcLEzZqpQ=;
        b=Gp6+BtrYA4roI3btDd3k5IW3L5FvKAgvep7keefLhFUA6pIvCWyr/Rn+7bvwS0q/yk
         PaT06f8cu3MCOaIB13rnBJjXKlr9T5e0d2Oo6WrKS7y9tvXgl+/WjT7Br60REN+jva/l
         jtgYZlZgQsBtpwY0LEPn2cQ91tnrB9ZVGV8RPD9SxDmbgwzvBYh2Ujtxi6OQNevoSYul
         9pKxsIu1HLxSyQ6CDRocOC6liBy1XmVT1+kKh1628vy2nMyuNgyhFATztOP13HMbnP8g
         Dbl1NKvb/LcrgkxbVk9rGa+qKKl6PtqvBJfzAwuBV5k0leL212CSOTLWvIq9pVZl6PDZ
         6aXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785756432; x=1786361232;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h0zi8v7YJXcqF3J00o+I1vc21/xnxZ/VIetcLEzZqpQ=;
        b=O2ufScMqSt5GcijDvSEMM8sPUMjRGzXavihy45oIAbisY+QtCCGhlM1frewg75UH80
         4qB+bjSTVX5A7IlNWvWqcuSdJA2GdK0IBaH9hVuruNQPCarW5kkh34EeQvr4iYaQd49b
         L86Pn9jI0iwTGq1d8d06MM78pmRL8Mx3kdbo5odsAtCDnIfY4bCi3BaXny+bdYlfZ/kH
         DPf4Y+lIrCfD7keqzSLtGQJ0ek6jj/+MuiS/cLLTgqCSoIuXnReg1rXIlJnW4DijK2W7
         n5r513zaE7DhZWc4Emh+/8WlVM4SVGdH2Kr2yEW1RNDytMkqll+URAUTpadFlONb2c+H
         gHGQ==
X-Forwarded-Encrypted: i=1; AHgh+RqRPFMwZOpfqnoaWdKbeb9lqVSnXbs2v8tmHwIFiv9jd61u+GVm//pHm5Dkh412eujrIhrkNouCNA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzdCK7wv6divTBtU5yaLo5jt9rpE5o75GCSEtzsOP9NitYdj2x3
	croY6X96nw9BdwQ3X+35n9qV3VloaCkQNa0NSp612IudxxHz/QjlOu0SXgDMHBhYeyBDRB4p7i6
	BPRVhBbaCyIGA2qh7t9RyE8usAuNBPTwr2+cqyv9HZy0IA6YyUh4F6Tz/nyRKWw==
X-Gm-Gg: AR+sD10Vi2DnbMENPL+qruABsygv72qu3n6KAuRI6Ha8usuEjNCW+7eAibDeTHumt2b
	Ty6NoIOqf2wQSZJBvRvCAgrmsjqf658+W99FTrfBXseYbIV+OsFXijWEHGikWjoNe66KLDP/OXG
	Tn5JOxKCfH/6MHAoCwWBMpIOkFSjzaWs8HnkYTD+XOlhVpQJ2Z9tUKOjZE5j2I3YFDqfLB5P1mD
	Z51ywZNNemsmQ99aJ3K3cjq/u5fQGizgf+249XOso4MeLmAVhqFi5faRwAZlgdNhUr5qlrmeLqA
	qQ0yvh2uZMz9W24TtpjIR+S3IAj2EBqOYAuUww1nKhdQDhB5HIc+aZldRI0+MHTRD7t3YWGz6iy
	MiJzjMvc3047rxcY=
X-Received: by 2002:a05:6a21:2983:b0:3c3:9746:1fcb with SMTP id adf61e73a8af0-3c92a9c6876mr8928805637.35.1785756431650;
        Mon, 03 Aug 2026 04:27:11 -0700 (PDT)
X-Received: by 2002:a05:6a21:2983:b0:3c3:9746:1fcb with SMTP id adf61e73a8af0-3c92a9c6876mr8928785637.35.1785756431274;
        Mon, 03 Aug 2026 04:27:11 -0700 (PDT)
Received: from [10.213.101.118] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fab132cc4sm29967043c88.2.2026.08.03.04.27.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 04:27:09 -0700 (PDT)
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Date: Mon, 03 Aug 2026 16:56:33 +0530
Subject: [PATCH RESEND v7 04/10] arm64: dts: qcom: shikra: Add SMP2P nodes
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260803-shikra-dt-m1-v7-4-7fec8e777076@oss.qualcomm.com>
References: <20260803-shikra-dt-m1-v7-0-7fec8e777076@oss.qualcomm.com>
In-Reply-To: <20260803-shikra-dt-m1-v7-0-7fec8e777076@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Komal Bajaj <komal.bajaj@oss.qualcomm.com>,
        Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785756396; l=2339;
 i=komal.bajaj@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=wsUZeqt951ofrDfp9W/f0uYqYOBAK+l5bMH2XcMmkiQ=;
 b=jSzOUUwI/NkoFp0af3SSttmsh2hIXluC6ewwA54KkTKhWrk6BHB93N6gpPzBuF66QNlm6zW1e
 KElyqPbO+lkCiRs7bXlZfip8PI9HyIrGIyV+4btvwzt9m3FyM+jm5h6
X-Developer-Key: i=komal.bajaj@oss.qualcomm.com; a=ed25519;
 pk=wKh8mgDh+ePUZ4IIvpBhQOqf16/KvuQHvSvHK20LXNU=
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDEwMiBTYWx0ZWRfX/8fMs0cIZUel
 DYR3ci5xC37+2PjWfVWlctYSg1NESlEmku2zQSlBp8oA7tNaNVl0kqgd4565meiLR8IxA5TO8Sa
 EslQdIwphiN9x+PX8mIhUACDoAYjP7Q=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDEwMiBTYWx0ZWRfXy6jv/rpPvpFi
 oOCGjgNOLcsGzc1oxuydb3U9nkPhfNSIZo03VwUu+X2oWVqSn3Mv82DyaZb4q6xSv1HVsoTcooA
 AGi87KYsLXCfk4VlsAZ1A4IPJI4rrnPz5T+B/rkg7BpMN7v8RGkvv7+xHGDXe7efYHFzoZT6MgJ
 KZ6mocKY3aslMD5Kan2lZl/0wbr+SlwYvOF9HQqWyYIT2HT/E9wUhhxC4g+tDWMF6i5Q2nB3kca
 IwrYvfo1cMFaEHZFpZbdTQ84uUWaSJqH29YzffZytF46/uszIZNHSzc9PlLPAF29iJy9T5YjVJJ
 McPhdWdw3SuFFyoabUPvAMluSKkbvb3Q0rD6YHIdC0D5XJZK8DmrzZ/B8/Kjt8MOKT/FwOEn+5V
 oP+NiNZRfFNlYoJm0iVtgMtcUDcAc1nc5s5ro0n9gDuYjttXtM/6pZWhozZXyilt4qw8Q1US3Fl
 WqjaFMUSPEuWLHWo48A==
X-Authority-Analysis: v=2.4 cv=Zest8MVA c=1 sm=1 tr=0 ts=6a707b10 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=EkeGX7dVun7IgMBPpHMA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: WsbTdOcdhsEUsdKBvJWJufPO73YCX_j-
X-Proofpoint-ORIG-GUID: WsbTdOcdhsEUsdKBvJWJufPO73YCX_j-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_06,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030102

From: Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>

Add SMP2P nodes for the cdsp, modem and lmcu subsystems to enable
inter-processor signalling for remoteproc state management.

Signed-off-by: Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/shikra.dtsi | 69 ++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/shikra.dtsi b/arch/arm64/boot/dts/qcom/shikra.dtsi
index a01e26d9ee6d..42a17ffc040f 100644
--- a/arch/arm64/boot/dts/qcom/shikra.dtsi
+++ b/arch/arm64/boot/dts/qcom/shikra.dtsi
@@ -428,6 +428,75 @@ lmcu_dtb_mem: lmcu-dtb@b4702000 {
 		};
 	};
 
+	smp2p-cdsp {
+		compatible = "qcom,smp2p";
+		qcom,smem = <94>, <432>;
+
+		interrupts = <GIC_SPI 263 IRQ_TYPE_EDGE_RISING 0>;
+
+		mboxes = <&apcs_glb 6>;
+
+		qcom,local-pid = <0>;
+		qcom,remote-pid = <5>;
+
+		cdsp_smp2p_out: master-kernel {
+			qcom,entry-name = "master-kernel";
+			#qcom,smem-state-cells = <1>;
+		};
+
+		cdsp_smp2p_in: slave-kernel {
+			qcom,entry-name = "slave-kernel";
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+
+	smp2p-lmcu {
+		compatible = "qcom,smp2p";
+		qcom,smem = <617>, <616>;
+
+		interrupts = <GIC_SPI 287 IRQ_TYPE_EDGE_RISING 0>;
+
+		mboxes = <&apcs_glb 10>;
+
+		qcom,local-pid = <0>;
+		qcom,remote-pid = <26>;
+
+		lmcu_smp2p_out: master-kernel {
+			qcom,entry-name = "master-kernel";
+			#qcom,smem-state-cells = <1>;
+		};
+
+		lmcu_smp2p_in: slave-kernel {
+			qcom,entry-name = "slave-kernel";
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+
+	smp2p-mpss {
+		compatible = "qcom,smp2p";
+		qcom,smem = <435>, <428>;
+
+		interrupts = <GIC_SPI 70 IRQ_TYPE_EDGE_RISING 0>;
+
+		mboxes = <&apcs_glb 14>;
+
+		qcom,local-pid = <0>;
+		qcom,remote-pid = <1>;
+
+		modem_smp2p_out: master-kernel {
+			qcom,entry-name = "master-kernel";
+			#qcom,smem-state-cells = <1>;
+		};
+
+		modem_smp2p_in: slave-kernel {
+			qcom,entry-name = "slave-kernel";
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+
 	soc: soc@0 {
 		compatible = "simple-bus";
 

-- 
2.34.1

