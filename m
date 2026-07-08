Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039D4436BF7
	for <linux-pm@vger.kernel.org>; Wed,  8 Jul 2026 11:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783511848; cv=none; b=UwIJTIIWxEat80NNCZA/gJwWmCDrXigXQJhzX/oGJ/ASGFpdy2qPrekcIFz34LR03Z1sVtmKMADAUsSbPgW8IfdWTYskP5DFSoBlMRw6tidPpamm2zzYTHS70Qb46rHNVKIbqJKZ7td9w5xz7VOycW2OAmNWo6bPmO6RpUSGkGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783511848; c=relaxed/simple;
	bh=FUXzDx/MqiII8ZYGHiC1f7+FAeVodk7UbwWT+31SNcs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=PTud/wfnvHjKVwnif1LkGQNIIvc2BEwoXuhKfsV6mKKaPdmIYmrZ7LgcNRBw5jDVmbYtJ2bsZfHYCXnKEFmp7RnwEF8oqWWXnWOP4+yeUJz+x4RbqNDaPy3vLAOz6D+7GFaM9+kQmLD8KdJcqAS0TSy//9IMBcZutFj5JZrIpG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XrhMBcZW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=a3OQPlqI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XrhMBcZW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="a3OQPlqI"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 668BTcDn2502664
	for <linux-pm@vger.kernel.org>; Wed, 8 Jul 2026 11:57:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=hHdBgQ4YRaAM8+nMh8X4NW
	ZFsOQZElrCph3RwF75yXo=; b=XrhMBcZWhz8SnPajJmP+ziafF3kUG/fBpaGnuz
	aSuvEQG9pS8Xu6R90h4OXf9y0JN6I/8HPSxHvTOuwuLk9vZMU/YaWx5HIq2GOm4m
	Ayzi3qKDei0Nnicu2TIi2YbbU6GuXCKrtwZed69m8qS8K8Rgu/7gkc2OOtFfAtL6
	egWEfY3z8X4T1LRKNG6noMxgIGClYDK1ua10fH1GtKKsb/Z+EBvOuaoGgE3vncnp
	IJRL0WEf+2bWPz1OBSou74sfL/QNHHmESe4gK+tpIbevn5JgNrZfrRa1YsBysL2q
	uZfdmUqY7TxQWNqAI8vAUERsh6Z5bleE15sFM5YoevvPxTZw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9b5gak0k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 08 Jul 2026 11:57:25 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51c0ab07320so5585531cf.2
        for <linux-pm@vger.kernel.org>; Wed, 08 Jul 2026 04:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783511845; x=1784116645; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=hHdBgQ4YRaAM8+nMh8X4NWZFsOQZElrCph3RwF75yXo=;
        b=a3OQPlqIAdQHh7utFPZOndNzI/mzD4cmCHHkaFZrjAeTUG+sjQL8eysVIsI89WUtqu
         OQD2tt1LUBBxEvoTG4xJmDwwIiFja0EPaEkJlnoDdFQOmG/gdqypyWOekZHJfmwL/FUL
         xKGtFe6Q7MKpP9wWruR7rT7/IfheWlfvOdQtrzBJlQ/CmV0P2i9yjjQ5qNDFsd2Z3Kyo
         r9N5kIFxx5okxv0IzSCmD/p8lDS2973h11PnfxAq+BUBRPuVrAZMn+dXU3oLn4lEznAw
         cj0mdpQWx9t9CY1EosLVHehqDxPx254JfPlXImpYfVyXZXimnhbZxrv1WwVY0qgy8+B6
         f2WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783511845; x=1784116645;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=hHdBgQ4YRaAM8+nMh8X4NWZFsOQZElrCph3RwF75yXo=;
        b=qQC3XExELV1UHT9o9yBD7NEm9CJGQ9iWSzpg7UNs0HH0M+jqfcafIxSanhVAv4RWkp
         uV+UtEQdox7e36jS5iNyQ6PkBWtjfi3Ye/Qhkrh7OvRlsRPJOukAPJq8tDcZECv1Pn8t
         2840fTu7xWRwmvPBHBW/5ujBT95a+CGNu1vUUwSAmQLiV1Jv8te+4r3/aCKhOE4opLpY
         1dODLyvePXvKnQelTit/G3eu0pdKwtlPSls1JDWVsPy8JkQOfmDVt1lKClfehXraUcJg
         EN3Aji9gCPDwglHXIi+UMCy+vtbxPhMh54Q+4B9tQrtfMt+Q+FBEA5LiQNA5kiD2BDyR
         UQsw==
X-Forwarded-Encrypted: i=1; AHgh+Ro4RJt8B0xdzfVDeZJQM2ODVdjLV7YOpNvzcOHTHoEF0sR9vpkB6sfFb04qdx+JCW/hbUV4h0t80w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzCXxI63/kkppSa9WcXmY6IT/3N2rHhAk77XUwKFZBVRge2vcLY
	SbOTgVe2aRh11VVGyofLh6/nZoGRYCaCeL9Ch6YRrH1FxI3xBj5Oq0Ycvb42lU4k1ufOFsP7vb5
	0iJussMk0U0dNzg7aUIGJ3gXpZUWJCs7Bavio3oIt2Fl4hcDFoVzZlsJoQgXSzIn6NiIVYw==
X-Gm-Gg: AfdE7cmMC1UoexaXMuUUL79MFi02Wl3/LJ6/MTRIpFtoLhQ69rnXPRiF9YWuqcYQpJh
	ERzS29dWa4e/j74UjBCCD7nbI5BzraWznaSWGdQ0YT+NW9DJ2Ai10e1RF0sCssSU1PxhbT8Jo3P
	Uc5+1elFaEXvdgcfHQ96nsmIWVaVVRnzZv8xLIwAgPPsl7hwMPrVFWZyt6OZ6uyw5mAkHRCcLGL
	wsj5vGsQRHkkOgWVa4Q8BP5F49OgLRlgtC01jN/PAMuaSxA2abDAeizohcOxVMV8cEo/UrTlf9Z
	kwt+rJk29u3moW9I0obWtmq681IyaJkwv9VFLzA9I5dIXX4uBL7Efr+zTuGQpWcTjhh1FWEHGPx
	AJmGGCmbVPPhRCpU=
X-Received: by 2002:a05:622a:11cc:b0:51a:8c9b:6499 with SMTP id d75a77b69052e-51c8b40bf87mr21608821cf.61.1783511845186;
        Wed, 08 Jul 2026 04:57:25 -0700 (PDT)
X-Received: by 2002:a05:622a:11cc:b0:51a:8c9b:6499 with SMTP id d75a77b69052e-51c8b40bf87mr21608481cf.61.1783511844639;
        Wed, 08 Jul 2026 04:57:24 -0700 (PDT)
Received: from hackbox.lan ([5.12.73.156])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e0f3318dsm121284385e9.3.2026.07.08.04.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 04:57:23 -0700 (PDT)
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
Date: Wed, 08 Jul 2026 14:57:20 +0300
Subject: [PATCH] dt-bindings: interconnect: qcom-bwmon: Document Eliza
 BWMONs compatible
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-bindings-llcc-bwmon-eliza-v1-1-3c7dbcbae87a@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAB87TmoC/yXMyw6CMBBG4Vchs3aSgkHBVzEuaPuLY+pgOt4i4
 d2tuvwW58xkyAKjXTVTxkNMJi2oVxWF06AjWGIxNa7ZuK3r2ItG0dE4pRDYPy+TMpK8B/a9W8e
 +a1G3oNJfM47y+r33h7/t7s8It++QluUD/VxJmn0AAAA=
X-Change-ID: 20260708-bindings-llcc-bwmon-eliza-b903d985e15e
To: Krzysztof Kozlowski <krzk@kernel.org>, Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abel Vesa <abel.vesa@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-bc6c4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1413;
 i=abel.vesa@oss.qualcomm.com; h=from:subject:message-id;
 bh=FUXzDx/MqiII8ZYGHiC1f7+FAeVodk7UbwWT+31SNcs=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBqTjshh+J00qB2eNZSzeutTwk0f8X20DuUsz8nw
 a7GNWPC+ueJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCak47IQAKCRAbX0TJAJUV
 VqPQEACx4mNaOxvWdzfrJJPyaGPCcaxAx3IHGbzJohk67QYHzC23Lx/f+NohNkq92L6kS+wTPXX
 VavhP/VEENW89+yNxyT1doNpj7i4cd7JGe94R8WwsW2UA/tYv0ZRa4PNCQ4QatOAAIKZjeXYu5i
 xFZRL41gGzhf5IlDhGKAK+QNW0/rlI8UDyaZbxKZKbSX/Q4mlAo/wVBgi8FXYknWCWjY1IPx8HV
 a6xOaluJ8FAvlQX3NfXrU1B0LeVs2iY0/bhu12RYitO8dO8zmXkgJJvyFotCPK+rQhuMjDmitcD
 jTkpmeEHo/4zjjVWzWIEzfPT+DNq0MyKvPH1cNR5wZCxkaNaSElkvP5EegxGMziqEddY2c4/hb0
 PF3nbkXozEM9H77KrTIsYgfbfqGBjxtbpS/+6IDEdNyKqnomAvSg4BmJ9gUHRpLq+Z/keO5FD8y
 4lVDU/yLYGvEMYmPmkzLjzClX6WQRsqhcMWJmvXMRdcbn0vSKVXCBGtrl4Fayj+pOFX/RsdjM3l
 kzpB5sM9aILfEx59p/GdNvpNjfIidSlIf+Trx112qQ0ZDPRYxYTAL6I0tH4C9ipG52DhigacJxc
 PYeN6tXgjqQ7MuQ4snfrxaR++nFhVlu2oP9IkMQ+lk+AkIkbbrD3StsgmXJMW2sMDRE3WOBcfXy
 RPtHIIFHKY2dl3g==
X-Developer-Key: i=abel.vesa@oss.qualcomm.com; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDExNiBTYWx0ZWRfX9uRyr9F4aAww
 WoGuwYZ0X9V1+BeznO+ExqXJQamqysClYXOlNNtHRehRovt1IbFJX9/a32mp8EJNR+PmHskZSjX
 aQvIMGLStIOJWOwG/U5E568f1i0GUac=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDExNiBTYWx0ZWRfX5S+JXXvNoVik
 g0lCHKomFi40+cyq/MQN6C1hGY1lpqlKd9N7Fluvkug3YzqGZqLUc4YprkAwt39UiYBQjjIdBI+
 MEkSfFo78/0xATHRQFUKVWvVv+Y4dlaNE7dRGkh4M9es+g8ydLtXy3LmhHE5B837B0hfJlpmMtb
 bieHS1C8D6eAZBMQNmN429TrTi8QgHqKz2iUJDyF1HJvW0qFLKT5A0dORH8blqcZlSbK8aVdvw/
 OIVvkPY02qwY8ojcAtZoAMO9nt+kv9lW8IiY3RPU5fQCYelwxyvWTZPWp5rlPcc4qgEjrxewGJS
 IZjhxaaDRnVM/ZFmTMb/Llr7XJ8CwK5gNKjKPsNiVFGY4/adEA+klNZfCASHM5ya5FQwYdtU+4b
 9C7kZicVzaU1GyLhXd42t3ihDPCr5atV4SqrCrG03HI48y0/Bg3N/z5W9Y6TuHD1pdXj3lU2VXI
 N4Y10ZiM5dg2gEC5eBw==
X-Proofpoint-ORIG-GUID: gDT36-pkUXKVsAfmNZWd1AcQYR2er8MP
X-Authority-Analysis: v=2.4 cv=JLULdcKb c=1 sm=1 tr=0 ts=6a4e3b25 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=qUYP/O48JsHWwiZSxXr1NQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=_bAYtE0Crml8VzQeUhIA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: gDT36-pkUXKVsAfmNZWd1AcQYR2er8MP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_01,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0
 suspectscore=0 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607080116

Document Eliza BWMONs which has a BWMONv4 for CPU-LLCC and a BWMONv5 for
DDR-LLCC paths, same as SM8550.

Signed-off-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml b/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
index e002e70580f9..66dfe70a8c34 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
@@ -25,6 +25,7 @@ properties:
       - const: qcom,msm8998-bwmon       # BWMON v4
       - items:
           - enum:
+              - qcom,eliza-cpu-bwmon
               - qcom,glymur-cpu-bwmon
               - qcom,hawi-cpu-bwmon
               - qcom,kaanapali-cpu-bwmon
@@ -46,6 +47,7 @@ properties:
           - const: qcom,sdm845-bwmon    # BWMON v4, unified register space
       - items:
           - enum:
+              - qcom,eliza-llcc-bwmon
               - qcom,hawi-llcc-bwmon
               - qcom,qcs615-llcc-bwmon
               - qcom,qcs8300-llcc-bwmon

---
base-commit: 5c73cd9f0819c1c44e373e3dabb68318b1de1a12
change-id: 20260708-bindings-llcc-bwmon-eliza-b903d985e15e

Best regards,
--  
Abel Vesa <abel.vesa@oss.qualcomm.com>

