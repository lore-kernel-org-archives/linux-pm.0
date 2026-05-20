Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADD23A4F2C
	for <linux-pm@vger.kernel.org>; Wed, 20 May 2026 12:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779280395; cv=none; b=c5LHKlcOksBw3wqRXQwocypX3ngg/ENPwtJFJtnv1wJc/gjgFQ8Ho/d1wndmzdpyaxtz//UhfoDqigC9KssyeBowSQSU/DU0ZfydW2otW9u6dHBfX+3njsoHfnHEUUTXBeiu2C0hKX+Wse/Bg337/nzT1h9o3wxZxlUW5d4LJtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779280395; c=relaxed/simple;
	bh=ahaoAoAfsp8czyJswnQ6gTgE2U8diksgFj2UHoFxnLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GNPpocHnTCKZgs04wnj5fxorlY7rEEwf7fkUSAp/yxpEy8lfZyqPn9LFPIVXt2cHLH1OULdzKDdDC8nyV7JLtlQHSOkmNAcM/8Gk59HDGvfDAaDle8YEmWMQGkk3WzeLfzrxevFyMaBQ3pqX8NlszazaPWlegDYLJE4cfnMkUEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RqQtJaJn; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IxUyttOu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RqQtJaJn";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IxUyttOu"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64K7Wnq61953980
	for <linux-pm@vger.kernel.org>; Wed, 20 May 2026 12:33:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=r8+EvyPcMgBzsN6slPXZwJiH
	2h79WpzRBRmrsT4TL4s=; b=RqQtJaJnT1ujdMIRIX3SFAv89d8UOCoHzQsXqPjp
	9XGxMLA6eJRNMGxYhFKcVLiBkLDOs05rGcTJ/3ks166K3ZaRrhVHcRRHBS7fOKtW
	V7U8S1XK2xzYkox97yXX3UKa1JgSX4U2bTbdlq31blgDXYECA7ElCCKLA+HALSGw
	Kgd3UkLHxEiMROYFldhxO+BUgu1Acc0cbchk3WwGjaGzqpHw3sXxrsX3o3kklUjh
	WNLLRwMlozUe0f7hsqPPFsIchMzDM+X8VDZH2eSPL8bDhujQwBv9QFwuSbiGjcs6
	QZPilXCOwvDPFTakn/e+I4H+VUd+8wPOIMfWhIguTCxjbg==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com [209.85.222.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e8t3xvqs2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 20 May 2026 12:33:13 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-956732444ffso9192432241.1
        for <linux-pm@vger.kernel.org>; Wed, 20 May 2026 05:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779280392; x=1779885192; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r8+EvyPcMgBzsN6slPXZwJiH2h79WpzRBRmrsT4TL4s=;
        b=IxUyttOuuXhIFZDOfI7mchffebSMBwV15e0F/dc4eLjc8dofgWrUKT/5lEkYoJicSt
         ePK3kK0CHYsZ1VNq7pL/+KM4GZ0sVDKM6Pm7011AR/MK99c5+xaWkRPXV1s7dJh2Y080
         tI/y4q4UXeqQf+omvRYonTxGRGK/XWVqgWAlQ5LzZ8M5MZYur4iyJk/70oCkUmHihdcG
         AhR58eYiuUQFt0djNwDby1aTleEbd+qB8JYtZTYrTuR5ezE2LylDBbQP87hojGait4wr
         JMtxnjOe3fyinj9V5UKiN0u/FBAYJb2fwhuAuhMPE+lVOAeTjaAF2gDY4BEnueZz5Ckw
         8nyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779280392; x=1779885192;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r8+EvyPcMgBzsN6slPXZwJiH2h79WpzRBRmrsT4TL4s=;
        b=ld3AYmvH/ENeai/Tjm19nfOJhWZz9o5BftJYGpKhIK4DL2/xtjQDyrELPOvp8oNKtt
         H56Dhg/IHqgS19OzEvjFvdlkpb8ScGbW+Ct1Qy0n0ECIf7/lrco4Br8ri8iJDpNt97x2
         qKq7d/fKSIrklNPX96X0lO/xd7DAJPCpCM0m3Ln6mrGUjeMAXS/JdnM4lZQ9wmJRioE7
         T3hwRjSjyy3rmfj2qVUjmyp7GTXvLuU6EfKdXaULJAe3s3N5dsqhLsh3W9Doj19T6qOV
         JkQXlVQHqK6cC3BMn4GomYbrdPcJJ/wTpHu+riilxAoqVZDAvF2atsym7s5Zmr90U1Yu
         VifQ==
X-Forwarded-Encrypted: i=1; AFNElJ8d2ltjuboffdd/05ZWb4kVa3qUt2vu0Zwh6OPGJqATVP4zQanHMiO1B+fp8gXNVuIC8l+jtOP0RQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzAjv7xz2sCEua8togK9wAqF6ui8f8ehpPNlOEalaqJO+ZZ7Ji2
	eCJGfPiJ+LNCWpz8uHUvPJpeNAQWmBdNGz1W798mSaOh3jUMRZ7/HexDsQDpyVbn+oF4J/NG9Mn
	SPf+iTotpURhCfJI7V6ldcv4IQO/kgq3meWZNdOflO6oZAtFeWxRM7uvw5ZdCfA==
X-Gm-Gg: Acq92OGO6c8qPiwqEVTFd2veJSKaa8Rp0l4m6dOR0Mqsm3xf/sBe2RcYNBCF8jBiNlK
	pWljmdTJ7rkRsHwvwl9bbfWL+Ixr8JXJM4M+zqfj2RDxpFAgGLtB6lIDkiFu4mLLfvEW2OH01Dj
	1uSv7LCDqMyHHabbhtL2AaKP45+VbmUKqKG3ekM++j4EaVI37tBBCp9G9F9rcry7hsv6tccVCKT
	AWJ2+zVlsUnIYkSw4Fhck+KxNsW6N075UjU2b6s4pQReOD7JAqdJ8vV05CbLichJU2m4i7/E+30
	sHyEWWN95e0jcQLkyOg/A1d4C2TheyilCWFFaHdituEvysVn7ZIL8KAWMxU2Fkv/0QxFRDSLMYV
	rAnDc9ud9utXyOzfUcg9sCcMa7QAu/c1tZ/WD453sMvvDbB3RUOItj7ZtbKQwJtygghrEjBN2l5
	icvd/zmuAWMAlNfdTb7PwPPCTaMpH8u9u5xNs=
X-Received: by 2002:a05:6102:41a6:b0:636:984a:1e5d with SMTP id ada2fe7eead31-63a3d4294famr12951554137.11.1779280392322;
        Wed, 20 May 2026 05:33:12 -0700 (PDT)
X-Received: by 2002:a05:6102:41a6:b0:636:984a:1e5d with SMTP id ada2fe7eead31-63a3d4294famr12951537137.11.1779280391840;
        Wed, 20 May 2026 05:33:11 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3958874fe01sm30639941fa.23.2026.05.20.05.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 05:33:10 -0700 (PDT)
Date: Wed, 20 May 2026 15:33:09 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 2/3] Bluetooth: hci_qca: Support QCA2066 on M.2 connector
 via pwrseq
Message-ID: <cx3pbr47tsy5mnag73oopkodnx4jgoiipz5pzrp4uze7mk4fgg@zogzww23ueni>
References: <20260520-monza-wireless-v1-0-9f6942310653@oss.qualcomm.com>
 <20260520-monza-wireless-v1-2-9f6942310653@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520-monza-wireless-v1-2-9f6942310653@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=WaY8rUhX c=1 sm=1 tr=0 ts=6a0daa09 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=2I_6hNrxhXWvIde2sUgA:9 a=CjuIK1q_8ugA:10 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-GUID: FSbzQZMDkd6sphYxy2zkdEwqDT2m3Cd2
X-Proofpoint-ORIG-GUID: FSbzQZMDkd6sphYxy2zkdEwqDT2m3Cd2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDEyMSBTYWx0ZWRfXys7Tu4DtzJQ3
 7harwiWZM16EUUWRx1H3kaib/je3YH4hnIm14VlPRbZ9gQk01vte2DNi0ekEWxUqn1FskMn/FMU
 QgftFZlB8dsLI7JsPI1LW2tqo48lBuJimCbq0edFj07cLDfl6eCupWEBDryken5oBAmV00lcDxR
 YXTSSKjoJeE9NazZLwgvdD4ERoM+/E98iR64rrtgJo5pzHIxS5B3tAPC9BR1YIYSUcpFCClSpSl
 NevaSSLwDmIhULceEWPLci+QNd21dHaOtcV1IBJs0+iqxJAkCDP1SRekvDGcGKt80M2Uqv+1mju
 G2vxJpJzdk9GX3GlAIYv6+RcFw1dsM7frdGIa100VgMaWoMcZcLM05hRZMyqOHTw0NhukQVPd1j
 xicd84mgmeIpMOR4izjmzKCsJVgVCK+LlPKhv87eMBrZ6/WhcnsR7CDdnMSQnK2ro59IjFwWadr
 rtK0fu2Wlw4Twc6WGzQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 clxscore=1015 impostorscore=0 spamscore=0
 suspectscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200121

On Wed, May 20, 2026 at 01:01:43PM +0200, Loic Poulain wrote:
> For QCA2066 (and other QCA chips) on M.2 connectors, the UART enable
> is controlled by the W_DISABLE2# signal managed by the pcie-m2 power
> sequencer rather than a dedicated BT enable GPIO.
> 
> When the serdev controller has an OF graph (indicating it is connected
> to an M.2 connector), acquire the 'uart' pwrseq target from the
> connector's power sequencer and use it to control BT power instead of
> the bt-enable GPIO.
> 
> Also allocate bt_power unconditionally for all SOC types since the
> pwrseq path is independent of the SOC type switch.
> 
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> ---
>  drivers/bluetooth/hci_qca.c | 33 +++++++++++++--------------------
>  1 file changed, 13 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index b5439b9956cfb0497e6ba6ccd9ed61224d23a9dd..de5cba7b7f44e280a48dad5d670fa2758d3268d0 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -1873,6 +1873,9 @@ static int qca_power_on(struct hci_dev *hdev)
>  			/* Controller needs time to bootup. */
>  			msleep(150);
>  		}
> +
> +		if (qcadev->bt_power && qcadev->bt_power->pwrseq)
> +			pwrseq_power_on(qcadev->bt_power->pwrseq);
>  	}
>  
>  	clear_bit(QCA_BT_OFF, &qca->flags);
> @@ -2415,25 +2418,9 @@ static int qca_serdev_probe(struct serdev_device *serdev)
>  	else
>  		qcadev->btsoc_type = QCA_ROME;
>  
> -	switch (qcadev->btsoc_type) {
> -	case QCA_QCA6390:
> -	case QCA_WCN3950:
> -	case QCA_WCN3988:
> -	case QCA_WCN3990:
> -	case QCA_WCN3991:
> -	case QCA_WCN3998:
> -	case QCA_WCN6750:
> -	case QCA_WCN6855:
> -	case QCA_WCN7850:
> -		qcadev->bt_power = devm_kzalloc(&serdev->dev,
> -						sizeof(struct qca_power),
> -						GFP_KERNEL);
> -		if (!qcadev->bt_power)
> -			return -ENOMEM;
> -		break;
> -	default:
> -		break;
> -	}
> +	qcadev->bt_power = devm_kzalloc(&serdev->dev, sizeof(struct qca_power), GFP_KERNEL);
> +	if (!qcadev->bt_power)
> +		return -ENOMEM;

This builds bt_power for all devices even though it wasn't the case
beforehand. As such, you can drop all further `if (qcadev->bt_power)`
checks in the driver. But, you also need to check that this won't break
support for other (older) chips.

>  
>  	switch (qcadev->btsoc_type) {
>  	case QCA_WCN3950:
> @@ -2543,7 +2530,13 @@ static int qca_serdev_probe(struct serdev_device *serdev)
>  			return PTR_ERR(qcadev->bt_en);
>  		}
>  
> -		if (!qcadev->bt_en)
> +		if (of_graph_is_present(dev_of_node(&serdev->ctrl->dev))) {

And this breaks support for pwrseq for non-M.2 BT devices. There is no
OF graph in such a case.

> +			qcadev->bt_power->pwrseq = devm_pwrseq_get(&serdev->ctrl->dev, "uart");
> +			if (IS_ERR(qcadev->bt_power->pwrseq))
> +				return PTR_ERR(qcadev->bt_power->pwrseq);
> +		}
> +
> +		if (!qcadev->bt_en && !qcadev->bt_power->pwrseq)
>  			bt_en_available = false;
>  
>  		qcadev->susclk = devm_clk_get_optional_enabled_with_rate(
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry
