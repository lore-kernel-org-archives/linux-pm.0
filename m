Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786164119F7
	for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2026 18:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792089339; cv=none; b=lHjB4jO5+IcN3UeJ7CJXryzd0GfZ+mbTpBfcqyVO3SE/VKoc/bQk8gySs3stmRo7LjXJ4Z8cAuclCrzaFvo6qWWMIo58IHHOQ6BLLArGQ5NaKaFymD18SqcYzIWgyRF9M75gWyQikFR0OqI8NKG6B6tZIfmJVbmxsn6a+4IHYmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792089339; c=relaxed/simple;
	bh=KYDXplaztsx1U000X58CB6h3NVEyy6BQoRPvrsqVwwQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=VkHWqBe4OTZagIqqcvMlfN5QPX+FxyV1+t3ZUryAmTueWnzg6y+M4XV/UEOKMiu6ErOHLf5KM81crxgoTRUtswZwX8eUZ80vE7Xfc9sHN7Dkh3JcaVbfWfUEEGHrTXxaVvOXawL2exdXpAKzJZ79OKDTgFl2CWQAUHhCf3kFRSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=etaI/YDC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ks6hCfez; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="etaI/YDC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ks6hCfez"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69FGkFXu4100228
	for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2026 18:35:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/fZkA7+9QpkZ7suFOufJZjC1MOSNUgoX1n+vDs+p77w=; b=etaI/YDCQmWknRCE
	xBv21JQs5fAsFM8O93GxtSMa/geJJelFzvr2WbS/KCzhX4uqIpeQ+CVqWniuZVQ5
	IYhvCPycG01kA85eRnTnebhtuDP2xU9SryvWZcBcjgdQ3DWQ5T3zrO7BYoIoeyrL
	fx3oPkQrZwZ0yi1iwl758SKIkiqVB0z61HRLQ/9dXf95l4zxttBZ0+brbk2AtXAF
	qV500+1sJI3MA8Ddy5tsOMPIXX+CmwQ6ASM+bNaW13TiMFiXmmubd5Qg16rZbBZf
	PO3zKahw0ypF4SMHgRuGYCDfVKLUel0RQc2GcSgLZJaaZuBFcQHhm9dcgqTyTIUf
	RFvEcg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4haw2r9yk0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2026 18:35:35 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93caa0ce0cdso234835085a.2
        for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2026 11:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792089334; x=1792694134; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/fZkA7+9QpkZ7suFOufJZjC1MOSNUgoX1n+vDs+p77w=;
        b=ks6hCfezklK/Phpl8iXjsl4BMnd4Cj2QOk3ktA5VZfe7+bDA3nQJmOrnJJLY+Y1dB8
         lOOkCX1lR+7Qmnk8Xo/w3r6hYYf0y2qU90dGWcqaWZqOyeH1zQNcaCfvRNpdXcEfl+5F
         YJScdBIUGsyJU0HjRxTFMo6Tguw2bVHrP8aPddKwjum/LeHIu1LRqoW0LOKn7YFtoGQK
         +T2pHTm5qBn2oNCal8J/St9gyL/nfEPim1A5qOxkBiUfvj7oaYCFHwwdEYdkUaJUVesi
         qQ/ezFMRr7TTd9dikfK6Mv/N9rJhwMzTSIUfUBjcWHpxb66tlNOp9dn15v0QsUhtqlsH
         6wTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792089334; x=1792694134;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/fZkA7+9QpkZ7suFOufJZjC1MOSNUgoX1n+vDs+p77w=;
        b=dShpY0fZIZcKzjrxI8wYJibMSImpJdrBTN6QJEUecogi+hCveHa6mPvj7HvrDd7UhQ
         pGpelf1W6ANxXnytyGCIAlHSnd9TO/RUtFt+vjfUaJ0T9J/fPlK/RG0l/lbmcLbEWG6o
         6GcmoACJskdDo+1Jf9a9Tk3mTttE8Yo4tnVL5EUAZ0trxSOH2aepo4cxICF7xJlmgb46
         IoXU6gQhNLqj9yJSTFfeO/frhNm1O626W0zpLJYhu31skuuN2COeMRUzvF+2u6BGRHod
         PdIE1c0wXlsfZ/98lbiQtNMkDMd7m2LxWph6i/4e8f7/s4s+5jJqcaTAje89vzQIevzX
         3prw==
X-Forwarded-Encrypted: i=1; AKwUvBwromG7TEt2GDOmGhLfeAltNyG/IUEysMpKmnkjxpqtHhrtl4e6OCK5gHSAOhXD80MM5HafKgJq3A==@vger.kernel.org
X-Gm-Message-State: AFq9FYI7LFgY2R1UGXltbbqZ+IcEZyeHmK6gKXEVQ+1oJqz2l6K6Y1BO
	SLjKS/6SYwIxwPnHD+aNYS4QcP4DkEkY+LCv743dip28qmqnBmcCYwtDioTy34Pmk2lOLeITdNj
	FjbysVhu/PuUhzrNG0EH+UwWgOSLJPoEQUjE3UwCKck0GNksORPS/cyc2UpN3vQ==
X-Gm-Gg: AYBFou1TAa5nuaaPb2emhgsrlad2axv74mxNjcfv4A604AbsWCJP1CZR50Mg4zsnPX9
	NnrF3AqdFqVhytU5EHbl5HrKFkMhvN+3DhPycWP41fTRBucZHL1ILDNpTYYKVNnZ7GQArKBcQOE
	A042BFWCrj1iWjb/uMyxdWL/xN6qwCfa3Wry12NGl5iff3EZcXDuVLrz+j6XG0KnNghjC2ArH+E
	ozb+Rh40Oj1Wk3Rrxj46+1OZheCUmMOJ0qbke6HQNDLrrPWge7X5FcyeTjpgwcptGSsQ6kSu8R/
	UTd6NP+NRxdoUmT2akNNj3pBYYfLVwlth53fAbuD1c9g+CYlkRs7RcGf/jpLsKdSdEKJJ6tJrTD
	+k1z4Uh/WtEc86RJ5onV9AdmcrS+PjKLOGDu1MruW+UGqJZRrZ2+UKLBUmxVRWrRsDw==
X-Received: by 2002:a05:620a:199a:b0:93c:746d:7c72 with SMTP id af79cd13be357-93ebd29a3b1mr3089708985a.64.1792089334016;
        Thu, 15 Oct 2026 11:35:34 -0700 (PDT)
X-Received: by 2002:a05:620a:199a:b0:93c:746d:7c72 with SMTP id af79cd13be357-93ebd29a3b1mr3089703385a.64.1792089333389;
        Thu, 15 Oct 2026 11:35:33 -0700 (PDT)
Received: from [192.168.1.35] (85-147-213-205.cable.dynamic.v4.ziggo.nl. [85.147.213.205])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c3fd83464a7sm63267966b.76.2026.10.15.11.35.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2026 11:35:32 -0700 (PDT)
Message-ID: <33a935e1-1417-455c-8776-59ccd04230cb@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 20:35:29 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Hans de Goede <johannes.goede@oss.qualcomm.com>
Subject: Re: [PATCH 0/3] ACPI: Serialize battery methods and INT3403 _TMP
To: Rong Zhang <i@rong.moe>,
        =?UTF-8?Q?Ali_Ahmet_Memi=C5=9F?=
 <aliamemis@disroot.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Armin Wolf <W_Armin@gmx.de>, Charis Stratakis <c.stratakis@proton.me>,
        linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org,
        acpica-devel@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20261014132703.93355-1-aliamemis@disroot.org>
 <58586fa666f09c209f9d7fe8c692a8bdda6d4410.camel@rong.moe>
 <7ecfd94c-7083-4d76-a5f7-490ba1e650d7@oss.qualcomm.com>
 <db52af80e3d52f16a609071db79a29e012f4fcd9.camel@rong.moe>
Content-Language: en-US, nl
In-Reply-To: <db52af80e3d52f16a609071db79a29e012f4fcd9.camel@rong.moe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA3NCBTYWx0ZWRfX0zhpPWxq/QX8
 oDRpNkDL8nw3IJXyQ5C9rqILDoizSaA05cs1TWexz6c6VuD/8DXdCqXO1ftWZNxtUgnnuiEPnWU
 evyHqtsiIYiRMPQ8egimClv7P7JdU0k=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA3NCBTYWx0ZWRfX8FnYFZAKoqRB
 Jb20EndNW2XXV8jRg6fOdBw6OyVOzBFrOgziz3Kg7ZWS4C315bCBU3327qwgVwa6ljHtCD4pK5C
 THy7+rX6J39T9h3ZIhHDwvIE3znaiynG6Go9bfTw7rf4oMMDQBA7ChBvAp4G/9kKfQRccezcOsu
 EtsajqJtQR2FycE+ISSVJIBzoTraIpTaMG9+3C+4wcFPrpAXscaBaiArUeaVMnW+Te1Se1m9OIW
 oMrXXTU8UOZGf40327bQeKwCdY/ZuOa7Ie9A8MK7ck7tUuFaqsltgzOUkhYMamFglG2acxDGEIS
 /Z8nXw4nP8zC2JVCm8LuSyQ4SgsttF8xKLvBYr//zZyEIbrna7Z+aQg4oGs6/yW95H/kdBWeRp2
 CM/6WXzJYK8M9bTwCCvuQ5Wn8JAw/iUSY0OyovpbCI0pLwPSsxdI61rqZPxNH7JmA7BHHiR3X2o
 0736UfiVVISywqn78kw==
X-Authority-Analysis: v=2.4 cv=BNMmP1QG c=1 sm=1 tr=0 ts=6ad11cf7 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=Y5s2KDXI4nyRj/ULHr3D4g==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=Wruc98bIDj3zykDVo-cA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: oneuI1MqqycptZrk_WhUjtPYMHfuoWrT
X-Proofpoint-ORIG-GUID: oneuI1MqqycptZrk_WhUjtPYMHfuoWrT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150074

Hi,

On 15-Oct-26 15:48, Rong Zhang wrote:
> Hi Hans,
> 
> On Thu, 2026-10-15 at 15:13 +0200, Hans de Goede wrote:
>> Hi,
>>
>> On 15-Oct-26 13:45, Rong Zhang wrote:
>>> Hi Ali,
>>>
>>> Thanks for working on this!
>>>
>>> The series is generally in a good shape. I just have a few minor
>>> comments.
>>>
>>> On Wed, 2026-10-14 at 16:26 +0300, Ali Ahmet Memiş wrote:
>>>> As discussed in [1], add exclusive variants of acpi_evaluate_object()
>>>> and acpi_evaluate_integer() and use them for the battery methods and
>>>> INT3403 _TMP, which interleave badly on ThinkPad P1 Gen2 and P53.
>>>>
>>>> UCSI (bko221065) is not converted.  
>>>>
>>>
>>> Please leave a link to the bko bug, so that readers don't need to
>>> assemble the link themselves.
>>>
>>>> There the contention is on a
>>>
>>> After carefully auditing the ASL code again, I've just found the root
>>> cause of the mutex acquisition timeout.
>>>
>>> It's hard to notice, but \_SB.PCI0.LPC0.EC0.RDER being declared as
>>> "Serialized" causes an ABBA deadlock:
>>>
>>> Thread 1 (battery)                         Thread 2 (ideapad-laptop)
>>> -----------------------------------------  ---------------------------------------
>>> serialize \_SB.BAT0._BIX                   serialize \_SB.PCI0.LPC0.EC0.VPC0.GBMD
>>> evaluate \_SB.BAT0._BIX                    evaluate \_SB.PCI0.LPC0.EC0.VPC0.GBMD
>>>   acquire ECMT [A]
>>>   serialize \_SB.PCI0.LPC0.EC0.RDIF          serialize \_SB.PCI0.LPC0.EC0.RDER [B]
>>>   evaluate \_SB.PCI0.LPC0.EC0.RDIF           evaluate \_SB.PCI0.LPC0.EC0.RDER
>>>     serialize \_SB.PCI0.LPC0.EC0.RDER [B]      acquire ECMT [A]
>>>
>>> That's why merging battery notifications significantly reduced the
>>> frequency of mutex acquisition timeout.
>>>
>>>> firmware AML mutex that _Qxx EC queries also take, which a wrapper
>>>> around acpi_evaluate_object() cannot cover, and Rong's notification
>>>> merging in 7.3 already reduces it on the battery side.
>>>
>>> Lock contention is not the root cause, and EC queries and UCSI _DSM are
>>> just innocent victims of the ABBA deadlock.
>>
>> Hmm, ok so since \_SB.BAT0._BIX takes ECMT itself instead of relying
>> on \_SB.PCI0.LPC0.EC0.RDER taking it (1), 
>>
> 
> I guess the intent of holding ECMT in _BIX was to prevent race conditions
> in multi-threaded interpreters. IOW, the firmware authors probably took
> multi-threaded interpreter into their consideration.
> 
>         If ((Acquire (^^PCI0.LPC0.EC0.ECMT, 0x2000) == 0x00))
>         {
>             If (((^^PCI0.LPC0.EC0.BTDV && ^^PCI0.LPC0.EC0.BTFC) && ^^PCI0.LPC0.EC0.BTDC))
>             {
>                 BPK1 [0x01] = 0x00
>                 Local0 = ^^PCI0.LPC0.EC0.BTDC /* \_SB_.PCI0.LPC0.EC0_.BTDC */
>                 Local0 *= 0x0A
>                 BPK1 [0x02] = Local0
>                 Local0 = ^^PCI0.LPC0.EC0.BTFC /* \_SB_.PCI0.LPC0.EC0_.BTFC */
>                 Local0 *= 0x0A
>                 BPK1 [0x03] = Local0
>                 BPK1 [0x05] = ^^PCI0.LPC0.EC0.BTDV /* \_SB_.PCI0.LPC0.EC0_.BTDV */
>                 Local0 = ^^PCI0.LPC0.EC0.BTFC /* \_SB_.PCI0.LPC0.EC0_.BTFC */
>                 Local0 *= 0x0A
>                 Local0 *= 0x0A
>                 Divide (Local0, 0x64, Local1, Local2)
>                 BPK1 [0x06] = Local2
>                 Local0 = ^^PCI0.LPC0.EC0.BTFC /* \_SB_.PCI0.LPC0.EC0_.BTFC */
>                 Local0 *= 0x0A
>                 Local0 *= 0x02
>                 Divide (Local0, 0x64, Local1, Local2)
>                 BPK1 [0x07] = Local2
>                 BPK1 [0x08] = ^^PCI0.LPC0.EC0.BTCC /* \_SB_.PCI0.LPC0.EC0_.BTCC */
>                 BPK1 [0x09] = 0x251C
>             }
> 
>             BPK1 [0x10] = ToString (^^PCI0.LPC0.EC0.RDIF (0x01), Ones)
>             ToDecimalString (^^PCI0.LPC0.EC0.BTSN, Local0)
>             BPK1 [0x11] = ToBuffer (Local0)
>             BPK1 [0x12] = ToString (^^PCI0.LPC0.EC0.RDIF (0x02), Ones)
>             BPK1 [0x13] = ToString (^^PCI0.LPC0.EC0.RDIF (0x03), Ones)
>             Release (^^PCI0.LPC0.EC0.ECMT)
>         }
> 
>> this means that not just
>> the ideapad-laptop GBMD method call but anything calling
>> \_SB.PCI0.LPC0.EC0.RDER may cause this abba dead-lock, right?
>> Are we sure nothing else is calling  \_SB.PCI0.LPC0.EC0.RDER ?
> 
> I checked all code paths with ECMT involved, and concluded a call graph
> with all faulty methods:
> 
>                       ideapad-laptop
>                             |
>                             v
>    battery                 GBMD
>      |                      |
>      v                      v
>    _BIX -> ECMT -> RDIF -> RDER -> ECMT
>                     ^       ^
>                     |       |
>     +---------------+-------+
>     |
>    GSBI -> ECMT -> SMTE/SMTF -> ECMT
> 
> GSBI: \_SB.PCI0.LPC0.EC0.VPC0.GSBI
> SMTE: \_SB.PCI0.LPC0.EC0.VPC0.SMTE
> SMTF: \_SB.PCI0.LPC0.EC0.VPC0.SMTF
> 
> All methods in the graph are never called by any method or driver that is
> not in the graph.
> 
> So battery and ideapad-laptop are the only drivers that could potentially
> trigger the ABBA deadlock.

Great, thank you for checking this.

Given the above I agree with Rafael to drop the EC query and UCSI
patches for the time being.

Regards,

Hans


