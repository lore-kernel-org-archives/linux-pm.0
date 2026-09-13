Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C92339377
	for <linux-pm@vger.kernel.org>; Sun, 13 Sep 2026 15:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789313112; cv=none; b=qYHkqoW8ekH91qNrPhXzEYVNb4XY2ypWjuqzx27Gtt9jX2SIlqZfQXc0BnsSnu4vOO5yDq7qCu6kvZJsDe9tOfF9rSPDm01GzBcdjiO6zGfd6KIhFhOsJcfoUEKWDXWmwC43FLKe10UwiSCpHf1h1pqeoqZEylS9gmYjFKOlwG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789313112; c=relaxed/simple;
	bh=ld4R1jneXBW1hGoO0VRUWX/Y4qVOEP+XupoaDss+ItI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vg9/OOWv5GJfkRlzgJ35v4cLLYFBzWKgQPtmojEtKV0zGEfBR3wVoKkS/mshORp7jlCVgU+nJhwxw2h4ZEUnQx5qR4DCBlIiMxDSGrsJrlo/1IaQSqPZuQZaFih1EMz0zdd2x8hQJ/DbeAfp+HEaXlG6riKECgO20Z2XRAjwh5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UClpXggN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kfSCuwFm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UClpXggN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kfSCuwFm"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68DE017c1951276
	for <linux-pm@vger.kernel.org>; Sun, 13 Sep 2026 15:25:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JJ8vr1mNWBrNs+oy+VzKW00DnpjkO29odTofhcUnTGM=; b=UClpXggNDGnUoju4
	8s7pg2DMW+aMyZIUBvoIm3xqhEDNuIZ4G7sd4CZmdYMnHd9zDSUsG5sjzuWrZDYg
	qcVEOykNpnfBaM7ZnrgJiKY4L2LJZCYnSRsf7WlQ/j0Qy1Mq+Li9c58BMLT5crGK
	p24eMVk9QrUCvPcDchUlxN5jCfOie3h0kC2kYxMJblMD7ubKLtio4iDmTlsw66xg
	cyLXq+/xwyLLBs+OnBgqkVROVXdGzl0r8tcDDDGFaQ0xLcMvAt9PNDekthiXMMql
	YhphqN8MA4xiN0Yy9MKDIVHK6ojMwvU5xHfOmCySmeQzZyAhh/cX9+QiEU3mjX0F
	jwC9Vw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmy9d3jar-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sun, 13 Sep 2026 15:25:03 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cc489e7a701so3569732a12.2
        for <linux-pm@vger.kernel.org>; Sun, 13 Sep 2026 08:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789313103; x=1789917903; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JJ8vr1mNWBrNs+oy+VzKW00DnpjkO29odTofhcUnTGM=;
        b=kfSCuwFmeAoDKRa2E6ut27zPUILuazd2eQSuCF56wpXRAas+N5VntdtbODwIkYSVCQ
         t6qhgXGPivLu50pzNGM65Ka5q4TVtCpG8a4cCiiCvW/yO/d2MTPFXT7KU4Qd+ocr6E0H
         PEI6ZRG+mRNIKRE4HwSE3wKhJVt5rvAH3fv9OkADUvuG6dR/ewdEF9bgzXYnCsQz4vIU
         mNiq4WUWxmq/NgeI5oIj8uuO2zwTYNyo8pmPb1n1fVcqJ6Bbq40zdQpdAArhX1PtYetD
         zz2v0JFSCZ/VcA8xurDuX0gYtjSeIq3bcTkPJkPWf/OIjC20LL4ymj1GIAyRV9iQ6xGM
         amQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789313103; x=1789917903;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JJ8vr1mNWBrNs+oy+VzKW00DnpjkO29odTofhcUnTGM=;
        b=rWH7AMVx7j2U6OGEhbnpsCT6v3dIwuoM8s31XYWr7ycCApfXQztqmclOsmlQOaUsUM
         FjoXXngPakKHr86Z7BPA0jt+eXu/oE2AtA2z90pKo5giExprXjiXeQuDKq6IG9t+bePE
         xFkOJ6PXAXWdkM9T/coQsLr8VRw8PWpIARsmkgLRUVmOagHyC57pOAxgGwiWJeaAp0qK
         W+pp1vMhJvz9wHSTDcypbWC5BTv7H87yF8ArqgDeu0Q1V3ApHY6/ZXkGlS2OhhhxNlX9
         BYDHLGsdtVB8RZDy2IeWHaIJdLrAKNoRPcLPLlgFD9UeYnmVhnMjbDcph5c79E5aSusl
         qZBg==
X-Forwarded-Encrypted: i=1; AKwUvBx+/tEZ9LHUZM1JJ2B6ZPZknwq2n5IvEXRJ5n2vqSw/u05I4UhQdS4e7yV8cG0kYsaJqLqEJS0GFQ==@vger.kernel.org
X-Gm-Message-State: AFuF++kxCUpGZINxjtjsXpq4r9QESWK/I5Gmm3Knug9LHmNLC+EB8AxX
	RPW5ruToIO0CQPL4aSTMwpFtTMh8NlI/RvRrFv8oIztI1td8SbcvC6Afxw+HyIkYw1uEeMGhPJT
	8pmgGf4h15PDv5HNLKWAmuiMyJMZAZFXQCM5FKlDfpkmDDsT7LxKQpK+18x3cqQ==
X-Gm-Gg: AYBFou3YjO7tWFP2J0+kEN1QJ1ZEvPacYau1oYkOUR9+8Mo0uogKMX/MoJjtSB3XyhC
	ljXK2R6Qx4sd5rwl4m+m7K9NNsF5f6rq1IpNMc5wfwrb7IewqTeDd2CdV3FM5KckpHTlziEIN7K
	oka9WY2pmQ/BXY0suvAFwXglFnib8hHdY1IKGXvr9xQ/1VI7E+9sAfLZe4kzrWb3qOCKjWJLR1p
	lIVIKsts5eoF70kGGYN5orhUEPWIetUWbqPgPmr+kwFXYhTGrs8OK+Y2g2wmpw/PRIdrgZE0bDS
	us84GC/GIK+3xrwuvUa68c/imd+RXRBGpOWPnqvxojmu6V3aFGwDvFTUGZhEGGcjxlez89+k/Q1
	fcT79+kD7x638tmT63sK/cW7ejdyeDiMNof8=
X-Received: by 2002:a05:6a21:113:b0:3cc:8f53:26c0 with SMTP id adf61e73a8af0-3daed31ac42mr27011622637.17.1789313103247;
        Sun, 13 Sep 2026 08:25:03 -0700 (PDT)
X-Received: by 2002:a05:6a21:113:b0:3cc:8f53:26c0 with SMTP id adf61e73a8af0-3daed31ac42mr27011548637.17.1789313102860;
        Sun, 13 Sep 2026 08:25:02 -0700 (PDT)
Received: from [192.168.29.31] ([49.43.232.43])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4e9a8a9sm19916161eec.13.2026.09.13.08.24.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Sep 2026 08:25:02 -0700 (PDT)
Message-ID: <9345454b-4e31-4224-980c-0066c912252b@oss.qualcomm.com>
Date: Sun, 13 Sep 2026 20:54:50 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v24 05/12] dt-bindings: arm: Document reboot mode magic
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
        Bartosz Golaszewski <brgl@kernel.org>,
        Sudeep Holla <sudeep.holla@kernel.org>,
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
References: <20260803-arm-psci-system_reset2-vendor-reboots-v24-0-889281373870@oss.qualcomm.com>
 <20260803-arm-psci-system_reset2-vendor-reboots-v24-5-889281373870@oss.qualcomm.com>
 <20260803140222.GA3188037-robh@kernel.org>
Content-Language: en-US
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
In-Reply-To: <20260803140222.GA3188037-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEzMDIyMCBTYWx0ZWRfX72l9Cv0v2RF/
 7ECwHGpsgjd7LVfuUI5uOu7L8c7t3aV2CvCpqJ7PHzmJJQ4e4y9lXi46VoXuJ3XkEqEVLPPx2Zx
 3WmJ76VIrb698Vj/Kf1Bi1Ul9c+v9Qs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEzMDIyMCBTYWx0ZWRfX8+jrpWW1jzNw
 xP0VNpTcYxH8yKFitJNdbZJZsktGYrwe6AayR48iavwnuGl7BHOe9pM/0cvY0TkOdFCeCeqO9rY
 ETBTcGLw+wKh0SkCcJJqC3h5JcRIXYvMqPmfqwuBmLdf8EtvIbFNfGZw6CShR7D+VTHkFwpaX9A
 WhJ7uWqueR6rx3j7rY/EWmh1PXSaHUbA/R+YdKcFjUkDV27+q/+Hik7aC1GHOr7opGMkrFYBY5g
 +CnMVwsPbpX4bgJH5fZ+ZXoIddqENJbZQE1LUyEbaHi7T0EL65d0iPVmkhZu1K2ghnQTXHwa56n
 wjfkJiY8Dtg3cgZ2ZFBUKrelqAxB2fGwCKLbVBea2K+gl35tmSXc6FUNSV056GvIPNH8ko+wF6Y
 jdvYiE8QznbhQbotKaFUl7o80JUoLxbFc838kopvVOhMUapjn5214vdyW0pqWFPTNlqXmavoM0i
 y5m8Rke0Jw6HcDAE6Mw==
X-Authority-Analysis: v=2.4 cv=IOSXmQvG c=1 sm=1 tr=0 ts=6aa6c04f cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ExSUBmHX20r5BGnuCy1yUw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=q4JZvQwPHRNDhfj5UpAA:9 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: pkbx4zQpDMfOfC0L74jVaN9wL0OmYqN7
X-Proofpoint-GUID: pkbx4zQpDMfOfC0L74jVaN9wL0OmYqN7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-13_05,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 clxscore=1015
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609130220



On 8/3/2026 7:32 PM, Rob Herring wrote:
> On Mon, Aug 03, 2026 at 03:13:36PM +0530, Shivendra Pratap wrote:
>> Add bindings to describe vendor-specific reboot modes. Values here
>> correspond to valid parameters to vendor-specific reset types in PSCI
>> SYSTEM_RESET2 call.

[snip..]

>> +  - if:
>> +      not:
>> +        properties:
>> +          compatible:
>> +            contains:
>> +              const: arm,psci-1.0
> 
> SYSTEM_RESET2 was introduced in PSCI 1.1...

just wanted to check on this.
we have a max of arm,psci-1.0 defined in compatible.
SYSTEM_RESET2 is already being used in some cases with "arm,psci-1.0".
how should this be handled here?

thanks,
Shivendra
