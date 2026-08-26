Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A474541F5D1
	for <linux-pm@vger.kernel.org>; Wed, 26 Aug 2026 13:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787750277; cv=none; b=XVrs74npg+ZTL8NITqIdT0NuTVwkBiQsHuF/jasrFtdeVfCrV0B9fDaAeZVKCpbts/0ZWMNbnooYm8BVkE5gc3z+jcO+Pyp/5RjqxxPQfFqTszMBl6sFh62CU2JrGINSx2Uhf8JPQmUu7Nrk+BYb8rlyYjHhhXbuvXlVYeR/MiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787750277; c=relaxed/simple;
	bh=BYDsTpoHZztHpVH/KB9MIt4S85CTFk7lYHBkXkgV+nA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ht8QKVlpxu3EvzNaQt5G3sx9xyunwkV19D6u2pT6uvYrtQU9KoGRptY5vMggu+jbjy+8Re1Z5Ky05hDediHuVFOjqIFvmTchIpkJuC3YLZhaBt9B1cV+VdEItXAqFaiQ00PyaJHlTRuXfu2zSY3mf0Rt7rdNiP/CqsyERVu9K+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gFBmXjrd; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kwiBaWuo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gFBmXjrd";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kwiBaWuo"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67QCCF0Y882034
	for <linux-pm@vger.kernel.org>; Wed, 26 Aug 2026 13:17:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DELOI9rOA6Bm04F7WLidIklLxMdtsGlI2iiw3Tgfc7I=; b=gFBmXjrd0bXAHG1r
	R8/tATY6zngKD0xcvCkn3tiCgsi6wIGAwzpH0mjUV3GoGyhMdGGKOmfZ6XtxI9hK
	kObU0MuJ4yFt0gUW1SGU9g1TMyxNIQ7PNBb8ZolH2tcO1LNatYFTNLJf3iOMJQNN
	fzhmQVhxLfgWCsbBH+6trMDyDqDk68AD4aPAey98vgRG7oLGVOelxmRnwZtoK4tT
	lmbrnuq4hasJd8uvcIcZvgwAGuQ1jsAL6/dNxrReTNxeFyQ9VmP6SUmVPr9vl9dn
	2U0y+03fmfLeJl4D5UFfo5+Yx293EF+8KPxUQfj5iTLYOkzTJSFJtu0zNtzNtIKP
	SqL6tA==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g9r0k29ny-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 26 Aug 2026 13:17:54 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-744e789f00fso29605137.2
        for <linux-pm@vger.kernel.org>; Wed, 26 Aug 2026 06:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787750273; x=1788355073; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DELOI9rOA6Bm04F7WLidIklLxMdtsGlI2iiw3Tgfc7I=;
        b=kwiBaWuoMh64vd8BN3Yn8RYp83AUevy8dz1fHV/vKJz8WhVpMS60tYrduGwhY5SI/m
         /Ys+/UWZTuu6Z7FtsUrj706wd3QJKCDFPX59FiJUKeGF22XCCeUoCEIbAgsupvBZGgt9
         d3l/3SLmULMtxPCSX1PjCCa6pozpy8aZ4O4l44jmUgltp2wu4CQ1EJDKQii8Jj9vWoD+
         5KS+shjhKqAZvpYNnKfWYyy5C9gA/OAIGcx03o2wdF6v7FgPUZyOGOOGVTkUlo6W07fR
         MlurjmcUolR1MmdGEImxMNqLI08UKorcF1f97JNZe5bQq4jSExKGxRIZRDfmUrdwY/Qq
         /B3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787750273; x=1788355073;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DELOI9rOA6Bm04F7WLidIklLxMdtsGlI2iiw3Tgfc7I=;
        b=rMkzljk6F+GVXJAB/PWEaJw8qeafRqE2suAz0+s/9p7p4af2BtR+3eNPrZk8wluRw/
         G/DfyNqzfNL/Na7N2mUl9ShMej/OD3wRS4gSKmL+M7/r0mzTLiNq7l/f9wiJbwYKDuWp
         o0HfVp90jHZs6InsiNnT+iTP9pCeeJh6S28M0HqrywOh9baTGVNQgYHQ9rsFS1CPxn7q
         yMKOu1MeX0W10gFSH1RhG61T5irJSgDJxftGJTBoZXFAg0zZJr+ZbtSbiUXuWXi7A8Yi
         1hAArZIgW4V2u+VnXDZSIXoh1EZtNU1RHPnVkpAmiIntfJv9CH10qMvG3U7h+oQImqQ9
         ADKw==
X-Forwarded-Encrypted: i=1; AHgh+RpV6KonqnsvCl+4ADZAh55RSLoNpMgyMl9QpIVgFp/GRcsQ2hquSlutidKH6wStFvZ3OJ8MCjU1Ww==@vger.kernel.org
X-Gm-Message-State: AFuF++nGEAgFuUCe6YFyU9eBavZw8tu6gQp7AWC2eXrQ1iqsz7ksVH+m
	wxVa/02ZVDMOfl+yeetfABm6BdD1Ud6096BDJvJ7/lvc+Aq1nTcbymF53qrHx1m5XBiNXrcMUYr
	tRe6Mjj6PQ+NEOWU5nyKU4udyChgSztNERg0RVWRWg7yXrz2+LqY4j0UQWN2e6w==
X-Gm-Gg: AR+sD11UNHZxUCuRuukCtMox7EF+kxqiboE15WvJehD66HooIBKvyMuDppUg7fCj+yq
	xFMj1bKtsyxopChavve7gIFkEz4fG9BKiXXy4AvQx4PVooXBGW6/RFslwFndI9l0uaCBVw0/vzs
	wwarSZ7Yh11YXV2j8pgYVebHrA7qtWVN4ki9wPzvOUgWMTg4dx1PoCtLmM3Sy4FpfmzkPlRB+v9
	j+hrWrwzcBbDCggGSYHtZZi4A5t2MQEgySxvduhAGtmGArOITIVwvAjDVdzGUKxGzl5em4AVgbG
	8f5DXkrSKeS+DtH7GZ/cpY3f/5ZnMl1lF3isUd7fpxTwUPEw1/JG/nu3ah/bTLkU9zcg2KL/TD3
	3EgYdhoHXgeHiOg2WDc5q/CbB
X-Received: by 2002:a05:6102:3166:b0:783:73ba:7df6 with SMTP id ada2fe7eead31-78373ba9fd5mr278618137.1.1787750273443;
        Wed, 26 Aug 2026 06:17:53 -0700 (PDT)
X-Received: by 2002:a05:6102:3166:b0:783:73ba:7df6 with SMTP id ada2fe7eead31-78373ba9fd5mr278603137.1.1787750272973;
        Wed, 26 Aug 2026 06:17:52 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c250a9b235csm376838866b.44.2026.08.26.06.17.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Aug 2026 06:17:51 -0700 (PDT)
Message-ID: <0d493aed-acb5-4905-83a2-6dbd6349cb49@oss.qualcomm.com>
Date: Wed, 26 Aug 2026 15:17:48 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] pmdomain: qcom: rpmhpd: Add NMXC power domain for
 Nord
To: Shawn Guo <shengchao.guo@oss.qualcomm.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Abel Vesa <abel.vesa@oss.qualcomm.com>,
        Bartosz Golaszewski
 <brgl@kernel.org>,
        Anurag Pateriya <anurag.pateriya@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260826102746.633076-1-shengchao.guo@oss.qualcomm.com>
 <20260826102746.633076-3-shengchao.guo@oss.qualcomm.com>
 <6b2f4411-9c38-4b82-b605-6b9a047ab973@oss.qualcomm.com>
 <ao7mrrW_ob77EAIp@QCOM-aGQu4IUr3Y>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <ao7mrrW_ob77EAIp@QCOM-aGQu4IUr3Y>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=fPEJG5ae c=1 sm=1 tr=0 ts=6a8ee782 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=P5qJYf1CprfF32mA9rkA:9 a=QEXdDO2ut3YA:10
 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDExMCBTYWx0ZWRfXxS22ugg2onnt
 j8S++noWb/zlZJQ1AdG4WxbjcqrdjVjhDd5ra2Vt6kAU2WEHKNFTYPtTaKpm1+Vstzq8xGKUtmm
 kVX/bi3V2ZOj+FYuCjafJoXtkBBeqGw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDExMCBTYWx0ZWRfXyC03m0O+2f4S
 iYvFwnOruNFMqvr9F0khQR8ChbiLOMrVO/8LpSAFdIJtOjK/bzYIH/Ik/uZIYsA/jSPdNDgZxAR
 WxVvi4IjqR/t77eoidDmf0ICnGQ8OY2AJ4DtrUpN6I9d4tKmIBJMn9By70jByBAbwudMe8th+uq
 mEwEltdhiCP1niI2hwzM0/5nlaUgu2hQgoRWMBTNToueRndSf5Z6n8wW9ynfzmbU1LP1vAE3O4K
 WMTfU7xHmUKOVA39zKaF7MPGOaJN44qsOmTJYHzyBy1BOWzakn5SjXZII2IxblnKEiphkLmZuEm
 HGsAkp3s8PqVgPCAFtS90Xlz/0YXxcljlJhVibo4k4PeNtr4J5odbkT5Aezk/aoK0gThBluAYqN
 0I6MXRZ7HoEt+pAguljAJM+2/yf9pVZIq4pOsoj2DE36cptCf36eIulj5vWxqfSzCvgKBagMO6Q
 rwRpiTriF7u65l6ZMrw==
X-Proofpoint-ORIG-GUID: mjNQVylN0GNM55hDETAvJDgH3sTXnnNW
X-Proofpoint-GUID: mjNQVylN0GNM55hDETAvJDgH3sTXnnNW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_03,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 clxscore=1015 adultscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260110

On 8/26/26 3:14 PM, Shawn Guo wrote:
> On Wed, Aug 26, 2026 at 03:04:33PM +0200, Konrad Dybcio wrote:
>> On 8/26/26 12:27 PM, Shawn Guo wrote:
>>> From: Anurag Pateriya <anurag.pateriya@oss.qualcomm.com>
>>>
>>> Add the nmxc.lvl RPMh resource and register it in the Nord power domain
>>> table. Nord supplies the NSP memory rail from this dedicated resource
>>> rather than from the shared MX rail, so consumers need it exposed as its
>>> own power domain.
>>>
>>> Signed-off-by: Anurag Pateriya <anurag.pateriya@oss.qualcomm.com>
>>> Signed-off-by: Shawn Guo <shengchao.guo@oss.qualcomm.com>
>>> ---
>>>  drivers/pmdomain/qcom/rpmhpd.c | 6 ++++++
>>>  1 file changed, 6 insertions(+)
>>>
>>> diff --git a/drivers/pmdomain/qcom/rpmhpd.c b/drivers/pmdomain/qcom/rpmhpd.c
>>> index 96e4bd2f5a14..717c44d1c39a 100644
>>> --- a/drivers/pmdomain/qcom/rpmhpd.c
>>> +++ b/drivers/pmdomain/qcom/rpmhpd.c
>>> @@ -198,6 +198,11 @@ static struct rpmhpd mxc_ao = {
>>>  	.res_name = "mxc.lvl",
>>>  };
>>>  
>>> +static struct rpmhpd nmxc = {
>>> +	.pd = { .name = "nmxc", },
>>> +	.res_name = "nmxc.lvl",
>>
>> The commandDB sources suggest this shouls be nspmxc.lvl instead..
>>
>> Can you dump /sys/kernel/debug/cmd-db?
> 
> root@qcom-armv8a:~# cat /sys/kernel/debug/cmd-db

[...]

> 0x300a0: nsp3.lvl [00 00 01 00 c0 00 00 01 80 01 a0 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00]
> 0x300a4: nsp3.tmr
> 0x300b0: nmxc.lvl [00 00 10 00 c0 00 00 01 80 01 a0 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00]
> 0x300b4: nmxc.tmr

Alright then

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
