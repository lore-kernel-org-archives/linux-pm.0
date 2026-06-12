Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF843DEFEC
	for <linux-pm@vger.kernel.org>; Fri, 12 Jun 2026 07:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781249870; cv=none; b=rTveMHYHEl7c23c/yMB2vXYBBlUb7VGW4/L0KTBwyMGD1tBMKYoKS1FTBjbdbxXLxziCiWa7HqPhzZS0EEiY0ngZLUbLWZXs1v0fLddk9WP76RVfXT5r0cXdNM29UeZhkKDDr/V+OSA4dxCdmKgwvIJ6P6NMLHwq8v84TLNLM0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781249870; c=relaxed/simple;
	bh=qU3rvddbEAEf+sOsgGpXhGYeMFA0CB2x5S7vdbPsjlc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jnDd/SATdVNS1yhIz94UKxup4bUKo8bmJJ7ARkPfRZAK14MP7Nz6p7KAKj+takeej3E/bwm94sIBVm7/7Cbs1WqA4dMm1Bmr4MngqDFtaeDnERaO1u697v3MuRYQdgzZfzbs562m8zVfbF5H4ZXKztD4GdTDefglrkCskk91Dbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MFdRN/il; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QmEOP9FU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MFdRN/il";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QmEOP9FU"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65C3BnA52534325
	for <linux-pm@vger.kernel.org>; Fri, 12 Jun 2026 07:37:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=LqKFVOC0j90WTOOl7IKcMxfD
	Uw2Bsn86Jo/TQGF3Tl4=; b=MFdRN/ilDhylgFTY9jwTDhhgWfuwzMp3nlQLIIgp
	LShr6w7XlAIihowPQ01V8ot3nd48F4y7cy9viqQJPLBKxQfRokwFhXXEoW0Smn9J
	019/SJ7lDIymGzHkiOYrXqOTfPoT/tJQcHd/Innzkp1CgEJ/OaytiJrWSfYksmLR
	85BGRDUCzIgyodPaIyFarXNbFLyOKGN68GqF4ABsR3D5Dlnx5mfye/FWtgxXwl4x
	iD7Rq5qBMmJ51ADhJ0zuxJvjNhzQtrGvXqQeDXsptnk3/6Wj7j7E/wlDT+AobESR
	EyizJn0dW0AB3AO5KLzZ+OBRf0JCLS8sR96pJCmT5mMAiw==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4er76eh3bc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 12 Jun 2026 07:37:48 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-6e907a982f5so1907064137.0
        for <linux-pm@vger.kernel.org>; Fri, 12 Jun 2026 00:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781249868; x=1781854668; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LqKFVOC0j90WTOOl7IKcMxfDUw2Bsn86Jo/TQGF3Tl4=;
        b=QmEOP9FU4MKSigAeYYwb5aSQIjOAB0NvRe+M/FGbH9mUOPUUbur4bn1J4yqa7f2WBJ
         jmF4n17Vv0y7qyBCRdnU/kPiU9VDDl1RKYONOTaDxqYCSxqHkh3sFhMEjVTxd2g9xGk9
         ADjc/q6uS+++WVqtVGiq/RxsQcsbcOGQKQoc+BT1NeG31slj6Rm0D2+hNMbDpCcNL7Lw
         +09XTc2KKCh2QnfHAS1fcy4pHC4Ir0cDHF+5nk8KD9BPjOxBlraEZCHyHIfqOtBWoYp0
         tDaZE3/eAtxkjIIC2db+l5fe7AVYstq30/hCTQBkMk1Ya8qLKpDRzU6ZYVXq7ikc9Otg
         Tx9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781249868; x=1781854668;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LqKFVOC0j90WTOOl7IKcMxfDUw2Bsn86Jo/TQGF3Tl4=;
        b=KBYwvFHTZZN/8iwWi6OMa0ws2U0aqZ040cfiwT1n8gczGWJKr5jrXay7CYVhG9gu43
         vpsDFuwV1vP0O+sMeY5U+iaSNyNP5iIDISY561/aj4B7iFlDgkiclk7IloCOmUbK9FD6
         kExA4s7TRQ7LsOo1weS4rS0nMih7qgt58emGrDAXqLuErTqjtXhQnjGpA8/SWherzfd7
         Y3gUUxIfaj4Nm5oFVKcmqo19oDzo4xDNjSfHx7rktzBs2a4P81lhhT3I6AFDpWWFG4WJ
         T/AFN2MiMzD63dtTCFrFT9+jt4DdgSx/zY3bM6SNUS97pFRwdVmWBvoCZnahznyV76iP
         akxw==
X-Forwarded-Encrypted: i=1; AFNElJ/OazZ9kN34QDzbyXIsIpjv2kg9vkpc/1JlrUfBIhgZEtez5bRDT54bv3RBxcjoGkPJFn8rGt8WZA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5vAEJLom646ORQdPHjLs4teansZqqOCBW02ezmN8gpNp4rrJ0
	nSOUyyM7qN6uTNrnI7PARyEl1F9bqg0JeK68YSxHKNCyv4Q9ZL8RtM9YhpwLIZG0N/AGMgODT7i
	O2koIbAbBRuywnZlsnHabg919txL9+Z7lACn9HGNF5eHtqihXQYAjNOiv/hy68Q==
X-Gm-Gg: Acq92OG3nfM/mSqeD29RQdWbNEWlvuiNviB6zPE0BB/v54IOTTiveHqUKQvG7ekJDDw
	E1V7cYJndmyZqbU52TBy5t5QfotrIaYADmtI5AqlzawIwrXIaYSXMCJu3PnZpHWv/UY+5y/K5CO
	oH/A7Z6sj2hOIA15WzRrrmvUiDp6Yyj0WP7vKGBRpMbS0DbsCUH62f5Fiak30IauKlzIkPlXTS0
	IFeNnONsOg/57MJ5VK8cyuiuFFIv9B9evNzmbD2VmS8xutBhZFKJnU2CB9g95hZIeRz31jWou6z
	mbhgjKOmGMIvTQTJMbaPGrLi7eHxj0QWUc5Xh+mzZ3lGEKvnofYvsV+qipu8CoBU3dNqyefWgZ7
	05alV2Io4D8Y0/zBigYh/DpMBaAKy92d6YgkIgdPSGfB8iTtDkROEA13Rio+WrYu2sAiTwzuLkg
	cn7paJ2Yy2xMYKmnDXAg1pPHHnRZxKj+SDNZc=
X-Received: by 2002:a05:6102:8604:20b0:6c5:94a0:37cf with SMTP id ada2fe7eead31-71e653032cbmr641074137.8.1781249867913;
        Fri, 12 Jun 2026 00:37:47 -0700 (PDT)
X-Received: by 2002:a05:6102:8604:20b0:6c5:94a0:37cf with SMTP id ada2fe7eead31-71e653032cbmr641061137.8.1781249867532;
        Fri, 12 Jun 2026 00:37:47 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39929f190f5sm3867201fa.25.2026.06.12.00.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 00:37:45 -0700 (PDT)
Date: Fri, 12 Jun 2026 10:37:43 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
Subject: Re: [PATCH v4 07/10] arm64: dts: qcom: shikra: Add CDSP, LPAICP,
 MPSS remoteproc PAS nodes
Message-ID: <sut2627vbby6gtkv3mrldko5nsdlvvwxozvwyk45xykzmgly63@6ke5dgwfhrqi>
References: <20260608-shikra-dt-m1-v4-0-2114300594a6@oss.qualcomm.com>
 <20260608-shikra-dt-m1-v4-7-2114300594a6@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260608-shikra-dt-m1-v4-7-2114300594a6@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=O94Jeh9W c=1 sm=1 tr=0 ts=6a2bb74c cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=l7gszL_yuYPfzADJGiwA:9 a=CjuIK1q_8ugA:10 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-ORIG-GUID: GxBXNv6yM1ixkmP0a92My11bK4xR8_Nd
X-Proofpoint-GUID: GxBXNv6yM1ixkmP0a92My11bK4xR8_Nd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEyMDA2NyBTYWx0ZWRfX/PRSI++vUd0D
 TzzWaJkiWgYO0g/tzvS6toFpU6eTQ0AjwoHMplyAZkhVUnNB50aBAY1zDjPGrMI/wMKbBr17J8Y
 /Vv3zIdlIv4JjT0rAR0kuiDjFCi4pLKzntiPNxC7cg0UKv8WUMc1OmX3Usqv1f9dl6hx9vPJ8xF
 cc6T9p2PZ8ZF9tHZUVQGAZUeE5C7/m9G4rOg5ojgMp/gP5Va4GBDHfhzvnpxFDVGZR/uw+WrjGQ
 P15/Pw/Rbf7DvIlEZ5ctRSReJ/hRV5K+niQfUOMvYkdNZAAlCgLYR20+gGATz7LWWtIUIWTyclk
 0nmVikGnGs0ZBfzi6hD864FJyNbM1LHvZsrGm3mJkuorc3WvABFYu/OBEoc+TIOTLEEh4zH1ucg
 v3uVs3za1R+wPrFxoNcWPHHxXppnArP0R6NrQ+o877xw93aP3tn4yOQ7Ie2c2ERtxGnHVPKn2C4
 OmnscVeL6cPPKgm/dWg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEyMDA2NyBTYWx0ZWRfX7yTf0zw8Z3uz
 WtDMbM8Z10wLnB/Zn4mRqerGFx+QpUoZxq3ZLCEgT5cLLVHuK4yGppaiGVPHkFzIPLi3210GSko
 WlKV7VrwfVZWyF5UUBwwdW3v4dsLwvY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-12_01,2026-06-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 clxscore=1015 bulkscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606120067

On Mon, Jun 08, 2026 at 06:40:27PM +0530, Komal Bajaj wrote:
> From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
> 
> Add nodes for remoteproc PAS loader for CDSP, LPAICP, MPSS subsystem.
> 
> Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
> Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/shikra.dtsi | 164 +++++++++++++++++++++++++++++++++++
>  1 file changed, 164 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
