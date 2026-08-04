Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E2C4570D5
	for <linux-pm@vger.kernel.org>; Tue,  4 Aug 2026 18:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785866894; cv=none; b=nswyw90GnP34Uh15YkekpvHcvrcrbSfHXzKrhGGUdxrphFnfo7fSLrMSFUN1HA/y/LgoQUkz/Hd1mTzAb50AryE3yvQCBY+UxFn5ttfIeiBuakdMgzhnGdRhVZ8xfH9A7/Vp7byPnJMmQD9zbDh2WqT/R2Q2TI+kbDIp0jLvEVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785866894; c=relaxed/simple;
	bh=p402t6s4dsATom6C//ZA3V0XuQ2KGU4ByQP7LL1aEl8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PF31gO0qaR/P8dLkZ+k86S9/yDQEqQ/1Iuz2G1P8nmwxLqOkizh0nxoCgZ0oo4r2qrdVXhGaH7VP6JTDbztbjcTq21PkfwGOWKQLAy4sFfLGzsunThSxleEdXG7sPwRDyqIXiea/2Xr9uscSJu2cqaU97T8bZsv5E7XWec2SPvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=o/rLauv3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Hpagcymk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="o/rLauv3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Hpagcymk"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 674FfVlv070998
	for <linux-pm@vger.kernel.org>; Tue, 4 Aug 2026 18:08:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GU1YtUDGbsfxTlijAya+pOjBIhU0+IZyXpQLGX6+QZc=; b=o/rLauv3GaIsBjcx
	/uTgzvuU3kdMD3n6mT6NJbQU/cw8fHHY/QbTVehsDSdEAcF9ORRT+aQ3CqMzksn8
	kowqJPHoVobbZczkeSYcT9aBaREraZQI4u2T1zdFB3vYYOPw95yy1F2u5AZAistC
	A0HQXm1mO0/W/sHunI/80kPWpgRDRdOr5qqSTxoimsxeK4WEV61D3tQPM9ZdY/BA
	IBaxuYxLJUO8JXes8oqHIigPyd40NcSDsn1qNNG6QnQrhl++mlI8jwdTi3KNi847
	fkcIWGi/npiVs3HWC9jEO6SOEPhDPakfq3CG1xZzGcZbObJbQTjR+a8wpJtippip
	WuBxuw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fujwsgrb1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 04 Aug 2026 18:08:11 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c9c26587e67so153422a12.0
        for <linux-pm@vger.kernel.org>; Tue, 04 Aug 2026 11:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785866890; x=1786471690; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GU1YtUDGbsfxTlijAya+pOjBIhU0+IZyXpQLGX6+QZc=;
        b=HpagcymkPPaoRLtH/uE/cKTzCRu8uJyzDjE+JGhDDQiP+qrT0NLm9183hAxnVkJwbM
         LnbjrI3yGjviQdqowBlcQ5zgKx4MpAnOcFGJ23NAMkxeDJmlzclNnDM3ITpdkUhwJPKg
         dXmottWSy4jRNpVrZKxdAJUn7K+0sejXzOqgRwj6i2jWiSA/hApB/R6L1A0foe/1on4J
         2BgYMVLqmeh2cStv9HcVZHCkILbOvPIjlRhKFROgxmWlhYRdcQ7mLOfGUPjUteZgh/f4
         kyQ6QLi+5Bq0vnoUuLnes9CHJxTTpa4j4eC5rw/RJceAtAzTAZWgvZAppJoiln0lY0ha
         DjrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785866890; x=1786471690;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GU1YtUDGbsfxTlijAya+pOjBIhU0+IZyXpQLGX6+QZc=;
        b=ZQcwrbHqmv43KDG1u2wMXxPPfDFQDmJi8gPM1jPg+m3ZExb66AtJNyPOe6ro3puJlB
         Fgh5xFcfMfB+JaWjPikkaA2V5fMZ/SsPUkISlhsZ8wAtU7OgagOh5sOO5JLia5ewFJAg
         RCEZjpXHLCSvM7XtQpClUs+p2suDAjjVKjjxGuhRcMFFwBVZ5W/nfkkI/vfdurcx/HCc
         eUftKza0blOSVs5X/vKen5C/O42WgzFYn3GTOUNKhqgpvtUVU0RnaJqh6VvC0oheSwKO
         A8WS0jtlHXVl+iOabzxqJPxtssMBb/B+l8dSQDRZzwmqSo8IRtwtqL8omcj7CVv5ioWB
         IhYQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp9I6+DdcXJG62vJK+0i5T7MqalTxxyWS0e9emSK5stHc1MYkHaHisGsaXAUB3JjBUwk15KbTFa6Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwHPGYk+fjfY4xkJ2w+nrrecA1XXmu+MHlcwxj4IrjksCZJH/JM
	h+kIfhW6BuWB8kvgg9c17ARxPg0zcviIlhy/f1uZn3WM9DekZ0BlR6+y+dvkBjl62/YIZvi14eC
	yaWks9VC/eehb3DhliArx8bdXKc6PH64OrlpWh5Nxn5faKRyyuQcpin1V8Et1Mg==
X-Gm-Gg: AR+sD130e7rb7uhj+dxtipXX7SceoqXgkNe41/rMXe0LJCtnqVi6VCTPIywJdsNC85T
	Ru7dSToHc/5VDMMwOzR2QphJWgyuG+4iMGONhMZayOT05aTPxqnI+3WlWcFLpZeBarDLi5YjtDx
	SwvVlyGeaeU5m3dnVZ1t++V7CmaztyeY8v1Ttj5g+Y9Jeb4Nb7udgV3WGXmswFzZHcHSxF3VIVS
	fNaC0ULy9cHqw3ZPY4NX4PfJK9u7WBEFKmsCaoEW9Jh5UBA/3AvjppK+g3X7+g59Hpvk6ikG/EY
	wyoCXauoWxIUwPhN2tJzOPJTGHncoiJcfTrovZpKRkQIk1RiPuLwfdXBhwtrklLpFd7bvIIiF2K
	sKwpiJx8jPPYs/y7YGjjENdIL6TBfzI+4yw==
X-Received: by 2002:a05:6a21:6906:b0:3bf:b7e8:68ab with SMTP id adf61e73a8af0-3cb6c752d6dmr5609277637.2.1785866890336;
        Tue, 04 Aug 2026 11:08:10 -0700 (PDT)
X-Received: by 2002:a05:6a21:6906:b0:3bf:b7e8:68ab with SMTP id adf61e73a8af0-3cb6c752d6dmr5609227637.2.1785866889874;
        Tue, 04 Aug 2026 11:08:09 -0700 (PDT)
Received: from [192.168.1.8] ([106.222.234.41])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315863b0a9csm9922859eec.2.2026.08.04.11.08.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Aug 2026 11:08:09 -0700 (PDT)
Message-ID: <b062ed85-052c-4c7c-ba84-282a4be2bcbc@oss.qualcomm.com>
Date: Tue, 4 Aug 2026 23:38:04 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 05/14] i3c: Make dev->desc locking assumptions explicit
To: Adrian Hunter <adrian.hunter@intel.com>, alexandre.belloni@bootlin.com
Cc: Frank.Li@nxp.com, akhilrajeev@nvidia.com, rafael@kernel.org,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org
References: <20260804133810.184905-1-adrian.hunter@intel.com>
 <20260804133810.184905-6-adrian.hunter@intel.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20260804133810.184905-6-adrian.hunter@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: h9G1UAGaOnlpP-_EhX9akgQ-bDiRe1g0
X-Proofpoint-ORIG-GUID: h9G1UAGaOnlpP-_EhX9akgQ-bDiRe1g0
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDE0NiBTYWx0ZWRfXwCIR/Pb92pXv
 hjIfqUCNSF/C6LIKKrDazdmUEosTcijfha2AZ30Q3ZalO587r8i4uSpH8t4gkesZq26B1t5cnF0
 SR90+m4BCJGlpPo4+eEAlSyttJR3FbI=
X-Authority-Analysis: v=2.4 cv=Lu6iDHdc c=1 sm=1 tr=0 ts=6a722a8b cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=/lQgZcjXNA7ZrIsIl4Cfeg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8 a=RYwuQet4LqFKJ_N4TO4A:9 a=QEXdDO2ut3YA:10
 a=zZCYzV9kfG8A:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDE0NiBTYWx0ZWRfXyB83DkFVVnDQ
 hwaLPGPb6cGJsk99t5HXjjQ6HEwAanPQzDsYhAU7e8aoayESbp1Ud3a5SaI7r0MM0DqMH0+DCtD
 e5hlwGeJRqT9dbolaE5ZTqtG4wrLf4syJC9JkfHwgqVfrbIzJHE1qriAWaTe7qX1os03HxTA2ig
 0n6M1MStOXj80ykzB9oseZq4zakkWvgyGhw5iB4Crt2fOIW9OtScbcOoGi57lmgqzkpnGguCn99
 //+U2XaF5DqFkK5Ct/mTpV0smOTUorLLCYJvBLKYUWMVgljgMfCAbrEjPO940fkrtPctAdYLJIl
 GHUjHpSPEp9i9A9Y7jgZEw7Oc2yejAqvwsqidS5oz3QxoDbC1mSzRFopI4ddHz0UM82BIt/p153
 uQ44+7zD3YkwQjka9XCWMw5fLnaz+R0kGM5fWr5Q+75Ejz/pXKzI1tRpSFRnRsPu05MAvXOtUBR
 dtkZo2H+xxTDF2M2qFA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_03,2026-08-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 impostorscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 clxscore=1015 bulkscore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608040146



On 8/4/2026 7:08 PM, Adrian Hunter wrote:
> i3c_device_get_info() takes the bus normal-use lock before accessing
> dev->desc. Under that lock, the descriptor pointer is guaranteed to be
> valid for the duration of the access.
> 
> Remove the unnecessary NULL check on dev->desc so the code more clearly
> reflects the locking rules and expected descriptor lifetime.
> 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
> 
> 
> Changes in V3:
> 
> 	New patch
> 
> 
>   drivers/i3c/device.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/i3c/device.c b/drivers/i3c/device.c
> index a3778282e84c..5e6df6de0283 100644

Acked-by: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>

