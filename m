Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793008222;
	b=Zu50N8vRpPuFBcLIG4uzh+sid5ciSS1cYhzTQ1jAgoFxMwv2kLzHlKJTKzlaJOMkt9bu
	 Dc1FNexDdzrnWHpYZPqj+SDp9kpT2+P8CyHhS0wU7JHM/s3BuY/7BCnrrBp7uZwQO7wmO
	 bGLpJQI/wA1T8PLxeD5JuO0NRy7xiwYmviPjENXHYMQrxG++vhPbdl+1xTgP5WteJXHQl
	 oGpwLqO50FDiHCPmv7PuJJDCRJ8TwW99UF6I5g3qFozxFT+MLyCV6ncG/CkAFnxQXGugd
	 1YBV5/WcqjbOgqOdsHq6cgWsBAkEyS4Q3JV4V/vIn7sKRzDdPouCbi/J9jjwhCJd7Mg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793008222;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=zKX1jeaJXKjVB7lhiiifJDbywGu1ddtc70oSnHfUUaU=;
	b=LYE/IOkORT61Z7uKvDfmKdRfrsVOQMLx1tqaAmVbIneaXkPGzwf5i2Lk6KlRGU4j5zrz
	 /+nZSYTOC0fYgDr2zPj/+a6xLsWfDaEItzYLVzODRmYCxrT8mRqvMLamnfzdeAvIUuVVs
	 L9HrX43qKFnsgpQ4+qMOWrV4ZICXC6FRhK9M7b83/l3F0vsebltX7P3JU8L/PJ7VLu/Ug
	 GLLLmwsaPtQ+839ACes8RA3OJZf6s946wBPu0xhr5C1mmoKn2Ij6j+UroQWu2GgmXTXep
	 ovQwRy169hbkwMAW2Et6Yuf2qgcBZ5hSGaslKfYf55bhixZdAooUuCnHU7SeNJHBgUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=XRVXsrOk;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=JiX0fFzg;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E03606A321
	for <linux-pm@vger.kernel.org>; Mon, 26 Oct 2026 09:50:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 19E03606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=XRVXsrOk;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=JiX0fFzg
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69Q4auvq2727072
	for <linux-pm@vger.kernel.org>; Mon, 26 Oct 2026 09:50:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=zKX1jeaJXKjVB7lhiiifJDbywGu1ddtc70o
	SnHfUUaU=; b=XRVXsrOkESbp/cCSaWJSpjFpCVV2NlaUh7gPe17KKmW3HKIpf0k
	B68B2bms9+r2ilQzj1RjSNqPy87FrPtWESIpo43Xuyk7kZIxtrlgcllaxUQwEICh
	yre5PFns5T/ny2mwDdCSbyFTr7b0hyX9/WtUdNsU4xpjDDQLclxAf9SNvgv3X5sS
	7VaGsajlciZGW96Kgb+kMje1hkiqp6VclViG4zGGy9vf4t5rLFVOPsvOICioGx6/
	8MUqCBcKLF/Hqe/pOg20CXjJhST6FuwVtjZWH/2Lv/LFACiyMM77idnqB2RBFXNM
	Fnd1d9AoUqvydsk7QzBYav8NCmkEvYNdxhA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgkp6nwk4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 26 Oct 2026 09:50:20 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93ecdc701a2so358017185a.3
        for <linux-pm@vger.kernel.org>; Mon, 26 Oct 2026 02:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793008220; x=1793613020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zKX1jeaJXKjVB7lhiiifJDbywGu1ddtc70oSnHfUUaU=;
        b=JiX0fFzgcgd7yk06M+3KTwENidi6pxln+1J8unjOw9BYLvBD+Ab6iuRQO0n87fV5Lu
         P3HY0mkE2oxievv1ZRqfK+3wJDtY8Gt2a6qMeEyDrGg9Ivjn7gWEqKfhRXDQoflRs0wN
         2P6c5+uhyjYdbp5soqad+SRRZpGvi6j1QkZNWLUcLBrik7J9xrY07u1ZW1LmD8j+oXbh
         AhI/TLEAKdJY/FbEL13X8LvS66bUzJ3LSs3OFLIzhHdmTSBBeOt32FX+7IiIsroj5xWv
         xhoRXPGZg2inW67tu3G5/1ouhUW1syGzSAzJcsaZ4Fmp99ffPc6gT6hxZeY2Xt0xJQ4a
         JIQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793008220; x=1793613020;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zKX1jeaJXKjVB7lhiiifJDbywGu1ddtc70oSnHfUUaU=;
        b=k/NL1VA5fGQ5gl0jKzSTV+bV4M7sj/JRhSw0ppq9BC5pA20h/GBiijcLV5EXE/L+ui
         lq7FBRSXXQOoUc8ND0RDyh6bmPTA0PSMuv1b4pys5ipC82dAWvE62UbWZhV/RxS1mxCN
         65Gw7ru0yEOrxnm/gtJITRdA4+9wTh5+tOGGePD/K4q2MolgnYMZlxYm7o63qgwX2kHF
         MOo/ywCU0cIOfrD+wznzE+I3KgpYJMpGEA1Wue/hY+RsoASfN7dmBMAb3mlvVEkSiRJS
         Ch2dzJgdZUNs1UFBpgAW6p0/LsFydlX0N4v9u9l5JftzEzIZbRp33XqBhWl3o3FA746b
         NwuA==
X-Forwarded-Encrypted: i=1; AKwUvBwismSd2cbEbwLHA5oCdjmqWb2rwuoWE4FrsQ20mm0/IOfvC11K+DDcx8wndzXMkCX3dK++4Tr1Gw==@vger.kernel.org
X-Gm-Message-State: AFq9FYIPkZp50LUqqs6JEvKe7/vsuTx98C8bQYWcEjQh9c3xkqUGiAsJ
	rN31AfJY9VFEkFuFIlkvVnk0/gwhdrkKPHydsss3yuca5c//bnXV06xHwNPvaPOx53FfMX+/SST
	08LjnBIfQDj/tGkWKq/JKnciUsB3TFZ34gKgjDNnjkJQUcsXG8ufW4Tb/Hmv2PA==
X-Gm-Gg: AYBFou0yMq6+4JO8cPaReYQZ9A448sRcwi2sSkSCZSqT7X8wyaHKhEdLCXONnpKTyyj
	IkxEtwq+zdqe156hCMovS3ICOHKyZu/rOgePX1CkbZRM5QnI3b4BAZGxEWsnJFIutePWOZgc77R
	PFyJKqcfhYNyd32If/Wuv764RVp1I9mzmH2YZ9kdR5zwDhNY3SsojSKjLYUVcleEqEQGJblz/36
	psIusg/I4xRN7Yi/qwftR+36vqDZMdN5EWfeRqPda+dKsST5bH/YUUyl9QKXpqAYAGDUq40LiQA
	oOuYqOMCHevPF+1FzW3B8TqUBWaS378ujR5meccaQFvQxSiaSc0slvpGVcbSPe5etFvo9CiQg3C
	p964E1b5hOIKMMNIgUjkZDMHSnFM=
X-Received: by 2002:a05:620a:4509:b0:93e:bbda:dd06 with SMTP id af79cd13be357-940ef682ec2mr945162185a.0.1793008220173;
        Mon, 26 Oct 2026 02:50:20 -0700 (PDT)
X-Received: by 2002:a05:620a:4509:b0:93e:bbda:dd06 with SMTP id af79cd13be357-940ef682ec2mr945159985a.0.1793008219740;
        Mon, 26 Oct 2026 02:50:19 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:7d20:e20f:a77f:4ef7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebc3dcbsm15405472f8f.14.2026.10.26.02.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 02:50:19 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
To: daniel.lezcano@oss.qualcomm.com, robh@kernel.org, krzk+dt@kernel.org
Cc: Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-pm@vger.kernel.org (open list:THERMAL),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] dt-bindings: thermal: Drop thermal zone node name length limit
Date: Mon, 26 Oct 2026 10:49:56 +0100
Message-ID: <20261026094956.2323036-1-daniel.lezcano@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
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
X-Proofpoint-ORIG-GUID: 5-9bOTtjeNxXWO5zJG5b51D-ZzSQeiOs
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDAzOSBTYWx0ZWRfX/fDW3hQVUfdz
 bDUNpe+lFe2XuzbhW2upETBJ3c0ijNaa1xVr/usIIJCBbIY42mvI5C/t7cBNoBkkCW/74NnflgR
 0Pi4S7G+v8otgOt6tPQDB/qa3Szwzi8=
X-Proofpoint-GUID: 5-9bOTtjeNxXWO5zJG5b51D-ZzSQeiOs
X-Authority-Analysis: v=2.4 cv=bq/Zl0ai c=1 sm=1 tr=0 ts=6adf225c cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8 a=F35qRUJZQmyXIphswqcA:9
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDAzOSBTYWx0ZWRfXxAjv7yYh2Ghd
 H13RKpItsdbXfD4LtEFVZFPNjTt0mtjxYS08VmIwTRCMxVoG725Ys3Ce044qREh7KZBHAmjGurH
 BC+yU0GP+AdIUpQOOIj6h9R70YH6zIa1CTzQMayvcf6E5fxcVTywYJcieCoF6qrL57DkrtQpHB3
 jXT/k8/sKNhxzMlEzLNafaPIZ3YfwH/ljXcs0e+KHSbWKv5cr+5FOBaBMboKeuAfETLjMkgZ5oT
 WZGk9FFEw0NfMgGkamUK8AVSDimQKu6ZI6+mynP41Y5Q3gowZDuhVazmbdtGh27ioGmGL1Z2O2m
 SuBVPKX6OEPA1CWSlw1jKAe3wOUlSnO4YafGYzo5sJ8EPFd1Z46zE2EeO0+BI0CWIwvZIGIFKlp
 Im9rfAzdJu76iTwigAZN0FBypVBqiL5TyZMd0mB4m3XgnFb81Cq3tW0+UQoUcgET3advg4lO4/1
 5kZelW1LxjiYoAMWJtQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 bulkscore=0 impostorscore=0 spamscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610260039

Device Tree bindings describe hardware and must remain OS-agnostic.
The thermal zone node name length limit is derived from Linux's
THERMAL_NAME_LENGTH macro, which is an implementation detail rather
than a hardware requirement.

Remove the length restriction and its accompanying comment while
preserving the thermal zone naming convention. Any OS-specific limits
should be handled by the implementation rather than encoded in the
Device Tree ABI.

Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Cc: Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/thermal/thermal-zones.yaml | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
index 999ad40a20d5..6091e886829d 100644
--- a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
+++ b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
@@ -49,10 +49,7 @@ properties:
       to take when the temperature crosses those thresholds.
 
 patternProperties:
-  # Node name is limited in size due to Linux kernel requirements - 19
-  # characters in total (see THERMAL_NAME_LENGTH, including terminating NUL
-  # byte):
-  "^[a-zA-Z][a-zA-Z0-9\\-]{1,10}-thermal$":
+  "^[a-zA-Z][a-zA-Z0-9\\-]*-thermal$":
     type: object
     description:
       Each thermal zone node contains information about how frequently it
-- 
2.43.0

