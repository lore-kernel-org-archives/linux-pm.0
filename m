Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC0B44F540
	for <linux-pm@vger.kernel.org>; Mon, 14 Sep 2026 12:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789389459; cv=none; b=kubRWi2Il3gKzDAgjw+XfhiNT072QSWoeZCxe43P6QlQ94mUA7rl7jTenUbofy50FsEj5RgW2tDbRBD//ZbfL8p64PvO3U7E0jbsuEM9sab8JFflE0GNcqNFYPmMq2Cgpv9hyzFIkvyH4lKfqCYGLBbEjhMQkc4gK8N5FtdxAXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789389459; c=relaxed/simple;
	bh=K05PmFF6pkqk7FVBk07pIjMzhL0tcbul2tO9kilU8bA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OooJ4gjDFx4ANG3JbQh/RG4C7UFxfl8pB7hy1rpeqEQn8uaopV8vJjdrWM9vXF55HnA6WXpY+0FbEC3twpRZClrHJ/AlkGMiWK6bxaoBJXqKHkZcXPri0LHvvuTAI4euac88Fnoj8nBJn9PH0KCTSZmvMnlTb4jL+as5T7tmoTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=owD5IByI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bJgyHJqz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="owD5IByI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bJgyHJqz"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68EAm6tu3793283
	for <linux-pm@vger.kernel.org>; Mon, 14 Sep 2026 12:37:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IElVkIsCBxgJuoSMibKS1eyihRvOBQooxAqxg9nq+9I=; b=owD5IByIMKLXs8Wq
	/uCIiPxjgkzEWVjVmzjM+v1Hs6Dgs3J1+S4S9vigdaDAGt9QZIFwhRFRaYej1WjR
	sKNWNjTQ7VlPZVpno9G/g+Eekoe1o5IQEwKgeU9GBbtKWJjZarFCFTBotWsjT9c3
	WhNdoMk7/8HlAwcV0ahqJmVePRQPzTY9NFDY59kAw/viw7F0q+sn7AZ687C/rQM4
	Z2jbSKPqOh2tgmnU4smJICqbbv2beQm6AeCoZi4+fx2zW9qMzYZUF5ojgf7dLIhi
	CEAEPAB50xYzRtKUzu3LneBTLhtz7u1xwKFHlEhX2ry3TzCP8hPIivbMJ724f6UR
	UTLvgA==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com [209.85.221.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gpcjg14h8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 14 Sep 2026 12:37:36 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-5c84b0a43efso105694e0c.3
        for <linux-pm@vger.kernel.org>; Mon, 14 Sep 2026 05:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789389454; x=1789994254; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IElVkIsCBxgJuoSMibKS1eyihRvOBQooxAqxg9nq+9I=;
        b=bJgyHJqzAKdDwx6Jmk4J4gs1IP+4+duTPK6PccUCr2IejTBbSkMlp5+/LSrkto7rzk
         orgidVmEIEsz9Qc3/eygXASzFGIgTJYAx6OlJW/km1cjC3d9VfYv8KKotDHUg7xaiWo0
         fOjI0TwpkX4lh98Rw7hYky8ASqdkwRiIRUMBFAIOW2xt0I6zMvheF8X/47oUdNfZRSdo
         gBFwq7OIMfWEPIH6gsI9PhXQ/OtxZ8u+lCmaJRgg4vGOCKNOGcsS7mwoXad+zfADTaNn
         YvSAKikucLJmWz/0aBE1DwdYXBXHd81RRm+k85MWdE9UYe6kmuH0NgVt9Dz/lKlJRj8Y
         OERw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789389454; x=1789994254;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IElVkIsCBxgJuoSMibKS1eyihRvOBQooxAqxg9nq+9I=;
        b=V9ZgMPdvqPbnsSn4fC1efC/MJtDBuBRlOtMXgNwoDtQJp5VmAqaacuaVavTe8OOS0/
         qrsCI5+2sAZn6jlYLsIKne+dLrWAs+yCnvO7IWF6JvZg1w7GaffP0hvJmmqEkqWVOpO2
         bDAjdeDUWtpLv2CRtVYExkcx1jXK7vnLlyR1vrBbEGW4wEM/3p54DMay2jhMVRufgT9c
         iZXDxd4SwWCzOt4KdWMg0fqV0CoSyDAJPKlU6DdxuAQYQ/+I9joVJaFk2ggaD+653k5x
         Mnc88QGuXren2lwTcAdSzpTqZw8j17zJXUkJMCAoVCTaybK7/2jgGoxAqBqY1ngEurDM
         sdcQ==
X-Gm-Message-State: AFuF++nurqKvzzWbkzqDQ304jFlXorX13+woWVOexlndwVxpy8j4C091
	N5/6mveBo0P6Dt6xEIUq9UxCI3fZdbvtEBbOl/1Xy4tPN7OKpp8ZUWiht6E+uPpbn7vv++J/XNG
	EfNjP461975pUt2NagFwOwLhjOeFItyHgk/0l8Zb4P1KfhP7xhX9bCopc3F1oOJ7J9+0cvA==
X-Gm-Gg: AYBFou0UKnueFa/MgCoyA1Vt/y/oDN0KHLNVbDC0L0MK+DalR7Ua1yBISnu3wcHcPfG
	/fJk1Ac0oLK52FWW4nMoa17vpTIwItHVtEOmg3XAc8kceUi6pz3/zeck7AV2L9k39tBab8Q2ZpF
	pPdSimuzRMsAXfFyEUcV0PbAySRCBnOffb8w33VB8xOx2A50jxhWK5XVRjpqf8aRAgtCdxJIn3/
	x63DqQmzBDuJ9uPoRrexFpIOFS7N/QxMdixy//H2N8HGheoqFzLtnEsziNlyFMx3a182pnra67R
	6SAqX1cqhNw7j3GNM4+cH+n0erCOTH/TBSGn5FaZfHcUJySHBkFwY2jyL9FXGoZBLXDUWlxUbFN
	qrmLW7MmMENM4XK4kULkTjw==
X-Received: by 2002:a05:6102:54aa:b0:795:41a8:ff58 with SMTP id ada2fe7eead31-79b53156063mr371811137.0.1789389454092;
        Mon, 14 Sep 2026 05:37:34 -0700 (PDT)
X-Received: by 2002:a05:6102:54aa:b0:795:41a8:ff58 with SMTP id ada2fe7eead31-79b53156063mr371803137.0.1789389453626;
        Mon, 14 Sep 2026 05:37:33 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b8a046d243sm2407027e87.53.2026.09.14.05.37.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2026 05:37:32 -0700 (PDT)
Message-ID: <e54cc308-7be7-406f-be05-c38a759e5b3c@oss.qualcomm.com>
Date: Mon, 14 Sep 2026 14:37:30 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pmdomain: core: Fall back to node name for idle states
To: Maulik Shah <maulik.shah@oss.qualcomm.com>, Ulf Hansson <ulfh@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260914-pmdomain-idle-state-name-fallback-v1-1-e4242c409a0b@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260914-pmdomain-idle-state-name-fallback-v1-1-e4242c409a0b@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=CKa/zhrD c=1 sm=1 tr=0 ts=6aa7ea90 cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=5kt61lt8hwMnmxBZRvwA:9 a=QEXdDO2ut3YA:10 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-ORIG-GUID: TjM1WVhrxuRL9m60t7-GKgJocN71GYFv
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDE3OSBTYWx0ZWRfX4R0knK0dbWSA
 uFOg8CGy7xzDWiqaNC4YQjuqlWhze84tduj52Cs3dutiXzoi9LOun/Jd/jzgUyXr1yKAa9kMNCr
 UxWIJjhiP7Q7EXnxH2om0hoq5a/nPQ4=
X-Proofpoint-GUID: TjM1WVhrxuRL9m60t7-GKgJocN71GYFv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDE3OSBTYWx0ZWRfXyKbTK26gowXi
 u5PdMeS23HnJalpS8A5aq6usnAsvuwiG72bgLzMUtai1ZCKueK+uDHGBdmu2J3a86YFPGuwoXYJ
 BOe7Ug4s/RdBXnuq/pwrvGPLWP8XeRZGty1j7Vm5kRyBxtHjbCsS1snl3nhmHGpOmFkTVUZXvEe
 HYENzCzQ6Db2GafG1VEMEjfoae4NPR+FGcnRQQaQ6dLqi6zxzsdbq3fHcrGkjbB4inBbWCctsdd
 QutoVzuVCoEIlIv9locWRT2gQn4tTFsM1ly5XnHLa0WC5R4kNYGhwqwB2793cYMrGoIo+pCw/Mu
 6urbSg1FmPM1nRjXsJYEZJjr2f7OREYFm2BH6DuhQtDmdqUPcLk18nTcwkziZs96J+kwdbItJ9m
 XO811q58h/su4sk5jyOTW4yshBhIqeoCMKs5EyYdkBCy35MTNtRKqBwLaW9q/26I1ptUaRnB4ck
 lCBBN1jkeDPOyBlM6jA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_03,2026-09-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 spamscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609140179

On 9/14/26 8:54 AM, Maulik Shah wrote:
> The dt_idle_states uses idle-state-name when available and when missing
> falls back to the node name. Do the same for domain-idle-states.
> 
> This lets pmdomain idle_states_desc debugfs show a name even when
> idle-state-name is omitted.

These are often 'idle-state-N', so I'm not sure there's much value
(but certainly don't treat that as a nack)

Konrad
