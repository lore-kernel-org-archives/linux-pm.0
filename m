Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3A9470122
	for <linux-pm@vger.kernel.org>; Wed,  7 Oct 2026 10:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791369843; cv=none; b=DI7CMSJHOWVZ2uh525Uw2Oop3mKdw3faoxYm3IpmrnLIgNST+e7TuoHhrNxT5DqEf6OI3EjYyVm9cKc7jr/ioWlCJj1oZ26YyC4x661b8zvKhAbQaICefHAfkb2UygRiGXLBOmK+yhYteIb4XQEaj/XWzrGnFLtOhO6l3h4lz+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791369843; c=relaxed/simple;
	bh=z30z8EFGdS9MpzWJ/1rGZvI4KgHGfl74E2sgwHNMULc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=potUOyCJzZ4mTS1oNCZVFUkfMvNTfgcjHgZTrFwTR6JRK4vuXe6sV7cUgUi20sWfU3YXV2N1rIbkEy0WSi08nuyXTzCaUt94XM3WHutwo27JCHGkiBVY3tHZZE9kdtAvI415OckJSTYJIyI9VWBIp+BU7BARxT+lfu82Vp819qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=V51P7SbJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GDZbimwL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="V51P7SbJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GDZbimwL"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6977jgYf2969764
	for <linux-pm@vger.kernel.org>; Wed, 7 Oct 2026 10:43:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IMClJZgZh+h/7kyhDwRKLGWenB/OxKGkOyF/L/dIWco=; b=V51P7SbJLvGvEKbw
	/LzCisXFhxbYm9Y+3SaAhn9KcGJxeCifWXAMpjuLwRDb6y/P5bPtP0H/AUjuqR+W
	sAh1OGdxFTBIPy9n/68Tiujzuj4QhAlew6GKLqpPcVFRe8p58hmEmQM1bYHnk3em
	Na/ZT6tTd0vYr8VlNj9D5oPLnIK26mMo4JdmfUiDopAbyzfrZL57+mNgXetdQVKx
	RzaWO2kQt9YJSEFZ03oYgxCbH3hTvp1HTqXipg2W8dGvJQWj+iu58cDsDBETgYMU
	x3UcoZ7QTAt6lA1xpITe2wzmrXZgfjtep7l2DoisJItY3hx/n7+cvbyJ6ndmRdvx
	s8jzLw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5c679p9t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 07 Oct 2026 10:43:33 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93e834ff4d0so590380085a.3
        for <linux-pm@vger.kernel.org>; Wed, 07 Oct 2026 03:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791369812; x=1791974612; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IMClJZgZh+h/7kyhDwRKLGWenB/OxKGkOyF/L/dIWco=;
        b=GDZbimwLzrKbn0gTYW9Hy71epSsLmLhmXRApsSlRNTfn7M/Vsc3MHALom4TRzsFAqb
         9CRLHQH6amky/GM3h7qyrm6cjnuZ1wMOKeG6gl9wQAUXgKeKLi8aMNa8M6g8PL2yQMlG
         uYZfH5WzXK/dyKrD7biYAojy4keKqGnrLWLZ5DaRPKNjjLhsOA+qKH+7GNhbN03oO5ch
         ZPuiQT2/+e5IH079ikYIfptfwRMqp2NcSXWjWUdqC46yA191sPr4YgRS7U7wH0CgwB0O
         8szPjgtHHD1bXtnc4f5t3+dJqaEsprJU0P/WIQTXYe7I+kPPzKI2QY8deaZyHgmSvuaf
         cqaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791369812; x=1791974612;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IMClJZgZh+h/7kyhDwRKLGWenB/OxKGkOyF/L/dIWco=;
        b=NSIVxTrwIlwmLzdB4AjZmNlrqLPzaAj8JorYnWoKsAVieBTEQwW8CELWraDTvi1TMl
         p+AOvLNI9asElwCKu0A0JdQAqSyOyK78AMbACddTTOvEaeMi7V+xfsJkpWmcH1e7nT6E
         x82CV1hd8dlLonBeZdVI5yuyGWmz7t3sbfwai7fgVdi+R5C0276eAhGY46XzXqDNDe7r
         vfNbjV/pHEb1COIIsQhIptlVIljvk02qTWTeY5YNZxMeJCk5L+MniohMMfdbR6jwnbGO
         +0gk6ByqQ3wl184ulg8uUcuxAFjpKAGDTkzyO9iPWj73W7xPuYIn3SECMs/hbahdniz/
         sSGg==
X-Gm-Message-State: AFuF++lcCdtzLu0pRQv2+IYuzSE6bSHyPsSRt/v6xEHN7hLvvOQERe/B
	wwRX6hDuZwj0Sr/Wv3pl0XI6TomFvYufArSTUAhiEaEgIQiH9DPRyaUAPye/RmzomQAqBcsjkY6
	uwFnoesMjPNXHAwAHo8hJ+Lu2rOn/0f4mka8pLfL92OqLAuiSpLmaW5d/Tzy/dw==
X-Gm-Gg: AYBFou0Iy5qReK+Xk6zju5tmkUX8O6BKm2Dnsu4E5sGOfOFXZvOA72tDSnooej+uJDv
	CyWlU9H2gzH0pstvdR4ctqShHP5S7dh8QQPTXgNRjqGklL0OISf+9HX4s6zud4ftRQImXSulIkM
	RlAS2RVVi7JmKGCR/xT7xVGDKJY9JPugQJlRPHfiPAX5hJ23Szscw/Ndv4Zb14O2CeFV8UY4Z//
	x9iOvzMhWO1cAaLQHiws0wVZqppQzSoOp3XAaLAAJXwyoSVvLGnGyOCsIdPgpaiWsFAj2eGdx8X
	TsGZgxO3EcH/4WEvfxWMckTfazz0pMVH2myFM6vu4jdQWHIBUyvz6W1149xruTLwlESgPtKHK8i
	Nbm2Ns7ofTfUlbV2X
X-Received: by 2002:a05:620a:1992:b0:93e:9807:9784 with SMTP id af79cd13be357-93e9b8201b3mr318313285a.69.1791369812649;
        Wed, 07 Oct 2026 03:43:32 -0700 (PDT)
X-Received: by 2002:a05:620a:1992:b0:93e:9807:9784 with SMTP id af79cd13be357-93e9b8201b3mr318309785a.69.1791369812011;
        Wed, 07 Oct 2026 03:43:32 -0700 (PDT)
Received: from [10.40.4.23] ([37.168.19.198])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a17f4eac2csm72420585e9.0.2026.10.07.03.43.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Oct 2026 03:43:31 -0700 (PDT)
Message-ID: <99cd4231-b186-4db1-a9d7-45926720b16d@oss.qualcomm.com>
Date: Wed, 7 Oct 2026 12:43:26 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v4 1/3] power: reset: pscrr: add kernel panic reason
 tracking
To: Faruque Ansari <faruque.ansari@oss.qualcomm.com>,
        Sebastian Reichel <sre@kernel.org>,
        Wim Van Sebroeck
 <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, Benson Leung <bleung@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Srinivas Kandagatla <srini@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        =?UTF-8?Q?S=C3=B8ren_Andersen?=
 <san@skov.dk>,
        Guenter Roeck <groeck@chromium.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        avaneesh.dwivedi@oss.qualcomm.com,
        Umang Chheda <umang.chheda@oss.qualcomm.com>
References: <20260805-pscrr-reboot-reason-v4-0-54ef517084cc@oss.qualcomm.com>
 <20260805-pscrr-reboot-reason-v4-1-54ef517084cc@oss.qualcomm.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <20260805-pscrr-reboot-reason-v4-1-54ef517084cc@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA0MiBTYWx0ZWRfX+SFJKbW13KiZ
 4Z0C4roNBW4mljwsQsdqdNbE5Zbl4tUogf8S8kFHUkKWOOVBGP90teeAS/95jtMHcidHSPsXveN
 aGkU+w+XtTavgJ7hEcUDcPgb+EY5rJM=
X-Proofpoint-ORIG-GUID: pu3S7n7wi-_KTYu4Toe6kfGdPke55Ulz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA0MiBTYWx0ZWRfX4gYLhOSYmcsr
 MzGL+zwEavndc5qBhck4mOFSykKAtTJMtyAuzLiyajlLWX+p6e6yg3pSd70BM/qpB3Xb4d4ysxB
 j7yDlHkfh8lefwa4+sFil8uyTUw5B1SG8VE9Z+MbmxbQFtp4mQkfAGEGbwbb0fOF4PuBEuF3218
 kl8MVlY+rosnRZhjlWpEWpH86/BYYStdwJ9iO3Z9TX7cEjOjOPTEH2UBjkEeFsLBTIWl6//L4wY
 Cq9aJTQraSSIh+fb5zL/Jz3Z8SoIXB974PLuHVpTvXArkF0uaSpWz8EjkMarzLwzaGPf0lec5la
 1/5H0djrysMBdM77WJsLsvpZhAB9TAsN8v7jCfG+86wF02gb1uFPfGvxaq3fS6VfVfWgmLRLixU
 fPOxD49o/6D803+cg6X9iRwQ6ARDovJniVs9+o9pFxCM5/m74IUML/PBR05VudKuJaxXqf8XFQz
 5uLYDWIfWokH2Z/Kl/A==
X-Authority-Analysis: v=2.4 cv=OfcNnRTY c=1 sm=1 tr=0 ts=6ac62255 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=YKLnzF1Vlz+PFNxJOoRadg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=NAPdFkqvqfqtUqX-_sMA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: pu3S7n7wi-_KTYu4Toe6kfGdPke55Ulz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_03,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 malwarescore=0 bulkscore=0 clxscore=1015
 adultscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610070042

On 8/5/26 10:54, Faruque Ansari wrote:
> Kernel panic resets are not recorded in NVMEM, causing subsequent
> boots to report PSCR_UNKNOWN and making post-mortem analysis more
> difficult.
> 
> Register a panic notifier to preserve the shutdown reason across
> panic-triggered resets. Add PSCR_KERNEL_PANIC as a dedicated reset
> reason code and its corresponding reason string to identify kernel
> panic resets on subsequent boots.
> 
> Signed-off-by: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
> ---
Reviewed-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
