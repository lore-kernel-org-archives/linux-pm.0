Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794931401;
	b=bmNusMlh99XVn6rngYYcwc78QGeR4yci8rJSuy1sFPgSAgnrHbzofeCwBj2w1GqsTWqq
	 ugLFU+TobTpK+3FQJKR8b4ghCK8t03vF+kRTlk9sVd+Z6Wfaov8qfR4jYlDchCaRvGagp
	 z0OPkx+CuWJf+WfvS3kshXopoKU+4I1TfSP6zv8eO4UdORveFD/12M7XfkA7uXxGzuc8b
	 uwl5d3E1/dzfkcmYKEhN4P+QHEScLIW2hMwHx1NNb2cYEu08vFxxj8OFpV3WsVe8Zm5dk
	 DuZk5esAzpEAU+qsEyDnr9LaMsQPdebGfSkz98Ax4knpxKeOiHvzhgGEuG7jYQTH5RQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794931401;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=K44g9D+a319XGB4PD7ytYAYG94h2IajymOEoYGpnvQY=;
	b=B4gL6EcXsaLFr/b0+369QfHwwpVyX0QmZi26V4N1w1vho9XFrJ/wU2iKc1PfCoHts8nb
	 uSQA2oCPHdTpbm+bk+b96ZG3MycTfBnTiyYpNPJXSP05HkyVrVbQ2vTt8n1arIZTZA2sZ
	 XjM8nb8OYKvvQag75tQZql3nu8mOPbX7yEMQ7Ct2g5wChipS2AUkiUtvzb0/Ei0zqiVmR
	 pqx71Pk4OM74jdunWlIenV6a3SZelBnng8zID0Gcsiwb2KpTEXGiLGbmdrpJRaWny/nAY
	 JWV7KwRpZGdB21u4cJGsIUPIhRJHbKeFNlx6iqELvscHL4R3Grke0ubQ24tuSRp6Cww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=DjH7rE7r;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ciYjquy3;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDCCA606A32C
	for <linux-pm@vger.kernel.org>; Tue, 17 Nov 2026 16:03:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EDCCA606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=DjH7rE7r;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ciYjquy3
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AHFQpQg1663289
	for <linux-pm@vger.kernel.org>; Tue, 17 Nov 2026 16:03:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	K44g9D+a319XGB4PD7ytYAYG94h2IajymOEoYGpnvQY=; b=DjH7rE7rXPUt1HX/
	wnWqhTKgUG6zzAcP2cdBB7rOkK0/+hINtf+imirMNoaJtRDUnJ6GJb7GyFaOpjIO
	DR+JPWNr/nHrNC8SnvdajhhbziVtD9nfokhUnKeKZ9Pm1LN4OVc+GAm2ejBf0BrK
	G/KE3JbWvMOWvCtl4BJrotWwIw7RRQCqd8RUY3cQ2ak0kTF/07bgIpx+yTqlXtyC
	ZLCXpZP/09lMbCe5ZBtHOgfzf1eeYWqfJXAtktIOGUaVa4wj9hlUpi4sPRFsj5Vl
	tTsiOUuNbGvZnZqnlL0NZtgOauxcjfa8LEYVvD83+GRsYMf0S+N4STCQB6yuRuUQ
	o+xvvg==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0kcc9u7w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 17 Nov 2026 16:03:18 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-7cc06b9ca9eso270994137.0
        for <linux-pm@vger.kernel.org>; Tue, 17 Nov 2026 08:03:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794931393; x=1795536193; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K44g9D+a319XGB4PD7ytYAYG94h2IajymOEoYGpnvQY=;
        b=ciYjquy3mKYpLBVYOeTMAYxKZKY6SRXCfL/ZSMmqwB7SPFgttRv3pq9U7tXw+tc5Er
         IZRye7Ac27Iymk8RRwprZq3ML4zcbdlBHgXDlqKURd3F3APYAGHTqsstP+U+qFHLFtK3
         wWPk/Kh3/6tbc/mQNNmdyOedmc7lbjJ45dGtVxiDZTltfw2tAEnEKIBt9TQGfMM+75Uo
         rYMkgeYAgWCBEWRStnRbB5fCp6WfywXdGHxPdhIr70vVblZ/G0zjL61XA92zb/so+INV
         yLMELCp4OGyEZx84qoG0VnQcrJs4ag1ZqNmngV6P7o9oVg70AACd3hi77HSY8w0eojp3
         ySGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794931393; x=1795536193;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K44g9D+a319XGB4PD7ytYAYG94h2IajymOEoYGpnvQY=;
        b=mhDOXzV2WuDvULGZuIjhKTaKOBoGPPhJX+OvqrXw8G1CPgOb18gfDkHmvEU44itCu7
         LK9J6h5RDgo+k17dSBSwI4sjt2uKQp30QXKPIg9eURzevSvHRZCxAFx7ETmI5NZL7cTh
         7ZIe7Yfev4LYTEb8wdbiiGweDiogtwN03msor18hZaFT/Y5HcSBI1iE68Omms1dfhqje
         fPl4t4aRE56poDEgS60LpMCud1tGVMUAX0CsmdcojAAs3XhUDCxEp8pt4eVr3L/hGl3P
         Y06V7BmFTAG8RWIcWgxwEfrOD9Ae0jdb0VfnRvcMa2kk61tUpnC+8rsepEAX8M6SdnJs
         a12w==
X-Forwarded-Encrypted: i=1; AL+hErFUvrSWpb1Y6Lxm7ouDQGfAisgQJCzRoVGBZaW9Mj+Y6yHJ/0rvFPZx7YBjOxc4SPfHWnyrHY95sg==@vger.kernel.org
X-Gm-Message-State: APuU4Z/KscMe6gbxW2zRkmvgKnAXIdNolZtKHmqwXeYhifq9Eu966W2o
	fDoIL/HWTlBJh23I5rOfWWD7JQZ3AhZj05JIh38zX4znsOSTXfLA4R4LSljN5vGIdo6dQdCcOX+
	wc7Rxz19p2cvpJ2UkPRMF30HD1X3YoIu+8r79DxbicrVcwPG7Rzi5iI1Lb63jgw==
X-Gm-Gg: AYBFou2y9WpU+FOOFUEFzjSNJXbabvmxapaCCquUcYogm+3buOfQ693Eg7Rtnw3Ixwa
	Jw3+j2MttIyMj9DwHikBJogfpAmLOgwNcSeJ7NENvdsFa9OQDMfzaTTbEflS2/XjyWIeodQdu4m
	Rremgi+UUbd9J68fSSNuMG6L6KJH278XU56KmE01gGeq9z11d0KyZXAiKQEVEyRLMkV1DToYwdx
	vVN4Jgpq8chZRYsF33aKU5dif7XRf8YIJ5EEEj6XAjlDzBEH99ReCuaCztQjno9OjY9rlfp5ek0
	Si+dfm+FB1yIcCCKpRLSdizNcmcSfMcl2fxKkX47S6qaotcC6nJiynq3vYLHzzZyB7c7fOpaNT8
	qbn9vlniqJGOn7DEqgqpNyXA9VIE77Z4679h5ImdqBHr4Ky3mULtbUF84Rc7A/DGyMO31XHogxO
	hwSU0MS/3gKj6XiIH0Y5Nx1H2TLrAbkV3GmjvdVw==
X-Received: by 2002:a67:e7cc:0:b0:7cc:33c9:b3d2 with SMTP id ada2fe7eead31-7d64d84039emr4314619137.25.1794931392697;
        Tue, 17 Nov 2026 08:03:12 -0800 (PST)
X-Received: by 2002:a67:e7cc:0:b0:7cc:33c9:b3d2 with SMTP id ada2fe7eead31-7d64d84039emr4314573137.25.1794931392102;
        Tue, 17 Nov 2026 08:03:12 -0800 (PST)
Received: from ?IPV6:2a0d:e487:16f:e583:d991:ba24:64f2:e39e? ([2a0d:e487:16f:e583:d991:ba24:64f2:e39e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb78422d2dsm111459425e9.10.2026.11.17.08.03.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Nov 2026 08:03:10 -0800 (PST)
Message-ID: <0de1444a-a0ba-4e16-a480-74a39c865ab6@oss.qualcomm.com>
Date: Tue, 17 Nov 2026 17:03:05 +0100
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
Subject: Re: [PATCH v3 1/4] platform profile: Extract the core from ACPI
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: rafael@kernel.org, Len Brown <lenb@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Viresh Kumar
 <viresh.kumar@linaro.org>,
        Hans de Goede <hansg@kernel.org>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Mark Pearson <mpearson-lenovo@squebb.ca>,
        "Derek J. Clark" <derekjohn.clark@gmail.com>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Armin Wolf <W_Armin@gmx.de>, Jai Luthra <jai.luthra@ideasonboard.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jack Wu <jackbb_wu@compal.com>,
        "Mario Limonciello (AMD)"
 <superm1@kernel.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-pm@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
References: <20261024223501.1420953-1-daniel.lezcano@oss.qualcomm.com>
 <20261024223501.1420953-2-daniel.lezcano@oss.qualcomm.com>
 <CAMuHMdXJOpcC3a6wMXF_m=uNjuqSO1Z3kyM7Az1uP_2GBurOvA@mail.gmail.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <CAMuHMdXJOpcC3a6wMXF_m=uNjuqSO1Z3kyM7Az1uP_2GBurOvA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDA2MyBTYWx0ZWRfX4BA2NjX/bZ7E
 8pqY6RkdaNYk65if1yQmoqXJDgDbK+4dgAJtIVxkJDeSLpskDmFfuzuSKsSEMRRBoZzFIrQm3ZT
 +Nt+zREhAFgfO+86SNGhillNu8Hwx+Q=
X-Proofpoint-ORIG-GUID: Z7w3mkP6bm36dG2_tnA0xkcHjJkBEjk0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDA2MyBTYWx0ZWRfX1XjzzDjQa92D
 4FYwr1UB0afbjQXkzXu9J9KyH/nKtX9QQqn0wGo+xanmzxQgRnCxQuHsuH7peBEdD9HnIRKfrcj
 tqZ6o/WXx+tuu8eYNQgjyyzAhOIZ4LTpyt5aTB0PMFQk5l75TkJnGLIlbcU5qgL4a9jtV0zLYkJ
 i9YZDvboFNya32JZB+5ONinjlDI1m1AS4jbOxqip0kdfiJuNA0ZyOIFl6bc1TvyLcbox5LNXaU8
 APgauF7bn4Zq2rT3Nvu4q+vCLXWMmeTRBsZ4pUC3XztLfe3l1MgQwhpYSMmPEJxm3sJybBD0IU5
 oE/nY6GYRoooPWd7yV4GgihgjOXadxayzkq+rQ1PeSGIo+fnW89tp1nYToAcyTtZxSo0RbtCbJb
 aG15kcb+5kAEPlCu+aPlozaTmnJYlpmUBrQeuK7oY3pd8uFC1vmRy/Y9MhPbEGPFa9n6w/mgdYW
 LZ94bZsGSL3uZTkLQHw==
X-Proofpoint-GUID: Z7w3mkP6bm36dG2_tnA0xkcHjJkBEjk0
X-Authority-Analysis: v=2.4 cv=ZP1CCn7b c=1 sm=1 tr=0 ts=6afc7ac6 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=XpNdnCcgRucV5c9rQ-UA:9 a=QEXdDO2ut3YA:10 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_03,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 spamscore=0 bulkscore=0
 adultscore=0 malwarescore=0 clxscore=1015 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611170063


Hi Geert,

On 11/17/26 12:48, Geert Uytterhoeven wrote:
> Hi Daniel,
> 
> On Sun, 25 Oct 2026 at 00:56, Daniel Lezcano
> <daniel.lezcano@oss.qualcomm.com> wrote:
>> Platform profile providers already use device-based callbacks and do not
>> need ACPI types. The core is nevertheless confined to the ACPI build and
>> refuses to initialize when ACPI is disabled.
>>
>> Move the implementation to drivers/platform/profile and introduce the
>> firmware-independent PLATFORM_PROFILE symbol. Update all provider
>> selectors. Keep provider-specific ACPI dependencies and the
>> platform_profile module name.
>>
>> Isolate access to the legacy ACPI kobject in an optional compatibility
>> object linked into the same module. Retain the legacy ABI on active ACPI
>> systems, and initialize the class even when ACPI is absent or disabled.
>>
>> Use subsys_initcall_sync so the class is ready before built-in thermal
>> and CPUFreq providers, but after ACPI has initialized its compatibility
>> kobject.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
> 
> Thanks for your patch, which is now commit 699041135f75b13a
> ("platform profile: Extract the core from ACPI") in pm/linux-next/
> 
>> --- a/drivers/platform/Kconfig
>> +++ b/drivers/platform/Kconfig
>> @@ -1,4 +1,20 @@
>>   # SPDX-License-Identifier: GPL-2.0-only
>> +config PLATFORM_PROFILE
>> +       tristate "Platform profile support"
> 
> I guess this can be invisible (perhaps "... if COMPILE_TEST"?), as
> you have updated all provider selectors?
> 
> If not, I guess this needs a "depend on X86 || COMPILE_TEST", so people
> configuring kernels for different architectures do not see this option?

The goal of this series is to make the platform profile firmware 
agnostic so it is available for all architectures


