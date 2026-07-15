Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656012EEE80
	for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2026 13:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784122877; cv=none; b=d9/50RZG+70EuNjXaJOZ7Lvc9kykfNZuHkVOvgunQYvbvY9+m95RCNGB3jEy4BgCET3z7u8wDw7tb9sSyvLvxQllNIcBBtiRKiOi6ooLMG59pt6/lvClV8dORf9oMcKQbeI3uZAfPV1fO9z8v9FkZrhv+Ryx2SSW0nh2FJDosYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784122877; c=relaxed/simple;
	bh=pz2SYwnFXEo45x3poxgyvBRBbqKCYUxUb17sAp4CMLU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UZxX8siSH2tlcF40ZK5od3m+5fcD59DkflOCWFJkZceK7StbLy+09Y5NZfpb8ru9hTuo14Avf4euCOMVL6yopNciyTqUPhrmIyOlpeB8zjXvavfS8y3waec1NvfgMszg63AXQUsIri7cdA5ma+UuQL8Zmf7jnTpgK74ZdRc+5iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aY+PmiaR; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FMQCdYYS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aY+PmiaR";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FMQCdYYS"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66FDIL3A3854595
	for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2026 13:41:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pz2SYwnFXEo45x3poxgyvBRBbqKCYUxUb17sAp4CMLU=; b=aY+PmiaRg48/HlSe
	vRnBgSuzHMhSstyNa8a/9mrzriUVMu+7ckJvNBKVeZMoppt64ss9KhWTesJPe9Ur
	Qrkm1F580Zqe5AHf47PbGDjrAr16DJC3M0uTSSw8wpjCr5uteZemAYFTOyMvxZK9
	1f4C8zsyQx7i+mV8GVwBmI/dBYnvO9laS7zMMng9v+LF+hgtLhexOP8EVkfBj5bC
	KmVbqQnVyciR1ACCgYhd2K2U5T75ZgrNDY0zbgudulXPhDjWsv/1urnOCRoCzGNS
	FwIhohpIrcDI2qLby7C3O4pUOf+OMdW2htV2w+WQwqkDgFWSoZL+MLEicfNPK2l/
	nS4llg==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4feayfg33s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2026 13:41:14 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-8ee2847cbd4so82494746d6.3
        for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2026 06:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784122873; x=1784727673; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pz2SYwnFXEo45x3poxgyvBRBbqKCYUxUb17sAp4CMLU=;
        b=FMQCdYYSsfwdeYn0jSEUzGAY8wNJgrQWTzp1fBhEnpa/ai6QONcmIszZEu3AGyfgNJ
         FyQI3DCya7r1OUY/s+HfUq8+YceO6KH1U+/9f+8JcogoO7+bTydCI+n1atdUyQm47isp
         9Tv6x4FhM/Crz0HkzeR7d1gOb/uMs/oC8Azq0112aBvaHsPZZ3AfiBJIskBjHSH7xwt4
         Jf7Z/yeVUFN7JsGJI4iME9CCadkHMUMOMdgC9/7BKT47q6gFzwNW3xezcsrcDOCLvaPq
         /Kz5YJ+IPFY267M54huJjFSX1IwadLz8itpKNnoaF0kwkxirNfrfxrqmGR/9tzGv62HP
         TUow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784122873; x=1784727673;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pz2SYwnFXEo45x3poxgyvBRBbqKCYUxUb17sAp4CMLU=;
        b=UabEeaejlvGQQSBAANdg86e5vVHKhDzlWMzSX5+kwCf7dULtmYE2tRr+xRjSA2NaY9
         9FW4eDnKPMb6bNQ7qeXw33WPXnC+K3V0owO5R/41c/0IFdlQZSGw1HQNgVWDxxaRlu8l
         rrxnMVW0h57QVrOOleW0ZyP0F3ClXwfAZ4J5NcsYz6yQNNEY+prEYDrq7xH14riASg39
         1VEeZ0M9q1DBLjnWQtggjYE9ENi1GzyAI4C6+MpN0F4e2AY2Hc/2w21dJmv2gLugWBAr
         K3LfxiTrzbiBYtOrXUCjsO5Kru/wnm3Q56XYBR3xxSnaqDqiKOOV8AccJn9eO2XCfAxu
         TahA==
X-Forwarded-Encrypted: i=1; AHgh+Rqdev6T8d9W13GEosEaPnk5UgXJKgI9ZPQya2vZCDiYvF78r7ym2QMX0opaFhWLHgNyBpeN8YXT1Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzYTxCAreNRI8Yuu2Pxcr1tBtXp/bA3wkUP/zEj9mqgP/Cs7wIW
	dckCQjmt7IuSwXzG9/dxUz2k4yuraUITdjbSdnbSSCjA3ern9R5X1K0XWsoCyyP+3t0NaJf1djJ
	Ez5PE2Vnt3NkND6uVBNycAEUshCaWrVvbUNo6gioF37ASdvc22UHd0vlt7GpLQQ==
X-Gm-Gg: AfdE7cklNMVOvXVj2OPpsLnqlDsMpIS4pqElj9LTnET8DglhwNlUwXSL6fbjBqVNIcl
	waarwYkkokGWrjV5DgDDqwOYfxiV2cPVo6SMGwS+ItWR3cAJddQZBCsxQnMhGun60xLnPsArqSF
	d0qB6O84G+kW3puvR/+5BPj51XRdt++GHkbTxoN8qN/gMF4A1vLq7RvtkySqpLJ2JTrVUpR8ZDd
	aHCzICWnXdD6Ua/o6xUZxfvBuITJD9I5eGb7xSUDiWSsqWxgXPesUyZCB/kGDwUpVRD8sm1vVvd
	Iw4p08hevEyCWYErB60l4QASdkiBneXckfWyZIXpt4CDrttysXtvLF9KESrnghf070V7vLdVdfE
	bBtGJGY55QM0RYF80GXCIvFmtNB72Qk+PoGZgGg==
X-Received: by 2002:a05:6214:488f:b0:902:be55:9f2 with SMTP id 6a1803df08f44-9074c826a7emr78194916d6.32.1784122873621;
        Wed, 15 Jul 2026 06:41:13 -0700 (PDT)
X-Received: by 2002:a05:6214:488f:b0:902:be55:9f2 with SMTP id 6a1803df08f44-9074c826a7emr78194556d6.32.1784122873043;
        Wed, 15 Jul 2026 06:41:13 -0700 (PDT)
Received: from [10.218.18.44] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd87c9500sm193023346d6.46.2026.07.15.06.41.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jul 2026 06:41:12 -0700 (PDT)
Message-ID: <4f641f13-a278-4465-8033-670c7279a7e3@oss.qualcomm.com>
Date: Wed, 15 Jul 2026 19:11:01 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 11/11] arm64: dts: qcom: shikra: Add
 gpio-reserved-ranges to tlmm
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Anurag Pateriya <apateriy@qti.qualcomm.com>
References: <20260702-shikra-dt-m1-v5-0-f911ac92720c@oss.qualcomm.com>
 <20260702-shikra-dt-m1-v5-11-f911ac92720c@oss.qualcomm.com>
 <9c1aab59-14b2-4811-b778-8e96645bd65b@oss.qualcomm.com>
 <97b205e8-5ab7-4205-b1dc-cbcb0497987d@oss.qualcomm.com>
 <986da1da-db2e-4d4a-b9d0-70482adaf4bd@oss.qualcomm.com>
Content-Language: en-US
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
In-Reply-To: <986da1da-db2e-4d4a-b9d0-70482adaf4bd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: orNoV9SE8gSJMIQl4tVxhiGjPlJqbvlo
X-Authority-Analysis: v=2.4 cv=WoMb99fv c=1 sm=1 tr=0 ts=6a578dfa cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=29Tt0ABisfwxuJ5Aca0A:9 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDEzNiBTYWx0ZWRfX5y7AUq2xHDu3
 rDtn0+YjYdg5LQAnasP4szEvttjgHkyS6E5XI5vQcaczm6OJQ4ftf/PlQMIgi+sm/dmdO/Q1md/
 wX9OLFVYx5cV5yi4YgG45PBgBxiu1xz8OLSqBNM67TrUdSJG/sq7oCqrm5e0A9O4HaDVJ7GkmLJ
 d6+9J18ge+AlQOgh114kznDrOBSnU6VoS+p1ay9r/W6rfvbcqoiuoqcLCh4+9zttT7eFJfoxVQ9
 m/AHn+Thq+5LXSmwMSVFWBV4aHcdSArQBKT9aJQHUuV22b6cq5Tr4x5EmR9NYNzu+BoUOrzzvGp
 9IuBDWFl7E0tlCK4EIKzKYTZAXmE5jp4lnaOYLO9oxRrC877e7c/0vRTTp6hPnEd6qaFtuKzpcO
 H81rbo0LNEJhO+9+fvuyCDS2otr7RJ9wiqyoZ7YJ7dJh+9gNmvQGaF/KnHV5DXvgE1W9KnbGcLF
 0Nu+nI57JH7Hh8ifygQ==
X-Proofpoint-ORIG-GUID: orNoV9SE8gSJMIQl4tVxhiGjPlJqbvlo
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDEzNiBTYWx0ZWRfX8didyU2sMybf
 nou5KPeXMuK+EElLSPthnBCFhN6BKBfI+3ZfokXrIULJ2cLA+Pe6cpdmXOtOVRNqtTHWDCXA6M0
 LUs3gPApAycVvUSnj+qbxYFVttQHFJs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_02,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607150136




On 7/15/2026 3:57 PM, Konrad Dybcio wrote:
> On 7/7/26 6:36 PM, Komal Bajaj wrote:
>> On 7/2/2026 4:25 PM, Konrad Dybcio wrote:
>>> On 7/2/26 11:50 AM, Komal Bajaj wrote:
>>>> Add gpio-reserved-ranges property to the tlmm node for all three
>>>> Shikra EVK variants (CQM, CQS, IQS) to mark GPIOs used by the
>>>> SoC internally and not available for general use.
>>> These are generally added to prevent non-secure access upon TLMM
>>> probe, i.e. the board won't boot if some of them are not protected.
>>>
>>> I assume the proposed set contains both ones that are _absolutely
>>> forbidden_ for Linux to touch, but also ones that are dedicated to
>>> some specific purpose that Linux _shouldn't_ touch.
>> Yes, some GPIOs are reserved for secure-world use and are therefore not accessible from the non-secure world.
>> I will update the commit message accordingly.
> I'm not sure how to read your response. In other words - is this
> patch boot-critical?

Yes, with Access Policy enabled, it becomes boot-critical.

Thanks
Komal
