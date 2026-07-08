Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA3A3C3437
	for <linux-pm@vger.kernel.org>; Wed,  8 Jul 2026 11:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783509990; cv=none; b=dQ7qHSXOmHKzAcOR5Tlv8ucHiu9RA9LYohoWSjqI1Y7pjpsNJsGOgr4bl9Ub/5Hh6hsxnWt6YnivDTucN3dUVKfcNlph2KPipI/i7F3YcQdhSUVIFbxgsMkuHZeXQvuBB3F4CSOiiEPmZcPSUtoxQlLt1eKo71ETBr5q1OOgMok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783509990; c=relaxed/simple;
	bh=w5fRy7o690nHjMIWvtYlzqFF+jLZSb7JRzaIUHqIWGc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mOC1cNdyJT1zHSX1I92JiobvLbiRKu0SHhKIrVJgce6upKXK40EetdvIVaQ8IlxxClDvOksciSnR02xwOG+ofHmST3G27zbm98LLU4a9/SI0fFKrH2qHuQ6i1PWLESikjfKJxciuNbT+Voh8Zu125B8jHA2L2QsukfL5m0k2kV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Iln2SuM1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kJCUsxGo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Iln2SuM1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kJCUsxGo"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 668896LS2258477
	for <linux-pm@vger.kernel.org>; Wed, 8 Jul 2026 11:26:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oP/WqK6zvnpHzkRReKPypPVW5yjEc8H9ps43aZCK/44=; b=Iln2SuM18g8/DQM7
	ogsLYhncXHzXEiK6YQjmMJ56xgKvHuaXq0tBT7NsZRcHVWSVSr49u59EML6jWVIr
	2/bA6dW+TObQLmq4o4vrex/LdcRsODE9bRGdZDjlliaZU4oMypYoWdwyLW82eklK
	4PEqE98419kVRCJPsFuwKF7p1qidh9kHlE9p1l4m+4dXs7G4joaNGpEzT67f5nKM
	aDdZ8o3PaQirRjyVW5lLab86r/azO3yYc5MfvNEQhs6/NSSRCDkK3wcL/KGxrMB0
	T6yDCtgIEUgAX6ejT/hPPnVcqc7AMnh8JWz7qIoDPjsOQGmLyP8FDZfQEJ3b2rPM
	QkgkAQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9cswa52e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 08 Jul 2026 11:26:27 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51c1d137a68so13038101cf.3
        for <linux-pm@vger.kernel.org>; Wed, 08 Jul 2026 04:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783509986; x=1784114786; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oP/WqK6zvnpHzkRReKPypPVW5yjEc8H9ps43aZCK/44=;
        b=kJCUsxGoQBCArUWIBbvBS6kxacw9GarZz5mYt0Q0uh8Dr3LIvGVaS8CBSS7uMMUPq8
         6fbj0t+XIGwqzQhO+9plSqj95FWTyOw4UtaE45fTNYzwkDAc/gWTi4nBRw8KhLnfLHME
         ZTqjoG3+LvekfMG55VsZW/J9DEwUxHt2+TBuvBYmnAD6zt5xPN/cxP3y9JTjwjk5wCjy
         +iOmXjo/HjXNwLJ24yljEJiDe08vKdo5VklT4pZYzL6mwhRo8rU7ozdZ1gjQCWYyIMjl
         I81JJaaDKwGtHGB625Hy/w1fxwTUsGB7IJv1xVuihGulPdj/MT5BStX2Zdm+fpqCXjox
         iPEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783509986; x=1784114786;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oP/WqK6zvnpHzkRReKPypPVW5yjEc8H9ps43aZCK/44=;
        b=FBsYEOAa0cJ57dp6LZVqssaYoQpaNEP0yHCDw23ed1O02y4ql8SqQvqQ3lBz6CQIun
         VWyuuiApmL2m3/IPmBIuo2d3RXFO8Q/ehGbaR3vzf3UfpaZ6B9ZqqTr56KqtuoeckMBC
         1tO35410l9QUe3OThJsNyOODcEWfTPNZpB5b/SQtqMZGZJwxhW69Sg5CeY++Z6kRFqfm
         he4uL5CRbIZ7adSKkf+tsn5h7fgvOGYq/449sM4UuG4dV/CeTEAUDCzZ0sApnP85P9bE
         YP67KfHxUY0n51pAuYTJOP5woAh9UYycdZzVQ4oF0DsgOVcaYpdctnIdSUPIIANCB135
         ooFA==
X-Forwarded-Encrypted: i=1; AHgh+Rou96DasoljFhFuLcMytnKHpvX4OdXxaBRg3qkRNzpvmR/voizd5Zq6EUqmtf6cjp2NUT0V8HALQA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxP/UNtqMPR3s/Tf9/zzkpN1QO78lLiLyRESJrkaEUFcfNAiGsM
	oJr/gvcE0ARh+dpEFePCbHq3jhtEeyOwcHsEwkAcU/ho8Cbq9DlmSYlhasj1ZdPQ7dwqb6EMwiG
	h8HSO/69fMAYxsR2yScCPae9BriV1GBQ5n9W/6oWjL1ZacDWHkCeBrNEIYrGfQA==
X-Gm-Gg: AfdE7ckAPKp0DstdxAQlpEXPhVPpo+atbTCmD1dHSHwg8p6JTail2v9k992vxhOrco1
	hJiBwvYxXosOWYB8qwVQw8qnJ1mRpqgSWIGeAgTtzvwiQdSbXK7STvDa90NB1sDuQ2jDTmRoogc
	0mQtLWPQOV2rWRxXX/fUayMQtzZGGhSly2Yuc3bFWPgsNtUYWX0x2g4uhJViA1tlYfuf5ALGcDP
	CHQr/h8NakNTvHbCOxwsuTgcjj1Jiq8hEyRoXEvMuZiNPsyTO1sdbPsQ79527PkoaUveZvFBK4T
	fZQJdlNetEZNuavyXm4fZyIc2M1RWYOF+qu2Fzr6eCFDCPx+FUG5XfSpQX3hyC7gbAZXehslELW
	F6ITTqxAnaeHlBeIVLdW2ShreVy0Cn6FtLv0YRAPmLLm2UJFMGYP7SNUgS3wGmkyuazh0U3UQRg
	==
X-Received: by 2002:ac8:5e51:0:b0:516:e10f:7140 with SMTP id d75a77b69052e-51c8b3f9775mr19156851cf.35.1783509986290;
        Wed, 08 Jul 2026 04:26:26 -0700 (PDT)
X-Received: by 2002:ac8:5e51:0:b0:516:e10f:7140 with SMTP id d75a77b69052e-51c8b3f9775mr19156601cf.35.1783509985725;
        Wed, 08 Jul 2026 04:26:25 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:9094:f7db:443e:b97f? ([2a05:6e02:1041:c10:9094:f7db:443e:b97f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa039ad21sm41220698f8f.20.2026.07.08.04.26.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2026 04:26:25 -0700 (PDT)
Message-ID: <9ed13499-3582-45e6-8d4d-edc204aff231@oss.qualcomm.com>
Date: Wed, 8 Jul 2026 13:26:24 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thermal: armada: Use bitfield and bitmask macros
To: "Bryan B. Lima" <bblima@usp.br>, miquel.raynal@bootlin.com,
        rafael@kernel.org, daniel.lezcano@kernel.org, rui.zhang@intel.com,
        lukasz.luba@arm.com
Cc: gustavoscorrea@usp.br, linux-pm@vger.kernel.org
References: <20260701010802.99029-1-bblima@usp.br>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <20260701010802.99029-1-bblima@usp.br>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: BIUEZQa7H19KXaLWjzKSUiG6Y4nsxqZ_
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDExMCBTYWx0ZWRfX8br7kDyCgbb/
 xkloCXMAjTqZ97jPZPEWKUgLkFvrIEtAunOJSZrWFajB1vVmRt6p8iaA5EipplxmNeREI0RqeB3
 kRIYPmV3XUxtLdC73fXK1ZrLDHJPqWc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDExMCBTYWx0ZWRfXyna7Q59Jzkwx
 FrTb6BV8YApuhgO0Zo06jiVyBecF0/RZemC0ufCfDbgkDliGDwW4PTwISDej3AstFx7+WIdrvbc
 tntC0KItoQsD3ZmkZxfvJjWq+q6gaO62H66E11twsPa9uaj1duKUsmW0n6na+cncMuLjBYyiTjK
 FEcQKLau2MdzGeXRF59omTGf1xBCXM1th+ROLOYj1Zd/eHBlfDvdWYXBlhkZMEq/zOqPscan2kc
 WFDzqZFdaayld8WUQbNli0RmqScKwe659XWzjXx8Lrktfd1Mii4zNRAXR6PtMKG2ijvIYXuxCye
 P+MdLfUjmzD9Rs4IV7PYpU+tAoNKCWQQcljkyH4U3alRxkBXBT2vIE4PCqzjkUWqMGX+4N9hGxz
 0cjKuHcLA8v97E/oCEj6V29LXZu238IlJzI4JZewvNAQbs/+qs7SefJ3O+P5HGwn35E58lBdhRG
 mpSMany38W8FJuKdecA==
X-Authority-Analysis: v=2.4 cv=HaYkiCE8 c=1 sm=1 tr=0 ts=6a4e33e3 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=lgQjnBL-N0W9jqsy2JAA:9
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: BIUEZQa7H19KXaLWjzKSUiG6Y4nsxqZ_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_01,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 malwarescore=0 suspectscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607080110

On 7/1/26 03:07, Bryan B. Lima wrote:
> Replace manual bitfield manipulations with FIELD_MODIFY() and define
> constants with BIT() and GENMASK() to make code more readable.
> 
> Also, remove offset and shift constants for clarity in use of bitfield
> macros.
> 
> Signed-off-by: Bryan B. Lima <bblima@usp.br>
> Co-developed-by: Gustavo S. Correa <gustavoscorrea@usp.br>
> Signed-off-by: Gustavo S. Correa <gustavoscorrea@usp.br>
> ---

Applied, thanks !
