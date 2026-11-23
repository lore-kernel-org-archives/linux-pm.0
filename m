Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795429549;
	b=XIze3nwCUMOXge2zZuzmI17iDUnUxL60nh2Pdgn1ZUoZDQK9mO+WB0OczYj7gdyPAURp
	 DAvwc0T3QKoWeP+NB8s1ukksW56VowieYQ0AyRIC6WV76YAeFCdUjCbNRjbFLfnUtZ07Y
	 q0cKK3FLLmRlbSRi9INNM/fMjM9HAl1J003/h5gIbFAqejFaiZocnX7zbyz9PceIAMP1J
	 CQK96NlPHkjVyN9uoBxfjhiwcEJNw7TRZbTxSpi1pS1RFLQRvmjNdH2GnDnKOPa+ya75/
	 ZHQJh14SOxihr9DpzxGYnj3gUmgMi4dFuNYEvMW2BGXz95sOBkyHRssIiOtmHIspG2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795429549;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=fdPleMKS2IC93aynK6NEkJ3p446vokYhvbwvmK8b/Kk=;
	b=vHmDiN9qzIJ3/1cbSDMYL/GKB52VQS3mHWgN9WTiCX5cUU5zqW0iFYSJ6MG42oyZmOVt
	 LoCZzqYJiO/V1s9sptumGhTf2o/mV82RGKLBvbM8Rzjeip4Yh+F/66Ak0UHpvxMA7C45t
	 UY63G7ECxP/1cRlBiZqOgLedNgU3pyUPxdUec+rLiBb5IGLvvN4dvOyUcZxUDWVhITqdg
	 qgSG1lIV6ySnqIuEqde4ylJ4zxc3rv3HSdQd7YGICBaWU1057dRysSc9qNMnWhuDjy83i
	 FaePB/Fy8gwp1tJo46eLRenpfGccscHrxKB+vAKdXBYlPAKCyxt9WXvRSYfVN4zr9JQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PG0catFr;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TMZSX80K;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F3A60A2638
	for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 10:25:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44F3A60A2638
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PG0catFr;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TMZSX80K
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AN9G4v91899656
	for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 10:25:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fdPleMKS2IC93aynK6NEkJ3p446vokYhvbwvmK8b/Kk=; b=PG0catFroHWUpcO8
	1ZieIvVdt7o3wG3I/57gd22yhfoX/Ns9c9eA2XY+mRgEM4uuU2CJFtIdL3huZGG5
	8pbfBDO8D3MnOM78UNW3OwemZ0B0O0YuSoayd5B9CDH9QVRUjx6O5/ayV2SW0XIz
	I2KBPeMBIRKY6cl2KtsMl151L2oo0tR0awxHTubgim+fmAay2mwOrjgBuxKFIlDg
	5GSUbLUG3sJZBX2OM23hyVbMeTF7FUbZQmZcjMh6swqJ51RqE7p4ZPbCEe31G95G
	6vGfadHesgz7OcG58VZakx/85fHdgtyp4pkl6En1lS+cDIBfoH1hV7KSCfE/NZ2w
	C/UX9Q==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4g1k0xkx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 10:25:48 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-9495dd0f07eso596251285a.0
        for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 02:25:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795429548; x=1796034348; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fdPleMKS2IC93aynK6NEkJ3p446vokYhvbwvmK8b/Kk=;
        b=TMZSX80K4huuAHvPAe9qssG5wgmUmh7eeC6RQHLN6v4sPudTMA2U06e5s3hrnKQjEf
         pi8fwpNbGc7EE15d0RaQhwABZeHGK2V95sK7v19r3y7m5niLZZuDaQ6Ztuj+qd4B+/UL
         GvWwc7cmE5v262rI4bUpuF/Kl+40lrAGPSWcTDOwkAxHrC0BrHdPO09Ep/gIL6an5fd8
         B/zABLOSQlX3WAp5irnERObJyx+WwVbLO8xluL0CT63LPkKUtrWEcJpworoH+hMcc9WZ
         +NF4f2Zw3QIDTI6MAJcl32qQh3USQ5yKKvX+MwWNccfjGE911AeggC+v2aDVCMY+iknh
         LPFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795429548; x=1796034348;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fdPleMKS2IC93aynK6NEkJ3p446vokYhvbwvmK8b/Kk=;
        b=C55Wc5lgFbwK9uqel5YKdGkUt/8vxEUK5dHjScy+1yMvLVp4HZomkbxxVdfb5mgqWZ
         lhuiuvmWKZZur+UBiUx1/QazUTc1G8d8ojGOCJiXgIa0R1aVpqbJVnnCycSkePs3J41T
         +rsp7FJpu1mA5oFrYt6DJ9POo+H5QXePONsrjSKxP0iBPA+qyxzHw1Xayj//6YYWFArY
         E+PxhtXM1exCrANYIJ6sReCy4uRbMKCVKaTxSdqY/HADFm5ZOLlu86R00aRG1sA9dnHx
         C9M71e303O7tJTq8T5jsb2MBmxZpLK7t1qcTuJn3QiCJVdaArW6z5b7451udfZP/9v8R
         ojTA==
X-Forwarded-Encrypted: i=1; AL+hErFuS6OGMQq/k1CAFHX3IQtMFly2bUKc/v6U7YmErKA7vuA3HgUcc5UKxV3lQBNBqwyfWxbCumrD1A==@vger.kernel.org
X-Gm-Message-State: APuU4Z/8hu39Qhg0a9HHZwVZYTLMt3mNjQYb2ZWAY+ibwv23ut5Hr/3M
	xaV9r2k8RJeaKE+RIw5Vje724JTJOuO8hjKKSywNY+jdfghTm6yxYXb3WxPfaN55ISi+xoxU19C
	BxdJsLZ2A2bTRzFbEe6V7jGseZ/Q3z8w/LRSKszZd8kutaEJNBf+YVbzjk0IPyw==
X-Gm-Gg: AZFdTZc+U6K9SHjP8OOcji8idv8f7KXzSbiGB/cilHnCVAfCcXaAf+p+WTSwzEGleKn
	8gmXpe01Tr1vJd61bnOyhp1GNoN49UjWNsqo5DItW5wtJWk9pkZb7sotZZz9dopaH1klpSM5xlM
	fMOs8SiHSNMB9TAOl4Onjs23F8zpVLiWKrV4ODfylQ7uLQN9hgdx/igPk0LvZQWmxIw+eZB0hPS
	e79Ead4spqJCkzdSFVoHn/2RzbJqaOKhsctKEm3ZkKFik0SRtPTmxTIkyy0ezftm061l8f30ym8
	e49U5DBlmNt1j2Wz2MPqi1cYfpLZ24S02AaeN0EDTmWpyGJmrqqHSX4qHvGE8Q1bp0s8ff/ZqAD
	Jtq4lMIQNs3S6DLwgE2K9lH1dN5+yoXzpw38aIguEHhmrnH7ckF6otqp6ikNqVvTUg6Nu+8IHsq
	wQh3tWORy+N2ko6i2+HI+4MB+hNFwctffKhRdoJsRcPX42EfDk22VRRsAI/2p+VfH205oQrm4nG
	bMCM2GgUhg7V9NzPURfXKpI+hTw
X-Received: by 2002:a05:620a:2b45:b0:949:a7d0:9fbd with SMTP id af79cd13be357-949ba9e2668mr1901700285a.41.1795429547606;
        Mon, 23 Nov 2026 02:25:47 -0800 (PST)
X-Received: by 2002:a05:620a:2b45:b0:949:a7d0:9fbd with SMTP id af79cd13be357-949ba9e2668mr1901697885a.41.1795429547152;
        Mon, 23 Nov 2026 02:25:47 -0800 (PST)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:58b4:dc38:81d5:3c3e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8538b09bsm634166845e9.4.2026.11.23.02.25.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 02:25:46 -0800 (PST)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 23 Nov 2026 11:25:38 +0100
Subject: [PATCH v8 7/8] dt-bindings: connector: pcie-m2-e: Add vendor LGA
 connector compatible
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
Message-Id: <20261123-monza-wireless-v8-7-a8b38604be6c@oss.qualcomm.com>
References: <20261123-monza-wireless-v8-0-a8b38604be6c@oss.qualcomm.com>
In-Reply-To: <20261123-monza-wireless-v8-0-a8b38604be6c@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA0MSBTYWx0ZWRfX4EQ26Pmk2fV9
 u7De/+fCP8sZsEYekVRdxFdqSJ3eqtuFG4SrFxGn2TiTSm3i3SJuTyWIUeFpQutCl+9sqbsS4ug
 hZ3Ym/TAcbS6+ohfctPZhcqMzjBUVzg=
X-Proofpoint-GUID: Z_bxqXdqA7Vn7L4mfwsjY6CBAxv7Odv-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA0MSBTYWx0ZWRfX0ZTv9Ul5PQ/m
 89l5JCDT3uNLWZViNSwQryq9fjiMHCMAzwzasD5KWnV6adMMFigBr7SSAwNxaj3yG6j3Tn5KzLu
 OjijT1I2vRQFFWiMBHwK5K6tfIjzI/A2EL7JSeLKnznRccRJ8a4KtLJzmjIRNH4SQ87+qtaW6mr
 kGbu6f1wZk3DTMiSt6nqdiZP4whhD4ac4Ib5sE9Od0gkmjbpencBcMYd7TRL9ibg1JcnxiO7m4c
 lgnjwSQfPUDHR5t8Livwtq4PtgU1tWBZH5hvfOpzVtgiK3agEUlQogDrYV/cl++7ea+Veh0x+vb
 IlMSuz07l6y1ULa7Ueru3aoNFevAeu/JSPQ1WNFnt5fI0n/8qtevptv2H+kqKprlgecVh6cXU9k
 xrElyj0BB3EEp6tjWit7JUEe5PS1nHw5r9Juew28htzv9JdWU6VoAVV25+zvuGXd0EoKB/vOsch
 bFXu4U8i9FXXq16Cl7w==
X-Proofpoint-ORIG-GUID: Z_bxqXdqA7Vn7L4mfwsjY6CBAxv7Odv-
X-Authority-Analysis: v=2.4 cv=cpIOAF4i c=1 sm=1 tr=0 ts=6b0414ac cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=VwQbUJbxAAAA:8 a=M8sXMW5dAYDte-7YvdsA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_02,2026-11-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 spamscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230041

Some modules (e.g. the Qualcomm QCA2066/QCNFA765) expose the same M.2
Key E interface signals but are physically soldered as an LGA package
rather than plugged into a real M.2 Key E connector socket. Such designs
are not actual M.2 Key E connectors, so describe them with a dedicated
vendor-specific compatible while keeping "pcie-m2-e-connector" as a
fallback for the shared signal semantics.

Add "qcom,pcie-m2-1418-lga-connector" for the M.2 LGA 1418 found on
Arduino Ventuno Q (Monaco Monza).

Add "qcom,pcie-m2-1620-lga-connector" for the M.2 LGA 1620 found on
The Lenovo Thinkpad T14s.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 .../devicetree/bindings/connector/pcie-m2-e-connector.yaml        | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/connector/pcie-m2-e-connector.yaml b/Documentation/devicetree/bindings/connector/pcie-m2-e-connector.yaml
index f7859aa9b63469cb43919c0b5719c18694c5364d..ce6173a0ec41cfe8ab4a5780940999c18674ab7e 100644
--- a/Documentation/devicetree/bindings/connector/pcie-m2-e-connector.yaml
+++ b/Documentation/devicetree/bindings/connector/pcie-m2-e-connector.yaml
@@ -17,7 +17,13 @@ description:
 
 properties:
   compatible:
-    const: pcie-m2-e-connector
+    oneOf:
+      - const: pcie-m2-e-connector
+      - items:
+          - enum:
+              - qcom,pcie-m2-1418-lga-connector
+              - qcom,pcie-m2-1620-lga-connector
+          - const: pcie-m2-e-connector
 
   vpcie3v3-supply:
     description: A phandle to the regulator for 3.3v supply.

-- 
2.34.1

