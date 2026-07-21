Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8600B443AB7
	for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2026 23:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784675558; cv=none; b=VNmLXvM9M6v5/f4BurJOZ7TWhSIGfsMQ577mvWgX4G0oatK4CrCyUvEt03g3uFrAsz4FbhAxvOkfLh/xJpvxZPvrxk/1PrC3uhA66S2F3mDl7Rg1aXxGLhwNscHVoB+KWzwD61alQYomO/eg6x1zMfrz5+/I8NdNuyacyPlArKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784675558; c=relaxed/simple;
	bh=E1xUp544mD8hGvP00uo8LYF6vpui1oe6A/h2MQI3tcs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=foRr6aLrrvC8lERbig1EnK+lTVZxjcbmFuN+ZU880iMbtNryKQNiRkFKzL3wbo71H9T3pbVwxXtCdtxolnydXmlmUBP33wmNSdQsRPAP9rG/XhFP0NzCq356M05NBIAw26Xtikmf6km5g+JD5m3VZstHX+yorZO2NXBrW9+kmaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TyjhpNuQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CpzEF/OJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TyjhpNuQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CpzEF/OJ"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66LMZEc73062002
	for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2026 23:12:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IF+4fh1OWmacQfGFecoHPZmQhHgE3MzLCqCvWU+XHF4=; b=TyjhpNuQp9BpmM/V
	hfQs5MsNOrBW1VnKtfA0geUyje2hqOzgCxZOTVB14J8kQp2pNW0lnHztMhjd0miZ
	WUV0rQLcB2+sOlmqMFqUgOlXTKVtdWO+28SbCedt24QqSUtxq+Y9zQclgnwh+/Lk
	ZTysoWbUNMJpkiV4aMXq+5a8NYnx6S4vk+8blIndxvy9Lr/NnADPPRIPPewNHLCf
	0+EWoShyXWhhCpCCuXE1h2QYuCVcZvJ6ugfBE2ofp/zGdYVNY2/d97wstKGHK8+k
	COMstR8LkOw7eaBhk8wgzgfabf788U2GzvuUEYubL0TlKoVPzntmaILtLebPUmDJ
	YH/4lw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjd6a97f4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2026 23:12:35 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51c0f0a0760so286630131cf.2
        for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2026 16:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784675555; x=1785280355; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=IF+4fh1OWmacQfGFecoHPZmQhHgE3MzLCqCvWU+XHF4=;
        b=CpzEF/OJpi2pVhyPFqSaRd2clSv+no9zjpxf82fdEcWRIEtZYwGL/wBE9rEWaHsiSH
         g4DYoyeq7SwVITyoVeqdkZcAslTD41RbfTz0QsMEFoXeav2NvXlvBwwrbGwOglSGcxsz
         IkzK8ZrKhGN/TWzh8OGG8gpKNATuWY+y+n2KhEJz+nq7JUm1rWcPclRWiFT0l3Fv9WZb
         NKhz60nzpXr4LQm7nIdo9FZ70KmmTqjZ9aZHr2i7ZtY5s1QEu108RDOUDuinKhkU0tlM
         2n6rGaVcplpYK+xospyMKcHJTutwVMR7QbNPGPjheu+5cUxlMiQVC6/FlwnAYjEWsao8
         YdfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784675555; x=1785280355;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=IF+4fh1OWmacQfGFecoHPZmQhHgE3MzLCqCvWU+XHF4=;
        b=YlrV4ZADFupLdu8RNpoudFhfmBPSssoXqbigJmXzmCjUndc4xFIFDsUM6VFNL8rq2Y
         gGN1dVlqtGkKzRI1D/aWazkVM0SmeauCv69T+TbcvaSXuj8kUfPGZOn+ZPcuR1z448NP
         mtRSZ9J66qi02ogCNnv2Pk6AxeSDvxZxPVwpUoVWQ4jFOCyWA8GDCMxGEBFmcJR3GaLD
         2gZk1SIKkkhzP7fXNypHATcnnrzUDngp48+ucJpPSKQMQTIp3IFt+2G1X8CO/V80rETj
         dD7FeD3J7A6W46bVFSCXYtQZd5pAUrbJdppDo3DotMGCHZurOR11afcabAGQ5EVLPtOE
         Oaiw==
X-Forwarded-Encrypted: i=1; AHgh+RoB+YYaw2aZQPyhjOar2qMae4yLDsvWUMWJxJzcGKS9SK8WnRaC/UbttaC9FegNe8OWXAOcMhKKCw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyndSZbLTAAvTY1YUQsBZ9EfK1vvIyAzzTAEo24JlxCCiNIgpEu
	X4/W2rvUFJeSnTmB/PpxRYhlHw1uFpeD7nn1cSIDX7o8Gt3tPBjGdlDwFOljTmF3xEFiEHtz3Pu
	hsAfjPZloACtKALOnU3araT5/It+kltmZd4FkpFICG1D8b3mCPrGHrMf2Wa3J0w==
X-Gm-Gg: AfdE7cnt8GpEIbqHFoROywrFy7kXkhnq7UeaUUfKDTyau9nWei328+MvMfS/pP/u6C2
	zYjT8ggBPT3vuA7xnJaaezJKRFesh+ccaue58QEZxBKCTGZnkRlfgciSuzKUM2wZBY9Xi937Ayc
	87y7xHubkqDS1n5QwHxVwTVWCAOZMUxfPXJsxKqpBIP3jErIUamJUs3GYT3Pytza67VfdKbhMC1
	R1P3Cg5ELwGUoV+LkvpBJcJ6a0hSpgIIsoZBy34LhAQfg17j6sm/bewwa40VKwzjSD9HXS8aEwJ
	UkHIywl604UAspA8i2/1pubV3dhtP4W/bG2pAnbC8cgzBHlzIaBauzaMT7B0S3ebQJrRhSZ26BE
	Iyv9e5a8u8De3bBElqWzm/NG/VzOU9TGqui6KE7PqozuaJ0k2X7GmE/Dmnid4GEocMv1PjlzPJj
	N4v5jhkPIS4WILug==
X-Received: by 2002:a05:622a:1e0d:b0:51c:7b11:41a8 with SMTP id d75a77b69052e-5213f959c7amr204205981cf.85.1784675554624;
        Tue, 21 Jul 2026 16:12:34 -0700 (PDT)
X-Received: by 2002:a05:622a:1e0d:b0:51c:7b11:41a8 with SMTP id d75a77b69052e-5213f959c7amr204205581cf.85.1784675554256;
        Tue, 21 Jul 2026 16:12:34 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b2a9bafdf5sm155867e87.35.2026.07.21.16.12.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 16:12:32 -0700 (PDT)
Date: Wed, 22 Jul 2026 02:12:30 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>,
        Amit Kucheria <amit.kucheria@oss.qualcomm.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Manivannan Sadhasivam <mani@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-hardening@vger.kernel.org, manaf.pallikunhi@oss.qualcomm.com
Subject: Re: [PATCH v5 7/9] arm64: dts: qcom: talos: Enable CDSP cooling
Message-ID: <wskpf27kmooybswypyzt2vcadh347rfzrd5mpjwrczjlxnsczb@hjlaoqbscupy>
References: <20260721-b4-qmi-tmd-v5-0-99620e07f505@oss.qualcomm.com>
 <20260721-b4-qmi-tmd-v5-7-99620e07f505@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260721-b4-qmi-tmd-v5-7-99620e07f505@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDIzOSBTYWx0ZWRfXxtavoZSzK89j
 O7BxiQX7Ut2l+wrocQh/sYIt2KQKUBQ1aJxlVRxslw0lhy7NqifWozdXP63kZhYOD5L1S0aAYRA
 WVSARnrmU5+/rj+1eLjowdlPJKQ7Rmq67367UacNuTlTso2TMC3NVdKVUgg8WNCyPg/cRi8kxF+
 5GY37zuk4+mRGtIdksgDg+4s3ooajjhCbzaOoTwsaxoTth7/u/ILvUdfYp6l3cDout2XfC9tP8o
 KOjjZXopZbqhDS6v9y3BMpsELje5x68nc1ukCDOqy962RUfSF1V0u/a+J8GPvA1Iik4CndxY2eZ
 6wq5F/nh0QYThgmHnqKdM5z8WkYIGLcoxvWljNwBmrZ0ZxXExfh3DiClyxj0i7kDQhf/UChSNzd
 FJw7o1TuukXeBCx1ay3c7/IMWyP4XdfW1GR2yTpkxCf3dzsbJHRSourRFWCiys447RMpXXRSVIE
 2yqurxbx/TqRLR6of/g==
X-Proofpoint-GUID: nRspzPcjxtiPkCCIYIazWna5jkdRzJE7
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDIzOSBTYWx0ZWRfX9GZmBvg69Zb6
 YU4FaPPIJni+oVYCv4LRXfrKS2/UN4kG+9XUBbjeCiIOlRcVRD3Rja7fX+qkJpXa9zbRa3K03cG
 82l2IDDVxzuqFD/vwE4udjHQTVyOBxc=
X-Authority-Analysis: v=2.4 cv=HvJG3UTS c=1 sm=1 tr=0 ts=6a5ffce3 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=_nN_CDt7C_a4776dohAA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: nRspzPcjxtiPkCCIYIazWna5jkdRzJE7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-21_04,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0 clxscore=1015
 adultscore=0 priorityscore=1501 impostorscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607210239

On Tue, Jul 21, 2026 at 11:59:04AM +0530, Gaurav Kohli wrote:
> Unlike the CPU, the CDSP does not throttle its speed automatically
> when it reaches high temperatures in talos.
> 
> Set up CDSP cooling by throttling the cdsp, when it reaches 105°C.
> 
> Add polling-delay-passive so the governor periodically evaluates
> the zone during passive cooling and steps up cooling levels when
> temperature stabilizes below the next trip.
> 
> Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/talos.dtsi | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
