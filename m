Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794488106;
	b=D9syvn66oC35pRoPl35CvI7G0M4S/MGcMC+qDlwZp0oP7zEDVmrrNgkD1sj90PPxjgE2
	 L6DLtErzl4tc6m/oISX2iU4zKCwTqR1yzjvXSFiJL1Emi9VRKIDyVniJ2+bNHp/klC3Fr
	 5gcM5sSzwLn/o2S/ay9KAkydpBVaCWLsDiXz8c/m5JYp/3qCtXPK3Gr2+UTrI5i5jLh+W
	 IqMBMJsmwATrBemMG80Ox68Gu7ELQVbxWotiTweJV4pFn+/227SrtbeC/GZZ4EBDPAbRt
	 gn4W1UBNaTrXffA3KQVI9xpf5qB6oSeVIoAHml4oORel1V3xltfXOWqfnO7f2DIW8nA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794488106;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=FJWBGylPd+TUvS4fg6aAHxRIHS3fTwweS5Rmh/QZp8M=;
	b=AHFLJe9FEK+XlfAgCliG5opPOWEAm72zk6kLjxFcnkLRSN2KgGnXlTYcGPSC+GO1hZQK
	 HE57fatRNGHbEfNHcjz1lxmTW+fSFCrrrpm5+I/04X1CGFC0PHdVNNGd3sxt1hdM4un0o
	 jtLToiskrw7zLzg9m438oKd6PtWOhw5SIlM7OMpV5lhLKHDlfNoOuTP7B4fPKUOk94hFl
	 p/NrlrrjZ+gKxJF8ezJI+9YMAwZrHX0+QpOBk+mDWTHftzqRZOxhq3GRnBRsetNm/WhHt
	 j+strWdPvolUNwM77pTTQKCFtnAYlJtBfjPR8aU00plLbeA7yawer19FGh/u34tdpzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Mpz5ENUg;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ATRO1fxp;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD46606A323
	for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 12:55:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8FD46606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Mpz5ENUg;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ATRO1fxp
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ACB7OW13477432
	for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 12:55:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FJWBGylPd+TUvS4fg6aAHxRIHS3fTwweS5Rmh/QZp8M=; b=Mpz5ENUgcqRabHUP
	PD3J3yeBOVQuO3lto59EUpQ+arQ2gq2AwvPOsTfYA95ODC3Rd2VWtXnNMSumVmxn
	IX7m2D4pTpCsNVLNR6W+VCpIfjV5z02Ym5UXkWfYDRbj0W3lmSde+LMcM/Y03e3J
	pT3c5m/VovkQTPynUrjPx12qtGwROyoAbSXISgQC62QVKXPDyK95qTCf2JLdji07
	G6XQGZWPa+cs0PVEDzxhTuHVELhXyASTkjc036K/YUv4UBbKkRAsWHD02P9D1rCY
	7OgLvVZe12vQOHcS6cQaLqmZ/VomqPit472dY/vnqmfJ4jE9DbqRmpCw+0V28/XS
	XdG5Eg==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hw6yuhknm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 12:55:04 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cd5fd34fee0so2566784a12.3
        for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 04:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794488104; x=1795092904; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FJWBGylPd+TUvS4fg6aAHxRIHS3fTwweS5Rmh/QZp8M=;
        b=ATRO1fxpOaqjoB3TBeRQ2Iq9xgkvwpqdGjYnJh1DFozvHl1ptPVKUSJBMtFO3azSSV
         wRx1imsYOTRFk5L2lQJsu8A3TDjmu4v6P1S6/k7nMB/zXZ8GPWXrLg8BTbzKk3ygHsiU
         6fndKA4mHPSqf0FvxRCg3J+ADRMa2VDJTS8GvK6WdvNEdJB0Ddz+n/A3u+yj4Lz+AfNT
         KwYc8v2ViX5dRWxUO2ltvRMIWyini6HkH9fclVPDGzRjdHp0VBLLnGGW+ZW8RrENPUe4
         DsO3cbXKfmMaFAsF6a16tc2KUv8DddAVKyZK6THjZnsnMeMfaY60o4oPgC1hUTPPxyUS
         zrgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794488104; x=1795092904;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FJWBGylPd+TUvS4fg6aAHxRIHS3fTwweS5Rmh/QZp8M=;
        b=nlhglUvkTvShDbX4eHdUvEccObolYB01tx/7bldPc96v7HyG9tkCPQnw1VSzO5BZSv
         pmIKBYHdVbiAQyQuwl0XoknDD2O6zPFi9PScxZ6PSc1nxtk3M6s8It3Nux2bxiYLSxS5
         dc7f5TJJV5oEAegBMQLsTnabLFUfdnP/O5KmQ2kjVJO0jrI0Ar5DUp2XX5fbykTe6j1o
         Jappef8LtpL2yvPEaHfisp9DT5m4CQKMZNvP90mf5xJDT89UGnnA8CDkOKl+0t0hqwTn
         wo9+GHSFUsPaO4ituRDAKAO75QboiP+OXN9fGB6HepLiySz636KMmSCD4s51NW3mPQvB
         qTPw==
X-Forwarded-Encrypted: i=1; AL+hErFQCQ7rv6i2SI+YzpkNQ1b7xftz2PgUisgtR65kLOBWK9GtoRefp5oGFEHCKLP5siTm5aVZa9i1cA==@vger.kernel.org
X-Gm-Message-State: APuU4Z9rsdLM3SlCKvm0nHO0L9oPANFVLhWP304p8BF89z+vTkQrZVJf
	n31/h1V3Ig+0XT+hblnsD/o9d7h/ak5BX2j8Cmn2VTaDOHBgE6cox7fkLJod+INgTutfH5EZCbl
	n/y6ecm6zRdXrmXgjQFh+FlQwo3wmdhls1viB9ujfkbvttCAjjryPIEbn1NNFgg==
X-Gm-Gg: AYBFou1P1tpUJ98oURTkqDfm7CRbF97R3ucj0vwT4DvXOxwlQiXz4FQs8zBPdFFcgmv
	yhQvAr/hIPHQQS3GZlEdmRiYXnhfNOHZ5qaT843r/Fh46EN1R23o4djBWBlwWeQBtf8FTv5wM1p
	1gTEspghNl7dDSj9uQ1a7zR2IGqJF8lDCfpM/AGCXeZd+sZlvmIOleojA7lTf8rDLGp4fo9OxEf
	UwB51vKEUsDiVQRKZER43vBsapxVZuxHxSwP0E1ZkylteFdVaTawaYiuSk7g19VUT0Hy54ruGzJ
	QhnPLUw5dmMerERDlvsdystcNKVSDvmeA6tkS37/egt1X+beoOAJmR2XNn1kvsXss8RDqMpw+6l
	rgm5lBsxIraheRGloR3PPeA27T34FocIIrwYNOly60MLlxSn1YJuGLVLLcBl7LVw+4ZRuYVD4a4
	7PTD5VhEcYTCwETuzrJzP7l4nKPGOGieo0A/jpwkg/UrAF
X-Received: by 2002:a05:6a20:ef01:b0:3e2:2fb7:844a with SMTP id adf61e73a8af0-3f2ff7caf1cmr4970702637.61.1794488104064;
        Thu, 12 Nov 2026 04:55:04 -0800 (PST)
X-Received: by 2002:a05:6a20:ef01:b0:3e2:2fb7:844a with SMTP id adf61e73a8af0-3f2ff7caf1cmr4970682637.61.1794488103530;
        Thu, 12 Nov 2026 04:55:03 -0800 (PST)
Received: from [10.133.33.220] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8baaa9631absm3493088b3a.28.2026.11.12.04.54.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 04:55:03 -0800 (PST)
Message-ID: <755d7440-28f1-4c9d-bcef-33beb25c71bf@oss.qualcomm.com>
Date: Thu, 12 Nov 2026 20:54:57 +0800
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: dt: Set the initial OPP to apply its voltage
 constraints
To: Natanael Copa <ncopa@alpinelinux.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc: Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        =?UTF-8?Q?Milan_P_=2E_Stani=C4=87?= <mps@arvanta.net>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yixun Lan <dlan@kernel.org>,
        Troy Mitchell
 <troy.mitchell@linux.spacemit.com>,
        Shuwei Wu <shuwei.wu@mailbox.org>,
        Aurelien Jarno <aurelien@aurel32.net>, spacemit@lists.linux.dev,
        linux-riscv@lists.infradead.org, stable@vger.kernel.org,
        Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
References: <20261111130430.10359-1-ncopa@alpinelinux.org>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <20261111130430.10359-1-ncopa@alpinelinux.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 9UT_7dBVFmnmcSMb7ywNAaB34GD8CxiZ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA1MSBTYWx0ZWRfX1C7YkItrRl6r
 XV1BRtdYfNzBgnHWBuNNPTxdIZ5LA1nA1LQLaar3aQKilv3xgjuoitlsjPfxt0ofxXSwCy7+SSQ
 UGQS3bIkvjmwTlWwOi39z1I5dj8EzBY=
X-Proofpoint-ORIG-GUID: 9UT_7dBVFmnmcSMb7ywNAaB34GD8CxiZ
X-Authority-Analysis: v=2.4 cv=d49gWhjE c=1 sm=1 tr=0 ts=6af5b728 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=c92rfblmAAAA:8 a=kmYkUENqAAAA:8 a=VwQbUJbxAAAA:8 a=OUwkjY6KL-vEgWlMa8UA:9
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22 a=GvGzcOZaWPEFPQC_NcjD:22
 a=p9kz6gysRiz6SGr9lVkz:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA1MSBTYWx0ZWRfXzOL7QiLZM4cx
 JQjkfM2HnQNGGfZIW64uCPJBw5qLveSSP9V0C2ZbYuRu6tysAlaDPOy1QdC0ALFZorUbd54+wK5
 0E1ujudM77LtcQAJiZzctIKfEObL0rGPlvgh3VRx1iWdpPzkDBT8rDgPhOgY7JHEWqe/tDlu8Bn
 rw85djiYIDDtIu1VEa3epKiJNDbjt0Y9+wrZXZpNiCaXyU+fu0MOZ5L3qAs3e2WtV+A2SSx86Oh
 tFaSsSbhBPySo1ssYNmuzez16IUa6fxsLEhnCNWHh9GGB7OuKy2h1THw5pSlvlNFqWSkSHhP7aL
 EzBE4eGxAnZh0fNHcJ3j0OB4Iio7uMNGoW2oYnmveEAnG7ILzEcic50ZzqLEtr8adhCh5UNseAY
 5V4+ZVAxpsmjiswyuHaxc3qHXLvj8H8QbVJdVCi+kCDLIA8Tl2yFkHAiWksOkp5myMcYrSOKjSO
 9hhknt9RBibJ+rTDYmg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 adultscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611120051

Hi Natanael,
Thanks for the patch.

On 11/11/2026 9:04 PM, Natanael Copa wrote:
> The cpufreq core skips requests for the current frequency, so a policy
> has no voltage constraint on its supply until its first frequency
> change. Another policy sharing the supply can then lower the voltage
> too far.
> 
> On the SpacemiT K1, both clusters share one supply and boot at 1.6 GHz.
> When policy0 scales down, the supply drops to 0.95 V while policy4
> still runs at 1.6 GHz, causing random crashes during boot.
> 
> Set the OPP for the current clock rate of all CPUs before registering
> the driver.
> 
> Fixes: 3b9c34556fc1 ("riscv: dts: spacemit: Add cpu scaling for K1 SoC")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-5-5
> Assisted-by: Claude:claude-fable-5-2
> Signed-off-by: Natanael Copa <ncopa@alpinelinux.org>
> ---
> Reproducer, booted with cpufreq.default_governor=performance:
> 
>    # echo 614400 > /sys/devices/system/cpu/cpufreq/policy0/scaling_max_freq
> 
> buck1 drops to 950000 uV while policy4 is still at 1600000 kHz, which
> crashed my board within seconds.
> 
> Tested on a Banana Pi BPI-F3 with v7.3.3 and v7.4-rc2. Without the
> patch, v7.3.3 crashed on every boot with schedutil (three). With the
> patch, the reproducer keeps buck1 at 1050000 uV, and five boots with
> schedutil were clean on each kernel. Not tested on other SoCs.
> 
> Other OPP users that never set their current OPP have the same gap. If
> you would rather fix this in the OPP core, I can rework it.

Which other users do you have in mind? Apart from K1 I couldn't find
another in-tree cpufreq-dt platform where several policies share one
cpu-supply. MediaTek CPU/CCI has the similar issue, and
mtk_cpufreq_set_target() handles it by not going below the boot
voltage until the CCI driver is ready, so I'd keep this in cpufreq-dt.
But I'll defer to Viresh on this.

> 
> Found and fixed with the help of an AI assistant (Claude). I reviewed
> and tested the result.
> 
>   drivers/cpufreq/cpufreq-dt.c | 26 ++++++++++++++++++++++++++
>   1 file changed, 26 insertions(+)
> 
> diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
> index eb15650f99bf..2646dda10aac 100644
> --- a/drivers/cpufreq/cpufreq-dt.c
> +++ b/drivers/cpufreq/cpufreq-dt.c
> @@ -153,6 +153,30 @@ static struct cpufreq_driver dt_cpufreq_driver = {
>   	.suspend = cpufreq_generic_suspend,
>   };
>   
> +/*
> + * Set the OPP for the current clock rate, so that its voltage constraints
> + * apply before any policy can change frequency. Otherwise another policy
> + * sharing the supply could lower the voltage below what this one needs.
> + */
> +static void dt_cpufreq_set_initial_opp(struct device *cpu_dev)
> +{
> +	struct clk *clk = clk_get(cpu_dev, NULL);
> +	unsigned long rate;
> +	int ret;
> +
> +	if (IS_ERR(clk))
> +		return;
> +
> +	rate = clk_get_rate(clk);
> +	clk_put(clk);
> +	if (!rate)
> +		return;
> +
> +	ret = dev_pm_opp_set_rate(cpu_dev, rate);
> +	if (ret)
> +		dev_warn(cpu_dev, "failed to set initial OPP: %d\n", ret);
> +}
> +
>   static int dt_cpufreq_early_init(struct device *dev, int cpu)
>   {
>   	struct private_data *priv;
> @@ -251,6 +275,8 @@ static int dt_cpufreq_early_init(struct device *dev, int cpu)
>   		goto out;
>   	}
>   
> +	dt_cpufreq_set_initial_opp(cpu_dev);

Does this need to apply to all cpufreq-dt platforms? Could we detect
this dynamically by checking whether the policies share the same cpu
supply, and only do it then?


> +
>   	list_add(&priv->node, &priv_list);
>   	return 0;
>   
> 
> base-commit: 067c5c24cef23d913b67eaaf71ae67e7169a6620


Besides, Sashiko reported some issues, would you please have a look?

https://sashiko.dev/#/patchset/20261111130430.10359-1-ncopa%40alpinelinux.org


-- 
Thx and BRs,
Zhongqiu Han
