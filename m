Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793902952;
	b=jJVsca+64kUSltKsJdwnkFRpORqJGMa6a6KMahubqI0lyZ9owV7f/iYnhCvFH1nBtzlY
	 egGezOlpmcIXirixAf0F72jJpjEUb3DOcKgutCL1fxAenk0EiO1WsUOjpAVwYRwTrA6KP
	 hI1REfyfeV11KBWqJVoKOKOe8riTKgouHbV5fxeJbTdLXuyUrADmkscKd0eVU5GI92aL0
	 xNsedfU0iABuGAsL6P9CT7pbwXgoWZAs93+lZh7Ejy58ael0DUbW4C7Lf5ymR+8XVm4E6
	 MPmrJWq7Ups7pzcDgsng7jbDh/NrGBgBmc+81g+UN4LXS9CJR/o6J/62aA33hhuhn0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793902952;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=YHJMEIRh83r7RL3if+qhlEXqyFZGQxnKFEkhzXkGzVg=;
	b=dih4vUDFvyvLoq+B/4+yfgVkQGj3J50+9u0l65xV+blCIKJTjll0TXVWMn8102Hai4XH
	 edk2xUNMaNqDwoIU/6WD4ipKDgpcAn1uWpLfDboGOjpVG34qD2R0kXL326DbhGG5mOfA/
	 8To7iF7CirANkxTFtM3hNG9pw74jLgXXADkYeMuU79yYNF6XUgBoQgKSdRpuRDAm/88Sy
	 +yMSju8CS98rCY/d/4eZUiFGH8Ti4CoOAjrIXpRWuLBnGM/D5TibMl25y00Q1if01sfzs
	 wtiuA9MpAdb8Cb/jAjFktZxmtkFUMLLrUAULpb8z0kyBEtbgbtiZhZs4LljWj+L2ESA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=C5A2fBWE;
	dkim=temperror header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=VKuZEg2n;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D1D606A328
	for <linux-pm@vger.kernel.org>; Thu,  5 Nov 2026 18:22:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 79D1D606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=C5A2fBWE;
	dkim=temperror header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=VKuZEg2n
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A5Hef8N2067175
	for <linux-pm@vger.kernel.org>; Thu, 5 Nov 2026 18:22:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YHJMEIRh83r7RL3if+qhlEXqyFZGQxnKFEkhzXkGzVg=; b=C5A2fBWEz+nOeUUa
	yXR1tZzfSVPkA0Ok9Lm5hjlni/66tbBOIlfMQIMhBScbceYCpVWRkuFOHowAIafc
	Ccx+/9veRF4CPl/hJzwm0Lx9ZpxeuLkhzjxtPU23Btr2S4LR+IwYxYdt1mo9Ja/2
	4AK4ZqgT0XzEVGq+cc4BN++k3NHnL5PoVHscghV44poXqP8+wmFjQ4aG3RmxTobI
	wJs276tvSzxgpo29lT86qIUBB52NYLlju/ywUQ42ZutoBkXCm8I57/uJfVJ6YYq1
	8WmgM2R9y3X88jvHNCkFj3OPdTpB+aoRB1GMBTpBAxmiKziBsvCL/tZx40864F6V
	efd17A==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrkaqbbuc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 05 Nov 2026 18:22:20 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-30bcb065bfdso3749203eec.0
        for <linux-pm@vger.kernel.org>; Thu, 05 Nov 2026 10:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793902939; x=1794507739; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YHJMEIRh83r7RL3if+qhlEXqyFZGQxnKFEkhzXkGzVg=;
        b=VKuZEg2neCzaL8hArZuAdDn2OVNiISnxjcCjubCYh7sFmtCczctw0uNQSol0U6SQbG
         mzbKny2pzbSUbT+pYNl5O2cPXu0s4er6EIGFE9bywF//L/VCEdr5WBArVFs8CGzc4LBN
         2pzxlWzw8oJEhwT6i0SfaE6u05NEMVk4XEEzTLCwv0ldlef8VmX0O7z7rFiuSNsbmIr2
         s5WOt4NzI2T0aptvlevG28+VohhftI50eLPMMNXhk7BIuGjQ6DMajG5k0krFfvfdtg3/
         CDZVx6OGlz4JjetC47suthxYyj6YvrEs4LY9bbczeHoYreGeuop0/vNVsQQWBl+ATwzQ
         cxrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793902939; x=1794507739;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YHJMEIRh83r7RL3if+qhlEXqyFZGQxnKFEkhzXkGzVg=;
        b=tZmCq40byW+/yrbIE/BI9EMMY6q6WQSbjMRxqmIHGBQERUia547tRf/CLM4u+bo+6R
         gxVfYrNQc7b4a2d0wHgOAgeTyL10NlxGsNdyYsF6wVe9xEncQoXrbk4IUf2m9ahZ9hrD
         3wSwRVuGUFN2ySEBCqtCYVuKq2gpgYtAqiegAXc5fR1PJnM6ji+uwD36LPm04jqpglcO
         AyJXlx5wgPH44w/UnVsCXPs1/AAM5mPOy+gcOhILU1B30vDr5dzrXjn6nWt8IiRmmWc+
         TxSDVt2wwL0nGIb1xP0pZVK7YTlKvJ4tLxY98xJcmIrOVP84y4Q7hwLVxFTZW2umvfZN
         wXXA==
X-Forwarded-Encrypted: i=1; AKwUvBxJzvbdEVkIxyMoGy39836tSnc0KRW96mEPLG7rXK19C++aM4AAU6bi6s+cfEIpnnCvQePtzrGE/w==@vger.kernel.org
X-Gm-Message-State: APuU4Z8ORpVQ2Yb9sipViYFNdnskatahXh9HUa0Kalxm0HKNNHOtJyUz
	sqoqqobaOFqHrYvk6uS4nbhYLVRKThoFm4I/vxwhv2wMWfvJw30N9P/wI+zw+fYTB+oZRSUkB5L
	FtRJegO1m6s1yhmYCjdvmyHkkh6zvcCEI/6ho5otJ3Qtz8nrkeaxLrsKqfemt
X-Gm-Gg: AYBFou0qpab1agNT+qmXPAPZS53lfxw/r8oAmk7ZUXMYX6LNkx4gXNi9TITT1tOhelN
	dvdKnRNWy3wpXhrrFtMUORkc9xhnarPtBdabHwME4GEkBVTwLxKK97CtaGZTAH14BR6Bh5CuPIK
	tVv4UmBIReNV0MClPzAiA0Xj9o7vvUEK3xqLft8qLic+pMi/CIf3ijs01Okz7H4+AU8uQRGs+nX
	q27vjN4kuE532/eDST0eQI6m73FuPZUtimxYJzDRzIXBHJwFjtOUVJ6WbZ/pY5veJ++PIdmhJ9z
	Vpo9swpR5/ekfqD/r4wyT9UPNHCosxbFwXQ+wtx6Qafw7kJk6RIly8jmY8h63qP/1asaxVzp9zQ
	LS+ewvwoVeoryN9pOQ8zyU+jCtTBXXdksG94CnEf+EOlBuVs0rv8XFb8vgXUxr6gd1q8Wn0rMDf
	LadQ==
X-Received: by 2002:a05:693c:87cd:10b0:36c:a084:30a4 with SMTP id 5a478bee46e88-36ca084365cmr10656604eec.21.1793902939007;
        Thu, 05 Nov 2026 10:22:19 -0800 (PST)
X-Received: by 2002:a05:693c:87cd:10b0:36c:a084:30a4 with SMTP id 5a478bee46e88-36ca084365cmr10656556eec.21.1793902938276;
        Thu, 05 Nov 2026 10:22:18 -0800 (PST)
Received: from [192.168.1.11] ([183.83.138.70])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36f66086a4asm210818eec.0.2026.11.05.10.22.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 10:22:17 -0800 (PST)
Message-ID: <85e8effa-dc1d-441e-a721-e4078388c9ef@oss.qualcomm.com>
Date: Thu, 5 Nov 2026 23:52:07 +0530
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
Subject: Re: [PATCH v17 0/6] power: reset: Introduce the Power State Change
 Reasons Recording (PSCRR) framework
To: Sebastian Reichel <sre@kernel.org>, Benson Leung <bleung@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Guenter Roeck <groeck@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
        avaneesh.dwivedi@oss.qualcomm.com,
        Umang Chheda <umang.chheda@oss.qualcomm.com>,
        Ulf Hansson <ulfh@kernel.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>,
        Bradley Morgan <brads@mainlining.org>,
        kernel test robot <lkp@intel.com>,
        Francesco Valla <francesco@valla.it>
References: <20261019-pscrr-framework-v17-0-69ea6cdf4731@oss.qualcomm.com>
Content-Language: en-US
From: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
In-Reply-To: <20261019-pscrr-framework-v17-0-69ea6cdf4731@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: c4wV_xPpevnYAw10tNYvLxQ7O9Nmp0ST
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA3MyBTYWx0ZWRfXzwBOdGqPunGW
 rJPT6iAdty3zjj9fijqHF7nPN7fk2jV6gBu5pDi47MGZVQXEHXqsvh2sRdr37PhyPl+nGtNDNZ2
 TLgjn1Y0yrNQo+R4wDrCfCDgqrEfL8c=
X-Proofpoint-ORIG-GUID: c4wV_xPpevnYAw10tNYvLxQ7O9Nmp0ST
X-Authority-Analysis: v=2.4 cv=OZoNnRTY c=1 sm=1 tr=0 ts=6aecc95c cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=Ns+0gdUR07JhZB4Cb4qmrw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=8mBobP89YcDz70HNg1MA:9 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA3MyBTYWx0ZWRfX2KexoBz1vjoz
 95hZSM6yXsofYrbr9IHFQOUa51TWMtOnMHBgDG/QlNZ8zQZcrZ5mWrFRDc2Q1NWxYezwsr5qclB
 GVy7NQICcWLRYCCttwUJcGUUXhIzf9iXtr9cH8M9uCzwPYJmyBgRbrSkqg4a8wtHsyNzmyv2TcD
 A06aP6W3uue69euxpkQpsA8FhU2lpEHIFic2rx1rHDTXnpYf3QerfhfjoVo7k8YjbIgMWZ81ItD
 MsXnodXxrw3klNYhG1KN7ITNuoJpNuCdVLf1KFumSCOCu6BqdRF9dTO+NExeFt/ebc3tk7PRVs2
 +5TVrlyC0x7JDzabgdJRRL8GN/ns5bMIDC8fOMgzxkCeoFT9fI4D8K34SvRGARCrkEMGOIFqmmw
 jCS09MK1Hg6csEv1JHBVckzPTHkELZPDZQKi7nno7fJjieKT8+NEwX0kjhW/anggtWTCk75ICdU
 F0rlubkEmcECR/fKrsw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_05,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 clxscore=1015 malwarescore=0
 suspectscore=0 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611050073

Hi everyone,

I believe I took into account all the comments and got the 
different reviewed-by tags from the different maintainers for the 
changes touching the files out of the scope of the 'reset' area. 
Is it possible to consider this series for merging ?

Thanks,
Faruque Ansari
