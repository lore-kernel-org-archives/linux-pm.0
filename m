Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D38142315C
	for <linux-pm@vger.kernel.org>; Tue, 30 Jun 2026 14:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782828980; cv=none; b=IAuGHKI0lh8S8hAWpZqT/X0R8gRr62+t0d/coQf5HXqt5n4uM3xyBmI9M9mKPqFGZvwcAQW8vVGRtSYG+hz3WaE08pOLLlndZn3tDGCOrFR6SnBbwhYPJzHh5bJpPlvcT9UUeWB1rEH4DhPiShXlAt65SalUj/GELQj42cWXjyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782828980; c=relaxed/simple;
	bh=BIhbtLTCuL/PsbBo7bkGtYH7eIpUplVqs0upazLRnDE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FTFhtOZ8dCkUBrRwn2efwXTMV8Zfqi+R4LzxNe/BpNU1yPRL9pOPFu8QWIwhpwDI3+xGC5XIyMOSHWoxEZwamqTX9CD1LXUP2Xwu0HXfjfCJ5deNnbwCqwFPoYhaM9gBZlg7RTPxWYgFNa3A1x+EjiTksMu11ACFU74lUZhvqFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jAjhfMZ6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FFzFYvZG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jAjhfMZ6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FFzFYvZG"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65UEDFq42216759
	for <linux-pm@vger.kernel.org>; Tue, 30 Jun 2026 14:16:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JStmruWEm2i+T8q7mcjNz5amoIiti9X5qtUv4Cl3j4U=; b=jAjhfMZ6op01ueNr
	Vs893PlDvIYcGfDo9Dx2HeGWGX874Sjg+pnUnFP1Ej/neiC9xlWR5St3KxTqP+eh
	1naV+eNK3eI2Y9x7Dw+J9KooUsZzw/EfL80xUzOnTGxa/lbAeaQcWfoHsLwDk+lA
	9LVjMhjaoeaYwkO1M3GAxyLYGZrIRnixp1/ei1243owW5Vw0RJA0SpftKOVLYHPU
	f7OwymOBMfESYc0sBH/jshFHpTZRFY9aWPjCsBMWAu/qhaiF0ortD6sytqiCh7nL
	sJLFYooJ7ublkfjcOh55hAlT2LpMBtMJ98G3VbGPokHncKuyIauyd2Ol6SXLnrIq
	Gkhrdw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f43vfk3j8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 30 Jun 2026 14:16:18 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-92e5e21552dso36809085a.0
        for <linux-pm@vger.kernel.org>; Tue, 30 Jun 2026 07:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782828977; x=1783433777; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JStmruWEm2i+T8q7mcjNz5amoIiti9X5qtUv4Cl3j4U=;
        b=FFzFYvZG3aCtZbVd5MLv2lTajT0AuwjmXfyt92tlFgOLh9a7NATXtzQ7pmaxeTZwue
         hVFZH15FdntdWLwVwtfzCrwUptTk/DeCM3krSl+rn4RYgJQJcD7Vvjm/pkCExIj1hP8Y
         XVxDHjYFdR+JFTHVY/aWcEne7VpjhIwVWPw9T/zEqrWvesQFTsGdqQmnd3AwGDSxXYqk
         gjusNkXKNtB9ioP6bnw0USzDkWPuLcKBE1Q90fJVIDKIqt6cNJFp4bTtAJ4DkHZxxhKn
         uEI0gPlhTWYsBBOg7ThxreRYZuYBrv/uIsP4GmhByBh/l4eQ+ItSYaGyHff3xzqTWOb7
         h9pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782828977; x=1783433777;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JStmruWEm2i+T8q7mcjNz5amoIiti9X5qtUv4Cl3j4U=;
        b=g1RUizswYY+/v92wAxd693JzbRFdbH2JO0YF724QtSPxAOSKuDNtlXTWezG6htgXix
         7eVbJpX1srDVRRWEeuW6xyAqaoI0ORG4rnddGDFwYVoLK+e1AwssJDgbLsjaZ04AI+YU
         R18x8L/cj53TtOjiPIekn7PjdLlcvmfZqi2IViRzKHs3EROncBa8AdyjINSo8UaA5k1J
         jh+Sd5752i3K7SE+v01ohrZ9jkjpwcSEzzcSBbduAFlIbFmxI5K0AjHfq0uptYFOMBUf
         7rUeWTyoPRygih5WANO7DDnU+isOvOxVe88GTfyTGZpuaePu1+DcXVoUxHy/jdFLi1kE
         M47Q==
X-Forwarded-Encrypted: i=1; AFNElJ/NJDEnlpLtuBHXPyNQ2mcLqXV+/IoEvvfr5+Sgl3oV4cClpgbbaMODxzHwxA+QG2SBkJ6A9iN1ow==@vger.kernel.org
X-Gm-Message-State: AOJu0YzXfz34WGHqGknrnYyTQTL3BKIs7L5zP7a3y5FfLURwP6FoAOC6
	+DmBCePkqsqoCRHWJtys1ALiCVn46VHxKuDX7RpPMI0s90i83ZlOAYAIXHPRNHAy6IGtLncl/Xk
	0xcoK8f1bqQmuLYHQ0P9u4kjaZSPtH3Q2TfIkEX7/wG57m26lQC6J8aDlAdPFtA==
X-Gm-Gg: AfdE7cmXDB6CWWy2uYDxsCJ0z3Cp7MWSsZfd5FgzN14rV9N80qJVtKhiK1Kthitvfej
	MUXZG4FMFLQmqT9VxTAei8TV0sPZMjJuDGeLWrMyWNNqdmzIIeFGMrPiJP0HV8u2AZBGs4A36EM
	4hl1cVENeVXLYiuBQ5y+fiZpTOVrIzreq8uzsqUiJQLP5UHpR2Xd9yaeZVLS418GHTjXIxgAaOy
	hPGDS/VKD2+UQvG8MP9UxJTlvTAn8WRWfnInqpkFTBOYFMVYET+1OgByzJyYMcMnoxfcnoGJeUs
	akF9xB64wlqKZCrH+jBNzc3JmX5EisOogVWSRWuhtQmjDBTvWD1CrZhy7G39SThFirjs2eCTTv4
	VjKoK4EgnCjhhjOrIoCoSgMXd3Pg8ofmrfd0=
X-Received: by 2002:a05:620a:371b:b0:92a:d10e:bde3 with SMTP id af79cd13be357-92e62829870mr353026585a.3.1782828977415;
        Tue, 30 Jun 2026 07:16:17 -0700 (PDT)
X-Received: by 2002:a05:620a:371b:b0:92a:d10e:bde3 with SMTP id af79cd13be357-92e62829870mr353021485a.3.1782828976841;
        Tue, 30 Jun 2026 07:16:16 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1288d6b068sm138860266b.25.2026.06.30.07.16.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2026 07:16:15 -0700 (PDT)
Message-ID: <d4001407-cdb0-48ee-a138-87c94b5dab01@oss.qualcomm.com>
Date: Tue, 30 Jun 2026 16:16:13 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] qcom_battmgr: Add batteryless DC-adapter MAINS
 support
To: Bjorn Andersson <andersson@kernel.org>,
        Rakesh Kota <rakesh.kota@oss.qualcomm.com>
Cc: Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, jishnu.prakash@oss.qualcomm.com,
        kamal.wadhwa@oss.qualcomm.com
References: <20260518-add_dc_in_support-v1-0-31fbaa329879@oss.qualcomm.com>
 <56a54a34-1040-44ae-92e2-ce65a3d3acb5@oss.qualcomm.com>
 <20260519065938.4i5wot72pfxy4m3d@hu-kotarake-hyd.qualcomm.com>
 <ag-NLvh4ROgTCs_L@baldur>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <ag-NLvh4ROgTCs_L@baldur>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: _UsaGXmGj8tm0UnTekn0SfaVCbkKj8F8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDEzMyBTYWx0ZWRfXzXo0ans0eJJo
 6lclHv+q/Xm/4sRzgS76ENdxffIClnevZ+/Ca70ZO2/oRqsCOeyNH56I4DEgdIlTxAMG420aVvR
 q+8Xpg8VSjnLvtDTn2ZKkIX3zyH33G0zb68oCQLegWX2zB+7Z7PGPJTpJMTA01ZeuEcuARRUSKI
 2rLclL4cP1NxoP0xB5vTOSYyczVAEIuYeCbGigiu/vMqYYqlMfHQewK8ZcW2OEc2bhqlre83AMC
 +TC1Dr3p9dI/o6BvY6jWlOkGhDCr+5eYh2uFbmSLZh1EElCIDd35DWHkWNi8tWrC3a2nAGWtRmN
 terwTI0iJ9gdumfYbS3h4fIYq4Uz31O48ikexcPOvhE8yAunpM/AWuD3rfVYDtjG3W/uGh7SFSi
 wJJulNZVtSO4jBw0en/odPpB1nGE1K/lLKtYkpFd7TWSpf7JzOCo09/gOImyG0kLaU75QxD7Rqb
 2CE27M4zZJziBzCNTVg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDEzMyBTYWx0ZWRfX8wZcHjDA2ae1
 NSSybdaTSOoqOUCxscH8J0Mq29YdepxUgm8ZSANK+ndONbUCowA7x22S2xS0JlJlAHO5wcixku+
 qGGR/Oixzs3Ic1F0PPDczsqBkrH5COU=
X-Proofpoint-GUID: _UsaGXmGj8tm0UnTekn0SfaVCbkKj8F8
X-Authority-Analysis: v=2.4 cv=PcXPQChd c=1 sm=1 tr=0 ts=6a43cfb2 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=v7J6KcBBf8EwAPocaPwA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_04,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 clxscore=1015 impostorscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606300133

On 5/22/26 12:56 AM, Bjorn Andersson wrote:
> On Tue, May 19, 2026 at 12:29:38PM +0530, Rakesh Kota wrote:
>> On Mon, May 18, 2026 at 04:36:32PM +0200, Konrad Dybcio wrote:
>>> On 5/18/26 3:49 PM, Rakesh Kota wrote:
>>>> On batteryless boards powered by 12V DC adapters, registering the
>>>> power supply as BATTERY causes userspace to incorrectly trigger
>>>> battery power-saving sequences.
>>>
>>> Does battman really offer no way of differentiating whether a battery
>>> is *actually* present in such cases?
>>>
>>> What boards are affected?
>>>
>> Currently, batteryless support is only implemented for the
>> qcs6490-rb3gen2(Kodiak) board.
>>
> 
> What do you mean?
> 
> Are you saying that the pmic_glink firmware in Kodiak has a one-off hack
> that no other implementation of this firmware has?
> 
> My Lenovo IdeaCentre (hamoa) doesn't have battery, what should I do now?

I was going through my inbox.
This remains unanswered, and I don't see the discussion progressing
without resolving this.

Konrad
