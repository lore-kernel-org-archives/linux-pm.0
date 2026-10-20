Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792468027;
	b=VdGfKb+PMO5+jsAFcV9vgacIxk0Qi3b3OJia3hLZCKj2WiBog1TsySAWdipbTxZEw0rq
	 eC+yDo4tQIKc1NdVCiuDWFzsotZUt709HgPrVuWUix+sogvSrVKTCwiqRIsNnIdacJ2OA
	 IBS/y2/FFsAcN7s8ROPfe0vxZxQfH+fGBlbzEEYsYGHAjwRz+Mc0nWLObNx3LP0Vt5Lmr
	 IX4uHMdFZNWB0D5s7bD85FhpuViyhPaQGMaVnCV9ZCwXrIjs9AE2dARbPfw6a8qIwzxTG
	 Gq/f/nm4Uh9pCUMuxjWi1+RVp0CP8CDlNfr3gfK6Z8kR85Tb8pcpfzlg+BomEqD/8Kg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792468027;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=I8KcGkKJc5O5cQ+cPv0hwt4+vT8X5Kf/M9p0U3SJiPg=;
	b=VLIbHeOOB8KAQEwGdrUKB3Gf2Rtzxec+Hfn7esrQC7F4dYVKVxfzOKplzOkEfo7XhFhG
	 jU+WWAQDVHZ194wCG3vjIAGteLrz5XPVd5Hxf/ON9C6SEwWKW0HVFh1ivrTw9a90L2qGJ
	 XGHNyX9dtpeuhtt/THdiY0gHAfNQlFTuKa5KLUGMgRfboOSH7FPtMU2KuPdYukjPGLcjs
	 kRIDcUOYSh1WHUQHY5tDxVF4p/UJou4t7hLjw3yeSQy2nrsuNgxcP8t+iemwIL9aFoh+h
	 REZ9jA+JMPvRrnms+giRemMHpD5QFYqjdKE5GVnfMriKsaPshaSFJFOGQUzsiQKLYNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hZtQ0Ij9;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=aev5tig+;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347FC606A31B
	for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2026 03:47:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 347FC606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hZtQ0Ij9;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=aev5tig+
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69K0t7Ft3806851
	for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2026 03:47:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	I8KcGkKJc5O5cQ+cPv0hwt4+vT8X5Kf/M9p0U3SJiPg=; b=hZtQ0Ij9FPMQ+58X
	NYucubZW5beltibOfA2ge7ZfiBti0b2HSaGKzHAuOncNw3DmARjiKKlw2unaAQlY
	n0QJ6U3HBMPkYp7OV85GvYQ2Eln8DQx01mEVuRd8qAgp3Fj2MbUsuEqLLVBq16i3
	bMKkd9lh8ftq+1u8h7MTnunt3O47+c9hYxtgO5KH5TsVD7b8GBeOb4oqPrW/7FPm
	ytGsGxA30eFB5n7XVJB3XF6KGY/TGJZx0L2saBr2je4GP6iQBZIAR4kcTnjZHnsk
	8rdHc3mvj9efDUt1zhYs9L6BEL3+QTwEVCOkurbeuaRoaOp2ggSIkDn+/8Jat6NG
	gWAuLA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdw5p8q8h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2026 03:47:06 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-39512608fb1so5465146a91.1
        for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 20:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792468025; x=1793072825; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I8KcGkKJc5O5cQ+cPv0hwt4+vT8X5Kf/M9p0U3SJiPg=;
        b=aev5tig+4eWgmnAGV7JFaryuh0Vz5GQGb+BFW2akFTABc3Otve80gf2CdblBUlAGJS
         dy+e23Z3jeHV2CEZji5jZ7RxEO5K3LnpejlWgH5QcoieKa4lExKzE+54nRUD8ORAJ36U
         VtR4jo/hS1lOtdYr7i+xfTHwSdPI49QvqAaDsN/AKj/bZTwPPJXRswFtALYxqfhZ1SBB
         beAfXvlSc7aS7mOOP+/cCUj6jmt+9VxFf8Dl+oGv0zZrGwWZw0mvFKssqTzWsjUjaVdd
         0tNakIrpLsGzNHKQICuOfj5KpxEV24bg3mWXdVuFQgm/WvHyn1vqeadzA1zKcE2pYwIs
         f+CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792468025; x=1793072825;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=I8KcGkKJc5O5cQ+cPv0hwt4+vT8X5Kf/M9p0U3SJiPg=;
        b=vg9i6xHlHox9qIdMU7PTH5i2uK3vtHd0OfECw7fIdvR9pXy6KWQnnPP9DSziOex3l5
         vsTzErKVT2wnZqAlwo5S+aFDGbu/YfvbNiZV64TFpIkmobi2Tkpw+G66oiz0zBbzKNb/
         bdSjKfnV9VGh4baj1DHrKM+Adz5lxqlFygZOPVrqCF/yyK+Gwxr53C1Xz3hw68gfHY14
         cuSEpUSTSvWZl0xo/XN0+m5woYj1KYL3io1BxpG2SS1fzYzrpW0FvPSQypcl4RKnlRk3
         9i8ftOiShrfuXX6hfY02AQf8ulqBUOzbujZa/hi+EKW30eiLgJds+duEcuwE0zXs/nrm
         Dp2A==
X-Gm-Message-State: AFq9FYKG6UFrZ3McbcHEPCkKu4jk39+dDOKNrbuv7BgAQX7JguCe1D+u
	koT6pvKFC5D8Q6LTLtKSOeCotgJocCSgbLpgb1EPrW30MfkF/iSOhPb34SP8Wtbk9QuAc3/2zaP
	USeyOfu3yG1Uvtmt0DYp9bHZJoMESwJCWakH0dJMOgS/K49Y67u/YbscpKHcqsg==
X-Gm-Gg: AYBFou0aW3hWyXa4lxtuWcYBvueA0EGf5iIByqxHjnWiXs0zVs1yJw4Xx2uY8qkFhLz
	+4KEgFKxXnBusVFJ7+qth5V+rkvuADGcvV8EOSgrjlDuC4GGWPSftBFUYtJtB/fIZ65Ci1pWsup
	iz6ojFL3flrXwDWyzEUVJKrtfJNAmuK9xtKL6CIA0dmboeiwYeaAWfNXlmVoPEiYTBpomCn2mjg
	aU+7CoubX9XXlw31g8h6G88woqlX1J0H0NaKP1rxs83aLkhOYTspzwuG7Cci+I+RO8liE5y9jQ/
	s8C/vQaSxxmZ46AJ9ZNKnm9TYlyW195UhIml/DtnXoVaECl1rKTEwPkgt20NC5zYmrGIhsIpPnT
	4JUByKy2ySvTfuDD51kW0JKkCVx7IHqo92grZE1LeMEV35s8exXVUtkmL9GiiJtyI9N40vA==
X-Received: by 2002:a17:90a:acf:b0:3ad:183f:5e3a with SMTP id 98e67ed59e1d1-3ad183f5f57mr3604819a91.4.1792468025298;
        Mon, 19 Oct 2026 20:47:05 -0700 (PDT)
X-Received: by 2002:a17:90a:acf:b0:3ad:183f:5e3a with SMTP id 98e67ed59e1d1-3ad183f5f57mr3604804a91.4.1792468024799;
        Mon, 19 Oct 2026 20:47:04 -0700 (PDT)
Received: from [10.133.33.81] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad5d4004efsm2113209a91.5.2026.10.19.20.47.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Oct 2026 20:47:04 -0700 (PDT)
Message-ID: <d2c3fa0a-348b-4015-b2c9-b97d8c7964c8@oss.qualcomm.com>
Date: Tue, 20 Oct 2026 11:47:00 +0800
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: longrun: fix typo in kernel-doc
To: Manuel Ebner <manuelebnerli@mailbox.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhongqiu.han@oss.qualcomm.com
References: <20261017071434.1250140-2-manuelebnerli@mailbox.org>
 <9c312de6-7c73-465f-93da-d7a75cf3be8c@oss.qualcomm.com>
 <c635054081da35e61ccc25cf356f6356ca8580ba.camel@mailbox.org>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <c635054081da35e61ccc25cf356f6356ca8580ba.camel@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: CxH2YBvI7pCrzJELcSemscZQLVDmyX3d
X-Authority-Analysis: v=2.4 cv=fb84WEQF c=1 sm=1 tr=0 ts=6ad6e43a cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=b3CbU_ItAAAA:8 a=EUspDBNiAAAA:8 a=C86PBj00trpwstLOT_sA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
 a=Rv2g8BkzVjQTVhhssdqe:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDAxNCBTYWx0ZWRfX87IWdU1YeMOu
 8dU4XpTCh09uJEOp3SAv0qMM2kRTHlqh6nl/BohoEqUCjEE4Dw2dk/vlJTXnegeZWH8bAAXfg1T
 n+byKbhpUe4Oc5muCMgW33d+Q7ObEQL06kO62wxTDcEgRwl2rxDpSZG7+7SUtEeC7IaAuzU6Kud
 cXmltAlFVQBwYGONrwwyHaOxFtS6NpEDL2899LAaM+kvQbHQnlZEk1hqVgojIT6ScMygxn8I3Zn
 rZi31+zdeGUU0/JancTeV0xX7QHR6XJCv25tbfUQXrXO+fkBpS+ysDmir72BMUhyf0VUZ9pbyUC
 6mod9oZc3wFP6//3cIbIba/EQIYen9GK8tCyFsweqXcwFP/7qpcTCcK6F5QmI7rkjxCG5HNYPI/
 hfc65av/9F/SuSYFB9lHyqyrhU5HRhR7+iTgTpswC6VVFybOpMmRV0+2O8V61DHjYHgO8LJ0s0+
 1Ap2aULi7UnKwatPfUw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDAxNCBTYWx0ZWRfX87ImWefL6kS5
 fFw59BlRMW1vVPbtd8jrCMpTCQqaNn0VXuA8itxQK+E5Zvodf+oeHwi/0JGHdaPycbYA1aOXi5R
 v0K/+sjifcfXlHbImHaGqOovLU7ynoU=
X-Proofpoint-ORIG-GUID: CxH2YBvI7pCrzJELcSemscZQLVDmyX3d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_01,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 phishscore=0 clxscore=1015 bulkscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610200014

On 10/19/2026 4:51 PM, Manuel Ebner wrote:
> On Mon, 2026-10-19 at 11:37 +0800, Zhongqiu Han wrote:
>> Hi Manuel,
>>
>> Thanks for the patch.
>>
>> On 10/17/2026 3:14 PM, Manuel Ebner wrote:
>>> Fix typo to fix:
>>>
>>>     $ ./scripts/kernel-doc -none drivers/cpufreq/longrun.c
>>>     Warning: drivers/cpufreq/longrun.c:126 expecting prototype for longrun_verify_poliy(). Prototype was for longrun_verify_policy() instead
>>
>> ./scripts/checkpatch.pl reports a warning which should be acceptable to
>> keep unwrapped as it is tool output.
>>
>> WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit
>> description?)
>> #9:
>>     Warning: drivers/cpufreq/longrun.c:126 expecting prototype for
>> longrun_verify_poliy(). Prototype was for longrun_verify_policy() instead
>>
>> total: 0 errors, 1 warnings, 8 lines checked
>>
>>
>>
>> Also, while reproducing this issue, I noticed another problem,
>>
>> ./scripts/kernel-doc -none drivers/cpufreq/longrun.c
>> Warning: drivers/cpufreq/longrun.c:21 This comment starts with '/**',
>> but isn't a kernel-doc comment. Refer to
>> Documentation/doc-guide/kernel-doc.rst
>>    * longrun_{low,high}_freq is needed for the conversion of cpufreq kHz
>>
>> It should use /* instead of /** and may be worth a separate patch.
> 
> Will do.

Thanks

> 
>> But
>> since this patch is only intended to fix the typo, the patch itself
>> looks fine to me.
>>
>>>
>>> Signed-off-by: Manuel Ebner <manuelebnerli@mailbox.org>
>>
>> Small nit: please consider to add the Fixes tag:
>> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> 
> Well, thats the init commit, should it still be added in
> future patches?
> Can pre-git history be referenced?

AFAIK, yes, the usual approach for pre-Git history is to use
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2"), the initial Git commit.
Many patches have used this Fixes tag, for example:

https://lore.kernel.org/all/?q=1da177e4c3f4

> 
>>
>> Reviewed-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
>>
> 
> Thanks
>   Manuel
> 
>> ...


-- 
Thx and BRs,
Zhongqiu Han
