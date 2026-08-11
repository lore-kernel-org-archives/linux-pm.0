Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7632C417355
	for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2026 10:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786445654; cv=none; b=HE4En2aECx9Pc8M4P1ca4qh7zcsehmrKbnj1dUso0Pyp4VD2hpmKA398Yf2NnuPNH8IS9e+6diQcBSqlWfGLmYxw8iZkdvZmxHU9vFzvNT1yJpdILKhLy3io/82uPsJlkRFzloBJinvik1gVsSOfnHPBWI2FBmM0bPif/MkEowQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786445654; c=relaxed/simple;
	bh=54hCdELmS6xZibU/cobdRnbT1HWnprpLvUsxGo5d5Vw=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=PELDxauHgs98N0koH93ofeNfEtBM6KJY/bX0ccMH+lrLPk7rub04o6+vpQhrTbq5sA86Yapqi5iZ1at93asr+FLUqGpnWcXy6Aw9yLG2DZWoSJCpEhImgegFuwyxf7rJ7wIPu54okGtRtJlOJ/RDHyXRUBdpJhOXM57rNSTUWkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jYs4na9D; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bjJPa5T9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jYs4na9D";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bjJPa5T9"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67BAM4Ls384643
	for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2026 10:54:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=qi1DTXj+2W/155zo0/nJZK
	RgSx9mgE2FLGDNwXgwGrA=; b=jYs4na9DrifneLYvJj25bUFici+ofr7wfMurj3
	cZ375t5IuQ69D2XWeloaWMyX4AFK4BZuq+6d5KeqTKKTmQTyf0GgyMWE0qVlcAwZ
	WVTVTI6HryU4N4gySQODe92paUZxhNU8iIFQPkMknSmMy14v+hk/BIc5TJQOv86n
	4SeSj+RxVEDHyTn/e1lNYHK1VWrdYGeGDAjs8XCmnnJ++6vGUXIetkACr9wIF2nO
	77Q1IYwzpHIUeyHJFgy74EydB6eAPm0CSvgapT8tnz1QHCA1wauxePl/CPptuo0r
	wDDk5a1K42w7CXXKY/Bm9kXPZdxjcoTA3f5Bp+B3QF0dJBhw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fyjk23taq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2026 10:54:12 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51c12e43b98so7706541cf.1
        for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2026 03:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786445651; x=1787050451; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qi1DTXj+2W/155zo0/nJZKRgSx9mgE2FLGDNwXgwGrA=;
        b=bjJPa5T9Lm2g/6Np546y0YmHyNjmrIUtCaXKVjcn8mA4qhF7sAhuR7qlbFHqEE3/M3
         Pp+Tx3fzEGQIN93MI5dd1p+yM+Sf936NneiIskHkmDZOtRvkUCBdZ0tOM5aaEnJ/FyXf
         gQbmepKbk25lhh9gAhAC3BLCjx+nRy5shwtODtXoYgPlb7/MUK+m34ywNarbmihNXoZ8
         GUVH3MUQa/RFapcUPJMQSCYqIcbZUJxr5RdcAmNBSn+M3dQQAqYa5CoJ+CygC78Uofac
         hQAPsditJZZ/qLj9yU7FWhPJ4ilxlsNUsYkuLkvPX6G2EpBbX2Y1GaLWQfypfAhqZeJX
         v0Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786445651; x=1787050451;
        h=content-transfer-encoding:content-type:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qi1DTXj+2W/155zo0/nJZKRgSx9mgE2FLGDNwXgwGrA=;
        b=gpLlngUSC5JWrTxZiRUEZTi9iPI33CCQIwuS5RY0cnpmfwe1UwQQPOu8MeWgK5Thpu
         cKC9wJc/XYEAVU8ekJkdcHdOwcL/E1TAIdP29AZOicD0iB97TR04UnLk8/UimBKZlBRt
         Ck3rSewUHvxyCORWg+XPoE/uTVsL00b0UBObVaWOFtlf0Eon7GcoSgrO41PDkglMtGdz
         pO8OYG5DJnJPq268ysGXFWAIfdad/mBLCmTN3xpFrCBDwgDaIJH0Xhoh1R62SNStunUp
         +gy1Jhvu1+WP4kblBVu+9POHeHHPlPR1LLmIziAf8lATZC2+/NSJsss3YW8AVwYm4+M0
         I9NQ==
X-Forwarded-Encrypted: i=1; AHgh+RrlXsUPqf4HU/DVrqFmaPUSMfi7XVFZ0p/yCkAJhgnTEp2OR6R/cS+klaagLvr87D5rKbP5nLeh5A==@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ//nLOFBbR1/Yn371oxnDtEduQbijDyZlE6UlgBJ3wWaaGt8x
	YfVCNRf5Cv0aJc7OtXZJMnNqYioWR3+cxEAYMtAWc4v4fXX5RjuFzeo5CAdSE4sZbjV4e8GZwSo
	4t61f/oRoFlvKhvNB9XCYceIsmMNuH48bkUerpMXzWqg52DSoMYw7qmptogXpgA==
X-Gm-Gg: AR+sD10WmrGBRP0WALTJgAIGPOgGGmZTXB03v4EVq/OPk8iaFXL+P2BmJ1lOOkTpnxg
	xnmlRx0jWS4h1tjA8GS//Y15J0l7xK+9VPZYY+uGUGlVeAbbmbS+k7chZhcstGuN2ko5SF0Ya7z
	FLdwxL6YBfBGIKh4UrodfYSbSvaH0enjzXOrzABv2rzwNYsGtqoBI5Tbv6ynky0GMnQxpm62RDq
	z2MwEDYsmjLQDi0M2vlI/dMKfNViv4HASnZ9hgG0uq20wjQuFzrDi1mE9SDoK0Ikfc1LOYkjKn9
	WwyvPqdiafk3Oix5Y/Wufinyhyc+Je2PkzzxzaCsNk7WhT5KO64RjXFh62IMhUPHHtehX2FzJBG
	ClMLoe8UpBskOXQJHg8Nu4xf6J5xKP2buGJA859LdfBYeKxXVEMvQXSSDl26z+Wk=
X-Received: by 2002:a05:622a:90f:b0:52d:41d0:89e0 with SMTP id d75a77b69052e-52d586c9497mr15822141cf.40.1786445651528;
        Tue, 11 Aug 2026 03:54:11 -0700 (PDT)
X-Received: by 2002:a05:622a:90f:b0:52d:41d0:89e0 with SMTP id d75a77b69052e-52d586c9497mr15821771cf.40.1786445651047;
        Tue, 11 Aug 2026 03:54:11 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:b467:f322:cd3a:615c? ([2a05:6e02:1041:c10:b467:f322:cd3a:615c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49977dfab57sm29695755e9.1.2026.08.11.03.54.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2026 03:54:10 -0700 (PDT)
Message-ID: <91946ecf-05a2-4479-bade-3d0803bdcba2@oss.qualcomm.com>
Date: Tue, 11 Aug 2026 12:54:08 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Mark Brown <broonie@kernel.org>,
        Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM mailing list <linux-pm@vger.kernel.org>,
        "Bryan B. Lima" <bblima@usp.br>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Subject: [GIT PULL] thermal drivers fixes for v7.3-rc1
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDA5MCBTYWx0ZWRfX5dBaKLN2hSDV
 SWm7NZpB/43WRaC3MsRC0MtOxFs8gHZ1Lgyrlt2C4wfywJTRYA4yLAZjaaFLpDkCWZggp44fGwX
 vuPoZuJva1exprW3ze+kzKAZvTKSkao=
X-Proofpoint-GUID: ookaOhrCMoCK6357b5eKOu_GJBviSg7I
X-Proofpoint-ORIG-GUID: ookaOhrCMoCK6357b5eKOu_GJBviSg7I
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDA5MCBTYWx0ZWRfX9e/K2EyFPgSo
 9QDGbmc+cM2nGkectEiC/WUfoEOGFeK94CBGLm0yrS47280bc3WygHbs09/e9uddYbchHLjI17u
 hisxvlwszDe9LwpijmiEWZ/V3eyeyEZUHPrzwxA5dnrF163WtDdOxqR0gFwpxSzhkRS8oG9P45u
 S80DQsPtDFU/tXq1C3ojn6Oat5qHzTy6oWgcdAFDTE5LYimgvZd0i2fEHBkYaDVfCYdJkNUu7a6
 msG9BWoUFNJNfOiDU7DV1jMruIpDybFUXVExrCRVLbpLGF7hyUOuBJziOazFk69GtTHItWdBsDT
 Pj9djgYF7Mdpf09oYm3+PZTmNNiQOtZTL1BUN4caH/crnoaFvXNA0HYoH+tNQMnvPUnWLIWO8UK
 A0qDdwRB2cwhNgSzJkaMYx4RoSG7Nq2XiU+bs9mDDqRNgm45m5qaNYuInAwCzysMbuYKDE/zq0E
 xtAteDnPhB4gFUgub0g==
X-Authority-Analysis: v=2.4 cv=eJ4jSnp1 c=1 sm=1 tr=0 ts=6a7aff54 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8
 a=TKr9EWpvFypitw2pW2sA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_01,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0
 adultscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608110090

Hi Rafael,

please consider the following changes since commit 
55c16e15ff9f91bc994a20124b83faf27f0e3690:

   thermal/drivers: Remove redundant error messages on IRQ request 
failure (2026-08-07 17:27:28 +0200)

are available in the Git repository at:

  
ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git 
tags/thermal-v7.3-rc1-fixes

for you to fetch changes up to 22114b21259b3656019cc0cb3214618f5eb278dd:

   thermal/drivers/qcom/spm mbg tm: Fix missing bitfield header 
(2026-08-11 12:43:45 +0200)

----------------------------------------------------------------
- Fix missing bitfield include headers in Armada and QCom SPM BMG
   drivers (Daniel Lezcano)

- Fix missed file when manually applying a change after a conflict
   resolution for the QCom SPMI ADC TM5 Gen3 (Daniel Lezcano)

----------------------------------------------------------------
Daniel Lezcano (3):
       thermal/drivers/qcom: Fix missing spmi adc tm5 gen3 file
       thermal/drivers/armada: Fix missing bitfields include
       thermal/drivers/qcom/spm mbg tm: Fix missing bitfield header

  drivers/thermal/armada_thermal.c              |   1 +
  drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c | 434 
++++++++++++++++++++++++++
  drivers/thermal/qcom/qcom-spmi-mbg-tm.c       |   2 +-
  3 files changed, 436 insertions(+), 1 deletion(-)
  create mode 100644 drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c
