Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10A14B716B
	for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 09:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792402770; cv=none; b=mPwcn7VslaPs54MsmcrQJEGfJbXjug12X7AqNt4odcFOvFPWRaqTaBSKCPXzmD+VwyGLOngJG5ynLGW5xanE/x9SF2gaQdeZWwEpTPXv4qAz7r2KNb31kdH+eHY9Pr2GjR5oGNXWBGIcCCJyu4IJX8qdyY5ekUeqn3m0ORd8EXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792402770; c=relaxed/simple;
	bh=c84dLn0TB4Eq5glgT2VM1SOLQznxul3sNGRaB1nurdc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TAzeo/LKA0Kxbv+mbG5WAhpqvS9A+Qv70XzwJBiyOzHS2OHCOXjLy+Witj1RaTxdEXQ0C7ZzNoMAtzVf7sDJVEM7QncojxIW7mQvpV2eOmRyK04QP7+TNdwxk1n1KU2Nf957RZKipsm56MLftcjb0MdPkUZoai8qiJl+8Z7u9K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=U4lAlwYu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CwhK4drB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="U4lAlwYu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CwhK4drB"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69J8Ou8C2752301
	for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 09:39:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=4qfL7piDG4R
	h9USRDzIt+sOlvyefKyWytxUWwXJiZms=; b=U4lAlwYuFzec8328ewD4N7V9i6X
	RMgaqq+O8Oo7RV90hWDCKKR4MLNLD54z5QV0mUmudBvJRHDUs8GvmY6DnM9+2NW5
	mCqV4YCdvDYHiA/tHNjqwb3OrS+YN8JBx0U7TEBasWvtx+wRsN0rj86LVajAz6Ck
	YB2ve8wg2X6vKocKxZ2PTOK/RNtaB1gpToQVWnTh8ybh9BAV5SnPY64hNvgpzDk2
	+X1H7avsilf3WX0NeTOpisp9TZgIpUD/zH4e+/9FjIa3lATjYH7dzMAYVLl5iAkl
	kY+tj6npqKPHdDzYSAQQm65IneE0AoagioPpzkqcwXGO7VYQjNl3oJVDdkA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf48gduf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 09:39:27 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3ab27c28489so939311a91.1
        for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 02:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792402766; x=1793007566; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4qfL7piDG4Rh9USRDzIt+sOlvyefKyWytxUWwXJiZms=;
        b=CwhK4drBDY0HzCZshW3Pt5+iTgoJ+xUrMIPGcAfhz/2Tm2Pl3o5HgXGnxuKzh/XSWq
         WQEGbzO1sq3+Xt1e+dAJkMjRHzzjehaR3YsLI2Y8+RE15Fwl4LLjhDYgGlt+iTDbM4L2
         YMGEiwoUceJehrZdytF2neaZP0p0nK4VJ51f67QIc5kv6744xgi017UOfnQ06P+fjtiF
         A0rMHhUTRoFNEeT1gjVqSlHCpCoQHyKpzUa01NWUQhXG4V9FU2cXhIlhSO1fbMAC0eGA
         +qoA++UcPaRB99ro902o9xmCho9Z+7fCZ9mBxI17xZGAeU8L6JPB747dcajCPmzC7WnK
         nMPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792402766; x=1793007566;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4qfL7piDG4Rh9USRDzIt+sOlvyefKyWytxUWwXJiZms=;
        b=vTYKFKxdPAQDbVa4ct0+xCPzlPkP+7PxYOKyZpZn9cVhfDVXUtkgFHPUC0b0bnGID/
         gSonBIFOEAFr5GjK8r5HAMuEnGqtBxHLVc2sVkU0c36AFAWmMzpMY10h9gxrzTqhhYsr
         L6MY6KP4+j8gor8sQ2T4Lf8p+c0Xl+fA5UHNdmBmJcfUCuV4oYRTOEkBw4wpu/HteAf0
         6SObWZzKH5Tbnkj253AD2eUhYy9RnhXJU/ItOsddgGvNCeQcpUrH7P8UKmyU74jrKkHv
         cCpebNhG8MrpjOWqkvT2xAvPQH9vJGQwUs9eBGGEmHn2yk1O7sNlnf4KnQ0+umqzwbWt
         lw+w==
X-Forwarded-Encrypted: i=1; AKwUvBx3oZUm0WZubFbczWShjIUDFN9WQfseQwNriIstRx1tPxrIk5avQf8gJxXKkF1u2H7iUgM+dKWWOA==@vger.kernel.org
X-Gm-Message-State: AFq9FYINRI9QL9wKJoqwZoNTn7EQ0qITnWTtcH4a3q7vAKh+qDTqCREB
	gmlRXFK5hqovrpPrpR7UL8ZhN819sreztNVem8rU9IlD9mwAEom/IiRoclqn4Nc9+vNSLVGEd+s
	IUpm38vsUe/BaAJy3my94pmC3tvnYlImdzAoOxxEal9/b6B1OGOalhrc/gkVnrw==
X-Gm-Gg: AYBFou0BRrmzQRnDnzim5PxJD/1TfuGhCpuIipCC6c61zKOgwCCrkngK5CCtGHzVacX
	sjinXFVXwkY/pCRwVP/gvBRMh5hr+rGFFAktVGd6unIzW84z5zXrWmEinrpPcnvGytNdifM6H03
	575TeB28NHupD3Q6KOde7PlCVyiApYz1UM7x94pVwpoRYf0hTKmb4d3yiX0bpba9yV/L8MqrA+x
	QwR2bEQzJ1H0fROfz0uhAIIRXV8ErrtiEagfp/CkNMiEyZBAuBjub3VHwsXWVcmY5SSXsRPI+jo
	LLTrPraexQ/lQfjlqawm0IjXQz5yb6VzFSBzL4rTv8ToOGM7ZkpyLyhSDvSmXw21RNH3a4KWqLt
	LYkOAjm0jKY3iRehC45TWfEoXXKUK
X-Received: by 2002:a17:90b:1845:b0:3ab:a188:b898 with SMTP id 98e67ed59e1d1-3aceea27828mr9020711a91.2.1792402766528;
        Mon, 19 Oct 2026 02:39:26 -0700 (PDT)
X-Received: by 2002:a17:90b:1845:b0:3ab:a188:b898 with SMTP id 98e67ed59e1d1-3aceea27828mr9020689a91.2.1792402766058;
        Mon, 19 Oct 2026 02:39:26 -0700 (PDT)
Received: from sdciot-sh07-lnx.qualcomm.com ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac94627250sm19758688a91.8.2026.10.19.02.39.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 02:39:25 -0700 (PDT)
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
Subject: [PATCH v3 1/3] dt-bindings: regulator: qcom,wcn3990-pmu: document
Date: Mon, 19 Oct 2026 17:39:09 +0800
Message-ID: <20261019093911.3199891-2-linghui.wu@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDAzOCBTYWx0ZWRfXyX+7dIHTQebQ
 IqPIiqMVWDiKAJt/MrCm4/sewKcH6/lxaIodrMuHr7eLFX22DZgkDrVGG4grVNmrGUfNf+hSV3K
 DbaZte6edUPgOf2Sz98MrArdN3P14M93D0GNyb9JUcHBaDZ+JtjaMsWvW/Kaz1DXgzpG0ZgWGgG
 ZXsED14r4Lb0geWHwR/XbSrT0ir6WlYVxOGaSMw2DA7KQqN1F5QuiU7uSJSQZue1NJoXMJuRBUr
 AyQs8OAM59PeZ9zf4RVAQXvizBZuX2DvYlXmtm9Fk/N1NBYZz2R78rvZ7CApocrahxHLrWC846U
 UAW6LZkP3Xz85CeVlGn6gLCCPfUOF2gjvZQfNrPPVQYXm2+iRkniEV5Lu5VIyDtEON7p+Z0rOi1
 vHz0EQxdL1ubzZOLgDHyEWPDVTmVee9gxEudk3q1J1wjl8IDbcHFxcyDOnOZwN/fNvLX4ijJhVk
 GIjv434gEEghLcXk1JA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDAzOCBTYWx0ZWRfXz944H8bRUYnu
 nLrJxHDsOQRCBT1yFMgJAMwDKzWwjpB7xMByVLJ5kx0kzrpWkrf3Z7OQMIR3SGkDB7mBYBGr7fl
 WOQmPSIYyOUoUWa6OqcdwrASNOqh28c=
X-Proofpoint-ORIG-GUID: TeRm332mM1o0oknkH-qVDOUdCHBUB_2F
X-Authority-Analysis: v=2.4 cv=Qr/LTlyd c=1 sm=1 tr=0 ts=6ad5e54f cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=brVOnVl_E7YOJ4RIXMgA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: TeRm332mM1o0oknkH-qVDOUdCHBUB_2F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 impostorscore=0 spamscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190038

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
