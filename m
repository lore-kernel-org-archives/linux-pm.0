Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3AC3AE707
	for <linux-pm@vger.kernel.org>; Tue, 28 Apr 2026 13:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777381404; cv=none; b=ry9hZssxg7d0DwN9Ypq9ICBChjLlrKRuEqf08AvW8CogPvuxM1sGKOI7x22kjehOQ16etL0Jh7n1QF1yQZug3YG3WPgci+ttC7pCU9ySsHt9p8vX3o9xoL/e1n71USCj18rAujhbswBNRwyEEXVJW30xo9bv9ZwvRviIcwKHphA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777381404; c=relaxed/simple;
	bh=po8mFBivPmCgbXtyoSG2kBNNAWPWRcQV/8vWooE8lBA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I/pznXNtEZjWvSwMQ/cxHr3uiQcU5sYqQ/8IfP96zrMLiR4uP4pu1jiuAKfVXvUU17RvGgpCb3GL4OSUZjtmHYREi6UltvVFNWyIgYwGWTPvCmTaIlXXInHF9IgFN9jE1OAvh/D3XfZ+2P399aMDU+S1DFrVSqY1XH/9k2KM7hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gH7BX+o0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ih8sujDq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gH7BX+o0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ih8sujDq"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63S7vqsM1744980
	for <linux-pm@vger.kernel.org>; Tue, 28 Apr 2026 13:03:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/YnMDibrKzfhntLr7stNZ51Gy9Qv32dxEsIF+FY5/ng=; b=gH7BX+o043XO51CZ
	eww7aZ4/jYejBslFXpdGy3jbqDCLi6bvJh23fkCh9dlEXnkG0cfqEdSX5VGs120d
	4Q8r8LvgVmwF7AYT1PyEmXMM3SHUPiAC2sxv8VM9Y3RAPmN6PNZdUDFj5euQ7wRu
	KbwpW46muq7TjRYRsb6Jd4fsTYjlieh1TM9aQY1S767SMquLuzQn/RbDm1F2yq43
	tROOpXtsuq73A1zLvD8fECk4A04GrzuuIa89D0qwyphjnU9V/Jw/wIaloeSVbPA6
	kXPtXN+ekEBEF5Do3gfP+Gpjj06Tw9VYTRoKOAIy9qATyLBqTFdFEqL0MHy+svQ+
	WxaxNw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dtryd95uk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 28 Apr 2026 13:03:21 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-82f6e6a3a76so13688921b3a.0
        for <linux-pm@vger.kernel.org>; Tue, 28 Apr 2026 06:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777381401; x=1777986201; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/YnMDibrKzfhntLr7stNZ51Gy9Qv32dxEsIF+FY5/ng=;
        b=Ih8sujDqvueALRseB19LcbqTPAiGsksklybJDX02qyqUXSa4GXIW1tAnV9u14/3sH3
         T5w+FTGgJzdkdr/FN6AM5G8mjoF23vG9cz1SvXPHzUkc2mNeo/DbTGIwnWiFt8FUCuep
         uG1UrL19qw1RPE7IiAxLdZPJoFqsieG0seULKGYlJ6fHlwh8LL7uxxStkTaQj6sD3gZc
         fSkNrjF8n7aG5CfUpaEADn8GsQARd0oSIokkSI1c2Iuze2kIXYW37EE2B6NxDUaz+r7t
         8FPkq/TOpxS/1L1iOxsE2xvrHH+a1YwLydSaMKq10L9Nez3Qvg74yRXfkm2V4CPckHya
         p2WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777381401; x=1777986201;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/YnMDibrKzfhntLr7stNZ51Gy9Qv32dxEsIF+FY5/ng=;
        b=dnVETQdSbsGzQaenKnsLzZAwmrKeGy8ljWxnqkYAasuU83gXlpgVyo8KGQRbKs4I8e
         HqOQCu8EmVz8Z3WFAVzXfJJdO/3GWUvZw5QMGQSOp1efuRF61xya8zU6sfPq2qdP6lsU
         BH3+Ig7Bq3mtEGtjPDzcDY82jQvXEb5360Dyv8haBZU0ADfqZ6jJ8Da3L1eo91rQz2Ki
         YvwO6CumEJB3iEO+BjsFxCprZXFSwIeqhQyw4dgcIJcsVAt55ToIw6p87xFJqckX9lM+
         A94RThAwP7oF67iM/u+Q/CXPyIkz37t7gQcq4ftDj+UYdleI3pPUg6EEyzFatgkyU0Sf
         4XmA==
X-Gm-Message-State: AOJu0Yzsz0tkfC5qAekmYIQ8EYyRsRAIupPlQZpnZyZPnn1UsyGKw/bF
	W6gJKx8NjsfmtEc1mo9VcaEM7K0viPdiSUfEArq6LH9ap8udW+9s8bBzp+aR8x4xkWVR+aunOL+
	nE8VsRb5aQMy/SLlj/oSzHoBOpMlsOjnOPogmQGaiABYMCrFLJLoIis68qVvVeA==
X-Gm-Gg: AeBDieu+QFUOocqAqnlFaPfYVOlso0V+4p3TAWYS+xzDge/3QFMXr1nyV5Zpaq0C+Dp
	aCfxs/+HWpzNKcStNWcqK7Eza5SII5nEHoeQlzDOxL6HW6hXrCK+GZ0Bh11g9FtuSAC82jn1w3q
	OsMhM01lc0l9azt5iBeWsYuyvaRYWOhni1s9en/EXBjoTo9ijuypWi9zsNE+y+BUuDbL6dTzi7G
	ODKWyHfOSPh+WrfoQGuZZrGyqTtx1q+hZqaAtRxCV58yDDzKR6VqItCNtFkkGPrz7snjAnahePe
	31a4icFkDRQhwdwHGwvJn7+umcixPjpy9KFCoo9M/HoR4pCxYvLIusieOUaUiYcT08FsSvGsRWr
	JySbI6bhbnd9YkMsNFD/eM/jYzUwUs8XQDiLzOgk86rRYAOb5DyLp4U348Zs3n0kAEYQ=
X-Received: by 2002:a05:6a00:3691:b0:82f:a89e:e16f with SMTP id d2e1a72fcca58-834ddb28060mr3248326b3a.14.1777381400780;
        Tue, 28 Apr 2026 06:03:20 -0700 (PDT)
X-Received: by 2002:a05:6a00:3691:b0:82f:a89e:e16f with SMTP id d2e1a72fcca58-834ddb28060mr3248246b3a.14.1777381400102;
        Tue, 28 Apr 2026 06:03:20 -0700 (PDT)
Received: from [10.218.41.175] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-834daf7eaaasm2531210b3a.57.2026.04.28.06.03.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2026 06:03:19 -0700 (PDT)
Message-ID: <d6112b9c-01ea-483c-98fe-b480e78872e5@oss.qualcomm.com>
Date: Tue, 28 Apr 2026 18:33:08 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v21 08/13] mfd: core: Add firmware-node support to MFD
 cells
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
        Srinivas Kandagatla <srini@kernel.org>,
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
References: <20260427-arm-psci-system_reset2-vendor-reboots-v21-0-dcf937775e73@oss.qualcomm.com>
 <20260427-arm-psci-system_reset2-vendor-reboots-v21-8-dcf937775e73@oss.qualcomm.com>
 <CAMRc=Mf+-04Zr7jjRoaxTzO3LKSMyQ7DzxJc=dHNSyThEUiq_Q@mail.gmail.com>
 <c0677503-8073-4940-8eb0-c06b34f843d2@oss.qualcomm.com>
 <CAMRc=MdxpSXiqAn-8Az4ig4N8TFVdE9psacPVG9J9KehuFnbwA@mail.gmail.com>
Content-Language: en-US
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
In-Reply-To: <CAMRc=MdxpSXiqAn-8Az4ig4N8TFVdE9psacPVG9J9KehuFnbwA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: ueBJZ7zB0Ffe1uKMvtlGe3HhLaA4tiR7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDEyMSBTYWx0ZWRfX6ChoKn/P+Ekw
 mceATUXzSpDGoXvobuaWKSCWNS238mMgyuuNxhMbyMH1mdzxYy2P5UQofa9Lg9EUk/NMU/p2AZ2
 7u4qDP16MW034vWIVkyrPl5TZ779NhBWsbyMMUFL6ewPC9NvbwlbmNo88J2Fm5c0uNB/fLeQl5M
 3GtYN3pe/Av6/8M8THNBsQP7c+SVQaw1d15NpBpYWA3BAoaZLD8HkC570pFHaEkKYopkREkwB+C
 ziSvNMbMLX8NWwXJVuFim25FkDOGkMNqjeC10BQy7p+m4glrEG2agEnpKbxBeP+GgzFWSc4fzbZ
 6Uref57wF10JPrjyO73hYbwuwKyS8qGyLmyGEyMmS4/n/eBJoG+6TMNLQBDRmRkWRmAMBsQxPZB
 6YPSDwPdrqK1k8v3j6l7zaUfI2GAb+BrVKgLkYS+S/atkDBh3QFz6Kt2j6qgAT1icpDKgZdflrB
 6aYAqzj8UBezVsv7LeQ==
X-Proofpoint-ORIG-GUID: ueBJZ7zB0Ffe1uKMvtlGe3HhLaA4tiR7
X-Authority-Analysis: v=2.4 cv=cMnQdFeN c=1 sm=1 tr=0 ts=69f0b019 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=PlKOg72wQhDXdNgDaE8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_04,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604280121



On 28-04-2026 18:21, Bartosz Golaszewski wrote:
> On Tue, Apr 28, 2026 at 2:18 PM Shivendra Pratap
> <shivendra.pratap@oss.qualcomm.com> wrote:
>>
>>
>>
>> On 28-04-2026 13:33, Bartosz Golaszewski wrote:
>>> On Mon, 27 Apr 2026 19:34:48 +0200, Shivendra Pratap
>>> <shivendra.pratap@oss.qualcomm.com> said:
>>>> MFD core has no way to register a child device using an explicit firmware
>>>> node. This prevents drivers from registering child nodes when those nodes
>>>> do not define a compatible string. One such example is the PSCI
>>>> "reboot-mode" node, which omits a compatible string as it describes
>>>> boot-states provided by the underlying firmware.
>>>>
>>>> Extend struct mfd_cell with an optional fwnode pointer and attach it to the
>>>> child device during registration when no firmware node is already assigned.
>>>>
>>>> Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
>>>> ---
>>>
>>> In the following patch you use this and violate the supposed constness of
>>> MFD cells. This also mean you need to modify the mfd_cell at run-time. I would
>>> prefer introducing a field in mfd_cell: bool use_parent_fwnode which would
>>> indicate to MFD core that - in case no fwnode was assigned from other sources:
>>> DT or software node - it should reuse the parent MFD device's node.
>>
>> Have one doubt on this, When we fallback to use_parent_fwnode for cell:
>> psci-reboot-mode, at psci_reboot_mode_probe(), pDev->dev->of_node point
>> to psci node.
>>
>> But we want dev->of_node to point to "reboot-mode" node. This may need
>> an explicit assignment again of of_node?
>>
> 
> Ah, sorry you're right. I'd like to avoid having to modify the
> mfd_cell entry at run-time if possible.
> 
> How about a callback in mfd_cell like:
> 
> struct fwnode_handle *(*get_fwnode)(struct device *parent);
> 
> If set, it would be called from MFD core and would do the name lookup
> and return the fwnode which would then be assigned to the cell device?

sure. thanks. We can make it a callback from MFD core.

thanks,
Shivendra
