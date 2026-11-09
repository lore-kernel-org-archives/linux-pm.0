Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794231021;
	b=kw9x4zIEyU8cK67Wtnxk9UuujyE5mtY2UmcFHwwuQrmkz8eeML2gyzjM1c/1yblJiM/H
	 b7q5cpUxm3ecy95qeNgvCvf8RN5ikFsP3SUiPYXiReQBI9eNVXU2xgV5EAzTw9MpQoYVs
	 Ol+ChYoeYxyZsvwbWYrgIPQCsvLiyX+Sjy1CYhS4RR9IbuMFvM7wKKVFR7Gtutxgv4gaI
	 ruy58GyQkWnm583UfMWd0GLgmKe+Z2jLNg041XMD125tBkv8BrucFI26LqU6DMk5C8psU
	 nCN6MkWhGi1IhUV5uFg74lTMYuu/oI8l8QiDl1nIig5AUJ7ywPguH9ix+0Mxdx40DGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794231021;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=3xWoTCJX7g0Ymvrlgv8LUIarTuXZICxScd6KoWd+6ds=;
	b=GSDb+d+QdyV3Loa6KZPyOcf5hWkv9J8ofxlVUTGr/8O9KgzQzCgF0sIUoe2bWp0y8vDt
	 UBeIVJOzZi+EMoeJWNKNKmOkhcAcFBrvk0UFofS2ExH3x+c26xvwIohDsXq5Uvg0YLeIr
	 d/vqI9oCNqSmcBZgAyNJ9mJCv1mH7chmMPPhQlQi8ovXl8cxTasw5vjdnY+qN+FfNr9dq
	 C8oMvtLNZYCwX1VYrjuvOfsCCi7k1uvX3Eq0qYYeuZPMytAt5bp83ST7WvVLYQH2px779
	 C1w6Nyv/cY38fAuPCerpaZyuTMEHyf5FmQ9abUaOZ1nJO8i/kh25p74ln4nIn+YHx1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=HbinuI6i;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NoY695KL;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57DD0606A31C
	for <linux-pm@vger.kernel.org>; Mon,  9 Nov 2026 13:30:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 57DD0606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=HbinuI6i;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NoY695KL
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A9DErpG336353
	for <linux-pm@vger.kernel.org>; Mon, 9 Nov 2026 13:30:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3xWoTCJX7g0Ymvrlgv8LUIarTuXZICxScd6KoWd+6ds=; b=HbinuI6iFwunE/J2
	ndoJp0ER76Ir2F3muz27Qg7Hip0+kV8NXThoG+/nKdcIcW1t6F+Msm3rHsIpQsZo
	om+eiEB7uW1kUdA4n98FK/I9MqtIh3er0T/5ANmFhhrjbv5HsW2qFI5db8T6fTB7
	YYy4JGBXcmP3mu604L8yKJ7EB+tezNWVqxlAt35Rmo2RjSkfAykzCf7X5TBom8AR
	CzrTZ2H6W6i0/wr9eTy5nJ0EvidNXbp/YBKnkfmx6a4KfRufAfLHi8OdqDf1RboW
	6NsBAb2VChWi6J0A/7gb5d5nvxoR+tfc2uWMVIa55LO7ILcf0GZAL2ufZ9EiNXkw
	7BFKGA==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hucr5rg8y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 09 Nov 2026 13:30:11 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-77f133855b9so17712137.1
        for <linux-pm@vger.kernel.org>; Mon, 09 Nov 2026 05:30:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794231010; x=1794835810; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3xWoTCJX7g0Ymvrlgv8LUIarTuXZICxScd6KoWd+6ds=;
        b=NoY695KLpf0/jKbuflSLGuUrmX7DxBwa5NQG0BgduFVVv+xlLz4G7swACOWhdauLmK
         lICreJJGh8JOJbkb2ReTQ9cjzCI1pb7eho+BlrcNn2OxKppP+WsQrxhleCtag78kE9xv
         G+243yRuiF9ejGu/0XWTzmP5ig1bcc6WQGhmNBR2ceiEGkSmis5vN+QLMn7Ro3nzAxlG
         dqNLiuBDPTYFZxc88+rXLG3CmQFJfDbr9L7Uy6vzfvJ4cZ77wqyehN+KiRV1/76gD2IJ
         XIcG71UyEwU9xSKlVMlZoepA0EHR6wyDQXjM+ccq8P38E/MLfjEHlrH6yxHpQStT3zl1
         TP3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794231010; x=1794835810;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3xWoTCJX7g0Ymvrlgv8LUIarTuXZICxScd6KoWd+6ds=;
        b=GAQCrMYEUzhHLEQ0+JncmPg1gAHhUZcJHg80CuJMEmlNetoAARlTJWVmAt1NgNpOZO
         tMyfBIbkuc0g6W8N1w/RzKCEYMI4qHDVrolXTve+sp9YJF8Bsxb8UvLfCidQ9YfhxoFp
         NOFoLNtNCsVyAuVQD+LeF38zdmJJwEE77VyBpmuiw8M2VbWVLYeokXOQzaogvAZNR5b9
         XSJJfmtzEdYPmsKyE2ayMI7dZITx9rrI9/6MpaB9kBLdK2Lw35cgFQnSRBBhRS8/kniD
         Ju3xB5soX6V6bFy9EJmBbLwDfChrlMzPs4RBcLwxJrtrO5f7BRjMvkpbq5D7d/mlGayI
         Gg0Q==
X-Forwarded-Encrypted: i=1; AL+hErE5UXuqiG89/vW8sAOSkh0oy7/mzj1+q91sbXyXXYHTaWAylS2EZTO3unIYqr3JJBbJA3hnIwqrLQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z8bjxe2Yrd+lWsOLl+4icxqo/r4Fkc2dNbh1Gur0VgC7s3z+Xbh
	bzfset/LXIm+iz0J5kzG3Ntx0/fZsTv5PvrGesphzyP0wo+xRZimCxnf1OvkaV91/YxIZbdSwDP
	m5w9c/aBrX3udsNTqycV4b5hXWhjXC3lt84iPbwDlolKJIjh/aBSzXkwzgJad2w==
X-Gm-Gg: AYBFou1N+HiXRRG0Dd6MbpkCisJ6hZ9g5uxeC1ywyzDbAb7ZuhdtbXcnx0IGrycAlAX
	3ESkd0ZEasjivYn8BuBkKm35S7chuZeAWU+2hpKlpw1pN6lBYJOhWjWvCw/agXFlV51agXkeOes
	XaU99Pq6mWGb348t4qtw9u732tnIQIkadep/XRAg65xPBv67oWbarzhUxaft4xK4Uw0XsAy8hop
	QODImpSDYx1Js1dGN4TayK2IszllLa8fukFSWkCJdd1C4/0195DiznhmtPTYpSGrGxXo8OGVfZs
	Wzs/H4shloBjpDh/laAP3c5L6NEhNbis//2n/7NFVosWx2/vkm4e8jpqgwjZYjtINoYJ2nXilsd
	5RFIBeOHm31CGHq4Yo0JkrATFYP180+NCMEtU2m1yY0UpuQP7iLkE8EP6GolpQ4wVvuI99w==
X-Received: by 2002:a05:6122:84c:b0:5ec:b681:f4ca with SMTP id 71dfb90a1353d-5ece73a16a0mr924051e0c.4.1794231009974;
        Mon, 09 Nov 2026 05:30:09 -0800 (PST)
X-Received: by 2002:a05:6122:84c:b0:5ec:b681:f4ca with SMTP id 71dfb90a1353d-5ece73a16a0mr923985e0c.4.1794231005511;
        Mon, 09 Nov 2026 05:30:05 -0800 (PST)
Received: from [192.168.226.72] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d6a999358sm170236466b.78.2026.11.09.05.30.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2026 05:30:04 -0800 (PST)
Message-ID: <f942043d-a46e-4792-b8cc-a00280eef29b@oss.qualcomm.com>
Date: Mon, 9 Nov 2026 14:30:02 +0100
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] interconnect: qcom: Add Halliday interconnect
 provider driver
To: Stanislav Aleksandrov <lightofmysoul@gmail.com>,
        Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20261109-halliday-icc-v1-0-def7cf786f75@gmail.com>
 <20261109-halliday-icc-v1-2-def7cf786f75@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261109-halliday-icc-v1-2-def7cf786f75@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA1MyBTYWx0ZWRfX5p39SkDGozz+
 jypjAs/6+HxYb0p3wHfOBt+OmPAAJt+LXomEA3oRpVXY+XtpL+0RYGPez6qaHrxsMy0W4CKNMNI
 H6J9VS8kKl13sApwyb45P3jB3bkRAaA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA1MyBTYWx0ZWRfX9+xIv66z4EIz
 GtktSg8IKPRKvC1jRWFoOrBrIq3CnC/2uwLKQjkXfHO4mGifYv3UxBycwYmsN+JXN/kopR3ymdT
 7gI5adNqCQNglvOzY1enktQg4H5Sh743H0zCK9rWHvwVDlrbSMLCOYijFMtSeg482AnT+P8+RHt
 bGM9ZKirIvRYYX+x7gdchCahiTjYdXD4EfkEbecMnUj60GK938mdbzPBc+bZt5k7rv4BrAlqxya
 gw91HHUxAav5pyJFV1BMt4Fa7aInLiiwyQA7vx5/noTpTSUj3c3wCoua/BmoynuAFv++/zlDPaV
 M2n28gS34gtRQXe+N1Zx7yOpuh0Wc1bZRyJm2EewOq9IKLVhXAjxejkNix6XLtP3QZ6I0jQa7AT
 Gnh4vj0wRESNLpsBTiu0Pa6SeDvaoX0SXggSvB7cr27X1qmQOBq4wCAFUg3dHwMmF223zBYh6Mn
 93SbOSf0988MpRED+yA==
X-Authority-Analysis: v=2.4 cv=ErlHPicA c=1 sm=1 tr=0 ts=6af1cae3 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=s7ymY0F4v_VPunFmiH8A:9 a=QEXdDO2ut3YA:10 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-ORIG-GUID: nQWVnGzwl6B-papAYDM79lfJmFC4QbJS
X-Proofpoint-GUID: nQWVnGzwl6B-papAYDM79lfJmFC4QbJS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 malwarescore=0 spamscore=0 bulkscore=0
 priorityscore=1501 suspectscore=0 impostorscore=0 lowpriorityscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611090053

On 11/9/26 1:29 AM, Stanislav Aleksandrov wrote:
> Add the driver for the interconnect buses found in Qualcomm Halliday
> based platforms. The topology consists of several NoCs that are
> controlled by a remote processor that collects the aggregated bandwidth
> for each master-slave pair.

[...]

> +#include <linux/device.h>
> +#include <linux/interconnect.h>
> +#include <linux/interconnect-provider.h>
> +#include <linux/module.h>
> +#include <linux/of_platform.h>
> +#include <dt-bindings/interconnect/qcom,halliday-rpmh.h>
> +
> +#include "bcm-voter.h"
> +#include "icc-rpmh.h"
> +
> +static struct qcom_icc_node qhm_qup1;
> +static struct qcom_icc_node qnm_a1noc_cfg;
> +static struct qcom_icc_node xm_ufs_mem;
> +static struct qcom_icc_node xm_usb3_0;

Please take a look at the newest files in there, you can remove these
forward-definitions. Otherwise, I think this looks good

Konrad
