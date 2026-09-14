Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3552414413
	for <linux-pm@vger.kernel.org>; Mon, 14 Sep 2026 08:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789375812; cv=pass; b=BkK2b2a6NzqqvR51YhvLlzgTh+vFy+zEOYYCG3JfskxdHPW+kRCBt9UL/wm8A7NmdI5dI6N74RlQJqYtDbOmf2PVKiygVACxF/pkZnJNk9cJmL8R7jnxhUqVw5AwnmvugT8zxNs4GRT2lBjXSCbF02rO1ooG7GudDPbAjIXQu4Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789375812; c=relaxed/simple;
	bh=rURd6TloKr3f0GtmYotAt/Lt132i4nJ02pnGCrda06Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YE5wPf6kTr6b3/OAr0H+OCBsIuOj0HGFKmn09I5NOWVJOSdQc9fdpybPtISo6qU1uCZNJ88EWS3rYzgL69o/SecA1ESuANi9rmohFhgk/DHGD8Ii88q71ZyY9VoylVR50da2CT+xzkOQlXk31+wlsgshc09Y1y/lZ5aep4fqVLQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UVcAMdwb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gIGQvN00; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UVcAMdwb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gIGQvN00"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68E7S2ob3351621
	for <linux-pm@vger.kernel.org>; Mon, 14 Sep 2026 08:50:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rURd6TloKr3f0GtmYotAt/Lt132i4nJ02pnGCrda06Y=; b=UVcAMdwbCwVGAbCV
	C+sUaDdDX+wSQ71/mmFXzE/+9fIcAZHzaY3fc/XfdVRB0NaaSP0FTc/4MgstqM9i
	si3Mf9Gz0rfrpoHnnL29Lxvcxul1FW2q/LrvaZU72WTE22DOmEuQqcE7sXLJ4nql
	RysRQcME7N72Fq8zodzLw0YqGXZ2HPtP4KN3XlDFAS4oTAGE27DHd+3Q0Sk2mdgr
	HcDGrJUw0yKoh4BLXGkfEu+jYFQpdNDIpOFZbGCEpjO/fzR/N9wHNjb1GT2HOSFM
	EAD5UqdxyBLXVJwigrgEiRRIaaseVJ8EKkFKtcsk1jj/AXalu8ePqYGRZ5iV3fBL
	YOVQAw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gpcjg09f5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 14 Sep 2026 08:50:06 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-939062ecda9so469971485a.1
        for <linux-pm@vger.kernel.org>; Mon, 14 Sep 2026 01:50:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789375805; cv=none;
        d=google.com; s=arc-20260327;
        b=PzTLRokis9in1lvUiPzjRoD3SC2gmdWkIJ8omaU+48FeKwt7LLmDK2uqyMW+exhsci
         YhYARPOJSPM5ur2n2hVSZyiiEKSw2kbtZJrEHhH+zHesqNuoIFfbCtay2UsmkednVaDi
         0ku6JuEcJuzhbgEIJFbRgjiL0x0w5OYyWaCz8QK98sKY5LRMefaMAJau/xq6eQ06q3Ph
         MtJCYM0pb8CIZ8WLiscI7UtiZ71UbK8M5XmmSy2z9hIgGbkF1keVz8YjHLkBX0hFRmbQ
         sC7W4JXsTQJ0XCyVE6pG0A3OBo+G9DHsCPdf3V0DZzdY8nhBLnF9YgmqRXJrLM0n1uKT
         BdsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rURd6TloKr3f0GtmYotAt/Lt132i4nJ02pnGCrda06Y=;
        fh=TrZyY1Unu2I/I3WRWlnlpAnkNAXyfe8u+0ZWYGlx85U=;
        b=TImbMqOh16fsh3H2cul+WZAV4wH/6JDPlpMisbtBt8cf9vMZN1Vd7e8L37BTgaB5Bs
         2MJ6d9uMJYM0tx7PUsfGBHWTqe6xP1ro3mFzFm+obt8HQdSG0w/zyGOW4/bfuZKdgq4i
         WBncaR9Je48Os3NbYHf3OJyCeCrFarPJF7kY46/SL3rn/WkZfKIAgZdwFtiTqaPPR1fk
         Syf3vRHoKTvZWhpsW3lLCH0mI3uiovg2zrlHEEH1gt7QbzNckbA5sqcGS12RK2p2wol9
         WXKaeq4duHqQHNTWVBLJ1u3hdg8oiW70N5k7IH26ZoZS9kDxqPDLVSsRNUP5Teg+8wPE
         NTWg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789375805; x=1789980605; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rURd6TloKr3f0GtmYotAt/Lt132i4nJ02pnGCrda06Y=;
        b=gIGQvN00XlJLIlrGcPqcLt7HHVIulIL64nwmJTXgneCQNFjmVn2g7wEZ0fzrW/2l6z
         kWff8ehsldkj4SlnTEFMq4A2Y5khFOk243AzI1o32GikMfmaI/v6Wr4i8ucNS7hfqi+K
         XrfUGRYWYxejsZnUTEfYZts/yvygqON7vSF1pCF1ecI5d0Q6V+uBcZ/4n1roS1CunWDa
         Kfc3IVJj8wuY0YvJbSaJdKqNedCMlP+fyzM5eKJNF860nauB7TM7Q8MxFXGuC598OGP6
         DUmtJfSQSwmIZE6QMQ1wXQ1UdFUVYgcUh+bZ9CYZO9oF0PkUTGcxCJ9nmimt1Y9mksjF
         PFKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789375805; x=1789980605;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rURd6TloKr3f0GtmYotAt/Lt132i4nJ02pnGCrda06Y=;
        b=cxf59d4wV9RH2Rvpi1Z8BrD7+K63MEXEDLog4Okp+QAulLDdutKsdcq59V7sG/k8pw
         1XBA0QaXSuxXqaTN5DrGsT7UtPd204ylcJQi7evk/Uwg84X3oveUzNppR2LtEGwBuqqd
         x1fHkhOPSTojL8binsM6JEOdv9eBHFZk9ScJmBhn4pEVffVl+E56LZ003z9A5zkH1kyA
         yIrRo/RinPOgfVB3ZXwrTc3LqQcdXkGYfQ9PutOVsGWKWBbWKXmKw0oJKENX/VRtj0Dt
         WHBmRpV+V3Mh9h6Zi84y134CCxWggk3WprQA4M9QuSF7NIXLvzLrHlJbuTV/4rigvFkU
         ir3Q==
X-Forwarded-Encrypted: i=1; AKwUvBwllrBbEzQhq94r4RThmh5sC0akQpYQ0y8/zAqz4sOAEYtsjCO1eMRLr8Wqe2vNE8F6tZZwlOnX7A==@vger.kernel.org
X-Gm-Message-State: AFuF++nf+SmkSuv3uJCMAuvkgf1qoTku+zhVXhDsxnEBdcw07H41o+Hy
	OglMJ/FToe0BLty+X6zrfw6S6waAlki06WkU+6bjzGtyN+64XJJ5khSNekBdifac6Ygsnby/zrr
	eGw5jQBFGhBtNGjS2S6QF01JZWrCqx1LYdf7lq2FwlYTJ7W2wtPOylC/GVqvYnKSeMtjjETK2av
	Teud3CDhSbAmjBcjklF+7a0RgblVuTEvhD1vEl
X-Gm-Gg: AYBFou2/+o15ynp9IoIqg9YfyBdkZUr/YC09ng81KvYcFKDyFpY09CpfJsvnZ5ypwFM
	vLeMi7C3bvff7JCLUCo60IBjyY2hfpon2VHovKjm09S8Bmr4Ax154go5j09jHJ/kryd1tftwY1H
	VkTNxDYse4STLbPgIkMfO2M8nBFkKE5oFjlRKjYIA/WSOUpappS/lBE7K+hciqew8PDOKweeN53
	vBfdVT2LwSCBIzDoVDTNAERFHGp3zZ6dHFh+lxIhq2jTLksPULCw+oNSNU8cPHYF41kcCYRp5A=
X-Received: by 2002:a05:620a:1b87:b0:939:9fca:8d2 with SMTP id af79cd13be357-93a2981322bmr224906385a.18.1789375805367;
        Mon, 14 Sep 2026 01:50:05 -0700 (PDT)
X-Received: by 2002:a05:620a:1b87:b0:939:9fca:8d2 with SMTP id
 af79cd13be357-93a2981322bmr224901585a.18.1789375804889; Mon, 14 Sep 2026
 01:50:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904-monza-wireless-v6-0-d8c5042b3efd@oss.qualcomm.com>
 <CAMRc=MfDAiUMzOYRWioK2NDM37=yQqb4pQ5ETZz1PVOKQhhdug@mail.gmail.com> <CAFEp6-1PuGMGkdfWYiUQnYffm7en8b-DQybg_4M9xw9MVDNRsQ@mail.gmail.com>
In-Reply-To: <CAFEp6-1PuGMGkdfWYiUQnYffm7en8b-DQybg_4M9xw9MVDNRsQ@mail.gmail.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 14 Sep 2026 10:49:54 +0200
X-Gm-Features: AcwNN1VznECsrEJUnLcouEQxxRZWOhGsAh6qOvyElwlmFiNZH_egy-fEq4m3Sig
Message-ID: <CAFEp6-3gD0xBJZOOmTw1MBex-DYo99MXHsQr_=uLABMHdSjaVQ@mail.gmail.com>
Subject: Re: [PATCH v6 00/11] arm64: dts: monaco-arduino-monza: Add support
 for LGA WiFi/BT module
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-pci@vger.kernel.org, Bartosz Golaszewski <brgl@kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Wei Deng <wei.deng@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=CKa/zhrD c=1 sm=1 tr=0 ts=6aa7b53e cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=et7816VZQgabzuuDM88A:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: Wd3vpQLQQMM5WK1frgKnJevgd71uYbGI
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDEyNSBTYWx0ZWRfX8s6Zi5/x/AS2
 r5AQ4edrQLMk2c7GNnPnSmYeZZeU5j+LZFNMLHEPWHKXJops3tos4x+Aa5xsiroDumzESnOnowV
 yhijz/SBkj08buQvVNvVGO/oRT8wqsw=
X-Proofpoint-GUID: Wd3vpQLQQMM5WK1frgKnJevgd71uYbGI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDEyNSBTYWx0ZWRfX+pBbG2tyGoja
 2pZzLaIbI2MrpXGJeL+CsCU1CQqEin9ZyBTvyByQ03D0s14Zjb4FXO26KnsbIDP85SyGd8/Beya
 5B+okrOAqWCl7Rb9I+aoBHfLqFr5TSXi9v/J5f58oPWLQ5Ekc3q/D3RObJWDjQ3PhmlH1UmBKry
 NbRJBjFooY+qnoGYq7Kl7OsP/wtZ57gX8vKM2cb7AbKVZJAzV231xf2GyERVF0EjT3ICizhEUt/
 F3uxydD1wznYF4xLJdSkOhWzG2bJg5twhr5sbpBxYIQyzXMeNtJYjpsuWgOCqeqOX40ZcvBZvwi
 ct1gME4AJ/sNKQNk2IQEtajmbi34GRubnMHa7cn1qT4IX+bQKTlhB+b+7Ts8SdeCfx2kPF1+/vG
 CgBcqpGaRYIeAg0RQc0mWywbuu5K9wDQ6Sw1kPe2PycN3nf1MH2wjZtsBC0Bas/TMN6XaR3m2MJ
 RjRfqnMi/++rvm8nYlg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_02,2026-09-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 spamscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609140125

Hi Luiz,

On Mon, Sep 7, 2026 at 2:50=E2=80=AFPM Loic Poulain
<loic.poulain@oss.qualcomm.com> wrote:
>
> Hi Bartosz,
>
> On Mon, Sep 7, 2026 at 10:24=E2=80=AFAM Bartosz Golaszewski <brgl@kernel.=
org> wrote:
> >
> > On Fri, 4 Sep 2026 17:42:15 +0200, Loic Poulain
> > <loic.poulain@oss.qualcomm.com> said:
> > > This series describes support for the onboard WiFi/Bluetooth module
> > > present on the Arduino VENTUNO Q (monaco) platform.
> > >
> > > The board provides LGA pads for a wireless module. On the VENTUNO Q
> > > these pads are populated with an NFA725B module featuring the
> > > QCA2066 WiFi/BT combo chip. While implemented as an LGA footprint,
> > > the design is functionally compatible with the M.2 Key E.
> > >
> > > The NFA725B exposes WiFi over PCIe and Bluetooth over a UART.
> > > Both interfaces are gated through the W_DISABLE1# and W_DISABLE2#
> > > signals, as defined by the M.2 specification and handled here via
> > > the pcie-m2 power sequencer.
> > >
> > > This series models the hardware using the existing pwrseq framework
> > > and connector bindings, allowing coordinated PCIe and UART bring-up.
> > >
> > > Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> > > ---
> >
> > What is the merge strategy? Do the pwrseq changes depend on first two b=
luetooth
> > patches (I don't think so)? Can they go onto an immutable branch shared=
 with
> > the BT tree?
>
> The pwrseq changes are only a dependency for the Bluetooth changes,
> not the other way around. So yes, they can potentially go separately.

Does the above work for you? Would you prefer to take the Bluetooth
change separately, or would you or Bartosz rather pick up the full
series?

Regards,
Loic
