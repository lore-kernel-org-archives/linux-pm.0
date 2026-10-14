Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2B74EC64D
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 10:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791972121; cv=none; b=dzrd8u3QAYlUzZWhPC3A1AjXCJumxnaXHnfB5WjD6ryjGdTjEu/p/5Ues3Ybvfp0oDDe3ibwbFvg+ZIUmiV6s56O0IRWGHuiAITIn2NWyY/9f0Kyaw64+zG3N7OMMWwkhfWGnLrRktZa9twG+gudbBFpgQV2xF5Wd2CcW+SbUDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791972121; c=relaxed/simple;
	bh=bxAABMcATBGCVbIdLI2E3IV2T/5FveIz1lB1kdv5BSI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=hFZ9csuPypKQwjWgpP2Bdg0JoMzmruU86OOoiHSY6Es1EzUirAjNlSOc8iJL+HrnIYsp4kCjmQAu0djCkpy5kBysOvev4QuH4GCnNtBoWkaZ/L5sOujzuDPKaxhi3+Y8cxqgBaS65xIdGvqbobz52yTBWulAKPOVWum4lJUpyUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XtRtTzbr; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=W/tnWRY8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XtRtTzbr";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="W/tnWRY8"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69E663fa3365337
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 10:01:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sPkOAvHjGguK+u1bhI+1A6KtcM2Hij2aa37XKD4T2YE=; b=XtRtTzbreLbENmD4
	w9nXdbO9+ui3nKl9oY0BLYee5c0YjQhis4AHR5mDZjszR844X7av0SCOJ0JiebSN
	cj2uDa9JoFT4XZEEI3q0mp8Zn6FJw2h4P3o+YIt8BKVj+S/6wlK7GC81Zw9kB17z
	2D3bc3zpMPhDXdHhWrtJeTX0ma16AzREevUBcPO+7YcnCOPfQkm2w6uMJostm/v/
	COTWRZbM0mdvs9XtLz/CjPEG6jPQ8IR0arPxTaOxX500uhNoCLm65ItV6aTe93n2
	Pjj133XIbfbRcX105R1GCek4kOAOCOeJcDGyrudOxjDQ/y+arROsXbpw2wOaBtjO
	tPxB5g==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com [209.85.221.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ha4621065-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 10:01:58 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-5da613f7588so4460882e0c.2
        for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 03:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791972118; x=1792576918; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sPkOAvHjGguK+u1bhI+1A6KtcM2Hij2aa37XKD4T2YE=;
        b=W/tnWRY8tdKuwCddu1XtkH6g/Qk1QDwBCYNxI5vLe4RymIg/P4HrGmJf0S9XomwU0g
         U2PAFMNpvBXR5UTO+0hHLFzpCHDr9yLY8Io6Yb9LAgn4UjCK1k52XW/57T9nA2q/wRie
         zil8qlCPNXwQImtmCj6P2E2SSvGLHkhsnNrmj/+ViVMHDDY7DuiiYT2zDX/swE0ywzvg
         dbb5I+4D8C411VMbmmXrmZDBapvOz+YdiqAQyA4pXvM244ypTQpEQfcJClx6nQggq85r
         BdzCPAovyyQ9oOCYylLEXby1vsY9/CIf3mTG/4ixhrI9RqPfox4lHXcYbRuCex2MsSXJ
         d/XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791972118; x=1792576918;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sPkOAvHjGguK+u1bhI+1A6KtcM2Hij2aa37XKD4T2YE=;
        b=yj5WjkZcrRvpjNwfKEVmM06B31kq1OmYVvNBuf8KzYAHPiFpHobbwh3p1ZQf5v7Cny
         YWptl0L0Vx7/d4MDGxl48yURfXjTcXZU5r4PA9x0OCLUwSCQunccSPgTEsXq51igoamR
         PzkpeE2R6m/EFKtqEaqA28oM1wLSFb4g0IdjQgX1XoYVx9ySVDh7ZNAf/iDTNOOAP/Bc
         3hfKrVeiroIb5MVf/GEntkFwulx5VGKzd3olHZoWhIjV0Ud0D0RLpRzzM5e6bfAY9k8w
         d9DNUCghLdtyemjIXJCIb/Jkf7xt/lHfWZNtGnf0Zzcno1aQ7MSX2qs5IuNu218T07aG
         AQ1Q==
X-Forwarded-Encrypted: i=1; AKwUvBwvU6avJnD/aWvcutdTmOL9e/c1N/OExHxJP6EHz98A1Pjdhr8TletJjG1uBnP7LWjrLQ+x/gZdgg==@vger.kernel.org
X-Gm-Message-State: AFq9FYIraAHbFxMbhfZBN0ZcbcIKCbV1CXSogtfyHU4v/alkFlyH97LC
	k4zQWfYDvyjhsc5ALqd7gsnPfS7wQP7t+0w3mEt7q6cS4PmOfK3LYZQ6Fq6bjHXqRn0jj4g1uDe
	saXIKZc1/KdwBVf9qzYEhmD8ysthVxMdC2rWMUfj6NDEP8X+sq+9Q4OEYlCZAlqa4YCdTlA==
X-Gm-Gg: AYBFou03Rb9pibxYv9eDhpzbCYvB69V7faGYnAm19CeeQWeK88ZYTHGkeaiBBwBmbvk
	WAr3gfbiJj4TsV6/X5T8b4BcTDP5TJ6HPJQNJBVOcvyqbPn7L41Z7AcmkGX9LHuSzB/MGCOKIdo
	xaXN2aMz1/qIcjKUlpib38Pjqih8LONDOStc3tvt02UkGOhL6IcPB3bL9x99cwwBmHZimPq3i66
	7Q8MDtoR8zhCt0ICulcOoZ9Gd3c07lmIr/PGGJRO7XNKgQWMhIHbrbHjCesZQho273Dr1OcBgbw
	5bV5v/xBod1M2sJGbURJ9fjrpWF3u8EOcDa1f1Afbb71HB2XoYUOojm8O6Eha9PoarEBEedo8cF
	RyzwNu7KeG4ZFPhOzRPy3KLEBz5iSGzV3o0YT3UtSMHOjj9pkUSyq3mTS11jtHRbzxnUnRhZEcO
	vXFKl+QyTHTjJGi1LQixi3gmCWgK8+hbtsuIWpeoNbC5UtEQp6SMVXu4QPJldHLz8VJw==
X-Received: by 2002:a05:6122:414e:b0:5c9:a60b:e5a5 with SMTP id 71dfb90a1353d-5e91f4d187amr5598564e0c.16.1791972117815;
        Wed, 14 Oct 2026 03:01:57 -0700 (PDT)
X-Received: by 2002:a05:6122:414e:b0:5c9:a60b:e5a5 with SMTP id 71dfb90a1353d-5e91f4d187amr5598522e0c.16.1791972117285;
        Wed, 14 Oct 2026 03:01:57 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c31a9ae59f9sm683926066b.80.2026.10.14.03.01.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2026 03:01:56 -0700 (PDT)
Message-ID: <ab5c5ae1-1bfd-4fe4-adef-fb64b5b3dfbb@oss.qualcomm.com>
Date: Wed, 14 Oct 2026 12:01:55 +0200
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
To: =?UTF-8?Q?Ali_Ahmet_Memi=C5=9F?= <aliamemis@disroot.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>, Armin Wolf <W_Armin@gmx.de>,
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
 <20261013210609.8117-1-aliamemis@disroot.org>
Content-Language: en-US, nl
In-Reply-To: <20261013210609.8117-1-aliamemis@disroot.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: navplZzwfkoRpVLaAj9iSL5zRcy2gO12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDAzOSBTYWx0ZWRfXw+0bjZR6hkJ+
 NZMOcWMcPiP5STey2HpRJLRkcfx3AYPwdYaesgMZPzRtYT0V/iz3p11S2Av9k9cnQs8k9whNNaD
 ZHVcbmQpAzYcp4tVFcmmPBfXlpSrs36dd97rHBSmdHtCLCmuWAzYTELLLxTpmZ4TygIlcKyHip7
 OYf8u90yss0KR7Ia1lThAyPsUlkWz9jNyFKgXv9Z7DqQVQaigVyfmF1bKbeMGKQA1ZL86rVqIFG
 kaS507XdABEu46zF0XrfbYPcAZkXbHmpsiVQ92NYWU5odADmUMfINVWHURgMwv9Iv1hxDWTuzge
 43GWMULupFeoURNAv4CSE+arCPTIPOZMzqAVKd1lBZ5iY5r8yBRWxc/PpktF5+cX5E0tnzPj045
 Hxpr40n9sZenmEEYZHT6IrZM+zCgkOyUrV3av2+BEG4R8Dl4pMvFXCoA0IyaNyci3Sa4+8PQO4I
 VTZ+lBUTEgNdPksNB2Q==
X-Authority-Analysis: v=2.4 cv=ErZHPicA c=1 sm=1 tr=0 ts=6acf5316 cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=VKiBM6ZALRNij_qUCYgA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDAzOSBTYWx0ZWRfX0Y+BdTkHBhin
 X9MRgIozrXCn3RRSZF5120CwJFVyKmSkM8nfGPbM6CE4dsoz1T9PvfQgzwFaIU6L9CBQMSy/egs
 Cg3xSxfssKhHGnSaZEKFxA+vWrtneso=
X-Proofpoint-GUID: navplZzwfkoRpVLaAj9iSL5zRcy2gO12
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 bulkscore=0 impostorscore=0 adultscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140039

Hi,

On 13-Oct-26 23:05, Ali Ahmet Memiş wrote:
> On Tue, Oct 13, 2026 at 07:20:55PM +0200, Rafael J. Wysocki (Intel) wrote:
>> Also, we don't actually know how many "bad" cases there are and so far
>> we have identified a few.
> 
> I wrote a script that extracts the ACPI tables from all 208 BIOS
> packages in Lenovo's ThinkPad catalog (370 models) and flags methods
> that switch the EC page selector (HIID) without BATM while other methods
> use it under BATM, and checked the flagged ones by hand.  Two BIOSes do
> it both with \GTST from _TMP: P1 Gen2 / X1 Extreme Gen2 and P53 / P73.
> Apart from those, NVPS on T450 / T450s does it from the NVIDIA GPS
> _DSM, which only the out-of-tree NVIDIA driver evaluates.  This doesn't
> cover races like the UCSI one in bko221065.
> 
> FWIW, the exclusive variant is done.  With it the emulated \GTST breaks
> neither _BIX after resume nor _BST at run time (0 of 5 and 0 of 1074),
> and with only the _TMP side converted both still break (5 of 5 and 421
> of 424).

As I just agreed in my reply to Rafael, it looks like we want to go
with the exclusive variant for now.

Can you post a patch series for the code you've for this now ?

Note I guess you're using LLM to help you with this, that is fine,
but can you please manually shorten the commit messages of the patches
a bit if they were written by LLM? OR instruct it to write "short and
concise" commit messages?

LLM's tend to write overly verbose commit messages. Note a good commit
message is important, but lets try to keep them compact.

And the same for the cover-letter.

Regards,

Hans

