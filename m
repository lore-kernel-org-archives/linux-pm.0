Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B6836C59E
	for <linux-pm@vger.kernel.org>; Tue, 12 May 2026 12:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778588347; cv=none; b=Nz0zAmlOLmCRc+GUXq77m9L5FMTbpaMKiDPbG/DH10Z3sEZDkUs9XKd1PqAoy9+7c5ojIvv3v2/MB+6VCFfD+OurHPFFsilRytPYiGja8EtJ6oRQF5MiCH3JjwmbrJW6L4mb8YFwpAW7dmer13rA01rMd2j4X8NoEMo+zQpm1qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778588347; c=relaxed/simple;
	bh=6Sf8vas4PHtUAWVpKu9m1KQiPpgtKGBk/lLZaG0jX9A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TDoGselg+FZWYrkPbyIHMER7VQg+Bm9+QWOTFly1sGlXFNqElO+n/QKUNIkjB3iQ1LU55GguWUXdYsCt6jhwCbrOZyGxBOPiWgqQxlSo+KlGtLZ1mnxfQDSN37LbiCcY1icxFPMUzPLs2fSTQTRxrO1MZ5OLyi3hKQEJ0NsAyy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mdkJZqHO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LQcTUyGX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mdkJZqHO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LQcTUyGX"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64CB2JBq2518581
	for <linux-pm@vger.kernel.org>; Tue, 12 May 2026 12:19:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZxIxPL825Lb/iu/06hO2kw0SxnGFVq+Qz23EK2d+gVw=; b=mdkJZqHOSIZr2sHj
	So1oedgsi7dqV3s6y31cYZBWuJa4NSLDkMA9je5aGnAnvIMHR+j+bdZNCIiN0tYC
	tbhTWmIKCevi+DSvFxUO7cCmvhF2hg298wesrM+EV0ldCUQLhI6AK2+1ZGWt1f9/
	aGctfkbSAxQQC9yng0F8MXUKgBvm9xywA2vAe4p/QDlsA4BJ3FbKh7aR3YWR6ZGY
	nFRdRdYAJ4XuEf2G/z7IPyvrLvQ1kUhknT2bUFaQGciNQFFOMyXow3F3nCI0/Ttk
	RDDgAQ+PmVrY8c5AXh+dcFY+vbWsKDlvy+tes9Wqia6jKv4yzjvv92UTHN6RG2DX
	SHDaAQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e3nv1k8e3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 12 May 2026 12:19:04 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-50d8e8c47a3so124985001cf.0
        for <linux-pm@vger.kernel.org>; Tue, 12 May 2026 05:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778588344; x=1779193144; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZxIxPL825Lb/iu/06hO2kw0SxnGFVq+Qz23EK2d+gVw=;
        b=LQcTUyGXPJO6TO7Bd29epAMYlEwJgiRsc0as8lXuRCVvAQdj/3NhdM45t8Qj/c48Vu
         tYuzPuryuG7Eg+wSaqUrnWaGXXs0PgOpvMjS/Dv0v4V17/gDOOrQFzOZsoc8fF3Csbpy
         zGXXVhqN9k7Tv3yOrs1gSt2HAqnBv1QL38wSIGHPRRQ0I6T76C6Y9wh0gfOSBpj8NxyC
         rbkKz4kJ6H1boQw4d5B+cJGDVabVqnly3KSso41pixEDwciggUjiCxb9zaz+P2/4TztT
         VHRNdUeOZ4AUQhOPbizeOsGGfUYi7+wF+fcTbqwWUyHkHgUUa44ihy5vmcDzuD1nfBzR
         HxjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778588344; x=1779193144;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZxIxPL825Lb/iu/06hO2kw0SxnGFVq+Qz23EK2d+gVw=;
        b=ZV9VxqUeii4/3FFOalKpBrJGXEBDT1Pz03hpRj5wQcgAdtNdfcJZ1Niyc7vir+cfZa
         HXvFKvo6f7tI65VwVSE6xa6N/3/LJhVsxgU84mIeahoDTgAAsoLzb2+Tby3SA071ox0M
         IONw6+E6iPebFP2yBPyQASHl99hKxBvc7laJe30RjZEf6DCm6xcRB+46gC2iVJ8c/8pB
         JH6SqV1rkzDJTb5Nwk+aeuBirEvvPksB1AjPHjxbF5VY/TySxvXutG8xMzYSLDB3swxn
         K6X0WTrshg0ljC5/9T7lpsFr5+D/6e1Q5586DFM2liGupZFX/yiseXjnO0mSJgNXS4Qy
         NBYQ==
X-Forwarded-Encrypted: i=1; AFNElJ+6Pg9zPxcWiknSHtnDxa80INqK+0aaTlLXqHu5CNEFs5zXVfrYNy7Gil+0Tx7eqyqODNFQ/hOsWw==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywyvw/hYyuy8AyHS8UQR2j/8LCFVH7U2eh7hJKMMjGcNN+i7qTS
	uTXxqkwfwirU9NeFLofT4EJQMvhpc+TgQ8ds7JoX0PXiSwpWstKqWV8Prx/Tl/g5QXz+z2c8IhP
	DhP/XLl0kQScSblHqszWVVEy4dHwm3nUU8MGxG7PdFFT8VwzmkeJ9hupGfF+AeA==
X-Gm-Gg: Acq92OHs4cKE0bVEOtqE3urquVXzYlXe1ILQv19/y09qFXlaiPCqKPuuz7JF82snz1f
	fgjDyo0YCBzzOlBvAu5rYob/sgrJMcOqRDP5dVd6NeoK5PXf39VfgvV7rWO7Kbn0fb8As/Kzxr8
	u9qluBzNFd9OVRdK5Kal/1CC5WfRsjSwD9hgRAPakV6vCOwX24+YN0geumEiE2XZ35ug5KyXFEa
	LNObR8kohlQ1tDaliRG0WAHm8BmC/TfbO/VKTA6a4XAJRdXUyPLv7zU2axag57Ct/elbWaRbLEH
	fXgQAvSC+V7xqVJk3k+Ro6IwSQZATqON0ya2jZbF+nia2DN662jaQnHP7zFBXvGHf0xGplhbzQS
	7kVyLTuuVeh/h0fFW3+ursPVrZFNUug==
X-Received: by 2002:a05:622a:1181:b0:514:5c9f:6d9a with SMTP id d75a77b69052e-51461fdc806mr398384041cf.53.1778588344217;
        Tue, 12 May 2026 05:19:04 -0700 (PDT)
X-Received: by 2002:a05:622a:1181:b0:514:5c9f:6d9a with SMTP id d75a77b69052e-51461fdc806mr398383631cf.53.1778588343702;
        Tue, 12 May 2026 05:19:03 -0700 (PDT)
Received: from hackbox.lan ([86.121.170.213])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4548e6a6a64sm33700213f8f.6.2026.05.12.05.19.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 05:19:02 -0700 (PDT)
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
Date: Tue, 12 May 2026 15:18:52 +0300
Subject: [PATCH 1/2] dt-bindings: interconnect: qcom,eliza-rpmh: Add SDCC1
 slave
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-eliza-interconnect-add-missing-sdcc1-slave-node-v1-1-b1edf81bac3b@oss.qualcomm.com>
References: <20260512-eliza-interconnect-add-missing-sdcc1-slave-node-v1-0-b1edf81bac3b@oss.qualcomm.com>
In-Reply-To: <20260512-eliza-interconnect-add-missing-sdcc1-slave-node-v1-0-b1edf81bac3b@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abel Vesa <abel.vesa@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-bc6c4
X-Developer-Signature: v=1; a=openpgp-sha256; l=985;
 i=abel.vesa@oss.qualcomm.com; h=from:subject:message-id;
 bh=6Sf8vas4PHtUAWVpKu9m1KQiPpgtKGBk/lLZaG0jX9A=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBqAxqxciVrsREC24LhNZY/CuAOWpX/y4FRkKwGR
 R1yfn4a9S+JAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCagMasQAKCRAbX0TJAJUV
 Vo5SD/9TFySVxerE97NdogvRiYi3IHn80SK0Q4xFCTri8qohcB+2VTbpcB32LcKWTwgtOj7uMis
 MkQk0WuHCEWYhJw5GGNJCPPS6sdgKLb4rs88YLX0rQZJFxGTnvcwWhUkrO88Xzv3kE4fjL3vXzm
 BpELa+r8Z9yC7ae6aNBhaoeRXtLG/cgvek5yfKDIJflPs4/OVCxtEeChrkedfb5Tg/pTxhEuGqw
 6Trck7wcBHUqA76Z5439wI0HntZaHmqZM8MRIKBt+CICM6IDaOXfbabCPvNUEEF7wKvbCKu+wxu
 WQTFTjto8VYe/ht7nUBdfIx6/y7BMRTyOTGCxO1IhQIY6zRVGow5Z6YU33DtpM9cZ7O9N44+Tuz
 WdQdDFWGdzXHokoIpqptdFStZPG4Dk5Tnz5oYy8S//S479gMGtO76i6BaJFMLe4YJ4/6toamor6
 wCNqDixd8ynWQu4xtg1igrRVQM/KLxchyU90SfiVi/Ypce4MQKtWIRt/cL2uHd0FWvcRNnCjyzT
 Ehkwg34QcWUenBoEVBMDO934rOXwjibayG1mVr4lQK1CWoqFSKeIIY2OzfCX1WDdwkWcMAJLJZ8
 72BBtHAcFQgEmDQn1wB66VFxNryMPWS1WvjEI8cy1MN3ggQ0xZuHzX6C1q9MGBpeBbL3M2NId6h
 gmf4UNnMnWnlRJg==
X-Developer-Key: i=abel.vesa@oss.qualcomm.com; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE
X-Proofpoint-GUID: TDFu3pne7cR8E-NTxJjaEqAAC6VUVb9B
X-Proofpoint-ORIG-GUID: TDFu3pne7cR8E-NTxJjaEqAAC6VUVb9B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDEyNyBTYWx0ZWRfXzF6xsuBurRu0
 sae2vogIPm62uGheVRA3Ak9HDC0H3RiSf4kHlM95MeZNcClGmz08xUbL8ZPXcODgQH9BGZHLgda
 5DPccpHmrZagp2yIkzR0QKEcxTLUex+9wu+L2eLDwb5hpRFgzqAYaNPb1r3DBP7+L7+JsWpf9os
 SIzW10645rq1JYaYvwqnKL7ECZINTKzZx15km2URuregmc4fSKh8PC3tCMgFLJUCAVZlfz9/WoR
 EUmV+NKrp4o4TxoOKq6XY1UZe9B3PQnJMhhFhlhfDUHV10LJdwDtQFecTuj6Pz2s1dfRqNJfaxA
 1xIxBjRweSUo/uxFrMhUAWzpmjHydZ4ibS9LZXZI9LWOUcoss2XqCM0OFKGz+pUIWWp2hxivyR8
 o6p4VPRmdbnd19gARuw4zXM4o/aVo+MxxEDlGGpQSoyzbuIMVD2QzlQ6Vl27+h3ewLujPwK8Djd
 9dQ5pxeQIgvzEwRnf4A==
X-Authority-Analysis: v=2.4 cv=c6ebhx9l c=1 sm=1 tr=0 ts=6a031ab8 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=gcnggjyPzmaCdwFRn6A1TQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=Xi85gMORp529Q7Pi2tIA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605120127

The Eliza RPMh interconnect binding is missing the SDCC1 CNOC CFG
slave ID. Add it so SDCC1 consumer can describe the corresponding
interconnect path.

Append the new ID to preserve the existing ABI values.

Fixes: 8300438dc424 ("dt-bindings: interconnect: document the RPMh Network-On-Chip interconnect in Eliza SoC")
Signed-off-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
---
 include/dt-bindings/interconnect/qcom,eliza-rpmh.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/interconnect/qcom,eliza-rpmh.h b/include/dt-bindings/interconnect/qcom,eliza-rpmh.h
index 95db2fe647de..dfe99feefb27 100644
--- a/include/dt-bindings/interconnect/qcom,eliza-rpmh.h
+++ b/include/dt-bindings/interconnect/qcom,eliza-rpmh.h
@@ -57,6 +57,7 @@
 #define SLAVE_PCIE_ANOC_CFG			27
 #define SLAVE_QDSS_STM				28
 #define SLAVE_TCU				29
+#define SLAVE_SDCC_1				30
 
 #define MASTER_GEM_NOC_CNOC			0
 #define MASTER_GEM_NOC_PCIE_SNOC		1

-- 
2.54.0

