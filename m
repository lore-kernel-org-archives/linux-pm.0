Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC833F54A4
	for <linux-pm@vger.kernel.org>; Wed,  7 Oct 2026 07:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791357893; cv=none; b=p1cyvhn2xedq3W9Xrn3BgA8Bm1iNdkf2gcj5kX8ja+qx4tCoqaudYMYIT+Q08aKKg+2g+szbGK70V/I/Welq4Lz0cHKviHBLiHYE59TeViMWPOB8xm9r3btm6FOnwam5iHen7MDANWIYy6IAAeQYN/BDLTO/OkhVL1Cqwxo9E8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791357893; c=relaxed/simple;
	bh=UxZ50NqwJpLV70DqujYJ8OxnuapLGbpMQOZeIC/fP8Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Uq8t/6d7czYRmv2k84JUteexqmDj4o+21mu2ciGcLpObFS+VgU70XR9XulQq2JxZQdbCpQPkuMiClwLmQRyQsy6bsS/Jw0ah6Tnm9mPy93yhb1hRi9QHhw+Hm8s4ZLx4ufAidSf35dzDo1qJdHuXboQhy4FmFAvM6HAOMw9i8yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NWfS0D0e; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kHmoqFl1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NWfS0D0e";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kHmoqFl1"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6974UDdm2916126
	for <linux-pm@vger.kernel.org>; Wed, 7 Oct 2026 07:24:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AVpUwU22uEKD7W4M4o2CONa/iooL55EIQZsHgPp6kK0=; b=NWfS0D0eVGD8Ok+a
	ItVMICbFmN4Pa8s0NHvUUl+KV7E4pFyLF8xMcW5GyJuzewPKBPrg34y/X9dB4Vox
	6LjMoR1/CZxdK7XNeIJ/Q9wyIfLfqkDQ4BzVfJElSE441HhIhQfEq5/AT8FBFKe1
	VkUrztA0mujGiZ7CW2EipTQtypQ2sIWyt9rye4od28rD43d4pkC/BszGocZtyXGN
	z9o3QKZgX71bCK5MfynKya07QL366faaCEVHSAdm5O0xJeKj2IAw3w+LtvdKHGZO
	M+Te//uEWi7n6ScQO74BAKIP7G6gHPiMdXCLWMWD9UXvR9Vqhr8vd/Je8FUZysMs
	g7wpLg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h546230ns-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 07 Oct 2026 07:24:50 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cc4ac5feaa4so3083598a12.1
        for <linux-pm@vger.kernel.org>; Wed, 07 Oct 2026 00:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791357890; x=1791962690; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AVpUwU22uEKD7W4M4o2CONa/iooL55EIQZsHgPp6kK0=;
        b=kHmoqFl1Y9L6LZ6OIEjFEBYZIwR9Mbltu8Y5HDRPL/D2d764grsemgb1WBnZTrXwmh
         u1Nht6XPkvmQ7L1XVdV/CatpwzNZsFni4CJy7P+5HQPpy2Mf/rjMzgbo3zpOmEdduBRF
         zLRK7ewYUZU9QmUMOOQUdLLdHINGYtjkWkPgYSvznYKIbYzRryufOQxEXjEXFDdztuqC
         E12fWD75/ap8ZxQI5TkQQaBR8BBL0Y7WCHsiUpSnk3nxXLpp20cTDE8iQBEzk8T/mweW
         o7K9/YrfqiDGwAEOPWIOGzN/m0VEdKIVhBaKnQeAtc9oEHVs0QgK4khdnKyvIvczjURV
         67jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791357890; x=1791962690;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AVpUwU22uEKD7W4M4o2CONa/iooL55EIQZsHgPp6kK0=;
        b=HFroiM57YCIdX2D7dMmLnwhq+ROLkokMVi+UaFOb+LwE3rdvtpLnCrxXBUNyU30ZxQ
         Db4KBmywMdtwm2UmEU62j039xThvPkrzxljHlw0UStPBcpoEnsJIqKRzFPFLYClG4HaT
         cHRLpnx9TV3loUGft4NxN8KiKJdJtDA7/qpcMUQxNwdGdNbN2uNJVjYTbttWS0R5mB5U
         EzipvxTvJqONEBIhwI+jezCPx8xTWcFW5zWjfXtYH1tr+k6hIX9tJCIDSmihciQwoY+0
         ZtchohDDaX78YXPzQolGoE6cp3zh0ONYLRlljEeOeLj0HnQD/KJdnnn+P3yhFmRkrO1a
         t1SQ==
X-Forwarded-Encrypted: i=1; AKwUvBz7pRHyzK5mmAWLcZEZsGfRpboc5y+bCyUuUMw3gfvvBkDaW0oL4utZhFMjiCJ24sO+TVu0JtONeg==@vger.kernel.org
X-Gm-Message-State: AFuF++lEdJoQeq+3iqpbJzgl718f98REwzYGeqvTP2VZA7z4T94ovTIW
	FZL2zcOZs4t3BJifptLRRoWgoXkg2cVhxdIHAl9mHIrRj8yY7V9dZvELECTtGt4kr+1ew6nNuDV
	2K9CGf63IWQRFtLnPPpmJGZBFF5ig3NTs2Ewd3q68aIQ8UMikZ+IROl7NZal1fA==
X-Gm-Gg: AYBFou3ZyK2YmKw6mLaKVigIh2rbpBvCEfcD4qMx9vJF2iFtQHYmpKRlyBXYet7Tl4G
	5z6CjXcqPfxeSoo0KuR9aYG2Kj0nsS8gJuwb4kYYHbSRE5NK9nV12NSegpdAjUKf0Bf30KjcFYO
	PE6iiUCIIIWVhVvrBJB5wnQxNiNpfEX6zZsOUHwiJl0z+rueZq9u0DIF+PM+zP0ptRSpR16gh0V
	JPxSri5g98XEM/TibLIWkBSFAKBfQNp0Puxp0AE3mponLxifC19dQ9J7BwenR9jJJ9Xn8SP67X1
	Yluaz/M36599umjnYrxyveWoHiyFveH20/9RSxZTLeq/RBqAE0nl8mtiKF9eKTFXn7ivn7iJAYI
	7TbL51ewOUQkoruELXXPioUaNewgoNHUCbw==
X-Received: by 2002:a05:6a20:918b:b0:3dd:85a8:4c56 with SMTP id adf61e73a8af0-3e134051f3amr991003637.29.1791357889585;
        Wed, 07 Oct 2026 00:24:49 -0700 (PDT)
X-Received: by 2002:a05:6a20:918b:b0:3dd:85a8:4c56 with SMTP id adf61e73a8af0-3e134051f3amr990973637.29.1791357889108;
        Wed, 07 Oct 2026 00:24:49 -0700 (PDT)
Received: from [10.217.219.98] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89188a0d6d7sm954172b3a.12.2026.10.07.00.24.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Oct 2026 00:24:48 -0700 (PDT)
Message-ID: <0f113c6e-b868-4540-9f57-75b3530181f1@oss.qualcomm.com>
Date: Wed, 7 Oct 2026 12:54:38 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/9] soc: qcom: geni-se: Populate clk_perf_tbl with SE
 source clock frequencies from perf OPP table
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
References: <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-0-091697dbeb02@oss.qualcomm.com>
 <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-2-091697dbeb02@oss.qualcomm.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-2-091697dbeb02@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: tA3I2YKip04iOXJlS_6cXcVJrWtV2be3
X-Authority-Analysis: v=2.4 cv=ZZiIpcVA c=1 sm=1 tr=0 ts=6ac5f3c2 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=Kq5vhQSCjsUw4Kr_5AcA:9 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDAyOCBTYWx0ZWRfX4LN2ZAp2NZaZ
 xhnHaCiUIZ5YZtasUeKnXQl42u1DaYsORGlQ5ahfj0PpmgYwEpbAnPhRXt7vj+BeNNLVD8Gzjyk
 TME465iKSaJYfLl1MSH66C3uCqgqQXA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDAyOCBTYWx0ZWRfX+6UjPNl8HlX8
 mqXqjWxCXjI72hbNA2yE778dhDotRAsahl+dQYPdo1kF4xo5KGPAEQWI8ABAGeUhbLbMtSbCzen
 ZlvejqWCEIbMOWsru/dBAPzMlo2/G4TwGFYe7H32hMFB3LI/+tECNSQVWFjzstSgXXwt+E774py
 Xhf0O/xJ0n4QSv60vNwfBnllVr+2jXcRw0+qELN+r6wXQI60UwcmTt5dYiJdh3ipYT7KACUsLfn
 iRQDn1/pr/LxXb9a18jNMMkwmVLBo8B11cw8O8TzKFCiZ08cbeKKbusHmvfraOgAuYNkb9mR+XQ
 GDafRdx8IV0cYnPm/Y5jp8oAdSq4aW/WqRJ2taCLU2V6rMLkzMPLQadRnXQrVY2nXAoS+XKoziX
 vH8EzlN61Evl/nCJZy+DsPMlYvXdpdE7vetGQy4lR8MdMgpDYxDVnDiDelRFSRkmkwbuzHT4UDK
 j4n/QWYQW5TQKORyhBg==
X-Proofpoint-ORIG-GUID: tA3I2YKip04iOXJlS_6cXcVJrWtV2be3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_02,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610070028



On 8/27/2026 11:29 PM, Praveen Talari wrote:

[...]

> @@ -1175,6 +1181,31 @@ int geni_se_domain_attach(struct geni_se *se)
>   	else if (ret < 0)
>   		return ret;
>   
> +	perf_dev = se->pd_list->pd_devs[DOMAIN_IDX_PERF];
> +
> +	num_opps = dev_pm_opp_get_opp_count(perf_dev);
> +	if (num_opps < 0)
> +		return num_opps;
> +	if (num_opps == 0)
> +		return -ENODEV;
> +
Let's combine both in a line.
if (num_opps <= 0)
	return num_opps ? num_opps: -ENODEV;


> +	se->clk_perf_tbl = devm_kcalloc(se->dev, num_opps,
> +					sizeof(*se->clk_perf_tbl),
> +					GFP_KERNEL);
> +	if (!se->clk_perf_tbl)
> +		return -ENOMEM;
> +
Non functional to Simplify, keep level = 0 outside and increment level 
within loop> +	for (i = 0, level = 0; i < num_opps; i++, level++) {
> +		opp = dev_pm_opp_find_level_ceil(perf_dev, &level);
> +		if (IS_ERR(opp))
> +			return PTR_ERR(opp);
> +
> +		se->clk_perf_tbl[i] = level;
> +		dev_pm_opp_put(opp);
> +	}
> +	se->num_clk_levels = num_opps;
> +	se->has_opp = true;
> +
level++;>   	return 0;
>   }
>   EXPORT_SYMBOL_GPL(geni_se_domain_attach);
> 

