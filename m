Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F732EEE76
	for <linux-pm@vger.kernel.org>; Wed, 10 Jun 2026 14:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781100930; cv=none; b=iXjH3fKAv1rPKxan3mnDnVnqdTWFiPYfv0mWQ008G/DK+LhcMCSYfXLET2k8rkLhdA4KJgWqvB7kJ9l9G8SO9UzYX3k0Tn1FWRq3hqN4lYfQ6H5PzzQcpbYNGBWkk7uFfYmguPnmlIwyfD1Aiq50eJsYAxkw8m/ncEG6m80N0KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781100930; c=relaxed/simple;
	bh=MFXOZCdPBc0TVsd4Y2UVkvn+uoJb2263Pchu6fl3G0Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IvBYueDlsl0Pi/qT/eXP8VXSIqgPAtLIKlbpG6GwtY6Resa3Z+5dF1v8QDZXjkxQkGk8Xsg+Ubwe/V4FwiB2zi0fONeL5NmnGekG86x3qqzLwbNLexYNcQVELX/3yFfcEkRFGINvRUBaef9OSf95LF1VaqzeLPzko3U7F0P1unQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=a6qg9sbM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FT2hiE7I; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="a6qg9sbM";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FT2hiE7I"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65ACBm3S3763572
	for <linux-pm@vger.kernel.org>; Wed, 10 Jun 2026 14:15:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UzmvbhO3ccLAFDnidWjn0AfYFzvf4Vav9+7SbxX5aQg=; b=a6qg9sbM49qI90pw
	IajAfxYbrHXzoHWl05FBcfEy0O9Fj/r8+2r7WxjlzP7v6A8EVsmAy2oMZ5pUuSf+
	p4OFEywRpVdVGc3oE7w0Wl4IEzl5ys5cSJtsm6Vo7rL/t2tNc8pPQj4c5VQEEqnk
	7YU7pSOLi7y4fxGC0Hyb5MkWIzktHIl8MQWJMmAedKs5xRVDuoXaLLx5ptRpregt
	nZLGKzwQabtpKgusyZD16C53Azom27trOWeETj+zoOVTkYL6jY4iUX7wmAL3S5NI
	Efbvq301aWIo67blgCfb0NXVAFgUEPeQS/WBWXFylwhZgGAdaOXgVe+CnDUeIJ8A
	ok78wA==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epwnetu59-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 10 Jun 2026 14:15:26 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-963b744b61cso6283342241.1
        for <linux-pm@vger.kernel.org>; Wed, 10 Jun 2026 07:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781100926; x=1781705726; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UzmvbhO3ccLAFDnidWjn0AfYFzvf4Vav9+7SbxX5aQg=;
        b=FT2hiE7IHhLq74SM4xmI6jQGSWHAphb3tueGkwRXNEDYmVB6MiBQVWcQWYivuDD8GZ
         bk4pyimS135eTAvjvkmpJGz4hHt/WA8ZwKQ4cNJGk3OxjLmZxnoysdrY9RC4bl3bf8Sc
         ZNGEqfAcK+hEpnlxrkwZGMcXPhhnyZXF4r5X5Dbzfq1CS6eXapqehAg6YvgMrHmz34uN
         3NvzPb4xkVwNOh1wSSngKxOZBfQ7YxJMi5RfLRDZYOabaX0Vq/4G3RHyBksS/wYPnxxR
         LtDw9Sq5W5U4Uit/7CbGcLVt7HxFLz5xyEOP/DjFWNtuU543MdTdh2WXoAItd7s7kzTO
         NTXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781100926; x=1781705726;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UzmvbhO3ccLAFDnidWjn0AfYFzvf4Vav9+7SbxX5aQg=;
        b=ds9AAhO6Wxg8A/kbsEobc41R+3YoDRdhW94w7ex9jmBXW0MafwPoU5M/0yT+OhXZdk
         WfDi/1/D2a2mciFBIIHGzWv131gVIa+z4fZNZoPf0j8LLXAMohSZR82q/GQy/fmXa4Ky
         6ZqGwMffAOoqoM4hRF6Hm1f/W4C8o4gwzeCub1IqkmVI+MSfBw6MOzCGvOTHn+1YaIX8
         mqlFRBVaO3b9fPIBQOivy+W5Z1t8JgPJV0cucb7BRw4fHiUq/S2daly6so/BjLjX1zje
         1e90iB/LtCaC1hnf9+08hxu8z1gVDs1hYOtcveV5xCWrQ9W0tOzTVX0FpSiX1VOgJMXv
         ZEIw==
X-Forwarded-Encrypted: i=1; AFNElJ8HzcgBYSR7UEz3Qszu6+/7UG6PFrwahxYIptzKfUkymh1+R/b9NB0qqxhzONFmOEEHfPKGHSLFxQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6xR2BO+shtBrcCbexebdzi0lL8Cj0oYNMT+hfskJur0uFSG53
	egk0fHPE3rUD1DErgBnlStF/5s1WbIAqbiS2X7/DArAGa2W1xlldMIg6BMqVW05eQWa85psXU5H
	kpIUDmvUnVEJUwu+1creiZDOJl9MF0QCWIwwSI7iZiQyJ3UJp45i8INALL7q5GQ==
X-Gm-Gg: Acq92OFti3JK8pyx9foDyMJVqdW93ZylA6fyMXRTajcAD1crS8bozX7ZYYjevuHHOzA
	xBFsEXQG6677AHCIk9FL/J1jcP7ydfQwG2OMVKIRfGy2MhtCEWI8uFtM0JHvfMte322kxssRE/u
	/YtaBvt1C/aDCmW7yrn8yWaZgsPjqVldqKmlE9rfJnBcdw2TVAAuwYUZzxwRtfoxX3Wa9BErzSS
	hBdrERW6gSkSRfXHL5Vq+RCDb/u76Xg1R/7/tGWt8wNKo5ho3wzWyalKLWYfkYUk2nnNEY2rYL0
	b0+JJ2o+E0O4cEvFniEs5gPsa4wb0zASAl30MsQ/AIS5clD5JpX/Y09EoA2RKSoKxWB8+r4Jae9
	oYQdU5na+2B9d40s4LcYCI+o26Dq4sXGY1NWfmQYeqTosh+Z2QDmS5OOH+4yQGWqvoY1ezhsYcQ
	WXX45/WsHX9ouEkfCL954=
X-Received: by 2002:a05:6102:6890:b0:631:ff40:22b2 with SMTP id ada2fe7eead31-6fefa60e40emr15357918137.2.1781100925758;
        Wed, 10 Jun 2026 07:15:25 -0700 (PDT)
X-Received: by 2002:a05:6102:6890:b0:631:ff40:22b2 with SMTP id ada2fe7eead31-6fefa60e40emr15357838137.2.1781100925377;
        Wed, 10 Jun 2026 07:15:25 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:7f50:81e3:bfef:b418? ([2a05:6e02:1041:c10:7f50:81e3:bfef:b418])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2dcbe3sm67240484f8f.8.2026.06.10.07.15.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jun 2026 07:15:24 -0700 (PDT)
Message-ID: <5105b5d0-16d2-44d7-9c9b-b6e982d7d53c@oss.qualcomm.com>
Date: Wed, 10 Jun 2026 16:15:23 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/8] soc: qcom: Add support for QMI TMD cooling devices
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Amit Kucheria <amit.kucheria@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>,
        Casey Connolly <casey.connolly@linaro.org>
References: <20260609-qmi-tmd-v3-0-291a2ff4c634@oss.qualcomm.com>
 <20260609-qmi-tmd-v3-2-291a2ff4c634@oss.qualcomm.com>
 <pyt62qpa75nzdatp5xl7vcqrdzmrzsf5ethw6wq62bzg6b7qtv@ts2v53im4bos>
 <33fe758a-a733-4f27-8824-3dff398e1cd3@oss.qualcomm.com>
 <awmoxzmrgqzot5yfwpoml2olntpultuguuvdfvk5mt2lxqjxqj@n3tsmix64fdb>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <awmoxzmrgqzot5yfwpoml2olntpultuguuvdfvk5mt2lxqjxqj@n3tsmix64fdb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 2ljmbY_ruvdJ-_XhL4uYYn2Rk8r9kd8F
X-Authority-Analysis: v=2.4 cv=ebYNubEH c=1 sm=1 tr=0 ts=6a29717e cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=duYTza_KgoU2j0Zg4FYA:9 a=QEXdDO2ut3YA:10
 a=1WsBpfsz9X-RYQiigVTh:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 2ljmbY_ruvdJ-_XhL4uYYn2Rk8r9kd8F
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDEzNSBTYWx0ZWRfX2t1UEdDQlA+G
 q51xDor5L4twD7lhHnA7S+wxLO6Ed9zSL7JUjT/OhrWDgYdIhKjnr8zvpVqsUJNF62IHnsudxn8
 jMvuUcUpSCI8ZISEI4A8tIQCWbSZvYxqSrVwYyo3o4qzkbyMKsPLHw62aZ+WZGrifeyrXjxpeMs
 tKFye03BssSsrQ2yr4K0VOpftbt2xwNGkHSupc9iMlgAjshTzmfUZlByEYM/5RFykvFvrqOKlo1
 s1sHgIzJNq87rbQ07cCBpCFeyAFn27W4pUgX/babdrkWu6Gz/t3wqP7CG/L+i5KxxqRMDrfcglA
 Ar+zYwXb7FiUVyxgSaA2Zl5iNkGbkyw3I3jdpvyyoCNA40Br9JEAYa90coVi9khPQQAgMLAAuBG
 unVl+eJ9aacEMVpnbrZ0fWPsxHo+Br+eG6dpCzcJpLcN/gkh5N8ql4+1rSm01ecYimXyxLepuTb
 BJJWBdDjNuLTlSVxo6w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_03,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 spamscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606100135

On 6/10/26 15:42, Dmitry Baryshkov wrote:
> On Tue, Jun 09, 2026 at 02:08:57PM +0200, Daniel Lezcano wrote:
>> On 6/9/26 13:30, Dmitry Baryshkov wrote:
>>> On Tue, Jun 09, 2026 at 03:52:57PM +0530, Gaurav Kohli wrote:
>>>> From: Casey Connolly <casey.connolly@linaro.org>
>>>>
>>>> Add a Qualcomm QMI Thermal Mitigation Device (TMD) to support thermal
>>>> cooling devices backed by remote subsystems.
>>>>
>>>> On several Qualcomm platforms, remote processors (for example modem and
>>>> CDSP) expose thermal mitigation controls through the TMD QMI service.
>>>> Client drivers need a way to discover that service, map DT thermal
>>>> mitigation endpoints to cooling devices, and forward cooling state
>>>> updates to the remote subsystem.
>>>>
>>>> Co-developed-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
>>>> Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
>>>> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
>>>> Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
>>>
>>> Wrong SoB chain.
>>
>> I think Gaurav wanted to reflect the changes did a back and forth between
>> us, so I ended up in the delivery path somehow. I guess adding
>> Co-developped-by should fix the SoB but won't reflect Gaurav and Casey did
>> actually most of the work. So I'm fine if we remove my SoB to fix the chain
> 
> Anyway, Gaurav's SoB should be the last one (and it should be preceeded
> by the CdB tag)

Ah yes, right :)
