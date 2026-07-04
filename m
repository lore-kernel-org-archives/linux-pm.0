Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0985A2E22B5
	for <linux-pm@vger.kernel.org>; Sat,  4 Jul 2026 06:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783147426; cv=none; b=mbeh5DQiwZ3oLHx4O/GnibIfbV9lhQWcylqRMFzlFHjLJq8G14XJDqPBwIBC6cEPpx+hQhI2DyImaow2eHe9ufadrc3Y7/BQ8frtGglmMueyaBCw+YAafR26BXap0Aqe6IJ0g5+aNj6uK2V7Xb5V+0adfxobQciPCrRoqox5ufU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783147426; c=relaxed/simple;
	bh=7uTOUt5aNOQDveOWaZ2OE0hDnvhxLRTSC4BUj4qeVOk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=skyj9zKWG7rLuutWY4dPjQ/QimLQf7Dp0qPkuWAmUZf91Jew8Rk2wbf/Sxjmnz5da+oJNtGMOpsU5RExXu/rG1uJWfNtlKH/QWsXC/6sJW7tGVN0WT2IknyZQXWV2f/I1X5pSU8LHnFtw0VUjIz9Ct9+dBAmv5eolfdct8iVYHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hz2DIuCX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KvxxDFJk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hz2DIuCX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KvxxDFJk"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6646heew2292892
	for <linux-pm@vger.kernel.org>; Sat, 4 Jul 2026 06:43:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XHcV7kAhtigHBS91AH4yrxaBLXSSv++mF7YkQi6hXOE=; b=hz2DIuCXDtweiogJ
	9FrOmmF6xnSA0abpnJoLk5EkHFSO4Z3RMTO/VQCBWgMjhgRxqAzipmzG4Ypw4lxa
	fk47EmOKcLpGi/ME/7dMtF721Vm3nET+tnJXStFtPeTPzEJ6zqJyrDVhmy0j+Wjh
	6WHPPgZUgQ2HcJ+U9xPnpYK0+xKT3tU8pYKJ7idLmPnVjshnM/tXem19nTrS+ipB
	yL0gw1aDgGTlbuzHSSXXkEgJl8DisoRQo6sltgUywHdbQCiwLYkL6bOSrBeMfAbC
	entTs/8yl4Dj5SzafyI/1R9etZcccXJjnpKlkFXoZ4MWoCTLA6dr5OMy2jrfA5zF
	RpqApg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6td389y7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sat, 04 Jul 2026 06:43:44 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-92e59b0e0f4so95092485a.1
        for <linux-pm@vger.kernel.org>; Fri, 03 Jul 2026 23:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783147423; x=1783752223; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XHcV7kAhtigHBS91AH4yrxaBLXSSv++mF7YkQi6hXOE=;
        b=KvxxDFJkU442eScXL3q9D424QGlhKDLPhRk+PzefSibaos1/adr0FjuHCK2cPtoNEC
         dO/V5vaNeKRyXwspiNpjql/fYKRssN3Xnwasfif9aLaIwIM1d6VsxNq02W+PB9+9+U5s
         FsgD/iY3gDydOdfAqDpmHl7degaTPvoZxvykm7vIS7qs0Nkzt2+Tq/DO5pMDvnNHrXe0
         +q1/vGsn3dyUTxdVYhXQfjJGSabg3WjTYa/6IPHOLRPvsew5d+0BBaha1MTa57QrbaHE
         ad0KhQd9QQByz5bWPJPvt4sWKUiUCVAMnu78ZskTfDeo7wG/pWwCfdLadg92F0Lio0yb
         Yuxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783147423; x=1783752223;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XHcV7kAhtigHBS91AH4yrxaBLXSSv++mF7YkQi6hXOE=;
        b=UuqQpQk52PpmRaLjp+pXoBYPAKU5N1T6F8DNCGJ4odFgYbu7jEYmaWLDuiN7GEut5N
         wVGYU9U9xlkWIFvGj8gWoZVrvNciEKLx7crDVNYYtu4u1eHdNJES8EyWOfp0lGFSzqeQ
         4HZaAKvgcm6FmNu0SgVPwv01pI2extP+057WzTbzDnHuQcKvWm8oY87d8bmMdolaFcxt
         8VSPnYWaEFuXrRdCfX16tErxXIn+WZqf43MWbLjNEntwqgp6RLqH6vMEz2cmcUv2Eyp1
         0yNk2pZCI0cOc9I/rl+o5spIraib3iL9ii+7kY7o2MQzY5Lz6mh0+h0Pz06mYRp2yGJg
         Ic2w==
X-Forwarded-Encrypted: i=1; AFNElJ/VMfFwE6wvVrjm0uyldNHIh/tjPWVeAGvkqkeFB1d75Io0otDrbV0qdebPa/uyllGuqGn/1naRGA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5uwmhYQF/JWEZSnyIuca3gksUGeVFFU+M9JVL2meEWv9pW+7f
	SAc9ol/fIyGfCnMMPEVFDV8TRSFwHOlOVFZdLTke2Lga9BQCDTWRwjM7KTVlLd2OX1nGWodwjsW
	d1XJgmHOzHPbzKd2kqMEJdnOUFUvAyVIBpkDZLH6n/vHQrVcAgdLKCzWxQEsrwg==
X-Gm-Gg: AfdE7cl+uPZu80sqrjYAwE4LM2Hj3HIyXZoH+zPQ0Lzvfivc04Z9dB8nGAMBJHK/Bo9
	DDmK/PFMOKRO2nus9pqXTGVrWZefHcqILiyL0F5moDfgP5GYlk/3nBcrliQF2g+QjHaergu7FqH
	7BYb5lo32nWUzHpWm+gfOm9al2wRMDV8zHntI8ku6x57h7KlnWg/Q1bfDmqeHW/HdSfBpl7PwI5
	1ptRfbkczZOMU0dE+4kG87b4edVUevdhFpjslG25hpPFVLgchwpnk+/iaea3ds5/SQHKXqXIWug
	UTfefiyuvyJFLDdBInr1LiC04EK8QFgsXUlBloHi+GYmhb9xXXDiTbrmZkdBjhph+RCp5YO4hRy
	Q9Iq/ChoLKjgf0Y1DgzEb70GIn0J1754Hpr9w48RpdrHX
X-Received: by 2002:a05:620a:3728:b0:915:675d:a2d with SMTP id af79cd13be357-92e9a4caaf5mr344602185a.51.1783147423277;
        Fri, 03 Jul 2026 23:43:43 -0700 (PDT)
X-Received: by 2002:a05:620a:3728:b0:915:675d:a2d with SMTP id af79cd13be357-92e9a4caaf5mr344599085a.51.1783147422733;
        Fri, 03 Jul 2026 23:43:42 -0700 (PDT)
Received: from [10.111.130.138] ([212.136.9.21])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c12b62f5c41sm377843266b.59.2026.07.03.23.43.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jul 2026 23:43:41 -0700 (PDT)
Message-ID: <4b7fe7e6-2531-4d26-9085-43f40a2ce2e0@oss.qualcomm.com>
Date: Sat, 4 Jul 2026 08:43:39 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: Disallow disabling boot CPU based on config
To: Sudeep Holla <sudeep.holla@kernel.org>,
        Sneh Mankad <sneh.mankad@oss.qualcomm.com>
Cc: Thomas Gleixner <tglx@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Will Deacon <will@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20260703-disable_boot_cpu_offline-v2-1-782d16ff58c3@oss.qualcomm.com>
 <20260703-competent-adaptable-coot-f8daaf@sudeepholla>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <20260703-competent-adaptable-coot-f8daaf@sudeepholla>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA0MDA2MyBTYWx0ZWRfX1QbLruR0nS3Z
 PgYWLo4SJNFnVhEwTawdzDeiRo73havTTZQ7X/a6bqpNXW+nFyU1wLWrO31Z0ahUM57LqoQ0Hff
 cJys1bwFI/tjiSZhkCOOrF6J1VhorXI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA0MDA2MyBTYWx0ZWRfX9lD02ARyI/62
 o/0qqz/iSz3SSBARLvjREiwHwNQfIla2nPQO6GhFoGi+pYlRH9q/KrdMMhoOiyAvGKu1nyaWpgJ
 gWy9xcipZwnM4HfQXIeOHCzg2tX9GHVIsTIn/ZtU7mD2AY4b0ZDBWG8sKzRycdf88komsSmZYgB
 WNZpcbT12cDzCGvdnhV33Z+bbRrNctBi2yiI58VvajvuD92eiCnAmc9+17rySIXmk0NcKTDxfqD
 BOftbgWhXRVvkZJRkIgRNNHYa2nQ0p3gban+ASzIYV8oHZBxbEYvIPcsAM4OmHktg24i6gWU+/e
 2vKowyElYu6t6FfcY7SVd4p7JnOYhXS+2MjQPy63S0FjVUrHB7BBDu+LNCw2ygdaHBdVdJ+x6E+
 FzI7xo5hf7q7ZCf7vMYJ3G7DxFy6G8wCUlgZRJ8rxALc2wumSydAfaDyyBX5eJjuKC+ldwPl54p
 fIS0WEk+xxMaWt+zLfQ==
X-Proofpoint-GUID: qAp8WlpLHZq52Q43Jui0qQ9dy05vddGM
X-Proofpoint-ORIG-GUID: qAp8WlpLHZq52Q43Jui0qQ9dy05vddGM
X-Authority-Analysis: v=2.4 cv=b9GCJNGx c=1 sm=1 tr=0 ts=6a48aba0 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=/bviTfK1dmy+WGcHzWQ0gg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=HAiw8MWB_luJwFoROhsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-04_01,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015
 phishscore=0 malwarescore=0 adultscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607040063


Hi Sudeep,

Le 03/07/2026 à 17:51, Sudeep Holla a écrit :
> (It is always good to cc all PSCI maintainer for any ARM64 CPU
> hotpug/suspend related changes)
> 
> On Fri, Jul 03, 2026 at 04:50:02PM +0530, Sneh Mankad wrote:
>> The Qualcomm SoCs like LeMans, Monaco support suspend to ram which leads
>> the SoC to ACPI S3 similar state where SoC is turned off and DDR is
>> retained. The hardware design on these SoCs forces a constraint to suspend
>> and resume the system on boot CPU / CPU0.
>>
> And you fail to explain why they have that constraint.
> 
> Is it because some secure context is not allowed to migrate ?
> 
> We already have a mechanism for that in place and this hack is not at all
> required.
Do you mean a mechanism for the secure context or for preventing CPU0 ?

Can you clarify ?

