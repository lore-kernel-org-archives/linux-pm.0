Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AED040EB9E
	for <linux-pm@vger.kernel.org>; Tue, 13 Oct 2026 14:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791901910; cv=none; b=otXxnfnIglmP8NUeWE8T46PSZXqzfaUf1vrwQosII6f0INF+ARHK4JQV9CieIyG4hKUkVj79FQChyBs7SrFzAKxeBUfgbWEYT9F6noLmD9wUUKiWAdhVJdgKffUyHf3+xN+ZA+UUHLp3BugVkbRHOEr2L+FT1nlh1BYIcWtRXFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791901910; c=relaxed/simple;
	bh=Xc6UXng5AfMa3Tdm3xgVuHWrr4sfMoltxMiAHnxmBU4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NycXfwHgSBOtOaBhB9u1bQcT7GPWe6lP5l3yuBa2sprgTd24r9aMU4BWnyv+u5tQorkMcFTsu5gdjEHcIorMySagyWj7JztMZhoUZ9C1ifuhwp688JCFklgUcEABDuuidnGGBXj8DS20Uy91Rh7cjRX/Pmm1Vy8cspJWDI1iLyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WLZIH1D4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hs0SHoxF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WLZIH1D4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hs0SHoxF"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69DE4Q2F2571122
	for <linux-pm@vger.kernel.org>; Tue, 13 Oct 2026 14:31:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/YOqxGlLfUnOc6Yx8cld+aJVHshZXI4bRKRZq6BJB5E=; b=WLZIH1D4gmyHOg/k
	cBYXf1jWGHJIcH9nlqKa/CSOjlWL6EDg0uiE6jPkwbcE2szL5VWIFy73EM8UDLdI
	Jkz8PVhdPQY2daA5dW2FHefgwewHjmh8PpVKN2aKgRQ/v/ObUCJSY8jwoN75aA08
	yw6tBPiJYpflQn+kXKugwDIjlU7OyrYDVWDG3ck7P0b0Cqs4uPkCORrC4iVlN/pm
	jqDoDj7eExStvPkiVWY2oE23F+oxOMIpK/PbYamPnvsNrvb3jk40vlq6b4ZXGkXw
	aOXpUnFV6JTuVgmg4OdpMM1TabUilDCXQthS/Y/68nALCHrizB1lF/WLEzIWpfWY
	07BOPg==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com [209.85.221.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h98hcbe48-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 13 Oct 2026 14:31:48 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-5e24d542d40so3748668e0c.3
        for <linux-pm@vger.kernel.org>; Tue, 13 Oct 2026 07:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791901907; x=1792506707; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/YOqxGlLfUnOc6Yx8cld+aJVHshZXI4bRKRZq6BJB5E=;
        b=hs0SHoxFoNZhCTr9ba7f9r0jw906VQhwQssz13Ur0/2z2kM0wg2i5Lx9Nq/GMZp1D6
         ovTKz4+DY4n5FDh2nbqACDDXRtyLI3PZ12ghFRqFxP44a6RIpU9njwtR3nUOethhAnz7
         6GYlpUGmNcoliIwPvs7Igroy9OKpYYm56RSzUnKQVQ6+gdxfulhvBLUZtpHCK+IFFOQV
         79iW9eg5iWdep5X8ZWVS7W5Z9kS0erEMUp40nnp5XBQY6AyM1C/xiceVbUWQbJUUhMHW
         QSZfBgGGDeI9rnnc4ikW6+scxJHTN/8Z8dCTiMpMK5rqWSzfYIhYf8P6SCEsrtNqxYIE
         /1cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791901907; x=1792506707;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/YOqxGlLfUnOc6Yx8cld+aJVHshZXI4bRKRZq6BJB5E=;
        b=WBwf3SGLWTVpXKyFGnMTR92L6peCsZKrkZyt/x6G8NteOI2AephagCvd3v4/Ax0euI
         JrkCL6xaJyKXFrk/R19FxvcesSt0WstWtSxaaVQxSXgNV1cJ6gGp7tUc80BzEXSSRbOo
         X4t+VHtyrsYowIu0HYb21lQQGeeB9SnL3hmTxVHuG9q5RiAcYxdpz6fFA0tyn+joY+eZ
         uGioWzoQeQGoNQIBVEcfpA7yfp5yI35ToLgqTBMhbhQeNd7Jen1S+Z4Xfv4Yo9mq+sJ4
         Vn4sbO16yaMvTRW1twkDTawIKApdnDg0zIfX2K4NG503gF4a1MZpgHYivCQXAECpGdDm
         9ddw==
X-Forwarded-Encrypted: i=1; AKwUvBxT0zss/T2triTVs9SYpILxOQfjsxx004wHJArISkSHSVsnQ0q4imcG+ndInYf6t/wff6FFVmMxgQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYIvsYHhfbt49HCa2I1jwpd5FCx/9vYjZFs2W9gRb69/6gyRfqTZ
	e47/Oq2YE7Lk8xBd4MnuwkMl19HfpRibZE9YfONyaX3XykrZ78rJF2AYcW81TxIcz/My/Qvw2Tb
	gE/J39LaNcXSuR+JtLCSNW6oKVZM1SEEnQbvHMjB8BbJMpH/X6QDFztW+awFK7Q==
X-Gm-Gg: AYBFou3Xpvrwv1+YIdutrAw1iJC1PEd0RGZGvy4OEFXO4BSPufP8nSzoQl51gDCuQ6o
	GUm/bglaqu7qjoR+WCBWiw5RuBuPRAIFi5B3ZrmGYgkrildjQZSh1Hn8a4vjy4Eu1fvNl1/7fkZ
	7tPc7gJ3gjmqlwrHjQ79qNf8V8bbB1Yovq5q78VT0RSts1SG7p8hfrCuOcNpyw9kME9NYy82Z2r
	ZWuwayh6goYreYfhbtTWTdG/BLoT45/iMv0ZVAGkUGIW+7wadODGCLbtZGVFHSHN6eoTuIl6VA1
	VSPwpTpjqrBFmFVl5gdjii265ygXMRiNWWuDzstJ4XgNZ/dukq8NvvtXF1fzvEXxA9K+q4MWZ4p
	o7Nmn4uFIBlWYPdP9
X-Received: by 2002:a05:6122:6161:b0:5c9:a60c:2732 with SMTP id 71dfb90a1353d-5e91f44e07cmr4248159e0c.10.1791901907068;
        Tue, 13 Oct 2026 07:31:47 -0700 (PDT)
X-Received: by 2002:a05:6122:6161:b0:5c9:a60c:2732 with SMTP id 71dfb90a1353d-5e91f44e07cmr4248001e0c.10.1791901905853;
        Tue, 13 Oct 2026 07:31:45 -0700 (PDT)
Received: from [192.168.10.46] ([37.167.4.94])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18beacd2csm401121635e9.14.2026.10.13.07.31.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2026 07:31:44 -0700 (PDT)
Message-ID: <04a1331f-1375-471e-a674-87039aeb0328@oss.qualcomm.com>
Date: Tue, 13 Oct 2026 16:31:41 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/5] thermal: samsung: Add support for Google GS101 TMU
To: Tudor Ambarus <tudor.ambarus@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Peter Griffin <peter.griffin@linaro.org>,
        =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>
Cc: jyescas@google.com, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
References: <20260603-acpm-tmu-v8-0-0f1810a356e6@linaro.org>
 <8142519a-0062-4f0f-b978-980e049f99c1@oss.qualcomm.com>
 <fe159792-c58a-46a9-950b-6c21d2172601@linaro.org>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <fe159792-c58a-46a9-950b-6c21d2172601@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA1NyBTYWx0ZWRfX99BNOInmK8Iy
 gD9TwcFgnrpQKooeRHsnEjl1WAAiKEkCUd34QTn7bhDEnPPJ2hCbvf/2bDPfKrVuFGY5sHjpZjR
 4LQp7A2DHfQgzNP09HIZLtgVeO9pFdtodh58dheprav19pilFBTL3tbAY8tas8tIhrFyoo0zUwH
 w+c2fJZ6k2ql3kX5hpr6H5ulXH1eUKpReHu0fBnA1j6YYcBLoPLEbVf8rdtx90KwsDKqEo6PfPq
 7v47aJhKDJMVkbJAhZcr/QWKtv0lIWHtnQ/ZKcS3kQGaYYmVOHtvHiymNjw0ckwk6Q+3JJ5TPTq
 hUlxQY59l6SzKYmzBW+9OQsJiUSZxW10J/ZGC0obS42CRH/6eG2GHBgDYJ3EfE8Pe78+UpTQF+V
 +5pE1ys0+cLUyMhbdZ30QT9c5Xlou7S6lUYOyTZ48OMRbayaK4LtABvJjDNQnkuyJ40aIpoRBQt
 QQrUbOn7TBAEbjI87JQ==
X-Authority-Analysis: v=2.4 cv=VPVIDNPX c=1 sm=1 tr=0 ts=6ace40d4 cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=Pwpi88Ktxb2v7RWwfB9ReQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=GpSJM9idUVmPmik-TdoA:9 a=QEXdDO2ut3YA:10 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-ORIG-GUID: eirQ6egDeqrUyRZFqKaaxfKQFv0x-wKN
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA1NyBTYWx0ZWRfX+cchKIrb9GHr
 R5Nb5nPz1vYpmUBAJ5td1shYeaS3nhS/EmmlB5+xDAIAGA750Saqe50DGyiJgWJlXCaOSvHsQQV
 g8NVmzfpSTB4Jvm3UPsvK1fg9YQYZLA=
X-Proofpoint-GUID: eirQ6egDeqrUyRZFqKaaxfKQFv0x-wKN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 spamscore=0
 suspectscore=0 lowpriorityscore=0 adultscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130057

On 10/13/26 16:26, Tudor Ambarus wrote:
> 
> 
> On 10/13/26 4:33 PM, Daniel Lezcano wrote:
>> Hi Tudor,
> 
> Hi!
> 
>>
>> I noticed I picked up your series without notifying you
>>
>> However, I did not pay attention but picked also the dts files.
>>
>> Shall I drop them ? (AFAICS there is one comment) and let you handle them separately ?
>>
> 
> Yes, please. dts and defconfig patches shall go via the Samsung SoC tree.
> 
> About the driver itself, I was about to send a v9, where I addressed
> some issues sashiko spotted. Do you prefer to drop everything and wait
> for my v9? Otherwise I can do incremental patches.
Well the v8 is in my tree since a while now and I'm about to send a PR. 
The patches can be dropped but the v9 will have to wait for the next 
release. If you want this v8 in, it depends on the sashiko report. Is it 
minor or major ?
