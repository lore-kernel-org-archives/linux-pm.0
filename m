Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C457F405C32
	for <linux-pm@vger.kernel.org>; Mon, 18 May 2026 18:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779129959; cv=none; b=crYllnTK4IfXTZHaIFwlfc3BnqrpMEqtpEGexHbbhLSbR2sqtmkJltAamBZP+Iexz/l3XYCjg4x7FgFlghkqXZG/gnyFAXnL9oxab/bQtgzpUdaP6n0c3nIPlRrwV4i7VqMdPcXzhOWoHTT9umpVqIcEw7//ZjIV9I2TwHoCXyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779129959; c=relaxed/simple;
	bh=Yu9Zwk7TGK2LLiay646XMZI1OzTnaKo2CIhI4FFv9i4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z/dWUVB6giq1mTGVXjc4zDS2ryybdwK13i41kqNRfzQoWz38MIhKXSbtp1qMrFEPrvWkNlgJEAr1DlKn1Qx+7/IJgXCScseotUV+UV0ZUuT6IuntBAx0xVbPxbXZ0R9HaDj47oarGRiSvHW13qsoODq34LqrAU1xKQsjCAIW7Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Fe7U63zm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HUrNZred; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Fe7U63zm";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HUrNZred"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64IDkHYL352984
	for <linux-pm@vger.kernel.org>; Mon, 18 May 2026 18:45:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	C9aPkfTUHaJq8jAZbP1lkuOqQeGCaA06/tOgxE5JXc4=; b=Fe7U63zmYXSVX3BN
	CKLAm3y4bEEuL8aOQ8T9AqrR5zrWlNA2Ji1FXWksJeQ/5mZEtlL/og/7A1WApcBB
	1MYel5qXI3PqPCQ1TOfdmNRakU6BfB/+2bWzIKvh6SvQQylm2H5eWNvgajTbGwfZ
	4qAyu/iUSSuyd/P0FENTrkLJ/g9izODzacYQztRAnW9z95ir44F60uS7wIBECdjO
	W7TOGS1RS+GLxAFkcuhgoLdH+rBCP33UoDOWjh82AL9Ra088JMFi2+cVOj5r/hDn
	w6ERWrmWuu6cUfFsAWi1m/OlJQJ7/jrzu1UxeUgBVTstu7KBl6NSXT3kupxOSGPm
	zonlAA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e7xjajmr4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 18 May 2026 18:45:56 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-514cbe73d00so93497711cf.1
        for <linux-pm@vger.kernel.org>; Mon, 18 May 2026 11:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779129956; x=1779734756; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C9aPkfTUHaJq8jAZbP1lkuOqQeGCaA06/tOgxE5JXc4=;
        b=HUrNZred3/fk18x6urQZlgJNhMqNXyo+2K3peNvI0ZjrOl0nqmA4chSxES1I52xHaC
         4Mn2RPcHF6/rae29xcbyvwgt5SHmeTi+dKYOgCBs2en+nVt5Urwhnv1Ui8pR4IXdV7NM
         hSK21cJo8H9YK6/B0VVBwlyR/pEcANL7FuP2ZDPGuN4hn8ihvT7+40MgOwNpCTro16Xa
         cnrTprDuuWu+UpTeCGay4pboa/0i6Sq4ElBWOmna8k2gZHSDEd6SX3bKLMQMua7Hakwd
         QX2Lxe6fw5f/rmamHyUAwyogU9YOjWTu2jfgMzQUpH2FWQ//NqkSt9uktwbV/dVk8rAr
         n8NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779129956; x=1779734756;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C9aPkfTUHaJq8jAZbP1lkuOqQeGCaA06/tOgxE5JXc4=;
        b=m5ndZL4za2DLQEISYq0v1CYqgemteR+nKzrnkbBYAHYvUbgq76UXZKRYx6Yuk3D/bU
         zjFZBcZds+AjIPZnn6P6Zt5E2TXvtXg8TUboZd49/BJiax22y+CpTscoQCkmODreo/0H
         3YfL2zDDgr6N06myjzhqQXJoPG5/OkAmh5jVhwFN3WFmQHeklbQTVXffudbILrg9n2lc
         YwS3SUhDntqhUkMsPitkh5nXrvUohjURl7uB7JShuM//6HSvw1dQokdlqj3GhDIGZDAB
         J3CLHb7mxOlmyTNI9ikmV+NqCYIBKwmXqCCHthvhJyhE4e6lxE4l6elowB8f7ctaIBLH
         +L6A==
X-Gm-Message-State: AOJu0YzR35UBun3VRon6jH/JsJv9KZ/3opFmYcflNkpMryxXjqn+PtI5
	OC1W+dPszwVWXKedqKhVQnwCe0Dk4xeigSLAvOOZOcTanJAXGbyOnODHcPQsEVerhY2YhG3Ikks
	tDt4lzvFwlZLa42Stn0o0EmJbPIhRkCkteixzKzEKVaBUd+lYgsJ2dEfyu3+JRA==
X-Gm-Gg: Acq92OHqaIhov8xjQAB7YL25MW6Ek95rP/vleg7klPQLiaEW/rwZZ1SYwtgPmT+XzRR
	EmzQU0hQ6R633kMxCW1D+eevWbdCT3njy9XLRJ5XAtABrVwsaDyT1ao65VdfCUV5S5IWAgjWHSb
	mzcTIeSOmSTBsuImX0Y9q8aLwBpABbkR2KSPahF7ymeaVRv6//hq5/TxLS9MSyPf3Dtfay4x12F
	LE9cDDjfP3+KK/maJbEgqsm0xM+AZVNvdHQBY3tR2kyWyU46XiboRAtKzvIL2i1UAbXmc4RLRcK
	KREdYZnTZL8Jzv9RdNqpf4n8hECcxbu8BopZJMvjGGvNmkeXmcF6UGACS5nKg30SctHeAE+9hmR
	X602uNCo92nr4Iwx/Ue1x1hYnV3e7gPpYywhahwGSkxuuwOVNl9QgOr4kFN6l9spcd4l+mmg72F
	nRgtg7ryqgeNEIJqtFNOI=
X-Received: by 2002:a05:622a:2606:b0:516:4f3f:d742 with SMTP id d75a77b69052e-5165a01ed93mr213777901cf.13.1779129956033;
        Mon, 18 May 2026 11:45:56 -0700 (PDT)
X-Received: by 2002:a05:622a:2606:b0:516:4f3f:d742 with SMTP id d75a77b69052e-5165a01ed93mr213777371cf.13.1779129955548;
        Mon, 18 May 2026 11:45:55 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:e390:12f5:ed3c:ffd9? ([2a05:6e02:1041:c10:e390:12f5:ed3c:ffd9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe53ab6aasm292775575e9.2.2026.05.18.11.45.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2026 11:45:54 -0700 (PDT)
Message-ID: <fc43b4b6-36c4-4169-ba2f-3453657b40c8@oss.qualcomm.com>
Date: Mon, 18 May 2026 20:45:53 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/3] thermal: spacemit: Add support for SpacemiT K1 SoC
 thermal sensor
To: Shuwei Wu <shuwei.wu@mailbox.org>,
        "Rafael J. Wysocki"
 <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>, Paul Walmsley <pjw@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Anand Moon <linux.amoon@gmail.com>,
        Troy Mitchell <troy.mitchell@linux.spacemit.com>, Yao Zi <me@ziyao.cc>,
        Vincent Legoll <legoll@online.fr>, Gong Shuai <gsh517025@gmail.com>
References: <20260427-k1-thermal-v5-0-df39187480ed@mailbox.org>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <20260427-k1-thermal-v5-0-df39187480ed@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDE4NSBTYWx0ZWRfX64A5rSbO/azZ
 MdO5CyMc6wKwqnGL5yIEtwUogEOf6o5igHSN815snG7tlK2w1Npim6d2LRC3tXrCGIq0NFYF5Bn
 EwirX7jehfxHEwi4YyrXwnnl3HtZeT4tBkMsNgNvZcNX36PYYG/wECWb4af6O0wXtJrYAqhXyAe
 jq+IIPtf7F3FVcQYOJRPnfDsHi0qA0SGBNeAth6n6Y446P236a+6nOT9hCUx4y8EKddISYeO4Dh
 SKmtJa7+TUMGIzJEFzx5zJ9j5kgbtGF8gZ+Kn7Bin0cEP2elY8hZsqv6r8F3kOLvXevSoOXtZE6
 oqH1ktcGcf4vlVAqpXFeAP20Hu33fLxGUvxCN1yRVGgCsYahCuL5MR2ibwDdGuzIGncHEAbr09+
 M3UF4RKvjTVaSCAzU/Lxw6WIvC6PmCMFNtkgLB7WsY1uc/GyDDvMFROowr7UIPbd/Syf19T8WAb
 1+5zt+J33vSB7cI5FuQ==
X-Authority-Analysis: v=2.4 cv=BYHoFLt2 c=1 sm=1 tr=0 ts=6a0b5e64 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=GYkd94GAhdMpQ88-WtQA:9
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: w72cQnPihvfnCNM8YSOPVkBukyJ8PmP9
X-Proofpoint-GUID: w72cQnPihvfnCNM8YSOPVkBukyJ8PmP9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 phishscore=0 clxscore=1015 impostorscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605180185

On 4/27/26 09:15, Shuwei Wu wrote:
> Introduce support for the on-die thermal sensor found
> on the SpacemiT K1 SoC.
> 
> Include the device tree binding documentation in YAML format, the
> thermal sensor driver implementation, and the device tree changes to
> enable the sensor on K1 SoC.
> 
> ---

Applied patch 1 & 2

Thanks
