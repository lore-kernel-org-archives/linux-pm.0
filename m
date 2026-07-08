Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A16B3033DE
	for <linux-pm@vger.kernel.org>; Wed,  8 Jul 2026 14:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783521810; cv=none; b=citzOCBcHxW0Be5SfJTDXlDYku2Fy5E1miJbsEc3mtJ3JfH8cnbk+wsWD1MUUCfNJOCjKNhkBhVIt1i0EYfUY+pT5C6zj42x3JQkIQPiTeD1GHZ6G7K7CpiXlVMhXBsi7PR1rigQZw+e9GPMB+qsWko0jIa3z3mGkTgMq7II3zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783521810; c=relaxed/simple;
	bh=BdoClZGhrMnHXO+Nj2ZOJIYUUzTfbMX+l2BW6eLj1z0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=R/Qrv3ZziBNmOwp3ZjNNhFkFxJ9j9vWvXwMntJYUDKT4Yeo55RipyvSwnh2CA2jQSxrOaSyNVK+NklgtCnNJyRa/t8GwkipPIQjYiTwHmz4MuiR9+UnCrtki36bV8PIx78/8SVQCo5XVAlWfm62ecQBVmYeJ1GVXapra/N0zc2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=I1+4CANb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ON6iNNl8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="I1+4CANb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ON6iNNl8"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 668C3ChH2791776
	for <linux-pm@vger.kernel.org>; Wed, 8 Jul 2026 14:43:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0gdecsGlT1UYIEodgg+h6tmVGXJuiUMpriS8ug2nM0E=; b=I1+4CANbCIONvmem
	RP+pkwigRqRj3uyt0aYxKn29gYqSR6bPN/FNqTOWeQ3R5ffu+C6C8qGuAPknGnMj
	FPPwPDweZzcCTqEtE06Kqx4y+ocOnb8FgejP8UXFs+BaJFzb+zyDo11Rjqq393nS
	GOKVGYlNY82qWao4AQ+9ICxFFpfbck07yJ29Exzt9L2J9LzIhAlKql4AalrT0Xfv
	qjq+wLF8PlbsSRNimZX+SoU5Np3k/oyBrbruBESufbBUnZdvoZIqVx2ZnBBFjoPH
	obnzQlVJTPnJyBNRxJkN+RFeUh1FDbFoE8gsgf8EgO6+lf7LofP0tMU9/fw5y7RM
	yV7o7w==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9cswaxd6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 08 Jul 2026 14:43:28 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-845317fa7e6so1497041b3a.3
        for <linux-pm@vger.kernel.org>; Wed, 08 Jul 2026 07:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783521808; x=1784126608; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:cc:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0gdecsGlT1UYIEodgg+h6tmVGXJuiUMpriS8ug2nM0E=;
        b=ON6iNNl8QircjzlgwMAQk21eyvwtgyfllsbjSAR4zONxZOxCbQHk5t8Qsg0wekWFs3
         FXZ/5uPadeWnbRL56Up+4rSV7w66jAeBWZtfQJHi5MVDOfmAKRzJRou+XYftPa6D5Car
         xqx48iAEIZNjnmBR6otv7sBmWL5qOeFOtEu901qc5ym00Ij8zB18MDeiKSFFMcbs1cXf
         c7uIngxvrCzbtzhBAXE0O1YQbTljs4rX43i46cQcYGy/GPdMpcex6OsvhBIhfgHvCQ5U
         GuLVwX2YEkwk5YCbSnx9nc7ZdLLJ7aRAnq5/li09Zh5CP61PfiwRVqBL2f7pPW6Ik6lj
         v0Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783521808; x=1784126608;
        h=content-transfer-encoding:content-type:in-reply-to:cc:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0gdecsGlT1UYIEodgg+h6tmVGXJuiUMpriS8ug2nM0E=;
        b=M1pfSqxgAJTPiJnnLsHLWP80w2OjRN9luyXnn9aN+n+CrbLGBjlHeamtkl5GIi3y9r
         EaaoLyAasbuZYAY8y37gr7gS1TPBWE/YkmG7zmO8WFtwTIWlMZ/yfIleQ7ysnddjxTZm
         5dW+Ytg3E8txg7nZL39lx18fzjkC8QZA87JhuB/X4j1Vk1TU+VzW7LwIt1L/IDhD5/+a
         HyBaWtHYiJgwyFkF5ABQbkp2k/ElcSvHNv5oPQuawDijBhaYXrjT0oeGKh0o/tBsx7V+
         NGufDeogwjyszkN2QuUY0E/y7NBf/DAY3mWgN9o4RxH92dM48RAGb3lDs0hlIqiu/VPe
         53+Q==
X-Forwarded-Encrypted: i=1; AHgh+Rrybom6aFbkDxcec+9ewTERo6QL7oCNXjgexNXmb6iUcOOCz2KLr9NvH39CvLgT8ad4R9lwlpif6A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0FXCQfv+TW7BmJSsL4aAleX7307Ex0/PKgU7ExMWihlVwvMTu
	LbJaQ2IapGjc7UvnEn5LAzYTs/K4412uknpey7lb9Z6wyOBEKjvDFtCZDS5fOC88BbHqFQtJrYz
	QacBTL/YOdvKux18xd0ERopUuZFtMNFmQddkqyDwBiUlI14lbcwUeB1kzwWS3GQ==
X-Gm-Gg: AfdE7cnKKHu7xC3hmmGgtmllKX7zxYAduUoJ6iUAh4rQRFvVARpAPaywnRKSlFeE9Cf
	XouAf9W/hUC34yw9Ncq3ynqk1+824gLVAPXBTTFLb2FPNKBF9a+mNciFcLsCWWf7fXN/fnIwcfw
	UiPIHesAa3kr1FjD8ASeMpRLksDrV2AVu5kacjBQPwpzXZ2gIhWW24Ghft3AqKI8XqIjg0rS+NL
	9imLyDYC7IthsbTH3kAEXZg1d3zu1TdK/S1fcgK67rR+cMAKwCocxqILZOguWOS5/1iJfhjFU3L
	L1mYsZTxjOLIJyV4AjhfQ+Nu2mzfGoaeEI8POch3ivtnZE+kDxH1BMBncbk0yq/tEliaHtlYxHv
	pR713EyR+RaUrf5AZ8oD3NAwwkSa+D7Fhpo0Y3WilHay6ABJJvj0GEb3why0vIHcBK4wAsKgqpo
	x7JAqPlWc=
X-Received: by 2002:a05:6a00:2d86:b0:847:82dc:450e with SMTP id d2e1a72fcca58-84842ef8889mr2902180b3a.8.1783521808022;
        Wed, 08 Jul 2026 07:43:28 -0700 (PDT)
X-Received: by 2002:a05:6a00:2d86:b0:847:82dc:450e with SMTP id d2e1a72fcca58-84842ef8889mr2902154b3a.8.1783521807551;
        Wed, 08 Jul 2026 07:43:27 -0700 (PDT)
Received: from [10.133.33.185] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ca5af7d58f3sm2460134a12.1.2026.07.08.07.43.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2026 07:43:27 -0700 (PDT)
Message-ID: <4ac18ed1-0807-443a-9031-c0bdb885fec6@oss.qualcomm.com>
Date: Wed, 8 Jul 2026 22:43:21 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: nforce2: put PCI device on driver register
 failure
To: Guangshuo Li <lgs201920130244@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260708110131.748268-1-lgs201920130244@gmail.com>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
Cc: zhongqiu.han@oss.qualcomm.com
In-Reply-To: <20260708110131.748268-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: WqZ_i4LQYEKwfgyU_jeyP_VWLOvxGAKy
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDE0NSBTYWx0ZWRfX3IAWJcJEdL+g
 j4pxxxZTm0Ll7KxJ5GIlJydDrobcGVfLuwYY7bdRKABrcw92Jo27LYEi5EuxU5g8II+bnycI5+J
 gXMVsZWY1PZBRZnXIFB7VOGJE71cxK8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDE0NSBTYWx0ZWRfXz3Q829P+CULj
 sK5rdqjy8HAdvdodPphYIu/6ltpbBazG2Yjmdsglij5Gi+Txv3TvL9R2F6D3jf20Q5o+9g7f/iR
 7VgKkVhKOzUBVsjipRZ6omFsUXNqczNoA1fw4GDICMi7nCAqfFaWv+fPfg2dgd8htN/NIzBKDo6
 /dmIGZ2o+C3NdiyqU9UtTMY0pQV0N97qr5J7xtaW6r3h0gI4n6JwDKhRijbTIbDKWMV58CpKZSC
 82/cXxRaJ8cGLrE73z2QzXgfBLRwhXflZqaXBFR5glfRYQ5VGdT4lGl+375EqUVp7TmE6vnMtb6
 eylFBhPW1ie7D70iaMEuUQqt1t7A539/dnYo/Syj8L4soN+cMV1HxWPHNtLVWnx7rCcgNYL39TW
 Kp6Ip4A6QdOPgsFiHxxzavHIxjPEooMpt46IPr6dUpoH2W6Nf37oiZu7dMfSA/s6+gnuzexLSyC
 ygtx+ECzCx+tKbDH6nw==
X-Authority-Analysis: v=2.4 cv=HaYkiCE8 c=1 sm=1 tr=0 ts=6a4e6210 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=ZQ7csA7MKCUh9F4vvJkA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: WqZ_i4LQYEKwfgyU_jeyP_VWLOvxGAKy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_02,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 malwarescore=0 suspectscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607080145

On 7/8/2026 7:01 PM, Guangshuo Li wrote:
> nforce2_detect_chipset() stores a PCI device returned by
> pci_get_subsys() in the global nforce2_dev pointer. That reference is
> kept for the lifetime of the loaded module and is released from
> nforce2_exit().
> 
> However, nforce2_init() gets the PCI device reference before registering
> the cpufreq driver. If cpufreq_register_driver() fails, nforce2_init()
> returns an error and the module exit path is not run. The reference held
> in nforce2_dev is then leaked.
> 
> Drop the PCI device reference before returning from the registration
> failure path. Clear the global pointer as well so the failed
> initialization leaves no stale reference behind.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>   drivers/cpufreq/cpufreq-nforce2.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/cpufreq-nforce2.c b/drivers/cpufreq/cpufreq-nforce2.c
> index 831102522ad6..5a101c69c47a 100644
> --- a/drivers/cpufreq/cpufreq-nforce2.c
> +++ b/drivers/cpufreq/cpufreq-nforce2.c
> @@ -409,6 +409,8 @@ static int nforce2_detect_chipset(void)
>    */
>   static int __init nforce2_init(void)
>   {
> +	int ret;
> +
>   	/* TODO: do we need to detect the processor? */
>   
>   	/* detect chipset */
> @@ -417,7 +419,13 @@ static int __init nforce2_init(void)
>   		return -ENODEV;
>   	}
>   
> -	return cpufreq_register_driver(&nforce2_driver);
> +	ret = cpufreq_register_driver(&nforce2_driver);
> +	if (ret) {
> +		pci_dev_put(nforce2_dev);
> +		nforce2_dev = NULL;

nit: setting nforce2_dev to NULL looks redundant here.

Reviewed-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>


> +	}
> +
> +	return ret;
>   }
>   
>   /**


-- 
Thx and BRs,
Zhongqiu Han
