Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C08A3D0934
	for <linux-pm@vger.kernel.org>; Fri, 31 Jul 2026 08:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785486279; cv=none; b=JaphHATS4ckqf5VHi0t9XokTZEeIHzrDQY8Lg9sb6gpP3ioieXFBXbkDhKYu8r1mvXNwSrxgh+oBVkvYUV1HPkTnb8mguauOROUBmDbSBHxkijtMXz0K8aEX6ABTGPVc6UTo1axbzqULCGJ9FJM1dKNvxUzmQrhm5CqqCubRez8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785486279; c=relaxed/simple;
	bh=XQHWU4Sfz1Ec70VbB2iTXlINqT/lml/fJx8mYlhLP18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dE0V+ymrevr9lGvNDEkzklVD17OPaMlfYi05tGF3vxMQ0XSXuA0/y3dR+wZixPyOQzdF6os0dAB0r+9X8DJV/t0wcFIkvQfgwwI6Fek0t/ejtT2hd3BTjShcTGmrBXWAxxVRBTCo5bsxvQlr873xD4eYU01b1IRWst4dsacv9mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bQ0dltdB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Jl6QBf/H; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bQ0dltdB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Jl6QBf/H"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66V8NlWg3941065
	for <linux-pm@vger.kernel.org>; Fri, 31 Jul 2026 08:24:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=vit+XptqPqCCnxhnywKX7IwS
	S7nXFK9HQm7gueLuEL4=; b=bQ0dltdBamKNK3T3QpavxRkpXeIn6V5eandPz93V
	/wqQPhDDFSoL2fyZRMy/3uZJwD0D0djNZwWjziXvfbRp6HMjZJDE/B5PanHvIJSB
	rhlCedDYXJ64AGRefUmijq2PG8VxwYEpx5up7v45axWVnkZkdtd7ux/WadtPBWjS
	7cQ/N2vhUeRYUczh17QvQh/gHbzzzosRYXtKFx0uXWWdWIGrROw33Q4TBqzTPTo4
	iB/0t/BWBRI2gMvGYXW2YheJA3n2qkSbv6I9yXaCaLLbA6nWI8A8HKi04ATS+rLM
	jxTOTVgs3AxlTRlGJZQWLnxFO+p1WwK9Pdb8mV4/ASdYCw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4frr5k002m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 31 Jul 2026 08:24:25 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51c1eb52e1fso12287161cf.0
        for <linux-pm@vger.kernel.org>; Fri, 31 Jul 2026 01:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785486265; x=1786091065; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vit+XptqPqCCnxhnywKX7IwSS7nXFK9HQm7gueLuEL4=;
        b=Jl6QBf/HwHFdAHUvd9CrPuZHayrgW0IY2GIIgxJ8swwCLqsnSYtoy6qvXkHY+bUDpL
         DSq+5XeEC5nTudob+Hb08vkFotgHEECyh5ojVByZe/xSR8vp/FmfR9O26NLplee3/UFm
         BF8b0I4P7IJQazY8kA/fio/3xflblcgigkV/6J0psDP92M8y69KfZbqQsDV6dGlwTw52
         rhrLXmmG2cD/mYmY4EGBgO/15vzoqe0vIoRXhFzdFFM/1fwxXgZE2nHP+4PocWszYW6A
         wlVp9nM8p1f6AkmEknvLlkWXYODXDe6oETkfeeySweYOEXRLt6np5jXPPA9/TLWpgQW+
         RgZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785486265; x=1786091065;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vit+XptqPqCCnxhnywKX7IwSS7nXFK9HQm7gueLuEL4=;
        b=eRAyFqEgSIWT/+ixNrsUWVfc0eubL6cZTEufWeuOZk+oRSvK1aLLGVAl6nre3L7Aq+
         Wy2EpPr+Wy3/VUKAB2HPMMDcAUK8uW/ErwQ1BC5BCfC76YxieGBaeDl5SzzHivkVbEEf
         eoKtENJfvgkP3QuYWqSaBXPMY5b9HHVHuZGKO2P1JTYNcNfmR80G5qAbS+2Hmof+TihR
         pX0Vyh42zOZUmXcKuIOkO7WuW0QkH1BXXxqW/rHLtOGHnUh5tuMs/uFQu32e9evRYvMN
         pgQFuCnWShjbbInTlrPVig71kJ8Ik1SfHTSo8BS7BMg4Cfho8xPXuLPRYv26evonP7d7
         qlsA==
X-Forwarded-Encrypted: i=1; AHgh+RojpcMOGw1w3re1soEJAbbHcc4FUAuJ5lOfVu/Ab4FPYBWhq6nf5kn94PnpZk/VK0ZlVBofa6K4eA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyUKnTO1WtfZkivRExEUPlqlLmer2FXTRnqx5ws43BKAJ7jriDx
	uxavwWUsB1XemjtgXZTRXM6ga3AQl7p3V7Nlawb/KbiBSuzl6Y9Q9Z61yp03tVhrMVgirxbEFGZ
	9zGqu3dQNrnkFe/01IvlsQ25kQmNvlpm42heBPQMxbbSy1sFy9znx5uqD6PddPQ==
X-Gm-Gg: AR+sD12cImiIMwWFEsYykkT2fzPLAIb7D0EXJ3cf0vm7j9CpSCYs26PmFg3g0VbOEsF
	eVr0MCgrMG1jlWYE3qnAlSmpTPEOQQfBmH1WNSyDz1yJbuYa1qXJfPF6j1cKGfsRrgC68J5astw
	UHyd3b2ZCb/pMeWMpYwpbKQruBX+w/vCREYAxknGPVVtQNRwc5jXCH823NGvY+wv7EsxX+s8FoS
	3oxVja14A4EYCvP4aBgqCyhv5aEJnocVYXoLSQMiIuKmKu74U3EDe3iwA2eoUZZEcAgRgGynG3l
	gZ2OCIu0d2kFB0XpaSa+NyIFi6Kfl2Vmg1LlAmDVuRdeckmM0eNpCVfi6k5W0Kw0Tt2BfThRgw7
	ma8oFEgQTUKWEU9I=
X-Received: by 2002:ac8:59c2:0:b0:51c:a8e2:57a3 with SMTP id d75a77b69052e-52b4afc08d5mr12936771cf.28.1785486264474;
        Fri, 31 Jul 2026 01:24:24 -0700 (PDT)
X-Received: by 2002:ac8:59c2:0:b0:51c:a8e2:57a3 with SMTP id d75a77b69052e-52b4afc08d5mr12936381cf.28.1785486263923;
        Fri, 31 Jul 2026 01:24:23 -0700 (PDT)
Received: from oss.qualcomm.com ([86.121.163.114])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd45a0d7csm1963043f8f.35.2026.07.31.01.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 01:24:22 -0700 (PDT)
Date: Fri, 31 Jul 2026 11:24:21 +0300
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: Re: [PATCH v7 2/3] arm64: dts: qcom: eliza-evk: Add PCIe0 with M.2 E
 key connector
Message-ID: <azz6axjfllmfdsxu46swm6yjxnhg6f6tpxhxjf7byryxw47vq7@wmmorb2kuerd>
References: <20260730-eliza_evk-v7-0-7ac7b66a3e6d@oss.qualcomm.com>
 <20260730-eliza_evk-v7-2-7ac7b66a3e6d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260730-eliza_evk-v7-2-7ac7b66a3e6d@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDA1OSBTYWx0ZWRfX0kZ29KyzZcCp
 vc1xyaYBunHBmBQKdCwQtG/esye8HVugEdt8Mfz/5HTMxbAsmgvNhlKmaKpuYlJVpHaooCeeo2A
 LinW6nR0iZK32CA/5pMGghbxEPxQtL4=
X-Proofpoint-GUID: BrjEKmOMgDrvfyhWPQejA2cRre3HAJXQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDA1OSBTYWx0ZWRfX49QFTL4pSGOE
 cn753Am2KkuEpVnXdfxzFj2G3osF+RaSvDy9HXf+IQEgmyfU8Md3MEjL/8L0fEBaUZYi1ugbk0v
 myT7X1RDyfJviNYHTXIdYsPTVnH6n/ocFlumddBVA30sLNaiia+btbmczyVQ65DaXQLBWr7Xf8M
 D1BBAinCvRClayUNSQwEc6EdESglTCSydicFCif/XzxddC+ImO8k93vBaJqE3Dz7KY57VP4pKqm
 fuElN5JtK1n1mTVsSBGc1BqSpZODyOZS0D3/Hgstr9tDiqyzgAk41T1EAvP8tdy37flbOiR3ukU
 /SETv4wvqzHZhO7kLyUn/VvWGvBxkb1kNJ/DE6W+OsZ+qbdf3bsajteBB0YTEMp5iSUV5D5EA8h
 BZRvAGtLElheB2VZUsralsCP9wS2HaSyTut4dO1Y3k5sNvbNYfqUQB/tTv672bksQFqM0Npeich
 6TdmpibzyI+j154F1bw==
X-Authority-Analysis: v=2.4 cv=S+npBosP c=1 sm=1 tr=0 ts=6a6c5bb9 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=6dw9+iwJWV8PcCi9M4lOBg==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=adJbRHicXYsKkr84VsUA:9 a=CjuIK1q_8ugA:10
 a=zgiPjhLxNE0A:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: BrjEKmOMgDrvfyhWPQejA2cRre3HAJXQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_03,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 malwarescore=0 suspectscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310059

On 26-07-30 17:30:17, Krishna Chaitanya Chundru wrote:
> The Eliza EVK board features an M.2 E key connector connected to PCIe0.
> Enable the PCIe0 root port and its QMP PHY with the necessary RPMH
> regulator supplies. The M.2 slot's 3.3V supply rail is GPIO-controlled
> via a TCA9538 I/O expander on I2C4.
> 
> The M.2 E key slot hosts a WLAN card connected over PCIe and a Bluetooth
> device connected over UART. Model the connector using the
> pcie-m2-e-connector binding, wiring the PCIe root port and UART5 for
> the respective interfaces.
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
> Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
