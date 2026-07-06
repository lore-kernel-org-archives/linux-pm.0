Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F0D38AC8C
	for <linux-pm@vger.kernel.org>; Mon,  6 Jul 2026 09:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783330663; cv=none; b=PFm7dJv3sPjzJ1nLxASF5Qvw1FscLarc2kupCf6hbPoYEBNeY4XYc1Hh6KAInYJQcFNRY7lF8k68KJmPhoSjn4ZOuqjzHZQWDSi4Sosv9ul8briz3C87VFUHgWiKIpTiZ4qmcftJkVQCcWQIHd4IVqQ3+I8XcnTNIlm1ZZ0rHGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783330663; c=relaxed/simple;
	bh=2pB3xK88kaQ2OwiJOt+1p0rqigF97sxkklqXZ52XiMw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DTF3phiU3q9LJn7GsjNmAklKFjCdzxEv9+R1nTLZKoZprY+84GRCbxY/IWwF29EVUMp3NFP6Pb/SvfEd/zl8DBd4W2rdwuH3LBSA9ufsBrCW77XJA0RiSeaOfJvJs67eMUNedn0udoNscDoFz3AIFFjCVL0zkeRIc/vlLmyJQIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PjEtZuca; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fE+LNQfj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PjEtZuca";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fE+LNQfj"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66693s4v4172338
	for <linux-pm@vger.kernel.org>; Mon, 6 Jul 2026 09:37:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	a4T8aHrk2TNFMP8btMDJqGfwbP8KJpLV7dRHZSLqCcI=; b=PjEtZucaCRTi6mcl
	yswok8GRrThyBpS/jkQMfznK6b3NUTSt8swW8GUcl1X/bFTh7kd1YO+nOBfPedgo
	1qes7uzQce6RCSqguBuThFdtHGBSC4AFER2U++MvY+7kRjabcIYXDQhrdtDOSjKc
	3SLCmNRmXBRGkxkyiIcPlvhYEKDRf4hkhpYm+dr88vxmU9+V36Twi8TA9vjFrPfI
	zDMtsh6HNoHoWYZgEGA2YVdbbt9rqWhaIeujq5/GQYnO9VRJlxuH9va6bonpagUv
	QNJqLzvMYtECCdeqgI68JnqnKduR11gfyk5DtPVebTnSi1h/Gj4VMgT4YJKFwGXv
	xbRJVA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f88t889p9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 06 Jul 2026 09:37:38 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cc7e86e7c5so22718805ad.3
        for <linux-pm@vger.kernel.org>; Mon, 06 Jul 2026 02:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783330658; x=1783935458; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a4T8aHrk2TNFMP8btMDJqGfwbP8KJpLV7dRHZSLqCcI=;
        b=fE+LNQfj1BEgzT0sVTDISnKNEXnNG+ZvEnHHWYJ0G2z2waTD4K/m9GcdPq5yRmdsfr
         Qubin38BNPuvAE9uuYP3evrHTpmK5+MsshFwZ9facwyFkWv0b2m5I5cQWkHw6fyreUaJ
         mYyH7oeq8RlWrGVwTPIVgnemBmEeX1AuhXxdSdKWN8bSSxl7nKB+Oah80ghDYKMJYGuG
         98ezifcE3/WW/r6+OYTvLjgSBBHyxwIAiMUEvyyHerZfhFYv5WMTNOAv+Iv2MJd82WqE
         kS7ZpLwpl/CpkjcrY6z2TELJbBqluX/DQuKle0UPBY+cdHySZ2/6/Z+ioMdUFGwHFReI
         fbIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783330658; x=1783935458;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a4T8aHrk2TNFMP8btMDJqGfwbP8KJpLV7dRHZSLqCcI=;
        b=dy44jE9CZRY3o1Vow2qOxLIjv5gwDmxdfNTaBmPKTuQ71Y1LB66Tl2zRKKAsXWt9Tf
         ytlxtlK0r+mow9kJl3oNnOFhjTZ09AuHC167bs6pHxyvlNvajJAHcQxJkS1/MfQ1DvmE
         c10YmqhG2yhmYJL8Mq13Ny2NhChitxKIxQ2zOCI7mY39Jb/H74YvSYuBhu0VdBDr4ZGJ
         OCyyJ1lXHEUT/QqaugebH+Za7HaAuCYkZ4VE9DCnv9m+qlnakBHRwAbAP566f15+irYR
         r6Y8hIamSrwULqerccDKs3/OCuks+pLFoWjP4lrRjUcSPhDZvgASWoTMx6WlL7vl66Df
         1VRQ==
X-Forwarded-Encrypted: i=1; AHgh+RrhiaGfJb1nGBf9jYOp3fBuw0geIMVQkE/XoaWjGng+MlSKa1XgaSWwVR15CgpImaOUpZbsJTJdRQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxvRRFuvWDkU0mKEx1EnAa1/Sd8p5ECiB30A4Wnl4Tc2hPLyRru
	bO2NokWA44rdAJD4ZsysvVJ/AcxUF03LZv3sbhwrt5HQBQ6SxA8hNJvbCbTGocI1Zjdykn4MOJ+
	zSp9QmPXke8hZF9O41Krlltx2e+Tu78UZUxb/ROjphxhop5iv/Elw11XG5nfJ
X-Gm-Gg: AfdE7ckThMpQ3r/7GzVigVxWZ/NXL2Mc4yiPUqWmD8tQHlzFDBsOTud3Rxjsk2fEiOg
	d0UNdegp2jRZVikYX1ZuWsf/+7h5XquN9X+68DKafgxSN8DuZnSHi7Md/B9NFA0sQw/XJFZwk2r
	ItcYJO8KgItq3Pb7UmMC7m8JoQ8hybRqLWbp58KA2nI1qHDj7cXqMxcNLtYSoFBQS2WSy+6WT/p
	cOdn/SkZtMXRDAhdMXWjyJ3NQ30D1J0kef2bY2/jUyuzsQsFUZVM7AA25XvUREmS+bEqCms69PH
	YPYjURNzZ3W+KGCos6k88PLzYxzUmNUfEGrX6JL9sC8DRqdXwdWplmPoe4SNMYP7tWMidYzm9KX
	uOZ0pFf5e7R5UffqaV8OIvQKc5Rn+adyqHZTg9hVWZg==
X-Received: by 2002:a17:902:da89:b0:2cc:8ad3:423d with SMTP id d9443c01a7336-2cc8ad3485amr46920795ad.29.1783330657851;
        Mon, 06 Jul 2026 02:37:37 -0700 (PDT)
X-Received: by 2002:a17:902:da89:b0:2cc:8ad3:423d with SMTP id d9443c01a7336-2cc8ad3485amr46920355ad.29.1783330657304;
        Mon, 06 Jul 2026 02:37:37 -0700 (PDT)
Received: from [10.218.33.235] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cad7147244sm46960145ad.36.2026.07.06.02.37.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2026 02:37:36 -0700 (PDT)
Message-ID: <f1400208-0c47-4dc0-8b69-d3ca2b054bb4@oss.qualcomm.com>
Date: Mon, 6 Jul 2026 15:06:56 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 0/7] Introduction of PSCR Framework and Related
 Components
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Sebastian Reichel <sre@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        linux-pm@vger.kernel.org,
        =?UTF-8?Q?S=C3=B8ren_Andersen?= <san@skov.dk>,
        Guenter Roeck <groeck@chromium.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        chrome-platform@lists.linux.dev, avaneesh.dwivedi@oss.qualcomm.com,
        umang.chheda@oss.qualcomm.com, faiyaz.mohammed@oss.qualcomm.com
References: <20250618120255.3141862-1-o.rempel@pengutronix.de>
 <3309e88e-e189-42ea-b74e-346aec1b4b5f@oss.qualcomm.com>
 <729b0e26-bdbc-42f9-8245-79b2942272c2@oss.qualcomm.com>
 <akJaAesz35Ml3iW4@pengutronix.de>
 <4b5321e8-05c8-4f3f-bc22-d3776e008151@oss.qualcomm.com>
 <akXnLLl_nq2G8EGI@pengutronix.de>
Content-Language: en-US
From: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
In-Reply-To: <akXnLLl_nq2G8EGI@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDA5NiBTYWx0ZWRfX1mENentIMqiw
 5EVnG/X5xYWSz7t6m6l0QhHf9VtFWiJJRNwv/3TXG419Wju0MGJJNN/l3SV8tmhvhL8S2BPRtyE
 KtsSXiDYJLd3/l3L2n2Cj47FFzbry4c=
X-Proofpoint-GUID: hoxjF0ft2HEU56w4KCc-kweiMaRy3UfL
X-Authority-Analysis: v=2.4 cv=C6zZDwP+ c=1 sm=1 tr=0 ts=6a4b7762 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=eap3bQE5FA6eWK0dIFoA:9 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: hoxjF0ft2HEU56w4KCc-kweiMaRy3UfL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDA5NiBTYWx0ZWRfX5nnYOMRkMALb
 Nfy73Zf+lOPqjBtxGjN2enO5NYkCXmlYCjI+BkVJmCM+sq9BL3wKwt5XUME/5GdcUHDCakdeNAX
 k9mpvJQoumM0Yp5HWvBEtBF+B08LKYRJWgXEJ8mLC9puI9+A1yKVRP4qiJxb31AUpTS44LYaOjE
 34Zrg6VHrZUsK7ldh75Zn8hcvuyr/MGfgWAohMvfUWu7MxP255PWdbLNZzf2T+4i/geuUwJlwbc
 DsEFqbQ6Qh7vuXIhpBZp/9qf3KDZAXRuIEfEt2fSxuS+tzP91ywqrH8Qmp9HginqHOGcOQ/f9SB
 cy1Ipk+T4wKgfnqOUcOhJYYBlz6elp5ZPm5RQ0DPXRkyifk6rufL3Cr/0pabUdkKiZ1YHXcHW8U
 uM1kNf7IZXCLpJI45ot6U2bZtNzpoa6YtYaMzb2ZYuyRCcv25BKIDJzgot5/cXN4fGt5veDSh+k
 wFuRMn53eyGoDM5SWyA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 clxscore=1015 spamscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607060096

Hi Oleksij,

On 02-Jul-26 9:51 AM, Oleksij Rempel wrote:
> Hi Faruque,
> 
> On Wed, Jul 01, 2026 at 06:26:37PM +0530, Faruque Ansari wrote:
>> Hi Oleksij,
>>
>> On 29-Jun-26 5:11 PM, Oleksij Rempel wrote:
>>> Hi Faruque,
>> Thank You for sharing your rational behind and idea behind this framework !
>> IMO it would be better to have a single framework to represent all the
>> reboot reasons of a system and not just the reboot reasons caused because of
>> errors
>> Ex capturing reboot reasons like ota, bootloader,recovery etc ... currently
>> nvmem reboot driver does not expose a sysfs/ABI which user app can use to
>> infer reboot reason ...
>> Also, it would be extend this framework to also support firmware triggered
>> reboot reasons  ...
>> Do you have any plan to extend this framework to support userspace triggered
>> reboot reasons as well like bootloader, recovery, ota etc ?
>> And also extend the framework to support vendor specific reboot reasons
>> which can be triggered by firmware  ?
> 
> I have nothing against it. My imagination was limited only by some of
> existing problems :)
> 
>> We can co-work to extend this framework  ?
> 
> Sure. Should I put it somewhere on git, so you can try your changes
> on top of it?
> 
>> On representating nvmem cell to the framework  - if not DT what is your plan
>> to represent it ?
>>
>> How would framework discover the nvmem cell if its not DT based ?
> 
> I'll need to re-spin it and send a new version.
> 
> Are you on linux plumbers conference this year?
> 
> Best Regards,
> Oleksij

Thanks for the explanation.
Having the code available in a git tree would definitely make 
collaboration easier. If you can publish the latest version, I'll 
take a look and try a few ideas on top of it.

I'm interested to see the updated approach to nvmem cell 
representation in the next revision.

Unfortunately, I won't be attending Linux Plumbers Conference 
this year.

Thanks,
Faruque Ansari


