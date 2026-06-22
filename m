Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3995035B650
	for <linux-pm@vger.kernel.org>; Mon, 22 Jun 2026 06:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782108165; cv=none; b=DuzQRmPpfDiGDavNN2acsS7O2GhD4uVTklkgAFYFhZOzXhuV0fMKPgVE4R0AaA0epEGbqsx71soPmFZ7/Whj7nvydrGJ7a4K5OblK/E8EH3Y5TN2KDY9kGevvw701/aJpetVYu8DRo+WRBH6hpEAzFLGgqaeaIFHBNMlShDFzaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782108165; c=relaxed/simple;
	bh=fhF1jkIK148QJRPMwgMFNLtsyUT0Tq6j6rDts/hWXk8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p2QXm2wgjVhfqD4uoItzN+pJ2EboJne1wmoCqFepMRxjqIDefj00484kK7vUu33RKyIV+xSiUoLEyCJ1bYU+oNCs+e4kRe+skpZ4mG8XZgIpQjZ0LdX6oMhrwv+4UYBSKWjmxofgcMpYQBoktRnAeMe6Gw3pEfqEhZmrSDee6IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=I2zZHh19; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ktIt14/h; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="I2zZHh19";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ktIt14/h"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65M5BX6I4183483
	for <linux-pm@vger.kernel.org>; Mon, 22 Jun 2026 06:02:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=fhF1jkIK148
	QJRPMwgMFNLtsyUT0Tq6j6rDts/hWXk8=; b=I2zZHh19VpeyrTBrzHyPcXUJCoJ
	OxAwhLJSCD48w/Uiz+2nYqkMuDLIy8928uFQawDl/7ZIfOQSQXoPNzhp2GXCHmPY
	szMyEtOPdUJ8VFGIq9L1oMlwe+aCkuWS/CE4FosGmI+jiZfL+Mzyoy2z7hFWumfo
	1chvL9sOx0f/hBj2rTiS7WpVsU67Qk0bHdxFwaRpRKwO6xaPRbY3/DABOCFtMzng
	TCNqfJlWmIbkAl1KZnmYvpn8ooaw0tee9+pkQWuKTUB1iNi9QRDKGbB2yAtH3n4C
	uWWRSyrWboTz5yzPO6umYoPeckI7JWbuZxh5FK8TvTqm0mQfo/QOkKz7cRA==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ewj6h51yu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 22 Jun 2026 06:02:43 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-1399e7a6d05so445638c88.2
        for <linux-pm@vger.kernel.org>; Sun, 21 Jun 2026 23:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782108162; x=1782712962; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fhF1jkIK148QJRPMwgMFNLtsyUT0Tq6j6rDts/hWXk8=;
        b=ktIt14/hhlZNmWYZ2mAw7hzbmRJPV4eYb2/ObDPHJwZKxJ/gE+HhQ7EtyKELhN9mu5
         0/qSibrAfcy0HtJTSmDwCkaQG5dd3mdqb6SegcF12hrrzPAto7q69ORWV+byIUQyNozj
         UT/qSEp226D5AAKHk9i6gQEYjHOcBUtCrPd1RpXt4MTL65cOBPCEMyZadGbgxUEQ3xk0
         EfVeXJ7krlNE5NUOH2lWwJZJru4tpqUyeyflrnFMhYb/J3CoDSwe+DkdihEttBYp+h04
         3Ln1PmIapeZBoWic0mAfrMbyjjwsr1DrWFrRxgV4dzzr9pmkMC4shhFWFXFI2c0OeZqU
         figA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782108162; x=1782712962;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fhF1jkIK148QJRPMwgMFNLtsyUT0Tq6j6rDts/hWXk8=;
        b=Q/YVuCUWOsECdWgQkUhkNJhDi6/OXA4EHWhI2AXvX+m6LIxExa+qi5fdmtxK0LFeOo
         o1YmJEf9cpGLohXSjKaUY8lET3C+lINo5mgthsfdlmwQj9FonpbknnL/jYu2JRp712Un
         OcYPPM/zxQEXvNuPDwLtaGGGdX4RGpdtyQYpMWQ1upFYiEuxKeaFfhVpzedFU5c6Iosd
         shjndKNwwh8jnl+IViGlGies3cY1F23uICqqn72rKiK8+qflpSn3FElX1OVxjTof4hHi
         qMHqjOFM5JfsMdGaXY7E1PtZ9XIDn1MJInQQ33ucY+3ncWYBxn2/KqvC4OpdIRTAldwC
         zpEQ==
X-Forwarded-Encrypted: i=1; AFNElJ/tggV9QOv31KqQgJM7Ma2kY4DB3u2jrMjB7pykvMvSVLKv4esymX968aq07i7s72wJtlLsl6XxsA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyftG5G4oGCbhTjG2kKJ4BT5sq1tMLFLa4mHU3zWleppVGhsDxC
	MaVLPYTAG31f19fxQA07aEl7MjcW2zu0NPt3fBu0SPFfK8o5z9FBNzwVQd7ny5GYbDZlOGU6SiM
	EmaltAlEbAK0Jy7cukt9QGL93ywc1cI4t+XN5vCczXgpaag9P3utnQgCn87Xqqw==
X-Gm-Gg: AfdE7ck0s/kmIpS7E3MeyGaOcUKL5oNdyLK8fPL1xA9DLuuTvgxJ/9Fe6/P66fhSwXl
	juaSNu0HaNKKeoi5u7M4UbnG0LLcg0eWkyWNaKsJxMzDT6NnJJ9fu7xvB4iIt3MJe5bntFLOK3v
	ui4s2UK7WdzKTH2tMRC0m7M4FcAkzPt8wC5qsgOtY1NNoWZdNX5hpdUhnRVXw9kXlkI9ElCBbZO
	z8xIzNKg6tSHVlxSrcd0PRhrr+95hX9US406nuNOK5HVvrRDTm6nHPfBpcm7Teuf4u31BRAtUyq
	+cEbYVC+l2RFNJUnJWhjUvm/7twhIk+9Uxm5YjEZlCa1l537u9B/UxBZi6EZvBezNhJfpxZ836V
	vp9IlIbCw143fy+7K9dMmFxhPwCAz8pDV/iS5aPv9TfBfUVxxGzTsdp2B/nD0mw==
X-Received: by 2002:a05:7022:6981:b0:137:fea7:9297 with SMTP id a92af1059eb24-139a2035a3cmr3794607c88.1.1782108162020;
        Sun, 21 Jun 2026 23:02:42 -0700 (PDT)
X-Received: by 2002:a05:7022:6981:b0:137:fea7:9297 with SMTP id a92af1059eb24-139a2035a3cmr3794589c88.1.1782108161301;
        Sun, 21 Jun 2026 23:02:41 -0700 (PDT)
Received: from hu-weiden-sha.qualcomm.com (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-139add5bd68sm7558262c88.11.2026.06.21.23.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2026 23:02:40 -0700 (PDT)
From: Wei Deng <wei.deng@oss.qualcomm.com>
To: konrad.dybcio@oss.qualcomm.com
Cc: andersson@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, mani@kernel.org, brgl@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org, quic_chezhou@quicinc.com,
        cheng.jiang@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com,
        jinwang.li@oss.qualcomm.com, xiuzhuo.shang@oss.qualcomm.com,
        mengshi.wu@oss.qualcomm.com
Subject: Re: [PATCH 2/2] arm64: dts: qcom: lemans-evk: Describe the PCIe M.2 Key E connector
Date: Mon, 22 Jun 2026 11:32:35 +0530
Message-Id: <20260622060235.746205-1-wei.deng@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <580db7de-321d-4f4e-99f9-3c9a1cc5a3f9@oss.qualcomm.com>
References: <20260608091702.3797437-1-wei.deng@oss.qualcomm.com> <20260608091702.3797437-3-wei.deng@oss.qualcomm.com> <580db7de-321d-4f4e-99f9-3c9a1cc5a3f9@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDA1NiBTYWx0ZWRfX1VM+kJMlfMnL
 dFzDy6gb49YcwgRk4eGs0mUy1C+m4dEwFkahXoH9/WS4iGRFfVCS+Nj1C8R4tiRNov0cS5T4a++
 4Za36/grCrKu9dH5pHhe4m6SSKQw5IzTM5GFNV9Ryv3jN7loVqy5pTlLxKRZztCmyzzLMlqauh1
 kjdBQjklqljyiTxK+oSjA9eQUDXZnHj3HihcYoEhathlKRD2QCrQePlj8SnsmtPjQKY3DDyvMEL
 LV3xQTbyPCdOXcnXCgRajsJYOcKIJOD1sfy/UHFNNLZD1ZYAbUKlztWfR4cbDI30vxYOExRAs2c
 5e3ZC8UODbYEivi1QorlqGXTwOM3sOZsI49uuDVGlc7VChN60DX6Qm2Jb1Mr/+C5VbXkqpWYDKk
 Ez0zCx/FMK0MmvgNiAWQJOaA67xiPSQnTUK6xg9xj3TDoP9M95nwVFWuYXdPyU8UbybPTTsBv+P
 IDRfDQe3cTzKXh2CuvA==
X-Proofpoint-ORIG-GUID: gAWzU_Mf9cisX-HesF6xISw9z-kraNBP
X-Authority-Analysis: v=2.4 cv=E7P9Y6dl c=1 sm=1 tr=0 ts=6a38d003 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8
 a=wHO1jfwDuY-934FNkv4A:9 a=zZCYzV9kfG8A:10 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDA1NiBTYWx0ZWRfX9gvrcOc+74st
 78D+w3eTlg/nY26m4c1xoX30BdQQvLzPDVXY8Cb91yxLfvIVmVskzamKZkbQmrqEczEQi50c7QQ
 iKBv+2qWBhv9RfaWOO18dXFrvXHZidY=
X-Proofpoint-GUID: gAWzU_Mf9cisX-HesF6xISw9z-kraNBP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_01,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 phishscore=0 bulkscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606220056

Hi Konrad,

On Thu, Jun 18, 2026 at 11:49:05AM +0200, Konrad Dybcio wrote:
> On 6/8/26 11:17 AM, Wei Deng wrote:
> > The lemans EVK has the PCIe M.2 Mechanical Key E connector to connect
> > wireless connectivity cards over PCIe and UART interfaces. Hence,
> > describe the connector node and link it with the PCIe 0 Root Port and
> > UART17 nodes through graph port/endpoint.
> >
> > Also add 'compatible = "pciclass,0604"' to the pcieport0 node in
> > lemans.dtsi to allow the PCI subsystem to associate the DT node with
> > the PCI-to-PCI bridge device.
>
> Ideally this would be a separate change
>
> Also, b4 can't grab this patch since there's something wrong with the
> threading (multiple series in a single thread) - please switch to using
> b4 for submissions yourself to avoid such mistakes.
>
> https://b4.docs.kernel.org/en/latest/
>
> Konrad

Thanks for the review. Agreed. Posting shortly.

--
Best Regards,
Wei Deng
