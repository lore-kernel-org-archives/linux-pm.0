Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6EE33BBD9
	for <linux-pm@vger.kernel.org>; Wed,  3 Jun 2026 13:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780494741; cv=none; b=FQfV7xijGP+lO4bxvTJgp4/tP/cJTEhYEjv86ZBfp4aDSVcBz/Ndmr2eYrJ8KbsdU61F5wRn2JOgV7Z8h2rURLA3ph+wy/Pyb1BfMbMv417ySaddn36edJzby80ugtGjYFKe8XGR9Kx8Luv2T79uEF+jLuk3RtfZlpOmBlTohZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780494741; c=relaxed/simple;
	bh=ZBUnzIuE5caU3n+ALkCmwprayNcweissEzZE5XjZcJQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XMSFUGIPkGx9L7rfhhjWOuv83E+0bR3nboiiL7dKZIDe34ydiAdMAFjln1N902RzdCZF0hsO3G1spJtn5BipqYweyTCWAuQmv2D9lNDR+IOzNP+eaZG+AHN9Aiq6l2IAbwvanlW2FyvVnVPKmFPNXkwOkgReehlzoW5btA76v5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=N1LJs9lF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OX+3lpOE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="N1LJs9lF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OX+3lpOE"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65395oWY780679
	for <linux-pm@vger.kernel.org>; Wed, 3 Jun 2026 13:52:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cX6TPXUE1peyJYkOCelKbormU6F0p0ner0qoZZq9DzU=; b=N1LJs9lFhenchwKx
	84Ym1C9Xtq2lxuOItYGwmRUUeflCQWi86u8fSsGyykNmIycc+klm8FX0e0xmX/NQ
	rwok4u4HtsMdUa6JoUvhfy0gKZRt0Gru09GZ1usVzO03CT3nRCfziUX0XvufQCdp
	RA2yjt9sNKC0rtXtSuGOnqzkFzdyKTMTiwrYqg6+GDH+XJxwuiVvGsaroxzBR+mL
	uVTfE9Vv+MRAoLFfNVJ3wLSS82o4f8KTV0LuLdOB8Zizdk4Bf2fBfzioFc9Ls62H
	ujNUu2TVvt5dsSjClXBMoF5hN6bJ4QelvJjhbsn4POLvX4z+KSNN+9hY31bEJuxT
	n5iT9Q==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejhbb12ff-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 03 Jun 2026 13:52:19 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-36d98b76d12so2849536a91.2
        for <linux-pm@vger.kernel.org>; Wed, 03 Jun 2026 06:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780494738; x=1781099538; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cX6TPXUE1peyJYkOCelKbormU6F0p0ner0qoZZq9DzU=;
        b=OX+3lpOEOGWWesaAJ/V1f6vOXLBmL2eL/nOGPWStj8v6Jr3lYJmmHb3Fhr3c0DfXfX
         DeGEfmmJPpomwYP/s4AdXM3xY0EAhqpEH8gpz6cGCeOQdj+JqOH861eqBqk6U/D5IZ6V
         rCzYcJjeHHGujjhzlk5rQII4z6MJCSP9tSBwq4M0QMfaK59m4aBgpVqRKKasaw9f2wXH
         wQX2WlwKDlj8YhGvBsF8ryTh0GAwMWMSOFz8Bbc9lzJwOLC+ToOipaWZEPk1i3cekwpd
         QsC25Avk7PpUSZR9hahHzJJihBJtS1COnYVk1zynITSsHkf2OwwJsRTron+8bkO5CHUu
         PGXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780494738; x=1781099538;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cX6TPXUE1peyJYkOCelKbormU6F0p0ner0qoZZq9DzU=;
        b=XmKrdKR16l5oAWeXDr8QKAYcnyUcakrTlpPOB1GZvtnE9lwEpoT/sT39jvrAJL340I
         TmR7k2BQg3gXltBb6LjBRB7+siAC80Xr7FBNEA0m7IZCtntfeGiGlvaqi4FeT2uPJ3s/
         BF2l7dDmWJrmbyeLXo3o/6mbOqwRo0tPWu0Ka8MffyhTOZviGTkvHamm5pWK/v9bzy+k
         XjSC+9T3kQFogKs+OjtQgua8Cq55ttqJHG/bdGyN84t/EoYXmYfe4SWtwkzEHIKzRzCe
         EDlYB7XtY6wdzI4qzju3dtlZEUrHs6iIm13kAm427I6t0RDyXFGKxQyYZoId7p2idcgh
         DT5w==
X-Forwarded-Encrypted: i=1; AFNElJ8tb1FceBciykuntMMCqn8RGjRJEq8t05X/gAuBfAw3WVUJoHR0HFAxpWGOtEInP+Th/9D26j+wjA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy5fe/0wMnk/hDGOkuinznZklJyB1fj+s6qL7YJzNARFM6Tztl
	Cl2bKuGp1oi+2xWkpISgTZSc/EXhGA2tNOLtsnZyXRnPCQrL+386ks13y4fWsDjmNtfpKaH76xX
	soqxe8jblUFauGpnWT8qkkpOQHi02BmtrKLuwbjnf3c9eki2U51cPfv4lSpKjig==
X-Gm-Gg: Acq92OEAfSgNRe5DPdYy7jtobwZ32AyCOl3HQL8jkNuub6wA3WinI6fSRDVCuqCfSI8
	RnemK2Ba9dJOpis4yGRKCSUxShtf6ozfgvVqVWoNJMkz8eJhe+62cG/GIFN5dmJW2BC1tYCa2lv
	8wBwRKXt/y4hCUmKCD3x11W6NNu+XTyDyq1W+imXnK9KlSoV8ri3VT/bQg0uvmfngOUoAHxf6Um
	/y94CiRDQPQehBkvn3DgHQ73C2XeaZi5DGC9v3ONNgN6ELU9myuOLm6LaeTRUCShXVoRJuGMypn
	klqvQobh0lkQRRuOibIO3VETl+xj8zcTmUYTzSxMbk30HEpRO24mh8UmMWE0cjV+j3r99Y3ZYtT
	Q0cJmTaqZ4OOknddZ7Z/e0l4htoyHJ3mWf/2li6L8saOuC+Y1l8fGT5X0lUOcoGBKo2qjQXcVD2
	GN2PeGT1OKJIFIhVshQchLxEtOVrj9
X-Received: by 2002:a17:90b:2d46:b0:36b:218c:719e with SMTP id 98e67ed59e1d1-36e32f1667dmr3315043a91.21.1780494738016;
        Wed, 03 Jun 2026 06:52:18 -0700 (PDT)
X-Received: by 2002:a17:90b:2d46:b0:36b:218c:719e with SMTP id 98e67ed59e1d1-36e32f1667dmr3315016a91.21.1780494737567;
        Wed, 03 Jun 2026 06:52:17 -0700 (PDT)
Received: from [10.133.33.112] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85df0341f6sm2453859a12.7.2026.06.03.06.52.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2026 06:52:17 -0700 (PDT)
Message-ID: <b02e6e6e-bee2-4f17-a048-cacab8ceb473@oss.qualcomm.com>
Date: Wed, 3 Jun 2026 21:52:12 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/1] cpufreq: ti: Add EPROBE_DEFER for K3 SoCs
To: Akashdeep Kaur <a-kaur@ti.com>, praneeth@ti.com, nm@ti.com,
        vigneshr@ti.com, rafael@kernel.org, viresh.kumar@linaro.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: vishalm@ti.com, sebin.francis@ti.com, k-willis@ti.com,
        zhongqiu.han@oss.qualcomm.com
References: <20260603072438.1199527-1-a-kaur@ti.com>
 <20260603072438.1199527-2-a-kaur@ti.com>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <20260603072438.1199527-2-a-kaur@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: orCTcKlgwrMt8a502mmzxxIYIYkV78XP
X-Authority-Analysis: v=2.4 cv=R74z39RX c=1 sm=1 tr=0 ts=6a203193 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=sozttTNsAAAA:8 a=EUspDBNiAAAA:8 a=uyaOEz7BPLmrWLbuK_kA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: orCTcKlgwrMt8a502mmzxxIYIYkV78XP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDEzMyBTYWx0ZWRfXzns42gaJyeYT
 nPdnfEid6gfFUjnpV5lEHCs/JExE9iDsatLHYIyvknljDFQPrG1HKywz5ZpctZ43k8kuQW+omm3
 Ibv9pEF1ldGVXzAGeFdstgIzci3+RjmSeoic1xeAiBq/GwBNff8ba+1i2JAqPrWY8vipASzbCXF
 eQXPOQltcRPhlCOjV8ny0850LZQb3JlBKA5oA6BZHounlKbJraTchGC6me78fsZtYgVJdUTNnwr
 8iLOQOG9x7XbeKOzQ+ThkmB2bhDDNI1Ykc7Jp6904Sik0LDKxuPhAvjRiSi79QiZQvinRrx9u67
 Op1UdNIWkdkZhEwLnWDR7Jk3wsNvEwApBnnZEXFsO6hxwChrvZhWw6HHFxH1+MybcTvNnme03+u
 jiaf+SZdPLn6t9O24OnkjrUSjFac+p+AhHlO5bkhafiRXa0wdL4N8wh7zggFPTgi/rr9/pmQ1jn
 6yWe8i3JdOUEsV7Hb6A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606030133

On 6/3/2026 3:24 PM, Akashdeep Kaur wrote:
> On K3 SoCs, ti-cpufreq relies on k3-socinfo to register the SoC
> device before soc_device_match() can return valid revision
> information. If ti-cpufreq probes before k3-socinfo,
> soc_device_match() returns NULL, leading to incorrect CPU frequency
> scaling behavior.
> 
> Add a needs_k3_socinfo flag to ti_cpufreq_soc_data (similar to
> the existing multi_regulator pattern) to defer probe when k3-socinfo
> hasn't registered the SoC device yet.
> 
> Signed-off-by: Akashdeep Kaur <a-kaur@ti.com>


Looks good to me with small one nit inline.

Reviewed-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>


> ---
>   drivers/cpufreq/ti-cpufreq.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/cpufreq/ti-cpufreq.c b/drivers/cpufreq/ti-cpufreq.c
> index a01abc1622eb..f2c8d9e3a1b5 100644
> --- a/drivers/cpufreq/ti-cpufreq.c
> +++ b/drivers/cpufreq/ti-cpufreq.c
> @@ -99,6 +99,7 @@ struct ti_cpufreq_soc_data {
>   	unsigned long efuse_shift;
>   	unsigned long rev_offset;
>   	bool multi_regulator;
> +	bool needs_k3_socinfo;
>   /* Backward compatibility hack: Might have missing syscon */
>   #define TI_QUIRK_SYSCON_MAY_BE_MISSING	0x1
>   /* Backward compatibility hack: new syscon size is 1 register wide */
> @@ -347,6 +348,7 @@ static struct ti_cpufreq_soc_data am625_soc_data = {
>   	.efuse_mask = 0x07c0,
>   	.efuse_shift = 0x6,
>   	.multi_regulator = false,
> +	.needs_k3_socinfo = true,
>   	.quirks = TI_QUIRK_SYSCON_IS_SINGLE_REG,
>   };
> 
> @@ -356,6 +358,7 @@ static struct ti_cpufreq_soc_data am62a7_soc_data = {
>   	.efuse_mask = 0x07c0,
>   	.efuse_shift = 0x6,
>   	.multi_regulator = false,
> +	.needs_k3_socinfo = true,
>   };
> 
>   static struct ti_cpufreq_soc_data am62l3_soc_data = {
> @@ -364,6 +367,7 @@ static struct ti_cpufreq_soc_data am62l3_soc_data = {
>   	.efuse_mask = 0x07c0,
>   	.efuse_shift = 0x6,
>   	.multi_regulator = false,
> +	.needs_k3_socinfo = true,
>   };
> 
>   static struct ti_cpufreq_soc_data am62p5_soc_data = {
> @@ -372,6 +376,7 @@ static struct ti_cpufreq_soc_data am62p5_soc_data = {
>   	.efuse_mask = 0x07c0,
>   	.efuse_shift = 0x6,
>   	.multi_regulator = false,
> +	.needs_k3_socinfo = true,
>   };
> 
>   /**
> @@ -443,6 +448,11 @@ static int ti_cpufreq_get_rev(struct ti_cpufreq_data *opp_data,
>   		goto done;
>   	}
> 
> +	/* Defer if k3-socinfo hasn't registered the SoC device yet */
> +	if (opp_data->soc_data->needs_k3_socinfo)
> +		return dev_err_probe(opp_data->cpu_dev, -EPROBE_DEFER,
> +				     "SoC device not registered by k3-socinfo\n");


Nit: dev_err_probe() attaches the defer reason to cpu_dev instead of the
ti-cpufreq platform device, so devices_deferred won't show it, right

That said, this matches the existing pattern in ti_cpufreq_probe() where
all dev_err/dev_dbg calls use opp_data->cpu_dev.

If so, maybe it could be cleaned up in a separate patch.


> +
>   	ret = regmap_read(opp_data->syscon, opp_data->soc_data->rev_offset,
>   			  &revision);
>   	if (opp_data->soc_data->quirks & TI_QUIRK_SYSCON_MAY_BE_MISSING && ret == -EIO) {
> --
> 2.34.1
> 


-- 
Thx and BRs,
Zhongqiu Han
