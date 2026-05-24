Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565822F7EE8
	for <linux-pm@vger.kernel.org>; Sun, 24 May 2026 18:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779645824; cv=none; b=UjMEwUw6HYEd4zkLznZAW9cibXu+9Z1d3r2eh0mwdAUy6ZIS0y9zjO0P1WL8PK5DME+bk4SeZcgDmSM7nCYAoVYRrhTVfj53ENTPQqLExoQHoXg+P6Qp2lo1fhTN/q8oz1TgmTf+31k6ApoR7DzMwh1y7KNU/LNHNy5QqnPqvEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779645824; c=relaxed/simple;
	bh=skCGxOgaz7scnCaEUfPg3Bw6m/3s2NMMlyoC1wxppBo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=crSM3aef9+Bw8bWDhnjVeFns/9EMsfEmO4/sFeU/efLEd+E9PPWk5GV/z9cQebcpExnWRIPnCluSRwjjAdiaeGJPK7iUEAN0slg5XxAr5XWYsNgPdQVG78yC3kIMfdv0qD/9E7M0hQndZwFJigyEAgcQkXIeQzHjWLk7140mLbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gb0yeSzU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MyNUSiWd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gb0yeSzU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MyNUSiWd"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64O0jElu3505255
	for <linux-pm@vger.kernel.org>; Sun, 24 May 2026 18:03:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=reEe2mjqmOyuqKZeF/4uc0
	HbKJY/S/Q3G/fnmXlp3uI=; b=gb0yeSzUeOZJDL9TQiiEWCJpgd95YzZVtyoir6
	gAbiaS32KpH6yVzYNUQmQJTtOLiP2oWRoN7CqkjKCGEdL4ELfXCm8Mz6pDi6N3MR
	47v6/0Fwf33q1o4KGe2s02oj5VtONsbDjRPdHtngBkm/qF5Tm7s10WHIv4C6B0Lw
	Zn1St00YX/4dVzYTOdnxZoFtheH80czy+PHghN2BnhpJIe10wzmIHZ0OMy+n8tUw
	+Co4wZAJZXXKBa4Fi3CznFBW7mGYov+6gxPGjlJRgReoK+0THTKO99M4OYkHLDLH
	GipEgIizdIo3KxmbpJBWfGHgvjYvo3yDJZgXpAsaqQyc/bWw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ebba0ty6w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sun, 24 May 2026 18:03:42 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-368ac44b26dso7710233a91.2
        for <linux-pm@vger.kernel.org>; Sun, 24 May 2026 11:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779645822; x=1780250622; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=reEe2mjqmOyuqKZeF/4uc0HbKJY/S/Q3G/fnmXlp3uI=;
        b=MyNUSiWdrDOTeV1aQinOhBgxIXi8JMibhwzTMnY/w6Q1+1bf89zXNO1+p3u+yUSUsK
         7ep/FvcuA70h2zbxmoWuxJ6l7bn8QTdV9ZRpZCKlL0UBteIB6hA2oi9PrydH3XKV5ben
         8szSkrdaJ2ZA/EddMI9+ZMMco8M15+tmKpRs7mFxyFsALoWLdq/iTKzIFqMe6sjaf3Ob
         p8Q3MLSdtVPME3AcXeQRBlanDJjFzqQm5+3eOxdBd0wYEP/mMKdMaVtRCszeO69GA3UC
         xhCQmfQMfYa+FC5069clakkhAiljk1FAUUjz/nkKVQsz6eAP5KodlRAiunCiGXXU2KoN
         /AKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779645822; x=1780250622;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=reEe2mjqmOyuqKZeF/4uc0HbKJY/S/Q3G/fnmXlp3uI=;
        b=OsjuQ3VU1Gpv7JBkqBUoCqF4BaIFQmpRAxxWte32CWNYynojxbQw2HAlkHvagFSLAC
         yRb20eMRYrad6ifRyQMrKgbzOxqHWXLbP8c7+e5szeh9xlW8pJ3e13SDcre5ApaETqT3
         zOuEGeN1wmyU8ruqoM/wNn9Q5FU9HfZO+3xysWuH+Gdhh/esyq3Os4g2NB5dM39Y9GbY
         iVgEt9PQKgZ+5zjDfsyxBwZObfCeBZFRNHoSUmYp+6C1rGLOC8yqrUZUclIc1CZno2o1
         Qljuaq2ezjmuki8gW2yHEJiD8ImxI85j50re+hJl4zPGJvitr0s/j47ePyTQoUU41Tua
         qL6Q==
X-Forwarded-Encrypted: i=1; AFNElJ9MP2Up/VGA1uAobF6BKxcdJOmPPoLsu8ots1SxIsXImUA48AFhc2jMU63XbkUFHFrvktGSoODzHA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh3yn01u1lS5g0Piaw5BHTio0ZCOrV4kN2gy0MKc59O4kC7pqq
	SD2nuQx7H/WojLCYyNgIVMbRzySxMisFE5JYrY4yJLpsi1WhQdB58KbfOTveJMfX3cRohmNq6Yo
	zyJAFWq2dxnNac15QIqd/AxvRtx05cz7Iqgr+2uWN5JmTA7tNCeKwk+kjgRJp8kcddhJEVw==
X-Gm-Gg: Acq92OHc+kQnExZlm8cUS+2sBGzOeolOZiNcIQa0XkzCy8991LY9dRaTAZCsN0Uwcqc
	MAA5mUzmv5/vXdsCy93m/UTr34kQ9sLqfs+4zCrodPHXWWBbCghvhn8HDZqWfh5m+XSxJg1bJ9L
	hTnHotZVINbu2Y5dvozfTQF/tInoVpzkksgsraOz9QK02GWLT61OmpX9Y1lnkFkJWLch+D+PRlc
	+taEvjYEKALRyn7fFpgCmYq0nhvBGQygHVcUH0hJsPSdTKAeK2zZRlleH2lnlZAeJF+g4fmBT0N
	fWwcOKDCqT+dSrd6osB4mNlGgA3XWzmZhJcA7uHSRhmKssAhi7BfiWCIRGeRT0isJq7nQbYxi2i
	83gEdTLrZNFQH6oYev1XVTl9VW7L97E4QIJwQcdEaWUvw
X-Received: by 2002:a17:90b:238e:b0:36a:7127:d9a7 with SMTP id 98e67ed59e1d1-36a7127e0c5mr6982264a91.14.1779645821865;
        Sun, 24 May 2026 11:03:41 -0700 (PDT)
X-Received: by 2002:a17:90b:238e:b0:36a:7127:d9a7 with SMTP id 98e67ed59e1d1-36a7127e0c5mr6982250a91.14.1779645821350;
        Sun, 24 May 2026 11:03:41 -0700 (PDT)
Received: from [169.254.0.3] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36a726348e2sm7252659a91.2.2026.05.24.11.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 11:03:40 -0700 (PDT)
From: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
Subject: [PATCH 0/2] Add EPSS L3 provider support on Qualcomm Shikra SoC
Date: Sun, 24 May 2026 18:03:34 +0000
Message-Id: <20260524-shikra_epss_l3-v1-0-b1528a436134@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHY9E2oC/yXMQQrCMBBA0auUWTcQx0TEq0gJSZzYqVJLphUh5
 O6NunyL/wsIZSaBS1cg05uFX3PDoe8gjn6+k+JbM6DGk7ZolIz8yN7RIuKeR2URfSKTwjlZaNG
 SKfHnN7wOf8sWJorr9wK17hyJRKtyAAAA
X-Change-ID: 20260524-shikra_epss_l3-522afe4fb8f5
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>,
        Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
X-Mailer: b4 0.15.0
X-Proofpoint-ORIG-GUID: ILcnk-fIyAG6ABRkKZn_NSOIv6fBzdxx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI0MDE4MSBTYWx0ZWRfX2uHtJSQqE+rH
 9bpDsNGXg61qQT//GJFWgYZpRjMyVoxZkLBy9hL+j9i0r0t5kw1D//Llb6J0UkLb1LBw9FvHeBy
 aMII1LCSXTnfzfnxyidR1UYDdqZ8ofvUtusizAkN3PkWa4wmLuRl3MuuMZiAgJkwwvB0L1NIm84
 1YF+2Tir5loLaSrwxt8ztxwHen1ytKbkie4uTEsozCoEW9YmU3pbrwmtHP4OcjK84KZ2+RHVcA1
 jmvzWH7Qh6hmkN9jSeXj10efD9qg1OrRtTok7wk3pL3uU82aY2Qcsdk5Q6rKjkJmoLSa5ulTySu
 hy1RjmvK2kt0cUHsaLP2KUEziRKsPTR7+E1WnUz8ktsueVOxW7HpEuMrfG0MyCVsfU2VTSYi1t5
 gjtpOq7CZ04PeWeldy/zMxVrDOtW0UgWpbKmqf9ZiDA4n7jx2pciEh73ZsccHbthZ67WnHHK/tc
 AuTlPW0kpjZlppo7zqg==
X-Proofpoint-GUID: ILcnk-fIyAG6ABRkKZn_NSOIv6fBzdxx
X-Authority-Analysis: v=2.4 cv=Xca5Co55 c=1 sm=1 tr=0 ts=6a133d7e cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=pzfQcldl9xs5PnSv4NYA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-24_06,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 adultscore=0 priorityscore=1501 impostorscore=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605240181

Add Epoch Subsystem (EPSS) L3 scaling support on Qualcomm Shikra SoC.
EPSS hardware on Shikra is similar to other SoCs but supports only twelve
L3 frequency entries (LUT). Reading the LUT beyond supported frequencies
can expose incorrect frequencies.
Introduce new dt-bindings and compatible to represent this constrained
variant of EPSS.

Signed-off-by: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
---
Raviteja Laggyshetty (2):
      dt-bindings: interconnect: qcom,shikra-epss-l3: Add EPSS L3 DT binding
      interconnect: qcom: Add EPSS L3 scaling support for Shikra SoC

 .../bindings/interconnect/qcom,shikra-epss-l3.yaml | 60 ++++++++++++++++++++++
 drivers/interconnect/qcom/osm-l3.c                 | 16 +++++-
 2 files changed, 75 insertions(+), 1 deletion(-)
---
base-commit: c1ecb239fa3456529a32255359fc78b69eb9d847
change-id: 20260524-shikra_epss_l3-522afe4fb8f5

Best regards,
--  
Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>

