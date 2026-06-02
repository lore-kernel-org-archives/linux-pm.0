Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12733DB629
	for <linux-pm@vger.kernel.org>; Tue,  2 Jun 2026 12:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780402566; cv=none; b=hkMrGvAJRHvO/ImgKoer+iGT+C//vSxKf/QiCxefZ80t3n4kSvx+NWnMrGhcLGkStPFaVeVg1d4JRotG8LYIOsEofRbhAibAIKPXxbwBI6tDf7qsG074vJWjHxeLuLzheUooTM+q9Td1fbmYuv39zZK+RTXl6Knzw0jC1LUbOIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780402566; c=relaxed/simple;
	bh=yH8UXZpywUFIUuxiUoeWfNzBtH2K4A4M3pwCb7xFDcI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aLTRWeqK8FcB0pQDWa23cA2/sPY0Mr3w6qlOpacoyzZU9l4KKLDP5cdfjE9WFG1uv0dl+J6DmWFfwqBjbYBLJoAy75acwe1GZVE/5rHuCeaUvMf4a5ZimYJWmQhUZU9EQMbtwV780/32866vzlz20fQOCf77a/x5IhrEM91mUfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CDaRNRGT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IO2HE14H; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CDaRNRGT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IO2HE14H"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65262S2t2688155
	for <linux-pm@vger.kernel.org>; Tue, 2 Jun 2026 12:16:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1ANrwuqdjefDIFHmc5n5pfhXi8/X9vYH5MINxqlroZ0=; b=CDaRNRGTczDxuYRs
	Lf+2do2rIC9cKHydSllTzTE3IPYjVIxzMlQ91EFvnC7TErQnECoxsyUjfSH0qrfa
	hHTB/HEjawVUSg5xIsdKEQX8BqQCGV915orbtiZU3lga6J8QvWdWXGmmJSxYzsAq
	3EJ+HxZ2dhx+1tJ+Zpvc35eSIyhKsEsRAUmkCAQvz2pXzQewyKkRUzrmm8jKZRxi
	m4cTGKXCt+r5DW1VIvuRcti2qMl/ixyJS5Kq5fZYQCKkWcJYVSrhAc0eexdf51jR
	cBLTluwozFBmQdwhi5Fmtn7NW1cgnQWoKbmIBcIgyQzeqPbpVGIrFMZbPgTqAEd8
	v45CzQ==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com [209.85.221.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ehsja9cxs-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 02 Jun 2026 12:16:03 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-5a10923f7d7so2651381e0c.0
        for <linux-pm@vger.kernel.org>; Tue, 02 Jun 2026 05:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780402563; x=1781007363; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1ANrwuqdjefDIFHmc5n5pfhXi8/X9vYH5MINxqlroZ0=;
        b=IO2HE14HDNADNka9u+7saKO+SpZJbbqChnnAgsISNeUuH2QNaYZd/LNeiWnfBmO4jm
         69uRVpOdFjwPyiphF+Q3nfn0peKdLgNVoJf5658mda5Cc+RrLnOSXRG4n3bRdIN3z2+Y
         N38wAhBwkYk7vJ+PJRCUbknkR7Xcw0XzD44BakeH9Jh3CTdMbcnKyoxyd83RvQcYPAiJ
         LmFeSvalF4Hw3//DHj9VjwFVneytvmWsN4klJXsGgCBbMeYxZyjW5i7idrbt5G3MqUdU
         Kz0HIE0hYgz+KF2A15imvP6fQU94AG2G7xVNVVrEnlWqT1zCVtnID7ZUP05gmAak3+Zn
         2rrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780402563; x=1781007363;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1ANrwuqdjefDIFHmc5n5pfhXi8/X9vYH5MINxqlroZ0=;
        b=spznMm0eWwjdZDroY9orrkxnzEabcAdxV5dxoucFaxteHZWRbojIv5fDZGavGgk0p4
         itGvtZxWCCUKi6AgS8VOXC7OGIumTAT4MeoqJlL0g8eVuSkceOfk8hs48ofkJuY05HUG
         B9NppIV/XZN28L9RzKdnvTjL118WwOUUMscn/Dikv7qN+DQDcOUs9EbxTbdipxaqvz2b
         eC+T7H6nUwY716r0vi5ZEN/eQem/nSnLx6N9KlMPOY2Rm0l8p3mhfHrxtVyHtUgDYOfZ
         /ADzKoCn5NMJHRps1G51YGfRt9ulVtQkYvPL3UVUW/wndmAJxs2B51Z1bW/lE1sk8Ayp
         S8Rw==
X-Forwarded-Encrypted: i=1; AFNElJ+ayl3Y3sLWW1LFA2675yrfv2CJAmmWJOwhpnY0vE1NbPVtdKYY4SrVTDFK2kJu4ca4+dFCbQmegA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwDY9pshLw3Q/H6po0rHN1MHPtbJNxLehf9xWsRxrQ3uMgSqV5J
	rGQotEJS44DkPqDhDJrFEKfD8WFCRW97Zm8bB63hK/aEBNZUR375/bA1xWo/r+lfW5qN8izB1R5
	3oxbBOuKk/h0o+BkPbTLXVpR5+WYmH/iKv5rvh5m/E0gl90+ICUjwM6murGnyvA==
X-Gm-Gg: Acq92OEz39ALyIVNjEEE5mS2Rr+SDisYLY0CTcl0Rp+UGDUIeHUB2FZ1yyg29/XRAO6
	kcmIcRVXBCIwoU6hiqrUY6erodRQA/pSXQZoI49UGCUEimNFwhYjIwByCkj/6Jigtfw2AL2cDbn
	vRsgRLQhrkXy1LmgkKxWIk+IzI+Tk06GRtqDAuTVRJDECDw73+Q9ID58szKwJStRM1ZxCVu4V/u
	8zyC/4dFXZhSXFO775aG+cNd32GcD/VLvfsbBQ2tT/b4NiGCuIkVeBhKMdy4+JqTwO3+IHy/Wg7
	6SeN7N7+s0/Q3n3BPNKpsaqMOg+N/OjctjgZ3KjZL3aTeqXDvIv+ZFHOo/MlZBglSRFhsvjoB4u
	3PqdyfAyZ5lb/H5Tg2Cp4po+6l8+JDv2D4mNPOwPlepWL0JiFtJv8eJlJ+RB70Ni46hs0RxQH6g
	E0
X-Received: by 2002:ac5:cd98:0:b0:5a2:497:328e with SMTP id 71dfb90a1353d-5a3ff16a77bmr1158718e0c.6.1780402563035;
        Tue, 02 Jun 2026 05:16:03 -0700 (PDT)
X-Received: by 2002:ac5:cd98:0:b0:5a2:497:328e with SMTP id 71dfb90a1353d-5a3ff16a77bmr1158685e0c.6.1780402562608;
        Tue, 02 Jun 2026 05:16:02 -0700 (PDT)
Received: from [192.168.2.1] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b0e7639csm65066665e9.10.2026.06.02.05.15.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2026 05:16:01 -0700 (PDT)
Message-ID: <49dcaade-4927-40e6-9864-9d4f3a8412d8@oss.qualcomm.com>
Date: Tue, 2 Jun 2026 14:15:54 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] firmware: meson: sm: add stub functions when
 CONFIG_MESON_SM is disabled
To: Ronald Claveau <linux-kernel-dev@aliel.fr>
Cc: Guillaume La Roque <glaroque@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        kernel test robot <lkp@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Lukasz Luba <lukasz.luba@arm.com>
References: <20260531-fix-missing-meson_sm-symbol-v2-1-1def8c3c169f@aliel.fr>
 <8c11a91b-cfbf-4b9c-a46f-907989bf8305@oss.qualcomm.com>
 <12d74340-0213-4f7e-a494-10ce147844ad@aliel.fr>
 <0c5033f7-1535-49e8-a502-426e54333496@oss.qualcomm.com>
 <59afecd4-7749-4be5-a261-a850634178b1@oss.qualcomm.com>
 <376eec65-20ea-434b-a6ee-edbc12e6d7d9@aliel.fr>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <376eec65-20ea-434b-a6ee-edbc12e6d7d9@aliel.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDExNyBTYWx0ZWRfXxijQA5J+dTTd
 PJR2LLT/EPMcR7CPuEQZrHjMMK4nsr/oGzF0dO6Qd5LhxHRRAo9B6A/Tekex3mcQ/xjq4dTb9Ks
 XO212X3/wDX5tMPmFC3aVmbkmucEqzAmPTVFTXPwrnBD04KpG9/dMEE6BsgwVU2QNH4bYYtzPKU
 jciDAx1o+OlxSrAqH+YASGO6xdluol/M5xmQsKRrFmZZdodl9DODpjTlPp9K46aDIezrfZC7Hg7
 KTxgGZoG6DuyOG0Yokrv6cuz2m49bm57cyGnB1GL57KoM2H2Bg5YV1gR0GirtoYTi6npKl+/gq+
 20N7aLkAHU/J3zfx8XaKObzoMA14UP/4tjSvSKKvTiGeEcRkfpLn45PhM2sXCT0x2mlZzZ25Gny
 l+18etkkXGwEamyQl4ooKjZdF/TX9qudVZMacRVXULbPvDtESeFB3nsrFWgXQ9Ft8KUHcJ3IYn8
 zaTygoB8QssxA+Q/a2Q==
X-Authority-Analysis: v=2.4 cv=Ld4MLDfi c=1 sm=1 tr=0 ts=6a1ec983 cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=uw/3876vWhRnNVL35W6mqQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=LwlhRjmIQBesJAWEzoAA:9 a=QEXdDO2ut3YA:10
 a=vmgOmaN-Xu0dpDh8OwbV:22
X-Proofpoint-GUID: dGC-2AjQQreN5xIWskE-e-YOLyUzCdY0
X-Proofpoint-ORIG-GUID: dGC-2AjQQreN5xIWskE-e-YOLyUzCdY0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-02_01,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 clxscore=1015 impostorscore=0 phishscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606020117

On 6/2/26 13:58, Ronald Claveau wrote:
> On 6/2/26 11:57 AM, Daniel Lezcano wrote:
>> On 5/31/26 21:58, Daniel Lezcano wrote:
>>> On 5/31/26 19:49, Ronald Claveau wrote:
>>>> On 5/31/26 10:41 AM, Daniel Lezcano wrote:
>>>>> On 5/31/26 09:51, Ronald Claveau via B4 Relay wrote:
>>>>>> From: Ronald Claveau <linux-kernel-dev@aliel.fr>
>>>
>>> [ ... ]

[ ... ]

> Sorry for the delay.
> The module issue was raised by the test robot here
> https://lore.kernel.org/oe-kbuild-all/202605310154.bmdMBZHJ-lkp@intel.com/
> 
> If I understand correctly we can drop this stub change and only use a
> "depends on MESON_SM" for the "AMLOGIC_THERMAL" config, is it correct ?

Yes, that is the simplest solution for now

Indirectly related, where is the mod dependency telling meson_sm must be 
loaded before the amlogic thermal driver ?
