Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264E63D6CB0
	for <linux-pm@vger.kernel.org>; Tue, 31 Mar 2026 07:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774943534; cv=none; b=Gsqau9Z8ItkUm7TK9OxMqC57P2SX5uZI+akoNM3EIYCYsvWMk+LZxacS95C2XTL6UU8AMf2drtz/jtUC+Vttpy2kI9Pm4jbfp+Gjsli7i3AP9oH9dzG6vCg7GChzd5vIA7Bj2hzFzVF4sQMKgr0AIz30JU+uJKZzh1sZ9pyhztc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774943534; c=relaxed/simple;
	bh=wA78j3kMngBreWSYtMlUJcKXyLiIrYfMXx8sDqogr8A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kik6KskmWwVp9qSbQnOlFrOs5bheq8wP0sN3tZ416iTaoogq2LcPFlXEojY5+XIyvmkzHoSI6rUbcVooKKNO+fkc1oO4bIzhaKZYgaCVxpLD7Bap5lhHcz1R+j/F6LyEQLqNrYx/ioURwShAQdJVm03eqD8Iy5sDqRb0KAiFruE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mfVvHcPw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WfrUzR/6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mfVvHcPw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WfrUzR/6"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62V6DYCF1090303
	for <linux-pm@vger.kernel.org>; Tue, 31 Mar 2026 07:52:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rnMbIIIsYMeq5NgReEDiM34tKVkTHQ7N0Rwb8NCEU2c=; b=mfVvHcPwpzLKI8o9
	NmIVT/KgHr8c6WAxjcAcS+UsXT4TLRDhLH8LkZYaBzoR0pYXG/eheSb876ZwPfw8
	WzZt0d/4ov1kSOSET0IJ+UDnIjNdJLVYKBmCgC8pYmxjTkcNbJQ2lUjpmHraHe9f
	XJ79Q/j0SXrxPsWx3rJmd3kiuPKPTqUfPk6sSKJzX/QqlsHqg4J42eiU8U4/yDP6
	Eu6TZFKFQW/E9I+iN9LrMwDfjmVKfOKEcyOAEomeDiw0h3c1uZ0u+0UoLcupY5Hm
	dmUW9u44bZfmMlLUg66VErkJy82GT7XkBhQPBFIFLtGKn/fEe8oQAiR7+dX+9Fgz
	Nn6beg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d7trd3jpr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 31 Mar 2026 07:52:12 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8cd97debc51so176100785a.1
        for <linux-pm@vger.kernel.org>; Tue, 31 Mar 2026 00:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774943531; x=1775548331; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rnMbIIIsYMeq5NgReEDiM34tKVkTHQ7N0Rwb8NCEU2c=;
        b=WfrUzR/6HKlO/c7KR8h84LwklBWuCm+XN0T8AdGD5cG+XfJPu4nG/kZNmxyF4yvg3P
         WkPUAX2DkldOie3VP5jSOnLhS9e2oV8CXLfbMbPbccUdp6g6PJ2+zykRX9/yFfzg+1/r
         MR/l4C4JWWkpfufd2tZVzb+sQlz7nNvF6dJcD++FbeCiLCv/ZxNOZMLm18WpAJnSQSwd
         gda6gLh+KOS7P2RHOz+g1SNe7CUHmXJ8grxYh3rOD7K29N7GmMuTW7ItZkNrf474KIQw
         y+jsgnHRLBITPWAOwp9lAbLbT0X6ZIdKEnrEbQz6S323h4dPbaohe1QK7OD+ZUY4ZAdy
         ydHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774943531; x=1775548331;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rnMbIIIsYMeq5NgReEDiM34tKVkTHQ7N0Rwb8NCEU2c=;
        b=M8Mq98sLX3Ft5JcC+LhMNaMQTOddZP1NmFekqNlZeAAfnmuB0qU+Qd6aT7BlCjlZX3
         IxI4Avaqg8uxRxg9zI/mtD5CLE54Vvc3YnMhnXMZ054ygB+TudG5VnRgAdixfmkCZvW0
         fkw+7wDu4ItlVlnrsBMPFKSjFos/w3ECsXUAumC2EayH1MksvWcx7/knGcKw7YTi+z2i
         LhzDgumKOMHdR57LmmuVw0P11D5Mu3c2QNZ3UPQnQRs2B1tn8r7bGuWsY7bJbMQIfGSn
         wBxz3C/CuI2XSfRIr6HwoxUdOSOJr/Mo006e6UwWwgHD3QYu8EEbEjnZU+6kD/J3ELZg
         p+Tg==
X-Forwarded-Encrypted: i=1; AJvYcCV1sRSGLzJ4jBvxBS8gqgWIHRqzpul7eoUkxHd6enwyZo+lqRqTNvHHiLv995vCmfU6P1EIWR0mlg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1FfQJrk09Fpvug786shkIkd1lGHP1hjUfF2UXF3rrG4wRLg+H
	62I7HbLOaS7I6RcApyC7aS9tvcppVN5EH3TROrTixMrM1mCj5vkxhd0OOtlaa1s7Jsqw6aop/92
	Y3/VwzHqitfaRfktgfDn5aohOSBl+E43FkliV8y/lyVKty/tIYuqflLb5gBuvzw==
X-Gm-Gg: ATEYQzxSt+QcqkB912YF2V5TuHkOJYVHMMwjJSDoJkBz7/lbOUaY4SkUp1triVJk5n3
	KCjDr65epRgkbQnUD8UEmUHd5/ApjKupf+Kwi1lWtI0m551Pkaw/eBxmI7tpoVPadlTKFiTG/po
	qkF+rOI8xUW1qL/kJSLdl3sYDRBPOLLaIHs+kaaLhgmVHlF7TriCg77H+271EKDF1ggMUK4ZOXm
	VEkbXiyHx76up1OOs9XnJP2jchPu/jtURqo3ULefkXZAy6g1xCHbPCG13r6P8wFK+9Glp+FbzEY
	QLJOc7kK3l9sSzL5k9rOShDYHIeNT+9ymtMmK6aT9wx8KjrWjctVaL4O7sOjw1BMAWmOBraiBu3
	4XjEVXc7F4GEz07WatkB1rDwMEFbXu3ppuWlcZD03fpkIc8BMsH00PyE5p974v3aVXw7S/x0KDP
	MlFjA=
X-Received: by 2002:a05:620a:2a04:b0:8cd:91f5:7a13 with SMTP id af79cd13be357-8d01c379c1dmr1563077785a.0.1774943531458;
        Tue, 31 Mar 2026 00:52:11 -0700 (PDT)
X-Received: by 2002:a05:620a:2a04:b0:8cd:91f5:7a13 with SMTP id af79cd13be357-8d01c379c1dmr1563075885a.0.1774943530931;
        Tue, 31 Mar 2026 00:52:10 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-66b72a6ec5csm3226000a12.9.2026.03.31.00.52.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2026 00:52:09 -0700 (PDT)
Message-ID: <46ab9ef3-bb66-4506-99f7-caccbe99e7ad@oss.qualcomm.com>
Date: Tue, 31 Mar 2026 09:52:07 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] interconnect: qcom: add Hawi interconnect provider
 driver
To: Vivek Aknurwar <vivek.aknurwar@oss.qualcomm.com>,
        Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Tipton <mike.tipton@oss.qualcomm.com>
References: <20260330-icc-hawi-v1-0-4b54a9e7d38c@oss.qualcomm.com>
 <20260330-icc-hawi-v1-2-4b54a9e7d38c@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260330-icc-hawi-v1-2-4b54a9e7d38c@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 2I-1WXvJTRrbWAt7U_MiYNfE0ltYWwxY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDA3NCBTYWx0ZWRfXxbodyukLeVQi
 2WTSfqHZNjeL6ZeLqHWK+HSVHjjj4mI1kbrP20dwX906tOUsSXVVI65JovvYReAGaoVlascz7wd
 xGDGOWYigna4zulVszka6xVVqnDLrpYZyWBcoTdeY6UfCG2f1yIgvHKH+iDd2Wi2qOFznaO68/w
 HLGsm4qaiuiCx8C7YzHbu18doM+b8tB8+E77dYCtcIQGhHzMDV8SND4RhBgzncnnyBvhhjuCVhS
 rVR5rjn3gbk8DkdSWTv2zrKsQtTKRfQczs5EpxubekhH/pcnu+sYC4cZY55MDuCwPOIYh2e9m8s
 Z8r6f8fIjTRwQduyV0aHtuZtSJ1NEOlTl5cFz4l52/q9LOVi3/M5NNh6zOYa8zMM2uPAEXVO6pA
 GDBdOsoVnYLk3Ze4iROXhTWxdKQ+j0/Q7RJEBsgSKGxyi/24pC56ubWUS6Aju/vvu0gA3rEiRkE
 XmEFR2+NdrpqIpA+ifw==
X-Proofpoint-ORIG-GUID: 2I-1WXvJTRrbWAt7U_MiYNfE0ltYWwxY
X-Authority-Analysis: v=2.4 cv=H8/WAuYi c=1 sm=1 tr=0 ts=69cb7d2c cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=EHExEHXSfcFrU6sAQN8A:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-31_02,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 bulkscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603310074

On 3/31/26 2:40 AM, Vivek Aknurwar wrote:
> Add driver for the Qualcomm interconnect buses found in Hawi
> based platforms. The topology consists of several NoCs that are
> controlled by a remote processor that collects the aggregated
> bandwidth for each master-slave pairs.
> 
> Signed-off-by: Vivek Aknurwar <vivek.aknurwar@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
