Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CEAA3C276E
	for <linux-pm@vger.kernel.org>; Tue,  7 Apr 2026 16:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775578304; cv=none; b=qY65saAECzsEKQ0bxT1Sd0/1tSJixU6DE3oqrxAH3dN2U0KGyLO/7i1JbLFeMh+ZVRdQ5rhm8PrXW9zJmAJrv+KCgde7IjVK3+FdVd9M3rMzTRqUL1LPhlwEMN+EBWMwPtwJ9N9E1p4Sw9Q2pKpCujQYAjPL7zN9ack6dyMlQNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775578304; c=relaxed/simple;
	bh=1cQAJtgQmFluSDEROaDsoxsRqFAOZvbJmchOqmbAdGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l6qiRk2DR4i+/vqik9KI8Yvcss2ArWWPotNzzqQFmYedAZO4RE5pdBqai2eJ+uJPQRlotsTSY0sbOI3TGLZAiMV5WzCOcD+ZEUCBn/urzB6Kms6cBh6uLA+XOSaF1pDxjgOKmL4o7s+fMUfn/wN94E9qeUmm5M+md7PagUe6AvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lKwk4HPW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZM4EQrrv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lKwk4HPW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZM4EQrrv"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 637CDhsi2580035
	for <linux-pm@vger.kernel.org>; Tue, 7 Apr 2026 16:11:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=fNt3t7bGHnmTY4XQLsyQYIDe
	23zUVnDOM/yLMp7Jz6M=; b=lKwk4HPWDN8Jh6mKxHtwtmsIkQYS5NCmK631tWI1
	r3vGNcZCUitnG8BkKgQ/4nxeG99R2KHtNzqF6nusOk544F06n5DQcbkUFMEL9A/4
	+gi7yqNabk5HP4M3CNrawA8DJNAvIQDRvoH6MIDcd3lgqvo13Q0y9OubSj79saL0
	VAZY/SwwubKz9F1Az4/v4j+5MCwjhdXGDCfgsOR3v3ZGm47cgIe2JCcNHTyfYHNE
	+yX0ECY7R7Clzg8t13tVRFzjEANj6NgIPze7UjH0wkj7wu6TbmESWycNp9npARxN
	VvSv4yW84JGA///lUPm3uLernh+KPT/MZRX6zPKEzZb6SQ==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dcmsf3jpk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 07 Apr 2026 16:11:38 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-12bfa367189so29612852c88.0
        for <linux-pm@vger.kernel.org>; Tue, 07 Apr 2026 09:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775578297; x=1776183097; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fNt3t7bGHnmTY4XQLsyQYIDe23zUVnDOM/yLMp7Jz6M=;
        b=ZM4EQrrv/4zGEoT1H0BHGwUwV7WLp4aTTA+TjNTPHhmWO7SbA+gT6c66job7fgWxY1
         6y7aJbNAozu0XD8lgZSOgMZXLXxMYJgi6oeckKY7H7xOKRY7pYbTnwK3pGyGCNsgH1Ku
         cI7odln8mgOAXcE8T6FBvOh3ZW+9OdZH062+DZ+X8zumW7leuT/iFGkDe31Fe3PGJ04z
         pyBeAkuMOB41s2XwdNIXwFv98/6zgc14XG4oyytqsb3ft922vtNOea5x1L5d0ihga7MS
         JD9kbScGEkS7skdNUlwR9wmxFe1R43fJpfpbhBX2uHIPExay3zvCicwmC6AUnimw5+bR
         YQPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775578297; x=1776183097;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fNt3t7bGHnmTY4XQLsyQYIDe23zUVnDOM/yLMp7Jz6M=;
        b=DpY3k4m5ZZbBXLJMpLpvUtDHGrxyTCQImaqdjOGFI12ZwD+SWfxt8HZ9grtHXfbXv5
         MeJAQgHSG1z2lPMWYZTLVzeS9fniCjXZ5/7/6BfjhpLxVC2bFHOlwuLrJ5EcAJD4NYch
         BEhwcrw00pA7gQeLoLl0pLZ1scO8QMWcdOEPWS+3Vy47dzK4zg6WkKd3ixxJIeRf98vo
         CzkiFWgljcTyFpFP6S3wxr4qSpi3FW0OEdkIpY6Z+F2N0yJDakwSBkzRmg4+PD+KXjOS
         MNjXwlhk+9xocLpoauwuXgjkOr+icRlcFsrVgGT+YWEEOKAIMic+qwTMewE/BwqHzCQB
         354g==
X-Forwarded-Encrypted: i=1; AJvYcCWI2vD586oCNWGyO1LSVrXSUk5GIdyf/2mR01BjV3IGZaq9Nk/WB/BmBE6n3/5zK9f30EhLmWPZRQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwdADW2mfMo0OP5TVlzywiWzQPbmqoL5Wmei/NWb5aqDMhyjwan
	935gamdC4mKruvxlzPTQFGZ05A4F7Co9mZUdmrq+SYrC5PGaw8vzmAWfvoi1OlV7oK79PtcZNTU
	+xfGBlU5s/K3qUUsbYGZf1Su+RhI+Z8QIEbvylkkoAWsf5hXATH/XFKHV3c/YWQ==
X-Gm-Gg: AeBDieuQTZVlXYS/xDL8h2zWi0D/jksPGx4CvspEQV+rghtE2fIre4aj5n9Si6EFWdE
	73+TtdfBEJyCpW4qe2rs6PlcOocicRuD7Udy+E+eYvGuk3sKe1713gf78Xxa4EyGcVdkxX+vaA+
	ocjHfCa784IvSQ4zH0mMQK+GLzUedETiC9LRmJxIpC27azKMhKuYb5nwoRIBT9btP9czq5vmj/g
	FrlkbXZmT8nxCXhzzsAzMAIpCDji9gAzAHo31MALiGo0UMxcVcEmocxuChpu4ieRfYkLtP6N/O8
	FKYnyWoEr0xvQYNRnkNU8simU/kuLJbukZ822wZkDhJR19xaEsSdpFfe3X3pq/tJhSKTOctYwGw
	r2Rd8Wb/W3rXecXvW3Q0uxV2f1FmJp0xrgdYtIalS/fiG+8vxEo5kd8241uKYoPrZCyPzDmZ1EE
	M=
X-Received: by 2002:a05:7022:ec17:b0:119:e569:fbb4 with SMTP id a92af1059eb24-12bfb770b25mr9183238c88.35.1775578297055;
        Tue, 07 Apr 2026 09:11:37 -0700 (PDT)
X-Received: by 2002:a05:7022:ec17:b0:119:e569:fbb4 with SMTP id a92af1059eb24-12bfb770b25mr9183216c88.35.1775578296453;
        Tue, 07 Apr 2026 09:11:36 -0700 (PDT)
Received: from hu-mdtipton-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12bfea5f860sm14659495c88.2.2026.04.07.09.11.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 09:11:36 -0700 (PDT)
Date: Tue, 7 Apr 2026 09:11:34 -0700
From: Mike Tipton <mike.tipton@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Vivek Aknurwar <vivek.aknurwar@oss.qualcomm.com>,
        Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: interconnect: document the RPMh
 Network-On-Chip interconnect in Hawi SoC
Message-ID: <adUstp6A2WT0Dvz7@hu-mdtipton-lv.qualcomm.com>
References: <20260406-icc-hawi-v2-0-6cfee87a1d25@oss.qualcomm.com>
 <20260406-icc-hawi-v2-1-6cfee87a1d25@oss.qualcomm.com>
 <20260407-prehistoric-inescapable-loon-cf0dd0@quoll>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260407-prehistoric-inescapable-loon-cf0dd0@quoll>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDE0MyBTYWx0ZWRfX5EMW9S3ulSKc
 0SsvxAAGcEZMJC8RLIZfyuuiNpaPyhtO0ELlzx+68V36UcKY0vljc6eI6ex5Jdzy7RNfWU1/6AI
 r5nnV/h5iSldY4rT/g4gHgl9N0lDnawsGC+sVL0eK4zWcv7QJmZZoEUnPMF6Mc+4csUcK0gMoM+
 nOa9xWEuOvwHzVN3AglVTD2DSM0qvOgKi649RDXoBLzkC+ViA522BKIS0q2B64/DxjxbBDAJqOZ
 vnDuT/obEcAOXvLo2bFyBSErHgzCs75zt7Tbo/p8lB7K47TuzEArnubJ2BTULKQAW51sruMqu++
 EPPkOCUmNGgmN5ZKuw1suadm6yNEeMSyJpPpCtJ4P29M/BM+rDBhdmlpHrj6RqKEsVLhMajG+nz
 6rg5GmmKudeOynbW5PkyI8b+jU5X4PclkAFCvQVuVw74QtlTiO9BLz3a9KOxgrCg8utiHY2mpOv
 uKb/5IEXRQTDxbWwsPw==
X-Proofpoint-ORIG-GUID: 55GLsSJRrJX1TwdIN5Cnqmc7XFxsxPjr
X-Proofpoint-GUID: 55GLsSJRrJX1TwdIN5Cnqmc7XFxsxPjr
X-Authority-Analysis: v=2.4 cv=DcInbPtW c=1 sm=1 tr=0 ts=69d52cba cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=eVgXn4zF-6aLp7D_HksA:9 a=CjuIK1q_8ugA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_03,2026-04-07_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 spamscore=0 phishscore=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604070143

Hi Krzysztof,

On Tue, Apr 07, 2026 at 09:42:09AM +0200, Krzysztof Kozlowski wrote:
> On Mon, Apr 06, 2026 at 04:04:41PM -0700, Vivek Aknurwar wrote:
> > Document the RPMh Network-On-Chip Interconnect of the Hawi platform.
> > 
> > Signed-off-by: Vivek Aknurwar <vivek.aknurwar@oss.qualcomm.com>
> 
> Same fixes needed I wrote to Hawi upstreaming lead in private. That's
> why I gave that feedback (privately) very fast, to avoid repeating the
> mistake. So since private feedback was ignored, you have now review on
> the lists.
> 
> All Qualcomm previous patches are poor:
> 
> document the RPMh Network-On-Chip interconnect in Mahua SoC
> document the RPMh Network-On-Chip interconnect in Eliza SoC
> document the RPMh Network-On-Chip interconnect in Kaanapali SoC
> document the RPMh Network-On-Chip interconnect in Glymur SoC
> 
> Made by the same people.
> 
> Why can't you look how Neil did it for SM8650? Or Luca recently for
> Milos? Or if you cannot look at non-qcom commits then Rajendra for X1E?

I believe you're mainly referring to the lack of "Qualcomm" in the
commit summary and description? I agree that should have been added.
That's understood and it was overlooked for this patch. Most of our
other patches inherently have "qcom" in the area prefixes, but yes when
that isn't present which should clarify that this is Qualcomm-specific.

Thanks,
Mike
