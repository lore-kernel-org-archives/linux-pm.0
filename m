Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD542D2397
	for <linux-pm@vger.kernel.org>; Fri, 17 Apr 2026 15:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776438167; cv=none; b=R5I5mR2o7uLzeqx0MRMWWNZOF2AVkj4cNbffKhfqiG9k1vXD71svLog/gJ3Qje/kECj5s2+Fh3rIFtK8ScUaK35mMMHFjAgvh7DV9uhGvaBACL5go+vg76WCoXQhWE8QJ0FZSWPwKmLygxYuTQX/blSyYcjdM7tFxYBrX/Q7DzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776438167; c=relaxed/simple;
	bh=TB4uysZX+yKAAaizGg3cEtRW95hbLHNXLsF/d8v5sSo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iOspLhLZUjaSR5FqubfuUUZbbtcdSnPGIOsY99jH9O0gxOuGA+g/Erj/o9QuXL1XF8GtnX/6aXKEPkB1hwbubxD5VyzBLzfGUtE0T8yZyrDOMUOlzD5ayD2xFqnvaWvO0p3guOq6Q8sdrnNaI51D2rdon6nZdctl30o8MLzlzvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RTbaIPW6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cyhRepV3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RTbaIPW6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cyhRepV3"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63H8nprt3100157
	for <linux-pm@vger.kernel.org>; Fri, 17 Apr 2026 15:02:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vvYOA31VxKI1M4G6uJTyxEANmTlV/IiNEokXS62edho=; b=RTbaIPW62uayqNWq
	mYec3+8/MX0c12h/ejiOe4aYJWbHi74hRhLqc3dBMKpf8GErD/x0iSM+P/xGJ6fQ
	DKMl5Gblp7pm9PmV0IVWh0Bn+POEOY3YrAL5iVghVFZRRoIlToGtFjscl3IrSK7A
	3LxX676mJCXRAME6EAYt1p60uzqj42HQlz0IsS8RlTLZaOmzUmVyG8irMQNf+3JW
	K4qg+QEOHgGkpUsGHd0W3GA2c4S98A+OndZZIfPnUZUGTjnSc0Dh9gKigIL9amJ/
	I/TilqSOZ6jKhjyi5e6DFduZewOy3xByS3G5HZ9qmnCmmD4lYOTw1jTYTybEcGt9
	UgKrlw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dkhpu18km-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 17 Apr 2026 15:02:45 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-35da97f6a6dso814148a91.0
        for <linux-pm@vger.kernel.org>; Fri, 17 Apr 2026 08:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776438164; x=1777042964; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vvYOA31VxKI1M4G6uJTyxEANmTlV/IiNEokXS62edho=;
        b=cyhRepV3U3JuiAAhg9+YygIUbvsmUXcGBOeWaTW579w9KxxBl1aKJns7Vk6tYcjCnZ
         mxXFWqbp8DjM1wJ1hzd1BgBr4Nn/Ja9Buueayoi2mAynD8OCEHXOAPz+KUxA96ku0GYq
         MPw+JaHhtT+g09psg/qTRRFtuV7aYuFCO7N3C4QnnHrZiB5d0USkn67H7Mgl2F/2GR96
         +FzTsRwxLydkPTgZYJJ93BhB+MPjlxfMBQBp7hiSgwSjUcfjrFtGcSdVtptMYLGc2MzH
         iXmctemUwNJLKTB4zOm1/d18nq+na+hL6G0TldpnGLX+8vscdReszIbls8imCIOf+KwO
         0suA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776438164; x=1777042964;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vvYOA31VxKI1M4G6uJTyxEANmTlV/IiNEokXS62edho=;
        b=gyYrD+9bQR1RJRY0WJDcd5bnU3Qha9ZVPrVQNeqJnHECK25vxrw8rUFNwZR02lfRoC
         bpe2+ARRl0vXiVAJ1Ddlc3pk6ipbxSoNdMJlShlectKUST1/jeD+ArfzOA6QEeaI/IcI
         Ah9942WsAQNpHO1ZKPR8sfvrXMV3aHvErAxmSSN0yDVJMNE9dZ762jGVO/5IqhiijeiP
         Yu9BoHiQL79ytnhws9yRcCPd5rjm4SWKha4COIIBoZjZzL781peruoywF7hNm37PScpy
         kNEzxDSIAeAb68CGBnvuhqgGxlxSecS2EQOHsOh0/ceekxOE0LQ2hMR/DGMxOE/fL11A
         Dhuw==
X-Forwarded-Encrypted: i=1; AFNElJ90iBPhe6GWa8/0hREldsdu4Z1oPvxvTOTrW5acCPvUhBLMUc0G6EpnWLsgQo5YroYlnA5hNhNZHw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz11v6CyF+bqYshwrWx+5qRC3DppV461h505GQX8cBRSTgRVBtT
	JTFl4e8xuGLi3TmPRa5m6KMIjaTx4ixaVcBzZpHT7iGB0bSDSMJrNdivTWXmG90sV3A3SBZRBr6
	oqz/XBjMPbD1egWnaEHdo4WMYqAkObLFeE/WHQORyCOGwS4dQWKQQuoBBO7wB3Q==
X-Gm-Gg: AeBDieukSOdUwKvzZImIZRR8v2q6rLr2QOemoBo9JnnlUiuzPgoQ1fttmJ6nbcv1Bx1
	zFmpRWTrmfn+t3IbR2JNSKTl6VWf1AZN2fzd2e45Obycs9tofPqABYx4HRQhb8a1i/egD3ZY1RC
	g2ZPlZZSSCM17YOA68Udkkxrh4cQc88abHLvzv3C20w65uTp6LXFfVBPmXC/qh1f2cQaIoWtWjD
	6nzPdZVO69UzTsOK1JRckPhffcH7H3IDjYZGX9mQBUcDsGzNRUOpGe78F2t1GNsmiQzCvGYeQI5
	COL6ZoNjkPyEFajyVrh+pTxkiXuoiJadR2jUpB+LtffHh7+2JOjX56qZTKq+DoyfFbGQXxUipUe
	hHNvuXuCoFpC1XI6JtdtL7SX7Fahz/d6mg5upEDG1Ao6Qu8Nxvn38Prt4etYmr52t+kN9umhvsc
	RrYryYwZYMP9m4r6jMYmA=
X-Received: by 2002:a17:90a:d40d:b0:35b:e5ce:73bb with SMTP id 98e67ed59e1d1-361403d61d5mr3461863a91.1.1776438164149;
        Fri, 17 Apr 2026 08:02:44 -0700 (PDT)
X-Received: by 2002:a17:90a:d40d:b0:35b:e5ce:73bb with SMTP id 98e67ed59e1d1-361403d61d5mr3461715a91.1.1776438163343;
        Fri, 17 Apr 2026 08:02:43 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:ae20:597c:99b8:d161? ([2a05:6e02:1041:c10:ae20:597c:99b8:d161])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fb7a06f3sm22656615e9.22.2026.04.17.08.02.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Apr 2026 08:02:41 -0700 (PDT)
Message-ID: <1d111777-d1f1-4737-9dd4-3a1205876a2d@oss.qualcomm.com>
Date: Fri, 17 Apr 2026 17:02:40 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Pre-CfP] LPC2026: Power management and thermal control
 micro-conference
To: "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@kernel.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Christian Loehle <christian.loehle@arm.com>,
        Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Pierre Gondois <Pierre.Gondois@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Amit Kucheria <amit.kucheria@linaro.org>
References: <CAJZ5v0jp-xWc_7Njjsva3EBhJXM31XVBpSspSkTd7FJ0wz1ezQ@mail.gmail.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <CAJZ5v0jp-xWc_7Njjsva3EBhJXM31XVBpSspSkTd7FJ0wz1ezQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Kd7idwYD c=1 sm=1 tr=0 ts=69e24b95 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=AZOz5P2jqbQ3Gj4Ve7AA:9
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: xSx_b3fZ1bMWMd7dGyFF5H0lGYw9oX4i
X-Proofpoint-ORIG-GUID: xSx_b3fZ1bMWMd7dGyFF5H0lGYw9oX4i
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE3MDE1MSBTYWx0ZWRfX5MS+UcgQTuJo
 qA8voQ77xzmtTUJ6wx/ViJkI4GGGFjBVLW/pguPyA6480H2/VTMnr2pd0FOLsAskxEXUEcSRrqO
 B6yMCUt/ktvq68ynUc4BthP5PTm6yOE53cpzZuGXFXXy7wJLTh6k2DwlglakndPx42E084LDj9q
 62ydVxnhEzjwQQqndwRbuUFEsDdBbt0ePFzmAL4koSbdhmHFNiXFDHenRb0Oxxj1cp2heSrgtZb
 ovoQlSxbMOadN2MjDHJL8HlbzoutPZ0tH4ZMgXpMGbQ39DfbrwN/7ZPl8IwxCk9TccKwUXXOSOX
 cgFgpQkJ4zOyL9mQ0t6vIgI0M1WiOTnE0qm/b58mSXTpc66p0OXPvGrfjlAIeHLU95qtAAUS8nL
 7d5aucEfkQFycBhx6O1kXnk9hzcdq/gEC8/kjeixedDxIO4gX8BDk0RLPWUHb8vfPaGr2pqHLSd
 lDjmQRoQvI7lG/ig2lQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-17_01,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 adultscore=0 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604170151


+ Amit Kucheria

On 3/26/26 15:35, Rafael J. Wysocki wrote:
> Hi All,
> 
> I'm looking for topic suggestions to be included in the power
> management and thermal control micro-conference submission for
> LPC2026.  The deadline for submitting LPC u-conf proposals is April
> 23, so if there are any topics you'd like to be covered, please let me
> know within the next 2 weeks.

I've some topics to be addressed regarding thermal issues, limitations 
and enhancements, suspend/resume limitations, powercap enhancements, 
user space resource management and may be power supply.

I'm still in the process of collecting information, sorting them out and 
doing a selection of what is the most relevant for LPC. I should send 
the selection in a couple of days (may be 3)

Is one title + a couple of sentences fine for each topic as pre-CfP ?



