Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7696F2D8379
	for <linux-pm@vger.kernel.org>; Mon,  5 Oct 2026 12:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791202923; cv=none; b=S49uhRx0znlMMf4yfttlDGuSP9vo/y2hJQAIinYJHuHKb9dZQ//Usirquztg/esmkId4e4zDSpdXm17kNDf4fOE5+4PH49m8th0xxYlbBqg/IRVMdRErOCvgoKtkeQGO08EOVxQrS+Rlsx+4JjlRLUNTx9c6nVTOT20yU64DlsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791202923; c=relaxed/simple;
	bh=xbR26F+2IK0SwAaQUmAO2+Xe1VwKVtt+NKXks4bobiI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FXwC8dBVNyx5ozaFnn8aIPzw1MjV4+9dnGursHYX3fHz1eluyJsr8NdofPkgOiJoV0kjXGeMheRl91mNZRzD3h9yiueE5rbe0sviXNl1s2jgJAYZ5VdW/hJIkDQdOlpHqKZdVKKjog1ZbdP1qQM3kuX2aM98rkMWMcm/ffUAxoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ioHZLbTk; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iDvie8WH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ioHZLbTk";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iDvie8WH"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 695CFPKS1925809
	for <linux-pm@vger.kernel.org>; Mon, 5 Oct 2026 12:21:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fdPleMKS2IC93aynK6NEkJ3p446vokYhvbwvmK8b/Kk=; b=ioHZLbTkI8HGv28H
	tNE8ptOu9b5+s59oYIITySvzWwj5tY2S24RnKztunJg8SeNDEFBvRiQh0li6LWsB
	3VdoHkyRU4mIgHljog+f3M2tXUyn2M6QPvAl0abTpvkuSWyzm811fCPoTyyuQTxe
	rQuXaR0x/pZ7mMwU2aGe7JTLdE+RbQejyRN3qkiGlzVlauMBxzngl/Br0BUuiqmF
	zXfKXPNvNH7igZRGtBXHv++Zo5s0F7Ad5HEe2huz2tz7MiXM82m6XArMlcGRJAXN
	RtnVxV6RwFZC8W098RkvT0w47mLbK+J4mzZypAVZBjkHSTT+IcaPNS8r/9VABFUI
	ugJFpQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h3xgyt1j6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 05 Oct 2026 12:21:58 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93e46b4b700so299653585a.1
        for <linux-pm@vger.kernel.org>; Mon, 05 Oct 2026 05:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791202918; x=1791807718; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fdPleMKS2IC93aynK6NEkJ3p446vokYhvbwvmK8b/Kk=;
        b=iDvie8WHK1AtDSaV7haK48Gv8S47yGjzY/83q+OHaWyvAN8+uuG0KpGA6veR6eGLOo
         zWcOZK1fDaIgwhqM2EiQeVo1ZApPWFC+cKk5iHO8L3p6hFBgUuwg/LL3nlQZg16A81vd
         pZVwcVpqMXb2Ukn8zupGWyNzC0OPW5fVnLY24Hu03LMqtM+B4YZPq+7RFfXTo99ilPKA
         5tTX4KFLCoGJY22o/woI32I4gVryp/itKQBOumSrEb8B5w3MnMDh9XfvQcz1jbGQPBVm
         CRWQPoVU9ZNZ7B5Cmg1PylhXAXACdxlmPJSS9Reg0Uc4ycO2uZOkVdP8Zhi9nglNLWEr
         xUzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791202918; x=1791807718;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fdPleMKS2IC93aynK6NEkJ3p446vokYhvbwvmK8b/Kk=;
        b=f4CF28YoSeroWWD7JPzO8K/UJeQvPcdBFTMYW07V3mwlOmXl3FQHKAR/9+611+E31K
         ksouJ4H75800nIx4ta9MjBBynmWkreB8x0/B3HEWLXSA89VGC7VLPJroEjHWcyGaPb2Z
         lR/Ta2zXXysuqPiKu2Cr88YHDcszoicuRAb9IezrxIEZL04yTHlywlbfoQSP5ncvH6qE
         3WSWwSwNFocYCRpRqKb6LOnMyGEIv4TYx2WinO6w03QX/Zlp/8Cw8nnXP0lHVtQyGtUz
         YducKN+TDEE4fWTTu5eAR8YIlWBWT82SON8K3k7QyP/NYJogq/GcBUQcr2pKR7skIAcA
         ouNw==
X-Forwarded-Encrypted: i=1; AKwUvBwJbk1oN8q8YVyO/fJ4L5E46YnHiTLuW7YcQ6AxFukOO+qq6h5g2+CGpdqBOo9Lsam2MBDe/L7C/Q==@vger.kernel.org
X-Gm-Message-State: AFuF++k99Vb0zQH+PPmf5aGRCy0PYc1SskFytxgzfXMCpdEUGE59JwMI
	18B9qYL2WIyStOLs8xMTfye8FZAIiZ+ccod1bj9OssiMJRriScm5PGB0a+77WtAmbdPQjOOSPfM
	XRWESnXqux3ODR4oGjEJ8DvMD889Mu2kIQ0Qnbw+ZbhKMW8Njalart7EwUmG3QA==
X-Gm-Gg: AYBFou3mPVLnsRbejrZWfYQuJSpI+WOQU+5Ow+JXphXvDlOOxZ87jj5B0hza0vjV7q9
	nCFclM6J7Gx5eE7OAJaB7xJn+VVmuJet0u86ICBgYQH22CIPCPyVGOmySWOlHY3rBnP4VDR3ezW
	EjRCgVE32VPSjRBMlwU1x1akK7f1Wb0zVQN8FsPMDgpFhWSRTRT0m4rhlOpX9UpSFyv954Zy8gD
	nQKGBJkxo7nM/kM3YOFLfQkXoLm0af2qbmyNRyWSF5Lo6iiwJFiubx2j/eAOR8Tk5jBYLDLfIBU
	6QHGQ426v+u1HM7uPeGhgcNgNAJ7gHLaOAqEW8u8HEr+ULrcpZl7LK6GExfFWwHvqP4DFOMMrip
	XacCb5jDKs/jDXcEf6nerdvQlcdszt7MKcpxyQZtdFYNA29I9UclFMqokouNB+KxyloTNX32HrV
	ykkCJApoTnphaJLvq6CPcgAkaXOLeIUmdde8VeLy8esy36b/MqjJRNopgI8XV9LCsPYnMAkQ==
X-Received: by 2002:a05:620a:414a:b0:93c:bdb4:2be7 with SMTP id af79cd13be357-93e510cc94amr1222904185a.60.1791202917867;
        Mon, 05 Oct 2026 05:21:57 -0700 (PDT)
X-Received: by 2002:a05:620a:414a:b0:93c:bdb4:2be7 with SMTP id af79cd13be357-93e510cc94amr1222897285a.60.1791202917216;
        Mon, 05 Oct 2026 05:21:57 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com (90-182-211-1.rcp.o2.cz. [90.182.211.1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a027698f13sm324157425e9.1.2026.10.05.05.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 05:21:56 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 05 Oct 2026 14:21:37 +0200
Subject: [PATCH v7 7/8] dt-bindings: connector: pcie-m2-e: Add vendor LGA
 connector compatible
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-monza-wireless-v7-7-5a6de7662dcb@oss.qualcomm.com>
References: <20261005-monza-wireless-v7-0-5a6de7662dcb@oss.qualcomm.com>
In-Reply-To: <20261005-monza-wireless-v7-0-5a6de7662dcb@oss.qualcomm.com>
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
X-Proofpoint-GUID: FmVLAw2_4rLyoRkZNSa2wviS6dlM0E4H
X-Proofpoint-ORIG-GUID: FmVLAw2_4rLyoRkZNSa2wviS6dlM0E4H
X-Authority-Analysis: v=2.4 cv=A6b5rKWG c=1 sm=1 tr=0 ts=6ac39666 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=zRh97aRZNhiOMYVz81Er1w==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=M8sXMW5dAYDte-7YvdsA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA0OCBTYWx0ZWRfX7O0Tv0D0AxyT
 Cgq30nqaAo7mHQr9i7MKvUn/tRnwk3gGFXgeW3TexG9nGBvN1xszJspmb3dAPmWPiQYXyWR7cAw
 hKyEhOauhE/3PnJVL6+b0+kBuaHvhqPN3Fdd1/3Pf+T2K12pXHcy6+nIq8ZuZxB4RH2G/ILQYQe
 HqQ5a+vCMb7bPjkoZvy2I6LFOOsO+pXOvinxBpLCHVQ+bgBuaqmOq4JnB7UvUfasJ4+PPcY4o9u
 N7EGK5a9vEZ0isf/qFSOhrL4DLihUZYtBYR2bozaeK9IXhdRS7RYgOcMJwt7CS0jo6bDYFCCnTl
 BibukCpGnFTeB20Ri+HhO6BQHDEq3CN8EAvQhVkDb2SYz5/BgY6pXOBgRTv86OjWVVLg3HtB1WA
 aPQoXFNzuWysVrcMQDRtEzaKZ0ZR5WSUkdZ9pgvTUm1IbV0JktuKchzGca/fL/pDhvSR6KQHy4C
 ftmkRCqM8mFZiYGGotA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA0OCBTYWx0ZWRfX9TUtejX10fyS
 d1B8HnWRjI/pmqRmRiIsqq2Y2gTDVuJqdUE3H4WNjiJoXLVqus5jEYJMAcQmGIp53G/hrDyY+Zv
 oe3xC7h8g6H4jbnEEzLFRC5pIMa4Y1k=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_03,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050048

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

