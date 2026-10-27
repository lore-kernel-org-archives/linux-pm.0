Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793093224;
	b=mYEqPeNp4rDaTjWuI/CYn+vIjdN4wiR1uyfDAclCVZjedoiCNq8TQ9JIl9iP8x7N0YNm
	 yVRawqf1dKk+OzL8Um5Rxj+F0aogwnu1cHclgrab6N86lHjNc5jMgWV/Ir3lFy7GeMBjL
	 39DRkuz+u2woUm42+oNmY8SAUK+1+gncSb0mcweIlornGq44E/Z93gfBFOyLvWOp4rss9
	 aXNjtF7V15Tz46qYgxkrprEKqRV39X30lfyLAYkOVFVneW3rdURoVzLr2eYMrh7Fftmmt
	 bUXDbNUEbwbiWZFNRfA9iZQ0WV/W9l3ifho/dXNKxJiIxObQT8r08KCcpzUA2ucQ2vg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793093224;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=h4/IEEwDZXLw/hZQAesBTnBi16Rhs6f/cohcUh8FEIY=;
	b=Gg9zRz57Kw7u0C8QmJyPU0cM7/I2NrwitZ4wxzHl3aMYeTIfwtqWx18R2A89RnY/uzoi
	 gzJR2BjvTWXb9ycn3JXjfu93nAUfXWmbeyHA6Br+IYaUFPoG+yQOcVjH3549z0VtYwUsx
	 u+KWaXfc5w5WESy/RELc/Zp6auOSQjjZdiyuZd6DWSQ6Wdv6GpRmgFUyoyX1ansUhA71x
	 9pYehij4PeoNhIlEB7jSkEOqaw3cQOcaVv9eeX4OV45k/4bi3H2i5lmtCvZD2JshaYTUb
	 7CDHT+Gj266FrqZjD3F3NTDOYiZsVoA6rMLJkIBBv2j2F3+B3D5Klhg0X+zd8KcrUWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=cD2Yk047;
	arc=none smtp.remote-ip=74.125.227.130
Received: from mail-pj2-f2.google.com (mail-pj2-f2.google.com [74.125.227.130])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D00606A31A
	for <linux-pm@vger.kernel.org>; Tue, 27 Oct 2026 09:27:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89D00606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=cD2Yk047
Received: by mail-pj2-f2.google.com with SMTP id d9443c01a7336-2e613f813b0so7205895ad.1
        for <linux-pm@vger.kernel.org>; Tue, 27 Oct 2026 02:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793093223; x=1793698023; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=h4/IEEwDZXLw/hZQAesBTnBi16Rhs6f/cohcUh8FEIY=;
        b=cD2Yk047GntO8zsfZbdXM51UwnSmlkiujCDjVKBZKHjlEC4pxvmDWLLt7xtffKKM4Z
         8zB+imfN4ACLWzc1EijhmoVLfxUXQHib690/YCPcklWWxT9MXSH1GIOOSLorLaHI91YG
         b3rnFOL1WdDzIXN8TUlajdbY8wwjJJfkZrm8DjM0OTDLvMG/colNHSQYb4a+25wNsxbf
         WRPQyYNcWsfZke5O6U36AyP/bCSV4MIr3ABqlyDPCu+X+Weajhrh2yQDfBXEjXGcPm1w
         P/En+NESa6dRXtUXTHGEDgfI2PRplY9SX2qFXVTXdO7CMkeP8tCuSTHVuMkKKW8fxZLR
         PvgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793093223; x=1793698023;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h4/IEEwDZXLw/hZQAesBTnBi16Rhs6f/cohcUh8FEIY=;
        b=C80eLrG5wE1cMOAhte9b9xY1j1/5NlfM/3sMMwTsRWE7ajIjt7kFvcEBmMqSKvAjo1
         7/Xt81aBzlTPc6EdZgGvEdihiZ2Jj8lY/Xc+zSfITlzQ4fxuHo7QR8Bq+WM56Tlw3kMo
         zRaZoDo1JDmubWLKAVnz0Gx2VNyjgLxcouhhFwcOuwXtMZ+k1uAfYeUGBFwrrvCmIo5V
         jW0HH5Oh88F3Kta2FkYWsI0BoJz2qDTomOUpKsDDzrRYwqhFg4XI1qZ4RLhBaEhdoT7Z
         i0yyWAodurleOIKgYu2eT+l0pTWuvSeLa2czoCAuxA/igKOSfFu59Exk1n5po7w94m6/
         D0Ow==
X-Forwarded-Encrypted: i=1; AKwUvBykHuKxOL8Hdo8EQt+xuioBHEnEzbJJaSYoZDT05mLiYtkQ4xDvObmpsRVC/7w3X1VPiunvWnV17g==@vger.kernel.org
X-Gm-Message-State: AFq9FYL4Vi2sIBic5BvLYDf0gGN9PVfWu5ZjZLJ0U3cY3tIdunl4N/P9
	1Pnazy8XbGcxkPpilI3hlWmeWQOVw8sCY8Eaz48ro4iMAAgCssyxiuiO
X-Gm-Gg: AYBFou07ThkbKcHu6RVnOLnH/9K8IxLczOsPM1ySDorSiTwqWBEua/gIRPrJ83jNpq7
	Eg2CLKlRUB5nRxucL7LHcrX3wkc99CzoP7pL+yxeHqv0nhLVa0Q4rwDG9k9Nt54wvMQClmAvfQU
	kwON6Q6or/30T+p6/khhl8AifsMkEUIKPkAYWcTykTiGoSefklGeEQZ1X3CFeJtem3evBoVx+f+
	xK8UvFs+yd6XpGB24fgy+XCGcsEo4myLdmWVgKXIlKnryNmK2S647t8883x/b3DgoDF1Doc2PaY
	bVOkVIf8MuHCaWEMyG3FyIOpYmRxukXQchXxuoHOkHiwSUPsDCc+altilsgukEvU3Tx6PZJJ+ZA
	UFJuywiFmXY6lt/TCCbErhnRixF+s4p2zSlFyyR1Z9zkn+hW/sAjBoxUEe10kksA/P/Qck9WlnG
	rQGHbndnyvpXtUFN6ZMMtm4aRcrkN8/O2eBDTRSrRKHVPe84VbX2FYxNKZeHGN29MHugbk3ed9N
	/IVXgUNvrl3HJPLksveHrZrnhsA7fBxMviQ0jDy9ZnmDpUJxChc/4KwMRZBimfxnAzvtcfslonJ
	gELiYEcrCQwgvmNqVR4TD40bNH/g
X-Received: by 2002:a17:903:19f0:b0:2e9:3dd2:a8f6 with SMTP id d9443c01a7336-2eae3942024mr14409105ad.9.1793093222853;
        Tue, 27 Oct 2026 02:27:02 -0700 (PDT)
Received: from [0.0.0.0] ([129.126.71.118])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eae6b7a216sm6149335ad.16.2026.10.27.02.26.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2026 02:26:59 -0700 (PDT)
Message-ID: <9556e959-daf3-4c85-8794-9613e7e7a9ae@gmail.com>
Date: Tue, 27 Oct 2026 17:26:44 +0800
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
Subject: Re: [PATCH 4/4] cpufreq: add an Amlogic speed-bin driver
To: Viresh Kumar <viresh.kumar@linaro.org>,
 Jerome Brunet <jbrunet@baylibre.com>
Cc: christian.koever-draxl@student.uibk.ac.at, neil.armstrong@linaro.org,
 sboyd@kernel.org, bmasney+clk@redhat.com, khilman@baylibre.com,
 martin.blumenstingl@googlemail.com, rafael@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, linux-kernel@vger.kernel.org,
 linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, =?UTF-8?Q?Christian_Stefan_K=C3=B6v=C3=A9r-Drax?=
 =?UTF-8?Q?l?= <ckoever@outlook.de>
References: <20261025192219.209137-1-christian.koever-draxl@student.uibk.ac.at>
 <20261025192219.209137-5-christian.koever-draxl@student.uibk.ac.at>
 <at7lXEqds7ukoR2V@vireshk-B250M-D3H>
 <1jbj8gkff1.fsf@starbuckisacylon.baylibre.com>
 <at8WfX_G0tfTlFrm@vireshk-B250M-D3H>
From: Chuan Liu <chuan.liu686@gmail.com>
In-Reply-To: <at8WfX_G0tfTlFrm@vireshk-B250M-D3H>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Viresh, Christian,
     Could you please hold off for now on the patches adding cpufreq 
driver support on S4? There are still two issues that need to be 
resolved first:
   - The clock driver currently does not support setting the CPU clock.
   - The CPU regulator needs some time to stabilize after the voltage is 
changed. Without a proper delay, the CPU clock frequency may be raised 
before the regulator voltage has actually reached the target value, 
which can hang the system. The S4 CPU regulator handling currently lacks 
the logic to wait for the regulator voltage to settle, so this part 
needs to be completed first.

We are currently working on submitting our own cpufreq driver. We are 
considering how to address the issues above, taking into account the 
hardware characteristics of previous SoCs and evaluating factors such as 
the transition latency. S4 will be covered by that work (as well as SoCs 
from S4 onward, such as C3, T7, ..., A9). So please give us some time.

On 10/26/2026 4:59 PM, Viresh Kumar wrote:
> On 26-10-26, 09:57, Jerome Brunet wrote:
>> On lun. 26 oct. 2026 at 11:00, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>>
>>> On 25-10-26, 20:22, christian.koever-draxl@student.uibk.ac.at wrote:
>>>> From: Christian Stefan Kövér-Draxl <ckoever@outlook.de>
>>>>
>>>> Every S4 speed bin runs the same CPU frequencies but needs its own
>>>> voltage curve, and the bin can only be read through the secure monitor.
>>>>
>>>> Read the bin from the firmware, select the matching
>>>> "opp-microvolt-speed<bin>" property for all CPUs, then register
>>>> cpufreq-dt. Bins outside the known range fall back to bin 0, which
>>>> has the highest voltages. Like sun50i-cpufreq-nvmem, the driver binds
>>>> on the SoC compatible and needs no node of its own, and S4 is added to
>>>> the cpufreq-dt-platdev blocklist so cpufreq-dt is only created after
>>>> the bin has been applied.
>>>>
>>>> Signed-off-by: Christian Stefan Kövér-Draxl <ckoever@outlook.de>
>>>> ---
>>>>   MAINTAINERS                          |   1 +
>>>>   drivers/cpufreq/Kconfig.arm          |  14 ++
>>>>   drivers/cpufreq/Makefile             |   1 +
>>>>   drivers/cpufreq/amlogic-cpufreq.c    | 184 +++++++++++++++++++++++++++
>>>>   drivers/cpufreq/cpufreq-dt-platdev.c |   2 +
>>>>   5 files changed, 202 insertions(+)
>>>>   create mode 100644 drivers/cpufreq/amlogic-cpufreq.c
>>>
>>> Is it safe to apply just this one ? I can take this via the PM tree then.
>>
>> I would advise to wait a little for Amlogic to chime in.
> 
> Sure, I wasn't going to wait for the maintainers to respond anyway.
> 

-- 
Best regards,
Chuan

