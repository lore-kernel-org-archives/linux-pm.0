Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09B54B1CF4
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 09:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791971903; cv=none; b=EKx+wlV3Zp44Lv1ViCUrqXOQ7tAuDHjWQwcjMohEm8yQ9xvNoanL2sPSJT666mXciSlTO828brFI9W5v2ebEUkHg8QOJx3FlceIsG96qu1BpFHvh6MvSgP73s8NEL8VN6pYqqJPmO15OTZJXBOX/4mQWbA69/n6bO+its2ScUm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791971903; c=relaxed/simple;
	bh=QRF1ppEabvf/Jh35Rw2YAMaC3v5QUSgiHFDdxHpxbkE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=rtp+A2tFbUFwJaU2IevzHW0llCmP7p6ROUTvPY06Bzaiqtgbgg8KoAljbBfEytif2v3u3CimrVrHwEBsCCNO5kg8/3/xUvlZGkCmwA64ma7rQXzv8sj9JGXpzBnnRuwd0MbDMWHiMYxOVKuJnw2vZOM+R03smQOmaQyRGXmLBR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=m2BJ0SjB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jc0rRYV9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="m2BJ0SjB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jc0rRYV9"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69E9RZNp2222258
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 09:58:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/G+DzcLKPK/Sj5Hw9eJXYwgew9ReSZ4k3cWf6CS+x4Q=; b=m2BJ0SjBVLkB8+nk
	mU3Q714fqH3TC9lBW3FDuODeuavFXB6xnS8Hd2Qjh784rNKgbSw7dyGqJp/L+uGk
	iRZO7LA85T3q/U9+91enKIcZsgyOMdF8fbSD0D4r46FL+E4lFfEOxT5Bd72dkZFB
	oq72Ra4jiojnHroJ1cYr1otgxNf9U68dWwkruULdiOQ8QYD9QTGYdt0v5QtVxqw1
	zxHzLep5SBhrpj3+aoDumtwt6XaxH9Uip/PVcuoD9RPzzPLWtoXR6w8N8fmgsknl
	NZ/CtmMW5kiGszak9N46nUdIGO5iUhn+UOBEN85io4sSvP/UFeewVQuZUrUtVAlc
	nF1DBg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9txsb15f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 09:58:21 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93cc40759b2so858786785a.1
        for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 02:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791971900; x=1792576700; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/G+DzcLKPK/Sj5Hw9eJXYwgew9ReSZ4k3cWf6CS+x4Q=;
        b=jc0rRYV9aMLQ8LHq012MneanIvECscolySU6azG0Q43R5gc7gDB58ehLwiIcOZjcEw
         jw86efzuXoolbElMDDxqNrJGZtwTvjQjqlTtt8xzD4wjRcD40w66g8juoMCq4y/t9siq
         4N4pDrN7tL9RmZM6IdKBKdz2pjCEDcMCl6OrHEQjO/DSptwpHeNm7uRKhn/JNf9QnVYf
         /8+6yyFQMogFKwXfo6gHaAU+fOEWs7s5unX6/vNYM2OfDz+lDagTuBSXoCwJfGyqnV85
         aOHuGy7xeUhiiqs3hBVcAioVavzkaaN5ZYPcx+ZEoW90fjsmPcC7obgyFjsqQxdu/bCl
         mH2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791971900; x=1792576700;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/G+DzcLKPK/Sj5Hw9eJXYwgew9ReSZ4k3cWf6CS+x4Q=;
        b=efs6pR7Dgo8Ammsx85wBqGVTATBfibr3ix1HdnFeiTZiM8zi8PKXrg8EZ2gx1sPVXF
         em8sWmlTWTW96JPn3VY+Q/mqgq+Je/GtBJlriJoDwW+/l1djBUMXfEkdDAX6NO+sB6Pt
         v8SUmjrTb7V4OZv2Fto4eKh/LXlXZpHwripgMOqYeK8jHOs8SsYAqSedjHCZe+SSMgDa
         DqEL5sR5V1sNr/y7I2Mn6MMcdiURRIdZCxzvZ22ibHV5f+45pi9VPhOFtQFldPsD3f8N
         7xmPwVtZQUB99ImmT1C6ez2swd7kq2S8wXQqJuoai7fVDbkyt/YJM2V+QT8ByZWt0U/G
         bkxA==
X-Forwarded-Encrypted: i=1; AKwUvByMpgBLTkpzOiWViBrzcc+v9DTqUy7S/SDykla/9Z2AzV0QH6AHMPAANw7h1592j0HL2Hawd0ESLQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYJpNw0Bsx/e30FTnkkNMkbo8xv9CaqF04K12nP5RtwXMfAtbDR1
	gQZ4gjk1jEIk0GCJENchVudPzvpqcnyb9qEr7D0y+fQXbEtB0j/tLn/GV6xYZW1kMyFBn9YxZDa
	30AlXHA7cHcSoNPt0vclKah4iFDzfNAVzudURLNCCD1pdHHZh21PhiDTCVOFCCw==
X-Gm-Gg: AYBFou0DkaHjU9lwzuy4IjNp1Q6GKHUtNQExV5KreQMvasNixoQRrodXShmSTiJ1bmX
	gfnNpV7RoCie/7cYOLFsf+8Xb2Tlhx6kmn2lmCzyEMgMfAKRSfjSnSX9JlxDMccmroJ1+ECfzQE
	gnPWzSzT1dBeq3g+4pMMSu7jA7AVnfvZ6rk0vY58SdXAHyAlVVpT6jjDEDdX6NAdslBI73l0x5I
	GNPnvn/+kBmQiDHJPDonf7qXE01RjopC/n/3jJ+5eFUJSUdPH3hi8RIQVBHz1a3kYP7Bq5Ao2TA
	uByE5AyzySVqsHKDDS99TjkzVoZR0svBNWNZW9vQBANSGnHRtue6IW4kY1msUwuEgJAuTvWns+P
	ma7mEXgu7GEugcso8fTtp6kqkABZJ1cQss5byVsXYRofHueKqWtYfBlWhuufXHrIlRzghCQgPV0
	fwTHJNfUmKrQPDEpVdOAwtvgIwFe95xjgrud8BnvLEcRZyEn1qAz/iymrm1jLb/G4bvw==
X-Received: by 2002:a05:620a:198d:b0:93c:72d2:ccc0 with SMTP id af79cd13be357-93ebd1b7168mr2353685685a.17.1791971899973;
        Wed, 14 Oct 2026 02:58:19 -0700 (PDT)
X-Received: by 2002:a05:620a:198d:b0:93c:72d2:ccc0 with SMTP id af79cd13be357-93ebd1b7168mr2353683285a.17.1791971899387;
        Wed, 14 Oct 2026 02:58:19 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c338d5b170fsm461989866b.75.2026.10.14.02.58.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2026 02:58:18 -0700 (PDT)
Message-ID: <b64b8092-93d7-4873-a55f-422b8e70cc04@oss.qualcomm.com>
Date: Wed, 14 Oct 2026 11:58:17 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: johannes.goede@oss.qualcomm.com
Subject: Re: [PATCH] ACPI: battery: Re-read battery information in the
 complete callback
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: =?UTF-8?Q?Ali_Ahmet_Memi=C5=9F?= <aliamemis@disroot.org>,
        Len Brown <lenb@kernel.org>, Armin Wolf <W_Armin@gmx.de>,
        Charis Stratakis <c.stratakis@proton.me>, linux-acpi@vger.kernel.org,
        linux-pm@vger.kernel.org, regressions@lists.linux.dev,
        Mark Pearson <mpearson-lenovo@squebb.ca>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <37N_jFulf7n-Z55NfKfE71C_wVPxYvZ0xD_iRUg2fXu7TypDiF5PStQ6siSfVBih6fThg5WoPes8U5ZQpfVm_teMFcUGXFxz2DdMbfSWuws=@proton.me>
 <20261012225141.13683-1-aliamemis@disroot.org>
 <fb993dd3-ee56-4e3d-aa16-573f011518f1@oss.qualcomm.com>
 <CAJZ5v0gS4agVUkCO6M=VW4Wi2y1-s+k23bpzmX9aAZ0Rsv4z9Q@mail.gmail.com>
 <044e9df4-1399-4ceb-80f8-f7cfe031d04f@oss.qualcomm.com>
 <CAJZ5v0isCM3K3U6HSdDnvXzBX41AgQMFYxqLx3KvMA0W_91-ew@mail.gmail.com>
Content-Language: en-US, nl
In-Reply-To: <CAJZ5v0isCM3K3U6HSdDnvXzBX41AgQMFYxqLx3KvMA0W_91-ew@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDAzOSBTYWx0ZWRfXwCOKamdekPRh
 AF0h5f0vSzM2QBN3BYODINuxrbJ69YO6XWVD/VTj7GfH2S1PubBAbyO/zUmwHae6mVzjtxJlBDQ
 G2cqSyp109DfdnorDYn/N18TBmNbRzA3K9x+ATXj3GlZvYVktgnj6g9M2GcybKUFa/gQQ/oT84O
 8WJqf+JWYTQF1LervwStTjxbA7shGB9cU8JMQJMPuuNpZ33/znYWWRFzZ3fKEdoZzzLZIRvG0H0
 +IRkg6wg5eTwrYUoUtuZF7ymhS+VVJHkwh8iknGfp22R9nwTAIfhDI5+gull0B045XLl9AlPwwM
 d1WbFPx3iINTsW675HfyPnzPbeh680RWJzb3iwoE9nyg2rK/BwZ0SP2dHlCZZ9eseR76DZA1OQq
 U74POEn40uobCtAr0wTQJFdQMScJJcu6EGrnHbbcRfIBoIKoJukidUJ4q4Y6RnAmdYRhUxByxCy
 hmGUbW0JQ5SBPlDK65Q==
X-Authority-Analysis: v=2.4 cv=LPPz05W9 c=1 sm=1 tr=0 ts=6acf523d cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=ZT-_DgOL5kLWaA04cYkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDAzOSBTYWx0ZWRfXxJit9q6EdXbH
 df+G50K/U6+5OQ6YHToi7CqrvftIizhsZfvbGel+vWbhT+AxKPy7o4Hw0tTf40AlDndduNHxJKY
 LpBUPEbYuq1QjxxmM3qpoSGbJBJwz2A=
X-Proofpoint-ORIG-GUID: ZIcF7NY56ZjQ684DqH-2CW9B8Pr1pfdn
X-Proofpoint-GUID: ZIcF7NY56ZjQ684DqH-2CW9B8Pr1pfdn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 clxscore=1015 adultscore=0 malwarescore=0
 phishscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610140039

Hi Rafael,

On 13-Oct-26 19:20, Rafael J. Wysocki (Intel) wrote:
> Hi Hans,
> 
> On Tue, Oct 13, 2026 at 3:36 PM <johannes.goede@oss.qualcomm.com> wrote:
>>
>> Hi Rafael,
>>
>> On 13-Oct-26 13:58, Rafael J. Wysocki (Intel) wrote:
>>> On Tue, Oct 13, 2026 at 11:33 AM <johannes.goede@oss.qualcomm.com> wrote:
>>>>
>>>> Hi,
>>>>
>>>> On 13-Oct-26 00:46, Ali Ahmet Memiş wrote:
>>>>> Since commit d33e89d12295 ("thermal: core: Suspend thermal zones later
>>>>> and resume them earlier"), thermal zones are resumed from dpm_complete(),
>>>>> before the PM_POST_SUSPEND notifier that re-reads _BIX and _BST. On
>>>>> ThinkPad P1 Gen2 and P53, INT3403 _TMP calls \GTST which switches the EC
>>>>> page selector (HIID) without taking the BATM mutex used by the battery
>>>>> methods. ACPICA releases the interpreter lock around EC accesses
>>>>
>>>> I'm wondering if this "ACPICA releases the interpreter lock around EC
>>>> accesses" is not the real problem here.
>>>
>>> Yes, it most likely is.
>>>
>>> What actually happens is that ACPICA drops the interpreter lock and
>>> the namespace lock in several cases listed in the
>>> acpi_ex_exit_interpreter() documentation comment, the majority of
>>> which involve having to wait.
>>>
>>> The bottom line though is that the interpreter and namespace locks
>>> cannot be expected to be held throughout AML evaluation because it is
>>> not known in advance if any of the cases in question will appear.
>>>
>>>> Recently I've learned / heard
>>>> from a trusted source that Windows ACPI subsystem is very much single
>>>> threaded. So it is nice that ACPI has these mutexes and other stuff
>>>> to support multi-threading but as long as Windows ACPI interpreter is
>>>> not multi-threaded I think we may need to consider to copy Windows
>>>> behavior.
>>>
>>> This is also my conclusion, at least to some extent.
>>>
>>> The problem with it though is that in some cases parallel evaluation
>>> of AML is actually useful.  For example, say two PCI devices are
>>> powered up at the same time and AML waits for each of them.  The async
>>> suspend/resume aligns those waits to take place simultaneously instead
>>> of serializing them which allows some time to be saved.
>>>
>>>> So maybe the EC accesses should keep the interpreter lock locked during
>>>> EC accesses.
>>>
>>> The problem here is that it is hard to say in advance whether or not
>>> _BIX or _BST will access the EC and whether or not that will clash
>>> with _TMP evaluation for a seemingly unrelated thermal zone.
>>>
>>>> And even go further and maybe we need to introduce a big-acpi-lock,
>>>> which I guess the interpreter lock more or less is? And just serialize
>>>> all ACPI accesses since most ACPI tables clearly do not handle
>>>> multi-threaded access to ACPI methods well ?
>>>
>>> I would be inclined to do so except for device power management
>>> methods, that is _ON, _OFF, and _PSx, that are not the problematic
>>> ones, at least as far as I know.
>>
>> That sounds like a reasonable compromise which should fix both
>> this case as well as help with bko221065 .
>>
>>>> Another example of multi-threaded ACPI calls causing problems is:
>>>>
>>>> https://bugzilla.kernel.org/show_bug.cgi?id=221065
>>>
>>> Right.
>>>
>>> So I guess the idea would be to add locking to acpi_evaluate_object()?
>>
>> Yes that seems like a nice single point of entry to do this where
>> all the various helpers eventually end up.
> 
> That, of course, would require updating ACPICA code and I'm not sure
> if doing it upstream is useful.  For example, if some hosts already
> use locking around acpi_evaluate_object(), this modification won't
> help them and it will certainly be a change in behavior.
> 
> This means that we'll likely end up with a Linux-specific divergence
> from the upstream which can be lived with, but it won't be nice.

Ah, I see.

>>> An alternative might be to introduce an "exclusive" variant of
>>> acpi_evaluate_object() with built-in locking and use it in the cases
>>> that are known-problematic.
>>
>> So here we have _TMP and _BIX / _BST and in bko221065 we have
>> a bunch of again batteyr methods + UCSI racing. I'm afraid if
>> we add something like acpi_evaluate_object_exclusive() we'll end
>> up eventually using that almost everywhere.
> 
> While I think that your concern is valid, this can be done without
> touching the ACPICA code at all.

Not needing to touch ACPICA is a valid concern. So I agree lets go
with a wrapper for paths which we know need to be serialized for now.

And then add that around the battery methods + _TMP + UCSI methods
for starters I guess ?

###

Should we also stop releasing the interpreter lock in the EC code?

All these things (battery, _TMP, UCSI) seem to have in common that
they might talk to the EC in some cases?

Where as e.g. your powering-up of PCI slots example is unlikely to
talk to the EC ?

Regards,

Hans


