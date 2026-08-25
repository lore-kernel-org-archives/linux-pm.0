Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DE53DD873
	for <linux-pm@vger.kernel.org>; Tue, 25 Aug 2026 08:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787645976; cv=none; b=gbmnJQEaQbzCYNB+Kq3alKI3yGEtySueIiNxSd1f98DUEWLfx98hD+aVhk2Zg2ZKAgLNQgpaeseYUIyaL3t2FkwgewtUe/NM1J4bDt8IYjRO62u7mogxSngYTDlBm0eMwpJ+qghfGiR+19y2ia7MN7N0ITtAZ0WUFFJD54HboXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787645976; c=relaxed/simple;
	bh=Ot8jIiii0wOPLXsN9OFHxPtvh5gzgjm6lZFKpTOJH6Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EbPlLMf5gpAJ8tjh7scpUgWVV2CxdERyREdRRjaq7yYswHjbeHDmflzR/TZiKFmWYI/zMa/qUnGt3IYbIgOI8BlUuDzsF+kbgAwtPQCBOBn32McDhGeuqNyxMAKf4F4ZZ6BF5YNzY4KCfT2P8fol4RJTaJ0XosvnGScU8En2FnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=j7Rc8kjB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Xefx6oUr; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="j7Rc8kjB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Xefx6oUr"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67P88IiW1706724
	for <linux-pm@vger.kernel.org>; Tue, 25 Aug 2026 08:19:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GT1LG3ESk4pX1L2+pv91ZrHz4OSnmnqI6wnpsuldA4I=; b=j7Rc8kjBAo5ttSFF
	a4Zv3pZeYdtIKXkG4JHEeDDKnKiKSSQj0wg7tyKNUIJu5LQSLwEGxOSxXslnk8PG
	h8ZLEiADGwfzm+T6fx6SqN4DEgTv/gr8h0+zJqklIrULq1JmTRJbkQkMbD3q2hhm
	malZb9VMsaNEC7RTMvZqtOh4so2ExbdzcQvGKOqhlUKbED0Y4Ka/b4bjedduCxI1
	csCE7XF3ccE/bAjDrVtzDfW2f/vSyGlUY3bwabmuG2leAIQjpQptjdpNGF3vKr5X
	KcfRz0oQlAUjRSZdqEsAvCdV2gKDwx7WQiLP6rfJAiiInS52/O7VW0qT2+F8ajEP
	RS1nMA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g93kvrwha-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 25 Aug 2026 08:19:32 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8484ba00601so5129745b3a.1
        for <linux-pm@vger.kernel.org>; Tue, 25 Aug 2026 01:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787645971; x=1788250771; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GT1LG3ESk4pX1L2+pv91ZrHz4OSnmnqI6wnpsuldA4I=;
        b=Xefx6oUrGyKDffGOz5z/sKZ4LSXEXdhddzrjncq66QYUPJqB3TsXYztc3mF1ZyvFqs
         GvhLOgagZEHoSCwlErIrkflb5WL3tO7oCyBHM+cti1WTl6MhbIkCW6KkNl8KC0Fx7FjC
         mG5kt1Qw3Mzm2WeNT74nQiZihjgO6dD9aY4GqZQcMtcwax0z2T4AQv64Ddjo7skPkBel
         fzcHTF7mKJo/4FDaoKEQO6Rqr+zUZrc99GK9fKQEnCGYjjQ9ELd/Lno6dnIWWtbwq+26
         QwWUn7J8GAp82J+X79ob3/PxfmFZOBArBOh4KRTVvnkL1tRG4sHIko5QI6sC8Y76pgSb
         fsBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787645971; x=1788250771;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GT1LG3ESk4pX1L2+pv91ZrHz4OSnmnqI6wnpsuldA4I=;
        b=I2ZuyQnfdouJYDx3UJ7ENK0l4iCVnQZaB0hJCSeoeKOXLqgwC0oEiOhfW02sJMo3Io
         6MruG5q7uc8Y0UdsgekIeDjFvip3cu8NUDRtYNUp3FnmtLx4hu3vZjqYO6Z5n492XO2o
         hdctfQa6ZLWxVHFz82dQn2S87Ja3GXGaNLOUSICnaaPylpb4UdbjFblQBmwzwX48h+IW
         3P/bhulVfzkdo0r+7QT332oaXdNO0/rJfAv9zc9KgCBkljmzmXf8WcLnqoEBEbDGAKtM
         3/bvyStnD8tR+vo7xiQ9VZYNnOJkuGBmENmXHc/HGzOlhuWMHfSDgUrqTwzDOwcNKsIo
         ePwg==
X-Forwarded-Encrypted: i=1; AHgh+RoWGFuTXbztVp6PaCzIbV7PBesi+wcrajmsypJ1/Y5Ftp0ggAJHlEFPSqxHdfEqXD+g7YB9BUnW2g==@vger.kernel.org
X-Gm-Message-State: AFuF++lHYeS7oKgAfpp6apykGBG8QpeepHbowwKJA6LNDFRNgn71/Wbm
	/F3wlUtyqsoRWNYXCsOSyYeLitQ2+C7HEFub4Xm7eKeDEK2NG+HCBDN5fT92pmS77/EznsUZ2n7
	corZ5k5eMmxvpV/4s6yD2gCSdzyj/4XddLxxwhnPZOTNt1V+VSbyj6GY97h0AwQ==
X-Gm-Gg: AR+sD10q/8P93q2efRmBOxx794yuyG8LBTW267XHwFaYIlfceZroJ6rHMH24GGi0wwL
	msXCqhR5FTWh1/vyupcIDt9p90/nwzIrIeEFeUPHsLX8fX8htVjmf63sjvkPpQ/ZBP0hcPnf58w
	+NDOwuenB6S2UAkWplcMVedTSi++wQu5tzM3cJssB8cIGfLYFh6kmE05tobhj29Fkb/PfIkicCZ
	tlYLRQlde4MqxnezeBOmusX/RJr9LRd5Y3qdUin9L+ZUcfY6oITJZvCAW0N9tIdyEWyqLgkYTMq
	CW48DyK8G5ovURMj/BN0BWsQphJMhb6f86pXYpbUk2QKsHs6R9Kail4Lzl0Yd0HoqpKwjzRpKch
	zN9fbf0Be4cshmgsD+/j5hkztKsePCrw=
X-Received: by 2002:a05:6a00:1ca8:b0:84c:1cd2:142b with SMTP id d2e1a72fcca58-8523c8f0862mr9113634b3a.9.1787645971592;
        Tue, 25 Aug 2026 01:19:31 -0700 (PDT)
X-Received: by 2002:a05:6a00:1ca8:b0:84c:1cd2:142b with SMTP id d2e1a72fcca58-8523c8f0862mr9113505b3a.9.1787645970964;
        Tue, 25 Aug 2026 01:19:30 -0700 (PDT)
Received: from [10.218.14.97] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8520f161701sm2725924b3a.53.2026.08.25.01.19.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2026 01:19:30 -0700 (PDT)
Message-ID: <956ad5fd-7710-4731-9796-b03dc21cb2a4@oss.qualcomm.com>
Date: Tue, 25 Aug 2026 13:49:23 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] i2c: qcom-geni: Use geni_se_set_rate() for setting
 source clock frequency
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Sudeep Holla <sudeep.holla@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Ulf Hansson <ulfh@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Mark Brown <broonie@kernel.org>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>
Cc: mukesh.savaliya@oss.qualcomm.com, chandana.chiluveru@oss.qualcomm.com,
        arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-i2c@vger.kernel.org
References: <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-0-61171ab1cdce@oss.qualcomm.com>
 <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-7-61171ab1cdce@oss.qualcomm.com>
 <aca6afe7-4659-4359-b5c8-e19390a07f8a@oss.qualcomm.com>
Content-Language: en-US
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
In-Reply-To: <aca6afe7-4659-4359-b5c8-e19390a07f8a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDA3MCBTYWx0ZWRfXwhAOrVuIfvtg
 RY3RV4G2pjUUj0Mru3Wqr5mHiUYEfAt/lytulmbUn87y4DfDVn0OE5aIfm46Fddy1WA6/hO/w2y
 N632MvednsrT8kVJGwdUE0jJ+n45yyVbl0KwbJ0e8Bj0rfSvev4UOt71LDRYGJYvU6gIr1cb4Bo
 pqJFYSRdMU4Lq0WgpvIV4TrIKhiK/NPdNgaenp5xhrDTesmTZRcsA6fUxWJGKBiFKlcCA/QZvfT
 X2dm5L/8BNwUNlcjJNkfouCNZ7fZiuXV8i49PdtcY+/TRyzRUNj0ZRSDgbBBOygx6q0E5mhFEOb
 iUI0Ja4PXXtrCJbuHPD7iVv+MAnMFp8GqDhr8MA6kK6MzowwXfgUtf/OFx7qvwzu+Y/Ud6c/NE2
 AA+gAHpxhxGAYW5tyHURjXERtGvUA8toGaIU8pEnzm4xt8x/stG8G7VQE4iKbAir+US78NkKiKc
 7GRQq07CJgmLkqH3vPQ==
X-Authority-Analysis: v=2.4 cv=aPHAb79m c=1 sm=1 tr=0 ts=6a8d5014 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=QDFqMEhmg62cRBsMz60A:9 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDA3MCBTYWx0ZWRfX76e48Y+CiH/O
 CZDb3teW3Q5hxIQ5coxXrjZCQsW+9CsIqc27flGzYuL4pvFizjxyR1NhYU8EaUkxtjJjBV2ZMzF
 D3xqAvNWVmzrF1IfbJwbqlemPaH5aOc=
X-Proofpoint-ORIG-GUID: uRJ0qjIfPscaOfuBtxQ-RQQaYxijHN7b
X-Proofpoint-GUID: uRJ0qjIfPscaOfuBtxQ-RQQaYxijHN7b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_02,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 adultscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608250070

Hi Konrad,

Thank you for review.

On 24-08-2026 20:36, Konrad Dybcio wrote:
> On 8/4/26 9:57 PM, Praveen Talari wrote:
>> On the SA8255P platform there is no Linux clock handler for the SE source
>> clock; resources are instead managed by firmware via a genpd performance
>> domain. The I2C driver therefore relies on geni_se_set_rate() to apply the
>> fixed 19.2 MHz source clock frequency expected by the SCL divider and
>> counter values programmed by qcom_geni_i2c_conf().
> [...]
>
>> @@ -233,6 +233,10 @@ static int qcom_geni_i2c_conf(struct geni_se *se, unsigned long freq)
>>   				 itr->clk_div, itr->t_high_cnt,
>>   				 itr->t_low_cnt, itr->t_cycle_cnt);
>>   
>> +	ret = geni_se_set_rate(&gi2c->se, 19200000);
>> +	if (ret)
>> +		return ret;
> This wasn't here before and the commit message only says something to the

Yes, it was not there earlier. I have added because of Fast-mode Plus (1 
MHz)

cannot achieve the required timings with the default 19.2 MHz source clock.

A higher source frequency (for example, 32.5 MHz or 37.5 MHz) is required,

along with the associated voltage/performance vote.


Thanks,

Praveen Talari


> amount of "it's necessary" - what's the difference?
>
> Konrad
