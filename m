Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793370416;
	b=PMPO3WFLXboxWD0lv7ah4Idn0Lged5innHfb11GC/luQpjcZtlQ+Ks2aoxlXze23II3W
	 72mxhY78LYFr7VG8rhQeGe9jWFvtR4T2R6qg3CCGz3H1A75PyIaNeunKTbcDYBoZLILpZ
	 UOH1rFiD9dQt8OH5BcgNqbfbT5E+vaM7pl38at1ufP9MCFWT3zX82JSjuDxdOnjFHPnrE
	 SMJebrthn1C7FwVr4PYUOgkzIYWxJuDzbvOoTSk4+jpKZfCfcKpHkhT/isQKQcSuZm2o8
	 Fd5s86IVfOEq85JuG1SDrP/atN4sf+6Ora1yTYXKuGNZWqSNfaqfCRMi/T96b7o7MdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793370416;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=0eWLrpt3G7XvH05+iqFKnT92AV6rz1MCjuRdpdKGeUQ=;
	b=sod56q9BhTt5w3O8mqrY6D0BS6rFLyRaM+wfLgFWIB4HLrruPj8RWKG+eCDOUsWDZx8d
	 uvIXtQqUhs3UkZ8Vr9MT/CKIIWhAtWt2UMRXvQs3Xqcqgr1+VH3OgGlRc73ILiOBi1ILx
	 NOpj4fLNOKa4Hw7owH81Gfhty1YCclPoTSLMpOBXlOknOJ4dVLtm9Aq30V9BG4l9nwkHW
	 QK4tx5AdR7d5VQbCI38SFknenowFpcDngFvYmt6985sRJqV+dGUUXG+R7CEz/dTk8gkmd
	 6W4vQH3Ig4Cj4GU9EpLzua/yU5GjpHMonQrZyRLLsiF2mMijLozJvgZJIVO1Pw7D31Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=DCeeaCFI;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=g3k47dtl;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD5D606A31F
	for <linux-pm@vger.kernel.org>; Fri, 30 Oct 2026 14:26:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ADD5D606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=DCeeaCFI;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=g3k47dtl
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69UDn5Ob3479681
	for <linux-pm@vger.kernel.org>; Fri, 30 Oct 2026 14:26:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0eWLrpt3G7XvH05+iqFKnT92AV6rz1MCjuRdpdKGeUQ=; b=DCeeaCFIyfTgBGCE
	VrKDaL/o5zAiqilZKMzWNepzRLy0Ntx+36ld4Y6UcQxW30rZQ3tZqqTl3wIkRrzl
	bS7Mw2TT7cjBqqeswY7Tum/ERLdJ8i+J3ze2hwBqIi9f63hBbFe/yO5XdjupoLtR
	+YCNPoI+MspCwd4yDgkmfSGky9mkRlRdx43BRlGlM1Mobv5ueMVwp9l7iZbpwPCl
	6xyzA1vpY0BKLjMcZx7XKJ8HAOc0qHHUjhlr9jiAVK+v59LgRi3TX+ShE0zQWKHs
	x1kpLW9XddjkYRrzAK1bG/1cWi9Dt48JJek27KzKa5jE7S3cyqZZwVYACsjVRFTT
	lGBvGg==
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com [74.125.224.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6qkenj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 30 Oct 2026 14:26:53 +0000 (GMT)
Received: by mail-yx1-f72.google.com with SMTP id 956f58d0204a3-67994010b21so1341325d50.3
        for <linux-pm@vger.kernel.org>; Fri, 30 Oct 2026 07:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793370413; x=1793975213; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0eWLrpt3G7XvH05+iqFKnT92AV6rz1MCjuRdpdKGeUQ=;
        b=g3k47dtlfncoocsbmYrCW4WPWowWq8VxUiFTRSZw0NVrOkC+BwJJlNee/JecSL0lhR
         GG9gWxelLH1J/glDJjH/cU1daS8GIzkzplExVO8lkjJmHrO9v56YdtlESNOKQgNolxTt
         D7miPoDpDDV60dXdLsIDXie2HcvswKhCrSYGqlzRA0syCWFJteu18JZzH3qL0ocvuHUE
         HQojgAeVPhK2elxRl+cqvuYwRtzdtft84PA1irvMebZtsnypZu89rnpiz8LB0gwES+Z1
         6/lCue0E8y+LJkJ+FltlkVaPN9HwvmjTcNkARflJnx6aIAHWljJxjh+C6RR/iJmGei6t
         jnIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793370413; x=1793975213;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0eWLrpt3G7XvH05+iqFKnT92AV6rz1MCjuRdpdKGeUQ=;
        b=HBbaKTCCKi6HLETor2/D2Vbkool9+Dsm2ItYFemoNj0jKWCPHFzbmzEO/3ghMMGQi0
         AywhG70XhvBwC+lkxcfJ8yZ+y8bq5JNKlStr1HGtD9IY3CgGOYBodX2I7MS6Ivq8iwNq
         hloqixhxRbhHkoglZwiSya9criXKvj215tlGntIG4FwCgeT5mOSAfYzI85WoATKM2Gwm
         3v9wxTU7A942WUCN9U58TtPwvD2Un+mv0xk0U/OcaJ+QCQUqILbsADXOJUswU7fKqHAq
         vTd6DhLXzRoseccbWmoWcyf6ZcZTyr2QKFW6qY/NkLtK6mIh677DsFp98dueVFlMSPA+
         KAXA==
X-Forwarded-Encrypted: i=1; AKwUvBye88yu2QuIB71xi2m1G4Ji8h/H89kuakeZ1if0rzW0T28/sXIZAHXQcVk4caUsLhOfK5Id1SCFQw==@vger.kernel.org
X-Gm-Message-State: AFq9FYIu2oZYTBz1Aib7XK0vwz+g5pR+5Wny8mck8F9hfyyFtCp1MIAT
	rbPsbmJ2qY9OQ42yGs47dtGDnBhdCoPbsQoczl7rO/jeW34WLIedp0sGB0tmLhvrbEwjklAFRT2
	Xtj0TKwWmkYR06svWPqzb68agJ1TjlzGHkjKLj70MLTvCCWztv+Akb/xpc94VjVi9DSIW5g==
X-Gm-Gg: AYBFou2CJ5sefvSwS202bY2s1/qrHnTLWXPLH9wTLPI9J0Zf3nCSpXqjlefXHdu2Vdf
	AKioRUYE2yqJIpIshi7guWszEPjURZd+ULnRcxJwCRQ4mfoRWmjdGSxromSYkCCTMcuWjnsdrEj
	sbTMPH4Wda4erfYBIWvu6LUwVH0uZmw49Cw456P2ksJEcORPydyOVbM6rrydJG7lCy/y2wy3L0Q
	PTE5rhvNJOj2ENZ4eePZ1RXHUL1AJAm8TVTfANR15m771BkqlG+Dd2vZ+ipCqG4VZpBrCYYOBVA
	leAdAT0oO1FbtVppG7f1TGszXnHoIf7UVLd8tKQQ1iaU53nYt6dtMVe/eyxBdgx0xeHStdqLzg2
	LHLCTwjHlUpgyS1XzrchmFWTEIqWPDSNoogXdvplLhaQDPbaR+bQ6QQig4NlsmoTuZFgWpepPM+
	Dy3pEWvws8pezJEYPJ/NYvrUrHT0bTjIPIob4=
X-Received: by 2002:a53:b193:0:b0:675:6228:2fdd with SMTP id 956f58d0204a3-67ba4c90dddmr1391845d50.4.1793370413228;
        Fri, 30 Oct 2026 07:26:53 -0700 (PDT)
X-Received: by 2002:a53:b193:0:b0:675:6228:2fdd with SMTP id 956f58d0204a3-67ba4c90dddmr1391821d50.4.1793370412652;
        Fri, 30 Oct 2026 07:26:52 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:7fbe:151a:486d:a2cc? ([2a05:6e02:1041:c10:7fbe:151a:486d:a2cc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b8c6e9sm3456455f8f.43.2026.10.30.07.26.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Oct 2026 07:26:39 -0700 (PDT)
Message-ID: <6b1a831d-299e-43fd-83cb-74a64f844d03@oss.qualcomm.com>
Date: Fri, 30 Oct 2026 15:26:36 +0100
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
Subject: Re: [PATCH v4 1/6] powercap: Add generic zone hierarchy creation
 helpers
To: Lukasz Luba <lukasz.luba@arm.com>, rafael@kernel.org
Cc: Daniel Lezcano <daniel.lezcano@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>, Shuah Khan <shuah@kernel.org>,
        Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kselftest@vger.kernel.org
References: <cover.1793288783.git.daniel.lezcano@oss.qualcomm.com>
 <78abd10309b51ffdc3304997376d58e55b29487c.1793288783.git.daniel.lezcano@oss.qualcomm.com>
 <dc1d68fc-e4fd-4cce-9444-acc8031d5ba0@arm.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <dc1d68fc-e4fd-4cce-9444-acc8031d5ba0@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: iqN_ErtbF0gnWO_X-yaKXT7PzsE9CbFm
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA1NyBTYWx0ZWRfXwBAq6cMBNMIG
 Ydu0IRSH2OF48CkFUtq870y2B/Ysv+uM02EF+USOGX1iwvupkCbmCXq9uezoScbbdyUjg7Uuv1Y
 5BGSB9RXi9a+hqdmHtH7ALwYxit4ns8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA1NyBTYWx0ZWRfX5LR6x8islIz4
 JA7ssYSrjESrDwhGK3Yd00wmCbCX3l5taqirq2LqLH6ZBnTK66An1RPnMKiAUKG5s05T0npmHxA
 g06jE2GVozPFgW1rOTurrxk2jbefhtRTfakAlcNL2rpPPEZYQJ36sjLGEdFpUX6qyO+NZZjSWkL
 PjbEYrWL2gEd8j6z/ln8xTyj5fMF2LNsUVg9LRm8ajel/Vmnk4aVoI0r8ljY1jVJeE/s26hwl9w
 Kh9J6Ug7uZQ9uliXP6Kd1i7QWLGH4rfaRFIANLjQ2scU681PcTVvKXzeFx977HClqMDsYvnWLcX
 qtHSvu52aIMdK77QDfDOvA3QBjyoCP/mFqUgMWAttO7exWwtzLUw6O2dgL2VM4l4Tq5I7bTyB87
 KR3eSaqg3eLu3RuXz//+eCUuaDBx2SkdO+XcSMihGo7gqBvVTUAKjPgJwoRaPolBf1yS+ZsCnlU
 4kEusJ1gioGIWtSZlzA==
X-Proofpoint-ORIG-GUID: iqN_ErtbF0gnWO_X-yaKXT7PzsE9CbFm
X-Authority-Analysis: v=2.4 cv=TpVzFzXh c=1 sm=1 tr=0 ts=6ae4a92d cx=c_pps
 a=VEzVgl358Dq0xwHDEbsOzA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=bC-a23v3AAAA:8
 a=EUspDBNiAAAA:8 a=7CQSdrXTAAAA:8 a=jVzW49EHFVz-FHsPnZwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uujmmnXaIg8lM0-o0HFK:22 a=FO4_E8m0qiDe52t0p3_H:22
 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 adultscore=0 suspectscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300057


Hi Lukasz,

thanks for the review


On 10/30/26 15:02, Lukasz Luba wrote:
> 
> 
> On 10/29/26 16:56, Daniel Lezcano wrote:
>> Powercap controllers may need to create several powercap zones organized
>> as a hierarchy. At present, each controller has to open-code the
>> hierarchy traversal, parent lookup, error rollback and reverse-order
>> destruction.
>>
>> Introduce struct powercap_hierarchy to describe a powercap
>> hierarchy. Each node contains its name, parent, backend-specific data
>> and the powercap zone created for it.
> 
> [snip]
> 
>>
>> Cc: Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>
>> Link: https://patch.msgid.link/20260806110159.69690-2- 
>> daniel.lezcano@oss.qualcomm.com
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
>> ---
>> Changes in v4 (since v3):
>> - Rebase on v7.3; no code or commit-description changes.
>>
>> Changes in v3 (since v2):
>> - Rebase on v7.3-rc7.
>> - Add a static initializer and clarify hierarchy ownership and locking.
>> - Check for existing zones and validate names and parent ordering before
>>    creation; use zone for the runtime pointer member.
>> - Allow NULL callback results to skip branches; keep errors fatal.
>> - Use explicit locking and a signed reverse-loop index.
>> - Explain the controller callbacks, their arguments and their 
>> relationship
>>    to zone operations; update the description.
>>
>>   drivers/powercap/powercap_sys.c | 204 +++++++++++++++++++++++++++++++
>>   include/linux/powercap.h        | 205 ++++++++++++++++++++++++++++++++
>>   2 files changed, 409 insertions(+)
>>
> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

