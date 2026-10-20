Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792486538;
	b=mUJ2YD7kAL4re6rgXUebXiKFZVDBH9AyE8/5h9iWEiQ2i8P6riuLXPSgyDvVcNly7gmD
	 iDRk9YUoJlFVLkwWlrHOZ9WqFAzncarARl0gRUY1QrVrRcqDMNXoLfGVFIDCJ+NpvNn8S
	 jqvdZg/S5jn5lV8htecSZ3vOfbbD0CXeg7yq8XpHijGQ7CxAiyxsTE8pRp0mebZfj/QJr
	 f2oTVTL2tbVmZqFxondUotDvkYvUSbJ8FQImBqUQtSLYx4OjlJ6b4y9ApMjQ+eJB/mipJ
	 9LuHaNiFKNrgVo8ZW51AzsafiVI08Ggk90UtgxMCtpqJHseHYBoXGPp5XApJU3OpRLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792486538;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=TsdVoIWtanFkfPd5/aWmmlsNnKRMvO6g1c/00z/cnbs=;
	b=vsvbUGa358h2Gbxal8PFw4u55dXiQmEjkd+F9z/o9KAWcxJRjWZBL2Tyurl/RDXrVjNO
	 TREBva9UuYdTJ5h3ZumREpfkjba4q6/D+ryvPaPAJ9qayU9IoV3+4PBnH2owdBk5VMOeK
	 xrw1spsg1LjlT/lQ7gUdl49zOsigRFZnLnaphnR7Q1wSd/d9Jul+UyilCK2M9imfN7M9h
	 C45VJsd+mwfEEH9rRLLsNfTK1y667lJVkp42/NpM5kI2ADiumiPI+ZZdiaSMY6+cAYBLb
	 QilaDPy9i3LLWQny7YXiUk676fL2p0JOzkp/OKFoTZCmOqSArkswsJN0tHCIUA1wOZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Lq9OmtAQ;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=frZoj4nh;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC62606A31B
	for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2026 08:55:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4BC62606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Lq9OmtAQ;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=frZoj4nh
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69K8YNgV620268
	for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2026 08:55:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TsdVoIWtanFkfPd5/aWmmlsNnKRMvO6g1c/00z/cnbs=; b=Lq9OmtAQWjQWLZZr
	0Dx/DKwlsFqK3orkI4FgyxC3gTnbta6JEs7t/qgdeAOWs70gidsWXlO2rumnHWeC
	EKi/EgE/ydB4jYHRjYFIMrlTuMoXpn73XV0Vlj8dlwNAVyuR0D3dXf32gVbZNwVg
	dKLgv5PPaR4MVrmI5Uqb7J0gVfGwB9SruLY3FWrnfhtaje88yF3f7J/kOBBMC34t
	y9t/M5paEhMkUZ67CPPvhtuYIdLQvH7OcG7GSbwRQ3jZ+d5EISOVI2m+uXhtmFlK
	9Dl6N2ZPOb91u+R1S+VGECkXQPVLfji9TxArGXQjOEOsRVDtNxsRs/Z0VtZspvFR
	1RbaYg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdw5nsnkx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2026 08:55:37 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93cac495d99so54515685a.2
        for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2026 01:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792486536; x=1793091336; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TsdVoIWtanFkfPd5/aWmmlsNnKRMvO6g1c/00z/cnbs=;
        b=frZoj4nhqzNvHMqE4WDbRFqI7486l2SBwAkO9gDR4mxtRYnEKwPnFB3Ck2vNGXGACl
         4WYSJE/EQRKhZn6I5eSvwHJrJOgnmdnodasYRd3NCL9yw8BZ8pwgSNH7H9MLg/TGzKBy
         ckLjqVKVyXtoLEh/qtgdxKVOCokZNhMK1KAs+VrF3OcEn2fe9C6/cscUrUEBFe/ELTK3
         K+9840NoRqmt8JDVlr6ZwVZtsc3dTWab6vZsJOdximkkl0wyT+vupPktQNPIuZlSvDwg
         MumC+Ku2bRSxcJ0wP4OBXsfwkUg4JPHhgn121Dpfk4zYlx4QnwlS+HDBzUC2niWteqYW
         4f9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792486536; x=1793091336;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TsdVoIWtanFkfPd5/aWmmlsNnKRMvO6g1c/00z/cnbs=;
        b=iX48WK3mA38lmwVrnhhgZtaYNNGb9KKMyb78C1QweGeZs0ZvUr4CO33WXw0D8jtaKT
         zoXdrNJ+A09znzTGp2ZZus1N85ZPvttRl5XI9kRZfROjoPlF/QFjObbF6yCF9eUGHOVz
         G5g3kSEhIlcidGvLe4zVrqYkGZUBZq0TgoOnLSEWV1jXvKXL2CL5g67wW9/9L01BmjP5
         jUFQ+dQEsxceWKDZMAH6CutJoOmnTcZAvCv3MAyOjtkuPjGJei1RyHSwqh7QGRjhKm7E
         Zd6Rj9e+ehz+D4SE8V+7/NpnQkkX90a9rL/KSPHT5LYopOq+lcoxV8c5EEqGNwwpOM8E
         /tVQ==
X-Forwarded-Encrypted: i=1; AKwUvBzYzcTFTp40M2Ot7Ly6l1PtA4NZNIDtjKQdSFcDb4Ph9G0N5Iz1cZcerMNlISGgc6FHhS2r1vAnXQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYIzTVY70OW8H1HsuuABzfSG86i11f5+PvH2TsNWs5qHUUZ1cVVM
	o73Xcv23lAzksNG6MaWc5DIvolbc31qxDO9o5fXCPzuy5RrD9vDIeTxKHY4sgP2nY+tOkOXA3Gq
	rdv4G00TmsM1d9tmSY3nabC5JgoQoEzyT5dZEVVSO6roQPwGi8urfTrcgPzMnxA==
X-Gm-Gg: AYBFou3N1gSME6eLdrubh0/eM3DCIkPiLCdfpfAwHz1qYH5jcbVpB8WmKA3D5FPIfuz
	b0aCZkCOPWULskjKR8q22UoODzrYFrTEySPOsTaff4HfpbLQbAnIvB+xNXtNUAkGQKfwkHbFgg3
	r4ot48NYF2XdMAz9fP+n4EtcyyPaUKORMKTSNzvZo+YxHhH0CPCGx/BWEFVR4uIUp0wyDUMhoh3
	B7mcw1oAd1tBfI0X8OQc7QdB3ZazyAM5fjEx9CGGP/l9dNzvTFS7ApWwUenpBlw3cX6qunVIptZ
	MrMLkOypv1RCxThgiUW+z/jG5pQLwFT7a6obRfiqt5bmXmuzzgn+k24pZQezjaTRhZ8luMjtFLO
	Ebrzs+pN5Rpokq/Q+4geyJQ==
X-Received: by 2002:a05:620a:4553:b0:93c:c96c:a5b4 with SMTP id af79cd13be357-93f29d66b58mr1971177585a.4.1792486536455;
        Tue, 20 Oct 2026 01:55:36 -0700 (PDT)
X-Received: by 2002:a05:620a:4553:b0:93c:c96c:a5b4 with SMTP id af79cd13be357-93f29d66b58mr1971175085a.4.1792486535934;
        Tue, 20 Oct 2026 01:55:35 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b38a1b140fsm5189498a12.9.2026.10.20.01.55.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2026 01:55:34 -0700 (PDT)
Message-ID: <696f7294-8e52-4526-aff5-30ad022654c7@oss.qualcomm.com>
Date: Tue, 20 Oct 2026 10:55:32 +0200
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
Subject: Re: [PATCH 2/2] power: supply: qcom_battmgr: expose the charge
 current limit
To: Joonhoe Kim <26rote@gmail.com>, sre@kernel.org
Cc: kamal.wadhwa@oss.qualcomm.com, anjelique.melendez@oss.qualcomm.com,
        dhruvin.rajpura@oss.qualcomm.com, andersson@kernel.org,
        dmitry.baryshkov@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261016124806.1789-1-26rote@gmail.com>
 <20261016124806.1789-2-26rote@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261016124806.1789-2-26rote@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDAzNSBTYWx0ZWRfX9XrJ0oSCHVCS
 HFTSKCRNeD8Ox13bh+h01YmEZK7GNr/JNbhxt2E97upId9TUya61C/2MfnJ+2xXJAhdCLmTmJws
 gy8rhqTQn683fnxIABnCHcumGe3BZMc=
X-Proofpoint-GUID: UAG3Vzq252F3Ztv1SoDeZv-lu8OobE9c
X-Proofpoint-ORIG-GUID: UAG3Vzq252F3Ztv1SoDeZv-lu8OobE9c
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDAzNSBTYWx0ZWRfX/rVEpLHUaJdY
 4jKUnDzPCdxIcf9hofQjSkHIqrZtVWJmCIYY6xW4A731vghOUQjpiUqk3kAqko/ughPj7BeeVft
 H2syNp1DOwsaNc8JlcT1nM8X+Y4BUSCNPz8y7sqC6jqApNpTnzSb49o7YY+46rOciYDoq7dtd6P
 P6Fl+AUO88XsxC5DyxgW9+hr8yzLcGDGkQxvmFaIBeWshilTcYgPD/Q5kz43Wqg8vCwyP/UsPC9
 uP1g8IDearcKysIXafC+O2kh/jo/1WJ6HURgXswRW8bpFaFXWa7wPiRiky8G0arSngo45v+wcGV
 t4AzL/cZJJxRsmllIoC2kwShx9G2D/Ti0uGlzxGUzyaFE5S3vKvYGbW4uziOc+Rl6Z28T4gaqYX
 0Afa+5Xr4H5DSlwcRznRNxMM7pHN3fVh79JR7qOOE8jf90fyy7bFijs+UZfAQuuymmAqabRtGr4
 cDVfJ2gKrqYfAAUAz4Q==
X-Authority-Analysis: v=2.4 cv=TcsDJhQh c=1 sm=1 tr=0 ts=6ad72c89 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=CtmeqFu_9xN5vWxN5BkA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_01,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 impostorscore=0 suspectscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610200035

On 10/16/26 2:48 PM, Joonhoe Kim wrote:
> The battery manager firmware takes a charge current limit in uA
> (BATT_CHG_CTRL_LIM) and reports the highest value it accepts
> (BATT_CHG_CTRL_LIM_MAX). Expose them on SM8550 class batteries as
> charge_control_limit and charge_control_limit_max, clamping writes to
> the maximum.

[...]


> +static int qcom_battmgr_set_charge_control_limit(struct qcom_battmgr *battmgr, int limit)
> +{
> +	int ret;
> +
> +	if (limit < 0)
> +		return -EINVAL;
> +
> +	mutex_lock(&battmgr->lock);

guard(mutex)(&battmgr->lock)

> +	ret = qcom_battmgr_request_property(battmgr, BATTMGR_BAT_PROPERTY_GET,
> +					    BATT_CHG_CTRL_LIM_MAX, 0);
> +	if (!ret) {

LLM suggests to add:

-	if (!ret) {
+	if (!ret && !battmgr->info.charge_ctrl_limit_max)
+		ret = -ENODATA;
+	if (!ret) {

to prevent a possible zero-maximum value coming from the FW
from messing with us here

Konrad
