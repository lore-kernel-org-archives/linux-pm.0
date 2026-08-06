Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CA64C77D5
	for <linux-pm@vger.kernel.org>; Thu,  6 Aug 2026 19:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786043251; cv=none; b=mGVVqjhNokztc3632D4aQfovIllqx0bLyAa4y+g+mW4EbeGNkSUSBudGZKpJpyu3beUVfXJTgL8GfyjCBmg8AoOm6o0i6dVj1oejNgojgq5XWksQr+D9BKyHPWmRLOTw8WAU1ONpLkCIjAR4269VACmTCR1ctCklisRHBdaGO1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786043251; c=relaxed/simple;
	bh=FgwXUwJLSAzdWsl8255gfuvk1MA6m3QamGFDZhQOHuo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZOUIw7b01LhMc4IIA5O7Pu48/Z86gTvo7nR8X/773fyLejYhGm7pDo88HHSTjR5C4JBCj4LfDRzhjnw5Ryx+OhB/wAE7z6q4aWp4K5z7zthqHx6LGrAuKuGFhjt6ONxUAMaG6aYUK3gnjElG5gTD/Wg4g0lS3Pzjdu5O5CDmYSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZO8EtX9Z; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jfRnYfTM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZO8EtX9Z";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jfRnYfTM"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 676IHW4Y3908798
	for <linux-pm@vger.kernel.org>; Thu, 6 Aug 2026 19:07:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BX8ZxjTul2K/taj0A4BXwYLfVRhcZVy2nUyT99KFjNc=; b=ZO8EtX9ZPSKmw4Ue
	ogJdGGY6I4QD0zNOPjfdL9QOL3RlfvOOSMXfQu0xqprdpVaZsuvFCok89qPH5FZ3
	tbNQD8Dxz7T/vFe9rWJZ8L8Sv7bX1oooCbgg/yG9TUqSqynI+Tkp6PWnaIvstz7R
	F/b+0EhXTOOGkqvdwSngCmKDj1FHNQ/XpncKAwkM3LejzfY3Bs1YGiJfziQaDVWq
	5Iv8opda3eogSjlSJL0eAYRCAE47unQFaK5MQIkTxBtRyPGBmj6rohHGjuWuUt01
	ZC8FLRFSCOJ0gcdgrvTjkt7MFWBRVAaCjTasfZayeZn993kq2lJCkMljoRTG63XD
	7CZgcA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvy6r8anx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 06 Aug 2026 19:07:27 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c9fe4c5eb39so1864709a12.1
        for <linux-pm@vger.kernel.org>; Thu, 06 Aug 2026 12:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786043247; x=1786648047; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BX8ZxjTul2K/taj0A4BXwYLfVRhcZVy2nUyT99KFjNc=;
        b=jfRnYfTM6Uphp85WzdXn1r7ZYOkiXV/0Wnz0E+B/hdOapuuX/o/UuqSbcoBBz1l6F0
         8I35P+Dqx1sgayW8QO5Q2czzZyE9zjRttQF75J78/8ZCSe+F2/8FPL2FTyscujpFsYr7
         kwQb3rtPjFzE0oD/nkVq457KjbvjTrsbXBXO2Atlcwcr5hcCZgxC8OJfA1xceT4TsIlJ
         6xh7z56SgsUa6bJzvhNBl15lz0kWTDj0V2XWLjX2GFdZ2XRjnTXKgc+Flg6dXFvpFNJF
         QZu0B+KecoXt9o4nCh+ZBpMmhj40LyBSaTltPU42fTQoEjAPuhsaUR6qER4byWeFCTM8
         cPjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786043247; x=1786648047;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BX8ZxjTul2K/taj0A4BXwYLfVRhcZVy2nUyT99KFjNc=;
        b=k5e+sBY1mvRZVyWLfZC7R66hsywkLJ33tD7XxywJcOdCeiDpLX09CqYmmbjduB57hW
         Wb5LnkZSlCL3xc5+0hWlZRzkavqE4khYqLPalf7RB7w2uCeYK1kLmYDmaAACENaANNAh
         7keub/bQ/zJB9xkivgaQ+H51yCn/GDSE1jmiJcGe1+d7Uj0z4WtchyMqWJkKfLrhi37A
         x7zhDBO1d+q5ntShK5XR/PUZDl7HdCplTEDBHtoKeRCLSYA9elFf5F7pIM/sITITyBsV
         YR7b+5dfU4FEua4jEgVRgI4xIC8PXoOLxI9BFs5biDMRKw/xkx/jxFJceneYgUaijjmO
         NQng==
X-Forwarded-Encrypted: i=1; AHgh+RrUIuzneakOr1MmOZe0Lj3rOkT1xniBmd+PgKZ+hn6mWdHvT/YNNFO/jcRpt4BBR6a72tBf7KWjFA==@vger.kernel.org
X-Gm-Message-State: AOJu0YznHTIV8MU8Ll6w3IciJWwQchOOp8KUMXQSVQT97yMK5NxdSlQw
	jklROH1jj9J/VONwn7GDoh1rLE0gTlm6zu6WYwHpgodPGJQjjd5h9khWgK1V89dLfN83Bf7sCF7
	w/UfGAFtUlseuXzdlTGONswMv6yYkCWoYfqVy65kBvv+7HmZFw+0Ts6sewukNRg==
X-Gm-Gg: AR+sD1287BIk2pgr0o85LZaZc5B/pR2QK4CO2szsH00eaikfP4AYWb+HEBRHrBoEj3K
	UWpGiIn7sUqTIKfvWYHl0cqnauNp6QAgg3bP/M1PxR5txiBfUfZvJk9lGIAxY9BIWo+xp5MG0QU
	937F+i81fM4E8LDru7SnvqAiu+utCCWrg5hDRvAwJG+XZtp3KR00HWtzto66uDAaeIYCNUyhc2E
	p/kDdivTSDtU94Z+DkqeunehQprCJ1YSLMpUz/RSVrqHOCMcKx7E1gPSR2wg1Qp9Oe8BFqsafbB
	SN7fo2wjT9h3hxpG2ZtMk2ajco3K5hvy6HcZsqi2/3aGvsatUrm0cNCkorwQgd8PtWF+4g9gC8D
	zwMXuLX3oU3xmSBSIGWT+PEQHHS0MAr3ijQ==
X-Received: by 2002:a05:6a20:7285:b0:3c3:7a0a:18a6 with SMTP id adf61e73a8af0-3cb85eea69cmr17032499637.18.1786043247156;
        Thu, 06 Aug 2026 12:07:27 -0700 (PDT)
X-Received: by 2002:a05:6a20:7285:b0:3c3:7a0a:18a6 with SMTP id adf61e73a8af0-3cb85eea69cmr17032424637.18.1786043246641;
        Thu, 06 Aug 2026 12:07:26 -0700 (PDT)
Received: from [192.168.1.8] ([106.222.231.86])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315ae6c1f9fsm7932348eec.17.2026.08.06.12.07.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2026 12:07:26 -0700 (PDT)
Message-ID: <f799295b-b3c9-4ddc-be3a-fabbfbb97b2f@oss.qualcomm.com>
Date: Fri, 7 Aug 2026 00:37:21 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 13/14] i3c: mipi-i3c-hci: Factor out i3c_hci_sysdev()
To: Adrian Hunter <adrian.hunter@intel.com>, alexandre.belloni@bootlin.com
Cc: Frank.Li@nxp.com, akhilrajeev@nvidia.com, rafael@kernel.org,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org
References: <20260806131857.119830-1-adrian.hunter@intel.com>
 <20260806131857.119830-14-adrian.hunter@intel.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20260806131857.119830-14-adrian.hunter@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDE0OSBTYWx0ZWRfX44dIyheBtErk
 KVHLkwNdethxGoE2iIx4Xvb57BhWJkj5QhCaNlSDAC500Xi2bClYTCJUUTzgTe5Tnb0h2MfHBSG
 XnR3w5IItCQ3l1g+EbHQ3LhzioLQNObgRmknw7rMpbs/ebnrtoAmgE7w9dFuKwVFVoaOxUYcIt4
 lE9HJOMfyWwg/IcTZqkFBftn0jCU+Px2SXGRx15pfzukHinCz/Ozveej9sygpfNQDXvECY9Fo7u
 jBOf/8l97efXUHaAIRcZ4xK5/9j/h81ZqMomRiVOpzoWXHRt7Ul5dr/vYL5yMOgJYnHsvxDPUpb
 Z/c1A1GFcx5NKffA9vv4t2a+tu5O1omcfSfsl06CWnv+Fx+XTFpMdPCU1LaPPV8b+7ueZyT7N3D
 I+JzDxFU4H+fsGHFbzlISVCXL7zo41sX3FDjVR1xgAWGfAowK8VmgbtiPOQ3IdgDiYF/WerQOy4
 1EwjqoA5KJ2U+Lx034g==
X-Authority-Analysis: v=2.4 cv=HPXz0Itv c=1 sm=1 tr=0 ts=6a74db6f cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=uB10XSru4U0CyR2DWkO06w==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8 a=pIyxDqSOQZZ-Xg8wykEA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: NNOOsT8Ff7JmFkZtYH4W9U4NZ1qHPXMD
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDE0OSBTYWx0ZWRfXxpzMGyXVKucq
 1mM6Kc8H6XejipVL0S7m5VQ9dzJTLY68xEhc/774obDAsPAQbFBQCRSHtOHQ1PIkgY2jgw3ewFS
 96PRnhqyOAMn1Y+g6Ud/cakf2b20ov0=
X-Proofpoint-GUID: NNOOsT8Ff7JmFkZtYH4W9U4NZ1qHPXMD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-06_02,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0
 bulkscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608060149



On 8/6/2026 6:48 PM, Adrian Hunter wrote:
> The MIPI I3C HCI driver needs to identify the underlying system device
> used for DMA mapping and PM operations. The logic for determining that
> device is currently embedded in the DMA implementation.
> 
> Factor this code out into i3c_hci_sysdev() so it can be shared by other
> parts of the driver and keep the device-selection logic in one place.
> 
> The explanatory comment moves with the code, reworked as kernel-doc now
> that it documents a function rather than an inline block.
> 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---

Acked-by: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
