Received: from mail-dy2-f29.google.com (mail-dy2-f29.google.com [74.125.229.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19224848BA
	for <linux-pm@vger.kernel.org>; Thu,  1 Oct 2026 06:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790835730; cv=none; b=cbPje8QjN73HeQ7JytOIC39DNL49V8bsZqz8PIDuxzX+ayZvCcj5DXu4TELzKQ5lyuC7QeHhPmtPCdzDfUQNAnAhF810C+3oDb9KAwnCDlNpxoIyWYksTu4NY9UHl9Jv1alq2S+GuDptpuRd9//l+SLWvDBWscP8/mqPV3YMvf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790835730; c=relaxed/simple;
	bh=jK8YcmgULqcX6JVEZ4kRXjt5tovYz/f4IYFMschjLGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JCQy8r/AiuI/FabuBMyzVqQlQ1udQ3DTh0jpRxAl5UttIFTZcKQKbmVgXa5b/nU4X7Q9TjUKE9zprRyPkTN4iWK2JmQtQ0O7bVTVqikJPUfClrjE8loYaafqWTsmDKP9MMKAwNgX9liXIjJNvajPPlqIN11eg+arAKSLCCg5hZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=K2iA6g8w; arc=none smtp.client-ip=74.125.229.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K2iA6g8w"
Received: by mail-dy2-f29.google.com with SMTP id 5a478bee46e88-34b48100af4so2121302eec.3
        for <linux-pm@vger.kernel.org>; Wed, 30 Sep 2026 23:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790835727; x=1791440527; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=y7zcw/ukAiD8lLlXAKYppSFNCW4crk+K0J8KwggLYx4=;
        b=K2iA6g8wbvHkPECXpwO+9T5iw0NOSqhMYLQOuAHXigUm862xvqbeGZu4i8dLYBUpcG
         BREAAMQlLV6Fzr65uxxxGpJW7MZO6bePGyhaWcdliPm4F8hwSIjjnEj+cUK6t1jtjFEL
         3fkKekmeRDumBmBjlWm7erxBFqMpkt6iT1XX/8bd/v+RWZ1/HLwbnkESlHDRSHN+pgf1
         4TUZ/AiXPw5ngly4xlsylLo4F6IjfDE+g0IZEXKgpWjj3xLf7aZmsOMnLO7ySiLTvicy
         PwfL+AUsncVtgJz0Zrb/5zvqVdcfpxUFhyIslxTJIdYaJ4iikwZLNcJc9DP66CcMFwHT
         +pkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790835727; x=1791440527;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y7zcw/ukAiD8lLlXAKYppSFNCW4crk+K0J8KwggLYx4=;
        b=D7BX29AO74KVeytOJukSfYdIrD2lCqP2hPdDbBSDVJfo104KVFf3vyX0dib8dYkZ5G
         +Tj5i1d0qFHRrLFw7OnCbCyb0siEZbUYs6xIKOVybCrLGNKlztI67MZmhmdRzt+78id9
         sJWiIJCX8S31uK991sTCrPNZ7iTFASgpbFC1zgYuuMvGJ3UV4Z9ofZWZwzCYoKl8mCmX
         LdjvcrAnv2ANMheOosCqmj9XrXTf/bpj3GlpX6/D1cRoeUgwPQb+xHzjPK9zg19peLxp
         9HrMx4cByO3bApxbaloUFvKlwj70tbD1ulN8qs92JJiZiwPvTqbNcUmMJnwFM9sTdLOo
         PryA==
X-Forwarded-Encrypted: i=1; AKwUvBwnc6c+4pxt0EquBw79Xfu3FuhRwr7qdzLJbKnKb8yUftmYK4P48x+nIIY0/WsR1z2HlmAPjDYDZg==@vger.kernel.org
X-Gm-Message-State: AFq9FYJpOZANUC07k47Y1xJmebBaeEZz90vp6zuV6SPW/MO7AxRP8hEU
	39iGU8DsC8yhVrY6UCmxlj1pUPp4JxNzK0j7x4PZeripAL9ONJlYRw0sS3j4VA8FG+M=
X-Gm-Gg: AYBFou04Gy1N/nsXJNJK8T7/P6TUHYZ1TC8yUCOHTzeSWzJab1CsbhfzwEAXEvogJgN
	tWINfj+FjAU+ZeaRP2UHyymHeRuG2Vlsn44LdeP/qqUQped5+gigiZyzFFnhGwVRbOmcdF7ZPl3
	STIvNL/rizPCNoNTV4dqQgEOlIz4ll7ylqRtW/Hh/I9mqvL+YUFT7CjyFlR/I2o8NcswPZVgC/b
	kV1T429mNQTt17vapDXSbWZQXZJMg1IZRAdqiaMa6la7YRLnG4NZryedJe4OwuI17i7LZslgcQB
	fbYf1XqeOLm16TOwSZkqRRdqozsSgLIXDbJV6AoRDoAG3blOZhwMu/i9HMX18YKUeVapggKjtSX
	lIVXuKtI+fBBBxiB5j01NVfumCLUnCnVXLe4s8LvpAiX9+e2bTyhbHxnPzo+AYN3fmpiNqfjmC5
	fQ1fD4au9MGsh9X/O8uh72TM0DAgS2ZKsOn8d9nFBFNuiBYot0MPOwQ+VlqNVAoG84/Slj8H7M
X-Received: by 2002:a05:7300:d947:b0:34b:101f:cda2 with SMTP id 5a478bee46e88-34cdc1ce13amr3929856eec.27.1790835727212;
        Wed, 30 Sep 2026 23:22:07 -0700 (PDT)
Received: from localhost ([122.172.87.224])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34db3750765sm4040631eec.12.2026.09.30.23.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 23:22:06 -0700 (PDT)
Date: Thu, 1 Oct 2026 11:52:03 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Abel Vesa <abelvesa@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Ilia Lin <ilia.lin@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 3/3] cpufreq: qcom-nvmem: add support for QCF3211 &
 IPQ5211
Message-ID: <ar38C5omDdaXQAID@vireshk-B250M-D3H>
References: <20260922-ipq52xx_new_ids-v2-0-4b1a0f3d04b2@oss.qualcomm.com>
 <20260922-ipq52xx_new_ids-v2-3-4b1a0f3d04b2@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922-ipq52xx_new_ids-v2-3-4b1a0f3d04b2@oss.qualcomm.com>

On 22-09-26, 10:03, Kathiravan Thirumoorthy wrote:
> Like all other SoCs in IPQ5210 family, cpufreq for QCF3211 & IPQ5211 is
> also determined by the eFuse. Add support for the same.
> 
> Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
> ---
>  drivers/cpufreq/qcom-cpufreq-nvmem.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
> index efa766e98d86..9f2e6e6c0905 100644
> --- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
> +++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
> @@ -205,6 +205,8 @@ static int qcom_cpufreq_kryo_name_version(struct device *cpu_dev,
>  	case QCOM_ID_QCF2200:
>  	case QCOM_ID_QCF3200:
>  	case QCOM_ID_QCF3210:
> +	case QCOM_ID_QCF3211:
> +	case QCOM_ID_IPQ5211:
>  		drv->versions = (*speedbin == 0xcd) ? BIT(1) : BIT(0);
>  		break;
>  	case QCOM_ID_IPQ5424:

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
