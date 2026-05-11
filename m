Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD86C3BFE33
	for <linux-pm@vger.kernel.org>; Mon, 11 May 2026 13:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778507681; cv=none; b=JJ1gjTvzBJx9iAsHkvXSpmH1Xm7QelV1+LUBu7O9KpNOWKT8PvrK4YMITmhJgxAlfpmU2nMgeQBzdI1Z2O/gOfQR5HgkAU7n6K9dKfmPS61srWM9//T92DxX87zj4wy4X+pxNjhkBdNNNlv5GmV1FpNuikfxYkhWp1XQFkXd9m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778507681; c=relaxed/simple;
	bh=r4olRqtT25PRvXYjfynWFNGrzUlqBkKYLbJrQ1jwD8w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oeNOX6sr64glapHbWsm25VqnEEbDw65pT2TA1FcQ7F26rHka49048ZkFcieHKQjIrgzzS/+bMWVRfycDHyOuXN4GUt0cT44VwtFyUHJw1Hitm6GBe97aPfbnrzpQSNijNKoabbec8dpaUXWSC7KTkSqbODy/4j0xQKgZKjGyLKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Da/O+MNt; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VY1DTFJE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Da/O+MNt";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VY1DTFJE"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64B9A9Ev017644
	for <linux-pm@vger.kernel.org>; Mon, 11 May 2026 13:54:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vseYlASF+Ag6wSqAVjdGQAFSwfi9OF8CpgFAIXGaYxE=; b=Da/O+MNtQqC81KKb
	o2tDoRKXnJ5kteHJ4nFROUGCl8Y6CE1Pc8jciTW/tW1RndhLyT8kTpY4gx5jsTmJ
	OugHOx8iD84k5vPcazZqZNdAUIgKOLezIBtc41F9aiQjdvnktoxbuWMRQocOWpHE
	rwUTJGGtot6UOPSItX1mCAlbt/gqasVvUByvHbLXrjB6BGI118Te5tnKQLpmf2SH
	mw7jAAomahMYGGs+HIKityAgAYGMyKCQHGGLcgexGNUn498JrorOqEMAYTtU/Frf
	otD6E0M4bUI/7a2ggBSYA/GTaXodHkbscTxNbAQ8rZaEziEcwQp2peC58uTpdW8z
	rwWtjA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e37xfsy7a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 11 May 2026 13:54:38 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2ba603a7d2cso47479655ad.1
        for <linux-pm@vger.kernel.org>; Mon, 11 May 2026 06:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778507678; x=1779112478; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vseYlASF+Ag6wSqAVjdGQAFSwfi9OF8CpgFAIXGaYxE=;
        b=VY1DTFJEoT0bRXi8Hz9aed4pM3cqVlNppo9Ju7xEhtNuaLn1aIxSmOj5J27umRamwY
         afMPXhixWhInweFIgpETWpNg/0A0SiDPOMgjYpngQ1fTHfzBGs2YI0YVK+8janvNJbG9
         yJw/Avr3cA580b153yVLDG5dRLHNqqQn5GJZB/cAVN/660615KrFdhSKxfOFuGF7yeha
         G4bOYSM/J0UZPtOhzGz9lPE2Lp/shDEOX/qRIiS2160RJqLWxCnjb2aA/l+h6hle5VPL
         zOFgPB9Yo+mM+jbHLnzc46FsjU9wZ8nYLS09JqohS07q14OHIGhPVm1mFucNBuRSpo8o
         5Bag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778507678; x=1779112478;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vseYlASF+Ag6wSqAVjdGQAFSwfi9OF8CpgFAIXGaYxE=;
        b=etNpu5RXMsh8gP2h7sDxJ2O43i4QPNiwwOqiodWR6qQxOU5TDKyWrEDCWm0itt04+4
         lwO0GIlaxPNOSCH34UK/ic6pRrA84DUWyywEo/iAMXW+1A+5PKeWJCZwg04QIXuYNe9j
         8PwlEw2o0H3tPZEKTzsITSgy7dsPT2dQgFjgGliQvIsXflN0YRz1hi3BbBLSWzppOVr0
         mYuzKs7pvsV65jTtC18HvmltuUV2sgxLptv+AF041N54RHUnU5TgLlWb2uetyB9WIcKW
         t/fXGsIxEzip3E63TnhASfwlrRLFEmPef02+GZ4YDe1f16w7eEa6VZO8g5omDPPosQyi
         Bmuw==
X-Forwarded-Encrypted: i=1; AFNElJ/IJ2dSdnUXn6T3frRwPLA/WJn/AHsTVJGA/+NvPFC8ERzGWyKRTuIdU1obrEYp/rgRDQBGXFfFpA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0mrVgbj6QduKxATpayl2Jcd9qFTSJtdjtz5T4NK8zUo7UFwFc
	oCHv6fdMr7gYnK2iDsN5oqIcfRAXjRNVWc82jITo4xEu7LeO+WfsaEfY+u7lIb3a9A3jLYiIhD7
	8InYr/LahmPj3TuYmQ9EUttlqWPxfty0VcBxKK3MfHdLCpV0mZc+xZoKBtGu3Sw==
X-Gm-Gg: Acq92OECvfNz/T/bp954HivAi0fVy7mXBHcyvMQrhD3GAQp6Wp8dP4B2HNYyknSZpPN
	nVEp36C9ERyi0UjTu3V99XDCqXhwx83vLTKjr8vV7C374dC9W6H1g2dyizCNNaX5LV7xg2+z/uP
	1w7qj/rspEoq+e82VXbBuB4YSl/3ke7jaWz8eYDNFkXs2L+8LR8q39Q8iDtmFfmckcz8nGMtohN
	WGuWxjghK6njd+Hq+rNSFex3bI12PJV+t7DkV38Ka04JNdwMpm5fH8khHtvEq2AeuonYEGDISGN
	2G2oH7g+BjDJCuXqyrNc32meHBo5KZAw5Y8g8mmopNOT32ujCx2DexdcyQHfymojyJWtekRCiou
	oo2RwxAf/qwL1OeKuV2cFhGevgIDaSZ1qZ7XD9v1gqasJoTr5Lxk7JUXp65WTMSCEXwuur+OkIX
	VAGUaLWKDI2Uwal6sOeA==
X-Received: by 2002:a17:903:4b03:b0:2ba:21c2:d6cb with SMTP id d9443c01a7336-2babd4bdb6dmr161931155ad.16.1778507677833;
        Mon, 11 May 2026 06:54:37 -0700 (PDT)
X-Received: by 2002:a17:903:4b03:b0:2ba:21c2:d6cb with SMTP id d9443c01a7336-2babd4bdb6dmr161930925ad.16.1778507677317;
        Mon, 11 May 2026 06:54:37 -0700 (PDT)
Received: from [10.133.33.247] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1d27109sm106388885ad.1.2026.05.11.06.54.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2026 06:54:36 -0700 (PDT)
Message-ID: <ea8bbb35-0fc5-4d45-9c9c-577e97282afe@oss.qualcomm.com>
Date: Mon, 11 May 2026 21:54:32 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cpufreq: Fix hotplug-suspend race during reboot
To: Tianxiang Chen <nanmu@xiaomi.com>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, lingyue@xiaomi.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhongqiu.han@oss.qualcomm.com
References: <CAJZ5v0ie54h2aK05qNZTWNw5bu7GZDgsxM55KSsuF=ReLMkm-w@mail.gmail.com>
 <20260408141914.35281-1-nanmu@xiaomi.com>
 <b3cabf3d-7672-4816-91f0-e6fafd9db4d0@oss.qualcomm.com>
 <20260511111407.455-1-nanmu@xiaomi.com>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <20260511111407.455-1-nanmu@xiaomi.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=TqXWQjXh c=1 sm=1 tr=0 ts=6a01df9e cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=QsNdl-TZesgADIufeKYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: Anmv6dB651QsnlWKnAfhQdgCUJ3hvpKW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDE1NCBTYWx0ZWRfXwkZHiqfrw3uS
 PPrZFJ1r74dGoLmthzArhTbDRDfTuMCe/0859Ay1dCCoUWmqZ+taK9bmsFdM1ht/y1U6ieKL4vB
 aqzeUWC1+jviGOdJ2JtxckREORsU4Snq70lQjGOaX5aTIpxiIPbooML9G4fJYsMnGshJmF2zaTe
 zpCd/WFGVFCRSb+XFVUKFW/laFDlVedrvRIrbxRSHUJDxEjN3TTRfLejTecXb2ogAnzcs2B1ZVt
 PJhorFvutyYVUC7fgH+ssc1kyl8z+0G775r54ydZX+v/6+9dLWPdKBqUnKOR+wea6yhToXT9xi/
 VnDreBNsMIlwua8VoG9A3AWTE0RRGZ4ETtlxubBBH99LztlND45NUi1lnrMGwxbA40H2e0oeJjy
 jCCIlDf0MoasfMMvzccpKXi4Xm2yIgUoyqNgJhoZDS/9V08w2wdI1Sio9stcuI16THRgfqHxUoP
 kQKpisSCudxcRkxOZ1A==
X-Proofpoint-ORIG-GUID: Anmv6dB651QsnlWKnAfhQdgCUJ3hvpKW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_04,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 spamscore=0
 clxscore=1015 impostorscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605110154

On 5/11/2026 7:14 PM, Tianxiang Chen wrote:
> On 4/14/2026 10:44 PM, Zhongqiu Han wrote:
>> May I know did you test this with lockdep enabled? Specifically, does
>> the new cpus_read_lock() -> policy->rwsem ordering in cpufreq_suspend()
>> trigger any lockdep warnings? Thanks
> 
> Hi Zhongqiu,
> 
> Thanks for the review.
> 
> I did test v2 with lockdep enabled and was NOT able to reproduce any
> warning.
> 
> No circular-locking splat or "possible deadlock" report was observed
> in dmesg across multiple runs.


Thanks for the confirmation.

> 
> My reasoning for why the new order should be safe:
> 
>    * The patch establishes  cpus_read_lock() -> policy->rwsem.
>    * The hotplug path already holds cpu_hotplug_lock (write side,
>      via the hotplug core) before taking policy->rwsem inside
>      cpufreq_offline()/cpufreq_online(), i.e. the same direction.
>    * I grep'd cpufreq and did not find an existing path that takes
>      policy->rwsem first and then acquires cpus_read_lock()
>      underneath. If I missed one, please point me at it.
>    * cpus_read_lock() is a percpu-rwsem read side and is re-entrant,
>      so even if an outer caller already holds it (e.g. via a pm
>      notifier running inside a hotplug callback) this is safe.
> 
> May I ask whether you have actually observed a lockdep splat on this
> change on any downstream tree, or is this a precautionary question?
> If you have a specific call chain in mind, I would like to add
> targeted coverage before v3 so we can nail it down definitively.


This was mainly a precautionary question on my side, to make sure there
aren't any hidden locking concerns. In my experience, running new
locking changes under lockdep can be a useful sanity check, so I wanted
to double‑check.


For context, none of the existing cpufreq driver .suspend callbacks
currently invoke cpus_read_lock() so this does not affect any existing
suspend paths.


Looks okay to me.

Reviewed-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>


> 
> Thanks,
> Tianxiang


-- 
Thx and BRs,
Zhongqiu Han
