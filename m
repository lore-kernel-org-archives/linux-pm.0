Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8636925B08E
	for <linux-pm@vger.kernel.org>; Mon,  5 Oct 2026 03:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791169848; cv=none; b=XGmy1G1WvLKqTfisSqV/IB/F6E5OQNN+Qgw8NTHUHB1W1gbXS5Sq4CDcTmouY1QrHqZ4kuDLMJwkE45dtzjH2nG6ybXeqNVwtqyTp6pBQP3epTCT+ZtnXtUXtCn32h7yFsfqtChUJkZtNOg5nAjsrG/ETHkqTdDS/S7G4keB+oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791169848; c=relaxed/simple;
	bh=FkAYTVSx/narKs44G9kWV+3HqbiiTQQLw1ziMHERtW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JIVxx02kYBKGeY+86QPPuVNkDYXZFBsfIDTiH9jRaL6wQAcBamDnB0lA6jBka/1YK71A6dzeIxNpxWRInzkXlI16ar9NtTqrgJQaj4PHptvDGflSXQd6VOxJFyuxf8DMtLgPdy5I9InKASdJP50gNnL+8Cw6iKmwFfArmsJmte8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=d+gM6bE0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cdtJ1KyB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="d+gM6bE0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cdtJ1KyB"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69511DH5788955
	for <linux-pm@vger.kernel.org>; Mon, 5 Oct 2026 03:10:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=3OfEK2icYr2I7GSUxSDco0Fe
	v4FbkyIVeW2fdTVpW8s=; b=d+gM6bE0mp8gn+PS8MsvfEEFXa2AYtPjzXEvduFv
	bISDW94sY7FXV2hxT7ss4R+hJuJkDg7/MGREAEXDlrw2y6yBGUTTBRtbaUWreMAX
	1BJ3dqYZEXzZ/BJEHbFSrGcQfbLwehjIrHtYlM0tHLBn7GRvA6kW2c+IUWdUt66I
	OIEdwDWP3955Iuj9tzOOg79JHKCskYXfWLelN40GgIV48WuR9NY6UmWsr91sK4vk
	vREcrp+x2iU+1nbaPALvUV2UhBJ4oT8jNmPKpc9Q2igrOrrMPM6NJw75WsEI/lm1
	UG+SroPbg8/S81xTjVEx+77w6gZLf3wxkBFgNMIpX5Ad2Q==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h2spa4aps-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 05 Oct 2026 03:10:46 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-7bf45388253so1225817137.3
        for <linux-pm@vger.kernel.org>; Sun, 04 Oct 2026 20:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791169846; x=1791774646; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3OfEK2icYr2I7GSUxSDco0Fev4FbkyIVeW2fdTVpW8s=;
        b=cdtJ1KyB1iD+oOm5+Sd+EDNvhKJt8AmqdUEICdclBsT31UcfAdpFGTP+coBdvjq3Qm
         nk+zWmXGlMX82vVdQLY8Srur6uRNt/MtI2kWQrJoFBHOg5PEWYnECDClwbptYc3hfXAO
         TfEzC4vXdacyifM5JOHYoDH6YPK06vaK47D6Jwt7B04PBa86tpEptH9bQ5051iJ/YXHv
         mrDT4zuzpEu/dhSUOPjJq7wKOmm9e9+P4H2q/rCr4Jp3kJLCGam4hJSPu52NclEAsefH
         F6Maze6boJGYKkdYQviR5Q8Fd7RoN9zrUFIIZ28kmPHvc14/ZGg62OpYee3cIvMZLhJQ
         BOwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791169846; x=1791774646;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3OfEK2icYr2I7GSUxSDco0Fev4FbkyIVeW2fdTVpW8s=;
        b=J49T8nbj+6CZI5qya1NojcFHVKf89lTCBuZ6gkDZoc/E6YNm0PD7byP/nutSmQR3Da
         Sz3bKdNRPR1bTJQ3hwEICF9aBzxoKGmHq4owkZLaCoC22qPMZKyt6wi2gpZmFx6+eQCH
         SnaLo9nBqGw4M26C+b0YFQ6N5dCxkb47qxA2u+d/gEIhY+UMDiVS5ohcoJ7f1R/FZjko
         n/s56aW3ghvUD5MT+V2BD9tNGaikyaVuLX2Ya8+AlAfsL5iA4LhckacbqjjrsVpPqnPf
         G7yL7RGWKcQ9a1Q1TrPBNDljJGVmnqwxPdBqDetNZH4a35+Pfg3mD7pq7CZjuCewJm9W
         VA5g==
X-Forwarded-Encrypted: i=1; AKwUvBwJOxfc7QdFVFxYHXW/LzR6A4z/taQ7u4uSsu8LpoXi6DXbb+7JFFFi+Y/H+W2SlLGBmc0vzvzbSA==@vger.kernel.org
X-Gm-Message-State: AFq9FYL3JAKDf8idtecg4LwtGexJyaE8XC7uhEbYwduGabItnhadLfV1
	Aftheh51RH8vjD4r/ivkPxiNemtN7NWUtl8SZ4aIZPXFq1lb90p/pwDdv6Cv9J2mdLW2KCqbDYU
	kagX3LAYruuOQbURe+fPlBAJwOfUaxrhZM0DMrNd5HjmGfOM7gi6549cw8MTILQ==
X-Gm-Gg: AYBFou1mRfbS0bfvBhJ7ZqAimq6wyQnhOXMm5dGEbqCApyruzlXttwydtA40lB5/dIx
	ZEB6Sd+3IblLDWBXn1qbTkmCMPSjXvbkvCOtKWarCAic8AvGXkksNXLgbTtQiiNAuOo0wb6lY9Z
	VQpaftB40mQceKIMJnrsoCzhLyvvj/B2YN6b7fFQFiZVPyhHBOO/bR9IR0gyjn6jHqxpxiIh7K7
	lbrved5SUvA/W9kbwbghqtpb1aexp77RlN5M/p2WbQUF3ovmprzF4lefgTDWhgrw63a/wsqYfJJ
	IFpNfLP5a5Ryi36LxnNQuIZ5V40EHqI8HCtay31WMCSRp96O7vwOVNKj4qYsj4mwcxqyFYJSrNH
	tfCATxIYAVMkPvVnystctsRhBEaH293+PiNO8vRcOGSgA8nbbyBuF5CRxNqEdi/O+Y9Ef3sHJ3O
	b+z7aTbNpzSmpo
X-Received: by 2002:a05:6102:3c8e:b0:7a8:d959:bd76 with SMTP id ada2fe7eead31-7c0f51af767mr2878343137.33.1791169845737;
        Sun, 04 Oct 2026 20:10:45 -0700 (PDT)
X-Received: by 2002:a05:6102:3c8e:b0:7a8:d959:bd76 with SMTP id ada2fe7eead31-7c0f51af767mr2878337137.33.1791169845260;
        Sun, 04 Oct 2026 20:10:45 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a87e31035esm36650811fa.30.2026.10.04.20.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 20:10:44 -0700 (PDT)
Date: Mon, 5 Oct 2026 06:10:42 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Reza Kurniawan <imkyufie@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/2] arm64: dts: qcom: msm8917-xiaomi-riva: Enable USB
 support (peripheral mode)
Message-ID: <3w2te74boo63yqbfgi5mwiu4rqdjd67nmb4ums7p7whucdr2gj@5l7euw4umfun>
References: <20260912-riva-usb-v2-0-997fe0171ee5@gmail.com>
 <20260912-riva-usb-v2-2-997fe0171ee5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260912-riva-usb-v2-2-997fe0171ee5@gmail.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDAxMiBTYWx0ZWRfX0U4bI7JgBEn4
 e5zIYCD4VpssM5X3nJJd1UHXZgibnXyNvcU9NS1Gv4lpeZIGwJEW94ACaWkp0Zsr71WWMloETVW
 qGV50EjxY7lIVqV1r3iwj2fiRtLJ6F7ah5C+8Fg2mVxD3kmli3CLarju3F8DONFCPJx0RPC+GZZ
 VQd2uxWvBe7GMM0n6Xq7trsGWARvZwDVKtFdaarXyB5sc+aeFu2iuV884E50yAR9VD6/VJ+8vCK
 C5By3FbKIYwhvcN9JL0PzhaD87zKuynQvIxjx6kXxu6l9nC5F6s/lH2uL9U1OO+S5BVAjclAv1c
 +aSCnjjkXNZinm/DNE26LfUJrdtTaSfVjQ3+3PXri3Kvj3cwqTVpUPImtIJMgCyDpJJCUqtT1gl
 Gr0E0CyTm4qEVgQ45OagZALg0mDZCiDglgge3gsoAvuAT3TNUkDF3tafJmeTW3AKvKAd7jOlnfo
 c+akOZBzmBrnnTns/ww==
X-Authority-Analysis: v=2.4 cv=b7MncdGx c=1 sm=1 tr=0 ts=6ac31536 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=AYGg-ij1XDh01NWh1ucA:9 a=CjuIK1q_8ugA:10
 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-ORIG-GUID: T5XPWoFRO8TUz2nVmZRuP61Ha6SCGlWD
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDAxMiBTYWx0ZWRfX9QFCQqVej85I
 EBklsB64T33G8JozN+jw4cT1pOzLKLuv/k7KdxVls8Tq5wmxN8ZgQqHGesbo/6y0LMRw1A0KZqK
 lu3bLRI+O3i96/nsc6bCj2AOe+8SAVA=
X-Proofpoint-GUID: T5XPWoFRO8TUz2nVmZRuP61Ha6SCGlWD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_01,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 adultscore=0 clxscore=1015 phishscore=0
 bulkscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610050012

On Sat, Sep 12, 2026 at 10:18:12PM +0700, Reza Kurniawan wrote:
> Enable USB node and PHY. Since VBUS is wired to the charger IC, also
> set extcon of the USB node to inform the USB driver of cable events
> emitted by the charger driver.
> 
> Signed-off-by: Reza Kurniawan <imkyufie@gmail.com>
> ---
>  arch/arm64/boot/dts/qcom/msm8917-xiaomi-riva.dts | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
