Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F5B32ED4E
	for <linux-pm@vger.kernel.org>; Wed, 12 Aug 2026 15:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786547811; cv=none; b=AKWJ9DZvdi25IuGEqQi1Yd/Bf3VJ7tqosNl6KTuSjL8x0dg2ktF/kNbuBn1bd+Pg20dv9hWIEv8BoJaFwCdXPjTDzQo3BcdimkPjaqrP6U8YY/T9n8YBICQiC1KRoAZIA5Ki6kqR9sRL2rtTDh1UpKFqonxsLOgxIJNExbu+4fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786547811; c=relaxed/simple;
	bh=9W6jTODiEwMMpjyfu3Y1J9UfdW3XAtgJKIHOqLQXxmU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h87RdBbEXElN46k1LqSfRJVc1NweJLw4+CNEZBYv57I+TNMYhpDhMzYm2kNMWjRkVazBGEIbKfjP43SyNhzYbiU4zJTkBsXsPEOdw+uNq15O7AtJQerSrkxB3vvOhQek5TaovsVhE8RVx18gZfheCQCKT//+Ix6H9SZV5Ocp0Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SaVFfeWK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dH9zwpmh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SaVFfeWK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dH9zwpmh"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CDcscm3654851
	for <linux-pm@vger.kernel.org>; Wed, 12 Aug 2026 15:16:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ifTuVGfML8lqiyh0N50x4CLOuH15tOwPs7j2Q9aS60Q=; b=SaVFfeWKMQ0ZJ+hp
	3d3SyEn8SwRiMsGN/Dsmjt6v5WRGqg+PM0+FfZWrkCYi0Cj60PPmS+uci7O+qiG3
	DwI399NgfF904I3eIbde6O43oRu746zMHYNnBNAMtp+FCJuzda3piNYaVXWscAi9
	lj62R/aKpfU0bUgOob2hQZjOqUjvfQ0uRgJmHUTkcP1WqhyWphhHhRYy5O5h3Wv3
	yzzrGCRyXC7rOxvXPiawPp+mGzvnV0C2KCJ6vd6HyFm+Lnl3VgVaD0msfR4Z6JIL
	5yk1wh3l2zy5G8UicSKNNwAU97pAVfnoYKJBA9gScxuQZQe/CrwukzOXZlixXCkE
	lt9SYQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0pmysag0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 12 Aug 2026 15:16:49 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51c1a9764f0so11615761cf.1
        for <linux-pm@vger.kernel.org>; Wed, 12 Aug 2026 08:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786547809; x=1787152609; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ifTuVGfML8lqiyh0N50x4CLOuH15tOwPs7j2Q9aS60Q=;
        b=dH9zwpmhR5jgvQHtp8JfLcLSRvVNT7x3Dj3EZN+BToXDUILLkzo+kreYX+92UuHExw
         NTccj90+/DJ+GW9i2oY890LS4jQItjrb06N+Fs5c4grY62DKasqEa7CS3mR7M1+jTuqx
         dUp5TDAAYIoBhBpn6DLANGks9QCd/ok+gBzuz1aflKi8b0sjhxjpSkW+yp8mTmiyPivM
         XMseOY5kL/WKt05Hhy+DI7mb8gmmIyc/H3aE8WTWR5HBHWw296hza9y2Go5+6r/CPKcm
         qR6NOeEDbBJ+maxUKiEeVzg2V35XUrOTT7Y3WPVAJUX8wQrLWL/rctvLTQUIca1FnfTz
         qeoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786547809; x=1787152609;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ifTuVGfML8lqiyh0N50x4CLOuH15tOwPs7j2Q9aS60Q=;
        b=S6MAFTuKBzwZ0nuSvErTchPgHe+B2vqQsgcx6lP4RVLxmwVL0LDFaKTdY4PRMvnLqf
         z8k5xDJNvjZFFkDae7tAFn4D/PNzltC9JktuPxI2C2zNPX5sCQ2mAlqbg3m/SacrDTEX
         sF0LL4IYTzLLUB1l1B/LDGUusV0uo8f5QUQtRC3RP/BFMPPtJnLijykkXAx76kREPDNf
         pjNfXNEkflIpdBy4zrloBFGVzCjlDsnjP+Lkanngqnl7cjYL7eSmJoQtacsT6HHqjUb9
         CJCgBYeFGo5C8mVfAyqfJrnSmZTtMP9huAe94oWT4VP69lx694bx6LJRImyJhw51sC94
         WGGQ==
X-Forwarded-Encrypted: i=1; AHgh+RoUG/cX2VhDssdqULnd0iqpN1NpajArT3MKs0D3Lngc35vmxRjEUFOaeiFfo3MponilxyaekPdHhw==@vger.kernel.org
X-Gm-Message-State: AOJu0YydBjOJf8X/MQbvr6mARRNHQACAtvadgGsxVAUGe9auGj/NfzZg
	Enmh33xuEzN9VwfdcGE/YBOKC1endvofZIgOHWRcKMzPGVBO3y9n0lKsoELSxEcQYP046FD1OFh
	ngyX+ODmKoydv+c9cDeEukN198/TGN/QaQfGfusOozOQw1pDs4Ro9jRXnfNeDBQ==
X-Gm-Gg: AR+sD13XYAG6MX181oJNEgUdDrYVEPCjlBg/kfJzVWHKvwfhMDkyTZLL8TWwy56f3x1
	rRIwFq0OBvFWIUZt7JQUJG7Hqg1svFSfbpYXtaHNN4shYZEfW1scnaOR3Gl463OugZORbJHgNMp
	b30qfl1+Hbx1V9j4o08p3e+RfwiiK4oCz8aEhZWlw5npJQj+UQIvKhJtKBfVv0bRO0YIIGw1r19
	ww+njMJbJnhrd4QY+Hx9CNMNgWO9KB5erVfVhaFIzV8TvxTl2Hnam/k5jHFFuPEy19IfSP+WhnU
	Rh5lxtPjZfdU9YopaGx1T8SCOYbsPRBGgdskue/IbIRNaheP25NpYsygyi52ZrgXNe/yNBMRe+4
	Hjo1A8Zs4cDK3g9zHYxEtmrfpkNM4XH0XuEXCH5MtiVnGYZt0ZcRew/f3muCg4D4=
X-Received: by 2002:a05:622a:84:b0:52b:4f1a:5ff0 with SMTP id d75a77b69052e-52d647186bemr52291671cf.19.1786547808574;
        Wed, 12 Aug 2026 08:16:48 -0700 (PDT)
X-Received: by 2002:a05:622a:84:b0:52b:4f1a:5ff0 with SMTP id d75a77b69052e-52d647186bemr52290701cf.19.1786547808081;
        Wed, 12 Aug 2026 08:16:48 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:d71e:6d83:9df1:6316? ([2a05:6e02:1041:c10:d71e:6d83:9df1:6316])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48150d5cb64sm8222704f8f.27.2026.08.12.08.16.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2026 08:16:47 -0700 (PDT)
Message-ID: <61e48b08-1a91-4d3a-8617-f25980038bfc@oss.qualcomm.com>
Date: Wed, 12 Aug 2026 17:16:46 +0200
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
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <CAJZ5v0g2G7L0hS64Eh14927P7g+eX_3KB_qUehBoa2OUfh+ung@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEyNCBTYWx0ZWRfX8Uk/7karN5/0
 6LgpQlX0ZxtlIxVKZ6MIakxpQL7MBnauQsUIPwe9/f2XJWhBAHl8bPdrf7/iBq8reycTi/D3g7v
 YpzZbASpar+VdQ0PBBTF4WY/muZ/HFA=
X-Proofpoint-ORIG-GUID: LT4y1BAOY88yVbPQ369jGRSmvJf4yWEn
X-Authority-Analysis: v=2.4 cv=C/fZDwP+ c=1 sm=1 tr=0 ts=6a7c8e61 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=D2xD6t6X85Nsw-2kTa8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: LT4y1BAOY88yVbPQ369jGRSmvJf4yWEn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEyNCBTYWx0ZWRfX/QI0AH0eJ6Cx
 LcnpKcLzIQQHs3etX/Qj4Qw08NcqhnFhkJnnzJ7ZvmhB1aP894KDXKaSJOwuvnlN/0/kcKRPIPr
 zZLt7GCSI3pq0H9XrSg6VycgLp64uftxbi37pKNlBpmk9uEg7TDcGTKMynSDKgb+fNapc5DpYkw
 0oowWqKY6/F4P1Orod1/K3KxYOIhgNIotW9Fvrz8YRKpVXjM8CiFdXxWSgMi7XFCPr7O/jW4PPG
 ub9bsFUNaCN9I4a0ocFL4QHX+T1H5SKsnwMtYTqy32yMpx8lY6KF5NVGrJ/LptTkHL1D0aTge+R
 TZ7a6FyUQwTEviLeGPmdpeyL2aZQ1c1yL/ceKaf+z0yIaaGalTmesEs3MHcnvOzHIhOhgI7sJBh
 oupctUn+XX9vHAt5XfTISBFj865wsbDHsn9dFvxeZ1G6Tc0MiiokVaO29nMDy/yhLjDzMCgElHk
 D72KT8M9R3WDufia4aw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 phishscore=0 spamscore=0 malwarescore=0
 adultscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120124

On 8/12/26 14:50, Rafael J. Wysocki (Intel) wrote:
> On Wed, Aug 12, 2026 at 2:43 PM Daniel Lezcano
> <daniel.lezcano@oss.qualcomm.com> wrote:
>>
>> On 8/12/26 13:28, Rafael J. Wysocki (Intel) wrote:
>>> Hi Daniel,
>>>
>>> On Tue, Aug 11, 2026 at 4:48 PM Daniel Lezcano
>>> <daniel.lezcano@oss.qualcomm.com> wrote:
>>>>
>>>>
>>>> Hi Rafael,
>>>>
>>>> please ignore this PR because there is a missing SoB.
>>>>
>>>> I'll fix it and meanwhile update the linux-next branch so it will fix
>>>> the build issue.
>>>
>>> Well, the build issue is still there in my thermal branch though.
>>>
>>> I've now remerged my linux-next branch to avoid exposing the thermal
>>> drivers merge I did previously and I'll wait for another PR from you.
>>> Worst-case I'll skip the thermal drivers material in my first 7.3-rc1
>>> thermal PR.
>> There are 3 fixes on top of the PR.
>>
>> One is obviously to be folded with the existing series as it is my fault
>> I forgot to add the file after fixing a conflict [1] which led to the
>> linux-next build failure.
>>
>> But two were reported by lkp [2][3]. May I take the opportunity to fold
>> them with the patches they fix and shall I keep them as is ?
>>
>> [1]
>> https://lore.kernel.org/all/20260811145427.3089426-1-daniel.lezcano@kernel.org/
>>
>> [2]
>> https://lore.kernel.org/all/20260811094935.2941313-1-daniel.lezcano@kernel.org/
>>
>> [3]
>> https://lore.kernel.org/all/20260811094747.2940616-1-daniel.lezcano@kernel.org/
> 
> At this point it's better to do additional fix commits on top of the
> previous material as it has all been exposed in my thermal branch for
> which there are no history rewrites.
> 
> Please send me a PR with all of the fixes on top of the current HEAD
> of my thermal branch.

Do you mean linux-pm/thermal ?
