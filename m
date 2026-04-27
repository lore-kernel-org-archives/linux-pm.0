Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82EE13382E7
	for <linux-pm@vger.kernel.org>; Mon, 27 Apr 2026 21:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777325240; cv=none; b=mfqUxoypuMzPd82JGWH0js49WzMCITMLnrwCLL9/OY1Tg2SZnUJ6CtXL1WFcANH1AqK5zDgKUDTNmsQvSa/lX5AEa6My6Xfhc0/I0mpL6S76PiScuybO4F9NRaCzEYFPbbMs1GUz61SlBNCGqnz5i6X2bTyOYzuk6BM85JVjrB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777325240; c=relaxed/simple;
	bh=2dMK2CeWM50DA/cKroIjF36jz4FWNs0gFTQMNXDpw/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N0VB8e5CC3VvY7xYhirHqHXGg1zxMnTiQaa96Pfd51hXpXalg/AVP7nAaH4tQKxUJzSaozb6HqpwALYHOIFWp+nReVpIuubDjvElGBsMwt0HqLH1tI43zDwhkO+oXMvcmAyrtMn7UZu0EshW+lbPQqHWexTDwTU0Jxr4bvWGKr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=B4r7U4pu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dZHVVVPQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="B4r7U4pu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dZHVVVPQ"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63RFLGBo440351
	for <linux-pm@vger.kernel.org>; Mon, 27 Apr 2026 21:27:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=0eM6T8roauSQzRuBmRoVn2bg
	U6085UljmY4Iu7OUuRA=; b=B4r7U4puMg2NvvaNTLi/06KcuLeGhcqlfXtBwSvM
	aNzN/rUrNYqn5h2fCmHg2lsaOFYiheaFwtxrPLjSGk1frKXNykvIAkzFQLUKErpb
	ijfcqznKwBem2NziHnaYFViat5FXW6OirNBXw/u48kH+9YQU5IFxr95Y5LDPJGuz
	WzdCXYm1kjhBI2FpJwYJGsevoeid8GV5DJU2Qwl2Y+nDEgkr3DDgQkNpR235XOAz
	if2coBXOPTbUAQuW3jLTtY4uUiNe4/BsNWQYbG6ECflmJgwFremtfzTY/yBrfK/H
	S30M6+5csLFp3DrThA2gKK1W3Pic5PM/RVZw1Lx5NZapBQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dtac41a9y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 27 Apr 2026 21:27:18 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-2d889997495so28547388eec.0
        for <linux-pm@vger.kernel.org>; Mon, 27 Apr 2026 14:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777325238; x=1777930038; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0eM6T8roauSQzRuBmRoVn2bgU6085UljmY4Iu7OUuRA=;
        b=dZHVVVPQKlxHCmiwZj250keaz+vzvJLLElWM3Ujy0h3ZywOdng6Ftwe0q08yphZca6
         t7arUpGaMsbQJDtmscfdrTQxPI7c2NhgHA7zKjs1Hlie6xKLpHavuqtdVDiHwfmvCmjv
         aBssNG0/c/HtvXP/Ym14IUlE23JZaSxwDGDozNZsQ2/tRhCkb7KYoW0muZUdNplGDxTM
         wtVQPbiQTt2sc917c7R32EfAKlP2HVV4+gGpaqdmxSxNlbjsBCIvss651bPw5M8BliQ4
         VrNRQ43HLPpS1jRMa+JvnwxwCBGVGYiAgi3QxmWft9ImDAPnTgFUD9SKVh7i8p1ouELg
         HvOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777325238; x=1777930038;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0eM6T8roauSQzRuBmRoVn2bgU6085UljmY4Iu7OUuRA=;
        b=LYV/MQcE3bbq9BuVGus8RKZozWc21PkayDHSmDWWh5d7Xp8i3dJ8f7WjrxJT+CocPR
         Ij1DwUaoAtp9ciMjtzw1eiW+oHHvJDd16rGmfzvaXQ4cIwZpb50RPcLt8zF3v9MzBEf0
         YXy58DwR8d/7fvV515/6987TkKK1wkejjsHN0zuP+jqOCxAAB00udJUHzH5f5gCVXoyR
         LoBoXg3E4tFADy2YE7r3AnsYb9v39MB0M7HMEdqXt+J5C1WN4qJiN7RwvusFCIgJAUq6
         cPJy6v+vBI2sBnzybyngW1Rlyjbr+udmqOG4lkZTNhWpBWjMVRog1tpOl7oq3HExmyoI
         ZXxQ==
X-Forwarded-Encrypted: i=1; AFNElJ8u3yVO3oqCCDW7tHEzor2byAHENcKdMV5qaAWel+u9KODuzjNdQHHCuwzWrJy4KQrqw1eXqbw7gQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy34qg9RC3nnjRsxM0bLZY1fAIaBM+kkkyJEf6ypa/gxPSrXiQ0
	U2yYoZj97f0tQ0AiWb4vevt4JrWIpPcsozdYWY1FeyHbwr8Wod78zt3Lj2OvVF7pMTvAuASiv4n
	Dv2LVrDyyhjoDn/PiLBKNFRzZwP0yffIdYtHicTwINcRcdi6dupLnqz7CL+urUg==
X-Gm-Gg: AeBDiesxCETNEMBeA4cVQPwy4cOwJ3Y8j41TMJbI1IOyvbt/YclAidwJ09P8Zk61Cp1
	P2P/EAK88yMIcJkrYOTmByddAX0eb8bodOVBuqlmDLgFTZYFfqda4s+r2graprZ8wRhbd5XA5mk
	dEFIsKS4pcsO5cfM4M91FIeXeJtjubyikXE2R+zLdtx571Er5D9LOzwihiOTN/Bp1vYsNc6wJKK
	nSj/yuGF2XWKR79tnqkGFSk1nlC9AgiiYaUjAWjheB4LRupBcazMZL5YkgPN0f2Z53M4zPgwO/c
	glZkP508vu754R/tWEbA3kli+UAMVAm0xv0hKc8t00QSAUAqUmxv7et5TEr7FK9YC+ehcJIBYB0
	h5kG8lOHxS0vZmGrNFr0TZnm/blzhaMZSxrFzWe+zglRjaGR+7srWtOwfYBuXjXIk/R+x8iurzH
	leyc4+3/fi4w==
X-Received: by 2002:a05:7300:73c7:b0:2e6:e504:5435 with SMTP id 5a478bee46e88-2ed0a015a63mr320149eec.12.1777325238222;
        Mon, 27 Apr 2026 14:27:18 -0700 (PDT)
X-Received: by 2002:a05:7300:73c7:b0:2e6:e504:5435 with SMTP id 5a478bee46e88-2ed0a015a63mr320133eec.12.1777325237697;
        Mon, 27 Apr 2026 14:27:17 -0700 (PDT)
Received: from hu-mdtipton-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ed09f8a909sm690956eec.4.2026.04.27.14.27.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 14:27:17 -0700 (PDT)
Date: Mon, 27 Apr 2026 14:27:15 -0700
From: Mike Tipton <mike.tipton@oss.qualcomm.com>
To: Vivek Aknurwar <vivek.aknurwar@oss.qualcomm.com>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: interconnect: qcom: document the
 RPMh NoC for Hawi SoC
Message-ID: <ae/UsySqVB+UaahQ@hu-mdtipton-lv.qualcomm.com>
References: <20260409-icc-hawi-v3-0-851cac12a81d@oss.qualcomm.com>
 <20260409-icc-hawi-v3-1-851cac12a81d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260409-icc-hawi-v3-1-851cac12a81d@oss.qualcomm.com>
X-Proofpoint-GUID: 4lOYSQZR6n9d6WOS98dg6IOfzL7Kk3kG
X-Authority-Analysis: v=2.4 cv=D7J37PRj c=1 sm=1 tr=0 ts=69efd4b6 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=leQ04dn23ONfhV9bpxQA:9 a=CjuIK1q_8ugA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-ORIG-GUID: 4lOYSQZR6n9d6WOS98dg6IOfzL7Kk3kG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDIyNyBTYWx0ZWRfX2NNNemATrO1C
 3GEWWjkAVE+49DDK/EEQsDr+exxBSxFLUopKe5YIHwQTFsDnxMiLMVlKtMWiNfHzt1P2/aHyDAH
 azl9ufBEvv0LDda8LzTBEKAANydOeLHpuwH2tXh8HdQAj0J1j6D/kokh14j71sFCxwixkqJNeyR
 E1Exc9kZVwTHvupoxUxaL1mGPm3E8q+tCuQjrq1mjU8diottKpbPws1zBmjY05RfKrE8FewJNPc
 okoQsLomg8rktMiShWLDDxsbta4FX/EbfnPLnRmG0OlxmWPU6YyTbsDMnLJVdT+ZD4paAIMqL0Y
 w0f3cM5qqm4YElv00EI+OSyBwxeustBCa5Zsqz/xC6seZN7HNUv6vBjNxo7ddygxBDPnYL1mzlO
 Wq4u0xruzPaQZ4b9v8OUfAvMfiiUajqbEhkvVmHUK84cFIBqKJ2enTIJty2M5kOyK3uhzwltL+4
 7sfAcWkckmXOmc3SEsQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_04,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604270227

On Thu, Apr 09, 2026 at 02:01:37PM -0700, Vivek Aknurwar wrote:
> Document the RPMh Network-On-Chip interconnect for the Qualcomm Hawi SoC.
> 
> Signed-off-by: Vivek Aknurwar <vivek.aknurwar@oss.qualcomm.com>
> ---
>  .../bindings/interconnect/qcom,hawi-rpmh.yaml      | 131 ++++++++++++++++
>  include/dt-bindings/interconnect/qcom,hawi-rpmh.h  | 164 +++++++++++++++++++++
>  2 files changed, 295 insertions(+)
> 

[..]

> +#define SLAVE_IMEM				9
> +#define SLAVE_PCIE_0				10

We're missing the equivalent for SLAVE_PCIE_1.

Thanks,
Mike
