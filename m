Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830983D47AA
	for <linux-pm@vger.kernel.org>; Tue, 25 Aug 2026 08:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787646182; cv=none; b=MzSnmY0GYlwvXUiwh9KMRH4svgkZ+uoBNGOn6fhB8FIFnBO5RsAFjJTsqDuS8fkaAlq/SmSb1xFBPuFYyXzQ9CtnJlq9xasRCZR2sVBn6yqs5cZwm12U766w81V9QZTi5biSJb6yAzANmidz4eicwmoPUvTq82CQK6KrZWJf+x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787646182; c=relaxed/simple;
	bh=3k4yRXSRua7NYMqAmmhy33cZ3AnCSJOK1rbJA9IReO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L9OE9KiIPx1/vE8kD25/kWDe5pO0Tm97ob2gDVkiHGhNuHASHWPx9Sjq/h/zTz+VthJR3CHRQNInmaWOy/+n0MafxHS+0CyVXvtZO6fnm8d5xi00SvpEcIE2icO2Yjt7t25bwFGlT1ooxS1A+6Xv2oxQHsw/rta87CChEuQKmsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cJObNxZo; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XJdnFqM3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cJObNxZo";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XJdnFqM3"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67P889lV771432
	for <linux-pm@vger.kernel.org>; Tue, 25 Aug 2026 08:22:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Ywz9kH7gTln627j++0eOYkrz
	Mzb6+AiHqb1QNVbCm78=; b=cJObNxZoa+HbrFvBFQ1ru1TxDdBS/19QcmdXzbsS
	JezWSTJ/JX6BEnSx3McaDZcdeRb8zxcJzt9OBCsmpJ5TbONQYMbmEoQXrw64sQKf
	+knun4kxmL+UuXAoIeVu2eeJdoDwUxzlTFYHo5k8TCUSyPXow1jnxrU1VAZ8b0Ck
	3y9kD7g9xKnIqG9hMv9IkhKaTlNAipvMBpAHTYzMTRN81ghQAbFEpV91PvrV8tWc
	b1aWJoSxXSMbwAQEArCCERwR63DVMQeE1thTJO9Qc7WQ38z/vr45Z9pmttd65BWE
	sHIopSczy/pbsFYxJVJUHaCWDWBE28+IsSynzfO7mzXeBQ==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g93narwkv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 25 Aug 2026 08:22:58 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-977fa96a0a6so525906241.3
        for <linux-pm@vger.kernel.org>; Tue, 25 Aug 2026 01:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787646178; x=1788250978; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ywz9kH7gTln627j++0eOYkrzMzb6+AiHqb1QNVbCm78=;
        b=XJdnFqM3O/XlABx3vN+uuDqSsk1T1XlnK4ciR7rzuNx/cimJeHM+oKlkGzO00d2LkC
         4oIhSDcfvwWRqsEoZHVxZGIecgEL+9Q9oD1NFiC88KY8o7j8CQ8TwvKecTJuLxt3KbRa
         aROB+QLibMF8BFUikX9UhJhvHHpe8o2ETS3VYIwmo3raI004dokWjbzhoU8A8X8tqjFb
         GeGDtJOu0c+Bw8UYGThoLhEyOr2aYdr1okVxFGJl3kM1SRVlAhZgychQ46WyZtbWECDX
         W4ZhaD/an2jIozTcjFTIgM5ELs9cxB5LW0SsT34c0KZ8B+yGZ0CIOaYnBnq621Ahw0UO
         Ji1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787646178; x=1788250978;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ywz9kH7gTln627j++0eOYkrzMzb6+AiHqb1QNVbCm78=;
        b=LhkjrP3fBx+y6kmpMNP5NjuKjz11yaJFDNadYz73CnMj9yUP6WWO5BqC2NURi/mAda
         AO/sIchQ7m26HdSGWM8f+f07pCxKnNC4+b5fKXCg2jIAsYOByDA2RNugKgQjDN0gTN9Y
         tyTV/3axtd0XqqImcwalzt2U7Hg6QRSjxvtc/eEkgEXZeG7REt4n/I7qWgpwIvpfdJP5
         1+arOBOlq1yxmlV6gzIn1hrGKuirj1TNUbKeAfekdPHC0aFJsi8UWMZRtaU1XCFOCLXu
         i+DS2CZV+EygecTeT4hCqHHVnw/DV1fDy/STzdbIVOK81JCmXNasJVB4ID2JDpvVFrPS
         VEIA==
X-Forwarded-Encrypted: i=1; AHgh+RqyYiyNj0vYprWNqXZzkheQUpHOYuqYENFTi0V9aUUFAPmjuxA1qu6amE6blCc57RGu1Ey+5EN1Mg==@vger.kernel.org
X-Gm-Message-State: AFuF++kpaO7Q2CswOH2GdaP19gJLYQ92ka6KCddn8g+SRYLOVSIlby9e
	4VvumO2jOPQQCqI9ORn5sCW36E+3dBkqxnwbjDUceHzYQe0FZctNEHmNc/cgrqS/M+30YV+WkTk
	UQYYjk8X9cNo6PT0lHFe7W8FJh4oof6Ub/79ToDi2orYsS7IlIRyH6dIuZh9Eng==
X-Gm-Gg: AR+sD133uobNBsSh3i4cn9Wuzs08gqAyDyU9fwGEdcrpYaX7YtYaN6eqjb1/MzEoa7T
	EB41Jts+/GwUmcbCamL/kIqHkch+evLXfyxttzzN5DyNhMTONod1/iNlmWqKZoYoe1ZvPTPkRq6
	3LfxKLLpk135lFiLuMIaN1PWr+EdRAWCTrBRDbt1yoHdfs7wUtEiyv7tQi1gmEegE63QkJpYCuw
	U5qSg4mTV7FjoiwT0p4HxOBA4QtMMgZ8/w3LfbsMxRz1hJyD/msZZz2BpwxL/NZ1W23maxO92zX
	pH+XQ++Ttd7lOTDZBL7DYxfHp1EBKaNKKxIy76jyLKnfyy9vUHKB7a7AL1/WEyCj7snwOXNY2xJ
	2zwifgt878g7TRg==
X-Received: by 2002:a05:6102:6883:b0:777:4e99:6f84 with SMTP id ada2fe7eead31-77fe635f317mr1644154137.1.1787646177496;
        Tue, 25 Aug 2026 01:22:57 -0700 (PDT)
X-Received: by 2002:a05:6102:6883:b0:777:4e99:6f84 with SMTP id ada2fe7eead31-77fe635f317mr1644138137.1.1787646176998;
        Tue, 25 Aug 2026 01:22:56 -0700 (PDT)
Received: from oss.qualcomm.com ([86.121.170.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a59e2da49bsm14366325a12.29.2026.08.25.01.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 01:22:55 -0700 (PDT)
Date: Tue, 25 Aug 2026 11:22:53 +0300
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Praveen Talari <praveen.talari@oss.qualcomm.com>
Cc: konrad.dybcio@oss.qualcomm.com, Sudeep Holla <sudeep.holla@kernel.org>,
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
        linux-i2c@vger.kernel.org
Subject: Re: [PATCH 1/7] pmdomain: arm: Fix -EINVAL from
 scmi_pd_set_perf_state() on state 0
Message-ID: <2ah2wpjrqixhnws6y33tlkuep3et36q6typfd7ausgaslykmrb@cn6usezfkae6>
References: <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-0-61171ab1cdce@oss.qualcomm.com>
 <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-1-61171ab1cdce@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-1-61171ab1cdce@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDA3MCBTYWx0ZWRfXxK+02vSWQB1Y
 B4FmPJp5ohar20mJBc4aZJ0tZ92ylxJqgHsAx79NpTURGAl3PHHh3a94dy4EjYDJ/tbSQFJrteU
 CiX18rKsgh7+bFgjcmWkGxhsdEbFook=
X-Proofpoint-ORIG-GUID: yBnpAuT7D2W8DOzAun2o07oWE7OLaQWq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDA3MCBTYWx0ZWRfXyuKu9sKfjjnt
 yGr+gz0Qh5fxrtWvBLJvugvL5zCldKxnhhkAKRH5Zxw3McOpaBi6mVHSgc00IQxGnn56ShUeHld
 NLu0z++xbo18sdlKW04f34W6/YUynrW8sTZZ8d5H6B+FzwhR+J+eQ56g9x7DZDrGg6/BuJqxEiw
 byYrF0wB/8K2+64Nt8FtFF0WQfgXzxeiGv15EV+zX4aHwROFmS7NI1D0b9QvGU1vioOSezC1Mzk
 bOaRuhGF78PZSYOULjSiSoSFbRAM3JMSoud/We/GP4VgzrPvPe+BXZG5H4ZE5DeWQZpV4A8LQMy
 BLNjcOWtlhjUbcW1pYTgsjt4eC9eKE2bFmxwAn7m0iF9LTPZDubETfKGpI2xG5X+SpivjQMBI0A
 7zANueT2WvLoduGbThnIdLFBu8R4QL4T3Enw/+hdzW29I7Z1wPnNMoNKTQ32gdw0/j4sI0LhtO1
 o5phCtlyqHQ3rTKfTBQ==
X-Proofpoint-GUID: yBnpAuT7D2W8DOzAun2o07oWE7OLaQWq
X-Authority-Analysis: v=2.4 cv=W74IkxWk c=1 sm=1 tr=0 ts=6a8d50e2 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=clBUptZa5v5FR042Ey+sjA==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=dS1doENrTls30Ym8nGUA:9 a=CjuIK1q_8ugA:10 a=ZXulRonScM0A:10
 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_02,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608250070

On 26-08-05 01:27:39, Praveen Talari wrote:
> Currently, scmi_pd_set_perf_state() treats a performance state of 0 as
> invalid and returns -EINVAL. As a result, devices attached to SCMI
> performance domains can report failures when relinquishing their
> performance vote.
> 
> The OPP framework use performance state 0 to indicate that no performance
> vote is required. For example, dev_pm_opp_set_rate(dev, 0) is commonly
> used (by firmware or linux)  when a device is runtime suspended.
> 
> A zero performance state does not require any SCMI performance request
> to be sent. Treat it as a no-op and return success instead of reporting
> an error.
> 
> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
