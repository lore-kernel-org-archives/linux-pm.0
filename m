Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9AD9429024
	for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 13:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787578923; cv=none; b=sEMQ5BtcAWmyxgZZ30Kw/dGqD0f4WcNQ2jkXlEoItJHIzwVFtcIkVfvnmQ7RPkm33ztalYzACBR2gJyKQY2zaOzkYod5TuA4INHsYnQJM8WNZ4zeEEilzwvz+kK4qAryiv2UYZig5u9Xpjcp/GNyd+2rUk62t5UuQaNal9XS/s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787578923; c=relaxed/simple;
	bh=220sKSJfAH66EhAx6MKsNA3uJHuVRcM7xOCoY8od3n0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pSNWwMrOAjmYj/aJcPTjqhdKprLMwQiOGZ8rqZi6xMkt4PVr0GAyXq8Tlix8/wrPf4VpfB/HLHOQPEJPNupu/E7pt+SB8Th7J5kBp5hyWk2nrg65ZNGVRvzXfJfVwlCgUJ/K1R+SusQCkXHrrF69KB0O8v7M0byo59KE5Gia+gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WeLnskcV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OM+pGXEK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WeLnskcV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OM+pGXEK"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67OCv5Sd2006634
	for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 13:42:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4nn3T1t/sB7+ffZyruvK0mZmx5y7OMfO+jTRwc/O4fA=; b=WeLnskcVZok8Wavb
	M2odJvv5d8hV/LD5NQp27uGONnXiEafmZkgE5sg4Sjf62xEqH6D74PlYl0xvO93k
	04Nf71ranEH5xPy5z0e3iywNAYhUMUYubaMk4JJuiaB96nxzuCr2V1j4tDc6E532
	QIvjOdRcqyjgE8N3Q8xqz+MfZ8Kji5dpI9gtXa3WF7BB0cDciV6AQbmcYwLgomM0
	ncmZVxqqqEhympv/jZRilWh5VIj+SUsAw6kEqxFmF9kaMZCtIjahq06Oli8t5Ztv
	dSrGJp+Q9Z56fnRzHeENNT5x3XMjMHLskW9MSF3lk3vyLfyR+sGuaN01L8jXNyxJ
	GVv6+Q==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g8kv78uu2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 13:42:00 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3950b1371a7so5350919a91.2
        for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 06:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787578920; x=1788183720; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4nn3T1t/sB7+ffZyruvK0mZmx5y7OMfO+jTRwc/O4fA=;
        b=OM+pGXEKndGdb2eKbWcGMWHrc43pPutKa/fpI70ZTCXh3H0Sb30FMe9d++yGoEImTx
         K0rL4x2lwJ3PvWP+Mpzl9TvKtMA++doIeF/yFovYdEBj26Hcy4AVUiCPoZ4ZCQ7C+yZq
         RK9MWI6aNEMcBpfhENw5lQc1/po4oN1WC86kdJwwhAjpDkN0KdoEi2L4Qh1LGy5gFHCt
         dWefkA0ssQq1mJeBD3dZdx6RWu5ktc7ZsiSYXvD6+8wUWukOCnCDiY5OjIVzN7whRNRt
         LzcRCZhTLzjp5xNUQSEr2oaI2idDO0PBqGxvnWRADzxpevM4SiPCSTaEjS5r64UrQsgQ
         RMMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787578920; x=1788183720;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4nn3T1t/sB7+ffZyruvK0mZmx5y7OMfO+jTRwc/O4fA=;
        b=fTqKznzfgKBE/HwIvr/BMK/dzmPZ3i1et2sAUtt6HYGxm8GGodAbupJRf6GUKsWcrr
         HYXOKZtHBNQwVZr/qh2IQhJDZwgXaEAG35akSFNF2HtbDz/7Iq1wYzRV6aWli5PkaqHm
         kMUNedx/a0vKfJac4yLGCaDoMHxyuQwUxv0WmTY62Sth28S3l52YFkVGTPyEr6541d8w
         orSehxCpYNob7xvyQTCVDNUcKKkdEPAJyYR5HoQY5reZadQQOYN0RJN5L29kIHVYOVHQ
         qFKn04JyVpcGYL3NYeFUPVQiFlpYYifKwMRRo3QP2aaDkoPUelFX5sMVgTvD38o1hI3d
         ufzQ==
X-Forwarded-Encrypted: i=1; AHgh+RoCEQ4Sib+uF9BXXjjLwYZv5iIha15mhmcDZO2z0gWksf69XVt7a4Gaj0SyPkq8KktuL4zbDc9haA==@vger.kernel.org
X-Gm-Message-State: AFuF++ny2xOO0JSPf4eMzG6hT/LkkfXQtrRpodSrBQL5WSlI3jtaH2vz
	w4DjybaAQRXBd22JNY8DQ74bOU5Lwrf7advgvVIHtAzf4sXysD29DeaBNQ8MPJzv8mA8H0Mrusz
	+ekPQsn/66wGcl6K8Twwfeh2FjVYLs3GTSM2a/a7+gV2k1XA6ytmFqY9z5d1Mzg==
X-Gm-Gg: AR+sD101DotFQJ/sFP12veHIOydA60hs958OxBiul/OYKu4GwaSR14ETDNOHxJlv07o
	wiFVrW7QYd/w3KYa8Sg3XEF1ebjr+eO3jvkTvGXEHH4VrVLKR1huv3Qb/d+cgGLCWVdyzNT0toJ
	v4846H+uK8u2T3NqzgXuov3fApbVGNyD21sUwYupy51Exiwceo/tf/kismdoD1nZz3zh+tuB4KZ
	LrVAisREIUSnKlLf1GWY12SYMd0gtvjHeIcPlQ056I5oXJL7fhwbfjCwMRhV6oFVvQ98Cc6tTRo
	tNjGUeQQnzU7qgcrA8WAIgqjxfj2HL/nL/D52GRxR82lYgwKOshxt9RPvDO1GdHz7bKZ6vsRhIs
	e0VIsvWUHVDvoyD7/1TfBYrlbANXiErh0xE4=
X-Received: by 2002:a17:90b:1b41:b0:383:5a16:bd70 with SMTP id 98e67ed59e1d1-395c39f97e8mr42709380a91.16.1787578920182;
        Mon, 24 Aug 2026 06:42:00 -0700 (PDT)
X-Received: by 2002:a17:90b:1b41:b0:383:5a16:bd70 with SMTP id 98e67ed59e1d1-395c39f97e8mr42709251a91.16.1787578919646;
        Mon, 24 Aug 2026 06:41:59 -0700 (PDT)
Received: from [10.217.218.158] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395e42d6139sm10107597a91.0.2026.08.24.06.41.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2026 06:41:58 -0700 (PDT)
Message-ID: <8af7a34a-da4f-492f-a51c-cc420edc5e6e@oss.qualcomm.com>
Date: Mon, 24 Aug 2026 19:11:51 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] i2c: qcom-geni: Use geni_se_set_rate() for setting
 source clock frequency
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
References: <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-0-61171ab1cdce@oss.qualcomm.com>
 <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-7-61171ab1cdce@oss.qualcomm.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-7-61171ab1cdce@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Cfg4Irrl c=1 sm=1 tr=0 ts=6a8c4a28 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=bL_AZauQwEGehf-WiMEA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDExNSBTYWx0ZWRfX6msIDd9tZZml
 0YScNNAasqy1YOVHHs6qZ4HDWmzxDjwV3RNR0r5zz2L1PpCEvGJqZZt9xrTwv3zb1Sah8uD0P/S
 LuHHCUAzP+/L5yq5JTfazkguFrRocAA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDExNSBTYWx0ZWRfX/7MwjFGjL7wM
 ZNMQFZ+9ZU46H/PfiADxa2VtoPuwClt9GynfTYRHviaCJ8I4F4b2mkSQXMUmDu2rU0l1wLS0Gan
 tSmvN5cL8q01NmPbmftM1F62C4BLlR8MWvlbzxFAiAwIkVytxdLxpqm1RIZwZyPvdV0LDF0gIp8
 eR5T4iMJ8t2bhdYb2lKRox+cxdg2I0ynRk0dxzTufpy4Z5rusr8kARId9XAjh6bS9UsPg3K/qvz
 F49QDjiAnF0aIjqkQNzJ+19VEfClJDIAck5QQXLoe8/pYp0CitDTy14Mpqug93CzJshD1atbNw9
 yI62e5uCwyE7Ryf5qJYp/9ZZFP8TSNpajfu/JundkYMl+jjiS4rDCq5SvJZPltywbeGhD6jJB3o
 qaakJf5OQZZiKS+fNcogSNyymCVoVOCFw6HqZopf8BoB8G9vwC/NUqSwfu2SZsMfxcjYPCbnEug
 y4+uhnTUXCSSgMpAzOw==
X-Proofpoint-ORIG-GUID: t9l8LiErWbOdnAlsmP8KciSGdoZMMV0i
X-Proofpoint-GUID: t9l8LiErWbOdnAlsmP8KciSGdoZMMV0i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_04,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 impostorscore=0 spamscore=0 suspectscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 lowpriorityscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608240115



On 8/5/2026 1:27 AM, Praveen Talari wrote:
> On the SA8255P platform there is no Linux clock handler for the SE source
> clock; resources are instead managed by firmware via a genpd performance
> domain. The I2C driver therefore relies on geni_se_set_rate() to apply the
> fixed 19.2 MHz source clock frequency expected by the SCL divider and

somewhere it's 32 MHz also and this may change too ?

> counter values programmed by qcom_geni_i2c_conf().
> 
> Call geni_se_set_rate() directly from qcom_geni_i2c_conf() so the
> configured frequency is applied to the correct device (the perf domain
> device on the firmware-managed path, or se->dev otherwise) without the I2C
> driver needing to know which resources_init() variant is in use.
> 
> Drop the now-unused set_rate field from struct geni_i2c_desc, the
> geni_se_set_perf_opp() usage on the SA8255P variant, and the unused freq
> parameter from qcom_geni_i2c_conf().
> 
> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
> ---
>   drivers/i2c/busses/i2c-qcom-geni.c | 13 +++++++------
>   1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
> index a23554d101fd..4561e2d235d5 100644
> --- a/drivers/i2c/busses/i2c-qcom-geni.c
> +++ b/drivers/i2c/busses/i2c-qcom-geni.c
> @@ -213,11 +213,11 @@ static int geni_i2c_clk_map_idx(struct geni_i2c_dev *gi2c)
>   	return -EINVAL;
>   }
>   
> -static int qcom_geni_i2c_conf(struct geni_se *se, unsigned long freq)
> +static int qcom_geni_i2c_conf(struct geni_se *se)
>   {
>   	struct geni_i2c_dev *gi2c = dev_get_drvdata(se->dev);
>   	const struct geni_i2c_clk_fld *itr = gi2c->clk_fld;
> -	u32 val;
> +	u32 val, ret;
>   
>   	writel_relaxed(0, gi2c->se.base + SE_GENI_CLK_SEL);
>   
> @@ -233,6 +233,10 @@ static int qcom_geni_i2c_conf(struct geni_se *se, unsigned long freq)
>   				 itr->clk_div, itr->t_high_cnt,
>   				 itr->t_low_cnt, itr->t_cycle_cnt);
>   
> +	ret = geni_se_set_rate(&gi2c->se, 19200000);

hard code ?
May work currently, but if higher frequency support added, source may 
change.

Also you have added in commit message, but add a comment also here.

> +	if (ret)
> +		return ret;
> +
>   	return geni_icc_set_bw_ab(&gi2c->se, GENI_DEFAULT_BW, GENI_DEFAULT_BW,
>   				  Bps_to_icc(gi2c->clk_freq_out));
>   }

[...]

