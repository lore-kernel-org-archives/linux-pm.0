Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C833BED4F
	for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 10:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789986578; cv=none; b=mVWxf5hu/LTUkgzxEP/HiQvkQLLIraInDoOaou72QVwPv339J8ZGLlvJxvWUT+gb8zlj7dKhSNCF7c5Mlmqcfox9XHPizMW9mrTVGDQfL9hm5lQ87rhRbMaWvnixQ5wL0ElLAIAnRIPrmscbKmok8emc6B04MCEg5w2POmQlCpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789986578; c=relaxed/simple;
	bh=zcOJMzXLl69/p3oVhEE7hTMKifMoLsS/KeY1YBgSWAk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EM4qTU1X2cNjZv2OzsQZS7X9wePweDTQCZ2K1G734P6SIxn+6iIYwivmUaZz3TWbfq0S+mfTYVO4TCwumM0VaNG+zkh6fIIqaRhDRQ8GZGBbuaFbk9lq92t8UBLa7Ic1YbFqTuI/zyRFlYJUNlEkL8RIrqZrnHrV26uaCc7JB+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LUlzHn8Y; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OI6iOVCR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LUlzHn8Y";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OI6iOVCR"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68L79uHI1624384
	for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 10:29:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	er85m/VpcaNBY8p0HNqxGDH04XxFCaQjcVPnP1W36m8=; b=LUlzHn8YRnxEXbvJ
	XKG1aPrc4ADfe5ljDpO39tdY8iQBQj3etE36KwnOG7OI33BORLbPEmIHiIhaH/yB
	06UpGp0i0/pCDsykgV8t1r60dbrVjGREQesKRCOiGG5x1MZnkytdgxkf54fN5o/v
	rfZlF8i0nGphho/biw5plN7bUZYGqQiXW/Be+z7/iQrErwC29LTvBziqo3fCoyAc
	RWnwZMBiWo1j6oEX2oS/6g54pUVsXRfu0uNSZv2Prx+ubEwVyiMg+65Yo7trFjp8
	JWCenn1jAWhtKLKbTH36jlcybklQtb7+rtYuME5LZ59WlUHtCEh3aCZd1xXYUxg6
	YDegUg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gtt3wsvsy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 10:29:36 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38e1118e4abso5192999a91.0
        for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 03:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789986576; x=1790591376; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=er85m/VpcaNBY8p0HNqxGDH04XxFCaQjcVPnP1W36m8=;
        b=OI6iOVCRiUerF/RG9pzGJtGCf0l1tU+/ilM2Yn0+At6WOYDjkzFoKh6pXax1Ffu7bE
         rDlyYLNtYMEL4QsnVb5zxEjuQvXt3PljUplOAXiFoElbvvmrmAak8TmfXTWXnEIANd6l
         /SmLFjXAG2tkmualXNtIY/BbX1XVlysNP1/cEVrLjj8UJEAN31fQMCyM7rUb5xeMBs9M
         OuizTns2gTzPxKCmrz4of5BV3EdEa6f73t0xxguWmatmZNjFlC2jbEeJu2HMfGjahcLV
         xLVAC2I5Y4HbwiUOmmzk77Xj9xY6IOONkYgtE9D4nwNnr9Q8OccvO7nytjwGU2VTQDdF
         ULAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789986576; x=1790591376;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=er85m/VpcaNBY8p0HNqxGDH04XxFCaQjcVPnP1W36m8=;
        b=al+jbIp/xbwvzFFrUkhHfVqSQwina21EERneUpGGb3uRWRe2YVEsbBFeGNbXjB/G80
         0jwueQVydjwS8KHcYzkUogp1QDUevWPlKijqsyjcoQHYvfjrj0bjefZjU6xXxpjolgSA
         hv57PLazKUisHbGVRmDjP5zvXJoyBDL6XpLnoFbakvLzq7whjl9kFn5HgqYUBP8uaw2N
         1V1C4pbCqqsxGz1AaW7h0MafSn3k505CVOSQ1WV9B2O8BtmcZ9+1xuNuLkPBqwlJbsdK
         HmrQBTRIKxXU/Ej/OYk1AOFLvgmyBxWNCjRAqfRB03sX3kv58nf7oeOARWIruleJUsv6
         7OIQ==
X-Forwarded-Encrypted: i=1; AKwUvBwRjpd1Lc3cORk/fuQR/l7D2MojW7g5hoHkc7WkHLnof+8iWeIjxajhWh2tWVbj6pzd+7CqNOa5rQ==@vger.kernel.org
X-Gm-Message-State: AFuF++lsvOht0VWcSpVj5pG98cX72YsSo3ObfxN4l2NaJnPMftf4CDq7
	sBMd2U1NBW+xvKWX8VI0AZ6uCXlj5DarAWssPv8nzi8KadLqdnWeow9xP/oHdLjIwl+SObcVEQv
	RlTkv8mWfVTEmBc82VmxMhsyb50nPt4tSJQCiD4MzCHW4ZY1tHsnCvk3/ldHRNA==
X-Gm-Gg: AYBFou0vDj35NTH7Fhw8G9P+WfQEkhupfPq8zcQ3SybiZchz9sz9jbfEPhai5zhM6Am
	yRQ3F4j4gDOLCX+XIge0aArYDHSAuKLDJkshiHic5SPXUnK5AM5swpJ9s2ch9t0LPhLQb/isVWV
	0BZClLVzBOpzitP+XvE8d+MZqK09FEryMrKCDnl0GjEGAmaFU4f9+9G7CmTf8o5uRhmAMP1NxD8
	KvjMj6M5enk4ttepxuHkoQPhrmOPzjJ4OSCkaCDMQOIlqhFErGCynG8WUKcWDSqKhEsja/eUCFt
	VFDHGFDlHubK7UTWjDEpmXkPCgIuiTYUfMt+2BUt1EbqVfnUwgeGI5wjQBMXX359jsCzSpwDIhg
	dVi0oCKskm6z2Po0u5/1oaYjYwmV+eVs=
X-Received: by 2002:a17:90a:d40b:b0:3a0:574f:5854 with SMTP id 98e67ed59e1d1-3a0574f5cf6mr1247952a91.39.1789986575748;
        Mon, 21 Sep 2026 03:29:35 -0700 (PDT)
X-Received: by 2002:a17:90a:d40b:b0:3a0:574f:5854 with SMTP id 98e67ed59e1d1-3a0574f5cf6mr1247934a91.39.1789986575299;
        Mon, 21 Sep 2026 03:29:35 -0700 (PDT)
Received: from [10.218.9.75] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-144da432647sm29762133c88.5.2026.09.21.03.29.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2026 03:29:34 -0700 (PDT)
Message-ID: <0e6877df-0306-474f-bc25-aa7d3fd2f53c@oss.qualcomm.com>
Date: Mon, 21 Sep 2026 15:59:22 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v25 05/10] dt-bindings: arm: Document reboot mode magic
To: Rob Herring <robh@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Andy Yan
 <andy.yan@rock-chips.com>,
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
 <sudeep.holla@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Andre Draszik <andre.draszik@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, mfd@lists.linux.dev,
        Srinivas Kandagatla <srini@kernel.org>
References: <20260914-arm-psci-system_reset2-vendor-reboots-v25-0-4aaf5c09b5c2@oss.qualcomm.com>
 <20260914-arm-psci-system_reset2-vendor-reboots-v25-5-4aaf5c09b5c2@oss.qualcomm.com>
 <20260918220634.GA2441717-robh@kernel.org>
Content-Language: en-US
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
In-Reply-To: <20260918220634.GA2441717-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDE1MSBTYWx0ZWRfX1YoAchxkUBVQ
 yskoe9dLiUwC4J1XSXpGZvFR7uxKyzMTlDPFMp2ZXnhYbufhY4/6H26Nfxf/eoZxLO6Iy/MqyQ7
 3SoLSqOvs/qakyFD4gH6C6F3MUx/GJtbNnQ1L9l+PmltCvpKx37MGd/jfHqLwinvuvEqH/lM7Dl
 I9bj1vUEx+/GWDZHZgShc5XihSJfHP5LQNklZjLTVSyrHfnawla0Vl7pgwHYsd7ECvlqW9Ec+PC
 uqu3tdoIzvxWj/5RJj33DIsoaOgXK//lDt5GMa7hTeABUUvXfZsOugq49ZcbtvhExgHp+W4BgIr
 9SGamtvar9KG7qZ9DXFRAeC8GLlVwI2oETgaSdi6ScvXYnyda66cqIzlrLxXkZAP86Wjhz1B2ke
 e7TdAGZDKJJUBaQKcnB7e9z17KebCBZlsJaU3pmx7ShL8dp/FTxUA4r/cfxHijFUr2MY0858beR
 vnHb+iTjwcvjo6ID8CA==
X-Proofpoint-ORIG-GUID: ILqCrWXtfvp0skzm-So4q4gfpBZUtdtA
X-Proofpoint-GUID: ILqCrWXtfvp0skzm-So4q4gfpBZUtdtA
X-Authority-Analysis: v=2.4 cv=dakVTnXe c=1 sm=1 tr=0 ts=6ab10710 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=8elzRJZBfmQ5qZguGEwA:9 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDE1MSBTYWx0ZWRfX3rEY6hJ921uu
 FaboGx5hTrxPKC4g3f+q63tMzyJFmZx7H75UUlxdGxEneGG4jmia2FK8TqDintz0Ps7ml5oX6dh
 F5WXXd+vt+RNZq2ZSYtH0lztEv1x0c0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210151



On 9/19/2026 3:36 AM, Rob Herring wrote:
>> +            minimum: 0x80000000
>> +          - description:
>> +              arg2 (cookie_lo in 2-cell form, cookie_hi in 3-cell form)
>> +            $ref: /schemas/types.yaml#/definitions/uint32
> Drop. Types are per property, not per item.

Ack.

>> +          - description: arg3 (cookie_lo in 3-cell form)
>> +            $ref: /schemas/types.yaml#/definitions/uint32
> Drop.

something like this?

   items:
     - description: arg1 (vendor-specific SYSTEM_RESET2 reset_type)
       minimum: 0x80000000
     - description: arg2 (cookie_lo in 2-cell form, cookie_hi in 3-cell 
form)
     - description: arg3 (cookie_lo in 3-cell form)

   description: |
     Describes a PSCI SYSTEM_RESET2 vendor-specific reset type.


thanks,
Shivendra
