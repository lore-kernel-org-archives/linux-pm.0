Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348BC403E82
	for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2026 14:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785163168; cv=none; b=ikznmaBLXFWf847ObXoTSLZzmHiS/FpgiC45PtXJkQWZToevcruY+PDzreqCbRX1x94iXnbIgd4ugr49tdoRYxGlIP3R7C6og5wDuLLhs874fCft+BlOL1JS4H7+FKZpedtkyoTmjhff8ccod9BqwZvwfYMZ06Nry7GIrkwjsfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785163168; c=relaxed/simple;
	bh=Zxy16+x799ihBBr6MJe6NLfjS8UfI3VxhcWSkMvxeyM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zu6qB9BNCizEJxDZDDRSogZyEbD38Fi5N4bsK6RLNSLyr/lOXM2jrlcLkVk50Q6ql/KZ3tlsgo0vlR7c/ugqR4JG5taDxGAbkv7w92iBUkhYY3DXfFP8WyTok3cy/QSV3H49tBwk9TmnMzLDJxI2E/quCV94zIIbkpsNtE3NZTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cnxgraeP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IbmXqwfQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cnxgraeP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IbmXqwfQ"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RDlaoV3414030
	for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2026 14:39:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aNiNwU2QrjjQdW9slXjUnT/0JOvoYgEc5+oULzxO43Q=; b=cnxgraePk3sg5GSX
	Fy/C6BKFOQKwhwxJC4foprG58vTDKyc9wfn2Y9MCjt27ia7i6Ks1UCMmb9xdZAfS
	TUFMilyElQQ4nI7UygXGsk8EMO/0nQSiooHhKMJww1JnmQC8QIvVr7F8v2YtCFnC
	V3SaMlMnE4FC0VlsPbKsz92eEHnJX9Gv9Vgx8z+AYAL9FZUExb4vOGhQplJMTNKp
	Mdno9Tu63Vd9XvffFKdtqGCW1p3hZWBexODpxKYIY3/rxmekEyfVMh3bxmXGG25Y
	KZCOfEetABf2Wk5aNHCzoFRvtx+kC9Tvup0A1d5yWA8jgFDCOhche4OJuj+YSZoY
	436Omw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fp4v694en-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2026 14:39:26 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-5174a23afcbso28140891cf.3
        for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2026 07:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785163165; x=1785767965; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aNiNwU2QrjjQdW9slXjUnT/0JOvoYgEc5+oULzxO43Q=;
        b=IbmXqwfQYs8fbu+s7NaIwns76EqxbIYIOrizOCQS2i58/tvE9S6YUWjb3Db4r8spV3
         YW5togUKNIgBB2zuT1Q1OyIFIvsTUSsjWFTbvugQz+gBVq/8BmD/VNS+Bflv1knCiuOb
         eLCt9c73+S00lS/G4J0nZdyPig58Y77g4jd1GCWJZkcZcHl60T0jMOdecz/qOVPPLSyd
         eIxPpOKUNpck9/vEwxpyxrs3pQQW6YesmsjvHZGlXaTKDYPKRo+LAPAA0Yq51k4QTf5z
         46R2qsu6gX8My24LR4QzjYdZTqZU+CawpWzV56EHl8fF5CC3HUALi6cyZfz5anJLWVaA
         eqvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785163165; x=1785767965;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aNiNwU2QrjjQdW9slXjUnT/0JOvoYgEc5+oULzxO43Q=;
        b=iTDCp0/nmflFbf9HFJLk17HAfA5Mz5/J/qPykMHUKYruUxDKqgXfABpH36sWUPz0Sa
         XSZRoaoqNN7zjiMmkm6lzipuzVeCK7D5Vs1ulkawxeqpxWtwnBiXJaM8ZAag5lUnm2Ez
         iB2gBLydxed8Af7vsm4JsFdaj10TC4VC9CmEFWo7L19bycGYw1jtCDUm/B9RjbJiBNZX
         GlMsUH/Hqr6F+P384KkUGtPCBt1YN9hdh7REOVJMHnyyHDVAs/eeh9WiYc7JmEYQuw3X
         9/ieKuPzvev12xK5kB3AENfLys39kgCNZZfjwTbBAOwBazhfXOF1sZJaIbOKwAkqMEVe
         OwpA==
X-Forwarded-Encrypted: i=1; AHgh+RqNyeMfAJxDH6/GAPj0KLWvx8zMLEg8fVNchlI/Z62iDHIi4H7tGjGoID2z3tJgSf8Qx6LZBsZtTA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxxnPrsCeL/ThnqKz82AtJOk6koXLAzqUCzowtMzT/a4JyuO0tl
	s/IuysVRK953gpHCL8hOt8sGNYRKeThua/Qp5QVSi8G5FKnA4Ew0yC+VF6GN0HGxyrfiZyLAjl9
	PCgXSiPikYlxn0nqRW1YrxIgm1itbBiQsTFsYSGJv6LgkKPUTsY48sotAopp43w==
X-Gm-Gg: AR+sD10g6+WnOi2Q3tu/BAG8CnGEDjl5SG0yhA1vgxim6v5RGxihX4VX7M5YdCQhrR3
	5QxTGFvsnM03S5cWIhXVumqwNZCLeojuj7uQAFrLziqaVuAEf51ttlAZDt1h0sDddM7DbnotueB
	fK09qqum2K5+OO6X8AgJnsNJVRRX/84kCGfRGAEmF0Lu/is5Ztaf7Ucc3OzWmq2YGne+BCYAdtr
	mNyeqgYUtwN9EJd5F3mb/A34EZeraBI9/A7mmEfARVvQzIhjxs0ZOO8aLId5vOkoZh5Ar0Y/d5u
	Nk6/ugq4RdBL+KCFmsxtQJImPi1awOfzoCf0Gq27ewci3ar4krW4DQwrMqdpAlik9zYjUZ9jO8z
	Ad8t/QDpGMqIFVeIfRokoFVobh5w1svS9yVsL/BnvyCylAg==
X-Received: by 2002:ac8:7d86:0:b0:51c:1811:6eaf with SMTP id d75a77b69052e-529a8732f6fmr90542271cf.65.1785163165411;
        Mon, 27 Jul 2026 07:39:25 -0700 (PDT)
X-Received: by 2002:ac8:7d86:0:b0:51c:1811:6eaf with SMTP id d75a77b69052e-529a8732f6fmr90541801cf.65.1785163164950;
        Mon, 27 Jul 2026 07:39:24 -0700 (PDT)
Received: from [192.168.2.1] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85c6e9a2sm51480708f8f.35.2026.07.27.07.39.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2026 07:39:24 -0700 (PDT)
Message-ID: <3ce0266a-64b2-404c-a904-25b6991f380f@oss.qualcomm.com>
Date: Mon, 27 Jul 2026 16:39:16 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thermal/drivers/imx: Disable clock on runtime resume
 failure
To: Can Peng <pengcan@kylinos.cn>, rafael@kernel.org,
        daniel.lezcano@kernel.org
Cc: rui.zhang@intel.com, lukasz.luba@arm.com, Frank.Li@nxp.com,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-pm@vger.kernel.org, imx@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20260722084909.463437-1-pengcan@kylinos.cn>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <20260722084909.463437-1-pengcan@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDEzOCBTYWx0ZWRfX1s7oN1epAOan
 9xddEUMRRPalMN+V+Q+YQvivq0kMjWXk0Z2pxz9U7IE/HRfOih97wrfrGDHulNX00JjFa+QCpjX
 +S3JcIYUG5RSHBbYTUW9mv1B1jfIp1g=
X-Proofpoint-GUID: wTvuVbmKuQLvy-w-SUZ_rsWf2lPbVu_u
X-Authority-Analysis: v=2.4 cv=ev3vCIpX c=1 sm=1 tr=0 ts=6a676d9e cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=uw/3876vWhRnNVL35W6mqQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=mjVe68GCGcCyfEWORksA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: wTvuVbmKuQLvy-w-SUZ_rsWf2lPbVu_u
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDEzOCBTYWx0ZWRfX7g0vOjzXsBrQ
 uGG82oG7/YiIEJ9vYNFrtHiFrNpUf3ZzhjhqY7aeOMmtn0oxIr6CsdYdwswHXCIHOChDTpj1ozz
 fRrbbNymyQImsXv19TpyNE6mFF0xEhCQySLzei2h1VUaJmUL17EZDNpH8RsmVoii78BUTMOQJ5Z
 pQ4bjlF35ualAJKSwsGN1yyJtZZmETzY6ZyZQuuBcsOfe7d+h5pucJfH5J/TPXXO+3CjWK/oxrp
 QRznoIcT3Q5Rw7jpQzPXjhIpHBBDmPDyZivtTES+28qj3JT82NjcNIbHkq87sGUTPgRjJmvkiW2
 C8a8CCggG0vHq5CEn1wZO5Rry2Q95V92NbLfdMA9t2jGxkYIaN/xCDcS9c5/V5EqhMI21BimRMD
 WdUC28l6BKDXP8l7zxAFsPLiT9LfhykNQVJ62k6h0cMYdk1Dhk36cCIr2V7A9gqole2zzh+dQir
 pfr8VLbkfz+R/psRazQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 clxscore=1015 impostorscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607270138

On 7/22/26 10:49, Can Peng wrote:
> imx_thermal_runtime_resume() enables the thermal clock before
> powering up the sensor and enabling measurements.
> 
> If either regmap_write() fails, the function returns with the clock
> still enabled. This leaves the clock enable count unbalanced after a
> failed runtime resume.
> 
> Disable the clock on those failure paths before returning the error.
> 
> Fixes: 4cf2ddf16e17 ("thermal/drivers/imx: Implement runtime PM support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Can Peng <pengcan@kylinos.cn>
> ---

Applied, thanks
