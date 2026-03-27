Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E998532ED55
	for <linux-pm@vger.kernel.org>; Fri, 27 Mar 2026 20:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774644331; cv=none; b=fAWa3kN/kjA97Rdmqzdlpgip24IlB8fBxJ15X3NkEK+peYJHwcxenw4mGPXbOvveJHPYlRlCqUulj6azwwHS+oiwazxefHvj1Z2KVXAqxIY1gUYtibNo/pZLsw7O9VeRHbvBiqJAYanTeDCZE9caVcCsUa8+Agq3QFCeAil1GtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774644331; c=relaxed/simple;
	bh=kFZ7oITAqKriU0X5V0NSUSPeTwlu4Lr9Zbk3r69tkfE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=opjglpMEbKBvVrArXxlTl4m4PcQFIAmeIhr9mDRncM4bONnmIMywyDOJJDprT0weua7Z5mwYQoD2U1asiGNdumCgaVCXawjy00gDJhprntgpi8TkS6i6iBnFZ37sG6eyLQ19X5GS15aRiJb90Rp3lIPr0fSOu83uOdUSck8wNOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oQfFE5ri; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JWapaQjR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oQfFE5ri";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JWapaQjR"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62RI2QTp4030466
	for <linux-pm@vger.kernel.org>; Fri, 27 Mar 2026 20:45:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	32/2Vswo/Z1NPaFaNOGKibtIU/RnlHV2CWWrqpTejhU=; b=oQfFE5rikHq3qd/Y
	zDpOW5Wqocoz6ejSBwWxvwtKay9iG3ccPKtf+5KFif5RxMArGYHRM+H9EkgIuBwM
	FEiN/F0pfM6amY1scL3V0wQY19vz8fsS5FFNH/zBJrLosF6unphTYRQA3h+9PwQa
	8CoO4q3fdRZs0l4ZOPpIH84rWd4bVfXktvo/xW00iet2w9Zuky1vURWp2gQyzyHv
	mlNoxpeD28Qn5Qdfug0qFnIrkRsCjvtiy9qfmlOFWeCh+ltFoTyawGsy/A7fjILU
	thBZs1y3a1oFMfvBYGmaRWCSf0WRh8f9ezc+pY8RWpb84kTaOSyEF63qP+vY0Va5
	cR8c6g==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d5v6b13w9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 27 Mar 2026 20:45:29 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-509219f94b0so25796571cf.3
        for <linux-pm@vger.kernel.org>; Fri, 27 Mar 2026 13:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774644328; x=1775249128; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=32/2Vswo/Z1NPaFaNOGKibtIU/RnlHV2CWWrqpTejhU=;
        b=JWapaQjRfiqBHk6wpq/0/kIBar0LjiR5QWHQIVtGbX/D30/tLybFEGz7eJw7QuxGM8
         o6qi+tQJZ5cKa5Wdvuf1ysi32jZYZuREd3MnHGFNilWDi5d2gCc4hTjbSCjDk4NQMU0c
         whac4KwZoMOJZyjlSgoakIIHAB+nOteVeDuU91zfJk/MEqrrXM0wr5V/Kx+Fb9uKV+kC
         o9GL5rrjWxMT3LDTxSXCgTMa4A1j5j8MeF0XukeS/WNuMuo6jlnI2NAQnrCQ2dL4uy3E
         CIpOgGqpF1AS/26Xed38a045U9MQjIILKA46VRu3D3Y43b/MA+ibkBNpH5o4Ch2zLlH9
         4nvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774644328; x=1775249128;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=32/2Vswo/Z1NPaFaNOGKibtIU/RnlHV2CWWrqpTejhU=;
        b=YzKRNTNure/+0Mkop2Elg86mk7v2rS7vEZcUXHtK3BE5aiRMYsY1aMYDZhxkui1BCA
         Ztm1fc5IfeDplcqs596YIgWNkQulBKwWzrg/20q61vi81XClAhsGmfD3QZBI/MZoNHDI
         POAQ27Ko+lmF0c6vA/GwLJz4K4oTIVN8ZDSC32fPGDurgfdRUjPmullqxwcKEtHPdiNX
         opllRQr5mOOTQqqNtxJ5Zc3u21WmON3Tw/lIYBV/LxbNwNLcYBcX7XNFAE8OwXp2ReYO
         UOlI3LazqCZGmo3dZtwwd/2JxoLh2ZLuMW1tyRoHq4I/WAbdmAVwKFgae0/QpZb6yMUJ
         x2sQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwA6eGezPRefuKHxPBfHHeqoEYowbnfN5dOO1LMq36BD8e6Mlx/R/vspATdKqxQZfxOFxJsAVigA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx1u/up4fYl08eYs1EtuqFYTmZFsaoMzksuGlepkVTZZG0HRxi
	yyI56+QinoPwHTIBY9KDHs5qbloRDlTJvXBQkb94gtuc6wt5/clO0i66EvGu1g996FKpmzva6j0
	rsmbgtrMzB0jIzayH//oy08YFF8gbwL/MjsO1mYMu+Q5qr9eDQgER8ZHrrsCThg==
X-Gm-Gg: ATEYQzwFy977aQ47VzNhcUZYU6nfjk+7xLYnY1CphjHkRnvaITGaW9AMnQ57mXLgqVi
	wJNi4fLbuFFqONvQpzedoLNuaoIIiBMzwI1qWEEPumZuu4oqvN8psbfxQOYUSLb+5m1ugpziACf
	cBLT/66DQ9EOGf3M2dXfb3ko8HnE6QuxGYNo001tIE1OjZDO7/6RDSjqGHHEtWd8mgo4ZaDv5Cj
	q6YHas4LP9ad/YSWdmNR0qnD4wk6uD1J2u1e5kZfDxcTCaHBALS1fX9+oVc7RFZpDF9NF+wE8Vc
	cDQ0FKq4MnopxdIOrqzh0qEhad2dtSrBft+5C509Bj2LRTfhEF2GBHellN9c1W9wAFImifY5VhG
	9eH3KydQWrkRvdaVz+jtKap5PNWye4CBA7mQWoyAzEY2BH2kzbVVYijMz08x/1mKIjkm17HrIHj
	PHfT9ChRVbt126GiUixfy9saX+BFOnX8wI6oY=
X-Received: by 2002:ac8:5f12:0:b0:50b:33c7:5d97 with SMTP id d75a77b69052e-50ba38bbe0dmr53588501cf.37.1774644328308;
        Fri, 27 Mar 2026 13:45:28 -0700 (PDT)
X-Received: by 2002:ac8:5f12:0:b0:50b:33c7:5d97 with SMTP id d75a77b69052e-50ba38bbe0dmr53587981cf.37.1774644327621;
        Fri, 27 Mar 2026 13:45:27 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38c836d4381sm663401fa.2.2026.03.27.13.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 13:45:26 -0700 (PDT)
Date: Fri, 27 Mar 2026 22:45:24 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: =?utf-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <barnabas.czeman@mainlining.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH 0/7] MSM8953/SDM632 rpmpd/mss fixes
Message-ID: <kz2uuxipafymtvivrywsyrd2567ccnhbpicqqn7uzvdvqzp2wo@kwddn4qyshxw>
References: <20260327-sdm632-rpmpd-v1-0-6098dc997d66@mainlining.org>
 <lv2ali4zgsfdh54yd74cx5mvec2z5kg7v4rkayyukpjt6juyft@vzprb3rvewkm>
 <083d2560294855857663df23e8900f9b@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <083d2560294855857663df23e8900f9b@mainlining.org>
X-Proofpoint-GUID: qRXQhYqbvkGxOSaCB2R2o1QHf5KBjOkk
X-Proofpoint-ORIG-GUID: qRXQhYqbvkGxOSaCB2R2o1QHf5KBjOkk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDE0NSBTYWx0ZWRfX/B120tz32sl1
 Itt9oAIIA7y4i8ZOorAvWSYUkN7GT88znWtJ//sdJUwZg3ZBloxirzzBH+R0jyvsWBRnBlBtGZJ
 8Ixwk20VIM51UDvzqahYl7A+evj/BnDTYEK3Mu5gFSov23svEFeNpj2+fLr9Evl5VLzm6h+X/UX
 1YALx5Hygrjflq46uXvJ+3irn4Nw38NN2ezm5jg2xaHOaRtIqNSlLutg/+ns+EEot7dq2mibcjE
 I9fTDgJl3I9CoUf28HtLDmrIR+6aDWNzA+YQg/NyZZ+oX6KUHMK5S/3ZJZlK3oSTA7tDxjSfFAG
 SnBcHB2saMjyP1+EVCFpH597y/mI2B1kw4VIksH16y71nPmApbFl/gRRq+x/j69ujK3/CKZmwJb
 6PXef1ptRGRx935CpamLJiEd1RCWgrC7YW/pGRsCbeMOLmw6ykEu1jFtCzNEm2Ah2K+oqjD4IWJ
 c7SIpDGCxRFBZONq4+w==
X-Authority-Analysis: v=2.4 cv=JLs2csKb c=1 sm=1 tr=0 ts=69c6ec69 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=OuZLqq7tAAAA:8 a=k6zDti7sIud78PQTOkIA:9 a=3ZKOabzyN94A:10
 a=wPNLvfGTeEIA:10 a=dawVfQjAaf238kedN5IG:22 a=AKGiAy9iJ-JzxKVHQNES:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-27_01,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 clxscore=1015 bulkscore=0 suspectscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603270145

On Fri, Mar 27, 2026 at 09:38:20PM +0100, Barnabás Czémán wrote:
> On 2026-03-27 21:33, Dmitry Baryshkov wrote:
> > On Fri, Mar 27, 2026 at 09:11:42PM +0100, Barnabás Czémán wrote:
> > > SDM632 pm domains are different from MSM8953 because MSM8953
> > > is defining pm8953_s1 as regulator but SDM632 is defining it
> > > as pm domain.
> > > 
> > > This patch series correcting the pm domains defined in rpmpd
> > > driver and splitting the MSS resources for the both SoC to match
> > > the reality.
> > > 
> > > These changes was discussed in a previous threads:
> > > https://lore.kernel.org/all/2b057aa5-4416-4fd4-aeab-6bc23acbb53d@oss.qualcomm.com/
> > 
> > Was 4.9 never expected to work on MSM8953? Or did it require firmware
> > changes?
> There is no official 4.9 kernel for MSM8953 devices, all of them are using
> 3.18.
> There are unofficial 4.9 ports for those devices but all of them defining s1
> as
> a regulator so the regulators were changed back like it was on 3.18.

Ack, thanks. I was looking at the msm-4.4 tree from the sdm660 branches,
which has msm8953.dtsi. Thanks for the confirmation.

> > 
> > > 
> > > Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
> > > ---

-- 
With best wishes
Dmitry
