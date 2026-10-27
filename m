Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793117890;
	b=JqJK+obWshcDziW2H8V7G/zImHILxSTPwySK61Jd56o8vJYUVj0PfC4SF99ncB2pb8J/
	 SrRe0lww03cTg6mKthJf3dNoyVFy0M3sSFi+zqil9wPikXeypAI1P/ICiaJtilTpX5WDI
	 ldrzwIa2jEGJaZPo6AnrL3/M+U42jKgkL4PRxKDGZkZp5I5QHs5yQIyhbRv/1ean/dWXY
	 TQpf/la2JM47Y8TB300LT8GFc2vULpjcAK+XIrLgIs/Ko7KZrZTBW5oFSTZAu3+OIlZja
	 B1KtZ1ZewdhaZZ1zXMEdz6aDzd9tsLUgtBb6RNNrcyWGFIUNDBf2hiCDthi9QvmQucQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793117890;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=IGDTuUyORqQ9ZtkZ7BRn3HYpiHLzxyIKFVLh6zS3w3s=;
	b=kRz3fD4RVE7j+brmn91IkmA/7s61u93N0U/BBRe+ScA3mZmERfBPc8YtpSMjVOMNKUFj
	 or+ereyIhBjhgz4Fp0BwtMY8Jq9jwxFr8b523lOFEzWEOGBcNCEg4fcHnejH0/SvEPH3j
	 WBBZwD6re0jzfBkIaFBWgCCoH/qPM7VqCRhlvwfJrjyusx6YCRTbBhGYIkeiQHf0WgIlY
	 fVaz2Xr1gycwGbPLk9VlsduxSObQ+CPdQ8aCiVbdXnrL6e65dZwYc5bFJdTqevDi397QD
	 OBgqDplHnqLNTG5NLgwqCSY6Zlq60XaB5hgELf+fGAWOD6MpX/ys7eNhDvZm6oY9jNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mkLDoAVu;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=IlLzR2In;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECCC7606A31E
	for <linux-pm@vger.kernel.org>; Tue, 27 Oct 2026 16:18:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ECCC7606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mkLDoAVu;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=IlLzR2In
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69RFKw3G3655228
	for <linux-pm@vger.kernel.org>; Tue, 27 Oct 2026 16:18:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IGDTuUyORqQ9ZtkZ7BRn3HYpiHLzxyIKFVLh6zS3w3s=; b=mkLDoAVufykMfXU9
	b0wNwshi/OOFS1fGs2PUhkkdJTgKHecVqhmTkGvP5r4qVsM+99YVbuqYp42UzZBm
	2TI4maBCJKRfRPZLpK4EHZrA4GQCiz0sUK0TDussji1lhYQpdcZ+ik3hIJgvxnM0
	hZWRaYnTqGItcNiX0Kw7f9A/6jtt8D68cwLTH4CWc1agJ6uhZHLwqnGJA7wS3xzb
	vyELDZ4MGuWT4alpDXCC/oZm6s0T+j2wvi/ooq5od9IlQ9oV1WXkYa8UMu1FHjnR
	88tcaYIVwMLXmirQuw4xV27zS3jA/EgftwetVNFFnLWWu1MMo7IZQzPRqk+ELF69
	G8yO2w==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjh91bge6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 27 Oct 2026 16:18:08 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93caf7856ffso1027618985a.3
        for <linux-pm@vger.kernel.org>; Tue, 27 Oct 2026 09:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793117887; x=1793722687; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IGDTuUyORqQ9ZtkZ7BRn3HYpiHLzxyIKFVLh6zS3w3s=;
        b=IlLzR2InH2CS98YhZBCaotjhyEygpybW1CmPXgAkPnGDOyPDXOV3gh0D+loR79QpFg
         k0RNJHqPL35aU+JSC13lBbScU3nKaSVlIiq4h0WxDuJT0bAiQztzlTVd/Z+l32W5Em3O
         dxtqhznm4Ydsf8oLJitYAVWC7eeS9HGuU+WGJtGL4XuHvlgKMaNxuPPKvJ5f5Q8Zbjh5
         E21UoR/9IoYX8du5rXjH7b1bSrDqDYpTZLA6Gl6kUvNtYrd4CIr1taUCGxvCLbb9fVu/
         fS1Ue5Nw9IbMR/0vQS9LHKoEwf++0jm4PA8qlntLZV1rm0n9iClTMG5lGWeIuLi0poLT
         0+Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793117887; x=1793722687;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IGDTuUyORqQ9ZtkZ7BRn3HYpiHLzxyIKFVLh6zS3w3s=;
        b=H12xWzZOpyQsvkpb311Wc4KbWtMRNzh9TrtD9OqlxuheXFwf30IHe9/FVn6LZTVnFF
         ZMPGkSxfzumwW7+2jCljnohqmkyeJ6+5njA88h3OVsGc3aa5ker0T5kz++Zl3y+2/Xrj
         YKAbeGzgYga6FUD44amyeleorEau9LmoNAUaH+iYEtu11FpXRoG/eNNfHtU6GvSY4TdS
         Ohve7EzywdVpnysl92zQDXrpolxaGvWOVi1rGqoi4WM3ahrZUPHCoN6P0cVItTNP8ovA
         lEH5IQJSAcLvHu8HfEe2emy/NaKrktkDUgkcCWo3eGrjqVyAyHek0bqbJ27CtZdYsYC0
         Aa6Q==
X-Forwarded-Encrypted: i=1; AKwUvBy7TFKmyOcuPDQivf+4KsXqCB7tIqf4PlVLXmn+uAYznN931JBJ7CQNCRkASEtF/JCpiGLQogVoTA==@vger.kernel.org
X-Gm-Message-State: AFq9FYLo7Y2mQDO2YVP+V//YPu7XHGXNSeYcFIWZgtXvpYuozYMUjyrB
	reGEHkBHbMw5CQLxr68EsS2/pmYjNJO07f6H56HmDC+wfGmaxmo0Rpu5iE3EG/Dnp0pw2lcJdTa
	jCb7Y0vSBDWYQ35TxFUUE4hn79T7Oubsv+ptojzT/l1yISUExrn0fXYuFMiTZbw==
X-Gm-Gg: AYBFou0xvDRxSu2ds6H9l1RxOZ/enmUMAgSsWW4S6/NtjIJ16rdAIThE1Ke3CGw12+m
	4j3tzWHRUnUtmA5WdBwcW/bSi4b+lM2zH7Yx3JeWayhbtTZOkJvvpliOR5mPwDnptNNbY/gGSMQ
	nMEeCY0pXvxCSmAWHJu0jKPqjToL3ncx31XDhu5XIBaseEU1O8FQhhAtvrhIdhGZuUq1RFmpuR4
	hAdIwVnd3aozeurFQ4IGqlAWq5VDml1ix+gOAUVwA47bJgnWQQ+a3+w7WCV46xzl5zFj7Cz30Gu
	pvCUcm4/+F5D28ZmrwrlY3fde734BrmLJAt/gnvOHsgO/lnIWwYTMBO1ROs+yDupfje7SaIuBwP
	wNpVtnpqIRX8FiuVLZ1Lo/BSHQOOVzNTNaMVSw1hpGmFv0pk2OWvBSPhnoCWAxA==
X-Received: by 2002:a05:620a:2b91:b0:93f:6e05:22eb with SMTP id af79cd13be357-940ef8f9253mr1634334785a.48.1793117886949;
        Tue, 27 Oct 2026 09:18:06 -0700 (PDT)
X-Received: by 2002:a05:620a:2b91:b0:93f:6e05:22eb with SMTP id af79cd13be357-940ef8f9253mr1634328585a.48.1793117886452;
        Tue, 27 Oct 2026 09:18:06 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:7d20:e20f:a77f:4ef7? ([2a05:6e02:1041:c10:7d20:e20f:a77f:4ef7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ecd8ddasm25927477f8f.48.2026.10.27.09.18.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2026 09:18:05 -0700 (PDT)
Message-ID: <8e53d1a3-fc96-4d07-8be7-74f383ed3618@oss.qualcomm.com>
Date: Tue, 27 Oct 2026 17:18:04 +0100
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
Subject: Re: [PATCH v3 2/6] selftests/powercap: Add powercap hierarchy
 creation API tests
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>, Shuah Khan <shuah@kernel.org>,
        Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kselftest@vger.kernel.org,
        Thomas Huth <thuth@redhat.com>, Vasily Gorbik <gor@linux.ibm.com>
References: <cover.1792504834.git.daniel.lezcano@oss.qualcomm.com>
 <83799bf79e85e9e2ab77140e632f11d96b17a04f.1792504834.git.daniel.lezcano@oss.qualcomm.com>
 <CAJZ5v0gSLOP4KN3bNB425SaYOLcpJ1c3t5isYEQAdvxqQR0sVQ@mail.gmail.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <CAJZ5v0gSLOP4KN3bNB425SaYOLcpJ1c3t5isYEQAdvxqQR0sVQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: _00ldwDPzpVbB0gxFWRAnT0KRc2klKHH
X-Proofpoint-GUID: _00ldwDPzpVbB0gxFWRAnT0KRc2klKHH
X-Authority-Analysis: v=2.4 cv=TuxzFzXh c=1 sm=1 tr=0 ts=6ae0cec0 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=bC-a23v3AAAA:8
 a=EUspDBNiAAAA:8 a=c92rfblmAAAA:8 a=82gYmaJqspjqQrwE4UoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=FO4_E8m0qiDe52t0p3_H:22
 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA2NCBTYWx0ZWRfX6yF+d7HtREB/
 9P0w71dzQ/UkcNWuElm+jaNK6Qga8QquGLDmi+GfDtAOZSuhEWVpYKj9WWKvdGIXa/akfYe8deK
 UlBeaUF/urNtT8C7moMiOV3MYwyWqDpfEhDzko1D4Kqorabl/njzjd6j4cIbLUTAQJdIZdCH8jz
 Xd23Q1fEgVnXQ2xQrJaizrEnzjeNKrxMUusRzOjwBIDPEEUKIIOQd83BmKDH3Na5Q9CBMyCXOlt
 T+Z9xEE79b7sJB1HMGeNLSE33uXsqMXf2oAOsrnX/NlD6xvlXUgL/guj3hT1li4+1BXA+RR3LHs
 wkQr7HFMeyAkiebVlrQV+XZBywIy20RPtsFOOEh4JDmhpU7ibxMyCcH45iQHBdH04N5PdDpAekl
 yOD2Rb91QqraYdC6CmKTdevJeDnznWkwMDv9JURmw3E/P++9D1JaHdY9nhx3FLSbJsnveB8F3u6
 y8RUCNevC6D7zmhTQRw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA2NCBTYWx0ZWRfXyI+Tc3D671cD
 yskifR15imzz/rbzuitFtHawM6qbCluhp8KhGr5NnVwhm+fTS6KxVoHUQ4lY+YNyGPgC27IshRd
 gAWVpfIXqw67ajx1NLXNngITkaGLKdE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 spamscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270064

On 10/27/26 17:10, Rafael J. Wysocki (Intel) wrote:
> On Tue, Oct 20, 2026 at 4:18 PM Daniel Lezcano
> <daniel.lezcano@oss.qualcomm.com> wrote:
>>
>> The powercap hierarchy API introduces generic helpers to duplicate,
>> instantiate and destroy a complete powercap hierarchy from a static
>> description.
>>
>> Add a kselftest exercising this API. The test builds a synthetic
>> powercap hierarchy composed of a package, three CPU clusters and twelve
>> CPUs, registers it as a powercap control type and checks the zone count
>> and selected sysfs attribute values. It also checks that the controller
>> directory disappears when the module is unloaded.
>>
>> Exercise direct static creation, duplication, skipped clusters and their
>> descendants, reuse after partial destruction, and repeated creation
>> returning -EBUSY without replacing existing zone pointers. Callback
>> checks verify the controller, name and backend-private data supplied by
>> the helpers.
>>
>> The test consists of:
>>
>> * a kernel module implementing a synthetic powercap hierarchy and
>>    dummy callbacks;
>> * a userspace kselftest script that loads the module, checks 16 zones
>>    and their power and constraint attributes, unloads the module with an
>>    attribute descriptor open, and checks controller removal.
>>
>> Use powercap-owned zone allocations so registration failures are cleaned
>> up by the core. Build generated module files in the selftest output
>> directory and extend the common clean target with Kbuild module cleanup.
>>
>> This provides a regression test for the powercap hierarchy helpers and
>> their integration with the powercap core.
>>
>> Cc: Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>
>> Link: https://patch.msgid.link/20260806110159.69690-3-daniel.lezcano@oss.qualcomm.com
>> Assisted-by: LLM
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
> 
> Sashiko is complaining about this one now:
> 
> https://sashiko.dev/#/patchset/cover.1792504834.git.daniel.lezcano%40oss.qualcomm.com

Thanks, I'll have a look

