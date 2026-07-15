Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCAB4448CEF
	for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2026 12:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784118771; cv=none; b=ERqfZv+j+SR/AM+c/yzM/5d0bOPDklgJ9cuD5FhoIlJTJXtlHdkq551YtEv1PxLBsPDGKvgewpsfAdNSB3PBclzZUyTlj7dTGKunZtVcpvDdX47rUTzVK5Y5huEQjf++XKlGzxko03WTAOhMTiycfoF7OKvJMb9R4HdYhQNnekM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784118771; c=relaxed/simple;
	bh=l2EDokfVWLOd7EizmjOsTHzq73UGspoJZp1Op+A4qz8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qqIGSZFKTHELquHf+T991Qv3uStoX7WqeWfFVwecFykgD6sSe53EoWc5m28Xau3fHqQnKPWPGZCUfSokIQ3joFQDwxPB1yT0lxJl9uA7qzJxbjF8UKAxRnTolt7tR0jbeX1/B2FBM1NzLR9FH5q0PrgkNKrKFfk4lw4lltW5Nh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GxosF29m; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VLIX6fmt; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GxosF29m";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VLIX6fmt"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66FBcu053629121
	for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2026 12:32:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	x9HbStl/BzF3lZnAuHGCNzOkA2YjZqn3RRATWA0aM4o=; b=GxosF29mlEn1Qxs3
	5o/4d5QBd1KCSGGHzVVtwh+vIQNsBNc0b9irJQ2GNEk6pYiPVwFc1UaDSZdYhOpV
	e4TFe39YMufArtUKFDY++oYcrDu9383doJTOp6RoZRlpdihq9SmOXmG98NJj+XDJ
	sd2kmO2vVublGF4RHrQdUmUJ9qCEwh1PSilkxKhcwH2lo7CPlIhcDb5boumrpJiw
	Iv2UgT++xSoxpOW38J3FjPcwJ2Yy1frdV4Pn2JnRX9HPF50uxlHr/JtnNo9jcrA6
	XCAHpgCRHLsXT2YTwdNxdn+9vN3RXU40hUmiCzwBwFVf6c0/ehP2HkgA12/Boogn
	KH5PFw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fds9kup3b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2026 12:32:48 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38dad28e86eso4715521a91.0
        for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2026 05:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784118768; x=1784723568; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x9HbStl/BzF3lZnAuHGCNzOkA2YjZqn3RRATWA0aM4o=;
        b=VLIX6fmt3Ini0PlxrxMG8fZjHHjYpzJ8zUmiApvb14nUc3M5AmicY6oxwHkAErTUo1
         5ifC6cnffnjj5ogierdN935API1pMIzitHFVcCc4j7lfcB0vK6ba5wzlK5Ee8Fr2CvaP
         PJrjf6nLJd0lt4dbJqoIi3cZRgK03QKHYER/nKoEM+wGsrwKZ1uq4HqImD/tksSV9+/l
         AKgEFDRV0LbrsvNUe1GzoUrQg3ur7/mLhbMaj4v+TUnYhlhbxaD6W+RywEnfny2ic4Hu
         lqeoLB1pe7vSA6LaEw2YGNQQsNJeV4IpWMSQ9ko8hm5i8Dhbu/M+20sLohWSX2KcEGIM
         hm9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784118768; x=1784723568;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x9HbStl/BzF3lZnAuHGCNzOkA2YjZqn3RRATWA0aM4o=;
        b=Z1v7dkB2I6Nt6UnZ+Ac73DBcB2sTUo9NIlhCXAe0YaJSY0VWuIO7xcEO6bW2YSDbO9
         nhivcEmMTPafIfkQGEKha7cCMSjg7qEuOUivCARBaZiuZuhu91XLvZBTxUPYwAQ/yCwo
         8buwW4I6VnC3cTXbyOs+vvd45YO3owlIWYROlXmoPRuw4Jk+szRRsDsF5vDTl2Szq3LQ
         yndGKzYaT0EEnv6REeYfpijgzfiu8Lx16eBnEKioIBSXQkB61VjL/CQQcdETshHWbo2z
         j5+s3bo85k9DWHDH8FW5IkbPHxrn6hnpXTa/zqOOLlA0Y0HIbv3uetQHo1KkJhfnMlYo
         P32Q==
X-Gm-Message-State: AOJu0YzkGl+5KlOz/ifgLd+104ylzasb2Le4R96J1uqkOCWii4aDqUrQ
	Z2CQvEetB+gn3+LD6XL8L+hcLmrYeUWhO3W6fCNg61cR4DeFGWkA0i7cUDG0bu9CZlmBvXd6thK
	eVUqkoUEhMmHt3vSb0UJaQRreRMMnXRUyGhMa/Oi0qqkLG9/QeI33XU0SiEPnSw==
X-Gm-Gg: AfdE7cn2n+NV7rMoBC0k+jMusWQlgT0BeJZ2gwy0wuXnLvYsRp79QTM5P5BrHlIZD4R
	u5du1IhHtPxekCScYMz36OgLX8XLLeqgVhXMO006CcL2ilX+VJLV/6dBxln6zf/0ya5M7JWPEFk
	UrWi5HDaLbNxCs2FuLvkjCDlJ3a7oyJyA0Vi8MObiBvmAzLKP4Sl5GWJeocnYetKlOHwaVMRCK4
	RYVsIT/pR+SE7F4yUvd68jpyooOPCuBIm09nSO7kcZ4dde67tv3kdqrdUKxfmbjkZFEu/CkbEfF
	JDRMNM7fe9OIDaWPALbBoG6jqBdGqSJBFmaVoAaTR1965HqB2bFz0uRARAxiB+MNehFrmps1xgQ
	m5XD/OOgiHj0hDiT4bBUFIpGSdSDVaAJSP3ZrHOCt+HRfbQ==
X-Received: by 2002:a17:90b:3c81:b0:37f:9ce1:cdab with SMTP id 98e67ed59e1d1-38dc776da74mr16463982a91.33.1784118767635;
        Wed, 15 Jul 2026 05:32:47 -0700 (PDT)
X-Received: by 2002:a17:90b:3c81:b0:37f:9ce1:cdab with SMTP id 98e67ed59e1d1-38dc776da74mr16463948a91.33.1784118767258;
        Wed, 15 Jul 2026 05:32:47 -0700 (PDT)
Received: from [10.219.57.229] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3140e5306afsm1515390eec.9.2026.07.15.05.32.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jul 2026 05:32:46 -0700 (PDT)
Message-ID: <5aad793e-2dff-4727-985d-5615a204f309@oss.qualcomm.com>
Date: Wed, 15 Jul 2026 18:02:35 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v23 02/13] power: reset: reboot-mode: Support up to 3
 magic values per mode
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org,
        Florian Fainelli
 <florian.fainelli@broadcom.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Andre Draszik <andre.draszik@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        mfd@lists.linux.dev, Srinivas Kandagatla <srini@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Christian Loehle <christian.loehle@arm.com>,
        Ulf Hansson <ulfh@kernel.org>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Andy Yan <andy.yan@rock-chips.com>,
        Matthias Brugger
 <matthias.bgg@gmail.com>,
        John Stultz <john.stultz@linaro.org>,
        Moritz Fischer <moritz.fischer@ettus.com>,
        Sudeep Holla <sudeep.holla@kernel.org>
References: <20260714-arm-psci-system_reset2-vendor-reboots-v23-0-e7453c548c21@oss.qualcomm.com>
 <20260714-arm-psci-system_reset2-vendor-reboots-v23-2-e7453c548c21@oss.qualcomm.com>
 <CAMRc=McKp4WsOY-EQ21n2wbqCp5V0Lr1Cbub5geEhz-LZvVkZw@mail.gmail.com>
Content-Language: en-US
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
In-Reply-To: <CAMRc=McKp4WsOY-EQ21n2wbqCp5V0Lr1Cbub5geEhz-LZvVkZw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Q63iJY2a c=1 sm=1 tr=0 ts=6a577df0 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=1ebYhdgdrGDEZLiK4_QA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: Phod2fQNvHp7oT0luxXjB66KVVGdbhul
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDEyNSBTYWx0ZWRfX2MHP9TEl2248
 Z30fbeHGWxKjZxULdHp2wza6sCpFmf2r6Xz99XQRuexsHMgv7K80MDFe9QsJe2aovJdnWGLJTnG
 e8RsFJMqZwL5WqhGCNb1GQSAVr6a6gw=
X-Proofpoint-GUID: Phod2fQNvHp7oT0luxXjB66KVVGdbhul
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDEyNSBTYWx0ZWRfXxBdAdGKo64zs
 LxPF+PMMdqMPrmdz36Cs7Pn/VsMvq+CeOFkm/ckNhzO32EKdPTgqP2jH3rnGYHHc2d5meDm0x4r
 3/0/UnbwGx7JM35vKxlfUr86PZ/dC4R3VEP66PdV3s40Imi0fZ1TmemOu0Ie3V8p4wSTr6YMF4J
 Y7U6f6wmbZ1ONUR8c+jRSKYjKjnmiEZBXuSiX7UkuACffjmqcPzDXvlPMoaE3ZZlxeyozAYRmkd
 24dIaCHsptrcqg4OM7f7Ikc0JFO40O9xzZ/vjL/tHfLHvVOIW0287Vcyhgnhh0MA92Vn611dJxd
 T8WXb+9XzwIOYX84/N0f+UVq0PnXJD/x0aRkP9izpLxg4vNGImMtu8zSfMttnMngokQICQjYNn2
 zNRsj5Sdll8N/QsJfainXNt0LcTAXW4xBkfPlA9GE06iAiveb2QAEVnwMcLNu1YizFqE04GGOoQ
 nvyG2BrR+bv99nWlaDQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_02,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0 bulkscore=0
 phishscore=0 impostorscore=0 malwarescore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607150125



On 15-07-2026 17:56, Bartosz Golaszewski wrote:
> On Tue, 14 Jul 2026 19:16:30 +0200, Shivendra Pratap
> <shivendra.pratap@oss.qualcomm.com> said:
>> ARM PSCI vendor-specific resets, require a 32-bit reset_type and a 64-bit
>> cookie as arguments. This cannot be implemented via the reboot-mode
>> framework, which supports a single 32-bit argument as magic value.
>>
>> Extend the reboot-mode framework to support up to three 32-bit arguments
>> as magic, per reboot-mode.
>>
>> Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
>> ---
>>   drivers/power/reset/nvmem-reboot-mode.c  | 10 ++++----
>>   drivers/power/reset/qcom-pon.c           |  8 ++++---
>>   drivers/power/reset/reboot-mode.c        | 41 +++++++++++++++++++++-----------
>>   drivers/power/reset/syscon-reboot-mode.c |  8 ++++---
>>   include/linux/reboot-mode.h              |  4 +++-
> 
> Could we avoid having to modify multiple files here by just providing a new
> function:
> 
>      nvmem_reboot_mode_write_full()
> 
> with the prototype you proposed and making the existing
> nvmem_reboot_mode_write() a thin wrapper around it?

sure. will update it.

thanks,
Shivendra
