Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794950827;
	b=QDmeLwdRABa+2BQRnFczT1I6YTHsA8gHNk7zC8TAa0p+Uh6XWoyxaAq5JRD6Z4ELHE5P
	 d0hjYyTJoBDnoJqtEZwY7aaWyoDje9T6tKEyTu2EG9XLSSVO2WidRHc/r+sjgwxNEc0rm
	 8AGAtzwGBZHmxDpV2TSW8wVolK2MC556dNzWqm0s0Z0YZzvhQ+JhlgM4zdq64qLqjOyQq
	 blm8/lkV50IVFkHFYeaP4uM1BOsLQxmBt01vIDLHYpFRK4xXa9ZxoDxUO5YJ09jyMgb5F
	 dkRxoubPhYyFdE1lfV0y0srNkF9y+uxLhf682ixbjsvsXoPaKcwnA7vd/48SyI4STsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794950827;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=Kye5UCFhAlBn+MOXhNz9A2crB6ZLISzlyY8FztGTBT4=;
	b=QZQLG52wDmcnSOJV0IMIk4nfZudbQyb0JCs0FkyxwiX6YHFyT879gt8Kc2TSPH803faI
	 0Dz35AJriqSkVLdXtLgJFD7NTvARXRlteQZw27n3/obES6UirCPPcu5HMxsPg7ngVaQVf
	 IF1ZysODT9IcyhJbQk5ROpeaYGiIfWZfgsDbPQMr+h/r2xAidOL71nPtO0/FPfrLEYZfp
	 hdbi34SE+7TNBJU0e6aiQhzoTQ94wOZHD9e4RlPGQzVXUszOtQFHh7ob6/PfQP+rHHse9
	 /FptvXf5hiv4UGiw6unBLh15xZVI6e1wou7c1Sy+Fxp4OMkX5UX9R7HaLO2Qk3edlNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mzqgtgXh;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=e7DlLGgo;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C3E606A330
	for <linux-pm@vger.kernel.org>; Tue, 17 Nov 2026 21:27:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8C3E606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mzqgtgXh;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=e7DlLGgo
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AHKfVst676310
	for <linux-pm@vger.kernel.org>; Tue, 17 Nov 2026 21:27:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Kye5UCFhAlBn+MOXhNz9A2crB6ZLISzlyY8FztGTBT4=; b=mzqgtgXh+8LtF9DP
	EF0D5lQ3qW7+qC4zKERMkCrEqQKmpFz7ZEkgFGX0pLrxYz4k5h5anxYY9Onv61IE
	O1yMYDU1dsuOf8EYLIbQOULw30htv2ksBapiCniOlj94uWXKiuCASqeiFc+S0iB0
	FAB8aEH4H6t2nYg4QMG8Bo/mkt4Q66kEFW5/u+ZpWXvwAWMdE3clhQCYU30/v4go
	qWBbGFQcMMSxgnA21BKrCrfv+0MDmRyi2mwGpho99EsGgOkEKCcdOPyHMK+jYRJi
	zYnTb/YGV4smLo2nlgjPYYC7vdMeSlwbTR8GaxBQxN9ub4NiPvdpCVgD6qCSoMz4
	e3ngwQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0hve3nge-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 17 Nov 2026 21:27:05 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93f559420f3so45348285a.0
        for <linux-pm@vger.kernel.org>; Tue, 17 Nov 2026 13:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794950825; x=1795555625; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Kye5UCFhAlBn+MOXhNz9A2crB6ZLISzlyY8FztGTBT4=;
        b=e7DlLGgobmR+QOKQq0e8FgMxDMyehtVrveDPjc354olS0UaDAZob/9BBxgU5awPfR1
         oPT7ne2R6527xtV6/dwrBUJJoGV97Y2Aeqeaol8BMf/OOlxk4/3JRuZ4MpiVi8bIbnKl
         C8jAbTR4vm6OESSOGToRkDqOdt7imZ50tlNkOx0vSr/XqmL2SAlk8E03tRgsFODu7gTR
         qGbk8W7DpBKJaJ/pYeu3dkNnKQHsSXNlk6xtljgRuoEm2lwUSxhLVUK6nQGMczIBgnCs
         gxEsEYOf7snZz8tqg7cHPx2BirG4xlYNYmbCuz/yGPKHPw++agQu1zQ908YYfUn5h4WP
         fzng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794950825; x=1795555625;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Kye5UCFhAlBn+MOXhNz9A2crB6ZLISzlyY8FztGTBT4=;
        b=pQTIxjMs+gnjr9TdgQOiUwpBcLcOjYjDApw5cymikmehmBfseo0yYrLKOwi0yttZF+
         oBMqwYdP0afk02D0wdqewLjspYeyCMEefsvtaz9xQCePcv6ufs2qFrYu0mQp77JvvzMc
         VinfYmR53WKOD7EdOJpYpPaWohU3B/LXCdoilvdMSGtA1dNKRRGtCkIlMFjQ9DR60m1F
         7areKdQDIoYBQaTC45LHV2yQPCTzoNt+hzRiOGmITclRDQFWA7BaAz+k2+DXY4pOEWNb
         JwfrvzYMTSHFjU08Elu2aVB6X0GNrXlwrrJ/JGwLA0aAF3IsFgY/zo8xTGwYtIxPopCb
         OQtQ==
X-Forwarded-Encrypted: i=1; AL+hErFYJfsaThnmhS57sJYKxKttcXwmPqD5Ehk3AY0ybbb7cC40YXizJZ/YknjxWszM2KzBhGleao0/fA==@vger.kernel.org
X-Gm-Message-State: APuU4Z9NJSO++lN6pz9wF1BZ0FQ/eKyVeljjPymEmiU42N+U58ZfuQOs
	VGAgetL/XPsAuLbTSBlljswmX/j1fTpWF+H3J0MN3CWRR3HC8RBFcSk4d0xKeFOynNwwLnICHZQ
	4aRbVGeTDrUHfxz1o72o7ErSvLL6RAVUKEY4ohKq76+4DPypItRPwhLdaxFkTUg==
X-Gm-Gg: AYBFou3eFuBswZWD7sm8DW8+ugUUPDvjwqEchcQkkSe1jfAhRZVZK30DXpd0oZGSHWd
	rL6GuohDFmnVINvd8HM+oYoR7zDaCQvKLpZtvov4HfE+DxhDfuHDtf7JxZiilNF0lbct1yf8Ulj
	gsxGs6DvcOYzvGz7nFZveTNlhz00rKDK4eA/vPC8WOIJItLCpLI78jcwbauwk66YznWpvu7Ef32
	nO20hbXVQLrQx3mHPk2T9tqCXHtYYIVRpgHH6LqmGliP7vj8tkaxjjcl0K489YgRqtMiQ0PpcJd
	LgvJpKUPcHQOKJBmhgYkyBhMpaODovCHufEQ6yKKjdTCXmZwC7hiwZN5BP0pj7catWZMnrTpaoX
	r4wpGJoizoVm/Vglt3DXCobp+68xTP0rQqfPvo/TxmRurwuoPkG+AZJYEhEXBi1H9zcRDidlCRm
	5J3W0MPgrMMxpt3Zc7IrNtF1Om2osVLs3g4XY=
X-Received: by 2002:a05:620a:8014:b0:949:78dc:f90c with SMTP id af79cd13be357-9499960aefamr136052785a.60.1794950824653;
        Tue, 17 Nov 2026 13:27:04 -0800 (PST)
X-Received: by 2002:a05:620a:8014:b0:949:78dc:f90c with SMTP id af79cd13be357-9499960aefamr136047485a.60.1794950824084;
        Tue, 17 Nov 2026 13:27:04 -0800 (PST)
Received: from ?IPV6:2a0d:e487:16f:e583:d876:5ec1:ccc:7949? ([2a0d:e487:16f:e583:d876:5ec1:ccc:7949])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb78386902sm104139015e9.1.2026.11.17.13.27.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Nov 2026 13:27:03 -0800 (PST)
Message-ID: <4f9abffd-1794-4564-a752-60f99ccccb4e@oss.qualcomm.com>
Date: Tue, 17 Nov 2026 22:26:58 +0100
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
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Len Brown <lenb@kernel.org>,
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
        linux-acpi@vger.kernel.org,
        "open list:CLOCKSOURCE, CLOCKEVENT DRIVERS" <linux-kernel@vger.kernel.org>,
        linux-doc@vger.kernel.org,
        Linux PM mailing list <linux-pm@vger.kernel.org>,
        PDx86 <platform-driver-x86@vger.kernel.org>
References: <20261024223501.1420953-1-daniel.lezcano@oss.qualcomm.com>
 <20261024223501.1420953-2-daniel.lezcano@oss.qualcomm.com>
 <CAMuHMdXJOpcC3a6wMXF_m=uNjuqSO1Z3kyM7Az1uP_2GBurOvA@mail.gmail.com>
 <0de1444a-a0ba-4e16-a480-74a39c865ab6@oss.qualcomm.com>
 <CAMuHMdWfH+_4ijxko=LS_P6b1Y76WWDc8m4xL6qW1H+qKRQ98A@mail.gmail.com>
 <CAB9z6xC4c=o1DwVARBek7ozDxaCON9rpwTmJ810sDGyP0XYQDA@mail.gmail.com>
 <CAJZ5v0jg61_W6hgtMzKdMa+f27ApaNunnpkzM0MoYxN+aV-xog@mail.gmail.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <CAJZ5v0jg61_W6hgtMzKdMa+f27ApaNunnpkzM0MoYxN+aV-xog@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDA4NSBTYWx0ZWRfX+AoJa8Sjgfor
 7AsDSM9XFr/5qdTTpl9EcV4LgEdnWz8BxQJU2Q3RiojPWF/+76jGnIz35MJJgN5T5raiD+nikN/
 XOt7cL+kZa/0LTbNYwCsC58N69N2XQo=
X-Proofpoint-GUID: TLjW8QuZNrpScuRgjunKZIDtj_KAvp7q
X-Proofpoint-ORIG-GUID: TLjW8QuZNrpScuRgjunKZIDtj_KAvp7q
X-Authority-Analysis: v=2.4 cv=dqhOmFg4 c=1 sm=1 tr=0 ts=6afcc6a9 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=1nFPZZerRWjXyXi6724A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDA4NSBTYWx0ZWRfX7mdfnhOq23cQ
 Y4JffOyqU7sQ6X4zVFHB6ZZ6WznNx7Vd9dVxBO0jnn9x7g8fym30MUEigaHR+pIQd0WqH0YIG5t
 Rlhl6PIHmJ0AIysmJCft2lIoYBaUjLZPqNHgZCQxjNYajzetGkHzyWrtvVRVJvMpBWGO8oMthg+
 PnoE70U8pWIIxIedRDsdrVZHpPL5Tl0CqKxqf9KdWIvHrUjjnzqVz1qs9pfKW30M+UGjiP9p4oG
 AJ8zAkSzZA0kNwvE+8hamRhpSuLfh+cFNSjxETRDt0bv9jFXvjaZWdpme9d1pwpc7PCSB9wj740
 dGfOyNb0gsnC1Xd4ZLSeN/dARW9PByK0AO0/i5eQHKMryZzPcv71V0I+91f3/aa0szYIYoI+A9E
 Jvt9md0Z/ozT99U/bChPPhunkho6aPj3l2+8E0M9GKoRBmWlsr1GwF4fM/EIkSgi+W9M8vDGUim
 wDHdNIObtNjErRA+QOQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_04,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015 phishscore=0
 bulkscore=0 malwarescore=0 adultscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611170085

On 11/17/26 21:22, Rafael J. Wysocki (Intel) wrote:
> On Tue, Nov 17, 2026 at 7:27 PM Daniel Lezcano
> <daniel.lezcano@oss.qualcomm.com> wrote:

[ ... ]

>>> Sure... Are there any users of it on these architectures?
>>
>>
>> ARM64 is about to (patches are cooked)
> 
> Geert has a point though.  There are arches that don't need to see this at all.
> 
> You can add ARM64 to the list while adding support for this to it.
> 
>> Others IDK
> 
> Well, exactly.

Ok, I will send a patch to depend on x86 and COMPILE_TESt
