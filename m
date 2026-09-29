Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C029848CD7A
	for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2026 08:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790671444; cv=none; b=XpFyOL4FPqQ7wLsvU6Gd+OQ068jChwnTTynwlGWwzlqsYsPAWhmHhBlilT+d1ELLR9xeGpFqPfWtJ3XewJQBcX3X70K9ViaHTaJ3f6cHRDxM8qFXU1q3QdVgYxK5sWMknm+AOfTetmhGamHS7VgeU2feLhDEQELWrx8yKyKc+9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790671444; c=relaxed/simple;
	bh=PW29nh6AHKIAfInJuhHm2rTl7ZNcfWfYAnmTTwkdspk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bg/c6YCK8LpdWZC39fUJT5l2WCdNPVhE5b1uIMTEv5mSWYlR5Fj0EQk78FAFB2/yN+bdOI9NKfd4sOs0PcW5Bvjmi9ZAbuQi5YulyhySzSfx8q0mc0EcGEzLuBMIG4DpJtsZSmnewl472dQSn8ouCAfNND1/F0kfb0mne5WW1XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hrL6QsEX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hI9m2mjh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hrL6QsEX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hI9m2mjh"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68T7Tp1x3435194
	for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2026 08:43:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IrKwOcgAyyYp97eQvpSA/WpL5HLMDhjcoFZkd6DMhmQ=; b=hrL6QsEX1aXwzaj2
	/nmBYfgLXBUNlA8EIbp0Q/hWDhvaDrOksMM+nuWhdijbF9KSuiDtuuPBxzp87CEN
	PO/rFxo6wnvJOxPbCMI3s6Nxe3q7WIlFNx84bSDhLETTzX0+Cak0oI2xgUprLI3e
	2LmHZ7mw8WtDQAtkA35Wf72wmhWVIEwiFWHT3lz3FNAK5qW5hsR6MIiqY5Y7yBte
	xZ+iAWWPuYNRVju0Kxw15UQYufFusVKzFByXfC+kd2tn0n5xotO5Y6ljJa8WQZKX
	dWcxv939+CrjOu0O91Nj3Uz08vRaZPjMthqWdNAq1Su2uy1dE1BN3/ZI18jC/wJG
	Zk+/NQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyvwnb3e5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2026 08:43:57 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93a3f673221so1117640885a.0
        for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2026 01:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790671436; x=1791276236; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IrKwOcgAyyYp97eQvpSA/WpL5HLMDhjcoFZkd6DMhmQ=;
        b=hI9m2mjhFvvbiKUZrdpycZjv/u8moN+vxbpnBn3g7eTVL+cRxnz6/XtJ+U+PKhyyVt
         bHaS6hNFk3V1JGNopfFlvUdrGraYEUhDRl5DyTSBYwuB9NPlYH1YN191h85IQuG+53XZ
         atTxo71ieXci3KTp/t82mK6cGQ5jHItmOuoYOzMnO9DFyGSqeA+gf2UlfWunE0ZTqtM9
         +pb/yv0hCQTyvl5pjlIrVcknwVZVqaTo1uE3nmBaKGsfVRclki9/8wexQNrLwlq0cBhA
         qKl2X27SgOJrHOtmCGbeWBMC76XUHkOvIs1fMxQu6FJCZQsX/jveVkuIRaqmzEjCwfI9
         ZaHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790671436; x=1791276236;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IrKwOcgAyyYp97eQvpSA/WpL5HLMDhjcoFZkd6DMhmQ=;
        b=IP659ggRZvLr9nL2ZhOK/ghEbedOELlUirGpztFl5YBcnlWnSe3tdZtTKwjEJYxXCs
         UFwFfcw3PUisU6R/zHwpAgVztDph4pfNhKWs8hNpxQ0BdqxdWQe4tN6tVePfrUMZmtyo
         eW1UwmsJeo//6tZmGaTKq6/7ENKzbdnatThaTt9NbyyqD8M/CDd0prcuTvCqbqvXliSx
         B1RqYGzXJ2L6z73uVJdX8Qfhsi/DJLDICzeQ3H5g1Yiziu12Uklu5miLnx90jVF5RGhR
         gnkd0xACKJ7GeYlahWN4mobHkf3/MXETzge/nafZmR9wU3yF/qBFj4Q1uEZxYpt468T6
         XnNQ==
X-Forwarded-Encrypted: i=1; AKwUvBwQfoBnyayDIgsV2nYYWBEhad7GXByHMzxLbANWnzKT09a62dwjVMmnKsWMDViu/g+0qMNF36PcvQ==@vger.kernel.org
X-Gm-Message-State: AFuF++kVBqx1+xHFJOzOwBRzbXx4/DjD1QwIhs3KALqVN7AwU16NnVRw
	i1z75pXr5CjtNHNQlxf9jlsB7H+sLJhEhuO4CewGNAtX/+AwOIGjXYPnCjVl3MaIf4Kh2rZLTPC
	7t5qKjIMKqc5RcMmpOC2EAZaf8FoSUGgdz/+El6ErCNatU8tws/B+879jhFzgzNatK7hYJA==
X-Gm-Gg: AYBFou0XWjXjjSd3oJSGYcc8hJnekP22JCyhFbySbu40o2DmbflNDFhtYHASvQO+YvD
	UohmO2I1expnZc5UN8E32H1o+Kvc/i1tuLAxw/1qd4A21nqg76MDLKAiSU1ieD18HlnZ1EgG4F1
	N5tbI0Kvzv+dRyvqbDMHuhwVleXBgyerkqz4XPzQohuH9JI2jKWfQEFj4JrJQNSDeAp4mdX+gVE
	kRZQ7ez3c/zlEUOO2kfIpW9uACb9rr021+Uj7q/nl6/k8Gaw4yfN7jm3tXCjNhNQ4E7LlrGnRqU
	ztpIR46W0TywITWefIOKm3ks0hFhvU+zKRYOUZ1So+LeMyhdnoqKax8hb8xyzxpX173flAWUqlJ
	73lc/vyBw3IdETESg3gh171zXiHFrNp+iebJ6NhmBVONYqA1+h46b0SbNUB0NXg==
X-Received: by 2002:a05:620a:8906:b0:939:de48:e41f with SMTP id af79cd13be357-93c4749888cmr2363839285a.31.1790671436417;
        Tue, 29 Sep 2026 01:43:56 -0700 (PDT)
X-Received: by 2002:a05:620a:8906:b0:939:de48:e41f with SMTP id af79cd13be357-93c4749888cmr2363836785a.31.1790671435949;
        Tue, 29 Sep 2026 01:43:55 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:7d20:e20f:a77f:4ef7? ([2a05:6e02:1041:c10:7d20:e20f:a77f:4ef7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48af507611csm2211528f8f.22.2026.09.29.01.43.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Sep 2026 01:43:55 -0700 (PDT)
Message-ID: <a2b8e238-7f40-48fe-85c2-f8e52041b3e6@oss.qualcomm.com>
Date: Tue, 29 Sep 2026 10:43:53 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/7] thermal/drivers/loongson2: Correct thermal sensor
 registration loop
To: Binbin Zhou <zhoubb.aaron@gmail.com>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>,
        Huacai Chen
 <chenhuacai@loongson.cn>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Yinbo Zhu <zhuyinbo@loongson.cn>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Huacai Chen <chenhuacai@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        loongarch@lists.linux.dev, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, stable@vger.kernel.org,
        Sashiko <sashiko-bot@kernel.org>
References: <cover.1790561983.git.zhoubinbin@loongson.cn>
 <502911659e15a51c4e98c11f3cf476dd5f92e75b.1790561983.git.zhoubinbin@loongson.cn>
 <0aaf7166-378c-47d7-98d4-1004fdaeae7b@oss.qualcomm.com>
 <CAMpQs4+uWMfFib7MhRcc7o-QMXkFrFCtdcGj04y56u44JL4iOg@mail.gmail.com>
 <ed99f62d-cf90-4ba9-89b3-08dbe7f7227e@oss.qualcomm.com>
 <CAMpQs4+hATFf+0w6Wq09RoZB1JJ5L_GP0aWxcGAeraTW7Gfy0w@mail.gmail.com>
 <8eba263a-c233-42c5-842e-7487ea36d5aa@oss.qualcomm.com>
 <CAMpQs4JvLOUv3o8tktg-EOT85KCunY9gJhgxQVkZEXPH_C+4EQ@mail.gmail.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <CAMpQs4JvLOUv3o8tktg-EOT85KCunY9gJhgxQVkZEXPH_C+4EQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: wWpyUIYtgJeZ0I0wzZmbJIWGb-Xa2f7o
X-Authority-Analysis: v=2.4 cv=W42txhWk c=1 sm=1 tr=0 ts=6abb7a4d cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=AP4mLQHTS3Hkw8D5x4QA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDAzNCBTYWx0ZWRfX8IEqlQOk0aoT
 orf+ChPcfwOzT/EzmuA5AjqnRB/b91Tpg955is9cCObsHLrr4AsQQ4OZoxcA+Zt4912nvBumqXj
 /vVpYH6BXsl/zVVSYai8tn0/SahvN+cFka5yOe7VuIUb2zuCoHp/wzPosIHVG4WeA91RwTC0bVF
 cKqYxli3kj8DZDwQd+8BaVfBS4b1N44MHsYc48k/zUah6i6YwB9wV9IB5bMdk0fgSPXRPkTbrzG
 JXoXtZErfsIqKJrrxG5YKU6WV19tBRQK4L4LUj4iUdybXAmvaE+Rwv1Y2ygfCNy4WcMqX0UdK56
 D/tl0l6fhiuCpZr1E6dOfqIf1iIZ5eXEFlTYofsFU0Z+W5BHeENoeQh6Wm3HLjf09FqLVJl9OC8
 C9AnkLPwNamUD6y8W222IVgzJMnwF3fYbtA0Js3dt3S5PVATGCkewP+nmWmiBX8zrOWXiVu9q9+
 9EukZvD1GpsZYt/JaXQ==
X-Proofpoint-GUID: wWpyUIYtgJeZ0I0wzZmbJIWGb-Xa2f7o
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDAzNCBTYWx0ZWRfX6cjYIvEUcvl/
 zzft1WESJhR8Takp8PSsPb5v3xfIquHZ3eQ4qBOsg+VtUgIcJAhegJ+jIHrnq309EbGsATkrsHl
 vaGR+kQtn0F/yqN0Wlc3vH2LRH+wdbs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 malwarescore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290034

On 9/29/26 10:23, Binbin Zhou wrote:
> Hi Daniel:
> 
> On Tue, Sep 29, 2026 at 1:46 PM Daniel Lezcano
> <daniel.lezcano@oss.qualcomm.com> wrote:
>>
>> On 9/29/26 05:06, Binbin Zhou wrote:
>>> Hi Daniel:
>>
>> [ ... ]
>>
>>>>>> Please make a less cumbersome and implicit checks here. For example
>>>>>> count the number of sensors and then do the check against.
>>>>>
>>>>> I thought about it, and you're right—I made the logic here too complicated.
>>>>> Let's use `sensor_count` as the counter. Is the following check logic clearer?
>>>>>
>>>>>            u32 sensor_count = 0;
>>>>>
>>>>>            for (unsigned int i = 0; i <= LOONGSON2_MAX_SENSOR_SEL_NUM; i++) {
>>>>>                    tzd = devm_thermal_of_zone_register(dev, i, data,
>>>>> data->chip_data->thermal_ops);
>>>>>                    if (IS_ERR(tzd)) {
>>>>>                            if (PTR_ERR(tzd) == -ENODEV)
>>>>>                                    continue;
>>>>>
>>>>>                            return dev_err_probe(dev, PTR_ERR(tzd),
>>>>>                                                 "failed to register sensor %d", i);
>>>>>                    }
>>>>>
>>>>>                    sensor_count++;
>>>>
>>>> If I'm not mistaken in the previous version, the loop exits at the first
>>>> registered sensor
>>>>
>>>>           if (!IS_ERR(tzd))
>>>>                   break;
>>>>
>>>> Here all the available sensors are registered
>>>
>>> The name `sensor_count` might be a bit misleading, but here the loop
>>> exits after the first success:
>>>
>>>                   sensor_count++;
>>>                   break;
>>>
>>> Let’s rename it:
>>
>> Can you clarify why only the first sensor found stops the thermal zones
>> registration ?
> 
> This section of code is based on the original version by zhuyinbo; I
> noticed that you’ve had related discussions about it before[1][2].
> 
> I’ve reviewed all Loongson-2K CPUs that support thermal monitoring,
> and they all have only one temperature sensor, with “SEL” set to 0.
> 
> As I understand it, given the current situation, the loop here doesn’t
> seem necessary—physically, there is only one temperature sensor (even
> though its SEL value might theoretically be non-zero).
> `LOONGSON2_MAX_SENSOR_SEL_NUM` does not accurately reflect the number
> of temperature sensors; it is merely an interrupt input selection, so
> using it here does not seem entirely appropriate.
> 
> Therefore, I believe treating the Loongson-2K thermal driver as a
> single thermal sensor better aligns with the current hardware
> behavior.

Sure, if the Loongson-2K is only one sensor based board then no need to 
have this loop.

In the future, if there are more sensors coming with a new board, they 
can be described in platform private data


