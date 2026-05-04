Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBC42853FD
	for <linux-pm@vger.kernel.org>; Mon,  4 May 2026 06:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777875864; cv=none; b=a7+XOVD3fV4s7kZ8mvXs2pz7exSk1BoqiPrhn1aPq2ReSv7G/xWyukx6ixbufmc9n95gzZcHPQnGJ5uoDUd5QIm05B5Snf/wRTLzla4eZGU28co6l7wYYLlofP1N2syY2BYlVFk6YmAi70OY8Y1MtGf5V/2apS3E+3R44W6pMeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777875864; c=relaxed/simple;
	bh=bcTkj7z6FKGNVOHa6c1rxzRLMWKib6fRDMdYaX8gzSU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pLyureuWkATOUKXZe44jG9w0pmffQ+4a0eiOLct7ZrZQsG/s2UnG4kNZ0p7svVJ2hNea30MLyeqFH/CdhxaH1DRa7hoD2UCMQTkt/7E0DumUv3k1gmk97FgorSg9N9UMADwixZWQ59f6kWK4x9dymZtEj/USkXRqWsu4g9l2XSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=j9makQ2V; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cCcLpQjZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="j9makQ2V";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cCcLpQjZ"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6446DNWU118944
	for <linux-pm@vger.kernel.org>; Mon, 4 May 2026 06:24:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TNyRR0rELfmD0/XXE4YuZsBRKd2/cuC3uluE9QU1vLU=; b=j9makQ2VCl7+a92H
	Ms359avakOcDGNz8ZJfzNQmBfTNA946xGHczlH1u6/6vSkDQkPY4jefB3GjtSIq6
	Fh5DSTC7ycKn6SYkIHN2O3x6Dwj0VrrEMzuSoFvLnbA/UPcfXrWszK3c5D7KRTjY
	Cx6xeG4+uRVJUIvkKPeEExDpqxzA0YMDmG327Qu4oWSloLysl6GNdZaKgDDiCC3l
	WZM+2VX2q7wO99Q+4pB7Z11FKIpnDxh1adEAU3VWQspVaSeg4OTyHKaQmwnFNfpn
	PcYy93sNJBnQV91mpvmhR1VGVZ/M+V+aKqRZxAKtyjJwOcmyRwUIg94RIpbMPHb4
	oCfZ7A==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dwaejmdkb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 04 May 2026 06:24:22 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2b9fe2d6793so24901815ad.0
        for <linux-pm@vger.kernel.org>; Sun, 03 May 2026 23:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777875862; x=1778480662; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TNyRR0rELfmD0/XXE4YuZsBRKd2/cuC3uluE9QU1vLU=;
        b=cCcLpQjZEdw1EPmTIsL0A2oMoXIAq3oKwkn01qeiiU4fVaELGnxBzqlOgZrSqs96Rk
         yR9nvlVNwuX8ExbxXzqY4JpQ4WVoDn5vpGcGVCX5cOL5I6iHkOXtfWf34cXuFWTIxjbF
         nyUdt/nef5tmzikwCstoFPFm7bj8otOf26CdtPO3gtlO8NmytUesmO/iDevboV2kSA80
         c+P2g++ywOA6mVHapWyu+av6zkJPHt53nzBV2aTIThjD146gK5N10kOkgR/cKx48UBAm
         P1N72cbqE9/sZmXXX6SYxbKNv/iD+qVhZy90ksPmFaexGYW4QyWYH5HUrkhu8F3AC35u
         G4lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777875862; x=1778480662;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TNyRR0rELfmD0/XXE4YuZsBRKd2/cuC3uluE9QU1vLU=;
        b=Bj9CJjgO7VzqjWVGja9ejaVhVexk0u6SloUULAyc1SyC6tDbqFV5BJ4eaPKvfG46lr
         1ZqXygBG+9R5ZvVkij6uY2G5u6DQ2bt5EQI54WqCOG4aOUqhjXDvLgMaNyZirBhn6ekP
         bDttcdRXYXpJj1GW5fyjxScCBAQ1MA+nL3ZGD58apWWSk/EbLXB5oLatWJzllk8YgAjN
         jdDLBq0BZY1tMmThFNJgu2alRI/PawwZD7E53m4pzBKUpeG3Y1IdAAtZQZkd8I/FHeIJ
         jSZ2JNGWF6BJuYW1vFZGcH0ujKT5HABlTxScCL7eQZVdpUt7JYzbFVLp5qjyBEhG21rv
         GfZg==
X-Forwarded-Encrypted: i=1; AFNElJ8gPwQxPue2f4fZPp42bMudvbn8wch9eCT4bbCbYLjdNF79G4tsECRbnfCK7fIetNL+73GAm+F9OQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyooc91Z6HJMyngAGcoTDwMKyefgiwlr5RkyhnyBut7AAart6NH
	P+tgIsy59HIdGLbnKWkZtfPLtUdj9JHDJeXyKMDjRMXzWQJCqtgfpkymysfAzMa1X0IzkPC7Ri+
	s5cOFRC6JC/5vKZc7NyGY/Dkg+Ohc5K3pbK3ja2bQ14i8wRnl77oehK3ODhxjyw==
X-Gm-Gg: AeBDieuHvb1z2jo1mQIm1XZAGXx24O+1O4chXjkgnlv/7Ro/LApvIWScTG2P83iQJ+k
	Flr0LDaeuWjWz0OypJRtkqGmEfRuUkRdybJCsMk28ykQAErZAyveTq45ftF8jfEqyZZSEqpY5YK
	txdEPvGoinsqV3F9X+llb7cqrKKdeXq+ZeD2rWQ2C6KMQR8+s2OINqMjnAbTn4axBgYXUty/rKe
	JDfd+yCqFVUIOW5rC5fZQxYvYM02FVpQauqwMfSncNsTr5j0aBiL5JbyniTXSO+ag9F8Tm6fkTj
	ORpLdhv5a6yrfGltYLnIjMw1YmTzmHLZ0RCHNlDmnKhjacXyNQKzNFNowz0TvdwTZxoD177mYu6
	xrsgqr2VWxqkKc6Ft7PQKstFxRf76j1Pl+3v6r7bsCnLF2LbIbn4ga0p4ZpWZFuD65Nv9KaQKxB
	xvSI+vt6As0I3T/bOPDnk+
X-Received: by 2002:a17:902:d506:b0:2b2:4d36:7aa with SMTP id d9443c01a7336-2b9f280fe1emr84277295ad.35.1777875862059;
        Sun, 03 May 2026 23:24:22 -0700 (PDT)
X-Received: by 2002:a17:902:d506:b0:2b2:4d36:7aa with SMTP id d9443c01a7336-2b9f280fe1emr84277065ad.35.1777875861559;
        Sun, 03 May 2026 23:24:21 -0700 (PDT)
Received: from ?IPV6:240e:400:e18:23b6:48a3:6006:2608:1239? ([240e:400:e18:23b6:48a3:6006:2608:1239])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9cae0f67esm96626775ad.51.2026.05.03.23.24.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 May 2026 23:24:21 -0700 (PDT)
Message-ID: <ff263bb6-1e0b-4cd8-a1c3-82ee162427bf@oss.qualcomm.com>
Date: Mon, 4 May 2026 14:24:12 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: qcom-cpufreq-hw: Fix possible double free
To: Guangshuo Li <lgs201920130244@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org, zhongqiu.han@oss.qualcomm.com
References: <20260501190005.504962-1-lgs201920130244@gmail.com>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <20260501190005.504962-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA0MDA2NiBTYWx0ZWRfX8tI+ij3xvg+Z
 GA9s15pa+dtieQl+H6RapuULzbBvhDA1LVidxUuPXPTX/wUlKZXXRmGbn0xehuLByvU+tLDVKiY
 zbYXLyXIMLnyyrKCBMU5pxPGl+m6kQ6epsjjzS2sv6bXVJlQu3idOLSzaLmz9RNLUBKZ8VyYTwY
 kOP14FiajA0IkaUrulEHXPo0nJwEdi25l109BgUALBVMdIe5/Y2oavMOT3SzZASxDNnt3y1ZMZP
 UelRrhIgDOEKNa5tGmdRCp0tHpyjHyUZX4bx41tXwQ9Dd4kGAEEPAGnBR7W/EkLhjute1ubTTa4
 PazIBiY3DNcGI+72yuJ7fMLTxbFyArPw6l9dUhA7t7bKrZxuavp99M72tjXr2KYHLtq0YjbXmD5
 bKPg5OVuNuVSnvrb72THWTpRmF6Hs+tR+h8RY296738LfFH3lae9Blb8MMGmUnrtd3NkOo+PlQJ
 8lcriyVH4uZ8PY3pIKA==
X-Authority-Analysis: v=2.4 cv=Wa48rUhX c=1 sm=1 tr=0 ts=69f83b96 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=c92rfblmAAAA:8
 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=g1ydD-XOTWB8Hi5v_0UA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-ORIG-GUID: -OZQkL2RsqOh90GbkykmUQeRYaeQUbzz
X-Proofpoint-GUID: -OZQkL2RsqOh90GbkykmUQeRYaeQUbzz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 bulkscore=0 phishscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605040066

On 5/2/2026 3:00 AM, Guangshuo Li wrote:
> qcom_cpufreq.data is allocated with devm_kzalloc() in probe() as an
> array of per-domain data. qcom_cpufreq_hw_cpu_init() stores a pointer to
> one element of this array in policy->driver_data.
> 
> qcom_cpufreq_hw_cpu_exit() currently calls kfree() on policy->driver_data.
> This is not valid because the memory is devm-managed. For the first
> domain, this can free the devm-managed allocation while the devres entry
> is still active, leading to a possible double free when the platform
> device is later detached. For other domains, the pointer may refer to an
> element inside the array rather than the allocation base.
> 
> Remove the kfree(data) call and let devres release qcom_cpufreq.data.
> 
> This issue was found by a static analysis tool I am developing.
> 
> Fixes: 054a3ef683a1 ("cpufreq: qcom-hw: Allocate qcom_cpufreq_data during probe")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>


Hi Guangshuo,

Thanks for fixing this.

Yes, qcom_cpufreq.data is devm-managed and policy->driver_data
points into that per-domain array, so freeing it from ->exit() is
invalid (and for non-zero domains it can even be a non-base pointer).
Dropping kfree(data) is the correct fix.


Reviewed-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>


Regarding the sashiko.dev AI-generated review comments[1]: all four
issues raised are pre-existing possible problems in the driver and were
not introduced by this patch.

- The data->policy dangling pointer via the clock provider path
- The race window in qcom_cpufreq_hw_cpu_offline() between
   cancel_delayed_work_sync() and disable_irq_nosync()
- The unowned IRQ operations when request_threaded_irq() fails
- The freq_table/OPP leak on cpu_init() error paths

They are potentially valid observations worth addressing, but should be
handled as separate follow-up patches.

[1]https://sashiko.dev/#/patchset/20260501190005.504962-1-lgs201920130244%40gmail.com







> ---
>   drivers/cpufreq/qcom-cpufreq-hw.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
> index ea9a20d27b8f..ef19faedbfec 100644
> --- a/drivers/cpufreq/qcom-cpufreq-hw.c
> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> @@ -578,7 +578,6 @@ static void qcom_cpufreq_hw_cpu_exit(struct cpufreq_policy *policy)
>   	dev_pm_opp_of_cpumask_remove_table(policy->related_cpus);
>   	qcom_cpufreq_hw_lmh_exit(data);
>   	kfree(policy->freq_table);
> -	kfree(data);
>   }
>   
>   static void qcom_cpufreq_ready(struct cpufreq_policy *policy)


-- 
Thx and BRs,
Zhongqiu Han
