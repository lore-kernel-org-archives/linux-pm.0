Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE4B42847B
	for <linux-pm@vger.kernel.org>; Tue, 10 Mar 2026 09:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773136789; cv=none; b=FPAhg8eZcqpStWkw4w8J8R4FSNb70Ddm4oIQKsxr/NG1VuvQZu+7byEnbQbxu6rYqo3GJqASvmf73BssYANk+DU75yTtINn07uqFeGSobgX/jH4zncfL3vGrfpiIw4uMzswBWuOEK/8ZyXIo63ssLtnhXTVNvkVHPjRMl3ArxkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773136789; c=relaxed/simple;
	bh=TDPfe7m1zO4HOHLA+mRXSmC65oJJ46//jYUxV1a9kdc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UzkA16fV523dJ040VwU7VfsXbkzcud/93TyGgsFQ9M0yMdJxHAm/jLcQwvK1i7HY6XVLiaYWg5D09Zuk9qRh+2Vw36buwHER4L17efKY9bWYVMnDoZryD6VTmkYkFslyr2VqZV3EemWYykSA4iH+k5//2uX9GiXj2pMuWfk3qjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Xs8tsJIa; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CkVfiZi2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Xs8tsJIa";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CkVfiZi2"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62A8plmp3690891
	for <linux-pm@vger.kernel.org>; Tue, 10 Mar 2026 09:59:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lgUe0TFn6d0vjPmbLxKtIohMDX7uiKOUBiGY0vO4PaI=; b=Xs8tsJIaHuFREk0D
	X0/b6Es/83vmE0IH6BgNgd5sda9mPkmieLyMsDF91whgiJgXQNXYiRb9QkHR88TD
	xoFPVRMob0nwQEJZYcIlCSkPjptYkjXDDlNmqPdsbk5H+Hxasl+ROILF1FMEJZ1j
	OxYjgdH8cK+LX09gX42fk04Fkk5YoGJOsmdYW/Jqngt1old/BEWmTec/7GpG9emm
	YEC4IebUlfSG/DzZlTLx+gNgmlVm6iUjcSNnYpC2cDKWHCjZUK6Yy6FjEXRRf+fz
	xF8VV3ASO7vKPZkyGumge0dPKpyzsutqg2gW/2O1rrH8wWoghWSNZdORS0lPZCv/
	Uc3+aw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ctg5ng8v5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 10 Mar 2026 09:59:36 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-89a174bd442so473503026d6.2
        for <linux-pm@vger.kernel.org>; Tue, 10 Mar 2026 02:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773136776; x=1773741576; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lgUe0TFn6d0vjPmbLxKtIohMDX7uiKOUBiGY0vO4PaI=;
        b=CkVfiZi2gPTHvbr3XH37zf6fiddNWx88BEzeh0Uq98+F4JkoA4W/XdV2lYU2imziks
         Gh0ZGkXIlWE0f/Qmvn4n/I5JinUCvjZJXJ56km5Hsq6Df2M7I/J5Ys/CrSIj/gG7A9p7
         8CqMkxWBKFUk3ku4PpiLVVLm+0C7920mT/gAw4zXqwJlIkemzYERLPZNZXb6KXDp5/mM
         RubqBxFBuyZQxw67+OwkRtDHc02NMJF05uBk466y0ZXILVNGwrXCc3nPFAi35wdE2ejP
         ra76Frxi8fuPCMW7oDR+UV/jeDlPfIy7H7LLJ1TpGc/VW8vr7mhuSadG8yuwQ+mKCZ5n
         YcZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773136776; x=1773741576;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lgUe0TFn6d0vjPmbLxKtIohMDX7uiKOUBiGY0vO4PaI=;
        b=BIU0mJ7n9IEw2utJXvSCA1jRLmEwsi9EzL2pkxFup9i1UT9iuVXtM/owg2mrns2/e6
         +J5eVBvDQAsGdY/P40uid1iohrOo4m8D61pIu6yzJJ8FJAJP/LitLrJT2rN0L5DECzpi
         AiP75+qIFFzoNJDgGOJl3324Z2eppNIKD5GkZdSNNXvrDC1tMnJECtxRN+f1Sr5PIWSp
         Ldn491tGOCZ9k8gl8fdR40vMfWT3mdrfz10aQ/13IO9W5muHNZG+psjeZqJUUJyss9H7
         zbo/OXsyyft2npz/dLj54sRm++3NEwIe4P12jP4ktFH0rJTkqlKV5Z7SRKDuz2rY0ias
         PiCA==
X-Forwarded-Encrypted: i=1; AJvYcCV1Cyxx+aounZKjKo4CHnlAs36IQ20HAE/qlDpC7W8RWBmd6HJxnP3JZdlNWBwNYOssZxBQHhucqg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzUitMHLJuhM+hv1wFO3+undsBCUmPp+/UA9jzOrJmbjMsYy++1
	04zG2EgJhKQ/3+uhARJ/l9OpmJ0jFcBRxBrk4npRh/TOb+D7U7I3+eHDWLLB/xA4ZruOCyMpBfa
	DWZJdtwDN+HiQ/mxzE0F67NPKlwFpFCQSxr0HmJVBcqpLwiWOb8gf6boF2Ivh8w==
X-Gm-Gg: ATEYQzxEpq5UQl6CayObCjK3kinHYYzTq7oREAV1/cnFsEEG0K2d/J/wRCDLn29JsDE
	U5JSIDpfv+t0K0rtNzeehCJY53h5gROWTyThLOyHBhYmoTlN6C0zsk5XrKntnwAE+A1Jhs86nT3
	fCntpoG7prLEwOiMOlf1QwVIeprqsa4dhT8MXazPZZoa0sjKe4yV/53fKBR6ILW1UrDlq/11RrJ
	kJqAHQFx3S1AHDlJJLGTQlp+XBzgUk46WXa+dm5GcBrXWFNRMK8AFQWbHuduGu1PHVn0GBBm8Te
	5eMFDWAw73zHHoNOl/oPcYGbpWgHot0acKxmzPXwuYVUsa6cHcxtm+P98mJnqKZHr7ibRrbIO09
	99wmpjSndJOPLZriYd6yerSDsqgHTF/5zNGEx9jOsEM+gUNA+
X-Received: by 2002:ad4:5de1:0:b0:89a:258:c1d5 with SMTP id 6a1803df08f44-89a30ad59bemr219718206d6.50.1773136776367;
        Tue, 10 Mar 2026 02:59:36 -0700 (PDT)
X-Received: by 2002:ad4:5de1:0:b0:89a:258:c1d5 with SMTP id 6a1803df08f44-89a30ad59bemr219717766d6.50.1773136775932;
        Tue, 10 Mar 2026 02:59:35 -0700 (PDT)
Received: from [192.168.1.29] ([178.197.219.94])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-485419b8526sm68327405e9.0.2026.03.10.02.59.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Mar 2026 02:59:35 -0700 (PDT)
Message-ID: <9a9cb7f8-54cc-4c43-a5a0-f022394351eb@oss.qualcomm.com>
Date: Tue, 10 Mar 2026 10:59:32 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/10] workqueue: devres: Add device-managed allocate
 workqueue
To: Tejun Heo <tj@kernel.org>, Sebastian Reichel <sre@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Tobias Schrammm <t.schramm@manjaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>, Lee Jones <lee@kernel.org>,
        Dzmitry Sankouski <dsankouski@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        driver-core@lists.linux.dev, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, chrome-platform@lists.linux.dev
References: <20260305-workqueue-devm-v2-0-66a38741c652@oss.qualcomm.com>
 <20260305-workqueue-devm-v2-1-66a38741c652@oss.qualcomm.com>
 <aapTSyrkqqZ8j_XL@slm.duckdns.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@oss.qualcomm.com; keydata=
 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
 cwzYbmi/Et7T2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <aapTSyrkqqZ8j_XL@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: XE8nbXpSA0alNWIYqwWXdPQmfbTbsRdv
X-Authority-Analysis: v=2.4 cv=ervSD4pX c=1 sm=1 tr=0 ts=69afeb88 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=gOEeR9iKwsj33Yj5oN/cWg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=f4WQo65-w8K6TlvLPnkA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-ORIG-GUID: XE8nbXpSA0alNWIYqwWXdPQmfbTbsRdv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDA4NSBTYWx0ZWRfX5WDRKR01YJ4C
 mjPrZSH+eix9MdVEOa/szkkdn6eJkWSENr6WuISwtKP2QRaN/5wcMtHPQZtP2i6gGKTR00Q/QaK
 YG9yPSZEKRlE79++bs4uJpD+LnqRMz9ioz2BUPvC7AQEFOwoqq3I/nK+eIreX/apaCZsNWiERvj
 c6mMS6N/2PELBVfM09VoXnANA8631khADiWw21kf/2Q4LiiLBuRcvqSE/G3NF1qIGfIk8D9iq8z
 y4X9iJrXupAwMsRVplxtKrKVfgkAA3awh8cOtQRiiZaAxVTaT6hJ/rpQJalPadKv4I8GAsA8sIa
 L86gJPhc3ldXwzkv4ElB17QmmxF5JutykGiZ69VZwT6LiCT74yo/c26nOATc+1WtDUUHakz1VFq
 blPsXIvQxRlGi8K2Jw28+q16ths1gqmKg36JddhYmyfgoBYBmHiNUjTPtv6sisotFVQ6hvfnzBh
 o+Jlt3Mw26wYptwdoPQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_01,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 malwarescore=0 phishscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603100085

On 06/03/2026 05:08, Tejun Heo wrote:
> On Thu, Mar 05, 2026 at 10:45:40PM +0100, Krzysztof Kozlowski wrote:
>> Add a Resource-managed version of alloc_workqueue() to fix common
>> problem of drivers mixing devm() calls with destroy_workqueue.  Such
>> naive and discouraged driver approach leads to difficult to debug bugs
>> when the driver:
>>
>> 1. Allocates workqueue in standard way and destroys it in driver
>>    remove() callback,
>> 2. Sets work struct with devm_work_autocancel(),
>> 3. Registers interrupt handler with devm_request_threaded_irq().
>>
>> Which leads to following unbind/removal path:
>>
>> 1. destroy_workqueue() via driver remove(),
>>    Any interrupt coming now would still execute the interrupt handler,
>>    which queues work on destroyed workqueue.
>> 2. devm_irq_release(),
>> 3. devm_work_drop() -> cancel_work_sync() on destroyed workqueue.
>>
>> devm_alloc_workqueue() has two benefits:
>> 1. Solves above problem of mix-and-match devres and non-devres code in
>>    driver,
>> 2. Simplify any sane drivers which were correctly using
>>    alloc_workqueue() + devm_add_action_or_reset().
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> 
> Acked-by: Tejun Heo <tj@kernel.org>
> 
> Please let me know how you wanna route the patch.

Like I described in cover letter, so I propose this going via one tree,
e.g. power supply. The first patch might be needed for other trees as
well, e.g. if more drivers are discovered, so the best if it is on
dedicated branch in case it has to be shared just in case.

Does this look reasonable @Tejun, @Sebastian?

Best regards,
Krzysztof
