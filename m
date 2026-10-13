Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BECF8503BC2
	for <linux-pm@vger.kernel.org>; Tue, 13 Oct 2026 13:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791898578; cv=none; b=mDoSdjlJrwOcAdKWtQgVRUP7V+KPObw0WPhb5iSWcQSaOpphekdr/kEDP/d6RhFI6aybc/qyx19lxpoBpB7YdtjfzASE27U/xqz2o/JIG43ofRxJjz6mJ8M9+7NLxagH0x2QAcxl1EnoBowj7o7kY7ufLqfxWk7ZGBajHQs4yVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791898578; c=relaxed/simple;
	bh=Lgk9ryxB4wlwUpPpSqjkNiShbk84CUmjVZpN3Z805q8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Tx3Agm90N0UTI437UvbW6/ERlWtcq5ufLSmNcAf0OCNcfMQNOCycfZlxwyHxXRVo+aIjd3gxiYarlmsHepIjPay55WLBo89Yc0hlnkUw/5mbO7pocTfdyj/SPY7AP8V7JaAYR/cUOve3rQmNN0dh4yroQMAluVPEiTxXZ7UKeVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EnpB4CIG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GWxCrU/0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EnpB4CIG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GWxCrU/0"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69D9tRAc3475857
	for <linux-pm@vger.kernel.org>; Tue, 13 Oct 2026 13:36:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XHPs2aSg7qSq8sMw0lMTSM9cUyOJg6fhbZjMyvCBsuk=; b=EnpB4CIGyiyHOCa/
	WJm8PKkFr7sbTbIFH25UjbupMh8sqKOQHk2Euz9Su4u859F3Dt18GjHbaFbXe49g
	pqkvtglbzqJ7X4BZd3Qsm55k685ADZXtLuv17lARW9VdbbUwFZz1M7oPeTisU+AA
	VlMNvpBgQaVpvhRdWdpYY4bSZSBTJheXZMXdyNprtO39lbNtEgpO86k053vRr6EV
	Xf88FwqlkYpYtR0LqdEW1JNg1Zv23mPV1y4aqpd4sSWPQ8PvonXXgzFyrCUZpLPd
	QhvqN4dkFd7qBP0s7qMWAsj5ztTv58e2Ikkajdkgns/QoPiRUTxJ5Kz1gqiHuh+d
	RKsowg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9d7ja9xf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 13 Oct 2026 13:36:15 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93caf6c528aso520461485a.0
        for <linux-pm@vger.kernel.org>; Tue, 13 Oct 2026 06:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791898575; x=1792503375; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XHPs2aSg7qSq8sMw0lMTSM9cUyOJg6fhbZjMyvCBsuk=;
        b=GWxCrU/05w7AD857SvT8dlB6WVAfiPmwBpoyQWl+4qDpxUqiNCCaJfnxE0fC0Pg0Qt
         4+TNpMhE0yoghwSpkOq/uick3D69XbiqPIKtiOl7etTctEqC+i/Pnci5zGxJ8xIhBmX4
         HU2lMe8bjX/soF5umjIFIGxPpr/AUn8044c8O/kIc4kjdkcnc2BA2OYB92rbNH0F+1as
         SBxYUVlxpRf+4taICqgRzlS9gijD63WAXNB9pJ127iKgl/viuzL9+LOq/lPgf83gEG4O
         KfG4oDRrY9Wv7XIX3Ws8IC6cwH/mB5Zj0pQRN34x40FVhQSbusfcHokkpXkoeLHIsyFM
         i2Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791898575; x=1792503375;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XHPs2aSg7qSq8sMw0lMTSM9cUyOJg6fhbZjMyvCBsuk=;
        b=bE7YfNUO5NlMpdK7ZZPs5Qksuqwv2nWxaGsNv+cwB+la3uFTJfzzzx5tCG9AXwbR2q
         3BCiQF/5CZp+Z6dbiU795FRuLJa4U8RkOjL6dnC0No63Ld0cbN09Fj3IohtxJruCvO8M
         l91S0fYglcQHDIsuhdPabc1iH8EGv3zlW6FXYyypfBEkCtR3qf4tex8WOyEqUAIJsi0y
         K4/Cxs81GjBc07EBzE8h9DTsBuyzi9+agIB9jK83iWpN4eLdtS4i1JH4o+zpWb6C09Ip
         t+Wrv1a1rwXItKf3dXOnp7EFnHOvCGKp6O+o8an5pPU7E/FNvBNd0zVTUR8tDbS6aMhc
         LsAg==
X-Forwarded-Encrypted: i=1; AKwUvByFp70H48cRg8wvvyLMyC+75FexjGBE+0l1N/hzJjW0jmuLt9xiptz4Ic9M+tS+ygYGXe1ho3Yumg==@vger.kernel.org
X-Gm-Message-State: AFq9FYJji7XbMZ/lQLcDCmdLM536w3qJT9GwOhyFZmWu2Af0JmPabyEE
	Ol7qOomSGx81ejjm7F70oobMOiN+ZVSMBWP91G6ZqUZP59p2QSBTNCQ8+o2jvqtel79jF9Ytz6J
	FZomwfRGUtlhEWazZBlstRQ29uM5YcIBUR+BRNLvNB7a4n7DkphUpv6oaby51WQ==
X-Gm-Gg: AYBFou2+jnoQyz1t7HXS9kBNlRqsrFaC26Boy42QRcIivngW+db7Tlc3NiB0rrlUnhp
	d/Iq28OvqKy94kiZWHpy1W7L0ap/toUBbh9iC/sX0Z6zO9NPIZ9IFifdN+ZNMJmV/hSizfN4STU
	3uv0f+ceBYqrqfZNk3HY2rgGiyC78Yv0u6QMxIBxkApaCm+RoUiZZSULvr1iY3cSQxODtq24jXz
	aesLyzEbzX9ubK9LLbyUJuhxput25wgkuJBZmOyN7yt16PgbDFu+RI4aY1HdhoKQqhq80prQmvF
	A3ZKl92gNPVrcZC2wP6PuGW+bcUImtXy4HHkmRHv97DTCE03hNnzeUChO7PQ88P85KluzzQv6/K
	PVWnVRzohbgCQhPgeM4vZampOL8XaMwbZP6J01h5+gpfNdbIyhtjsvRmiJkDubeat6ZIfOph2V6
	ukFBLBHrA9UnlYvv5cOEG3VNsuwqI2EOLZyxyJLhPaslpNsSfhYDi23weWqYz6rvaTgA==
X-Received: by 2002:a05:620a:3705:b0:93e:4ede:893c with SMTP id af79cd13be357-93ebd1dff48mr1978375185a.14.1791898574780;
        Tue, 13 Oct 2026 06:36:14 -0700 (PDT)
X-Received: by 2002:a05:620a:3705:b0:93e:4ede:893c with SMTP id af79cd13be357-93ebd1dff48mr1978366785a.14.1791898574001;
        Tue, 13 Oct 2026 06:36:14 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b1c27f0f3esm2632349a12.27.2026.10.13.06.36.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2026 06:36:13 -0700 (PDT)
Message-ID: <044e9df4-1399-4ceb-80f8-f7cfe031d04f@oss.qualcomm.com>
Date: Tue, 13 Oct 2026 15:36:11 +0200
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
Content-Language: en-US, nl
In-Reply-To: <CAJZ5v0gS4agVUkCO6M=VW4Wi2y1-s+k23bpzmX9aAZ0Rsv4z9Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 4kEfqwKC4dqkGHN9o3kweN2rshe0Am8W
X-Proofpoint-ORIG-GUID: 4kEfqwKC4dqkGHN9o3kweN2rshe0Am8W
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA1NCBTYWx0ZWRfX6vOEL+m9WtOM
 mS/XUt066i6T34KnbveTiiPtJjU6r/rV9N5+ejby1Wlr+HKi3DP2ZQB2nx96tx76HCg+wWvz5HB
 EoMJY3LxJocPRjInUjOJV5oe/zT9JKM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA1NCBTYWx0ZWRfXzwbmI13Dr4Q4
 o48m+22bVfaOn7jLFGrxiP4vCOsnd+VBYGjEzG3jFosopfD+KMLGrHiLw+rTmyoSt4KY59WWy07
 SwPM7/Z+melC3j1Zsm3+6u6nqeOlD6L/p5juK18NNyd6YqUNaLvNOnMUVriZ7AahxC2Y0gYREOn
 rNuEbUX/yrk8C4xH4DIzdBPYEL3bUTtMBXWZS736CFLts6SsiHS8CeWcwkiEJIJ5OrMEgQt/Rce
 c/dWT+BO7c5r3/zLWrgZoT9JFcxIQ9q8JUAmiy1VhV/YcOAXrsIdWtycGiye2nfWcp/3oB3i/BH
 cL2fldTtDurvlp1Mx1GvEiIkZXJZj9srMDdofBjt1tCLWbrZXDjr7q4G7VuQFFjGkTW0PFTRNZF
 L8QFShtQ69841HKTcptfPUvnEVI8YbIX9wFSUAemG7GvjbaP66GAnn/FBhdhoa5WsfC+WDFXkfB
 WuvBclYyWmUm1qRACfw==
X-Authority-Analysis: v=2.4 cv=PMGaavqC c=1 sm=1 tr=0 ts=6ace33cf cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=MZlWtUBn__QG1sgtjpgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 spamscore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610130054

Hi Rafael,

On 13-Oct-26 13:58, Rafael J. Wysocki (Intel) wrote:
> On Tue, Oct 13, 2026 at 11:33 AM <johannes.goede@oss.qualcomm.com> wrote:
>>
>> Hi,
>>
>> On 13-Oct-26 00:46, Ali Ahmet Memiş wrote:
>>> Since commit d33e89d12295 ("thermal: core: Suspend thermal zones later
>>> and resume them earlier"), thermal zones are resumed from dpm_complete(),
>>> before the PM_POST_SUSPEND notifier that re-reads _BIX and _BST. On
>>> ThinkPad P1 Gen2 and P53, INT3403 _TMP calls \GTST which switches the EC
>>> page selector (HIID) without taking the BATM mutex used by the battery
>>> methods. ACPICA releases the interpreter lock around EC accesses
>>
>> I'm wondering if this "ACPICA releases the interpreter lock around EC
>> accesses" is not the real problem here.
> 
> Yes, it most likely is.
> 
> What actually happens is that ACPICA drops the interpreter lock and
> the namespace lock in several cases listed in the
> acpi_ex_exit_interpreter() documentation comment, the majority of
> which involve having to wait.
> 
> The bottom line though is that the interpreter and namespace locks
> cannot be expected to be held throughout AML evaluation because it is
> not known in advance if any of the cases in question will appear.
> 
>> Recently I've learned / heard
>> from a trusted source that Windows ACPI subsystem is very much single
>> threaded. So it is nice that ACPI has these mutexes and other stuff
>> to support multi-threading but as long as Windows ACPI interpreter is
>> not multi-threaded I think we may need to consider to copy Windows
>> behavior.
> 
> This is also my conclusion, at least to some extent.
> 
> The problem with it though is that in some cases parallel evaluation
> of AML is actually useful.  For example, say two PCI devices are
> powered up at the same time and AML waits for each of them.  The async
> suspend/resume aligns those waits to take place simultaneously instead
> of serializing them which allows some time to be saved.
> 
>> So maybe the EC accesses should keep the interpreter lock locked during
>> EC accesses.
> 
> The problem here is that it is hard to say in advance whether or not
> _BIX or _BST will access the EC and whether or not that will clash
> with _TMP evaluation for a seemingly unrelated thermal zone.
> 
>> And even go further and maybe we need to introduce a big-acpi-lock,
>> which I guess the interpreter lock more or less is? And just serialize
>> all ACPI accesses since most ACPI tables clearly do not handle
>> multi-threaded access to ACPI methods well ?
> 
> I would be inclined to do so except for device power management
> methods, that is _ON, _OFF, and _PSx, that are not the problematic
> ones, at least as far as I know.

That sounds like a reasonable compromise which should fix both
this case as well as help with bko221065 .

>> Another example of multi-threaded ACPI calls causing problems is:
>>
>> https://bugzilla.kernel.org/show_bug.cgi?id=221065
> 
> Right.
> 
> So I guess the idea would be to add locking to acpi_evaluate_object()?

Yes that seems like a nice single point of entry to do this where
all the various helpers eventually end up.

> An alternative might be to introduce an "exclusive" variant of
> acpi_evaluate_object() with built-in locking and use it in the cases
> that are known-problematic.

So here we have _TMP and _BIX / _BST and in bko221065 we have
a bunch of again batteyr methods + UCSI racing. I'm afraid if
we add something like acpi_evaluate_object_exclusive() we'll end
up eventually using that almost everywhere.

Maybe do things the other way around and serializing all the calls
by default and adding an acpi_evaluate_object_unlocked() to be used
in cases where we want the speedup of multi-threading like
the _ON, _OFF and _PSx you mentioned above ?

Regards,

Hans



