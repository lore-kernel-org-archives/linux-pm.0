Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EADC23FFFA5
	for <linux-pm@vger.kernel.org>; Wed, 12 Aug 2026 21:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786570380; cv=none; b=j3Xg+vYwOZfK6vc8ERLbXK/pOQaq66Lz3zJqQkKciEDurNQ5mXsNJeDwhiyDa3vGFsSrISBw5Y4VsnBiV0dWQxbl7UddXOgxhVYySynRcerpbNsnoDagkA9VCkWktghs1OQcwiy8pYlLX/AE3iVNAKXKG9SNCS95z2DK5pzQB1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786570380; c=relaxed/simple;
	bh=H9KAVrZ9EZXmZGJEXhr95r4m410l7raCqTQ83d5is70=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HqFnvhVfXmmbexgoclzBR0Iko8OOWfKbqNjc03UuiCsgBMB+xhhzhPVeAaVHJi3zhBVdj8ijiOJW0VhBSmfHPSfUs9GM+TJh+XFhf1oMDNHXL1POQyW8MAUNE0Wnvb/vdw1h+FrxTQ+SL8pt3v5Y2nzcw2c4GNoBUhsUvDIsucY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aW1bJDN2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=F0RqNahi; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aW1bJDN2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="F0RqNahi"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CK2bxZ4038349
	for <linux-pm@vger.kernel.org>; Wed, 12 Aug 2026 21:32:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XkSewvAsCOUodUnPgBSMzzLWKqt2tzeTdiNW08oBack=; b=aW1bJDN2aChrcGdn
	Ppkq0I+Y/FK9ZreN86GjnnpPX9LIuloi9Ja/boy74i+N/x3MQn0KsBPik6kJ1wXe
	DwnHiIXqpoCZDjc0mn6udwtfFgw7OVPursBG+F20Gywu0QNcr2RWWEnP7USi84GT
	E8gJIUAyECJ+vqBU8E1ongcMz1i2mvLo41QuGfZODWzt17wULfTc1JYs0RnH9+fl
	s92qEmwNMDzhpCxaErv94RWwlbRKFBvCStsuAnUNW2vQ289JU6zoUxQjIw067Jhc
	dvBTv22qXYrBYowNDXr3UrPh3B9VoRImjdc5oRFgi0m8gNID14UHSd86bssDKt4q
	HHV91g==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0mndbha5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 12 Aug 2026 21:32:57 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51c26012cd0so246451cf.0
        for <linux-pm@vger.kernel.org>; Wed, 12 Aug 2026 14:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786570376; x=1787175176; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XkSewvAsCOUodUnPgBSMzzLWKqt2tzeTdiNW08oBack=;
        b=F0RqNahikgv0QdZiXNIpu1IL2tcjSo9ghK63TmbQRMmCIuVEGdNUEIXr3ZMZkd4A/F
         5eile0ZeB6bNZvWSc8HVRRfF/mGyIN6D49d0vmBTQMvxroPiztg4SiwrVrfou97NpV4u
         TL2Pl1Q6HAqS5giOIvqT/dPeM8xlPCUWts/uVmIdqVu9sSe3UJQ1C49qOuCSE+D0YoKh
         /Wuv1sftA4ZXZFrGXfawyMpAt7PeyUxoR6Ef+WTdwdhYlKl1Eh/Iwy38/8gsk+IFHnPB
         FmnR8+cSu/M0EPej5ipHaKSBmqDhODPBWk8Vvs/w3EL09AEVSav+jC/Rstulvyx+luNR
         VfDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786570376; x=1787175176;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XkSewvAsCOUodUnPgBSMzzLWKqt2tzeTdiNW08oBack=;
        b=WFLZzAO00GhF1sUGAFnNyCw3pSGexTh8IB5EuKFAwWkzDvothj+IYk37Q/gfJr5sq+
         cJbMHTWs/05+F/V1azlriac15dolkwUtsiV8s5kLsoiCzj6zRXmKGPJjLsjIX7snPCrn
         xC1TDP9ZLoCknawMq2ZXknP88oBBH8qJjxd0rkZ+lwmrZOi6K1nPPkByXzO0RsJQnDQh
         TZcgiuaPmKPWSbqOdpNMYXse0II6De4VqaieRxvsEapkOh9dPncKR6qKEnDzZKKgQfyO
         OXHPvm39bNCZsvXHSGaKgS9WhP7bLmM9gw/+x6BDoj56n4xRbV5wBLWg6tmZeqFuYwSt
         UShA==
X-Forwarded-Encrypted: i=1; AHgh+RpmHOMlUMPhN/neVUONCY5yfr7MvhEk2RnjHQLGHnuSgmL29FulruBxzXqvyPmrl4+a9iSoLL1Paw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzgTGnBqq1KFEHOclfAPnQogQpvhJalmaGrYi8wVkcPG+OYHXpV
	yI2bjWNmI9Fe+8l612zKtQVvhTEhUubsnONZM2mVYJRwhM3mFBaGMNvYU4Ew11gfAmRRePTVn7z
	cUZz2pVOSCGCtJbrA2Js7If5Vk0iSmilfRqC9DQ14IDI7/uiUoUw66Cjc+Q1mCw==
X-Gm-Gg: AR+sD138rjZ5pub8OW/bkBYFnWTrue3N7ONAmPLx1Pm/PgxWbpQvjAERFmMiC/rULft
	BKPbJZ/soTrXFC2qA5PiYKZab9yskryIkVivQ6+MshrRdUqWK4Nx19dql+5rNUdx+f6Fzx31DkP
	yV6tVkmDbV83Qkh3/zm8HGj8tW/ugscaCZGsi/uj8Wmfyii0p8GdhBaKm1ZBkIyMy7RnR1Y5882
	qDTW3/xD0QwSatHR7qSRG+fAxeeHlCDHYIW8Tmk32vNYOEzYFrBYTZ1cLI4Elvr028MXtqNe7WQ
	9zioxv0KqzYq6BwXxvaCmuER2C8d0m2xaOaznL82ik2a4/WPauAVG0iRMyljn4hjD77QkxABgwM
	Gp/Nf2b5amBIJFpicQ/L5Yfs7z/QgIcJxAq6xcnPXlOvhtQkA79VKGegZuFSc9bo=
X-Received: by 2002:a05:622a:1b94:b0:52d:3352:f7bc with SMTP id d75a77b69052e-52d73ddf4c9mr12509661cf.31.1786570376319;
        Wed, 12 Aug 2026 14:32:56 -0700 (PDT)
X-Received: by 2002:a05:622a:1b94:b0:52d:3352:f7bc with SMTP id d75a77b69052e-52d73ddf4c9mr12509231cf.31.1786570375916;
        Wed, 12 Aug 2026 14:32:55 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:d71e:6d83:9df1:6316? ([2a05:6e02:1041:c10:d71e:6d83:9df1:6316])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49981b0f4afsm18768125e9.5.2026.08.12.14.32.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2026 14:32:54 -0700 (PDT)
Message-ID: <55f4589a-5146-4f46-aed1-39a1c3a15ac8@oss.qualcomm.com>
Date: Wed, 12 Aug 2026 23:32:53 +0200
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
 <86ba3abc-c538-4d56-ac2c-3154b95e00b2@oss.qualcomm.com>
 <CAJZ5v0g2G7L0hS64Eh14927P7g+eX_3KB_qUehBoa2OUfh+ung@mail.gmail.com>
 <61e48b08-1a91-4d3a-8617-f25980038bfc@oss.qualcomm.com>
 <CAJZ5v0gi9n4ZAf7YZsf_dXhqYKA3DHZpR_fLmxgukogNKVbb6g@mail.gmail.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <CAJZ5v0gi9n4ZAf7YZsf_dXhqYKA3DHZpR_fLmxgukogNKVbb6g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDE3MyBTYWx0ZWRfXxyF1vHvUDuHC
 P46M7NEaiMzTxPaD6tP+VKA6gmkK1AyPspMHFboK+26EXC6+RinowvdCrt9jU5WHjaaV6vCxUEa
 Fjbb7CM8ZaDDWtjZY867s0xSyfi0zQ0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDE3MyBTYWx0ZWRfX8Cn4NtStu+kL
 vCqBau4AgDgpyz1WoYryyknOVXhiotAxB9wQEHWpgjYmNRhzlR5A0secdL1MTaXqHBKLNS52UT/
 J1gWyXFONfKbqbJoZiBhl9MPL2V8nR2E6dEcC2Tuzk7yRKag/WW14pmZQwY8VW+LMObbhFEY5wN
 0ysJlKrTFmXq1Syld3Gao7eLLOOBIT8JvZLWeN2/6tjEsob6e9ZK/6Lp5ZgVaecJk7DBHmVycSF
 gevdzlAEDzWq67LnXJWzKyiGF1I3UR/n5ovmuRU2xngWTDVdMisHtcucETU+qZCwazUWeO1sMPZ
 N302hX5T7rNpGkEeifnM7BDuS4pxurv+pHq6SD9kYkq9SzCR4qHUTNYntEC2WTQcMqW0U2H7jNZ
 ORLhHPXUdoae8tOdtTFLe8IhPTltfXGMYVzRRf+d6o+Im0BdqoDvJg188kvZaMqkSFMvns50JZA
 +Yp+z4IQIxHI73oSS/w==
X-Proofpoint-GUID: lkkHIJLFQWz7H5yRR334dNpPBOH41k52
X-Authority-Analysis: v=2.4 cv=C87ZDwP+ c=1 sm=1 tr=0 ts=6a7ce689 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=p-CSxRuzmnTlOi1juYIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: lkkHIJLFQWz7H5yRR334dNpPBOH41k52
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 spamscore=0
 clxscore=1015 priorityscore=1501 bulkscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120173

On 8/12/26 18:04, Rafael J. Wysocki (Intel) wrote:
> On Wed, Aug 12, 2026 at 5:16 PM Daniel Lezcano
> <daniel.lezcano@oss.qualcomm.com> wrote:
>>
>> On 8/12/26 14:50, Rafael J. Wysocki (Intel) wrote:
>>> On Wed, Aug 12, 2026 at 2:43 PM Daniel Lezcano
>>> <daniel.lezcano@oss.qualcomm.com> wrote:
>>>>
>>>> On 8/12/26 13:28, Rafael J. Wysocki (Intel) wrote:
>>>>> Hi Daniel,
>>>>>
>>>>> On Tue, Aug 11, 2026 at 4:48 PM Daniel Lezcano
>>>>> <daniel.lezcano@oss.qualcomm.com> wrote:
>>>>>>
>>>>>>
>>>>>> Hi Rafael,
>>>>>>
>>>>>> please ignore this PR because there is a missing SoB.
>>>>>>
>>>>>> I'll fix it and meanwhile update the linux-next branch so it will fix
>>>>>> the build issue.
>>>>>
>>>>> Well, the build issue is still there in my thermal branch though.
>>>>>
>>>>> I've now remerged my linux-next branch to avoid exposing the thermal
>>>>> drivers merge I did previously and I'll wait for another PR from you.
>>>>> Worst-case I'll skip the thermal drivers material in my first 7.3-rc1
>>>>> thermal PR.
>>>> There are 3 fixes on top of the PR.
>>>>
>>>> One is obviously to be folded with the existing series as it is my fault
>>>> I forgot to add the file after fixing a conflict [1] which led to the
>>>> linux-next build failure.
>>>>
>>>> But two were reported by lkp [2][3]. May I take the opportunity to fold
>>>> them with the patches they fix and shall I keep them as is ?
>>>>
>>>> [1]
>>>> https://lore.kernel.org/all/20260811145427.3089426-1-daniel.lezcano@kernel.org/
>>>>
>>>> [2]
>>>> https://lore.kernel.org/all/20260811094935.2941313-1-daniel.lezcano@kernel.org/
>>>>
>>>> [3]
>>>> https://lore.kernel.org/all/20260811094747.2940616-1-daniel.lezcano@kernel.org/
>>>
>>> At this point it's better to do additional fix commits on top of the
>>> previous material as it has all been exposed in my thermal branch for
>>> which there are no history rewrites.
>>>
>>> Please send me a PR with all of the fixes on top of the current HEAD
>>> of my thermal branch.
>>
>> Do you mean linux-pm/thermal ?
> 
> Yes, that one.

It has my PR in it, should it be reset ?
