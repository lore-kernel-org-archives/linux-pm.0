Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794468028;
	b=cBO/zXXBW8Gz6F0THljPwylvkcFgTttojtZ8CJx3ALh2NqeLnMdE+4KKQUb/So+bNMcl
	 l01Se+CbHcziNbYOuyWgnzHQUrTnptskRk+LM+LQgZ6aLzwXRcMaA5pdLlKbq5KdPogZ0
	 C0XvgFjUkkYR44Xkci4L+E0snngSaOWkvyytKYouHquKQC8bGkm1BAMCEypiOTVC7DEQZ
	 IAlcNmbQS6Nmkz8h6ZxFUjPpXRZ48UGM316t67vor1HWIpZigdbq2rDQiRWzDGxYgClAg
	 yRX7Urct6YMBjTi+mUIG85yYVJc9mlHCzau1CIdm2+BrCly+U3VgqS8PmuV8Alb9Unw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794468028;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=4qfL7piDG4Rh9USRDzIt+sOlvyefKyWytxUWwXJiZms=;
	b=nAB8xF36V0LrHoOfdK46cNUPiAV3t57xhqbiTYK2rHXexQ4j5lRgrfYR2Sfiqu7dY0a5
	 +f1cNDgea0Dp+ggMKKu1zDudqvdulkJptAv1f4OJXKSfZGzGOAbkX15QvTpPZ+nJ2Gj4O
	 KGfC9ptDGVST9knlf3vZCNl4FsNDe3IP6DmeoA6eLIVMfVz2kdhwn7YjfiVV1YA1tnhNc
	 +c6lN2ZKJa5hZHudb4X1RboU9bF795IGQ4yoD783a0EwCUmlhuQ1+riEJ5sBirHiDcBrX
	 AwqBS71IiHb7DFLiYYvSBNkydtkipUOL1kPZiK1gMB44knD3upCrfZo+F6x+dC7UFpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=o7kINskI;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jnV54P4z;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC112606A8A0
	for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 07:20:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC112606A8A0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=o7kINskI;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jnV54P4z
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AC4lx4L3893148
	for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 07:20:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=4qfL7piDG4R
	h9USRDzIt+sOlvyefKyWytxUWwXJiZms=; b=o7kINskIVSfsohNxfhtPNksdu4R
	nwr4fsYh+RohlDcR5574SVPu4Ekm8w5eA/XkoaxitHR0S+qnfgXlNrwQO5P2JJmw
	twkMcpVrjKQllZ+if7BAw3m0cO4WvskP041LRMGPzMoFWobpOltVQlGx+aawk/jS
	TO6FvF+RYnlOw11m0vOZIhhoMhrYURWk8h4CePPNdSJzxt0lxEQbJH1mDtVLhHfN
	BmWuTtLClpEO380/+MTCI+iCU0sRFC+bx5ahid7OWjrH9Ip2/IeP5UjKrrRrD99T
	XBPeLIO2fg0sN+kx1cqcORzaA48SpQ4Cc4FrFPluFxQNrk9Gt/0wjrAuR6w==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hw6re0fnd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 07:20:27 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cd5e8574384so207418a12.0
        for <linux-pm@vger.kernel.org>; Wed, 11 Nov 2026 23:20:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794468026; x=1795072826; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4qfL7piDG4Rh9USRDzIt+sOlvyefKyWytxUWwXJiZms=;
        b=jnV54P4z9Mcv9+V/bGWAEKREg6X6KACNKWBaR5cqKYMTzka8t9KMVpxM9cOpU0+K7o
         ydpEOKxx3dudASJEhuixpBlMh2W/LEa19Tvt1RS3Zy6z+CmeITZ8HlgFtHG93fYCdWNL
         Iwu/UkAIeASSCOwCL7KO1gUX//PL7rNJHG4+vK63A7d16zxYz+HeFo9K8DYhNHJQpuWF
         jJFnc7cdfHt3JejM/icNYfNn4E8mZRpw0CBf77Lx17CGfAVtzTS9WffAuc+4iTyyDItX
         QdEieO6Z6uKLbSxXpERnRgrK/lVIq13AETs8yjtC2BwcUixk7Jfo7sOxfWDfQ0VriCN9
         JM1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794468026; x=1795072826;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4qfL7piDG4Rh9USRDzIt+sOlvyefKyWytxUWwXJiZms=;
        b=bxwmIBSka+sMi+as2kiWxdFdDUX55dyO216q7CSa9P32j1RICvsDvnKf0P0Kj+XIZY
         9U8roMbLuTwQR+BuXGv6jn3mo7iL597NxL99HB9yLe23I7WlY9You0Mn/48vPE6WhByy
         kDGxEvir7mHSJ7C6PkEgif1N3U1BYMEPzQ0QqiDqcg5Ie67hXrh06yWgBQF3G8NbQ+Hb
         4oPWDjwYf2kZdp588MYd4LxqavsL9i+nR0s+/EySg3h3/NscsjA8oH0U5bngezhLKXgz
         +PsR1dW43BgUyn5ph5gbU9oAbQuRDvkB/wyGUq0AHiSNAG1eEgv9YTcyWdiRed6lmonF
         gaBg==
X-Forwarded-Encrypted: i=1; AL+hErFperCRC9TcaBHcQgHx3vSL8qQPRhCSoc1zvKlkc816GH8U+8r5eV9IaTjQDXLposkrPeJbtGHHpg==@vger.kernel.org
X-Gm-Message-State: APuU4Z8AvzityGJwidEfVcZL5FJRmJGMgVmdJv8omCEw/DxGWER2RGKS
	A2pAzGxN4mDNU6MK+E5YAZDAUbxl9xn5kizrZk06Rb0QI9kb65TMpRN34kfAlcrZtAOyhTcH9lq
	+2eZxLAlCewkasMoEoG64RmXQa9qJXAlBSYgjkXD7ZIpsoCzPRrHHFO5Azwbbh/3mXH85nw==
X-Gm-Gg: AYBFou39HLtoIYv9eaycjRS8AQvdSUNk+0tRfrJBM9BeKI2QXQY8EaLI8s6rx+E5s1G
	LDhKGibvn2gFh4QjfolR517Pzg5DLQsFrJlbYqe3ZoVMVunoEX5DYtnZdQDHSWBoJ1fVzahdEX9
	ZHYQlUHdSAXTkQrCAFK9l4hoUdvPPKirS2VNoAVtMFBS2AE0Iz3Yshxjlsto2l1Mch3gE0x0bTw
	n9R4zYELMoVsbOIEYU9NQd77BNyW3KvGo4yFLMAx7u34XiPB+B7RwctT1NodYvMbSUHoNicHgpA
	CVLI0LvZthkABlNfA10QbGFE47C7EdyEZdXgi/+3VA6ZkUDL4zlPxT3bvIjClRhwLE4KhriJiXz
	62s5vCwrPda8QOQg0RfrwdzPx4IQRZWmwyIPkkF/hNcTUS4mvoUSfy2zWlla/j4xuYCRR+sO+aK
	m1Gw==
X-Received: by 2002:a17:90b:2ecb:b0:3b0:d0be:f02c with SMTP id 98e67ed59e1d1-3b183000402mr6586898a91.6.1794468026464;
        Wed, 11 Nov 2026 23:20:26 -0800 (PST)
X-Received: by 2002:a17:90b:2ecb:b0:3b0:d0be:f02c with SMTP id 98e67ed59e1d1-3b183000402mr6586876a91.6.1794468026028;
        Wed, 11 Nov 2026 23:20:26 -0800 (PST)
Received: from sdciot-sh07-lnx.qualcomm.com ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197c73e27sm3149185a91.9.2026.11.11.23.20.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 23:20:25 -0800 (PST)
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
Subject: [PATCH v4 1/3] dt-bindings: regulator: qcom,wcn3990-pmu: document wakeup-source
Date: Thu, 12 Nov 2026 15:20:07 +0800
Message-ID: <20261112072009.3815276-2-linghui.wu@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261112072009.3815276-1-linghui.wu@oss.qualcomm.com>
References: <20261019093911.3199891-1-linghui.wu@oss.qualcomm.com>
 <20261112072009.3815276-1-linghui.wu@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: di2g01q6IBd8uBIdEIP_mIU5-ld0Ldy8
X-Proofpoint-GUID: di2g01q6IBd8uBIdEIP_mIU5-ld0Ldy8
X-Authority-Analysis: v=2.4 cv=NJhAaE6g c=1 sm=1 tr=0 ts=6af568bb cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=brVOnVl_E7YOJ4RIXMgA:9 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDAyOSBTYWx0ZWRfX5MuDRlITv3uU
 3RUhSnecnT5t3z/5+fLVIGtHjV6w3omGtCptTIc6i5xc/LHNQdJ6z1tATG7Y0eEDEztJnEx2nME
 AbPS6T4alVIzgM397lYohIrMmZLnXFA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDAyOSBTYWx0ZWRfX5o+cooivWG0X
 NWolvFs+4Rf/ofsGSg8Wu2OSSOkiRqn2whKewZVhwal+zeg/DxZebYo86ObLcgM/YOGfAOfXPs5
 bJbarcFZAs9C4L9ZCSR69Hrd13ssK4+S5+UzS8lF6y28T/234RCreXZ1Y8H+KkVdkOooh/UtYvl
 NKzf04ip+3c2TCS2SP96rq/Qum3J2x+sw1Dipr3Ralu8PuxQkBXhyCAgDiVNxMrtRqovx6w2XyW
 xx5d54kh4DXVWEiDl86p88tu/OcqU21iF6fuOIBf3lcA15SD4jWqF+Wh/fcrGSgvmUlUNKtOI+M
 L4hwhgHDqHpwAKLhP5DHFr6ncpfCE8GTYpG+uVwMEClsXY5Wsh+xp87cyiUZDbfr0h7Jj1pi5Nr
 FeWQviXdeiyGgeCvx2jPFVNuBfKDUQFC8bqGahvIJe6a6W05cNlOLxOKIpB75+SAJhTEM4duFUm
 b3Hh3r+Je7cjaVK3pvw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 clxscore=1015
 malwarescore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611120029

The SW_CTRL GPIO can be used as a wake signal on platforms where the WCN
device needs to wake the application processor.

Document wakeup-source and require the existing swctrl-gpios property
when wakeup-source is present.

Signed-off-by: Linghui Wu <linghui.wu@oss.qualcomm.com>
---
 .../devicetree/bindings/regulator/qcom,wcn3990-pmu.yaml     | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/qcom,wcn3990-pmu.yaml b/Documentation/devicetree/bindings/regulator/qcom,wcn3990-pmu.yaml
index 9a7abc878b83..f0372e28c99e 100644
--- a/Documentation/devicetree/bindings/regulator/qcom,wcn3990-pmu.yaml
+++ b/Documentation/devicetree/bindings/regulator/qcom,wcn3990-pmu.yaml
@@ -42,6 +42,8 @@ properties:
     maxItems: 1
     description: GPIO line indicating the state of the clock supply to the BT module
 
+  wakeup-source: true
+
   clocks:
     maxItems: 1
     description: Reference clock handle
@@ -67,6 +69,10 @@ required:
   - vddrf-supply
   - vddch0-supply
 
+dependentRequired:
+  wakeup-source:
+    - swctrl-gpios
+
 additionalProperties: false
 
 examples:
-- 
2.43.0

