Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1D23A4F3B
	for <linux-pm@vger.kernel.org>; Tue, 25 Aug 2026 04:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787630462; cv=none; b=GIP9sbopGR8tIlJrVfrD0h0vc/wWZDO+XhrfA1RHYGJymF2dnpojQ2JXmTSsh3bIggSiD1Cmo+RuOPH/KnqDKSONW33MmlR6MWmWhtDtgEl13qDj7Emcqh46LbRGRJaHdQoZ+r/j4dzRB5ldZLAnkwnMT57DqnO4jLzo3GsC4oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787630462; c=relaxed/simple;
	bh=YWl90OOdVCd9KNVgHHy4ovXFe+CNKeFkWuTjHDRfD6g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=swELOYbSh6mVNITWQm7z3V0gJ+98rNgBl0bjx5Ub/l1P/BiHoqALvvd1Zi7eTeInN5N9Ri9ByX/grzYjn4znbeh8ITsovd2ipk1k/ibTAyuWm8+9bhea8irJb+dsZKuXdn7mWOhTLaeOsc0wai/WdeyUd3w5hHjSOFdTMAfow+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CIKC2iN1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YUzmf28P; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CIKC2iN1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YUzmf28P"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67P40mNs228307
	for <linux-pm@vger.kernel.org>; Tue, 25 Aug 2026 04:01:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	C+XQZtMktBy7ekGjf4/plKpxlv6MDb59qUzxqeoByG0=; b=CIKC2iN1ZReAWWl4
	16vuxGWUUJO4xlufvERdBG5vjw/2gSxGqmXPC3TO7qRE01rxoNS3b0E6F0UWkQ2K
	QckfiY4rR5jXrMqy40XdPryMBVmLBSUaL1UuSGjLWV3KIy/uz/xZtAAgmhlzp45M
	HK6JULyoHkGuMBOxSZabRJxkrGFdjLMMe7TdnLRgD8zBLP2vm4w7v9ancNLyWVLl
	TgxoTUwWMI3dGtzARP2pFInlrRH+smkBhuxm1CGTOAzZXx0kht45IKSJhqTpbV9S
	zVl47i3TaNETzacmw0QpARosk1k2JHFISAAOM+BmBeD6LzEjWK1uqsXsKcydMsBX
	GhzTgg==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g93nar018-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 25 Aug 2026 04:00:59 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-84870e7f498so4327709b3a.3
        for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 21:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787630459; x=1788235259; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C+XQZtMktBy7ekGjf4/plKpxlv6MDb59qUzxqeoByG0=;
        b=YUzmf28PbofztZn+3f0/ELIvx+6cCQcsbwmPEYaPiz6h5VT2Phr665iE0ArPYqKHDO
         w//j1xbT+toYiugC6yEmrZnLVaH4nuRFwAZfmsRlCXYS9hvcgKbszOMK9ZJVUVHWRC84
         QX2nMEX2AMu3R1JKs9aID9ijNMgFuFvuEn4mdNMfp1i7b70HRdzGSzUdzjkeK5FhPCEL
         V9ZBWgGESSVU9tUSgGrsUhy6SoSXtGSNdnKENqhOofkuXYRs52fvi4Dv/zx86nyWAKl9
         S4AsylhRJD8CNh68wLzhEO+hA7loJskQEe5HcGZfTltlXhYb3k8Hiuwp2nWhj4P0vX2P
         l7dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787630459; x=1788235259;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=C+XQZtMktBy7ekGjf4/plKpxlv6MDb59qUzxqeoByG0=;
        b=mxp33x7V1P+Q5xFAPR9a549BNviq2isdxa1is2YX5zon9xYRUjIhc4uRDIYuO+x++7
         aen3Hou26Pd7T+KQubc2uGKge7Yf1SVaVwKXimP197RUN8JtlN51f7UCT5Q5deUV0czY
         sY7LFTEbj6eSYBUkobnInx/rsWWTYeuTDjlPflxh8AGe83/GsIfDD1Yo6DBV/8ScauPi
         r8MsTug/4QEZP9ZOkhmZu150yyTB94uz1Hx7sHabJMOhsQz3V4PYeHVmv/j33dMx3IFy
         5D6Kce2it1WXTj68n45+Gtdb42v9ji8pZtoDmS+4fG3LJXPIy8LUsaA+Ya/lG5ZtjRme
         a++w==
X-Forwarded-Encrypted: i=1; AHgh+RowiPoUqkfE7zD/NC8CsZa4GgU7syEvLy2nH8vPqwSz8zLu5lgVc258tETZkKLw/E9rTvFuPoxWdQ==@vger.kernel.org
X-Gm-Message-State: AFuF++kysCWDixAlDw8gOL3e4dFOJ1ZXmwMpTWaoB2+q2IIK1BTtj8D6
	KIza5gEBFRYu3jiHVCUdozGtY4lSpUk7JylRKt1A6fOa/vsPfaiJUXWTnz0xY4WI7BGc6iYE7Xa
	Tii9fbdbgkBh+c8BRO4FCpT+JGrMybb+hNWYbtdn83Fjj/5jwmFD02iOcZ7rGiQ==
X-Gm-Gg: AR+sD13OGnXnby9lGYbHiMxsFwRJCNBu0VSMHmUx2wUKJexeKeexq4MZ8/xybCysfWU
	ffzBF16AoDzzMgbUmVgbzr7uEzvGXHlq3N8vfdeMwD6vDQj68Evq7khrmibkIyZtQM1d1aicLbM
	LFqXWaiGx++ujJURfN6q+G3diRzhdKTPbTyj9HF4+fRGmh56v48VijN9TtAfLHsdWBKIKNF+W/O
	aNQpNgjQ9Pvt/hBMxD/OiD07zdjULgC/Ao0XmKpbUAz67ULAdmlWBES/ULse4dYtPt7yEMSuR3P
	Om4QXzuvuLGmz5kCcA9OEzrLj5fmpEhVywQR/ozQXXOCuZ+4wZ+s6Bufs+Xp9AjAHNU14oWf31b
	8GIjZ95gui7Ga5SQDj7RFgW+KmzGKEGQ=
X-Received: by 2002:a05:6a00:4c13:b0:851:8bde:7873 with SMTP id d2e1a72fcca58-8520b98be69mr40252187b3a.8.1787630459235;
        Mon, 24 Aug 2026 21:00:59 -0700 (PDT)
X-Received: by 2002:a05:6a00:4c13:b0:851:8bde:7873 with SMTP id d2e1a72fcca58-8520b98be69mr40252038b3a.8.1787630458620;
        Mon, 24 Aug 2026 21:00:58 -0700 (PDT)
Received: from [10.218.14.97] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8520f1638aesm2534359b3a.57.2026.08.24.21.00.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2026 21:00:58 -0700 (PDT)
Message-ID: <17735f83-fd07-4fad-97a3-727cfbeabbcb@oss.qualcomm.com>
Date: Tue, 25 Aug 2026 09:30:50 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] serial: qcom-geni: Use geni_se_set_rate() for source
 clock configuration
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
 <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-4-61171ab1cdce@oss.qualcomm.com>
 <4e0d636a-7975-4711-8070-6f71957b754e@oss.qualcomm.com>
Content-Language: en-US
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
In-Reply-To: <4e0d636a-7975-4711-8070-6f71957b754e@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDAzMSBTYWx0ZWRfX/wZo1AuK/m5I
 CzsrX7E1/MQbvLsNJOHj5CLxZrJUcG3iLnEGTDDz7QyFDjrJqwBRjrhvCqWAT3kwcHypAs55Jbl
 87QPAtldG3f1Zpo2Z/srNHLw7CWlhMo=
X-Proofpoint-ORIG-GUID: UySafPg2LIBW4fk0N4Do1i2bP-JtpTYj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDAzMSBTYWx0ZWRfXxay/CBx5AFjv
 D32xkg74a0j5ru2F/OjuFVfsonBTY9AboyWVvMoEc02rmZbW0Zhjmog41h1yiTRIgjpYVC810Kj
 4x+3/6D+MH6gYqB+kMbm1+ptp9uBOg2CofFsTNqo1yt0AmXX7krQEhVeC9x4wMwObT4kf49kMlE
 MOUtJtHp0vyH7toL6IKuwnAiv+t0JHfjMJLOWChlkUUCDDx0bOp3k8cZxNCTXEdGpofrYdmv6wz
 L91/g5qvhqnZLEAG/DW04+05jyNinpXbICrRbsoYUK49jLkS48QhwB/5AiZveQlsW9yLhX+QlBE
 l4og/YYF9Z6JQB7KGYyFGIo3F0fHPSqUN+5sQvtEfY1PWOJJAW/sLHQCw0Qjl41GuKigDejfsQ4
 25iDFapS2N1HVjM257K3+XkcQZdNFxGH7IalVdnO0Ags+CP4Bp/VVYoFGxSlqd/XAiGvQs762kj
 nDNmucaSNENr3UWjr4Q==
X-Proofpoint-GUID: UySafPg2LIBW4fk0N4Do1i2bP-JtpTYj
X-Authority-Analysis: v=2.4 cv=W74IkxWk c=1 sm=1 tr=0 ts=6a8d137b cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=gztmCChag-4to_nYmxUA:9 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_01,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608250031

HI Konrad,

On 24-08-2026 20:35, Konrad Dybcio wrote:
> On 8/4/26 9:57 PM, Praveen Talari wrote:
>> The driver calls dev_pm_opp_set_rate() directly on uport->dev to apply
>> the computed source clock frequency, and dispatches baud rate handling
>> through a per-variant dev_data->set_rate() callback that either
>> recalculates the clock divider (Linux clock managed path) or selects
>> a performance level via geni_se_set_perf_level() (SA8255P firmware
>> managed path).
> [...]
>
>> +	geni_se_set_rate(&port->se, 0);
> This ends up calling dev_pm_opp_set_rate(0) [i see this is an existing
> bug in geni_se_resources_deactivate()], which removes the power vote,
> but does nothing to the clock (neither set_rate nor disable_unprepare),
> which will crash the platform
>
> Both of these calls (new and existing) should be removed. Clocks will
> be disabled by geni_se_clks_off() in geni_se_resources_deactivate().
>
> Then, we should do dev_pm_set_opp(se->dev, NULL) *after* they are off
> to remove any trailing OPP resources (i.e. icc votes defined in the OPP
> table in our case)
So, if I understand correctly, the expected sequence is:

1. Disable the clocks.

2. Remove the OPP/performance resources.


Thanks,

Praveen Talari

>
> Konrad
