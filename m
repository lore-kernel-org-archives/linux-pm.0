Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792672093;
	b=SP2PiWFadNMuDfdkssc/JTkVl6sPXLzJGoAEatLzGDzmoTDDTYJB7LCjNhaO2SjJRztZ
	 oTr6ZTH8FXQuMO3iYmQs3bC0Lgy2Z5BVE3a27S54jm4GhSn/uE78CRzXWHmOMEB7/1mYb
	 fPDzTeKZTkXh8KLZVmpBS1xhsIaA3o4gCK0PWq+B3eV7Z4+GMujI9+FODtLtkf5Ql0+JZ
	 3wMb62G5cY7PrYjy89lKMH/AjiEhQ6WaAb2s9YyDkuR6v+wQsal5pLs67KPt/n/x79Hat
	 hQRfm+aQ1AzLU9VdbanLtxw1xTTKnMIfCKjarWHjWk8Hmarl7/GLaYjA8LRZuxpaqUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792672093;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=ffhVe/j6yRlCzr2Q00fG+yNfZLrhxessWH3dfhlXdzY=;
	b=yXWq1+jYjlmM9/rWwLVQ7sRN0QO4xZXU6fYO2U1KDAPDohaJeK31CaTPywOpMe0uyJ4E
	 eRKGGlxh+v069rV7tktda9H9zGbeJmMUoXxsR9WrrfNFNmWzW6bi2FFAlzcvj1cYWNmqt
	 BNgLUUHaf4HIviNrC4Z6lrhOpJDGC0Qpig4DXyK3ZYUeF4XI+nV/53OD7vg9wgdULddwu
	 rumFTUY9Xn1ABuARwXiJJ/UmWxBNjcI/1QORbooK9tJaHCMf2S11kk/xC2GTl8mMT8vY2
	 JHHxImcRcmU8WacTh5wMRF4vRlLFSe0qxzXhduqBkou22Amk9F28BDWgax0zGD9aZrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Qk7LeKmg;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="YDDvB//5";
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C81606A325
	for <linux-pm@vger.kernel.org>; Thu, 22 Oct 2026 12:28:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8C81606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Qk7LeKmg;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YDDvB//5
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69MC5sYi3758326
	for <linux-pm@vger.kernel.org>; Thu, 22 Oct 2026 12:28:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ffhVe/j6yRlCzr2Q00fG+yNfZLrhxessWH3dfhlXdzY=; b=Qk7LeKmgKfl8ASss
	r/S31nkFb5YhbcmUSm5td/BECe5v1/SgAUKL+3yoqW/lRibA20tcdz8GOCTejfBg
	SJnhc6mDE3oLYQ7nfvuFZ8AOxYLsPwr0r1E38ln8TXP18dG+8EWHGPBJlKfBr3fE
	VcGF4BIJOrqH5FDylxqT4Lq/KDCj1IJpqJhG5yfK7/MIdqpE/fgqBrq9Q/nILTw1
	IzY44rprRytmIoIGq05urfI+V3wtpeFQtS4HFrD3I/HhyzSUlG0u+Vhxnhui2rLv
	qbPfovCQT1cJYHYgXzKW0O4anTJTXMj/jGOLvJ/icvRKkqNw4umV6qAIrYgHlM58
	W+/f+w==
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf93au7qx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 22 Oct 2026 12:28:11 +0000 (GMT)
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-80a4a17618dso1662064a34.0
        for <linux-pm@vger.kernel.org>; Thu, 22 Oct 2026 05:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792672091; x=1793276891; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ffhVe/j6yRlCzr2Q00fG+yNfZLrhxessWH3dfhlXdzY=;
        b=YDDvB//5wUrrsMjA+YOjITn6gFH07RI8ByXRGm5tbEi/x3FTKojCVivuRWJ8C5RsGE
         hpAN++kQIO2OzyiQI61LcvkrklJLzwQhpZe0FPXz+0w977W+VaOzM0xrifW2TDcLrySu
         ntOAlduDV/IVdjKapF8Sr0LDsRgzDICMUTekO0VJsHXE2UjAySxZ6INfhIbHZwZsf/y9
         otgi6zR74w7vRYgkYAy4l2d3R4CCVY9tNUrFutkieB20d0VTUXkEcX85/XMgBYH/YwCi
         7ePqJ+8bn2e1Jp2AVdwBRmo2ZNnqF/m/kfZDxOIoGZ6cgr79hzVrAZCvEoZwSqBKuQnl
         Dt6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792672091; x=1793276891;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ffhVe/j6yRlCzr2Q00fG+yNfZLrhxessWH3dfhlXdzY=;
        b=EDcaRedh9pU25npLi1jX92zdoiTywE/dgv0Fa3elyOQXFbg4cH0JesBG/jNwkafrkB
         voK7QngJGN/+B9Pn/YihXKc754XM6+dVA10pyFd+FguMtup3oYWxagKqt6KIwunu8cTA
         7d6Ubd8sjMJ1cdyh89TV/GxtOY1+6WN9Ky/S5u4HBoDz7LWLm1BHTqabrNRzjTUb45aj
         +e5DqAkgSt3JgEXx8qkiEExCRS1Eqsx0NtoQSzBfb4+JB6gOV25248Oj3LcC6iYYf8oW
         t78b/zXOCrQzKNsYLlNCY9qP17wwfH4FXD3eR+wVJyi7lXpD1IgEdwInxQj4HZnWHCEH
         dkHw==
X-Forwarded-Encrypted: i=1; AKwUvBzlRIDv2NdfQ1xU2l/KXVOtaqFfBSZoijUNtU5cdW+1O4EbI9DKdOiZ53gsmAtRnP0vINao6yGU9g==@vger.kernel.org
X-Gm-Message-State: AFq9FYI4bEwBA0nwckjpvyzbXs5WF4UgVhs37dEPZM0ykSq5g1tYEdsv
	5Wf2CzSJKtF1nKL6oV0qjw6BRKvq2nmaUrs5oBQh4do1MZi2dabKQ3oldxVIb9LAdIGyW0fXeI+
	LjH7ue7Md7/ob8PzhlVMYRb+p4HpGJ+qQw/3IC+UIX5zvMIwt3B2IQiio6wXHrw==
X-Gm-Gg: AYBFou2ofFwVlk7uuOA3t26SAzYu49wNDB+4JFesxzOZjfSIWHGbZRhr2vQyHI5prLK
	tUd9v6pEsfaecqhZS3aflAcZFkuUXnW42E+a1WWvMCsM5scxbPXwie1ciFODOHqDpIbmukSf/hr
	BVDFW6hTaPL5gwc00x0MC9WsRLMuK1aYzjzH41pOkLu5sjFnHrugw6FzmQkoyleMnbLIadvEwBm
	1FCYTPcdkvAgac0cEcold5hnm/RyawuvlH4jKlzBRVYTboqWSNk/QawkLuTLK5kto/AwB7Jh4H4
	h/Y25P6HS6WILVja+8uvz3HQLSZuALp3ty9U/3sBf0fnfF8e91g8QJk/DP2kKpQiys8CLYWwNFR
	WQ81aJmvQwRWWE8bN87Jm/6oUZue0greo
X-Received: by 2002:a05:6830:6f88:b0:7f9:555:1def with SMTP id 46e09a7af769-84e30c31e32mr1258616a34.11.1792672091144;
        Thu, 22 Oct 2026 05:28:11 -0700 (PDT)
X-Received: by 2002:a05:6830:6f88:b0:7f9:555:1def with SMTP id 46e09a7af769-84e30c31e32mr1258609a34.11.1792672090792;
        Thu, 22 Oct 2026 05:28:10 -0700 (PDT)
Received: from [10.217.219.98] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-84cbcdd9d82sm4892517a34.10.2026.10.22.05.28.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Oct 2026 05:28:10 -0700 (PDT)
Message-ID: <d6a3a783-c6ec-4f93-83ee-ce30848917d0@oss.qualcomm.com>
Date: Thu, 22 Oct 2026 17:58:00 +0530
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/8] i2c: qcom-geni: Vote for SE clock rate using OPP
To: Praveen Talari <praveen.talari@oss.qualcomm.com>,
        konrad.dybcio@oss.qualcomm.com, Sudeep Holla <sudeep.holla@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Ulf Hansson <ulfh@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Mark Brown <broonie@kernel.org>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>
Cc: chandana.chiluveru@oss.qualcomm.com, arm-scmi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-i2c@vger.kernel.org
References: <20261015-derive_clk_perf_tbl_from_perf_domain_opp_table-v3-0-5da1096243c9@oss.qualcomm.com>
 <20261015-derive_clk_perf_tbl_from_perf_domain_opp_table-v3-6-5da1096243c9@oss.qualcomm.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20261015-derive_clk_perf_tbl_from_perf_domain_opp_table-v3-6-5da1096243c9@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA0OSBTYWx0ZWRfXwltNBawNZFgK
 tG1k31J5HkIWBUMJr39UoF6jho0eT4nE/VND4YvkAFACawcXfhXO7WtI6Y9+Htu/fgGyGRIQYvM
 Xx03JpBtMB+xlhVVFEQj59ZDVaOMtvrnU1+px22u2E5qkk3dlXPpVrg0hh+l1PHVAcQBz8jVeT+
 FIbc23aPzznZNm1ucfmSd1wRim+Lr6WVftIRZQ0WdqZW+CGCNbV0puTSK/hcwg+Vdq3ZRJFQJsr
 uw+aI+OrD+OSRnuIdlSAVVk+w3rGyTQvt+RmlPgD5R7Qs3e5NRY4bxrLAFKHpcJZbfJiXHKnH4Z
 7KHTgkcQhiQ06z5KZkXKSxwTQOy5LqrfrMv4U7VY8Puj1Hb0ZEzwst+zHiJvHVpZQS68VFlwuep
 asNgVfjInFmOVHAjW7RSYO3MwWr8a3AGXEB/ZlwMzXsKmcCHdHvlEsLeH3KGDCr18XAY5RMoFGQ
 Ya3jnU7q6dnhvuotpCQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA0OSBTYWx0ZWRfX9ONbIR5LEq9O
 g148nmqHsOwQ1aymV8EC2WD8EP71eci0ZjejuDJbn/s0+I8SYd3E4uGG8u9iVRxibMZ9iqYj2r9
 7gGQYeGyw5m3eQkXD6iikQg+9A9znaI=
X-Authority-Analysis: v=2.4 cv=QPn91QLL c=1 sm=1 tr=0 ts=6ada015b cx=c_pps
 a=7uPEO8VhqeOX8vTJ3z8K6Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=gi_f2RLh3HdMVU9WvNgA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=EXS-LbY8YePsIyqnH6vw:22
X-Proofpoint-GUID: BQRhTITUpwF-vwBOTcJkbn8fvaqjDiKn
X-Proofpoint-ORIG-GUID: BQRhTITUpwF-vwBOTcJkbn8fvaqjDiKn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610220049



On 10/15/2026 6:28 PM, Praveen Talari wrote:
> The GENI I2C driver selects a source clock based on the requested bus
> frequency and programs the corresponding clock selector. However, it
> does not request the selected source clock rate when OPP-based clock
> scaling is used.
> 
> Store the matched source clock frequency and vote for it through
> dev_pm_opp_set_rate() before programming the clock selector. Also remove
> and restore the vote during runtime suspend and resume.
> 
> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
> ---
Reviewed-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
