Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9F43DEAD5
	for <linux-pm@vger.kernel.org>; Mon,  4 May 2026 13:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777903148; cv=none; b=AxBBKmsgurpKTVRONMCmeWZUE+CCqtUuFekTqlVLplGX55a6juRxvWf3MXxJi+IOEsS2KYcQq1gjmmzD9wZ7s/ZSNRO9qTTseTZ+GLHWHgPKiuwttBTNoFVcs+VW+OJa9naFXalmrUOaj0KcGJDY/dJFXQb+UELY8ik0EAlgZiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777903148; c=relaxed/simple;
	bh=y15kLs3sGaEX6SUswDVtuu6Y0cf0YKiM/wbOTXt7rjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oavXL/40NqKVJZf3QhBLPAa0tdTwJho4yuI/RhSBr8JynsVGCsp50FihHQsygsjNNIgMP9gTbdxVYoBNTD8oE0CLO5PJ0iJyVb7rJNlmCNJb9d+Uf3gHvJoL4iIy5LEHQkIxLT+T9sHkWp51okTa37KeANh/3mD0t6ZrXCxzXdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iIyL0FNX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=I5O/eWds; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iIyL0FNX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="I5O/eWds"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 644DrBie331056
	for <linux-pm@vger.kernel.org>; Mon, 4 May 2026 13:59:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=aniRG2KoHodHG6kSw+zQ8UoN
	MbU4RgeqkXy4ZEzC3SI=; b=iIyL0FNXbrkth56Tg4Yo1zYS1f8HxB3V5F9us0Gn
	F7/RdQTeRGZNlU0D6GLz1B4yTsaGbb4IDzW7UoSi622aU51hgLbtNpZ2d/19/t9H
	HNoEpYH1kKi6b9r1QQ5V4x08tzOEfQYBq5VpUjC4RaFY/Z7X99xM/q7p0nPKpm9j
	CM9SSEQQ3O0gBMm/+DEdI5W2MeTr0kU2VMHOZkMMOTjcSZ61AZJuWRJfnAcBY1oB
	Jyy5vIf+ocsTw3HO4IwVyZLNBISg/cj1Ypv36EQPbqHL7HwK2kfafPMMX/ven/9x
	Uf4BLJqoWUYmBXrZ3ujG2nPwP331M2pvGdGVBrc9F31mdw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dxvr180mh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 04 May 2026 13:59:06 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-50e67a4f642so99979901cf.0
        for <linux-pm@vger.kernel.org>; Mon, 04 May 2026 06:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777903145; x=1778507945; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aniRG2KoHodHG6kSw+zQ8UoNMbU4RgeqkXy4ZEzC3SI=;
        b=I5O/eWdsut7pb8VmeJ9o5b8PK0V4gs3YhpYWm0xtZHp5wKdEaZUg+KPCwirQc7nY3d
         iIgkR6b3ogxkW5TtUpIqUcPs8dnKeve3qUYPLdSsPvrfPEyYf99DvRm+BVzwv4SlR23P
         ogmvI80+PH4RLYP8l5G5lZFe9rBU2+BkkQDGG7Ua1MJBBWBnkypEEQrewZQdCiKOE4Sy
         V2/IjwoipfXdHmCYHDZj2LK9SqOa+/1vOMP6ymPpihqCnzNm2R8gwqwYF5nvHHARqSbC
         xndOasUkqjckWXP9Xwk+YFQ2ghOsWUOTFRpkdvnzL6ZToQF5u9QJz9NFr24WZ+1J0TX4
         Vl7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777903145; x=1778507945;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aniRG2KoHodHG6kSw+zQ8UoNMbU4RgeqkXy4ZEzC3SI=;
        b=P6YCtVdgHpIMTVzRX8tuHSzxKoEv21qZzvYLdPjrSbZU2xcKDQurG3+vT3pENNkrEv
         bU40PdoeO3ZC0QGsQVxFO05yf+YOXrTNM6YuPHDEJF3Jxxje0Lz38vvcyEYL1EEFeaFy
         EWQF5RufxdS4dA6fW21SrcQOlpmTl8DxurtHWZT0t8yFCG0264mHruEzWaNx2MRhBuw9
         8zQPuB1IeDWFsjDI81HKv1NVDOEPob2kChWGdl4D4MbJ/J/pdyPejH31B8+l1soOw/Bg
         RYNjPFnch3vUUi8wxr6siHXGR0SeLsmxx819XX/+hU1jbP2UURkSqBFLk4MTGUtwNzyE
         PVXg==
X-Forwarded-Encrypted: i=1; AFNElJ848iCiRqXG692oFl1AwzMaX80cORTS8kBVn8AoHr1EjMRv0yeh9UYu13Y5iLRbDQ7IcxZ6ES8xGg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs0dlpoFxokQReDK/zn1bCgnKUyJQ3TwfV4REFWIyeUI6WTz7u
	lVtmzVdWOZwau07E7tX1KPni+a9M51IJ5PfQxV2sydKW7eTdDwHclFb3YVrflP24M/k4jf6Mvzl
	Ub9+254s0Fz7V3MKqhbVOYVfxJIAt6OpE/mKU9MdNJIWNh82b2BgSYVzB3EYtiSzMWMlKgA==
X-Gm-Gg: AeBDietHjuHlSaWyviWwQPoVw9B+fW9DYeimrjT9KhwhgzrPB8JvNsqSMjQy3b0IWTR
	14G8WjRJt5F2We0a2PbPU794y3gkqKcN+Y/g8CfAWxZsQef3AnjpAJsooTgiWSTzlhBzsP46Qdb
	85xyH1G/M4TD77++CASMuopoiM/U+4L/ZVgKAKcmL1xNZ7xemTcs/SZVqBALIkO37H2Mi47ShA5
	BI3cNx6pvM/gTaRfgx61U5uC0VNEguXBGShQ2o0Zgr7wUHUaufJJRGePamI8e2xc880JzB63QdC
	kveyAO8cVpPY5llAp1nAei3n2YyPmiwvc3M0CcSmElzq5iD2aSV2ezNyLNOE/G5JiDQDK6lXrdX
	YNwSv9S0UXK57NNxiPRiKNBpvxuUtsCzHv2L6Xhury3jP3CKJnTNCuSvo87yQmg8hzAzk/Sh+O3
	i68jpzAToU3O9ZtDAoFz815UPpebUSYZPwUbqZRUGCcGaQ0w==
X-Received: by 2002:a05:622a:514:b0:50d:8905:7cc7 with SMTP id d75a77b69052e-5104bcb8b9bmr138356611cf.0.1777903144985;
        Mon, 04 May 2026 06:59:04 -0700 (PDT)
X-Received: by 2002:a05:622a:514:b0:50d:8905:7cc7 with SMTP id d75a77b69052e-5104bcb8b9bmr138356121cf.0.1777903144486;
        Mon, 04 May 2026 06:59:04 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a85c230e5asm2994316e87.33.2026.05.04.06.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 06:59:03 -0700 (PDT)
Date: Mon, 4 May 2026 16:59:01 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
Subject: Re: [PATCH v2 2/2] interconnect: qcom: add Shikra interconnect
 provider driver
Message-ID: <m6z4ha22u7urf6yd7atkizhii5fbnl7golkdw5v76e4pmfcpvv@r7ppowo3pfcq>
References: <20260504-shikra_icc-v2-0-81076171e010@oss.qualcomm.com>
 <20260504-shikra_icc-v2-2-81076171e010@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260504-shikra_icc-v2-2-81076171e010@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: CIwn9Zcdn1duyL2QzK-o_O0IIXu83Y-3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA0MDE0NCBTYWx0ZWRfX6Bo99gfMALQo
 mDQ69k3rIzbAfgaV7yym33+m1bOHePgPDDsRYx6UXI2cI2jWcSg08psFHa9CI8nXD7VjKtbfAXm
 H1VOCsqjWXZ9G+AMQyIvOMEjTiemHkvG0Au++EofiixGf290MFi/EWJ3IzFhZNkxgjKYYoK6ige
 VnzcoKhOzb9TUuBJMA2fuSV0ZHXT7t6tVcW3SClxOuqiqXN66LoviBf2vhYn8XNXxZBqldM0AMq
 gDu564A8wXPSU4F3hpntwfsdsf8wWHJ617nbftL2UyfvW91ZH5WG6MJRViV9rLDcUvs4ZuXCG3X
 XT++QSyJxRGbzw4jVxTT2uovKgK2GW8wSpDsOzIUVmKneo6mJ66kYN9xpjZjWIDrqkLqGKo6/EL
 N3tki8yl5Xa00DibE4xaowfLBSAiwpvu9gsVmQTkVZAcFFgLPGBlIkd25R4ZaXtMGgX2uiHPlMT
 KX4tukcDG7uKk7df89Q==
X-Proofpoint-GUID: CIwn9Zcdn1duyL2QzK-o_O0IIXu83Y-3
X-Authority-Analysis: v=2.4 cv=RvL16imK c=1 sm=1 tr=0 ts=69f8a62a cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=j7VvbvnbhCrZ_lwJNYUA:9 a=CjuIK1q_8ugA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_04,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605040144

On Mon, May 04, 2026 at 09:41:14AM +0000, Raviteja Laggyshetty wrote:
> Add driver for the Qualcomm interconnect buses found in Shikra
> based platforms. The topology consists of several NoCs that are
> controlled by a remote processor that collects the aggregated
> bandwidth for each master-slave pairs.
> 
> Co-developed-by: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
> Signed-off-by: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
> Signed-off-by: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
> ---
>  drivers/interconnect/qcom/Kconfig  |    9 +
>  drivers/interconnect/qcom/Makefile |    2 +
>  drivers/interconnect/qcom/shikra.c | 1837 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 1848 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
