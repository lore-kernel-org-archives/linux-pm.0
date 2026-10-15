Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E240051C322
	for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2026 13:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792069997; cv=none; b=jHvQeNcPn2oIPEnbkqOEgcrgPGP2jSRBBC0tldYmPfX0CxzzvDp8E15kHb7ws60M+coXxohIYEABEdzVpvJbfABvKqhNvHki/OzZI++QMS79FXiL1LBN00k9aX8N9m20uWoX1l/+PH4ZmiszEiFj+PMyekSPSHwkUNZ+jJ++2f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792069997; c=relaxed/simple;
	bh=qhwosOUFEn40xQ8xFJW/TeqPHN2EC2c9BkQeLwTb0ac=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=fVvyvqVqJalVFS4tVVwf6McomT61CQ2Nx9wsBgLKEXqb1KTmiourcJ30PloM+jOwZyh/SdI/9YsVbZEt0+fLTP9wPRLjEKa4D/KQk8micEZBesqHyxRtEwq3aBUtm4zwcIREdjrifCfQ6Nmg+dv0aWDXXOlDSkYmUbAqi1gybmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nrbgjqHy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eZNZr7dO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nrbgjqHy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eZNZr7dO"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69F9jqqs3408923
	for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2026 13:13:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	T4QVkck8E27F/8+DyCCyWCYYz70WAZti6OBC0YA7Lo0=; b=nrbgjqHy43VPixes
	GMy+iRjepgiRo8XgnGN5CqmL+kk3Xhq501X/tx1YTUhmuyWQtxOhxRnbKveBM8vk
	Qrypbr3eC7ILnQFKoexVYXVEFjyaQLOqFOD5QjVpqYLB3efdmnyrNOWOD1x5CG7n
	BkGV1G1kPvytGjmSFyD4q9UCA5duKoioRjUJY/qfljoOLkSL1ScCUAPLOngqKIzG
	IqzR32sQDvxrUbGKWzpN+u2wBD5gU6+FbXt0UUZSZLxdHcOWUCFZ6/i0bXuiOGFm
	IXuLo0ekpbxtsUDFbHjHfy/CwGpL5YAy0fFtR4S9XqVXpYrEPYGZ/QzPG31w4W4u
	zA9YuA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hakwn2wdj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2026 13:13:14 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93e46c120dfso191691685a.1
        for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2026 06:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792069994; x=1792674794; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=T4QVkck8E27F/8+DyCCyWCYYz70WAZti6OBC0YA7Lo0=;
        b=eZNZr7dOYQ2GDTlAQ20g1AXXoQ3k2bwQbplYz2L6/qls7aPY+Kh5sFzHW/CNiMGJ9K
         uLV9VCjJ/yBG/uQr87DofVh7nI/vximi/XLnRXyTC96LhxTz82sTkMBRq2s6DSxir1YH
         P3IW2cU6lh3TUSwUcdz/JagHZ5UMMwx0k6Pv19syoIijcyQq8eMmG6/xumIAQuP0dZ2z
         34jknSfHleul5M0CK35hn4eqShx3mxofAJmsOWcx9W2YWsF2tLW5hWhf7gJa3ZyeEBBE
         3MTOGU2i3ng0pTXf7nTuZPrkZgRsq79RtmNXJpZIqJ5JHUzsmsixYwHyfT27jcsosS4g
         pXuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792069994; x=1792674794;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T4QVkck8E27F/8+DyCCyWCYYz70WAZti6OBC0YA7Lo0=;
        b=EBiy3p86hEjFpVPMSD/RLnrX5Xm0PtiW4oMiKfq2ab+wovRr/Z+wV6Frt4al0sNDhb
         6QeqB4nEyeBNPlJEtu66JcH3TeHePue26DSfNTLqaiBVM0O8EAf7w/bNPCXScm76jiAl
         e6RpqUMT8CCyc2Pi/j0x2y8VwiWHer32k0+bgUJPWtl64uijFI6OmZUrDs7Lh470iVKl
         nr5/7QZnZtJVYcdhJvHE4p4I62KBl1/yCff+BozT3KzrDOxl1e4uUpC8DgKXcmnxO44t
         a8ixkGo0WeHopQXoDz+Wq5oT6E5eoaVBVaNc75uPtD/u/ZfAXmPfssQ/SwDL/iSW703i
         PjSA==
X-Forwarded-Encrypted: i=1; AKwUvBzmyBVfTbBdwToa7oJdVt0OL+JekoTo7OTjXNyjG/bC8b0+89ovmQyDJ9iBjBpG0dRI+s9XVgGUQg==@vger.kernel.org
X-Gm-Message-State: AFq9FYJ1Yj6e5KXOVgB4RvBllJD6u/B4xIJojtbdVc5w73wi+tR0/r+h
	7pmdPJZ1Kk3GNx3RV7iuLXFkawuBkd89iwLA5Pk43cxuh2vq69bLwUDYUN5Job7zQlENB2UVDie
	X+BeHto66idyB7p9dRICUOeH01tvbhSM04WqNpeNBVTFb53Nw4H24B0OJtfFuxw==
X-Gm-Gg: AYBFou3hzS/fdOyQAevTanul0hX708X9tmfWQNqZLqdg3JSbsnQ03gaAFiyJSX6gkb8
	faP+SiI9VbL8lwtUTDGPL5wxWyuepYoUvkLTekadEy7yiuiD7usNC+lSJ5SKOxedS6ClsU+ib9y
	V8pHG4Ma9MLPjJA+enyNy4pbGlx5h4WEZE9BAzyVm8GglqApU2nUkWF0D0Z82ld0KUKOi+S6MSR
	tZdkuluhwSVsx2r7V7zKvrutCn+QyF0qFDOyJgjIwO80DRbPRX7jjli2m9gIRF7kJtP4+C9E8Qm
	6pnLbcuyonrloDrV82lMY8ywbQUNLeo1Scxs+qEBLJxU/bsYiXlKaggTC6FIzW3FqY5WLSjNe8B
	GGJ6P6vDB59CXklP1gs6mcn5zpnqU/Xz8NnqZqw0vnrKwclxm1A/JZzSL3Na5lTPVO317g0+TOC
	5rfG23dyXdapBumeYQwPthm/N+CoShswMoLc//lZ4Eox1EKMdSffavqGgwmaoH8hCLFw==
X-Received: by 2002:a05:620a:4515:b0:93c:aa75:71e with SMTP id af79cd13be357-93ebd27cc81mr3034315685a.55.1792069993767;
        Thu, 15 Oct 2026 06:13:13 -0700 (PDT)
X-Received: by 2002:a05:620a:4515:b0:93c:aa75:71e with SMTP id af79cd13be357-93ebd27cc81mr3034309285a.55.1792069993247;
        Thu, 15 Oct 2026 06:13:13 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b20388cfe6sm2456350a12.28.2026.10.15.06.13.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2026 06:13:12 -0700 (PDT)
Message-ID: <7ecfd94c-7083-4d76-a5f7-490ba1e650d7@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 15:13:10 +0200
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
Content-Language: en-US, nl
In-Reply-To: <58586fa666f09c209f9d7fe8c692a8bdda6d4410.camel@rong.moe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA1MiBTYWx0ZWRfXwBhSbwp1KCnx
 ys744hZSKX4jb26YWMx+bLeBVSJVBZvIDl2A2E4Yr4eqSxGyMs2ozNuHUSm2VOqKPjVCWGZNpYG
 O6zr5el5ZN0//+ztTzhDhH4ECAtUNAdCWM1iZon4AY9pJwFMtrVLfatdpbKFZQ36W39KGf9LeMX
 +VmQpH4w7CrLfUYsdpLHUsdT1FNlMUUcbcJfJ8mKLUpsRDJ9Q8oiEeVvuFLS5j8OfKbrJ/lRHSI
 6hwBtSlqm8MJhmUJ4trgNA3SSZgMDYQgA749rIK04L6+RSGXFhBCR6FD19tfDBE0FotGMpdIU77
 /mhxFhV24OHtoH1N/CQd4+nPmac8xHRtXDWstpY8axY4HXBrtIbDcyUXJ3f5xaiQPVO7v69U9f0
 JipAFbiW9LYWi/1Ruk87Qh9H8JoIWXEepYkX9k1MEMOIJ6LANpB2GGJ8BCAwgIh51qOKABkm+FY
 35qvTuynrRkvUbior3Q==
X-Proofpoint-GUID: ItfT2JjoaqJ49BH03sUhynP0gVUEpaNf
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA1MiBTYWx0ZWRfX2CgfRj5oFp+B
 yItiqCTlWk0JH0Izikti+TPW7lkSpgV/IsAvRQiGwUWrXIbehv+16DqlwCzoYcB56Amvq8D/aiV
 ICn30ibatj7AY3f9RRZuSY+9eqxyoZs=
X-Authority-Analysis: v=2.4 cv=BqUIUoX5 c=1 sm=1 tr=0 ts=6ad0d16a cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=Qb4wfcSRRCwKSm2dVBkA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: ItfT2JjoaqJ49BH03sUhynP0gVUEpaNf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 spamscore=0 bulkscore=0 suspectscore=0
 clxscore=1015 malwarescore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610150052

Hi,

On 15-Oct-26 13:45, Rong Zhang wrote:
> Hi Ali,
> 
> Thanks for working on this!
> 
> The series is generally in a good shape. I just have a few minor
> comments.
> 
> On Wed, 2026-10-14 at 16:26 +0300, Ali Ahmet Memiş wrote:
>> As discussed in [1], add exclusive variants of acpi_evaluate_object()
>> and acpi_evaluate_integer() and use them for the battery methods and
>> INT3403 _TMP, which interleave badly on ThinkPad P1 Gen2 and P53.
>>
>> UCSI (bko221065) is not converted.  
>>
> 
> Please leave a link to the bko bug, so that readers don't need to
> assemble the link themselves.
> 
>> There the contention is on a
> 
> After carefully auditing the ASL code again, I've just found the root
> cause of the mutex acquisition timeout.
> 
> It's hard to notice, but \_SB.PCI0.LPC0.EC0.RDER being declared as
> "Serialized" causes an ABBA deadlock:
> 
> Thread 1 (battery)                         Thread 2 (ideapad-laptop)
> -----------------------------------------  ---------------------------------------
> serialize \_SB.BAT0._BIX                   serialize \_SB.PCI0.LPC0.EC0.VPC0.GBMD
> evaluate \_SB.BAT0._BIX                    evaluate \_SB.PCI0.LPC0.EC0.VPC0.GBMD
>   acquire ECMT [A]
>   serialize \_SB.PCI0.LPC0.EC0.RDIF          serialize \_SB.PCI0.LPC0.EC0.RDER [B]
>   evaluate \_SB.PCI0.LPC0.EC0.RDIF           evaluate \_SB.PCI0.LPC0.EC0.RDER
>     serialize \_SB.PCI0.LPC0.EC0.RDER [B]      acquire ECMT [A]
> 
> That's why merging battery notifications significantly reduced the
> frequency of mutex acquisition timeout.
> 
>> firmware AML mutex that _Qxx EC queries also take, which a wrapper
>> around acpi_evaluate_object() cannot cover, and Rong's notification
>> merging in 7.3 already reduces it on the battery side.
> 
> Lock contention is not the root cause, and EC queries and UCSI _DSM are
> just innocent victims of the ABBA deadlock.

Hmm, ok so since \_SB.BAT0._BIX takes ECMT itself instead of relying
on \_SB.PCI0.LPC0.EC0.RDER taking it (1), this means that not just
the ideapad-laptop GBMD method call but anything calling
\_SB.PCI0.LPC0.EC0.RDER may cause this abba dead-lock, right?
Are we sure nothing else is calling  \_SB.PCI0.LPC0.EC0.RDER ?

Regards,

Hans


1) I guess ACPI mutexes may be taken nested from the same thread



