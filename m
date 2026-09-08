Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF20B19F115
	for <linux-pm@vger.kernel.org>; Tue,  8 Sep 2026 05:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788843689; cv=none; b=QhSwcd5X9UoziRc2VKQyZoFweUffJOCwbKNGu0TGayRoa++z7lYR9S980THSPFjkGbqdwjbfqg1n3B/x6Qqd76IAmntAz219ea70vMa3WSxEkwYhNsHDNIBe+4YBfoYIJuQ05enZGpOP+GMR0hjFv4TdkaCxz3Bj+asaEqknrpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788843689; c=relaxed/simple;
	bh=V+6ScvaiLo3JPN0wkVRmkS7bOLe8c075r83hcHldHlo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I+eWghnVOSvQq6UOAllqMm3Jut7/rPwo9hT4mNeVxHAiqbBLUwhcaQf/tKyV34sVDUt+gNrB/ej779nMcnCRk/+qlifjezU6bFzwzI1XU6yexNCI46XLkHcuyvmTkqDmdOwWqs9tOUaZD9ycOCkUX0wsNMsqw/aHdRuAzbfPcz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=E4dze73v; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TPYhT8Xl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="E4dze73v";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TPYhT8Xl"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 688447rO3001701
	for <linux-pm@vger.kernel.org>; Tue, 8 Sep 2026 05:01:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jhTD6XyG06zkUFyhXjqwJP5PsLsMnHTDifmAKJrZVq0=; b=E4dze73vOYcJmOsl
	DoBhJt7JXDTrf8nHORTblhEjWf2q6NL8sxbveTvIMT4cqs+rUw8a5bEuoiXX27Sr
	W6bb8aZcPZz75aoXjrgzBhoYvzmF/rgafPNg94rV8taMk1KGD+ucg7juWJeQ40oy
	EKlSa54PXcVCT026h4+KhyQWdh1AOxb8WXUO9tKXGdEI6GfbGBUq6eMISiUk/FIQ
	cx9hZDTniJYRjgfb6JcwWdk+KcTeGUapdZGta25uYfXoDWjl1TVrp0/3NJoUCDPD
	4Hw70Di0CoDAkQDQD050+1kP9Xuzvr+9iEeag9yUCEt2whrQcQ/uGB5ZkkRsXmYW
	+F0f3A==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gjb0p84tf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 08 Sep 2026 05:01:26 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-39b6416441eso3231306a91.1
        for <linux-pm@vger.kernel.org>; Mon, 07 Sep 2026 22:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788843686; x=1789448486; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jhTD6XyG06zkUFyhXjqwJP5PsLsMnHTDifmAKJrZVq0=;
        b=TPYhT8XlYZbvqikfYpE1lCA7N5IquVMh+naq5JRKnFqwcUHgj4bAyS2dbhbJ1nt+tU
         XV4dw7d2oCRCVXvWiTlTHIxKVOjPQTjDVs1cy8MdelR0L60JYOO8afX43GQFSUz5jMMT
         /w9dEaYLv3jtqFqT9Xb+6rhWKGmy4rwsAxPe6y2B2rqvqSVWodlhpaCTk53j1ksqaRRb
         qNqyYvri13Nuqd4LgzLJ4AW/1ArwpG4O0cwki9V6SRHswFP1sBUlUtu/M05iEf0aPzKn
         YKRKdzluUjEEpeCJGRHJL3XdizcF8d4NENN+AHrZ88mXju9VyjIqOgl+lIecBjEi4Tvr
         GvIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788843686; x=1789448486;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jhTD6XyG06zkUFyhXjqwJP5PsLsMnHTDifmAKJrZVq0=;
        b=FFMazw54sTJiiezl7bOVWs/ecWMUzIVPsiT+aCevWmEA7B++Y/WTsT05MKF+1/yHdP
         fsbPfoopcjoomsv6woZzb3iEPinjM1KtxYHDc+peAFJymEY1bPTG2liYQRMsBr2ldWyY
         ZCoxUUpkGIbXeVknT7oDTwe7GnxYLFznkJT7cO9hP9OhDPp4mH+HrtHpi5lYAcFkWPY1
         ppFGX/Ssl9dZOqor3L3lqV0aaA4mGcqNsPlJQ7544BEyvxjk8dt4kSj9PhOOtexBqF4W
         62/fBGkp1sERoFpZ/ByYN5+Nv9MP8536k6KVBz+KI79M+dW1bcJ/ODqyukFCx4MLuhJc
         LAxQ==
X-Forwarded-Encrypted: i=1; AKwUvBz2ZCAUElrQJdjOjDJkkGdUWw6OMRUkZWjmTQmSizQXnFWJlI6bXI/D1erLnw3TVlDGUQf3OJl59g==@vger.kernel.org
X-Gm-Message-State: AFuF++kpv/oI+tEVoL0q7sLFEa7RuvLTrCMP5HV1zUD+0ctASeGrg+OK
	ai6pNf+hiV79y9Cbg85/loyyyTKQba1KA5ZvIZF/ngxsw9kJk4kPbEfkyZtDc/blo7dl0Y9KYOy
	ltaKUSOUZxPYyGvJzTrb2TOz01emk06TDpI6nMc0p28FA9Cd4/mN9KT0+24ZRXA==
X-Gm-Gg: AYBFou2rQzNXTqsu4sWkCvtRbWA1HECL0WK8FLrSjcOGzTypF03cJ9gCj5KEHt8vamd
	6DuGz/ejcFJb4rkWQyZBkbQVhTa6kibv0W2mn2tXfeR9J20K4QRH6ZEE3cVeVCpjP5WY5zqS7Rf
	8G/XRxLCmJiDKJBsWXGoA3NcucaVk027N/EGmn2ZyYsJYnNkjcHfVxemmInrCXxnrH2DxLiNbp1
	D4Xt8LkjNXPb4jqB//CuOkIkwFWSEXa/1OIOVSaB5Z3k9jvT2TCFdW/3dlbEzkN3tuzxs8EKMXq
	cFxKLX5/LtlkF7mQBR8YR14nLT31Xg726cUgKjbPk4iOzdqYvNLkuOk7VUPeNPs5cPUQa4xK7qw
	sKpmB/5cGHGmLrA9g8Lb5dvIY+YamPzgPfxSW+06TKA==
X-Received: by 2002:a17:90b:1a8f:b0:398:d2a0:87ff with SMTP id 98e67ed59e1d1-39b26101029mr40141206a91.1.1788843686101;
        Mon, 07 Sep 2026 22:01:26 -0700 (PDT)
X-Received: by 2002:a17:90b:1a8f:b0:398:d2a0:87ff with SMTP id 98e67ed59e1d1-39b26101029mr40141162a91.1.1788843685573;
        Mon, 07 Sep 2026 22:01:25 -0700 (PDT)
Received: from [10.217.217.129] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b25f8d2c5sm24555583a91.2.2026.09.07.22.01.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Sep 2026 22:01:24 -0700 (PDT)
Message-ID: <a08e64a3-d5d9-4568-a795-6c5ed355ae05@oss.qualcomm.com>
Date: Tue, 8 Sep 2026 10:30:53 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] interconnect: qcom: x1e80100: enable QoS
 configuration
To: Marc Zyngier <maz@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Mostafa Saleh <smostafa@google.com>, Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rajendra Nayak
 <quic_rjendra@quicinc.com>,
        Abel Vesa <abelvesa@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
References: <20260527-x1e80100_qos-v2-0-305c6539e6d2@oss.qualcomm.com>
 <20260527-x1e80100_qos-v2-2-305c6539e6d2@oss.qualcomm.com>
 <apgeBNSiP01YfNcs@google.com> <86ld9d4h4n.wl-maz@kernel.org>
 <f58bd978-ca45-48b9-a928-45a2878fb54a@oss.qualcomm.com>
 <86jyox4fas.wl-maz@kernel.org>
 <ca962589-3b6c-4e5d-a11e-b49cf20dc262@oss.qualcomm.com>
 <86bja94234.wl-maz@kernel.org>
 <0916741e-442e-431a-9831-9457e3af1cf0@oss.qualcomm.com>
 <86a4pt3t15.wl-maz@kernel.org>
Content-Language: en-US
From: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
In-Reply-To: <86a4pt3t15.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: S2OZfwEUU5BMLDs4fsBvRhbjG3UiDGM1
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDA1MSBTYWx0ZWRfX/I+jEIx9KOFS
 UzxnKkADNZ1M0vtOtyrP1bYe1PW6Ace8xT3olu2hzKMbVX9q81IfIqUoy5z936TpnpbSwloJMjH
 clauXYHyJgdSGb++n5YdVXC8WB4z3Ec=
X-Authority-Analysis: v=2.4 cv=HL3z0Itv c=1 sm=1 tr=0 ts=6a9f96a6 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=sWLy_TsMIpJ6H1EfkIsA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: S2OZfwEUU5BMLDs4fsBvRhbjG3UiDGM1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDA1MSBTYWx0ZWRfX3EQ1sOrPp0Tb
 gZhOUhTpcffI1v9CHQl8AkXb/OHrJFMsvGVu4AexEGTNLw2pQCyW7P5E/0TIoF3UtwtC5UZ4Hn+
 7D7jfHVth/Gv7qjXVFGKBLr6KTpz1Nmj09LamnXkX+oL8iZZ2sF3HTogZP0D6mUBFRKsZXLirLl
 a4wSTuxkNIWIOY31Rk3IeykCzumlrNX2Ok63edbPGziT5qG452x+GY65RNGB5gXqavLKqg0S1e0
 wTlNy0L16wR7dauEDlKBqlLxW0xMKzSJQ+cIhbAjeelqc1ZDchf2B7AmiLhuu3GQl0iMWb0NuLM
 tmJyxJoCM2QJjHHfBVA3BbFps7b14STgmY2ngDM369JuDAoMvSOI3/cH6J3neXwZ6D1sBj7y7XB
 /BdMZi0ghwT8c8Q/a7Bg3TgNE292LPRPsR8KqS1GN3GXlSYnErm+YRkot77g2yFp8rhpb+EaEM0
 pZhuxevKqZ7EE2MEBKA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_07,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 suspectscore=0
 impostorscore=0 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609080051



On 9/7/2026 10:20 PM, Marc Zyngier wrote:
> On Mon, 07 Sep 2026 15:34:35 +0100,
> Konrad Dybcio <konrad.dybcio@oss.qualcomm.com> wrote:
>>
>> On 9/7/26 3:34 PM, Marc Zyngier wrote:
>>> On Mon, 07 Sep 2026 14:20:26 +0100,
>>> Konrad Dybcio <konrad.dybcio@oss.qualcomm.com> wrote:
>>>>
>>>> On 9/7/26 10:49 AM, Marc Zyngier wrote:
>>>>> On Mon, 07 Sep 2026 09:18:38 +0100,
>>>>> Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com> wrote:
>>
>> [...]
>>
>>>>>> The current patch enable QoS for Hamoa SoC, which get programmed only during
>>>>>> driver probe. This shouldn't impact or cause any spurious resets once the 
>>>>>> device is booted up and probe is successful.
>>>>>
>>>>> And yet it absolutely does break things.
>>>>>
>>>>> With this patch applied, the box resets within 5GB of heavy network
>>>>> traffic, probably because some transaction get delayed, and a watchdog
>>>>> fires. With the patch reverted, the box keeps receiving packets, and
>>>>> everything is hunky dory (100GB+ so far).
>>>>>
>>>>> Which makes me think that the set of hardcoded parameters in this
>>>>> patch is not universal at all.
>>>>
>>>> They are, provided the configuration is for the right SoC..
>>>
>>> Is x1e001de different from x1e80100? AFAIK, it is only a binned
>>> version of the same SoC. How do you explain the above regression?
>>
>> I somehow skimmed over the fact you said it's on the devkit and not
>> on the mini-x mentioned before.
>>
>> I pulled the Hamoa settings I could find, there are some updates but
>> none seem particularly related (maybe the PCIe one? I don't know how
>> the network card is connected), please give the attached patch a try.
> 
> I cherry-picked the Hamoa-specific patch, and gave it a go. Same
> result (hard reset while synchronising a bunch of files), but this
> time with a nice little message:
> 
> [  272.468031] nvme nvme0: controller is down; will reset: CSTS=0xffffffff, PCI_STATUS=0xffff
> [  272.468039] nvme nvme0: Does your device have a faulty power saving mode enabled?
> [  272.468039] nvme nvme0: Try "nvme_core.default_ps_max_latency_us=0 pcie_aspm=off pcie_port_pm=off" and report a bug
> 
> indicating that PCIe has died.
> 
> None of that happens without the QoS stuff.
> 
>> If nothing else, please "bisect" the QoS additions until it stops
>> crashing. Although perhaps applying only some of the settings may
>> have its own set of dragons..
> 
> That's not exactly encouraging, is it? And if the "recommended" set of
> tunables is not up to scratch, surely there should be a way to opt-out
> until someone figures out what's wrong. Something like this:
> 
Compared to Hamoa, some PCIe ports are removed on Purwa.
Let me share you an updated patch to try.

> diff --git a/drivers/interconnect/qcom/icc-rpmh.c b/drivers/interconnect/qcom/icc-rpmh.c
> index 3b445acefece7..3a4743c364dac 100644
> --- a/drivers/interconnect/qcom/icc-rpmh.c
> +++ b/drivers/interconnect/qcom/icc-rpmh.c
> @@ -224,6 +224,9 @@ static int qcom_icc_rpmh_configure_qos(struct qcom_icc_provider *qp)
>  	return ret;
>  }
>  
> +static bool enable_qos = true;
> +module_param(enable_qos, bool, 0660);
> +
>  int qcom_icc_rpmh_probe(struct platform_device *pdev)
>  {
>  	const struct qcom_icc_desc *desc;
> @@ -308,6 +311,11 @@ int qcom_icc_rpmh_probe(struct platform_device *pdev)
>  		struct resource *res;
>  		void __iomem *base;
>  
> +		if (!enable_qos) {
> +			dev_info(dev, "Skipping QoS (command line)\n");
> +			goto skip_qos_config;
> +		}
> +
>  		/* Try parent's regmap first */
>  		qp->regmap = dev_get_regmap(dev->parent, NULL);
>  		if (!qp->regmap) {
> 
> At least people stuck with Purwa or other abandonware (such as the
> devkit) would still have a usable machine.
> 
> 	M.
> 
> 

