Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A03F353A7C
	for <linux-pm@vger.kernel.org>; Wed, 12 Aug 2026 12:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786538587; cv=none; b=UfZIj2A4tx8enurPdSTlixZmAS8WQ7xs7sQAiHc84tK6bQ28VyhRgBw0KaSKVVfeHaun9dDJNfLYRUXv1bDYMW5Urg8RkG22UoCZBImE6btS6GAotPTFR365aEpFT7IRICILt6sqFG9pW/eYCgsivH/dhhEOm/I01gQUsJPjQVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786538587; c=relaxed/simple;
	bh=yi1QuvPcs8wbycXTztL7f1bH48t3NLHr0H3Dpf0+BZo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QT2Oy+/LUCo/1GvjwgOumNW3iw5iZcaLDfViXc4MmKeNqDqIPetGpW/kt2w3th36nNvIsYXNFM1G6wWC8zAhJuE8onwsRvxUkdQD7Yzz4GoIXy3GLt3Dzi9U8XV5/eBW36ljRyR6HGmUEuMueFINCumiRwhfz9lBSAP76d6ukBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QTWUBvmU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FAPADKsU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QTWUBvmU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FAPADKsU"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CB4BnD569115
	for <linux-pm@vger.kernel.org>; Wed, 12 Aug 2026 12:43:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	S0ZzOF/twjkGmH1AwYjcWJogdovZC4gdJleFPN2qDF4=; b=QTWUBvmUd1oIG/11
	79zMicbAwrqcEnLZLGoOTJxu6ULbcf6CylUX2sAOmpwkuUMUaCDh9vBh+VkQvW+6
	zkcXY1G1a7SGMMDJ+CZNTM0CZFdoOseOoMd+J0mpepb+1VgrldJOeT/zsH00TBuD
	VqCmxV+nlsnm3yIerfgU+nhAoSC63KHD7UNWF+Vr4/F4qPPsFX3PshqkXZm+JXc0
	YNIuu6vCYtgIwu+MolERlwGWL9NpAi8jtl6kbeyl8/sYr8r7YCGZ9b8vAgbdJ8Qs
	/YAgYm9kRUY9/B2MR37Z8iosv+9hD5zhOyKLDtRsBCA/nFBXnoj3UdXkHOGTz04p
	WVcUrQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0nut8sn4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 12 Aug 2026 12:43:05 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51c07f25de2so8185001cf.3
        for <linux-pm@vger.kernel.org>; Wed, 12 Aug 2026 05:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786538580; x=1787143380; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S0ZzOF/twjkGmH1AwYjcWJogdovZC4gdJleFPN2qDF4=;
        b=FAPADKsUB1Pn/3VfDoafNU1VAItpDGHt7pA75uzGZYqo3vHE8FxBTYp+CbkJa0wxXq
         4QouE7y1WhtCZkybln106cU4ewPg+aW+BVnOtz6dpEEcJ6HcU1h0+1JDfQvVDAvJYmH2
         75JvKg1s9KXoSoYcs4ChyWfnI/rchcq275qLfkXtsVH5AlOfDuAc1EjuN1UIR6OpBdd5
         Zv1jYubBOxyejDDVIlmRZWlCQhUcs52EZOsrSx0gOuGB70YiuVZn7wTq62UY4+SM/fBr
         Iu5N0A8KuVAnbwsWPeKkV4nKDzDgH3ngiaGClleSVOnt3emWHiJ3xiE2u9ehDRbfWUG9
         KtcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786538580; x=1787143380;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=S0ZzOF/twjkGmH1AwYjcWJogdovZC4gdJleFPN2qDF4=;
        b=auUijDcvMr1aSf0jkssg5A1QqtTejj3t9Pwxwi+5kZ/oNWbB9OpsK3MJaxXHdgh+hF
         vkQZpvZdnCxuQjzZk01MhP2QddO1l3+e8RL1/w9roksBc+2r6kAkyqOFY/qFM0IHy0BE
         ohyv3OZ50VPLzCH832Dme4l1/sZetkDMgm6Gvfo8vEJPE0tM0F7ZUn4rYoSqEQHsTG/Q
         21uMLf01V7irsGMdYhYOhatl3eimhwKIbjUvq7hqE9Hq4kyBu11VR5kGcffXm8praQro
         9GdTTGcdPnCpP3tvuT7kvdRZNGTHIcXgEYQ29TfHlykhKEhUQyT48TkEneTwsImUiWrF
         3YQQ==
X-Forwarded-Encrypted: i=1; AHgh+RqInkC6fNC6PYIFvIx6X0/bRxH1yub+U+z/VgpMi3DoaDItEBoT2cEUqffgTH9uhLgRX3HzOoOuJA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4+K6Xiee/zx5mkV6zZzSXbT7wT5W64Z8eBqRopN2hhaXA5g5m
	bDQPMhgzynksl0uQkBDmvkbrKEWKOdSzW9oDtjR7UhcZDqU3JwOVVObJeJDP1mlU1P/PTvLA6go
	+oaHjiHmQAvJes8hXEbdEvaJRNKkMbo4RRBaVZDVSGVt7tCnocA4/yc2qX6Xrs1aZkEgXsHMp
X-Gm-Gg: AR+sD13X1eXHfo3AHpV28wwnSihSDzCRwoGFVqPFjZHOcwK0IrK0CAX7lPpcoXstRZu
	J1cS4jSRcTDtxmOd3+4G4BWU8uNKrO9udGaJ3yl84lKKWG/IUrBLK4ohbIGWk819VXEOBagU1Pa
	SLTkJLqB/PE490iwUAwENcrJwr6Xgq/3BLfjquYRa2/JmrxPlkSc/nG6vPqfuxNLwBIHQcSMcuQ
	HKiFwR+WDmt1VNDcB+VgnDP9/k5z1HUjgU6ha+CtusCfQlRuUUqZIE43yDCKWlwPPF7TnWPkuRU
	apDAgXi0Kph9drjxyUjda1uOUV6VdLfEurkkFk8bsJwcOetrdZYhLSTnRrHSrPh4Uugl/ya+D7e
	YSyL8KRze15bp42DNtgGKEbZ+cpVB8Smfl+wrx2Wv8/qbZPce8Bg50VPRdNTie6Y=
X-Received: by 2002:a05:622a:83:b0:51c:1cf8:ca4d with SMTP id d75a77b69052e-52d646ed88fmr36418281cf.13.1786538580430;
        Wed, 12 Aug 2026 05:43:00 -0700 (PDT)
X-Received: by 2002:a05:622a:83:b0:51c:1cf8:ca4d with SMTP id d75a77b69052e-52d646ed88fmr36417901cf.13.1786538579987;
        Wed, 12 Aug 2026 05:42:59 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:d71e:6d83:9df1:6316? ([2a05:6e02:1041:c10:d71e:6d83:9df1:6316])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4997ad79e5csm37802015e9.3.2026.08.12.05.42.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2026 05:42:58 -0700 (PDT)
Message-ID: <86ba3abc-c538-4d56-ac2c-3154b95e00b2@oss.qualcomm.com>
Date: Wed, 12 Aug 2026 14:42:57 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] thermal drivers fixes for v7.3-rc1
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Mark Brown <broonie@kernel.org>,
        Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM mailing list <linux-pm@vger.kernel.org>,
        "Bryan B. Lima" <bblima@usp.br>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
References: <91946ecf-05a2-4479-bade-3d0803bdcba2@oss.qualcomm.com>
 <cf0365de-77ee-4ae9-96bf-0652c172f425@oss.qualcomm.com>
 <CAJZ5v0ibXHOsa4Pp=A00cKCOiBnk9SMpSk_n9JE2qSYTRZzYrA@mail.gmail.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <CAJZ5v0ibXHOsa4Pp=A00cKCOiBnk9SMpSk_n9JE2qSYTRZzYrA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEwMyBTYWx0ZWRfX6tk3Y5PzT4Jw
 XKB9KVbYWjbcCW9KLNLsZXFawSEdPxfXeqZDHsAxdpAgU4en3aXotY6q6XzK8DeJFRAXewsePvJ
 7LuqN6dSZXoek5tn66GKCmLFtl9ugTs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEwMyBTYWx0ZWRfX2qJ/eLLsHfvM
 4LFI+L/1BA4Rd7KLx8lhqnJK2xw/GQ3VqhTNcXb25zGOCmMFg+iqQNfq/vpIF3I2kPq2JSvyg+T
 JYS6A3G3BTqdbc1PNnaQwxxTvT6QsieBupzvXZ1JLrCry5Nn3w7yOxUHYXKCZyBJxnslBkP0RCO
 aOb7hiQGOgJ15n/AyeUAhRXpQySY/yqEfJklympGyEHC4SC3tN6AlzSf5bM9Wb8Ws4ZDlquyEXx
 2rL7MjsNOfiUIAgKUwQOPD/hlsv8oBYskhj3bJPVQzZS/6FKyqog9Y40cRgXp4HsuHFiJYFuita
 gwcKRxcCFx4Twhb8eM79LMWjcFaU4wBnLQMoVNMCD2akawvqfey5UbxUwipwoPrGtdQayGHmZ6p
 35hmhudiFjjkZzz6JESi41AQMKyYC/l4SfUtePML/YyKfrUslpsjvV108ZBahFyWhu6+ckv+vlq
 PPOKI7822CxxXw2OsRA==
X-Proofpoint-ORIG-GUID: ZXCtZR7pazpg8LXwjdvWjPXpNjiXM1nZ
X-Authority-Analysis: v=2.4 cv=POA/P/qC c=1 sm=1 tr=0 ts=6a7c6a59 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=z4ZlljWG-feBfdGYGlsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: ZXCtZR7pazpg8LXwjdvWjPXpNjiXM1nZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015
 impostorscore=0 bulkscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120103

On 8/12/26 13:28, Rafael J. Wysocki (Intel) wrote:
> Hi Daniel,
> 
> On Tue, Aug 11, 2026 at 4:48 PM Daniel Lezcano
> <daniel.lezcano@oss.qualcomm.com> wrote:
>>
>>
>> Hi Rafael,
>>
>> please ignore this PR because there is a missing SoB.
>>
>> I'll fix it and meanwhile update the linux-next branch so it will fix
>> the build issue.
> 
> Well, the build issue is still there in my thermal branch though.
> 
> I've now remerged my linux-next branch to avoid exposing the thermal
> drivers merge I did previously and I'll wait for another PR from you.
> Worst-case I'll skip the thermal drivers material in my first 7.3-rc1
> thermal PR.
There are 3 fixes on top of the PR.

One is obviously to be folded with the existing series as it is my fault 
I forgot to add the file after fixing a conflict [1] which led to the 
linux-next build failure.

But two were reported by lkp [2][3]. May I take the opportunity to fold 
them with the patches they fix and shall I keep them as is ?

[1] 
https://lore.kernel.org/all/20260811145427.3089426-1-daniel.lezcano@kernel.org/

[2] 
https://lore.kernel.org/all/20260811094935.2941313-1-daniel.lezcano@kernel.org/

[3] 
https://lore.kernel.org/all/20260811094747.2940616-1-daniel.lezcano@kernel.org/
