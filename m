Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2838B39C00F
	for <linux-pm@vger.kernel.org>; Wed, 20 May 2026 23:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779321529; cv=none; b=LHXd1Nx9F3lCFUi5LBbHR5GMnBRurgApGhM2MnDxB5dOwbJxN44s7aYBYFuGqqI2+JF2f+s8h+t8ay6tFr68eRIwf+JZ1gSU2TX+XuVBV5LSsHQQrEXa1l7A3fx7FKtBjWGtlkTvJKIyqVp+8A1UWYWKDo+7R8YFIfvyAtpuTko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779321529; c=relaxed/simple;
	bh=uOOiRD/C+EHFgynyt39wxQXM82SqV00R2YSRUShCnmg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b1LzGdxaoVi48hPiaohMLQCCdo6KtxnRMMWGQQ0Bt64ZieNcdpHxbMVKdYm4vMjkpMiu6nMrxrdUiUKpl4qrdTeUhP3TRdo1vcArJQmbN7n2h8Ywc4UZpZWGOKxLE5dcMGvBO1Ushtgfo30Qmmb/QWvqEq7YzdJVi+kHuJsOKJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Is8k7vIz; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cSYjkTbu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Is8k7vIz";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cSYjkTbu"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64KJnPS0316969
	for <linux-pm@vger.kernel.org>; Wed, 20 May 2026 23:58:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=xslQDtl6G93vlsd/+8QfWRHF
	e5YOMqqj6g8oprL6TDI=; b=Is8k7vIzj9HFkHlalVxgYbkv/a5RbqeQBDLxixxS
	M0KirKPoxqByptR3SK9JoyuI+zJ8TYOWwxAtvLbLWS33d3N5MN2KgvwIbllHv0Sb
	9AHE11oqwf4Uxg1JkTmJrwuatOoSAM0HdDTrfhD/Aphmm5w0dvprWgrU2QW8EOUe
	aitNdxcPW/8yI8rZ9W+Gu9PSB1Z7/L21kSvqDzQBJha/TiZs+G1KPW8v/XVkNH9V
	n2rsy2LJGeMeL94PRS8y4nGLGDrvCKgKopABUt9yEQkaTysXPRSiLNGddofYZvgo
	ClhKzBMBZAuMhvsjxOegOrKR214CUwAcjQNTYKlDpTMkYw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9d5qtg5q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 20 May 2026 23:58:46 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-50d5d1c2289so164058351cf.2
        for <linux-pm@vger.kernel.org>; Wed, 20 May 2026 16:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779321525; x=1779926325; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xslQDtl6G93vlsd/+8QfWRHFe5YOMqqj6g8oprL6TDI=;
        b=cSYjkTbuteBoT9NErIP5Tyf+SmYqiNEcENlA+LA6CtDs055xNEhRt/F3M5RK8ygVGb
         DObBxe+njEmgl6N13U37DutffX7+p1ggXGKzi8X9C4acUDoJbZuNdXKlwE4rFRLRT09B
         lpG71cnyhfIjBBHXQZhSDJbWzo8C4nwy6H0Xhl5d5HukEOuk+I9XrI0ZwBjIJ6p2gPDO
         SIIaT+Nc+bxNWJwSmvLmJwYoW578zxisL7bTdyJ3miNt7Gw0hXgnD+ouIjC57pvfsQDH
         qZNX5cVxr5bbvtqo/d/Tilbm0SS3U2Gg9/+T6BTbf+5ypQwSa2c6dvSTbLvTBDc0GOPx
         wahw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779321525; x=1779926325;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xslQDtl6G93vlsd/+8QfWRHFe5YOMqqj6g8oprL6TDI=;
        b=LrtVsmZGrM8nyyg+6agW69uI0GLRaXfSwGtNg8Ql9d1kkluUAi4+2KkHYgTR3Kr02S
         eE46OqpHSWgpflfuQQe0HpXT9uMXrO/aki9q/5WWwGHATdYEf2GjH6xoaq5QYdfBTQmJ
         XZ+8r6rPL7tGXF4iUYYJmzCMjZnXEn7/vzhDOvNv4rGnZWNBJVTRhbHg5l+Hb3TqAttj
         hRxJIdISCBncId6QAMP6j80Lftx9EJJ8h76rt8csX8OVd7/LSSnonfNeuRNpjA/lrPL2
         qT8A6iE2bBSN2XF24YhXpT94upNH+2ZIomxh2gNRFMX6PXLQ/5vD/3iwdVo18+eRhlRX
         ACUA==
X-Forwarded-Encrypted: i=1; AFNElJ+qrfKw/sxuIkSyxNCX2XTq9p/T9qHjeqnO7lLfrU0cQ6jsfNQduOGb/vTLfmci2W8/vB7I9GFmBQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxNHhpObm2zSWrabxIzZrwAlleI4r4lQFSJye0rayVbnUWwvW07
	lln3z6z+iuy9awCFvxqGISbfrBQm6nYUemwCOzyfgeHjDFKrDw1CXIxEoS9RFhJcY6c2DSwoQSa
	lPzTDPO+KP1j3uXzGmglgKbH4w507riL0FgQWVi7CyBjrwxF8xY330os9qV0JoQ==
X-Gm-Gg: Acq92OGHAYZtvEimMQTB8srKD5M+S/c8dMZZWfs/XjuFVSSC/ZPCP8kMKA6tMQOmh+0
	/7ib0MWyunm6dkZPnAtJV2TJ0DHjyiY9gQ9HRY5tJeIqg7Pox8X7rIHcCUMcF8DrP7hE2fW0S6E
	LMwR/Q9XW2TzSOM4r5NtgcX58dRo6VpcgNrcrdxphANBubm85sZdykFRorNmhHdcF0Lz3yJGeFc
	Whtgo5M3aT5F9CaodIt+oFdo9Pbt1g2HU3xIQn9Rx5YF17izTL9bRrFpSKMnHZaObB97Vkib6hr
	mkoY9PoD06QKucNnuN4sFYXaC+Ix5qhCVJ6AJow2BcrmNx0BtbKsfJksC5tw5AUl8FWWYC7mwUP
	Ujb7ZuB5NmWUdWpE25/misX62bjcckLbWY2Uyu6y90IJcqoMfI/9oP3xiaWcpHMsIJKYsUvk8B3
	NZTO9XUSn9zSZCyGYkyikRv5p3MfMieKUfN7M=
X-Received: by 2002:a05:622a:1b90:b0:50f:b17d:7e57 with SMTP id d75a77b69052e-516c54d32ffmr9945361cf.24.1779321525369;
        Wed, 20 May 2026 16:58:45 -0700 (PDT)
X-Received: by 2002:a05:622a:1b90:b0:50f:b17d:7e57 with SMTP id d75a77b69052e-516c54d32ffmr9944971cf.24.1779321524875;
        Wed, 20 May 2026 16:58:44 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a9164bc20fsm5302758e87.43.2026.05.20.16.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 16:58:42 -0700 (PDT)
Date: Thu, 21 May 2026 02:58:39 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Georgi Djakov <djakov@kernel.org>,
        Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, sashiko-bot@kernel.org
Subject: Re: [PATCH] interconnect: qcom: icc-rpmh: Fix resource leak in case
 of missing QoS clocks
Message-ID: <vhpgkyasgtckugbf75vkidzacda2tg5qbqrgvg6rwcsjfqzy4w@pwf6wkoze327>
References: <20260520191953.190564-2-krzysztof.kozlowski@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520191953.190564-2-krzysztof.kozlowski@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDIzNSBTYWx0ZWRfXzlJ7uMH1F7Pq
 +qUXDXCaFn3WtmcaZkwzfD2Vt1Ao4rTjuXi5/6PLpfxMcRA+0wk7aYkJcx85qC8gqQ1qxotinwg
 P0MmPaxTbNA28DzxdE20OwfYMA2Rj8f+8CcLHuwpMyCXgh2LNUPGogA056J9aI1xxBYZxweT3En
 KCdiBlYZUGSQQhVVU1KcyvCep4o5nZ1VRA5LkS6Nf/NpPkFbU3IJ2DVCpNsEGvEzIZP8XO0HYdK
 YbjUYonclQla/pcLU6+tw4Xi6f99UrPjs0lFF+kMcAfbqZrHp5YlibKIaqoqy0Ie7unE1yngnwQ
 3Bpx9XkRCDM820wbPv5YmdE1vjMMoXdtRrKgtaXGo6FkwRqHmNJ6Y8vXYl1XbVCt9C+GII6NCeF
 NqFzLCAChiiMLk6EvdnkzWVY5PJFdntiMyTtnxPerNmeM5eAPDxAvGvZEfTkVRFNaWwqIpmKJh/
 Byh2iZesIDHQshWSJ9Q==
X-Authority-Analysis: v=2.4 cv=QshuG1yd c=1 sm=1 tr=0 ts=6a0e4ab6 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=efQzfd3GQAiEoQBuJ0gA:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: 1u03Agm_B0Q2ZkfSYJuGtCAaffRL_D4y
X-Proofpoint-ORIG-GUID: 1u03Agm_B0Q2ZkfSYJuGtCAaffRL_D4y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 clxscore=1015 phishscore=0 spamscore=0
 suspectscore=0 bulkscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200235

On Wed, May 20, 2026 at 09:19:54PM +0200, Krzysztof Kozlowski wrote:
> Driver defers probe if getting clocks for interconnect providers with
> QoS returns -EPROBE_DEFER, but it fails to cleanup in such case leading
> to both resource leak and potential use-after-free, since the ICC nodes
> are stored in static driver data.
> 
> Cc: <stable@vger.kernel.org>
> Fixes: 05123e3299dd ("interconnect: qcom: icc-rpmh: probe defer incase of missing QoS clock dependency")
> Reported-by: sashiko-bot@kernel.org
> Closes: https://lore.kernel.org/r/20260520190807.509871F000E9@smtp.kernel.org/
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---
>  drivers/interconnect/qcom/icc-rpmh.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/interconnect/qcom/icc-rpmh.c b/drivers/interconnect/qcom/icc-rpmh.c
> index 3b445acefece..56512989d1af 100644
> --- a/drivers/interconnect/qcom/icc-rpmh.c
> +++ b/drivers/interconnect/qcom/icc-rpmh.c
> @@ -324,8 +324,10 @@ int qcom_icc_rpmh_probe(struct platform_device *pdev)
>  		}
>  
>  		qp->num_clks = devm_clk_bulk_get_all(qp->dev, &qp->clks);
> -		if (qp->num_clks == -EPROBE_DEFER)
> -			return dev_err_probe(dev, qp->num_clks, "Failed to get QoS clocks\n");
> +		if (qp->num_clks == -EPROBE_DEFER) {
> +			ret = dev_err_probe(dev, qp->num_clks, "Failed to get QoS clocks\n");
> +			goto err_remove_nodes;

Well... this can race with another driver probing at the same time and
using the nodes which will be removed. 

> +		}
>  
>  		if (qp->num_clks < 0 || (!qp->num_clks && desc->qos_requires_clocks)) {
>  			dev_info(dev, "Skipping QoS, failed to get clk: %d\n", qp->num_clks);
> -- 
> 2.53.0
> 

-- 
With best wishes
Dmitry
