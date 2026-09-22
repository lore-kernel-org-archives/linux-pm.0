Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4C5545DAA
	for <linux-pm@vger.kernel.org>; Tue, 22 Sep 2026 13:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790082400; cv=none; b=eNbOpUN+ctbYT/tYf7mJE1sAy6BnPwjEix2QKmmotzYyu+dI2E2bHXptlFXPMLbRM7xCNxmhQr8mgRF3Ponwx+Uo5jBfRDFw395cXJtiham2jd3cSX9joV7AtI+gWfgz8Y49qSfIqFy3rALf+LJClp9xua+q4mg5guuRD/mnkpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790082400; c=relaxed/simple;
	bh=fZyF01Bt9UqglrZKKojsG/PhUI2nAMEB86ngsJzcUvs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H3J0vAiAJhu9Mb0qS1l2dPDvCvlyvG7pO1250EgLG0aVTFJ0jp0VYJay6Y3kFLC7/tTQbQD4zDdqxuHHyUrI3tqoiNHPsr8bGzOkLNpZgekIJ8S+i0cDf072mb7gqJuikjXnyOlX78rneTSCNdJJcwTiwLHnFUQhL3/xayGWRqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lheEa0pQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dYA66Mum; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lheEa0pQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dYA66Mum"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68MBPik9269300
	for <linux-pm@vger.kernel.org>; Tue, 22 Sep 2026 13:06:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aXabJbQ5GKuSQz+kVwnj3VIjTGckGkJ3Lh8aDQ/65UI=; b=lheEa0pQ4wbU+4SM
	nttQDF/eeNcZ8LqaonuqKrhcBLJDVxqFuW5hZP8J9/Hei3pi8H91jYapkWUWWBCS
	3Ci0ibT3K4miDdppzj1capW3kxGUlZRnvjtZADecv60Yctezno5+fEHo4I80xb5T
	IInDQTrO/Z4uyTZ4dSjp3OSDYgUUeUBQqu7ROMbhQvhjYe8BlG3KEIY+pycjTaXB
	gjvsABHXOfU1MD8VQEpXarzIgHwTKK3ozxFBTVfUt6Fa+Zx8xcbYqEYWf08dvAvG
	leNem7sKdqMFG3i807NGdHw/kPclTtdVo0wR2hEovb0SjnS29QijH5tbUEgsfGNO
	95NwGA==
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gufbatuku-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 22 Sep 2026 13:06:36 +0000 (GMT)
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-6ab162f6428so392192eaf.3
        for <linux-pm@vger.kernel.org>; Tue, 22 Sep 2026 06:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790082396; x=1790687196; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aXabJbQ5GKuSQz+kVwnj3VIjTGckGkJ3Lh8aDQ/65UI=;
        b=dYA66MumgbzzvErw92Pxb6TPZYLwqsi5i+CW4T1htYSp5CdWPY6dMcdGozwQjP4ymV
         KDjr0JLCQXvEH9GqEFDhEY8gsaAqKxjetf94uE3FPR/qZ1m+FyYlEUoAgaXX7VPUG9sw
         f3GgTvNoRzJ3KEvTVrCd5DI/MZZLVaUT0AN54NjR6lHJp/8bnFxXCC/M0nmxL+2PVYU8
         vWFhxXstma/7UWZ+M7eqffzGOvBIyOoS+zKXn+p21KpIUCg2bPT3FHK0wvX6Zb1c9A4u
         XVB470ZZRps+AfB+HogrCqrEvOMrFrIu9Fn3Fwo1VxV51AkGJpTUFxApH39UWM2GVYJF
         jRrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790082396; x=1790687196;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aXabJbQ5GKuSQz+kVwnj3VIjTGckGkJ3Lh8aDQ/65UI=;
        b=gfmCyKsdCo7ZFuXAts8tdiCxb/fDzlxIn4E/PWk3+zH3d5xTfHJNuiMGZ894KL2WKr
         y5nzQ5zCuWYbqIkgVuWFgZtTeuGYkx4Oz5E/dp6vWRYKbmILgMsniE1+1gB0iJMPma5B
         I9C5d/Rz+2Tae9LZz8v18XYQ56F+f76t0LgZS29+6qKI2PsuzBw98xcDnmuHsm7PfoKt
         j8K+O4CJExnG9k/DpOX2K6X/sitfPwNnJC0qo3U7xp+c7ied7wpfiEPMBiQiwkHqJXR3
         4G3DCU7WfRSdjNbuhlH0+1OmhzeNNJGBuM8dmM9xjWPYG8Hxb+VxwGzu0HnuEId1WUwa
         9zJg==
X-Forwarded-Encrypted: i=1; AKwUvBxTPRZtyG8piAr0V0hKXijNSd8uLBsz+Tut6SomlG9lEbyOpMu0tzGlbIwgik5YIBGXkEvLLAvnaw==@vger.kernel.org
X-Gm-Message-State: AFuF++m3/LkR8o1U0RhNtbZjxYKCAg8QLdYKYQAn+FHAYOUuqDI0+g/a
	ZwKffXdN/kpeFUvP4WHE6E/gYyNEkBzrpaFVLRBTdXTIcMn2ZZihtsQlDAiwl9xbBoGZBgVTHm5
	MJa8gdk6WN+6rrXJ3VUXrsEBAhU4nW4ezGmuIIYQ+S7FHiVH2k3OOsv6rKgA8SA==
X-Gm-Gg: AYBFou2kNgteUWIOfECQAtpjEIXm6yEMZ2voYNmpeezQKtfviRrQAP9YapQZRibDVE0
	WwnmhW/njgXHBjGHxghl6IDue2VbYBnO2IuahsdCftvUgKwXLIaBOkIVqNTlj4v5NplXoMjQr3m
	sPmClRvCUUC1R8++qfC01U5PS/syro+qjv4C2TaGiBjIEDudPyGIJYvAmyngBxO6YQ3tICUBvOR
	ECHS3ugrcGBvVPL3DQL7RL7gEIU6hwAQiSKe00C4XgIqWQcmjdL4/3B4DFDIbZ+s6huhikbYF/x
	0t1hn3jsDYBOw9SnSa15s1xMWRGiIb0ivtUPQfMDtqYZvzzPDl8i4GiqvYmKxLwG982ZyVjVs8s
	XTHvO62Rd1flRLrU/OB3ZCw==
X-Received: by 2002:a05:6820:4d52:20b0:6bf:f0f9:a3b3 with SMTP id 006d021491bc7-6cb2ce213b2mr9754537eaf.2.1790082395632;
        Tue, 22 Sep 2026 06:06:35 -0700 (PDT)
X-Received: by 2002:a05:6820:4d52:20b0:6bf:f0f9:a3b3 with SMTP id 006d021491bc7-6cb2ce213b2mr9754497eaf.2.1790082395212;
        Tue, 22 Sep 2026 06:06:35 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6aaa44d1aa9sm1034255a12.10.2026.09.22.06.06.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2026 06:06:34 -0700 (PDT)
Message-ID: <ae4581c0-1339-4398-8d35-1d7611a0f47e@oss.qualcomm.com>
Date: Tue, 22 Sep 2026 15:06:30 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/9] soc: qcom: geni: Derive SE clock configuration
 from OPP table on SA8255P
To: Praveen Talari <praveen.talari@oss.qualcomm.com>,
        Ulf Hansson <ulf.hansson@oss.qualcomm.com>,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
Cc: Sudeep Holla <sudeep.holla@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Ulf Hansson <ulfh@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Mark Brown <broonie@kernel.org>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>, mukesh.savaliya@oss.qualcomm.com,
        chandana.chiluveru@oss.qualcomm.com, arm-scmi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-i2c@vger.kernel.org, Abel Vesa <abel.vesa@oss.qualcomm.com>
References: <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-0-091697dbeb02@oss.qualcomm.com>
 <CAPx+jO9fcvBsxe9yx9oK=0EXmpNwub5ba0a-TGk1WRFaRGsqpA@mail.gmail.com>
 <177884a8-902f-49be-8fcb-b2bec3ec7d6c@oss.qualcomm.com>
 <CAPx+jO8bXn2F3cWz87Ozjrh00E+a_UWBrHeUViTEkTL87JHW9Q@mail.gmail.com>
 <0f5494c7-c3c1-4668-a09f-d8c43d1c58b9@oss.qualcomm.com>
 <6c28e672-349c-49cb-892d-ec521b3004bf@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <6c28e672-349c-49cb-892d-ec521b3004bf@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDE5MCBTYWx0ZWRfXzDvAnyAGUVUn
 ididBjiZlNHDLd7ftInPDMMRCiEV+15Hn/tZATTmw7tOSVKMhSufLIJNf7d3727us+UXaf032uE
 ASa5Pn7YhnX/RfiDzgZiIuYKsbiF7xp6Nf2BCQmCRa1j3FYyXmgm3BZkH7qgDA9nUgkwTvPMqzv
 87WgYxy7zsa+k6ozeSC/Mer6mK1OW1OT/9jlOFHHPmhKcf7aK/QxOkwktI/qWdn/0lFbuvWdGuU
 fz+N/RQSuRIy9ihDo4QzHr3vpCc1hTAdsQvaZPNw6robBrunAjbQB63Z35Y/Kj4Wuszr165wkis
 4KllBu4ZoarPV1r+BD1P+MW8SeHV9tsUiyYI5WKG63MrXOnbKCbS657/vIh+3cS4Xrq7T0ieI/z
 Kkt3v81o7W8tzID4LETzDQ8CWhy5LWA3PbaQnP6EJV0C3ze87CQ0OUbAGdUXbsAQJGLYo6Jv7V/
 lB2+YCM68l/7YhwpCqQ==
X-Authority-Analysis: v=2.4 cv=IYYSymqa c=1 sm=1 tr=0 ts=6ab27d5c cx=c_pps
 a=wURt19dY5n+H4uQbQt9s7g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=V-jRUn7sFLrw_WHHsgMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=-UhsvdU3ccFDOXFxFb4l:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDE5MCBTYWx0ZWRfXzyx+fM8b3Ww+
 L0xwrZX8NlWd4Puj5NdEDNLZ7ppgHfodGiBiDSz77uRVXlordkCsMAZ/0Cp26RIoCr/sRl1Kn1a
 SVcj+6KsXVfAeGHbUcaqHaTub64gjdY=
X-Proofpoint-ORIG-GUID: 1uHiCqcZekGXQOtPyoU-ToCaotq7szvt
X-Proofpoint-GUID: 1uHiCqcZekGXQOtPyoU-ToCaotq7szvt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 bulkscore=0 spamscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220190

On 9/11/26 7:33 PM, Praveen Talari wrote:
> Hi Konrad,
> 
> On 04-09-2026 14:30, Konrad Dybcio wrote:
>> On 9/4/26 9:56 AM, Ulf Hansson wrote:
>>> On Tue, Sep 1, 2026 at 6:48 PM Praveen Talari
>>> <praveen.talari@oss.qualcomm.com> wrote:
>> [...]
>>
>>> So geni_se_clk_freq_match() is used by two consumer drivers today,
>>> drivers/spi/spi-geni-qcom.c and drivers/tty/serial/qcom_geni_serial.c.
>>>
>>> Beyond the $subject series, there will be even more consumer drivers
>>> that call these platform specific functions. As I said above, I don't
>>> think this is moving things in the right direction.
>>>
>>> If this can't be solved with generic frameworks (clocks and OPP),
>>> please clarify why so we can figure out a better way forward.
>> The way I read it, isn't geni_se_clk_freq_match() more or less
>> dev_pm_opp_find_freq_exact() called in a loop with an increasing
>> divider?
> Currently, geni_se_clk_freq_match() relies on clk_perf_tbl to
> determine the source clock index and divider corresponding to
> a requested frequency.

So I think the part that blocks going in the direction I
suggested is that the index and divider values you mentioned
are then required to be fed into some GENI-internal registers:

-- drivers/spi/spi-geni-qcom.c
clk_sel = idx & CLK_SEL_MSK;
m_clk_cfg = (div << CLK_DIV_SHFT) | SER_CLK_EN;
writel(clk_sel, se->base + SE_GENI_CLK_SEL);
writel(m_clk_cfg, se->base + GENI_SER_M_CLK_CFG);

and it seems like every protocol driver does some NIH things
to take care of that.. perhaps this bit could be moved up to
the common geni-se layer (Mukesh, are there some historical
reasons for this being handled in proto drivers?)

I think this may just be an effect of how the hardware is wired
up - the ""DFS"" clocks that feed into the serial engines are
partly set up in the clock controller driver, but then there's
this bit:

-- drivers/clk/qcom/clk-rcg2.c
clk_rcg2_enable_dfs()
	/*
         * Rate changes with consumer writing a register in
         * their own I/O region
         */
        init->flags |= CLK_GET_RATE_NOCACHE;
        init->ops = &clk_rcg2_dfs_ops;

which is the writes i mentioned above.

At a glance, plumbing this into OPP would require making GENI
SEs self-consumed clock providers, which sounds no less messy

Konrad
