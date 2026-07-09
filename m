Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1497D3DC4C2
	for <linux-pm@vger.kernel.org>; Thu,  9 Jul 2026 07:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783583791; cv=none; b=ZnJMdEc4d1YSDWt8D2Z541O0DvjzKeB6TDX3DFY/NGPDQm2Rs+IMzLQ4XmyBV3cH8QGUgbB+KDhXZUreHms4MMIZSJwFvig8Ob+xKI62+hdm9dEWaw/8sezseuwV6JNRrRKr9T5myH1hTkcn8pUnWwTmFKmPkSKCsRqYw/xqnXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783583791; c=relaxed/simple;
	bh=DrsO9+/TcsBnB6GcVVjgzMY7RlrO4vA2zjm03UqMC6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HABee43+3QVXxI3KzpadvJFYKPiTmW7+QrHD8PWvBWgg00IZToyf6EKqoRJ5EK6oG0FZ1pxMw1D8kYKZWShr02kQGntbaMEDQbzBFKNLJ3fdWmkLAzi0fuAItTmsMft+jqwm7rnU3B35zwbYCGS/n2f/9MWUBGgLjQrMPYvxlM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Zfj+Ek1g; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PB2f2j86; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Zfj+Ek1g";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PB2f2j86"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66960a4m837432
	for <linux-pm@vger.kernel.org>; Thu, 9 Jul 2026 07:56:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=tZzhSBXFUjefGXREmfHjGo5T
	SfL/nszPC7B8+7oKefo=; b=Zfj+Ek1gABNN/Gh5yAb3fIBha4HsGYuVpu2u51z7
	pXo8lOWhtZq9/pC+S95fWzlR0Sz1VSCLi+bS9GGHGz95//ISs3FRncWdIRjxkONn
	zC8T07vLI70Hkfq4pH7abbk/H6R+M6wWQsP8J8uODjvrBpJFEBD30Wnf776E7/dH
	wDG5Lxn1+f+ez/t5RWob2F0MGXMwW9f+85kyAIgxoYncPmsBDYPkwn1qSyx6VKWF
	WU+3GiLFVHCc4Adn8xMtSGyno/TD+4fGxLW1haKfQekyf0GJvH+qtb3E8x9aUn7g
	4o8U+XQAblrlXsU+VID/1QsyROrxyQtTtRBFHdz4gXT/Vg==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9sqwb1q4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 09 Jul 2026 07:56:28 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-738e5b5ef68so219251137.1
        for <linux-pm@vger.kernel.org>; Thu, 09 Jul 2026 00:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783583788; x=1784188588; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tZzhSBXFUjefGXREmfHjGo5TSfL/nszPC7B8+7oKefo=;
        b=PB2f2j86pOtBR33s+m8eFyFY20aiueKoxbk97p8Xs2Kd44X6RRNKuuBFIAxnf3yGPU
         FJCTNJIRtb9jOD8hCnRQQK3bxt2P5X1Om/lvsNS1Psdlazitv4CQnZQlvP+zZIbl1Yxl
         Zkoqq7xkXI/tufdvLd49/D8llqvVJwMCevjbGl0KCtJrRlxcSTUct9XvV9vSDbtEQHjd
         VJJXg6Rd30EqSQTXeWbKvF6ugvrlFnwUHcPIPdKBPuEACzmR37azcETlmmxTy3hUMpYm
         g3zYO5VJiHZB1YS1rXFAGxJ2e+neV1uu1sRSXRuBsQc+9u5bSjndrJTUGhGuFHNBJpm8
         BGQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783583788; x=1784188588;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tZzhSBXFUjefGXREmfHjGo5TSfL/nszPC7B8+7oKefo=;
        b=lmVx1B9mWiKyVaCjAx2zJzk9a+GDdgqmNfoXMfOgnReNjq9zozJZcMY9+qPxAiNkky
         P5PDsViPovaGn+y+dG81Nttgc+8ilEgkp4mpp1H/9WOQ/56b4z01Clzn8zJj6b/da0ms
         wbFDevHb+mB/yLPy/D1s6/2FTGB/KG2FgixQhZ8aZvUgSX4kTYq1+fdnv7W0Mq/b85FV
         eiKtPkdR77hkxZWNzQCAXJq+4BilmYZ6YSj2MQleAYtrY/+RB6E/wU42Q5jRwTXn18ej
         oQhsbsj8ZHnfdlBFQYbwqArWAaUTszkygFC9LgdeT2XUhV73uTv7bDHWK8Y6pl3bP1t0
         F+AQ==
X-Forwarded-Encrypted: i=1; AHgh+RqYYsLWMqpPRstPlyS5XoCKxw4Ff8JgP+oETx4YfcgyVYMazlqLL2zxxVCZU3SqvZw93WHMQLqVDw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxU8MhbLSg8tw8TaTe9La8+GY4yDuIUQtr+8IwAlGmamnBayGI8
	2jXCd7zYp+H07trWYuCwL+lSkqtB4TPffF5pFaD38stXlCwCxoqbezTcla5pLF3SJedclLh2Bri
	DO0ArfLfRN86RQ8QAicv/R2ikBMDq08afDdsbgA1JcIfNzoHc+lR3cMnUUQToog==
X-Gm-Gg: AfdE7cmc7GFQ+Lud8gudxbBvPBIDJ+LfNu486WXuRGG58zWpn/IOTq1XDe0lVtQyyQk
	KJAmvAMOSDxP5O6S7ytaqcsb34tPq/faRwsFAEhtnVWWqJNyoMsTh70sOpFXQEB0pF+v/pb0Tes
	uNkqwnQIEjB3fmi2iqoV9RFJGuQJFWmdyFTt3NmlJi5kM5sL+dZ9qAgtfwEKAbXmVasKQD5mHH4
	049m8rk5+whKD313PQb9aliBybg02kotRFK7R04Skbn7ku6UuSLu5qRJ/QkzOXE95U5FpAwPsrJ
	uruzQdiDrcSZv23MSChsxmmt9cD/8yJSFyMQslPKv/0wp4bJ1Dvd1BmiShoA7muvQJ5LX5fGcfO
	8suWgdzyKrKP98B/l7DpOqUINql04cRVjp4PkRZzCdLyu8WDibwradStPJYNLxBGEPPVkIJOEgs
	mYJF7O3hZ6D8upVfAXgGhmf9P5
X-Received: by 2002:a05:6102:418e:b0:728:68cf:c76 with SMTP id ada2fe7eead31-744dfed2a9fmr3555130137.23.1783583788126;
        Thu, 09 Jul 2026 00:56:28 -0700 (PDT)
X-Received: by 2002:a05:6102:418e:b0:728:68cf:c76 with SMTP id ada2fe7eead31-744dfed2a9fmr3555108137.23.1783583787538;
        Thu, 09 Jul 2026 00:56:27 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aed1370110sm5020603e87.9.2026.07.09.00.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 00:56:26 -0700 (PDT)
Date: Thu, 9 Jul 2026 10:56:24 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Wei Deng <wei.deng@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        mengshi.wu@oss.qualcomm.com
Subject: Re: [PATCH 3/3] power: sequencing: pcie-m2: Deassert W_DISABLE2#
 when no UART serdev is created
Message-ID: <gatls7n4xes7mrnhgxwsjof7owpocdmjrvuxazedznwa3zeb22@q3mtufc5dzkv>
References: <20260709-fix-hamoa-m2-w-disable2-v1-0-5e725091266a@oss.qualcomm.com>
 <20260709-fix-hamoa-m2-w-disable2-v1-3-5e725091266a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260709-fix-hamoa-m2-w-disable2-v1-3-5e725091266a@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDA3NCBTYWx0ZWRfX6UoplwfQ2De3
 45cOJqYkX9i7BmFGkUsGJ153dP1zbxk+R9m5GIPxj9ASFS5Fd+e1uU/7dazYHGqlZTTaU84qC/1
 irwbKpAndnYajDA02Y1bs7LQMsopigMlgNC6b73Aci6PwOqWBxTqPjc0Z+ZFtBfD35DCfzZtvgR
 4/4n9vU3GbIv1Gj+eJ+n24n/cEFnBvSNsjOoLbRVPb9jyhg/J3QLnl1Z/jPhOfO4wd/H+7F6s/Z
 BqE780Wsu6gh6SzETqHpn/bvAH7DAXy7i7Emr9JLwBqfgZWhGzI8Q0fVWMkWjIHkGgZW4fRqFuj
 FDAsB7OUIgK3VbLjpKX5HNSNbrGuR6HsQpXjIaG/9HgnRfCJPPj3hVuU+15Bo3oAYWRjCoc1UpE
 X70hExa4T1NhyLPqef7NnGCm6PoXmVVHxaCNI0aWCm8cvpZmBmorHxup/PRjBJLbJlXpLM7Q+2Q
 Ykry7shxh6nDopjntfw==
X-Proofpoint-GUID: 90FgUSHpY73vUhXIgiDbuEDa5epZ6XIU
X-Authority-Analysis: v=2.4 cv=fMIJG5ae c=1 sm=1 tr=0 ts=6a4f542c cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=lIAhulC54n7EYnaILX0A:9 a=CjuIK1q_8ugA:10 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-ORIG-GUID: 90FgUSHpY73vUhXIgiDbuEDa5epZ6XIU
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDA3NCBTYWx0ZWRfXxowjjLCQ6cb1
 QKC/ijr4mJ9GsGuUfLOm+vcqmjuRunYzXi+NFjPnBNIxyOzm8go394Q3To7Zsf3o/CXmlCXTknY
 tMAnd9Ia6DSmzAFlrK3sIRzY/X6pvIc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_01,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 phishscore=0 clxscore=1015 impostorscore=0
 spamscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607090074

On Thu, Jul 09, 2026 at 12:59:42PM +0530, Wei Deng wrote:
> The pwrseq_m2_pci_ids[] table lists PCIe BT devices that use UART as the
> BT transport and need a UART serdev created by the driver. When a PCIe
> device under the M.2 connector does not match any entry in this table,
> no UART serdev is created.
> 
> However, the BT subsystem of such a device may still require W_DISABLE2#
> to be deasserted to power up. Rather than adding every possible non-UART
> BT device ID to the table, add an else branch that deasserts W_DISABLE2#
> whenever a PCIe device is detected under the connector but does not match
> a UART BT entry. This allows any BT interface on the card (USB or other)
> to enumerate without requiring explicit knowledge of its device ID.
> 
> The primary use case is USB BT variants of combo chips that share the
> same PCIe device ID as their UART counterpart (e.g. WCN7851 NCM865 USB,
> sub 0x3378, vs NCM865A UART, sub 0x337c): no UART serdev is needed, but
> W_DISABLE2# must be deasserted so the USB BT device can enumerate.

Instead of forcibly toggling it, would it be more sensible to tie pwrseq
into the USB too? The onboard-usb-dev implements the same idea (of
powering up the USB device), but it predates pwrseq.

> Reassert W_DISABLE2# symmetrically when the PCIe device is removed.
> 
> Validated on Hamoa EVK (IQ-X7181-EVK) with WCN7851 NCM865 USB card
> (sub 0x3378): without this change GPIO116 (W_DISABLE2#) stays low and
> no BT interface appears; with this change GPIO116 is driven high and the
> USB BT device enumerates and comes up via btusb.
> 
> Signed-off-by: Wei Deng <wei.deng@oss.qualcomm.com>
> ---
>  drivers/power/sequencing/pwrseq-pcie-m2.c | 33 +++++++++++++++++++++----------
>  1 file changed, 23 insertions(+), 10 deletions(-)
> 

-- 
With best wishes
Dmitry
