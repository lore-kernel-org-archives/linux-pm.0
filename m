Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7119519CC14
	for <linux-pm@vger.kernel.org>; Mon,  1 Jun 2026 03:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780284529; cv=none; b=PIFkqjsysHlgaLZSUeX6n/PFmjttKjFVeFE6SgqJ/2YYkluKIc+pkIoXM3L807VgoYMVWs+E4Co52n2MnqazUMqpYlbpOgnSJ6lcA+jFk+86Eihyj/UmwTQCzy/H8TuimFOquDhtGIyMIbm9Og8otxOUAUaz9FKZAPGlTVb76QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780284529; c=relaxed/simple;
	bh=hZnL4VxSn7icgx227jNlZRy1iU8u+zalBkbBzu2AsPs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KMaoEJ7XIK4biCZtxwjQUIrH+dBIDLdPG/SK/8Zbb3DjhKNTIsO674eg81Dmk+ZrFeeNqTAytg4g71hDCv37PKjnPYoR7DjALP/5WvDt58O7QyeNPa2ZcPbct5JQG+MQqAE7sO4B/ZLenU4iB6qhl2kOwE5pnmsWTDFH8ngQUNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UV3YOebD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cU1cDpxd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UV3YOebD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cU1cDpxd"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64VLgdBb1375308
	for <linux-pm@vger.kernel.org>; Mon, 1 Jun 2026 03:28:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	o8tNCF22n0udrnNvEkj+Ccc/X/fa2rRSpUkqcQWhck8=; b=UV3YOebD/PnRyejK
	3KlEMJqcH76A4IRHQShWZP4JmuCQ8iPaK9q5anMTS7Xmg0fT+3tEbzdJ6rrobDHk
	SNFLH7bX+d8IOYpPxcAXBXz/x1NPZVS1Wy9GKaTluUfJvlESTR2cKjQWubvSK4+R
	Qn17/dvRY/ix5WAmS/pBflPtYcGGuLV5Hr7u9X/o/ftL0NKCVoPZdCIAqOobzlp3
	gzehIeZ1536BTICQLFYtdC8liqxdl+2Ko6ulSUWvsns4NmFHS8shToIVbKnFre8Q
	OFh/v0UA2vzA/P5p0VksjDdDaSBTJPGkP7Me0jJmuzbgPvOZM54LzZqZCuwLPq9T
	apVrug==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4efpw7nju6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 01 Jun 2026 03:28:47 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c856470fe9fso2250603a12.2
        for <linux-pm@vger.kernel.org>; Sun, 31 May 2026 20:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780284526; x=1780889326; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o8tNCF22n0udrnNvEkj+Ccc/X/fa2rRSpUkqcQWhck8=;
        b=cU1cDpxddzkKz+ZQ6FZj1gChJCSEzTvgRSavr7l2fGL/4moiXBxfW3P11hyIM/PB2U
         YEvgs7h9TjB/dSv0Gm1ggRUujWzD5AMd6TEi3w9uP8HbfFIxumVuhYPWACadoM6Cw7t4
         DkbXtxurexgIZx16eWB9nyr29xd39E0pnApQ6PqYM/RUPhWwGowjTHgCdbxgaOqoTsnY
         W/cEklZYmUNdEzk7x29gLrGSdFQOvU88J9aGPu8w+Z6OepHul58jRn0a9IFRvKNNdunV
         GGgwrT0Pr0IUyyLFzNxAjxwa2n2TkWt6HHu6DMUXp4nu7o6CuRuU/VihUhL+8V8n5RLm
         5mwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780284526; x=1780889326;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o8tNCF22n0udrnNvEkj+Ccc/X/fa2rRSpUkqcQWhck8=;
        b=GJaEvMs78WANh12yubZqTbVPwlMJD5mtISqRU5fJZ5xg5X00j9KTrcK+1o32RA/7eV
         Xqo39G9XQH6yxzyKwtedgWSOCkeS/i/tnvwr7ySAz4mDkeKrYTvskI2S2KWdTYOn99/9
         0pI0GEjq4eKUD6YQk0HiQxJPPznZDUucybchJbtn0YfDkllOXu1TeBDRDOYFujcl1S8i
         zZ8DM6BfPQt2BRPJ92FUYjZN5yphBg+8kiE5VAOJLo2CQsYBiECzVBJ/HBn9fOBqgBQT
         UqrcCG8RVLN3UEwGfIUM6G8Z+ga5QHO+1uAUAK7Z3l0sdFIAvrjVj55c25XecsYIe4y2
         9BmA==
X-Forwarded-Encrypted: i=1; AFNElJ+9kRRDp1kQQQBSPUqne+QooEwQ+xIcID/8f4aYgD5OHR7trslgwcJJCAp7J50l6bVtT9OEA/1P6w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwPs707AtCjC/fst0xK0nof60J4on0rILUImEPugRDAjZA9Dfli
	v8Ds2wCNXnUZwHnkdJ0EWP0Qpd2pL4DtQyjg5sI0qMK5l7+mCRVeQhtkLXtcVsO/1ih6Ia4cJ89
	ZnycuKZtRrceiw8Q/CFfP4kbCWyOSe7Lj1xLPtj7Y8P65TxQK8wYWFO4auVNP/w==
X-Gm-Gg: Acq92OFB4v4gsEIulPhOJAppJqWgt8h0nAcPrX2d1P3MTN1pPBE6B7a9tjFGsDxB3zo
	e/qVQweNfelfiNIYWKnUtHFyln86vV9RZ6pLdWLrXRfThrD/MPaFY5qw15cJE9BBJwA2srncZ4W
	W5gKXYqiBSdZoBFHUW2d13omTvSebRIp584Z6AMIUtdXMaxEut0sQSDqWIjJ86nBx0IxWw+ACea
	UHibrDOD/muy8mZtsTIUtdqeZ4rE5L9EC8hh3czOoDpy3/TB7SG7e7Ls+9wvqEW6u2TWvbtvC4y
	RF39oh3ygYRvo8rk0z9oJETKlwnr2gIDvb37Afp532GxrsbxqLKiCgPSGkHjRThaLPNe61CsbZl
	cAOlu8Y+aicETYPuxnJbjZWlixisIHgF0Nz4G2tUcoYZL7nfKeYvquSUWXAysQ8yg4Oj6IVLMoV
	BizYHozoOFHz7BW+plClRk+JvPRTI=
X-Received: by 2002:a05:6300:614a:b0:3b4:65ad:b417 with SMTP id adf61e73a8af0-3b465add073mr918054637.45.1780284525951;
        Sun, 31 May 2026 20:28:45 -0700 (PDT)
X-Received: by 2002:a05:6300:614a:b0:3b4:65ad:b417 with SMTP id adf61e73a8af0-3b465add073mr917999637.45.1780284525348;
        Sun, 31 May 2026 20:28:45 -0700 (PDT)
Received: from [10.133.33.90] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c859391cbfbsm4775417a12.17.2026.05.31.20.28.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 May 2026 20:28:44 -0700 (PDT)
Message-ID: <e033f55a-2cf6-431c-8c20-f08c98382136@oss.qualcomm.com>
Date: Mon, 1 Jun 2026 11:28:40 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/1] cpufreq: ti: Add EPROBE_DEFER for K3 SoCs
To: Akashdeep Kaur <a-kaur@ti.com>, praneeth@ti.com, nm@ti.com,
        vigneshr@ti.com, rafael@kernel.org, viresh.kumar@linaro.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: vishalm@ti.com, sebin.francis@ti.com, k-willis@ti.com,
        zhongqiu.han@oss.qualcomm.com
References: <20260528090510.829513-1-a-kaur@ti.com>
 <20260528090510.829513-2-a-kaur@ti.com>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <20260528090510.829513-2-a-kaur@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: mtRkfXWpBIFxOL8EbCUgdXPkALWRKPIW
X-Proofpoint-ORIG-GUID: mtRkfXWpBIFxOL8EbCUgdXPkALWRKPIW
X-Authority-Analysis: v=2.4 cv=bNIm5v+Z c=1 sm=1 tr=0 ts=6a1cfc6f cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=sozttTNsAAAA:8 a=Xztgq_OtPhCiGFyKZ7wA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDAzMiBTYWx0ZWRfX1mPzK0z4SGPi
 SU/yGX4ssJ3xJ3sYlTTWzCoI+87rwX4iruX0B4WNWdmpLbxTFlkI2/GxzhkefrwLvadtFsGvzx0
 Sz/gt2BnsQB6WdH5Cw7s61phmGuLKQr0GXrUJu91IkBXElVEIIBGRdRStf1CWmLrt6+GfIZ9N/+
 I9YmtAQF2py3T6gN0o6fThtQ3NWHJzuybBZTiNbaSYt38JHQc30gCL/ai8s3MEg+N5lVc7w3gpt
 VtBJW3zGbPlMYjZdUvQ1PCJG5eo4YKd3va4t8tuk8+MsWIuvcefEkLpfhZw3ddgfYIdCUnLTujN
 PPw6JxC1euuWf+5fpmGcnU9x8Ik5BFSQ9ay9AwfDm2yZEFFguJpkzXlJVw0bhsmHeV9mmhU+nZ8
 jgrKPL1T7tf9wkiCz6UxhwEXOk0Puc7B/sMrc/0oXczOT+ORaQcrUugt++Ic5VvWJzM9p7eF9cF
 sBizdYfjOgnTDplEvbg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_01,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 phishscore=0 adultscore=0 malwarescore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606010032

On 5/28/2026 5:05 PM, Akashdeep Kaur wrote:
> On K3 SoCs, ti-cpufreq relies on k3-socinfo to register the SoC
> device before soc_device_match() can return valid revision
> information. If ti-cpufreq probes before k3-socinfo,
> soc_device_match() returns NULL, leading to incorrect CPU frequency
> scaling behavior.
> Defer probe when k3-socinfo hasn't registered the SoC device yet.


Hi Akashdeep,

Thanks for the update.


> 
> Signed-off-by: Akashdeep Kaur <a-kaur@ti.com>
> ---
>   drivers/cpufreq/ti-cpufreq.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/cpufreq/ti-cpufreq.c b/drivers/cpufreq/ti-cpufreq.c
> index a01abc1622eb..8219751da175 100644
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


It seems that `ti_cpufreq_soc_data` is a hardware description–only
structure.

After further consideration, may I know would it be reasonable to
consider using of_machine_get_match() instead, for example:

static const struct of_device_id ti_k3_cpufreq_of_match[] = {
              { .compatible = "ti,am625"  },
              { .compatible = "ti,am62xx" },
                ......
              {}
      };

if (soc_device_match(k3_cpufreq_soc)) {
     *revision_value = 0x1;
     goto done;
} else if (of_machine_get_match(ti_k3_of_match)) {
     return dev_err_probe(xxx);
}

Just a thought — you might want to consider this if it makes sense.
Sorry for not pointing this out earlier, I may have missed it before.


>   };
>   
>   /**
> @@ -443,6 +448,12 @@ static int ti_cpufreq_get_rev(struct ti_cpufreq_data *opp_data,
>   		goto done;
>   	}
> 
> +	/* Defer if k3-socinfo hasn't registered the SoC device yet */
> +	if (opp_data->soc_data->needs_k3_socinfo) {
> +		dev_dbg(opp_data->cpu_dev,
> +			"SoC info not ready yet, deferring probe\n");
> +		return -EPROBE_DEFER;


It would be better to use dev_err_probe() here and return the original
error, instead of using dev_dbg() with -EPROBE_DEFER.

Also, the message "SoC info not ready yet" seems a bit too generic and
not very descriptive. Which SoC is this referring to?


> +	}
> +
>   	ret = regmap_read(opp_data->syscon, opp_data->soc_data->rev_offset,
>   			  &revision);
>   	if (opp_data->soc_data->quirks & TI_QUIRK_SYSCON_MAY_BE_MISSING && ret == -EIO) {


-- 
Thx and BRs,
Zhongqiu Han
