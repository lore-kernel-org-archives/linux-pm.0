Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0AA3E1686
	for <linux-pm@vger.kernel.org>; Tue, 25 Aug 2026 08:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787646527; cv=none; b=MpyHtWdsZ4NUlwpVE/6wLc97LBDWKlO0H7W5BeQpgHBkDi/I4bwEY8oBr5eyUcKhk4QqwGifr0CkoX9ogQy8sgIOxg3X8UtYX9Yf0Xr9aok4xXq8kSTCLTayf8WQ0bJJAQGWNHTub1TRdNFjZ0UAvlZIkZgAkYE+VvpQMQiMDzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787646527; c=relaxed/simple;
	bh=M6+Z/n2sPEdxSkumdm4fpxZDeQlqm0ww7+RLX0T8tDo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rSdQNEOboFukwhCo6jw+v7iRbeC/N7B+/0/nyc4l+qG0+vPd8GKmn2Hcx1jtrd3jiRBb4e70M5sAO945Hyt6+FQn/RkjrefRsW7g+bRIVb+Prr9isxFugEC632oUZ9hXUiIgEGyD8U0nHxw3WrOOHepsYepT1Rc5GT/pq/GC6N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hb9oUO/W; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TBXtRCwp; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hb9oUO/W";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TBXtRCwp"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67P88DN61934800
	for <linux-pm@vger.kernel.org>; Tue, 25 Aug 2026 08:28:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bYhkDV0y7XOpWdvVDzgGnrF9K75KOavFDUraFzDkeMs=; b=hb9oUO/W4rgIbipL
	mGFectRAfdZBqpJCcwpB1ofAMp8oW3JaDF/3oGnhjjRjyg2iyuqKO8sZObFeUYzW
	7XE0gnADDbK3HC628p4fbs6euvMI8a5pHQLTHFRdEUTtzDrjSyMl8nZt+7N17gNE
	a6Ag6K4qIJCWKEDkW55cbGE9Bb5mQN0xLyYxDpbZ3+xtMAicAQYhWwoBzYbBAnYd
	oJwJtB4UzeKUTFlm5AVzFHjTPEw4F5dMM/OUaIegUF5KBLFbnNTX6uozastRZTGS
	gnZWV3jfiwK+AQ9Q7JIXqTIyUAS/+mlc7135RIl7S8IhUUXRL+FzM+CQev6emWL5
	r1a6XQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g92jqs5ye-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 25 Aug 2026 08:28:44 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51c07313be5so10608021cf.2
        for <linux-pm@vger.kernel.org>; Tue, 25 Aug 2026 01:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787646524; x=1788251324; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bYhkDV0y7XOpWdvVDzgGnrF9K75KOavFDUraFzDkeMs=;
        b=TBXtRCwpxmXRRev1Olbv/b/EPCsWPpbXDp82LD2cKU6aQD0fqrI2EsJ/dCLYiOu0am
         Ly+mxDvjYbEYJQzHhrVYwc2pr4wRi94Der/PHL1DahPMHN2BYKk9hft+FN/vapI88avV
         iYktJ5PT7XLqWQ5Ce1nVqjk+33mkwhDUx0rUJdyw1fZAEpJ6aZvsWKJrN9mhfRra3cvL
         NLZKN6FuSig3cPw3f0rpldS18vyoXpxOBXUV4Mvav0hIjHsxaUWoeSQe9pIUBrzPRJgU
         XuhVvRJBzVAGbTxoBB8ub9Q0SH7pNOdggjfYISndd0s4h4ZknlVkiDaVG95pUE1NPxEV
         4vcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787646524; x=1788251324;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bYhkDV0y7XOpWdvVDzgGnrF9K75KOavFDUraFzDkeMs=;
        b=ly2nczTDBPdTsdvhyzOsiqs8iu7XYcP9JgOdpGzXRnyvhfggLZjAJtLxf8KXEjCFgi
         HyQ91vm5G0WcVKpPhqlTkHBHduvQpuA8h7Z2Cn9m3+AoBD5dbRnAXvVR5AZVqSClvX1Q
         CQRxLLqRpbfroJokDJ6otduju8geEnWHYJL6Yg1eZcjtYaDnRy6KuSfZEmy2astJKAms
         XsZaBWFhEcZTpz8SOCGcZjpWmm/h213OypyrpeUmnW65kpDyO2kcG4Ezw1BYJEOri3Jj
         oxIcS0cxcBSPNt/Glik2i2dprV7dblFOkQwbjaDK0WFFvOIneVSIJclxHmJa2Qr/rOy/
         KqPA==
X-Forwarded-Encrypted: i=1; AHgh+RrPwPSSDYf+8wr7zefReeTJjuoasH4a+Kg9DmyIlRJAZCWcFZ2SjyzWAmbfLKnXwRS/VXuYqX6FpA==@vger.kernel.org
X-Gm-Message-State: AFuF++m18OYlRBKtojCTHM0Ht2OK1d4BXzmik2MYx9xTXs5G8wsnXeD9
	MzF6nXt70ZtzgRh3OuXRE4MR5XoTeTWvEbSz9WSJgkkjNTfB1n8MRoeOprWhpHATKm2qN0oel5O
	DJPavsoRV0ryLFZImX8g/jDm5bSpdTm4hObwt0IOGX9BDqlptQH76UodVYOrxwA==
X-Gm-Gg: AR+sD12vhS68WtK7upiS5S0TxSzgAdw0//f3oVqINXietuZOT82xlg5hOUWgRkDE1FC
	4Sxjh6jXSWfW/tWVlAJjBgYUImlGS64SOxCnFHqWgnSs/8/4mSouDsCssZc2K27XmdIlNBYzoaP
	WJzL0ucQJIxL2K/J+5gC8Tei8UzzqIShzLP7Lt+obyF2g7HrqiDEVc+B7+MHXhMUPINEx+pgZ+K
	yk+XFGuxuTpcbyIJmIpmUY5asqXt0au3NoG+BQAHZsv9Ux8htPWCK7NxHh3FsTqlyOzG8N8+iV+
	5QymKm76xQe7j08c00S6ivZ2TJeSnqQDZs2/O/5MNiJcEU+rsZJ/KdVrwfAnw1MuTsOevV3NedW
	qw4F0twLIpARvXNBzl5qI3wEn
X-Received: by 2002:ac8:5f50:0:b0:51b:f40b:2faf with SMTP id d75a77b69052e-52df5a35311mr225835471cf.4.1787646523837;
        Tue, 25 Aug 2026 01:28:43 -0700 (PDT)
X-Received: by 2002:ac8:5f50:0:b0:51b:f40b:2faf with SMTP id d75a77b69052e-52df5a35311mr225835341cf.4.1787646523448;
        Tue, 25 Aug 2026 01:28:43 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c249629a901sm1820302366b.25.2026.08.25.01.28.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2026 01:28:42 -0700 (PDT)
Message-ID: <8d8f7742-fd4a-4605-a9b1-153ace9e14a4@oss.qualcomm.com>
Date: Tue, 25 Aug 2026 10:28:41 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] serial: qcom-geni: Use geni_se_set_rate() for source
 clock configuration
To: Praveen Talari <praveen.talari@oss.qualcomm.com>,
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
 <17735f83-fd07-4fad-97a3-727cfbeabbcb@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <17735f83-fd07-4fad-97a3-727cfbeabbcb@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: -Gl-9crUBhrRPafWond2sXANXU5FPzxI
X-Proofpoint-ORIG-GUID: -Gl-9crUBhrRPafWond2sXANXU5FPzxI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDA3MSBTYWx0ZWRfX1e00V60DITcB
 pDVx/RsX5/5P1iJTnfu/ZWRfEeMZeCXvBTQTjYnrLlGMp2yGTezmmb4ORpzB2uHncjghVnCHXRA
 tUboLPIVTDUkQ+O9sfX6FUMxnkPnYU5ofxJrySZlrx+7c5BWlTMBpe5tptw8KAg4awuz7ks0X7c
 qqoSx2sqwZ50z6YK8n+F6zXLGzMqZKGZxRDFoqij0gDAK4MYkw1fpFNsM5ARD8Bxyxj9eJxZHZU
 UqklW+0XwFAaYeFUsoOPOQheA1VMX/ve1ZPg68rI+79v3KHO97n1LcAUK2ET0fqz3rNBY9TzftS
 gIFqDpLkQXSiYcVMJPDxv63eOv2QMKxd83fT4muaTDJUffn8IK/SrNoD7PtKC0t3j3Jgy0kcymq
 JwZBQGMTEB9/UdF47Hog9kxsUOlLgmMmUXySxc9XHqtXSIw52fHYG2vSFWYESwYQ2qjXi0DewyJ
 CytWhxepjOn7/p/BuYg==
X-Authority-Analysis: v=2.4 cv=JJULdcKb c=1 sm=1 tr=0 ts=6a8d523c cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=CZKBZ6wm4gaK5Uy4Yf8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDA3MSBTYWx0ZWRfX3XnwRcwsjOv4
 O6AfLOKafjobbWWBx9QdgZHbRFS2NgzKoTpcOqjs3oLG8ihT1dIdwJAmStelxOi9uNj/CLZ0EYI
 zK2DDTXkg6xGbJYRngocL9qBiHtekio=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_02,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 suspectscore=0 impostorscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608250071

On 8/25/26 6:00 AM, Praveen Talari wrote:
> HI Konrad,
> 
> On 24-08-2026 20:35, Konrad Dybcio wrote:
>> On 8/4/26 9:57 PM, Praveen Talari wrote:
>>> The driver calls dev_pm_opp_set_rate() directly on uport->dev to apply
>>> the computed source clock frequency, and dispatches baud rate handling
>>> through a per-variant dev_data->set_rate() callback that either
>>> recalculates the clock divider (Linux clock managed path) or selects
>>> a performance level via geni_se_set_perf_level() (SA8255P firmware
>>> managed path).
>> [...]
>>
>>> +    geni_se_set_rate(&port->se, 0);
>> This ends up calling dev_pm_opp_set_rate(0) [i see this is an existing
>> bug in geni_se_resources_deactivate()], which removes the power vote,
>> but does nothing to the clock (neither set_rate nor disable_unprepare),
>> which will crash the platform
>>
>> Both of these calls (new and existing) should be removed. Clocks will
>> be disabled by geni_se_clks_off() in geni_se_resources_deactivate().
>>
>> Then, we should do dev_pm_set_opp(se->dev, NULL) *after* they are off
>> to remove any trailing OPP resources (i.e. icc votes defined in the OPP
>> table in our case)
> So, if I understand correctly, the expected sequence is:
> 
> 1. Disable the clocks.
> 
> 2. Remove the OPP/performance resources.

Yes, otherwise there is no guarantee that the clocks have sufficient
power for a given rate

Konrad
