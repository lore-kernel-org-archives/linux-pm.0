Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52C536404D
	for <linux-pm@vger.kernel.org>; Mon, 12 Oct 2026 13:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791812651; cv=none; b=BmLCInjZlll8f0f2oTHw6zuZGSQ86UeDBNzLOWnsd//ZYbfOHblglfcVlC1jgs+w/untxVgYNQlCxsSYMmxDv5m6phAAYKfGDEMdRedHtYCtfaXXSsBqM2Gd6gPB41UFGTJYQecXZFNlNMaKZ+Q9yQP/UoONliQw8gfVtMENnFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791812651; c=relaxed/simple;
	bh=qHnjHk5ujIR9xyBxf0VSVQPElSSwV/cboQAyFOMBTUU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dv2PDEW/D+F5S5SW5R6ap7EFo2tC7DHoc+INPFycifr0XHJ/xv9D2/ahuzL/2MYYkzDIERK8mTXylwrLhXb/AU9VxJlSERtXb37v7nOnQPyXDcWeZOH5iTnCX2hmS8xhrunnHO7Cf/d0BnsIlnHP2qIWXBnpVdXgTpFlxKex1to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QQYfz9qm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=T5PBfX5x; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QQYfz9qm";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="T5PBfX5x"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69CC02663365131
	for <linux-pm@vger.kernel.org>; Mon, 12 Oct 2026 13:44:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UrJ5o/8tqhbtrfkw4GbBGglVzHr2+lr+Pga8Ra4lpB4=; b=QQYfz9qmqRuEHOTF
	hHgLWSVt/mJ2qx6z5Zuor5oKTjphtj6ORKylzDIeyIRYXe4tWaH5jLhT9WW90VH1
	vws9zZI5kuW7z+mOsJ4qNRPpWvoY36m0NTvXkxaiK2l5JYvL24S7n2a4Zb/XwFpy
	tjpanKaKR8X+pRtmesE42GlZeWlHFvtiRry/VLZ7w+p7YhR0yTj4O347h/d3bTOr
	43iM7bOXZfSdt7NJ4iWyKCBZjdnOcMD4i35Q12grLqnOTFD4mYR5NspCtMp6GP9W
	0yidWB57BLhSrynbKIRCEt/BcU+Fk/Nzwf0gxQJsYk6vhyFQoGj3S9yxUYudgVkv
	cbABuQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8wdr8yuw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 12 Oct 2026 13:44:08 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-3548cdfd2fbso3106451eec.1
        for <linux-pm@vger.kernel.org>; Mon, 12 Oct 2026 06:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791812648; x=1792417448; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UrJ5o/8tqhbtrfkw4GbBGglVzHr2+lr+Pga8Ra4lpB4=;
        b=T5PBfX5xVkt0Fx1nB0eDNO4Gwse7XcCfr8K85FVuiqGZ8MSr+UFPlbyb6rATiNTr86
         CUoy5uBeMI7pRo7l0bL22SCWG6XTsD7r4BzFf5ecL4aKjBifptFgIfIr4eu2Wa8xi525
         GnPHcndtokFgps3LVcNtXLkkKmoGdc2/SeYakTRTRoCl9WbU1Y1vCiT9Ufy0fAJXi04T
         IDkRsxkv9H8b7crISwy/Gmd/5VTFXeDIM6HNA633o1zs4omPc7FBoSlsIO4lg7Bkj73L
         DMq7Qb9NxBxVCOK0AgrrWFaT6PPRKrcCkrc0B/rmNisURlTDNlPW+1KluWVy4f1MqEw8
         Lshg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791812648; x=1792417448;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UrJ5o/8tqhbtrfkw4GbBGglVzHr2+lr+Pga8Ra4lpB4=;
        b=RnenLIhNq1FzmtdNcdRTCv2RUtIJ4Pq6yCFUoBXsAWa2X5EAzJXmUnl/GOmaLo2k8a
         /9gTRJ6+yJN5EtAZrbl5S2a/5HheCfbsiKggkr//YIz8HyUWahzcIrVDPT2EXN89TrbT
         pLlt4kAuZpd96GiAD0rfTF0OCvIYDqMi+nnSSAA5Nv+1qwSRj4pZwivfbSrKDuzkwzFv
         Hcq5Qt1KUGEaoYK6cTRDHID7vPG6J/jl/EkWteA/DDz1SqDau44FKxpttRc8RbRkMKY6
         McHnGOnHlDVFhtWcwTPOElkoIyb+wTuy4oAKTl1rRI1/RAcSWA81Dia6cxCmJrlPK9y+
         zrzQ==
X-Forwarded-Encrypted: i=1; AKwUvBzkxgnZJCQqSxhA9ifbIaKWcz/SPhnyVBTVUcrm+isC//yKWnjAeptvvECSo2R8/FkH2/YL0SfPHA==@vger.kernel.org
X-Gm-Message-State: AFq9FYKLalYRgt4qLl2xVqz246zZuNwXgkbpXXX3Od7Ft0hRNLXc+uDo
	DTtLCkg67TI0yKp2sTOBmpJzLpcZB7nPS3S2l3j5Mw/cPmQO4DUsnN2QIW5Xcr2LRaa6BrutP+7
	p9lOXvtrs/bTQL7/jMKv07d+u9vCS35UpsGDaj9viplqlT8rK66M/bagGmGcP8w==
X-Gm-Gg: AYBFou2i0TDpQnfKwWDr6X14BEqRhiNyJythiMmZnP7NtFqVKweHbRDZ0UPfdVvONEG
	pMU6Dv7v5vCDpsX+hnXxj+jMiv7Q8FuwiBIzo2HtOAuyu9cYABFPOopF5hJxR7F+cexNhS++atA
	g8vk0Z7yElFakA0EzbjjtLRDpEMsFU5yZVscc+i4uMKFQt28UvfAdh+BVxjC1OCHXOrjQsAD9Ap
	KlY2jK0Ix5mCQIwD5DFldgEzFfNq09V9R8v5z82VvKGY7vkyKTIM1rMxnAD75iWETVcCrvABkrg
	asF/2PZhbv5oH6bnxllBS141+G7c+e68/zRam+HeA1623a0fgZzFJHCLXUIcljzhbdJLc8/SXVf
	h1cmHYFqTysn23dJ8NnCyD7xN0cmZFIreww==
X-Received: by 2002:a05:7300:ac81:b0:34b:f456:25ce with SMTP id 5a478bee46e88-3537ddd6fb4mr19975688eec.3.1791812648231;
        Mon, 12 Oct 2026 06:44:08 -0700 (PDT)
X-Received: by 2002:a05:7300:ac81:b0:34b:f456:25ce with SMTP id 5a478bee46e88-3537ddd6fb4mr19975450eec.3.1791812645696;
        Mon, 12 Oct 2026 06:44:05 -0700 (PDT)
Received: from [10.92.194.162] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537cb6a279sm33512555eec.30.2026.10.12.06.43.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Oct 2026 06:44:05 -0700 (PDT)
Message-ID: <c5bd025c-d32e-4681-9644-11c4350caf99@oss.qualcomm.com>
Date: Mon, 12 Oct 2026 19:13:51 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v26 00/10] Implement PSCI reboot mode driver for PSCI
 resets
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Andre Draszik <andre.draszik@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, Srinivas Kandagatla <srini@kernel.org>,
        Ulf Hansson <ulf.hansson@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Song Xue <quic_songxue@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        John Stultz
 <john.stultz@linaro.org>,
        Moritz Fischer <moritz.fischer@ettus.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Christian Loehle <christian.loehle@arm.com>,
        Lee Jones <lee@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        Pavan Kondeti
 <pavan.kondeti@oss.qualcomm.com>,
        Abel Vesa <abelvesa@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
        Sudeep Holla
 <sudeep.holla@kernel.org>, Andy Yan <andyshrk@163.com>
References: <20260928-arm-psci-system_reset2-vendor-reboots-v26-0-b24e2348e8e1@oss.qualcomm.com>
Content-Language: en-US
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
In-Reply-To: <20260928-arm-psci-system_reset2-vendor-reboots-v26-0-b24e2348e8e1@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA1NCBTYWx0ZWRfXxgrNKO7ob91W
 x7R4IEXwHROIi42GUf1qK8sFWAaF6qOZJRcl0zE6D3Jvp0LwUWvO5eV3OfzylxBNx7xbdSwphqI
 Fw1Xf8jVFKL9kXaNFp2Tk2Soj/i/1taS4Yv0jBW03+j2lsiVYk+oPYufatcCLq3cg7dzmkDQl2t
 0uLG01Ql8pnxggsym5krUHgcgJQUh8KUyGpUzi8NoX5u2vr9LyiEFib0F2G/k0tWOggko1u4zZY
 P5C6M4N8ha5MGGq9t4EX6yJ9LfzJpGhjv0v2s3H9kkq/ngouK0dU2oDTKu5Hb9oOV2pcp3mY3X2
 /luafPXkXP4i8c6JEwRqkTmQ4RYfV98vRMRRHM6H5Z8zchL/uce2Q/TAPfKXaA6bPLM3HAra7Vj
 jmczTiS5jd8ZyPUXk0X+fGf+S4fD6VrPb7ygs5u7FV4cy1DmIfhHNIuNcNnELY3iPKE+HiiDFXu
 wfeDsfuvo1sRt+2MIDQ==
X-Authority-Analysis: v=2.4 cv=SvAFe/O0 c=1 sm=1 tr=0 ts=6acce428 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=06DCG69OefxHWCB5cYgA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA1NCBTYWx0ZWRfX9dZgLP1Y6mGi
 xyzEUdKQRtJBBDbbK6w5LMdmEquT+ILngrujh6P9ZxxvLq4oC+E5scko7owbovSTGSZdkqOVBgv
 kxrVbxaU4VE31TEICKnhKnWjm10S5rI=
X-Proofpoint-ORIG-GUID: ZnK9oBplaQ_0x5bg5_hOYXncH2k4qs2N
X-Proofpoint-GUID: ZnK9oBplaQ_0x5bg5_hOYXncH2k4qs2N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 clxscore=1015 phishscore=0 bulkscore=0
 priorityscore=1501 adultscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120054



On 9/28/2026 11:39 AM, Shivendra Pratap wrote:
> Userspace should be able to initiate device reboots using the various
> PSCI SYSTEM_RESET and SYSTEM_RESET2 types defined by PSCI spec. This
> patch series introduces psci-reboot-mode driver that will induce
> command-based resets to psci driver for executing the device reset.
> 
> The PSCI system reset calls takes two arguments: reset_type and cookie.
> It defines predefined reset types, such as warm and cold reset, and
> vendor-specific reset types which are SoC vendor specific. To support
> these requirements, the reboot-mode framework is enhanced in two key
> ways:
> 1. Support upto three 32 bit magic values as arguments. This enables to
> support for a 32 bit reset_type and a 64 bit cookie).
> 2. Predefined modes: Add support for predefined reboot modes in the
> framework.
> 
> With these enhancements, the patch series enables:
>   - Arch Warm reset and system reset cold as predefined reboot modes.
>   - Vendor-specific resets, configurable via the SoC-specific device tree.
> 
> Together, these changes allow userspace to trigger all above PSCI resets
> from userspace.
> 
> Note on introducing psci aux devices:
> Based on feedback from Bart, Lee and Ufee, PSCI child functionality now
> uses aux devices instead of an MFD driver, with psci-cpuidle-domain and
> psci-reboot-mode probed through a common PSCI aux device enumerator.
> Reference discussions on this:
> https://lore.kernel.org/all/CAPx+jO9Hi2R_UnCEhsXLwf74c3RTb+RodaJ6SOVXbQX_eHt++A@mail.gmail.com/

Hi Lorenzo,

I am planning to send a minor update to remove some unnecessary headers 
from psci-reboot-mode.c. Could you please take a look and share any 
review comments so I can address them in the next version?

thanks,
Shivendra
