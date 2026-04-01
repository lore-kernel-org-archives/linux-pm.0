Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820D03B9D84
	for <linux-pm@vger.kernel.org>; Wed,  1 Apr 2026 09:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775035284; cv=none; b=R6oUU+fzSP2Q0f+IS+H/cuPcgunOsxQzt5HN/SslHKEvDJ3DOjAebOQMzlFrsmegGTNGBjqpXwcsTXv0EhvgTQmmHnt2fho4c8K7DRFm3W6G9SjXi0GDgs5wPvdWqZ3kcf/vVqnJgQSDhD8020nPHgZ+/YG2viH8vmlUWSjzz0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775035284; c=relaxed/simple;
	bh=NoCow4Z6L2G/wxb8DwrevuXxTOuceAl35jbs4vGKYa0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=deZG4my90mKpBelllsa2s+I2nbCNLNgOJtYtg72E/FeNZx4wrgpQRBlM4hYHW330S/yKUPqbi9QQKrxXYkcmavQgW60ekTF65TokAtNFUOIun89WaMd2oThihd3E4cOCj5kXEw8RupEdvEEt2RtSFXv3rm4+1vwBQFsrTMM2zv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ClJT30o5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IA7tjlX8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ClJT30o5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IA7tjlX8"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6317EkBc4106675
	for <linux-pm@vger.kernel.org>; Wed, 1 Apr 2026 09:21:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SBI7l9zOQxhycvPzhOFDQoTqc96GsNf9eLIJ5NTRHWs=; b=ClJT30o5TGzoJuEw
	DRHmI8SBcPR8/BKe0LQnKW2fN/A/1bu57CEvvKbjPAFK2rXAukpPNRoA7ydBongK
	SeEdzXY3RiA2chXjRkEHSjrx48QnaarcH8n8StJb1U4i4korDLdYWAS1IO080Kce
	0jhBeLBxqpq1r2FibPzFjYf4kz5O6QlLHhq2FgSdtSfT9uWoGKlAuzH7MivqDr0U
	UJQoo5OT8eXgbgo9n+w9PQiJJ8TkzflYS98Q5oY+L8D0e0PSqjBOHQ5frGYp9s4c
	F76M4EQN5NYFBp5TDaTvK3QalLfMVqgNu9DzsLdmjdUKzhXT5DHl58jr/+gStOCW
	S+l2Lg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d8xt90hdf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 01 Apr 2026 09:21:21 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-50b33a19837so25163191cf.3
        for <linux-pm@vger.kernel.org>; Wed, 01 Apr 2026 02:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775035281; x=1775640081; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SBI7l9zOQxhycvPzhOFDQoTqc96GsNf9eLIJ5NTRHWs=;
        b=IA7tjlX8pkGfijPNMRnJrNMmbrsIcCk1l1YmQxZCPnvZatuIO76AP3FEoB/yj6xwk1
         5QWyTYIlgmKVtSYYM8GeLG/1YoWUgb254Kk8m/26CwOubaJCkSYu1w8rBOJXvLW0Qtf1
         lszsBwIkjazaXkIUFESqs8y25LnD+DMPN9BFyBCf0IfokBmuZnUU+s1TiVTn0ual2xBh
         KHQUUnAAe+d+PBN10UgqKt8oVyfETJFeps0dy/xiKVm/gOAr6HIw7S8BEzpLl9NYS48x
         fBULeBEvOlEJZ9W+zEGqIG5NLRQfy6z8Q2alwL0DoSj5THJarzGgXRXn2i0Kl1eQhNen
         8omQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775035281; x=1775640081;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SBI7l9zOQxhycvPzhOFDQoTqc96GsNf9eLIJ5NTRHWs=;
        b=etq89ytMCr8hZEl7LMsgNGP54aEiLad7Wk6BKkWM3RxHP1oV5RaqDPCmJd3uFfjOSS
         q+4toh5qZjCBTvMvUe8GgPRVUEdw2juIoRQVI5Wrh66qbOpGCAEuhMllB7GzU46Zyl7B
         6ID2yvg8/f3Bgx/p123I4eVOpJKXpu7MshFXUoowBdail/TcSHg1/jNB2FUTlnB/24UW
         jlNr8JUXhgK0PQX9YYxPX0Ivzj0J79d4ASGgLizCVe1L9jSIcv9BjUmYOPO51+4eeHMb
         AWjIGV7QMiJmvlYD8BvwJ3PRsKaR9NJIDdrRks+qzPc97uXrzVcW9Y6o0VFCffkyf+I5
         uJxA==
X-Forwarded-Encrypted: i=1; AJvYcCUQtL5UJ23skMVpoATGCDasjNlZIn3SKXue9ffY4f4c6SjlQEX7lEWhUkneAlgi9wAfy4VaTPIdrg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxtYWkFptct2NDIu9M+j6k3+KNbgNbj9sdbfYUpY4BJLTD1+Mx0
	WA/16ZdhKYRLChgigs3sbCmKHZcDbWzKydMtv7b6qLlamLQv439Avgazt/cNCNER/n/iqTG64La
	rrza35UNcU7RZmqpHyNHKuX0w1+dqjA4rG8JLsmzNvCZNWz3i9gLPPFtUxxcb9A==
X-Gm-Gg: ATEYQzyRQaQHH0I7nNtxsCkV2AlySSTjsfMUKHKbWIw4P3xr4adnjBO+K0IJGeTrD1J
	VLtlbl4DuDBt8XaTG88FaakMpOEauIZAfMEa8wg8C8F+IFoCBFMoCpzUlh6wfvoSItMhu+RBpMY
	sfCg0/lGiupLboWr9N79I0BFwzUHQDeUwHsWl0H0EZJW7x6EHeMmr3bTrVfHz9g7S5h+v68BTq0
	olcNkdJjwKYdL0MUSnUhhEAx87tIUZoHvIc18APkkcPjQ+x4iqV9jtwAtlQiQj+BE9h5Tf4rCN7
	ToAQMy2t8OGHapwM8NJcNhoyPlzvQkNSiru5WdR8aGVuJT7+pDnrWwmrM1MVeClf4Q7WuHGXHyl
	ojIC87uJ9z5EBNu5ILFLJFHWcD0WyEzO9dhq6/8ePpqiIJ3HtFmfoA/rzjLKoIr8Atmd8iUB0Z+
	s7VYA=
X-Received: by 2002:a05:622a:98a:b0:50b:1e21:1733 with SMTP id d75a77b69052e-50d3bccc4f5mr28589081cf.3.1775035280852;
        Wed, 01 Apr 2026 02:21:20 -0700 (PDT)
X-Received: by 2002:a05:622a:98a:b0:50b:1e21:1733 with SMTP id d75a77b69052e-50d3bccc4f5mr28588951cf.3.1775035280472;
        Wed, 01 Apr 2026 02:21:20 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9b7b227393sm498818666b.63.2026.04.01.02.21.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Apr 2026 02:21:19 -0700 (PDT)
Message-ID: <29c8b202-2d99-4cf6-b523-0363335b25e7@oss.qualcomm.com>
Date: Wed, 1 Apr 2026 11:21:17 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] pmdomain: qcom: rpmhpd: Add power domains for Hawi
 SoC
To: Fenglin Wu <fenglin.wu@oss.qualcomm.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc: Subbaraman Narayanamurthy <subbaraman.narayanamurthy@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        kernel@oss.qualcomm.com
References: <20260401-haw-rpmhpd-v1-0-c830c79ed8f9@oss.qualcomm.com>
 <20260401-haw-rpmhpd-v1-3-c830c79ed8f9@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260401-haw-rpmhpd-v1-3-c830c79ed8f9@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: u1kktoRNCbOUo05pju1BPs9Xz4QF2RGb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDA4MiBTYWx0ZWRfX1yFpAcG2+j52
 lepyRLbRcicI1Dvwnb2rT4WXuW4KvPrnyTyy9Wxvv70MgXFk9cMt0vusiGCRzXO1uTDVFwlltLs
 XGxdjEzshx1jo/miiHBTs2uvXTW/YMTCLRZnpzsIYM26gAQfifOSzMJgJ1AXOQm/8V1jU1UMTvc
 dUPtShseTux6MUAlm496b5QNwbSkfOiqp2iacHu8KZuI/V4FqD2Va62+dszFttFgGTTKoWFgIe1
 GUu7cINq8M3VDIRGeXEeFQIWKRApouLeb73iFwVr/pQi8UziLFRGJIHXxs7ZwV+1Nu65KpKYGea
 HiVKGPmzWZFUNfYbX1+Gmoy4/aAKIwE5YuIKvYYV0BKfnd7LcT4ZR6njzGmdwtuyTx3itNkzmn4
 GgauonPrs3xIk8BuQ3kv/zSn3PvGcp98SZum/s7sTpVL+qss7qHVXb4H3mAMTiTNZy5pakwO8E9
 qVFP8gBDXrSG/sVhMiA==
X-Proofpoint-ORIG-GUID: u1kktoRNCbOUo05pju1BPs9Xz4QF2RGb
X-Authority-Analysis: v=2.4 cv=PoGergM3 c=1 sm=1 tr=0 ts=69cce391 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=qZ5ZlOtsQYTu7SIoqgkA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_03,2026-04-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 suspectscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 malwarescore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604010082

On 4/1/26 11:15 AM, Fenglin Wu wrote:
> Add the RPMh power domains required for the Hawi SoC. This includes
> new definitions for domains supplying specific hardware components:
> - DCX: supplies VDD_DISP
> - GBX: supplies VDD_GFX_BX
> 
> Signed-off-by: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
