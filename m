Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF4023EAB2
	for <linux-pm@vger.kernel.org>; Tue, 16 Jun 2026 00:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781569607; cv=none; b=mg9pbtSucH3ViEs03mOD1l5OSrDaZ4NKvW4go1gIrgT+ywnds6BFHyl6ufKiKR3OK1CWAKMyrIIeVqT0+rdw+f5NrHpObSoeK2PZLAZ0YqzhdHM6yiELPqw+uWPLCQXaJ2Gq17MoxAWhyg3Md7FdHBDPYtpFF4D6VkwE3ay5mGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781569607; c=relaxed/simple;
	bh=0TrEdUJRvXuitdwBSWjGtGrN0JNohG3HeK5r141lp2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bd5ifhVxsPjfyp7iE33qIBa1DAhMlo3vAjmCE8ZIzW57LDdE0+Qk/8sYzwfpOlPhqTbrk9ZEgD6u1vJiOuBb7C2fUqS6h4rND0DxKWNAyf0cLeUXH6pdqvNyQwTvHrerXlBpZJgdqOwu1vF3uVYeLp7Pbo5ox4hbATiNJaDwRJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mMyUv+U8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XmVeOM1U; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mMyUv+U8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XmVeOM1U"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65G0OKxY2093948
	for <linux-pm@vger.kernel.org>; Tue, 16 Jun 2026 00:26:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=2PULfDpM/oWn3b+RYT5n7mKC
	3htGe0l2sW/Vd8Ndc2M=; b=mMyUv+U8HmIqMyQxa7CCJ5jRFG/pk6aXjOLnYmKU
	FvgETP+v6v9agNp2dyEGkAixrimrf2zcXrvXHsANpgguPafynfNdycyYQ2uziEez
	5MgJnfOa01GACEp68bydD54dso5Do2qGT8BvM5mL/TqSV5aMo4w8H3DV7UUL9xW7
	GqDw7xUemJrbXqRg8gz/zuOl9fPetB8AT6BiaBP6Q6jefikr/vuD/IN06oveef6y
	/g0Ve40r2yIb+g2/fwxdjPM0gFXfV+4SHHnCP/rKogHOYUF+ZHVR+AkwWTcTk+sF
	nULqryoSpoRCYCojbpvW43vEPTZaE1Kl139ii58NPyWLow==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eter23u8b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 16 Jun 2026 00:26:45 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-91576c147a4so1011511485a.3
        for <linux-pm@vger.kernel.org>; Mon, 15 Jun 2026 17:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781569604; x=1782174404; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2PULfDpM/oWn3b+RYT5n7mKC3htGe0l2sW/Vd8Ndc2M=;
        b=XmVeOM1U445ulwE2RZklfaoObhWq2iYZpWAjMdCRq57aCk4Vng4zrdQmC7gIMQpwiE
         /8B6cd+pjWLGOR8more4U4Oh8iO+gK5SB1sVp3/K/hNUNh9Ec/x4jjo3/fZefu2fLCJ3
         rlie9Xpe3S4dbyzYhuLI4Umd5/UkUQCrpxkb1QhomcMy8T8GREkTKdT2wFj/MBwJnN9n
         gDgM6qAtbiOx/xp5qrCOQeKJHG3uWJQ4/Um9pOGfl5DB5IV88TIBz5FY3/v3OLlrx89A
         xZn1EYvI187W8BiZY05nyrbnd9/NqzTZbb0gg4/4umupabEHFHA+O1WhsPXAFOMZTM8N
         dYcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781569604; x=1782174404;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2PULfDpM/oWn3b+RYT5n7mKC3htGe0l2sW/Vd8Ndc2M=;
        b=qePAKPbDubXEtMzJfWGR5LJSvIxjpstFwF40NDebdrH1j6jdysRONwaFVXpXZpyeNS
         VqztIm45KWvA8RrQsHeUtR3r1YVypnqUkKXrDuY66Oy77NHqJj7+rRQZkaG50hlr4cNY
         v8zuLOE33812sstKeEDu3orVeiuH8jSkbJH1lDDt3bykyVWkRHi6QjgsHnRCHmxMTYdf
         g98Qkmb7oUEbg3ooATgitbdBsQuyHABZ9zTFSSExuaYAz5+zTyV12tXG4M3a7mO8Zs0o
         pAnSE0kN5bdQ2jWjxZXE3O7UeZu0n3rfwNJnLjoLIFffYl68FKne9s3JbszWnecvM3+c
         smDA==
X-Forwarded-Encrypted: i=1; AFNElJ856tuwStVwoOHmHXpoIJZxmQUC5QE4xnKlgOLcqyfR2l8UcOMfXQmDPckiLiFqFLe7+2WhGqpJWw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwupCFNe1c4kURoAHq6ysZSXuB7JU6sdlU9E/w6Nj9RtFqXVqzK
	Cy7kNztJnvvIeliaeJecg4UgoO5KjM54LxcSrw8p0CATZ0bWzdLFVDoOvflOy55ghn6QiQsw1zL
	2bryG9GGsMc7NZV0NFF3xG1c5UX9qRKooeNW2/KqEPw664AhkjDdV9VJNtZHFcQ==
X-Gm-Gg: Acq92OGGllaSucBI7+apQQrtc8/cM5bd24BdaCGDBGE1/LEdEgM3mM35S+0qHnX/tZ1
	iDNfM50AuneDgPRY8iitvV07TGGrxwLSbjXmkNuGU9bekGK+en2HlQ+KEic7efWZLClYCkQ6SGc
	kjWe1xGS39AfdAEl9GnVF84SKM2CEEahb+WjitS5EDbLZJW9Pcd9Vj/Wl5OxjJecsP5fHto/O++
	hNzYiY7Yw+amtZqnRWcVO5UWCS5D8SaWqmVgCUZpqgNKn+b0mAN2eR8xG/vSXArcN4zUw8D62nh
	vTi0yPJa2WNTQ32TFnuzDCS/cJaJfx0gpuFk+3y0McTE6QE93Pq/I4Pcd0oKxaUi7zJ1lq2ag9/
	AAcWjef4dFoTcpXOYFdbYa2IjyS7eLoBZhr4I5Xgcv06pywf8DkHnnuujTKTO6SCw/7CGw+jicC
	4nkDRC8XDp3g30A7emdzVWulHQtiVldz7/6Hc=
X-Received: by 2002:a05:620a:3943:b0:915:cf88:1e37 with SMTP id af79cd13be357-917f2a16e72mr2177767585a.47.1781569604534;
        Mon, 15 Jun 2026 17:26:44 -0700 (PDT)
X-Received: by 2002:a05:620a:3943:b0:915:cf88:1e37 with SMTP id af79cd13be357-917f2a16e72mr2177763185a.47.1781569604104;
        Mon, 15 Jun 2026 17:26:44 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ad2e161fd4sm3161734e87.14.2026.06.15.17.26.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 17:26:42 -0700 (PDT)
Date: Tue, 16 Jun 2026 03:26:40 +0300
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
        quic_chezhou@quicinc.com, cheng.jiang@oss.qualcomm.com,
        shuai.zhang@oss.qualcomm.com, jinwang.li@oss.qualcomm.com,
        xiuzhuo.shang@oss.qualcomm.com, mengshi.wu@oss.qualcomm.com
Subject: Re: [PATCH 1/2] power: sequencing: pcie-m2: Add PCI ID 0x1103 for
 WCN6855 Bluetooth
Message-ID: <hndyeomouu754rwevoigc2ai4ywtz5lhodizj4amjuyn4azjhq@f6ixgilydtg2>
References: <20260608091702.3797437-1-wei.deng@oss.qualcomm.com>
 <20260608091702.3797437-2-wei.deng@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260608091702.3797437-2-wei.deng@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDAwMiBTYWx0ZWRfX5ploL0pcxJva
 2CDjP4CqXWCv5nsyGv+EW0d9t/B69pKVhN2W4HiMbHO1rFf0yDbEE9/cqUqTFNzvykysQwZMtBA
 unIM6pLRAFCY8HzOiMT29WqcmfvBPMA=
X-Proofpoint-GUID: 7WNzOx-rzpqfbz3o8Ks7_cpfFUaBhzGA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDAwMiBTYWx0ZWRfXzYk0lYTldVr6
 /3L7OIqKRQyQfaxe7ttEJvU23MM5mWmiuTZ6Xzlsiscf4KpxMd7q7aYJ+UzgBTbZeBpquIx+0px
 bDcBxPszJs+H7yAXTeb/gT8/y36OFVfM2g9jKYa7vAT2Q4rTT2Vx6myt2LfN4lsr/ShsmpHNHbP
 r+aNBYBDpHSPOIOf6S0shTZ1iN0WvIxrob4QqArpaEClVHWH/5k8UfQkGJahKHA49g42rXZ0wC+
 BromPLjg8jLcs9yUQYWJEvTuM9P+Umc42jBTKzXMVnfj2cfsaRP43I7cQv7I6bg0n33OB50k/4q
 QRRBMtpHGh6GDNzOBPNGTP01xpK0x+AlINZSnUnuz67d1+U/pxvywQydATYE6CR4+lpPS63Ttwu
 JbFqn6jJJbsLwBWoSJkYAYpFlec70YzvHM/mN05i/q74xbuec91gNs0Dm7lSZvXrHKCinD9Wk/i
 3H0r8TF3RUXCJe9ms2g==
X-Authority-Analysis: v=2.4 cv=F4tnsKhN c=1 sm=1 tr=0 ts=6a309845 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=1WnTIQmyWdCf-KxfHyAA:9 a=CjuIK1q_8ugA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: 7WNzOx-rzpqfbz3o8Ks7_cpfFUaBhzGA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_01,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1015 impostorscore=0 spamscore=0
 adultscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606160002

On Mon, Jun 08, 2026 at 02:47:01PM +0530, Wei Deng wrote:
> WCN6855 is a Qualcomm Wi-Fi/BT combo chip that uses PCI device ID
> 0x1103. Add it to pwrseq_m2_pci_ids[] alongside the existing 0x1107
> (WCN7850) entry, so that the pwrseq-pcie-m2 driver creates a Bluetooth
> serdev device for WCN6855 cards inserted into PCIe M.2 Key E connectors.
> 
> Signed-off-by: Wei Deng <wei.deng@oss.qualcomm.com>
> ---
>  drivers/power/sequencing/pwrseq-pcie-m2.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/power/sequencing/pwrseq-pcie-m2.c b/drivers/power/sequencing/pwrseq-pcie-m2.c
> index efeb25ba9c79..b3af14464314 100644
> --- a/drivers/power/sequencing/pwrseq-pcie-m2.c
> +++ b/drivers/power/sequencing/pwrseq-pcie-m2.c
> @@ -188,6 +188,8 @@ static int pwrseq_pcie_m2_match(struct pwrseq_device *pwrseq,
>  static const struct pci_device_id pwrseq_m2_pci_ids[] = {
>  	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x1107),
>  	  .driver_data = (kernel_ulong_t)"qcom,wcn7850-bt" },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x1103),
> +	  .driver_data = (kernel_ulong_t)"qcom,wcn6855-bt" },
>  	{ } /* Sentinel */

Please keep the list sorted. I saw that Bartosz has applied the patch.
Would you please send a followup?

>  };
>  
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry
