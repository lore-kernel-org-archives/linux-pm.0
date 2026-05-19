Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147043F4DCA
	for <linux-pm@vger.kernel.org>; Tue, 19 May 2026 10:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779187834; cv=none; b=HfViYEkKSQWvKJo0rN4/g0G5J9vRYkKnnw+jMcp04c+Lmtp40IIHZfXJla6GvWCB20/xwG/tkvDirdvpWxH45ud1iNPMOqG/a8DU61HRwtJLQ1OoWpRBbDakMg0eW71St6SVsgWtxSZlZztx598Nv+EKyr8RDBse3Xuw9tDmK2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779187834; c=relaxed/simple;
	bh=QkBvjzgzUPS7j6rbYYt0+plzzSIJ+yEdKR2h5bans+I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ODZZIOA21Irwoqz4BqqcdXRLhc0MiQZzrKJyv6E+ckdPX6JKvZFZQTL5VWeuzH4qwdrqg1+IGoB6GGiq0k07ZO55dL0ecKzTbyltpKyUCR6H4qHV7Qa5dka5YbSJGtG+NGD4walb/7GAEFumYKpoTCCE+Jiz4xM7N5fQoWxiNfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WZe77LZc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MCm1EZo9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WZe77LZc";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MCm1EZo9"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64J8EXSf3612662
	for <linux-pm@vger.kernel.org>; Tue, 19 May 2026 10:50:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jD4A3DvHqusxb6pJNGa2ldrzXIBVdy3bObx9T0M3r9k=; b=WZe77LZctWPVbHmC
	vPpddlNZhWFfM9Ue2oc1UBvOf6pMrLYI3iJs9GYi7NuCqTtfXYt3mBhBoQX7ZVV3
	W1dWTqHETPMPBtHHPMrgq7Ulgquh+EqEIoTJwr/9hgQ+8/5GHyGnqSSZbvxWbtL2
	tiAOzL8AqIxAOcZ/d4gx5msq4HxeXLOTXTdiTrnKj3FUuT5zpUq4RDyqRJN5pk2O
	ufGhaq8giaj/nvs8wazW5NCli83ZjFDmu6wISfB1pbDnkrb6cP1e4Lr5iqhtVbNw
	Dw9+ZhV3V+km0ZZp4qXbpLU2UKqXMAai36mmQ7SQV0vl12x47NbSF1Q8mDvtPXFY
	sqKm6g==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e8m64rng4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 19 May 2026 10:50:31 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c82c477290bso1734420a12.3
        for <linux-pm@vger.kernel.org>; Tue, 19 May 2026 03:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779187831; x=1779792631; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jD4A3DvHqusxb6pJNGa2ldrzXIBVdy3bObx9T0M3r9k=;
        b=MCm1EZo9NZAdAp1loIb1RNLVY7iTL6Am5H9z/UGDVjlvh3nGzTTSVhcK4xXQvzVgU1
         HtkL63l7PQfDBUoHfdy2iGZeN6B+3PPnYH6+ANHK+oC60MW1iBwA8jG55ci3YUQ+xKLV
         7fphrFQFzlMeEWnSN6WWJf8wwJ3q5eKHUMkj3ZOK56Qs7XYt/7ZePr4fxCAm1Q6f6xUX
         bMA49qY9dUYK6wfJTDAfTS1LRx5gvkw708bUa9H3YYtqENUUYYipIk2iV0e5BHh+z8+2
         tm8Ao6YglCVJdAwF/uyp31we9HF/1VTQ/WUbbiDT5Nws0Hts/WeDGgoltGfADhj+xbCc
         8O9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779187831; x=1779792631;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jD4A3DvHqusxb6pJNGa2ldrzXIBVdy3bObx9T0M3r9k=;
        b=imR21P8pIww0om9iSEQpsrdpYOTKfylEr/l7BSrOn2LW4yMw9//1aS47H9XGhEK2Mt
         /M/Ikgau9IeCf/690HsrmmDBTymZgevUJCLHHbbtL0WYicT9H0+8wfBAZEHS46NE+yGE
         00p8tBuu4/dM+v71ZsCpRLeETUDsw92izcU32HgmlGzYCrHxtVwO8U9dWlglzeJmnXlt
         Y4MCg3tBNZN4SMFcXrZO0GXorPG2MFRUP1JqZ1Dbs0pr5jQdGdiUrJJbUr5aRqN9I4bd
         n5U1L/dmoJEP3I3uxUBU3sWBxVbrLSKjbXhuytajP8jJ1eDLjeRAZ8wuFuMvBdkRt8Gc
         Vt+g==
X-Forwarded-Encrypted: i=1; AFNElJ/qAqGZS05iPSmxHJHpPftg5BGOsv6dLBS29rQ850XYBkV7svk51gLuaR0womv7KIdaoXT6We52Og==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3QLCwoUrn3hFSIB+mPxt3bMC0wKSqyUejRop77MShqLwHRiA4
	8yJM7lErihgbVpSslyK7LTVIL91A2vg6ojFnuP9Z0eZfC0fe9wWzCQKIrNT9y4GVzZTGwt3+jga
	6v0jLlPP/xHobMf9Cl4OTS8/p8oPUxJcIdG3dxyqJaZf0gj3Q5egH8SAjn7+UGg==
X-Gm-Gg: Acq92OE60Vqz39WCJiJqV1xRa9us0NhAhQHbnVI6CxhpkPg71BgLcpumT9lMn6pAId9
	x004+ELYt+oLSGtzs4VVOm1nnAOENgxsrSB/wREsX0UI8MTMtEegjYgceFZySkxESRTJHTd/RMU
	IRl7x9NQY54OUueVJ0/Ps0pSqpMqEHvyPnjE+1xZc1hlnzSoYXF2oPpky7+v5inE/vgl1BQrH6E
	MchvK7ErYm14cwS8uxMm5YpeX59ci5SA7JYmLCEJ30k6IOo8dt6yp3+Wux3G/P+11mE+1sP8dIZ
	a8vY3dVsZMPGQeVryM7kR9mPMlA0HY4L0QZzARuFSweDdvIYaR9a3rXzNy0xQ0DhrpUNSPVj/Go
	/sa1rpFziznXHzOe7il0vUo5spUq3nnhfnPYNCXBVf3Tlf0qB3PNN8VTb
X-Received: by 2002:a05:6300:218e:b0:3a2:bd1d:d68c with SMTP id adf61e73a8af0-3b22ecb3630mr22180406637.50.1779187831064;
        Tue, 19 May 2026 03:50:31 -0700 (PDT)
X-Received: by 2002:a05:6300:218e:b0:3a2:bd1d:d68c with SMTP id adf61e73a8af0-3b22ecb3630mr22180368637.50.1779187830541;
        Tue, 19 May 2026 03:50:30 -0700 (PDT)
Received: from hu-manafm-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f19fa869esm20877879b3a.61.2026.05.19.03.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 03:50:29 -0700 (PDT)
From: Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>
Date: Tue, 19 May 2026 16:19:51 +0530
Subject: [PATCH 3/3] arm64: dts: qcom: glymur: Enable SPEL powercap driver
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-qcom_spel_driver_upstream-v1-3-75356d1b7f94@oss.qualcomm.com>
References: <20260519-qcom_spel_driver_upstream-v1-0-75356d1b7f94@oss.qualcomm.com>
In-Reply-To: <20260519-qcom_spel_driver_upstream-v1-0-75356d1b7f94@oss.qualcomm.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>,
        Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779187810; l=1088;
 i=manaf.pallikunhi@oss.qualcomm.com; s=20260206; h=from:subject:message-id;
 bh=QkBvjzgzUPS7j6rbYYt0+plzzSIJ+yEdKR2h5bans+I=;
 b=kdvWLzdOynXwDBoB2O6Sije04VhkPQ32HFwYGtVfrdeV/M/jABz/cCEHZAaxKeeyGpWxv3tMz
 mbI5Yxlk7YkAjF9/AxW3B2mTSCZFacwYRr24sphwJ08M2pMuYIbXEr7
X-Developer-Key: i=manaf.pallikunhi@oss.qualcomm.com; a=ed25519;
 pk=oZ3x9jh+FDyPwxHmCbyzEMQHMzKqrH6hUbbL7dEBe2g=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDEwNiBTYWx0ZWRfX75Lm/7Hrns63
 rxmxqByDhapVNAa/ZHyLV2nAmG4N7oLgCOjI3rjLcFJIH617IUEp7/mUC8em7Qjps3cTGNxaBOW
 5SctEPr+5aBlSX7ncQf5zw8JxaobLVQzMozABXd0O1T70n5M0E0UkjB54vnqT8fbRGusSey3sUB
 Rch+BiA15Bsc83g/TqzPL/w3MfYVjHW9AJla5olLaUdd11xEX3rLYo86HlA4+g0QbaL75zJuTPh
 /RlfoSTs28znt6EqV9qwwnFHzcNF1S6SUBM+/DtIO0HLeGJV5zidWCG+UGhcmaRjt7NNsdgO/VZ
 3SZLgYFxwNgOv7a8CBSCaTYyO0HkdUvllR9rJx+HXOkuErQ2CyoiTCXvI1/RJ3kjiZUkC9kuy+e
 v1HxPY8gl+qd5uJoPmixzULx7XMSmKZo4Z2EbqwVvA7/p4rz6UcnruPGoDdtsVvnmsstsjkssnR
 YlIQx5bOpz2qrEiIe6g==
X-Proofpoint-GUID: DxOD0mJojzac2QmZHWyjXp1LNSrTfTym
X-Proofpoint-ORIG-GUID: DxOD0mJojzac2QmZHWyjXp1LNSrTfTym
X-Authority-Analysis: v=2.4 cv=J8aaKgnS c=1 sm=1 tr=0 ts=6a0c4078 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=0DiunMzU2dUnP_sjRnAA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 impostorscore=0 malwarescore=0 adultscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605190106

The Qualcomm SoC Power and Electrical Limits (SPEL) provides hardware
based power monitoring and limiting capabilities for various power
domains including System, SoC, CPU clusters, GPU, and various other
subsystems for glymur.

Signed-off-by: Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/glymur.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/glymur.dtsi b/arch/arm64/boot/dts/qcom/glymur.dtsi
index 72c7dc6e4f09..c0ba8740ae41 100644
--- a/arch/arm64/boot/dts/qcom/glymur.dtsi
+++ b/arch/arm64/boot/dts/qcom/glymur.dtsi
@@ -5033,6 +5033,16 @@ spmi_bus2: spmi@c48000 {
 			};
 		};
 
+		power-controller@ef3b000 {
+			compatible = "qcom,spel";
+			reg = <0x0 0x0ef3e000 0x0 0x1000>,
+			      <0x0 0x0ef3d000 0x0 0x1000>,
+			      <0x0 0x0ef3b000 0x0 0x1000>;
+			reg-names = "nodes",
+				    "constraints",
+				    "config";
+		};
+
 		tlmm: pinctrl@f100000 {
 			compatible = "qcom,glymur-tlmm";
 			reg = <0x0 0x0f100000 0x0 0xf00000>;

-- 
2.43.0

