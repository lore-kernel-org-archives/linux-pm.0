Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FBA36DA1A
	for <linux-pm@vger.kernel.org>; Mon, 29 Jun 2026 11:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782731671; cv=none; b=qt81dDXDw9+QSfw/S+xltT7/kZzOPy92725iBv4YVoTZWj8mkkEEvH7p4PNSkBdy/h+M/ZWWFFPoVers4N/YN2nk9aWVLjjPQr3iWayyQOXa4atNPJsNOfBpHtUqJ0mBCo9zIGWF/IrW1yCcUZkyZwGrvlzVtmO/ylo5Jcp20HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782731671; c=relaxed/simple;
	bh=IyGlaIDF+zmd9BM8n6VXDW71QSY7Y8ncDunVoUDd608=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=HoDh6Z89/zgevEtTeBS2bny3FkPu4h88Xa4oC9PyU6BF2Stm9SaouvyRTG/slJAVChVtaICS8kq28oXvTfuQsGNyJOpGgOecNboNLqpt8zzx9vR251N79pyBP6y4L2KgXgRFSfOzjfIvc4eMHZq04TTPujWKjkYxx80yKpiIGM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SVT1Up/1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Sh3MGts9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SVT1Up/1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Sh3MGts9"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65TATG0L2628186
	for <linux-pm@vger.kernel.org>; Mon, 29 Jun 2026 11:14:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0J8jBJDIfQrD/LQpf7QzmI1m3KrBYrgkBIaVXCu4gdY=; b=SVT1Up/1L1vBgJ5i
	M45p8WIYN4fkX5bUr2lZnpK2XUASNoI2ALkqKqjnoe3pDr2YWPnSjqRupW9RAOkF
	MobCFbrsXxTQdooeubbP2xT47BhqoJ5KZRZTPJZQhBhDHsS4kLPImZF5gFxkZqIR
	8cmf2aag2Zz8v19AXGuvLSKsA+fkpWbY9pW2hIs1JQEqd3DMYxFs+rGG+XioV6yv
	1pr2QtCf9w2h5iGOOo/XLXl8idchXuttwmpk8M7qI4IJIvFWx62jnervpbdmfjdg
	TkugFjYioLagi9UM1GxvRhjDdaJgWA1RdgPK8d0tK2yRGDJMvBGSNBnIBYzDfTuB
	rhTdOQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3nbgrk4k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 29 Jun 2026 11:14:29 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-37fa907f98eso1625934a91.2
        for <linux-pm@vger.kernel.org>; Mon, 29 Jun 2026 04:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782731668; x=1783336468; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0J8jBJDIfQrD/LQpf7QzmI1m3KrBYrgkBIaVXCu4gdY=;
        b=Sh3MGts9revaWkB4ENg9OlH683j+rPffy/AcCNhrqSYIJB0T/zd4xaQJMFXAKYcVKv
         sdVESbrmlQdxnKsVZjKKgF1YeNrCKc7U+tFUgO0XmBU3yrzDwHRuxdA70ATuWQI+5XAE
         ywXuZL82G2RonHU8lGDY9ZjtMWZY/jROCmP6IxrReMY1RkLDc3NIWZcVNKdgLh6RIJhX
         xlF4bgouWSw6A/fnYEjNhqcU+GDN0FQGWUG71iy+CHEr4Kwhjz9ULKqMMVxIgc/M9xto
         5L8LXkm426MpfGHdVIoT+nVbfBCmX1ug/FDUPeMYdwJunFgpNNXqbkZOc2d13QC4s/8Z
         WtmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782731668; x=1783336468;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0J8jBJDIfQrD/LQpf7QzmI1m3KrBYrgkBIaVXCu4gdY=;
        b=GQQ8c5nidO/kWYydiGnuEzK4rTLgzc9X0mGq8K24adVwK+qmzCw8CCwDNLPVp5JQ8Z
         fO1afXYtLZecbIaBzPr1a+A9JRJMkk17qqYt2jDScvLpNCg4ozdYSoBQ7xrPfLvCG59A
         dt7mJSRf4QscgmdJFs0lKhuEgo+WFpx154xym57Ffgn71LP+nzfJKp/hbOwBZNAAWBN6
         XTovoSuDFcm9y7p6/ZZT7JtQ0ZuqPRZMr8hmB7BGRM/LFZhdWCg5yZezH0pfn2++0CtT
         a4ztrp80QhZCX/OYRr/Od3r9siaSlrisKtstS+Ithvz7f7Rszx34vKuRLV7z1KmXn6H6
         BLvQ==
X-Forwarded-Encrypted: i=1; AHgh+Rpyah4/5rf0k1lBMRtHYOlw4BqYaWg0/loOhPXtRMkzxO6H3M+cOgXPpBfw3khDzdG504NwUDmy8A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzOVrajvY6+WkfgGa4e4Y13RuYsH0JlT5UlEP4eXRiTupFZAYPn
	btRz03ndeygyOObqOZtZoDO2Zp9E7sK6JjHtX+Hr709h7Xo1WGDwlICg+qoZSvocvIlIhAhNQLH
	puXclkdMqPRZvjGtU+Q1YkmvazfKfFPyU40lG51/i/YpzNiibOQb1kA/NrZo7
X-Gm-Gg: AfdE7cn9RROyYem3TAwPJ2BpmgbsIYOmNB0HUzbk3CXS9k1kktUoTgJVNteP+7pLb7o
	9uEvOdf1TraNShRrJfKnNLR1qiSaG5ltRtoo3KG0iURMuRx2gm1+h39BoHGxigBTuGznxcln3kM
	eFYBYOiXC5wWJGAYPTWCV5BC7+xixxc34TUavIjVPmuIu8srAe0M8j6BUPiYVu65cEnlv1gQJlO
	+NmoYSeFLx//IiCaSl1OxiDebOylGwZ6hMgJzFMiLxlH0O6/fJ0GWz03lWBIlhNR2AzXcMRA8K1
	hH0fl3/hmKC4r9VQmD/zErT//Kika8/3vhmXc8SIfIb/mWPUzK+KCMBA4zR1oymkIjfrKAgNDiJ
	gto995hrYneXK5oXjBU7Nj/6GrvrbTIm1yYN3naShOA==
X-Received: by 2002:a17:902:c403:b0:2c7:ef3b:e17e with SMTP id d9443c01a7336-2c7fc797f69mr144891445ad.33.1782731668602;
        Mon, 29 Jun 2026 04:14:28 -0700 (PDT)
X-Received: by 2002:a17:902:c403:b0:2c7:ef3b:e17e with SMTP id d9443c01a7336-2c7fc797f69mr144891065ad.33.1782731667977;
        Mon, 29 Jun 2026 04:14:27 -0700 (PDT)
Received: from [10.92.200.168] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c92ddca789sm55167755ad.12.2026.06.29.04.14.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2026 04:14:27 -0700 (PDT)
Message-ID: <729b0e26-bdbc-42f9-8245-79b2942272c2@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 16:44:18 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 0/7] Introduction of PSCR Framework and Related
 Components
From: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>,
        Sebastian Reichel <sre@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: kernel@pengutronix.de, linux-kernel@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        linux-pm@vger.kernel.org,
        =?UTF-8?Q?S=C3=B8ren_Andersen?= <san@skov.dk>,
        Guenter Roeck <groeck@chromium.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        chrome-platform@lists.linux.dev, avaneesh.dwivedi@oss.qualcomm.com,
        umang.chheda@oss.qualcomm.com
References: <20250618120255.3141862-1-o.rempel@pengutronix.de>
 <3309e88e-e189-42ea-b74e-346aec1b4b5f@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <3309e88e-e189-42ea-b74e-346aec1b4b5f@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 6eebUjuMhBLydaDnoFbaES_c3DpcG3Eb
X-Authority-Analysis: v=2.4 cv=Z4Hc2nRA c=1 sm=1 tr=0 ts=6a425395 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=KKVNV-Xjcw2sXtYmnfQA:9 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA5MSBTYWx0ZWRfX4Ojc2CxI6B25
 gNhkWRX5v4mdzxxEXjILtKGnF1Iv6zUMaopWXpkzpp0Tq+E+hwqKxvwsxuQJcA+k/Tg9s9MQ0jg
 PWoBiP1iiN63fER55y8Tcqlz2ztexKE=
X-Proofpoint-GUID: 6eebUjuMhBLydaDnoFbaES_c3DpcG3Eb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA5MSBTYWx0ZWRfXwXyULDQaZ2n1
 MbOnZFadHlrwFmUXTeJnT4xegAe1o8xbrlFrgj+KKkc4QnyoHms0/un+w09nh57TZwA1nN/hUSz
 wfZMnKn5xCkvtiq5ugmxH7mzDmK8ysroCOtT/y8WibD1UJkB6ujPINkuHUGxvAd/p8XV18k+BGS
 QMLZYj4wNeo3vFqfeSPzSuYMdO5tLqP1mJVLjyq79g2/tzBCnzZ6xCK6qNUmRR9X+MiDMDffoVd
 jb09GJV7cMsNBMyoIEgSOe5RAGUSB178c5gZgL0XV9yrwR4jctekxkV83TfztnPMTfGRzWqN1BK
 6gpVxnBa8UCQpjw5uWeAVexdZxYOcsv7sA7bN3XAyb3gEnZ06q4JQcrD1N7qlS8uJc0lZ06t6Gj
 ZJwiM1QxlNq16W/x8uQVzhCDFgX9GN38lXP0C2z4pCEnMrZdcVj6RXQOtMg/qYV8W9AdwKZkbWK
 ja2eJZET6ZA37zekJSg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 bulkscore=0 spamscore=0 impostorscore=0 phishscore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606290091



On 29-Jun-26 4:40 PM, Faruque Ansari wrote:
> Hi Oleksij,
> 
>>
>> Hello all,
>>
>> This patch series introduces the Power State Change Reasons Recording
>> (PSCRR) framework and its related components into the kernel. The PSCR
>> framework is designed for systems where traditional methods of storing
>> power state change reasons, like PMICs or watchdogs, are inadequate. It
>> provides a structured way to store reasons for system shutdowns and
>> reboots, such as under-voltage or software-triggered events, in
>> non-volatile hardware storage.
>>
>> These changes are critical for systems requiring detailed postmortem
>> analysis and where immediate power-down scenarios limit traditional
>> storage options. The framework also assists bootloaders and early-stage
>> system components in making informed recovery decisions.
>>
>>
> 
> Just wanted to understand rational behind creating this new framework 
> (PSCRR) for
> reboot reason recording and not considering extending the existing 
> nvmem-reboot
> framework ? As, this framework already provides a way to represent nvmem 
> cell in
> the DT and the driver as well can discover it. Would it be correct if 
> nvmem-reboot
> driver itself is extended with the features which this framework provides ?
> 
> or was there any other reason you decided to create a new framework ?
> 
> Thanks,
> Faruque

