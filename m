Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950FB3CC9FE
	for <linux-pm@vger.kernel.org>; Fri, 10 Apr 2026 15:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775835729; cv=none; b=VCkVPxt9HZJaPgrsx9rRZj4C3fFXLrHjk21AWzg4ye1vnxNdbzcoTEUsmSUljxtb/eMJt+JUu4QI+h4IpqXj0Zp77vpCfh/aCEW6pF+W64gPZwSo2SjEWIlTvLjJVNOKV4FqpI8S6qk0W0ELfb/+MgO0PdKbguj93F+MgjObC5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775835729; c=relaxed/simple;
	bh=xIVUY+Pbg5/QfKf7tkCdKCtUq81gJSTuDxFQHY4fwOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sE77PIHfZ357p2ML3VPeysoGcKEi5yM38G19kv+PRlVFO09rD99Fyi9G9Cq0V2kQuuRS15YRIU3tYbBC57tnseWsuwAx7IWcCX7QfS2WdVStCjfzB5CNf2oQglr5oVg2b2GYOyicc3QvAoHhfi4n3ZDvZQ8/r3RnGEylzuV57nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OqL9tOyA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OjPVtr66; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OqL9tOyA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OjPVtr66"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63AA5cPB1498620
	for <linux-pm@vger.kernel.org>; Fri, 10 Apr 2026 15:42:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=uqIH26VW1DMf9T7tCXVZqQOX
	a0zE5Lks7d0a2XG7EJM=; b=OqL9tOyArpbnVHCfupxXUVAzJAmzzWPrObveAXHg
	dcHRlhTD+emIPU0fbVHmKp3DNXGAgBRvzJ34YIM5/MtndovTK77DdDNVaoByJkV0
	ZGgqK9bty1/mSsRlymsWRgQI5pVdAmFObGVh0gTNBGs7LlHDiGZKNLtnyftqtgcv
	ANrg0WDgiQrHX3Q4QbqOQTaUryDxsV6x4KKOX130fgNfuTlN8e9ZigkFxQEMHgv4
	Ps9mqJa3DMt7GYkY3WfikZYe54TpoQC3e9WinQiqS4bLcIFVZ5j2rhLeAie2q+0P
	JPgnMjoTxn7NavB1n+qLGQzgIm85mz4EB8gp2sWXqxDlkg==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dey5b0yut-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 10 Apr 2026 15:42:07 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-1270dcd11c1so3260011c88.0
        for <linux-pm@vger.kernel.org>; Fri, 10 Apr 2026 08:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775835727; x=1776440527; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uqIH26VW1DMf9T7tCXVZqQOXa0zE5Lks7d0a2XG7EJM=;
        b=OjPVtr66I+Kedymg95P4S8e7s7M/GrI27DHNWoQIbMojGy0lot1CqDWO7oy8HOSNHT
         QaRriAhitWuevcmW5f8xnG+A5YQk2BnTXIn0wPqeIAd/id+lucQN69b/CCmL38KrAbkb
         Ja/A2PSACVoDZv7G/5ofzy6xpRJfsfW+GOZutLEBW9eRsf7qi0bgQN4yFN85AMFNyx79
         s4kFJ0vxpgioBp1f6KpD4GG3CyWLAJ3WRFRBQvuVVdZkgc+NsNRPCG7gXjK6PM9AN7WK
         HYQSfhfBpEC/W81g4v1o19ZLSWnr7rmPBUAK+W9ZJkSrz4NsnLa/qQZ2OSmD9d2NyYJJ
         qQhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775835727; x=1776440527;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uqIH26VW1DMf9T7tCXVZqQOXa0zE5Lks7d0a2XG7EJM=;
        b=b9QEZlhYr7ytpsePQYaMgNdMJZBgYhJ56XtNUgzePXsXe2z5WXc5nWF6Slm21/ARq8
         aAHMMfjL0RQQHxsNMdlnZTuKB9z6aSck8dYHvMBmzB441Vz2RN5ZziCyVl4VhFqS1ut5
         ddqp2IxdvH1cdO8oQqqoOnEB4EGuePatozcyS7oeHGTlYPz1YHmnpyZeTAEvga4elfFl
         BWVkACx/TStYu6rPs6ZHuUnPUYuf6omERjEIxetJDlqA7PbsxvmGoQ97PhcIru+sTsyJ
         Am2p2RVPvhCshfbH6ldftgIAKt2Gsjc/jHYsRiNhd5AkOQxp3h6b4fM26ChlxY7EbKH9
         digg==
X-Forwarded-Encrypted: i=1; AJvYcCU8/YOx63A86XPbT4iOhHwE3oTTkcmY57lmRf9NAZTf6Wwwz3mT7behqrXdni11tbZMRz67JF26/g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwMrevBfc99o/xpxSCKXhs/yTNZjiLpWe1Vqhvuu6Abw2iFoiqk
	3N/9WhwXE+/awQOlGt+GcLQWURfwiRmlmXCxrXiYcHnHjWb+CmshkcTC6lbdlLHmUW58tK/sRiO
	7vI6El9l6zQVHCIVlwiJmR9l1JFmFGcjmu7sBdIjk0ot6ylLpF4F0vfbQqwlvKg==
X-Gm-Gg: AeBDietNxbVOX2J223KXK5oLlTO/Rq632jqAZUyBQlJdnM5+E1Iq5VAl59kHxt7XQ6t
	n88bXVgbgGMTZVAq/GgF4hj0mw4JyEuqbeTHz1WHGuUKrSF2TCzKArAULaBqd7QgwF2WEJNWJdt
	JUUISB3pisGKnKapPIEK1Oan+zKHBzM0nUW02hXKLDMCC5TM5b/fhrJQOby1K5jUNTOT99frW0x
	Y9E2w4UhlS+o/stz9JvTnLdwPC1jnOhePYhn738TdjuXggCRxOD8QiPG+PiS6AY8CUTvr7gapJz
	HlmqxfIXPXfBK5A6SldNrA+Qfr4gATj0f/KvRHs+WIglUSeffvswnR4UA2WSNwDaaEUji+s/fVk
	eWvaQKgDnkcT0ODnbfwL9b2LTPPpuX1kt9x/dYmlUe+g/9WwOuH1K1pvjsB0yJKujZg9E7wiF/z
	g=
X-Received: by 2002:a05:7022:60a6:b0:128:d9a1:b68b with SMTP id a92af1059eb24-12c34eee7abmr1952889c88.33.1775835727015;
        Fri, 10 Apr 2026 08:42:07 -0700 (PDT)
X-Received: by 2002:a05:7022:60a6:b0:128:d9a1:b68b with SMTP id a92af1059eb24-12c34eee7abmr1952867c88.33.1775835726421;
        Fri, 10 Apr 2026 08:42:06 -0700 (PDT)
Received: from hu-mdtipton-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c347fa2c9sm3838370c88.15.2026.04.10.08.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 08:42:06 -0700 (PDT)
Date: Fri, 10 Apr 2026 08:42:04 -0700
From: Mike Tipton <mike.tipton@oss.qualcomm.com>
To: Vivek Aknurwar <vivek.aknurwar@oss.qualcomm.com>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: interconnect: qcom: document the
 RPMh NoC for Hawi SoC
Message-ID: <adkaTBk50KYo7XEO@hu-mdtipton-lv.qualcomm.com>
References: <20260409-icc-hawi-v3-0-851cac12a81d@oss.qualcomm.com>
 <20260409-icc-hawi-v3-1-851cac12a81d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260409-icc-hawi-v3-1-851cac12a81d@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: PxMleMo4oiFt9bBZgAf3V7Y_xAQVc3ZO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDE0NyBTYWx0ZWRfX3KJ2opBJKqnH
 7AE+CQgN+WYi67MG2chATYSG4pyMw+SC/jfGDN7ZgQNGNG9qa9oabBYR/Xw3nYaWqmui1jdh+3b
 8qNGqRz+VETM0xD4rGSnCcJal6KvGij0skKU9htKE2HNEcRMglT2FZReP8x6a0gHfzbkDcOoRlY
 HIcIrBTDH6Lgi48JZlpNaWjQ4/PafR31yC5VGt+2GGE1su3fTMUpXla8wYRD6nFtm79NFlY1HrM
 Xh7XcBCoYgxiGvvzVjoh07cI+DXDBqy3UcFDg9LQQ78VFThnqIFi9X2+pwxWhJLh8BMtU36vaOM
 5QI13KWQvI+gp7LHUY0l5cVvaUVgXnO6/dTfYa0ik+6bXsFX5YWUQjYFcP1cXUGBT3oNbTyA4A5
 IV9z2gbFzwUG29a19JzI3zz/YgBmaunQQaUeIWY6f3Bwgmx2HbRxMBM2sAaT88x2KSqlUZVvOu+
 8F96f5jMwOKljBqueBA==
X-Proofpoint-GUID: PxMleMo4oiFt9bBZgAf3V7Y_xAQVc3ZO
X-Authority-Analysis: v=2.4 cv=VsgTxe2n c=1 sm=1 tr=0 ts=69d91a4f cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=leQ04dn23ONfhV9bpxQA:9 a=CjuIK1q_8ugA:10
 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_04,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 spamscore=0 suspectscore=0 clxscore=1015 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604100147

On Thu, Apr 09, 2026 at 02:01:37PM -0700, Vivek Aknurwar wrote:
> Document the RPMh Network-On-Chip interconnect for the Qualcomm Hawi SoC.
> 
> Signed-off-by: Vivek Aknurwar <vivek.aknurwar@oss.qualcomm.com>
> ---
>  .../bindings/interconnect/qcom,hawi-rpmh.yaml      | 131 ++++++++++++++++
>  include/dt-bindings/interconnect/qcom,hawi-rpmh.h  | 164 +++++++++++++++++++++
>  2 files changed, 295 insertions(+)

Reviewed-by: Mike Tipton <mike.tipton@oss.qualcomm.com>

Thanks,
Mike
