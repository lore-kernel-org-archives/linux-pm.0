Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8238B37F73E
	for <linux-pm@vger.kernel.org>; Fri, 27 Mar 2026 20:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774643758; cv=none; b=j5iIU8jHXk6zFJUEVA0OaLad9vmwXBbqmFCwFRJY5fgI3QW+B+5tFAWFGRCX0BZshoWM7x1XMAU9ukuS54Q9f8dkjw4YnPpmDEcangIVuLpnh12Y8vXSsVuBxbZFxTLVF2I6VoMXF1ymenTMIg8iEtUAjHQK+msvSnffUDCw5gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774643758; c=relaxed/simple;
	bh=da90JW4sgTJrBt5zyplbOUxv2GSn/957efQJW5/vBVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IiA/av//z6+cJ40on7anT53UGdPVeGVHZFwWvhs9c03jY3IInq4RLry7zUcmTIIu+buj2NniuEekRy1/Ld7+BWyvAcIyIfdz9YoefH1pUHjl4H02h4snw3HsSd8eMxWM0SZRwF1OGUXjufQUy0agGmAZ6n2TkEgSMso9CWYD7Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LaJGQxb8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=C0reVqGC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LaJGQxb8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="C0reVqGC"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62RI2mBZ3659303
	for <linux-pm@vger.kernel.org>; Fri, 27 Mar 2026 20:35:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oNV01vD0V3ksspIAVQk7842j5z/hrGjFE28fF4qUPxo=; b=LaJGQxb8XRA8vQpL
	+n3cWnY5Toaxjpi2hdGe6oD8ptpe09lx86GXtqAo9Zd64BpbWEzteO7SQuU258Yt
	Ykr4JQ4OCk8DY0GMHtHz2yW6hQf0hEYIUyFyegfTNNXt9I336ZX/rPJgCJz1Ft3N
	sZu4VRAOJgDWNS2WsfFzw0zuol3FythKGZtmDBXelraMRODJEwSIcWYe7bIb2tbb
	x90juQJtaXEqBQ2ni/4efgWwPFFA0x8x0QeoRzA6CfArmRYx6xN6HumzkqWKaXBr
	quRDIfxtJE0umSfm/+UMFziSfQktk0nGhRqqvyBmn3LKLEfYMW9yJNcR7q4e2vi+
	2QLeBA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d5mn12vt2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 27 Mar 2026 20:35:56 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-50b6f869676so38080171cf.2
        for <linux-pm@vger.kernel.org>; Fri, 27 Mar 2026 13:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774643756; x=1775248556; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oNV01vD0V3ksspIAVQk7842j5z/hrGjFE28fF4qUPxo=;
        b=C0reVqGCUC/vG70n8TAU9V7hvxImp/1pXkxn2AaZnPIMPfkdeqczLeDTd3z6RNHQWm
         xqDF2BtDOc32plTlxevR7hoAlbcyyxjcJuA4hsiQvcNFRypxIJCdWkfQp+1RAK9x87n5
         zfOtSkt3zqWBm1Fn/p+WcjTrvfOy8EFWIg0CU4DWXpl+kIzoujgVU6igZ0w+WB7XZbAM
         c+C+r+EiDR6+LIYo9Ob7LkxtVflyIrL3500AEHP1Y5UZuGOQVduLUqAzfyNQs/BMwOkX
         LvMCsBjXRK2gTnhX7dvwJQxUwxns1lqv6K6dETeIouaZPIcoZMHxnudoM80xgs1B8vIB
         hnBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774643756; x=1775248556;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oNV01vD0V3ksspIAVQk7842j5z/hrGjFE28fF4qUPxo=;
        b=KxD5rTFPsbR6ws00nahszYkT1yh00zMxY9XOtQTEuKVmCLDa+crzR+OIJHA2+dMzqK
         AoEV1snqG96kMxY5sVciv4VnuvNN7nLbHccGY8/xMP89hoZQGcrxBBf6l7IbTMEKvQn4
         56jNlXS6aTDMlC6XmE4OD0mH1kR2saC7zGqdC7EhELbx4cDh9X53FWUSAVUM99yX9rvu
         kxg08UZ/9zhyeaIdc7RVKAxZG65nN3ejoW5cwdrG90iLcwyIqamj5TQBdAMfeoUm6u92
         fvQQCK2inrbuhJcUS/a/zgJnahBkDDlfEInt62kJSOqGrxdAvymPMFmyUCjPhXUGBRX2
         o8zA==
X-Forwarded-Encrypted: i=1; AJvYcCWXCXbYI4RaUcBdk2QGKEkT2z4QQm1/XXxzXVQqnQ1HErZ3GpjI+5vRgPgnYCkYHDM+vXWldU6+vA==@vger.kernel.org
X-Gm-Message-State: AOJu0YygipzcKLU1JQvYONtA2oiluPyRBcvqbtquY3z6dai8lMTF1Yjj
	mkwovPmm4yK57A4Fe9FWJs4OAPXatSr1SlaLbNlMFFMdZztoI+NCXdqZ6y6VceJBJn8tlQo84N/
	hSQf2EaDVa4n9HiGSztGEgiko+ZYGR9t7EYTbUh+FnCUY6673UagKrxyIORhdVA==
X-Gm-Gg: ATEYQzwefDxROUFo/lrgRRveso0d/N1ActtLSmbieZwBpQkwuvk2L+P0sWGcHCH4Ytz
	4ve25hOW0Oyziit2zm/SeWQ7U7QGXhVf2aBKPGLIL2J0FGR3notplRN8fHJtlZK3GDIWQvGXiEc
	X8gZg4IyZYHL4snyrabqQL3VXKuxszp4Fu6Wph+v2HQnTICkHQ4hoRxohTcky87F71RuQjgVkpm
	19T9oWzXNAR6N3OkUvyze/eY60DJ2QcM1ljyPBGk3W+14DfzD65ReyJE3Wxw5fIGuDdvjllBAia
	XtpWlEfjAOipqC1ioT2KH2fVyr+lBeaH03gPiQJy1cpp6Tr/Nk8koJIxjVnW0rc4914z42MMo8L
	geD4IX1PP/cdF0pdn4Vtep0GEZZwIq7ihIBgJ7VnTBhhdEvwhEILHZv/XpvOQTw0nulzkjadb3S
	o+sbYz+asSR7lvSnDhu9u2p4lvmE/IXjD8cMI=
X-Received: by 2002:a05:622a:295:b0:50b:22c2:d7ec with SMTP id d75a77b69052e-50ba398f23fmr51862321cf.59.1774643755756;
        Fri, 27 Mar 2026 13:35:55 -0700 (PDT)
X-Received: by 2002:a05:622a:295:b0:50b:22c2:d7ec with SMTP id d75a77b69052e-50ba398f23fmr51862021cf.59.1774643755311;
        Fri, 27 Mar 2026 13:35:55 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38c8389202asm560111fa.24.2026.03.27.13.35.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 13:35:52 -0700 (PDT)
Date: Fri, 27 Mar 2026 22:35:51 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: =?utf-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <barnabas.czeman@mainlining.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH 4/7] arm64: dts: qcom: msm8953: fix modem pm domains
Message-ID: <i6lymgal5c62ud3aas3qvzv6fjnjrzuncguwechraahmflr45l@5t5qli3k7npu>
References: <20260327-sdm632-rpmpd-v1-0-6098dc997d66@mainlining.org>
 <20260327-sdm632-rpmpd-v1-4-6098dc997d66@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260327-sdm632-rpmpd-v1-4-6098dc997d66@mainlining.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDE0NCBTYWx0ZWRfX3fqlr+FjEHeL
 oxZfcRSzt/YohMWzEuOmvN9GmsR8YRopcbkROAe5iPUtE2ZO7nond5BboMzWX81f7xflO5rcNlM
 NIqb4QEiaUzWFZFdWoqDhi/7avqWDp8wh6WZmos2K8EhXLXbAh+19WI9QtiBJHrc35j3nBi83M2
 r1wwWYT7FGpZDGVOjS3YWt4mFIXnVq/hNcwdYe6J0kNQPDYejXxKlRqzotsRWWy/1/O1Iq33e0k
 oNqCfqy+3GP/Z3PnvL0l5Dst+HvR3cG13o+DGOF/QMQh+a3AV93Ch3HkYuDDMgA5CJ0vxQinhR1
 0h594GJ8FUOAFwK9L5zLWizgCp9oQKuD2tSFb3RbZsyufdN9GmLkoN4oU/exSVoXIizO06aSWrT
 C5Zv/l8m83+zgJG6L7K7yoW8JgoPTiL0Vc2Oo23WhUhwIIIVVEYtG1/cwEZ0/t8gD1eEM7Vi4Id
 uNrS0uiy85rZGo7Cz5g==
X-Authority-Analysis: v=2.4 cv=CcwFJbrl c=1 sm=1 tr=0 ts=69c6ea2c cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=OuZLqq7tAAAA:8
 a=4EqJN26lZN6HTI8qya0A:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=AKGiAy9iJ-JzxKVHQNES:22
X-Proofpoint-ORIG-GUID: dQxiELqfxs5PY44Az9dVOtW98P0tPGnP
X-Proofpoint-GUID: dQxiELqfxs5PY44Az9dVOtW98P0tPGnP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-27_01,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 bulkscore=0 impostorscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603270144

On Fri, Mar 27, 2026 at 09:11:46PM +0100, Barnabás Czémán wrote:
> MSM8953 MSS is using mss-supply as regulator.

"On MSM8953 MSS regulators is controlled using the voltages rather than
performance levels. Correct DT definition and model the MSS as a
regulator rather than a power domain".

Also please squash with the changes actually making use of the
regulator.

> 
> Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
> ---
>  arch/arm64/boot/dts/qcom/msm8953.dtsi | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 

-- 
With best wishes
Dmitry
