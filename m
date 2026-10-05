Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A541E32D6
	for <linux-pm@vger.kernel.org>; Mon,  5 Oct 2026 07:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791183655; cv=none; b=DjnciufELXAHa9yiFqmby9OWqUrZoG0snxdGLtJD4f9koGyxpNlKJjflA28l7G2qJCZVicA3it/BCJXTdPHHu3ibuMpufKlcjz/ettppbBMn6jdzKPMgy7QlxrTxjepbBuFtvFM3/QujkeiiJIqmK4+EEUZALMJ4dVKZmbGn4dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791183655; c=relaxed/simple;
	bh=hIL3L/HH1tlkPJXoLUtfGubULcEn3sMJ9QTXWNymtkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qIvbH+KH1W7kG6l/HLvuEAw/lixAPz4YRNDjm3GJ0fvAox7/grM6fJvaO0TGu/hfoUCu+DHdV772ENMneQHHcvCrf6vwJgJPCsvUPhS6ubM9NnIImSxb2+ctYDzW9qoqI1wCFdxXV7FtBQtNNHCHkbKXZ7qqW/8tBStsVJpiHJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TO9qK2Yv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jm934QOR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TO9qK2Yv";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jm934QOR"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6950xuMN3241164
	for <linux-pm@vger.kernel.org>; Mon, 5 Oct 2026 07:00:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sh7R+NUGgsXzLSIuUgY/DFj6UIp4Kh2aWWltC6nO4e0=; b=TO9qK2YvAJizDVKg
	mQz4xkmd4zuusiXCw2TsJ3i8hshS/poy6j4mT9Hmm3sJT5e9PcvY+6gLppIzptM+
	wcLzK6ePu1cFZ2VCpWwQDXOcfG6UQEZ80B0O/0r2hnThyRA02zZMjT8ehDX03juO
	xhdNkiHDd9TgxTuGrhvM+Bkg4Y5eb9SRrVwLniN7jy35f6vV2eh9ngado8lfLjUF
	dpQ8Y7yfHX0iZM98ckM+b/Fq7D3ZHAxVNlJdtIwwaUI4+uxtaJM9Q0BNUN5iq5/s
	AIpIxvIM7hxmRUhOGN53rgGdgUTSGFbthNFN7H2jYwtKGj5uGXW6J/HFRx7oBwtq
	nq2esg==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com [209.85.217.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h2tvevnxf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 05 Oct 2026 07:00:53 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-7bf45382794so1434350137.1
        for <linux-pm@vger.kernel.org>; Mon, 05 Oct 2026 00:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791183652; x=1791788452; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sh7R+NUGgsXzLSIuUgY/DFj6UIp4Kh2aWWltC6nO4e0=;
        b=jm934QORdtI4iGTsrtKDtvIH4nWTRxpitUbQgj1F27aoFkawr6A4NYDawzkvmx+ELx
         38rglaazhLjXpbzhBIeyv+ejVkHiL5lp1gf68YOTJsczkpFTKTf/GMjyI47zyxJbSfKO
         18OS7ravyu08A8YcEuZVppnbFLjoa7I/GmkjT4HlyNEebxXC8uBmDAskSxMotUoxnWMm
         +11ELP1hqi7vNG72KaLZgUlPZyWAOu+eq8icIFszHeF8bjyQWRp26QdMKFQa0GuTfrNN
         BkELJH5XIXPtqdcmsPMwck1jF6HCIJWjOH17jEiegQTRDmG5/4E5aH/yPZWehvkVEGZx
         5d2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791183652; x=1791788452;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=sh7R+NUGgsXzLSIuUgY/DFj6UIp4Kh2aWWltC6nO4e0=;
        b=Ond/qLBtlH4FwSDza1xWZpwr5R0u3i8cyQh59IE1MVJLmNaB3OxTfhsxo/uqRSOIPa
         lwJ7yZV1B6z0OoHNv6wQpksRAHqF+nvQk/rTtUHYuHQqglorzEcj1UZZfQXwsPQ4/OcP
         wbj3bX2Duv22mU2E13lR49VDLEXNTSDOd+VPWh9EWic2MzCCJOR1isf49WAKtJDy+w6m
         wHzB/+FrGEGiDjK7dkxvNifFEbna49Y9ae+O38Vp/rMb53JKReLqWtp4Cb8JIo0avSR+
         Er8KEbLdxJfKyZYYQzg9cjTa/g7cqgjy+XL+mkVqHlDkOpk/szXc6jt9f7nG6H7LVnfA
         5gKw==
X-Forwarded-Encrypted: i=1; AKwUvBxRraIyprLaB7ldGPdAim1bI6/sUTWBTYMZbFCi6if+YpCm0ZjMDRTB5WXtNJsYtKS6KQM/cbsf+Q==@vger.kernel.org
X-Gm-Message-State: AFq9FYLBjgXMNdwBWZxfwisXisVpy40mSnz13RHQSs3vHbuf6kW8X/IH
	ZcvGcPqRT0AV7f5SpKuRpPIIVhfaIOHxAHh/x1YEPlwz+Ao9npTqbHbC97iErhRXokNEDrBFPqh
	kVVGSvEtVygT0nDlF7Zmpntei40BtUYyKfgqrgERVVb2uqY3gVLhkItHvjcTT6g==
X-Gm-Gg: AYBFou0QUO3O8kxT5rMjRan8a31A31GH5lzKkiwxHPGHsVQx0LlHGGb65fjweyWgvo8
	/PbNKrYskLclLY6gu1SX8FsmbNdj1OGR5qQjKt2fJlU1W2kqbFSWbfQLWU+/77TSd9eugzHp5uq
	ZAy7IDlrK19aTEfCW2XQv2+7QPA+WGdY8rwovZqRQmc2KM6EC4FNRESPLZWkQpdK7ABYnuN84f1
	Dw9S7BRx/aEXSdFK9Ig48YQLR5qGUxeSK6w2rLktbYYeMB3CpvniCLxCrhZ124GBw5592plkivB
	1cMNYMle9UrRyEpN6BQATNSrLB/kEpPkgAGd2QLaXfKAKZ9Ha5GypSh4UhrQZzCiSgpGfMP1ery
	lRVksVTbU+HYcZVG2PyAdwdoQNIiNIBoYhmqvLe8a74Ynb7HTgbUlnqoA+tmKMIoKeK8BF8eadq
	E/i5L7II37/3c5
X-Received: by 2002:a05:6102:41a5:b0:7c3:7286:c28a with SMTP id ada2fe7eead31-7c37286ca05mr1191224137.19.1791183651944;
        Mon, 05 Oct 2026 00:00:51 -0700 (PDT)
X-Received: by 2002:a05:6102:41a5:b0:7c3:7286:c28a with SMTP id ada2fe7eead31-7c37286ca05mr1191209137.19.1791183651392;
        Mon, 05 Oct 2026 00:00:51 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a87e2f7fcesm36896791fa.13.2026.10.05.00.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 00:00:50 -0700 (PDT)
Date: Mon, 5 Oct 2026 10:00:48 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: =?utf-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <barnabas.czeman@mainlining.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>, Ulf Hansson <ulfh@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH v3 1/7] dt-bindings: power: qcom-rpmpd: define RPMPD_VDDMD
Message-ID: <qwedh6ykmzp6hs6n3pcjtsvptuh3oisj5xumi6idqlc2hems5r@i2vtyrwuheg7>
References: <20261002-sdm632-rpmpd-v3-0-95c47d0f26cf@mainlining.org>
 <20261002-sdm632-rpmpd-v3-1-95c47d0f26cf@mainlining.org>
 <20261002-devious-mauve-wrasse-66bbeb@quoll>
 <d5e9ecd991990098a4f1724750ed47f8@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d5e9ecd991990098a4f1724750ed47f8@mainlining.org>
X-Proofpoint-ORIG-GUID: 2vVVbKCCgOSjzixCBYKwPUIuOxkbpR8L
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDAyNyBTYWx0ZWRfXzQvolr4IE+qH
 Ww2US2ZOUwDNPcJiTRG6FQCgm8sKbYvOZltZmVkGaY00g77cgg2QIDZ3KYNp928x3vfPHZyFpx5
 qgUdIYv8f1ZSap+otBX+2qf+8HxKy58=
X-Authority-Analysis: v=2.4 cv=YoGa1IYX c=1 sm=1 tr=0 ts=6ac34b25 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=OuZLqq7tAAAA:8
 a=1Us7COI9vatZr-rxjUwA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
 a=-aSRE8QhW-JAV6biHavz:22 a=AKGiAy9iJ-JzxKVHQNES:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDAyNyBTYWx0ZWRfX0turr/NUxxvY
 E9dy4m8mEoPPtQzArJ0hwYvauFdEN+BBgyXBDTkuXlSNqEJXxtrmAjH0+Cf+xJ2/QoFv0butrbf
 84RvaMUCIif/Wjl/xkK3XjuHM+Ip19gfLxZIh7jwFcF2N7ThO3/HYHky1R9rhULy+1kDed0FE5L
 kjYFGQQ1Bcn1dO1dc8FUe31rgVHr0HFoh8q2hUxhKUoeJWiiiSwQYayPKDVbiYa8avdVYcmjVgg
 1qbwZfujim17LLQr6WIw8Y6+kDovrw2erJz4Tdzrzl8JB35e1fvgUycmwZDPVrOxn65bBQwZtsp
 yWDtIisxSueZFNjYMKGO17QCSAzn0nUQMny4FjCD0qoAnYq+PoATw71vG/r5BoNIPjBYB22dm64
 d1Kr4yaIFbpSyxfGo7GtELeVAWfF1mtgfZyWVMD+2GvxZT9zyxfPRlpqWAsA8KCKqmx6lLyv2q3
 BB9ByLCiBiIXUlnGKdA==
X-Proofpoint-GUID: 2vVVbKCCgOSjzixCBYKwPUIuOxkbpR8L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_01,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 phishscore=0 suspectscore=0 clxscore=1015 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050027

On Fri, Oct 02, 2026 at 04:04:50PM +0200, Barnabás Czémán wrote:
> On 2026-10-02 11:57, Krzysztof Kozlowski wrote:
> > On Fri, Oct 02, 2026 at 12:38:29AM +0200, Barnabás Czémán wrote:
> > > Define RPMPD_VDDMD can be used for SDM439 and SDM632 MSS.
> > 
> > There is no sdm439 RPMPD... The SDM632 is added later and bindings
> There will be.
> > header come with the compatible patch. Squash these.
> You have previously commented how that is connected to the indices.
> > 
> > > 
> > > Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
> > > ---
> > >  include/dt-bindings/power/qcom-rpmpd.h | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/include/dt-bindings/power/qcom-rpmpd.h
> > > b/include/dt-bindings/power/qcom-rpmpd.h
> > > index 4371ac941f29..beb066b3aa8c 100644
> > > --- a/include/dt-bindings/power/qcom-rpmpd.h
> > > +++ b/include/dt-bindings/power/qcom-rpmpd.h
> > > @@ -15,6 +15,7 @@
> > >  #define RPMPD_VDDMX		3
> > >  #define RPMPD_VDDMX_AO		4
> > >  #define RPMPD_VDDMX_VFL		5
> > > +#define RPMPD_VDDMD		5
> > 
> > Problem is that it is platform specific and comment in that file says
> > "don't do it" yet you do it.
> It is not completely platform specific and if you have check the previous
> reviews Dmitry was asking me to define it. If i set it 10 what will be
> very safe for every platform i will get warning messages.
> By the way 5 is fine for SDM429, SDM439 and SDM632.

It's not fine, if we once get a platform which has both VDDMX_VFL and
VDDMD. THe whole point of having this generic RPMPD_ list is to have a
set of indices which can be used by any new platform being supported.
So, indeed, 10 is a correct value here.

> > 
> > So the device has nbo MX? Why commit msg is silent on this? Explains
> > not much except repeating the diff and referencing users which are
> > almost obvious if this is properly squashed.

-- 
With best wishes
Dmitry
