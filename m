Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3AF03EB10F
	for <linux-pm@vger.kernel.org>; Fri, 31 Jul 2026 11:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785499148; cv=none; b=hdoUyDuKDHY6M7RujZUr7aeW+xroIp4ZJYddDOHj8GzkuOpJ3zTNyprLVbDPKesJefiTUDFriybO2uME0eiML+HCHM/0rd2xcjC8TDWf8j8qVO/8ugZDeAJaE9pOUmnmY68yU63uD8O6PPFzG2DZ0nT02h5VsijTcBfwy7GdZac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785499148; c=relaxed/simple;
	bh=GELpTNNQJlbU2tl+wAZ0cQdnJgR+XPFVoYc2iOtYqcM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QcQ/5aTnm5x7hbtyoGBPR4JNObyYhjHPj9qseb/INJC050FbWkCb8u6OOHeDKNOkW0TFxbSWTRKSJz8XaANKXGpf3YGvytVegzTJ8AcIt6MIkM+E3w7V4EuS0iHUGivIIcPguswrFV7GhQqwG6pwFWgt3jjEf3mhmLCFr42hmp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Gawz+7qI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KqmDNup3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Gawz+7qI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KqmDNup3"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66VBeVDf188818
	for <linux-pm@vger.kernel.org>; Fri, 31 Jul 2026 11:59:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	M0deU4TNX6fHxv9J0oFHoUXvgfYFVyrZJE+0KzVtFN4=; b=Gawz+7qItjp6JBG4
	wSZFtXV1r/8lDCem7/WneX55pR5DsP5IgR2DBJcb8TDx5PDGjU625+zPx6tKUInV
	bR72gzJbsg8LvXnGgUVwnTQBvA/usttj6SK3vC0RA2+UtSjwIQPiPgvX6h6CY/UH
	t8ScB06S8QsC+IKuD5CCTRPTt4ySIE4GXRGunyqpMK4ZlMcht+Txh72m0kMkDzMQ
	lXmlwk9gQGyNavFuxOIQH89B3h7AILhdJDwNSkx1g4Q/7doHozLD1/04c6ZdAFCJ
	3Kd804ctHFVuqUgMASBgyRYYGcCIw1xmTv/+y8hoEsmB2Sde+uhOt96fl2VBuwmm
	xiow5Q==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fru1u021t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 31 Jul 2026 11:59:05 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-520a00c7a03so15224891cf.1
        for <linux-pm@vger.kernel.org>; Fri, 31 Jul 2026 04:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785499145; x=1786103945; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=M0deU4TNX6fHxv9J0oFHoUXvgfYFVyrZJE+0KzVtFN4=;
        b=KqmDNup3IOlZq+NKpDSTR6kQRcHHpVyMqsKlrROjRvbzUo4hFXiOkpYlwQ+MMgWP3n
         +LtwTo/ZlS9/4xmFwR93Pm6y1fxm+v9DWIECsXtcKvkgqYfYf/x+gFJ70DaJrX1xblEc
         P/GuD+bVbn+SoyASahi4xU5+HuTbnJ2hZrRexAhBWbsXLYW2A6f6YX8zX4f3lwPs6i8v
         zWHbCEqzfsQV81Id2+1urG1QpZVPp9I4L21t3vDvU62tsV2/OoJYT2YE9rWUAGhryrz2
         qqQ/L821w+mJZ1CWDGrrafgJHkZT6zsRWzLSK5Gq7lTcrDKqVyVZBru9TJM8UROiEOiH
         L8xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785499145; x=1786103945;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=M0deU4TNX6fHxv9J0oFHoUXvgfYFVyrZJE+0KzVtFN4=;
        b=hWxLOsEoaVt563YpQmcWextrQET6BfZPZg7HjQHGWAZ3tb7pPGD0LKvxXnyTpSEHu6
         vNW+oCjC2kh8hl3ySXorRdgDOURTomAzPHAfgfJON8VrqU9z6PDNSm//uacFOmh8axCt
         9eFS33Xv6c/ck+HkuRUODyP2xE3pjRHhLU9+fZ9CVPTNG/fOZwqZWXyEQOd1oLh+vPM2
         mtYtfKt30MT8PozkNj/Q7vdDONqbfaye/SEMTff2k+z7wONSt0xUhTjm66XsK4de8ojZ
         F0Mp43/SnUrvKG+dTjg/aBR1bFTN8keNrND1msggk+otYI3jyeQnpgaWcrZo3vYf27Vu
         /6AA==
X-Forwarded-Encrypted: i=1; AHgh+RoDjL9/esN86GA2n9Tzya1TRSafJMQracaZh1X/2w3JNAllwIpOTMu7jjUR+WwEyhnPMmc+1gwDsg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxeH2v5gZ6MowpexyOAXTtizG+zTpK83w1LXcXEQ4i3nByX4FTO
	Da9v+143sS3++rRRuECUk4WKwnX06MH2OfgitRbGNZ9G+yAukFfLZ5MzTHEwYFFb/A4hRlYfqCb
	yKXoVtyaZmVJMd/UiraAzLtSSS/r79KqHiFzGq4f8Z1hq98i0qKAwDbSfCvtCWw==
X-Gm-Gg: AR+sD1208pL/l1uLFNCACzWRKlS1bH2s2NNrZD6obsBwSL5yMonN/1t2+8+X6OJ0U9b
	dchLNBUkXO/I8DVKrPDqD50+UmBuPWHGSkRUPOqYr/KAeCWDTQt7jqx00zudndD9erx1tWRdpUM
	9cG2CWnc/+5s2TkQM+X2cpTNzQ42UXdA+qQujbucPTTxxl2azeiBYt1lIgTLsQ8BzDErPPRel0W
	AayoFB/DwAyCnct3dU7BCpW6EzZtN8y1Ibo8L9enqTlVGGSdoFJYv+bpoPOuOA7QNEcdaRrAIIM
	cSLw/4teVSwT9fEEGvoz8o8GpxB3X7NGrSq5/WX+dUtdv9PbPjdkOuTk1XlMOtCm+LIu6s7QXNX
	ThqrTYNNVpdsCDEM=
X-Received: by 2002:a05:622a:5593:b0:517:5bc1:e1f0 with SMTP id d75a77b69052e-52b4aa0c880mr23329381cf.0.1785499144739;
        Fri, 31 Jul 2026 04:59:04 -0700 (PDT)
X-Received: by 2002:a05:622a:5593:b0:517:5bc1:e1f0 with SMTP id d75a77b69052e-52b4aa0c880mr23328911cf.0.1785499144278;
        Fri, 31 Jul 2026 04:59:04 -0700 (PDT)
Received: from oss.qualcomm.com ([86.121.163.114])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd4068fb7sm4618924f8f.0.2026.07.31.04.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 04:59:03 -0700 (PDT)
Date: Fri, 31 Jul 2026 14:59:00 +0300
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>,
        Amit Kucheria <amit.kucheria@oss.qualcomm.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Manivannan Sadhasivam <mani@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-hardening@vger.kernel.org, manaf.pallikunhi@oss.qualcomm.com,
        Dipa Ramesh Mantre <dipa.mantre@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: Re: [PATCH v7 9/9] arm64: dts: qcom: hamoa: Enable CDSP cooling
Message-ID: <aljdjmmenszu2gtdeqy47sblo7cfz2hg2rxvaedie2s27e7gcv@jdzrzzdxrwbg>
References: <20260731-b4-qmi-tmd-v7-0-3befd44403d5@oss.qualcomm.com>
 <20260731-b4-qmi-tmd-v7-9-3befd44403d5@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260731-b4-qmi-tmd-v7-9-3befd44403d5@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=H5vrBeYi c=1 sm=1 tr=0 ts=6a6c8e09 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=6dw9+iwJWV8PcCi9M4lOBg==:17
 a=8nJEP1OIZ-IA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=_nN_CDt7C_a4776dohAA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDA5MSBTYWx0ZWRfX180lDJADkczK
 CPHf0DdggHnQl9kaQxIDaql/Js4ij/C5x3GqAVn4LLG5L000DgM9wBbFxXuuvQamjo7Dnsh/Fb+
 2LgX9bMa7f0j3Uwntr5NSNGefudaRhm18SRHfuMOAmE8Y64wi7kwmB8noxTlCgsx1yedobqmzeQ
 GqJ75IAME2khk4F93GNyQ8NOP+yiPX3rHyJ2rky+lUhbFlzmb+Sa95BzhhDCA7WovtKYECvOrjM
 n1TUNRzQe00gJR5RDT+JsWNM4gO0wHHedSr5v6svzfuj9Nn2LXkK6+UXN/0ISE/Ouh9pq9eQeBk
 Q0ZmBPcrYw2PlzRVewcLiOd7J7JrGuO40NIOzHMVdcTJbQuP52bBvqWgIpca8gum6vVT9AwcRsc
 mxZKJoMBB5igsTY7MTyPJ+42SM4QJYfV5EO/V0705ev56Qt2w5nxkWqRsqV0NWeKpzN13aH8HWJ
 ZU0TMqb2dRKfvBqHOJg==
X-Proofpoint-GUID: pTGpZ4Nme3C07Fd5590pYFOe9Wsyh2Uw
X-Proofpoint-ORIG-GUID: pTGpZ4Nme3C07Fd5590pYFOe9Wsyh2Uw
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDA5MSBTYWx0ZWRfX3CSscECg8rJI
 6Pd++FF1LlKtziarASo98bHiN2eJgRKqUDaSMENYqztvJSFcL8RLOPrPH4Ai1zX9ESHg7O2/Kvm
 N3TjpzPXxmgpHliFmrzcbWsgnVf8oRs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 impostorscore=0 malwarescore=0 phishscore=0
 adultscore=0 bulkscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310091

On 26-07-31 16:03:49, Gaurav Kohli wrote:
> From: Dipa Ramesh Mantre <dipa.mantre@oss.qualcomm.com>
> 
> Unlike the CPU, the CDSP does not throttle its speed automatically
> when it reaches high temperatures in hamoa.
> 
> Set up CDSP cooling by throttling the cdsp, when it reaches 95°C.
> 
> Add polling-delay-passive so the governor periodically evaluates
> the zone during passive cooling and steps up cooling levels when
> temperature stabilizes below the next trip.
> 
> Signed-off-by: Dipa Ramesh Mantre <dipa.mantre@oss.qualcomm.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>

With comments from Stephan addressed, patch looks good to me:

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
