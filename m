Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559AB3F65EA
	for <linux-pm@vger.kernel.org>; Thu, 30 Jul 2026 10:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785407480; cv=none; b=ZrXm+inGawP3YEoLSz70+UOEK/p1woiCYoCIydlsO01QvgxqnHr9hhIJFbeloWGZr5OTUGQ3B5i+W69TaFmk9s6eIvmnLdFHzIuowfYVsa9DZqsXQ+tNmg6hxVKer8IVroXLEKqQ+QY37JUu7njGLIqKPjGHnUK8gXZowe3mzUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785407480; c=relaxed/simple;
	bh=MkFho+L+7qIi6ClR+NBgfddbQ9MuhqymAihXj6m77qg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H6/++WvA8P8cvosSozhUn6nv1z2n5CHWHuI4P8g9tYsGGmPL0IFRe3bC1qv/OTalffRTXOI73ib04JSUGr4tnjcT2d63S5ZMZNC5esf6yOC7vsk9obNKM4IJHSKqoXgjR/11e2y8p+bK/I5NsK0uTd5+44vYiwqAk4BbKpYC6+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XJ7TJymY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GAGYu+hX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XJ7TJymY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GAGYu+hX"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UA2O7H1663941
	for <linux-pm@vger.kernel.org>; Thu, 30 Jul 2026 10:31:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3FqmpIR1hp9650zedC/Cu7xxjGufkMIKEyfbRtcEbtI=; b=XJ7TJymYZTIxb1yQ
	APCeZ1Nwf6sfl0B294j1PC3xenfdAGPMzTg1oCbkeo8X6i1cERitfxbuHhUKInr6
	SPQ3xYd8a7HvKyDxCBLXNSNW3dTFc2av6rxwjiwIZC0Z+hJhVzIo/mr+MdaH/C7R
	ncnC41eL2vOoQr1Hnrdf9Yv1gxYCn5Ns3tffBX2EhpWX8P6QKZ9Qsf9ERiYG/zrl
	xXtDz5bR+9RcpkXQ5o+Hm38UQDvu7jKKbOBfXt1vXlORoEA6mxDOsZZPxXWSG5uD
	DQpvs65a2uopeEbkjh0ZYWAKfB2sIOMpkx+D0+VDUZFG5C0uyPoZEKPYrIoacX/Q
	zQyl0g==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fr3h1redf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 30 Jul 2026 10:31:18 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cb7d6ba548eso2419044a12.1
        for <linux-pm@vger.kernel.org>; Thu, 30 Jul 2026 03:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785407478; x=1786012278; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3FqmpIR1hp9650zedC/Cu7xxjGufkMIKEyfbRtcEbtI=;
        b=GAGYu+hXFdsZyJewHlmUAyF3+vG1HdjhWZAEvUGUdmuA1QLDERdgShhEqmBTaxE/7a
         iQz8XxDojNGh5MFFoo1IwNebIF6Nv9kx2e4m+ZbldPBg1MrPbiVz4plutx9eB+1fW3SK
         Ah+igm7w0e8BF82E8LmrhGWldn7eJPyjlYUNzNoAR/AA8mtGUR/N3GSUJjs0F8i0T8sS
         43vabm806Lpg9jiol+uU4dTMGKszsi8zDtqaiPVOiOK/YB7mIkXp1EhJLi8bFQCFKin8
         DVA0wj98++M+4LTYakNfA9d7JD+2WEp7doXnNxlVw5paCyb7G9vqUCu+u3GnlKOuhiDn
         i1YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785407478; x=1786012278;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3FqmpIR1hp9650zedC/Cu7xxjGufkMIKEyfbRtcEbtI=;
        b=WibeEeYai8lcr1HMPoXXb8iQEUlAeiZPyACQTVVNqr5n/fuO3e9Ram9z1fhyCAVGOY
         GZA8sSmxzxHambGSSNj7/pLqSeQp/WuBg5E2hLc+i4rweJJ/Bg/+UYO0fpyoEAcOWdvh
         ElgzWNEASM+r1CmtWh4b/32CuWleUUtiFPcnm7y+UbTWVj49zZNWsv2QINPZGVSy7SZq
         eTXVPp17CmpDseY+s/D7NXGe3sXimdHF9i+m4QlbhKMlIoFrIysvPN3PmehjickdKObl
         YThfolROSj1Zyq9IWGuwljCK3FvbcfHAEEKy5b3nZzO2pawk7wwgB51/Q2KDm0q/dsOy
         +4wQ==
X-Gm-Message-State: AOJu0YzZZlNHTZaBDU+GiODuWzzbaoNwVpB2ZRZ6RyzNViiQhMPhnAPR
	KoVbSUeo9DQ6OLvFC9rgdnhkq5qzuNnKt1zgmiZjXPGezoFnAeWaH32e4ytsg2e/i4wQexOLWaL
	S4jJ2IL/a64f7tWPkunXovvydxJImj7Om2v+c6Pqfpb9W+triWH17CZtopW3T
X-Gm-Gg: AR+sD124S3sEX4MxL7PY0NWjMh+Wl2Zv6QxlJjU5s0j7thuD7cWEO2x3gowzbFEICiS
	YE3fBiuqwgb4jOFJyr6OicCmZRnN3dyR+l7oJNuoPaC7p1Y2wcQE0pI6kCKczPXHTFp02oSQWxW
	vfY5xp2fjscPNCYZ5RLYR7/CsfsuYmSEI89APzqxB3iWWfiQ0j0TuIqjkSKfX0LjqWriW1m/6Xr
	xkYRl/PKJruc+W4+28CkVAH2zWX86GDVmT8T5iLjVdBQPN+k3zkyrO6xUTY72I1AN22mDMSKpD8
	1Aer+b+Ke50gMWk8N/9Wnv+n1FcnM1fctw2FOnGGMVOjmwTFGDWgZWZbUHNxTN0dNO2odnc/el4
	6MBhciZMicBt9oEyubCTQrdwWfaUdAUg=
X-Received: by 2002:a05:6a20:d49b:b0:3b3:1c7b:ffb with SMTP id adf61e73a8af0-3c90057a0damr1917898637.34.1785407477725;
        Thu, 30 Jul 2026 03:31:17 -0700 (PDT)
X-Received: by 2002:a05:6a20:d49b:b0:3b3:1c7b:ffb with SMTP id adf61e73a8af0-3c90057a0damr1917858637.34.1785407477220;
        Thu, 30 Jul 2026 03:31:17 -0700 (PDT)
Received: from [10.218.33.235] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbdba3518e1sm2024080a12.16.2026.07.30.03.31.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2026 03:31:16 -0700 (PDT)
Message-ID: <1fdb31e8-e6a3-47b8-a021-bf05cd61848e@oss.qualcomm.com>
Date: Thu, 30 Jul 2026 16:01:07 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] watchdog: pretimeout: record PSC reason on
 watchdog pretimeout
To: Guenter Roeck <linux@roeck-us.net>, Sebastian Reichel <sre@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Benson Leung
 <bleung@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Srinivas Kandagatla <srini@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux-arm-msm@vger.org,
        kernel@pengutronix.de, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        =?UTF-8?Q?S=C3=B8ren_Andersen?= <san@skov.dk>,
        Guenter Roeck <groeck@chromium.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        avaneesh.dwivedi@oss.qualcomm.com,
        Umang Chheda <umang.chheda@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org
References: <20260722-pscrr-reboot-reason-v2-0-495ba3005953@oss.qualcomm.com>
 <20260722-pscrr-reboot-reason-v2-3-495ba3005953@oss.qualcomm.com>
 <b7e5b66f-1f27-4c3a-a66d-2100a982aaf4@roeck-us.net>
Content-Language: en-US
From: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
In-Reply-To: <b7e5b66f-1f27-4c3a-a66d-2100a982aaf4@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: ImGq5NDN5WrezwkapAgnCx-h4Fsl89EY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDA3OCBTYWx0ZWRfX1rffAUUVGNR9
 i8/BMji4pCn9LqG0e086MOYiE+D7hOeWaawpok1F40YaBHOzFhEnBqC1wa3lp/b6Qz0iszS4wZY
 LuxsowMWM21jdOnxuzuMUm3QfrSxRgEYGoTd+4y5ua1QFtm+ncDdvA9GvDEbFIjy5PyyrBC9h+3
 PbmtFcwGVlnqLxg1w1m3/olcwwj3iFeo3IysxUwlzbGxJOMpQyKLt7WvZ3bFSZ3KoqAijJ6IwCF
 AOjvi8/X5f6KBrcRnSt+lfOZVxI7OptSr1TmWRh+pUP7fwluL1wBSD+weu38BLXBbK2mdcALVQL
 xVyD62UxO7+KGhd+XnbFbIsKrXZKYOziVh2T4YDhRY4TkNsXW1Ntb2C03D3vVMvonmld4bimhiY
 tBWtjSjHrRtp/hBTHsugCcRocU/2C0+pMffdexU7bTZFECnA8c9K3aUwXm/WuSgpZnsoCbhdP7v
 N9InpJBPx5xTjytkU7g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDA3OCBTYWx0ZWRfXxvDsxB1Da8G8
 qGEA4PMJGx7ME3w+eCBTHogUxrECJ4e6MNf06in+FE1Rpo8jV27wzBWtLYx9Te5BTgIoNzWfXaK
 bR93gQ0BWeavLzs8Z5cqQV4nH3AGCKU=
X-Proofpoint-GUID: ImGq5NDN5WrezwkapAgnCx-h4Fsl89EY
X-Authority-Analysis: v=2.4 cv=K/QS2SWI c=1 sm=1 tr=0 ts=6a6b27f6 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=hzOxsa2yftWTDtbb7UEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_03,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 impostorscore=0 phishscore=0 adultscore=0
 bulkscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300078


Hi Guenter,

On 30-Jul-26 10:33 AM, Guenter Roeck wrote:
> On 7/22/26 08:13, Faruque Ansari wrote:
>> Update the PSC reset reason by invoking 
>> set_psc_reason(PSCR_WATCHDOG_PRETIMEOUT)
>> from watchdog_notify_pretimeout() before either the panic or 
>> noop governor
>> runs, so the reset cause is committed to persistent storage 
>> before the
>> system goes down.
>>
>> Signed-off-by: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
>> ---
>>   drivers/watchdog/watchdog_pretimeout.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/watchdog/watchdog_pretimeout.c b/drivers/ 
>> watchdog/watchdog_pretimeout.c
>> index 02e09b9e396d..ea48d4eca4aa 100644
>> --- a/drivers/watchdog/watchdog_pretimeout.c
>> +++ b/drivers/watchdog/watchdog_pretimeout.c
>> @@ -4,6 +4,7 @@
>>    */
>>   #include <linux/list.h>
>> +#include <linux/reboot.h>
>>   #include <linux/slab.h>
>>   #include <linux/spinlock.h>
>>   #include <linux/string.h>
>> @@ -103,6 +104,8 @@ void watchdog_notify_pretimeout(struct 
>> watchdog_device *wdd)
>>   {
>>       unsigned long flags;
>> +    set_psc_reason(PSCR_WATCHDOG_PRETIMEOUT);
>> +
> 
> A call to watchdog_notify_pretimeout() does not necessarily reset 
> the system.
> It only resets the system if the panic governor is active. Given 
> that,
> I think this is a bit misleading. If the "noop" governor is 
> active and the
> system crashes later due to a completely unrelated panic, the 
> restart reason
> will be wrongly logged as pretimeout.
> 
Thanks for reviewing.
I agree. My intention was to handle both governors through the 
common pretimeout path. However, with the "noop" governor the 
recorded reason may be misleading since the system can continue 
running.
I'll move the recording to the panic governor path in the next 
version.

Thanks,
Faruque Ansari


