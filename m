Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CFC4542EFB
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 15:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791991809; cv=none; b=skpPfq5MPTzRG3+AJnpujDRZ9jDzTtkJsogJjQQmF5lTbgNkJa8nN8O/LZxS6NMFJ/iqyXN9MIHnlPZUj1Kngb+DRDnBSIDWsuKQGBEN1+C45ShaFQzgba72CJvHCoCOoelZLFHhcmtunZqNby1hqYTZYUS9p4MsbVIIWVIhWNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791991809; c=relaxed/simple;
	bh=BDhIdaDKZ9lplDbcye0C+desv6HoQGR8gmQmNwSxBNk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=RjFlccSZNps2zQu0gpozzIhW8jbqKDknqKev5su1Nh6NCkQbpM4X8KXi4qXGIMi58ZencDAQfcLQk3lO1eIPYXin7ex1EL1yyadeOMdZUtSfsFWuBLvGoaBCEasesOIblZGSvgYbjly01LXThepkXRLsGilagkEIZpJ01LUkyHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Jq2VNivX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aChsYQml; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Jq2VNivX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aChsYQml"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69EEcXu03209386
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 15:30:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZcsKSAXIsUoQvwuqGKNRF/KRcejBeBzxtNR/efR58HI=; b=Jq2VNivXr3uxGVSS
	MTyjKe0JLetyBXmtG3dKPr8Mv5ytFzQ8CaYshGhBD8RUObMdL+Qfo0KWl4YGeZb8
	qBkq1npT0hLsfr8d8exMyjeKAGHJDnWfkV4UjumTHja2ozm+rRopIYU2t1r0IqS9
	Ik28zgkBqH9vO++pbHEdD1y1VfCnL0LsfmoY03OLTOrGJ1PWE30fMZGQk0qa99Lm
	FKAJI605j9r0HiRE4ewKJtWByl6/+UP+OsEPiFbtVPtYigNpCclMlerV7li6KA6h
	ejjs6Nyam98T8r/sIqDI9vUiNKWk5qYMAvN/dgSWPPKeO67vHfol0zY78YbfM0oO
	fCdBgw==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9ud6c5we-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 15:30:07 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-91b7e7d5f56so73013086d6.3
        for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 08:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791991806; x=1792596606; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZcsKSAXIsUoQvwuqGKNRF/KRcejBeBzxtNR/efR58HI=;
        b=aChsYQmlmMeC3Fg6gfWG4aaew297x14xX1Hh0wIxSUC3P6yjQ/CCjrhEswKrK5fEgD
         jMPYR+/ZjC5GSOt6hxrbaMoun8wRw8lVebIPKpqa9pLuzjr/IXTIy/kSq8Fzazr31rqM
         p7LJpfETqOcyfIkODATlRO6Jy9yYYr0BRZPkDBsPUMQlzLIyrdhUdDrI2pRD1guayq0e
         3z77xhC3lpy1zicUaUAPcO8SNFz7WddZMhvOuZFeqouHfvQyBNOLnYsAhohPdu2d40+1
         pxgUPgneLJ13CQc5VGbENR3vVlO3B5OOmQx0PClCGnCI/2TPHZjqReR+d2Pot8uHhzZ7
         konQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791991806; x=1792596606;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZcsKSAXIsUoQvwuqGKNRF/KRcejBeBzxtNR/efR58HI=;
        b=vXJnoDv6UjGumH4LYxz8ZzwEfGa+EbA3B/J7K+8fsyvJANHhnYk87oS58FhAD6/VWR
         cGWI3tlfprGFpBS2OGvLOd0hrh1N8iGDjwLs4kT4T3JdPGsDfPtM+GfHpXrnYMniJpWk
         lQ81/9Sw+A9JQFjENHOlcQFkhQqAaNhl2fK68Yavy9B0wrLR7XqzagNTWVE/p51B/tXD
         iz/arTbI/2IeB65w5/XxKcbzfq8ro5AM4h0yXw2YnbppeyFvjiwZqPG6zb1QFfadBYpn
         ld3+y/nUo8LQjlfJbLk6GLgft9WSFJcydKwtaguTVFSlvtiEb68ZpuvI9A0hf2UaGpzZ
         xe3w==
X-Forwarded-Encrypted: i=1; AKwUvBwsd/zCikQqj7BHzRi2XPDIC/AKAPokwyRypENgslRS0d3djuZht4vlY5dWEQH6ek4p2+eEv9gVZg==@vger.kernel.org
X-Gm-Message-State: AFq9FYInLbjJBiOvx8jxzciOrYLNCRlphmkiyFr7KIbchRlODl8cGx8C
	BZCSSYvD2oJ4/SzkoKue9hN/hs4PQjy3r3zzXHVxSAatFQc1P8/yuF9IYL//obtLSxr55qIgvHD
	SWH15azdwxRo7Ct9JpLIfn3EZjriuJb7d+/5rCeLfpfv45ULSjcoXnmJb67hmvg==
X-Gm-Gg: AYBFou2YWaw7cHLh4/kNK8YBflozjk5HmK6vVU/KwbUIfkk7cvLvv7KbxZC7gPffO/6
	03BRTYwBoNXEGmsX2u4wkfwbv/zz/C3XFgJ2lBcSxAB4isKKPcyegev6YVEk/Cfl/3Ho9Jpqw7e
	chNbmcOb0OdMceC1Z8ConeZ44qVjY/nMMqv9RvwnuJBOQTEd0RIKjHJ73q3WE2KJIsGwVvUng9J
	jZAnlq/bmp/cNgE3mgSwfjS0Daq1ss22yQKazrcuAw15ExzdlmoFvo+XiDGxXod7aZdey7CaXN1
	PzybdZKniD1tLTBg7WrXpEcTl0AbaXBY+v8CiO1ZChAlpmLr+pdQjZS0DDppIyYsFrU6+0ZJegX
	ZMO0V71CYEwYvOCasY572ZnMyT77cJl7mIlzVQAYs/NyzDpxgBXZdRCSeX7ql7nJ3ohgDXP1BQp
	dVCcTnUGrlpu5oPe3OmJJHA3ST6jGeKRcN8gaL6bhmDmz27tLD59wQ0YR47h7Q1NpMV/o=
X-Received: by 2002:a05:620a:2b90:b0:93e:561c:5bce with SMTP id af79cd13be357-93ebd295d73mr2493797985a.55.1791991806173;
        Wed, 14 Oct 2026 08:30:06 -0700 (PDT)
X-Received: by 2002:a05:620a:2b90:b0:93e:561c:5bce with SMTP id af79cd13be357-93ebd295d73mr2493791485a.55.1791991805667;
        Wed, 14 Oct 2026 08:30:05 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b203762b86sm1331732a12.3.2026.10.14.08.30.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2026 08:30:02 -0700 (PDT)
Message-ID: <8be1a245-6061-4f86-9223-0da18d5e423a@oss.qualcomm.com>
Date: Wed, 14 Oct 2026 17:30:01 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Hans de Goede <johannes.goede@oss.qualcomm.com>
Subject: Re: [PATCH 0/3] ACPI: Serialize battery methods and INT3403 _TMP
To: =?UTF-8?Q?Ali_Ahmet_Memi=C5=9F?= <aliamemis@disroot.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Armin Wolf <W_Armin@gmx.de>, Rong Zhang <i@rong.moe>,
        Charis Stratakis <c.stratakis@proton.me>, linux-acpi@vger.kernel.org,
        linux-pm@vger.kernel.org, acpica-devel@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20261014132703.93355-1-aliamemis@disroot.org>
 <24b2e368-f0bb-484c-bf88-b9ce3125180f@oss.qualcomm.com>
 <20261014150537.121547-1-aliamemis@disroot.org>
Content-Language: en-US, nl
In-Reply-To: <20261014150537.121547-1-aliamemis@disroot.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: p6KQPIHiEoM9_nh4Tx6ocLXR3sWL97-g
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA2MSBTYWx0ZWRfXy2qoarYnKGkX
 bqnbtuRqA/KdJmCmu5/zX8VroNXKFNfhpqQ4WdUYdcq4BVnUE1Aer2SqcB/VKGlhYuXjia5nh1a
 rZRlgV7iYukbnMSuLKJKmRuNEM1TynE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA2MSBTYWx0ZWRfX9ogeJSxvUO7a
 +XFQGIKxp0w06WK5Q8mg6YVB8zkxJ345LEsae/TnBDgno9U0Nt0mL4tibQahfZJEAc/b5sSBT9K
 PM+no8yZR/yMc7gK3aVS1pqt0psJviCSSTqyzhLqezbrGq7ooP6YmTdkLqLyD3AfZWqZ3xtcirV
 XCWQc62rxIZTAeDDyvGYJxzj8rgwchabQ2WMkszCreOGXfWGGp8jgZo5li672HaP7TQx5jaiFJg
 g5UkunRsP334K/M8ZO7X9c7Pqdl/C9MThkWNi0cHSxOcECuiLcFsQ90vjGgR7wFh7b0WjgXltpS
 03okLgBEdw980g8jhZBMgV10Yng3zd2N49K/gAl4iIeMChkc/UNCbDOEaT+mRCKUIM0MmOlERjs
 3X223h2bOx/j/iWD1igQUvubEvgyPgppdNHdtMli4xC57dOSXoZhaRnHmM/CpZvw9xhbqxC+NCC
 Zz+xrmeLfsaz+3LmDbg==
X-Authority-Analysis: v=2.4 cv=fJ6sTpae c=1 sm=1 tr=0 ts=6acf9fff cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=iUgqFhfxAQh3BSJQTYcA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-GUID: p6KQPIHiEoM9_nh4Tx6ocLXR3sWL97-g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 adultscore=0 impostorscore=0 phishscore=0 bulkscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140061

Hi,

On 14-Oct-26 17:05, Ali Ahmet Memiş wrote:
> On Wed, Oct 14, 2026 at 03:45:10PM +0200, Hans de Goede wrote:
>> Hmm, I wonder if we should export the lock added in patch 1/3 and
>> then also take that in the ACPI EC interrupt handler ?
>>
>> The ACPI code already uses a threaded IRQ handler for both EC GPIO
>> IRQs and GPEs so sleeping in the handler should be ok.
> 
> Sleeping is fine, but the interrupt handler completes the EC
> transactions, so taking the lock there would deadlock an exclusive
> _BST.  Doing it in acpi_ec_event_processor() where the _Qxx methods
> are evaluated, works though.

Ack, doing it there sounds good to me.

> With the brightness key queries also
> running the \GTST copy, 283 of 891 _BST reads were broken without it
> and 0 of 804 with it.

Nice :)
>> I'm just thinking that if we're going to do this it would be nice to
>> cover the bko221065 UCSI case too.
> 
> UCSI and _Qxx alone aren't enough there.  I emulated the ECMT users
> from the 83DR tables and the EC helpers kept waiting up to ~680 ms of
> their 1 s timeout behind GBMD/SBMC until the ideapad methods were
> exclusive too.
> 
>> Note this is something which can be done on top of this set.
> 
> I can send a series on top of this one for the EC queries, UCSI and
> ideapad if that sounds good.

That sounds great, thank you so much for looking into this.

We should probably ask the reporters of bko221065 to test
the 2 series combined and see if this finally closes that issue
for real.

Regards,

Hans


