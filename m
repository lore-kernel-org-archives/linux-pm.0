Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.138
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793093514;
	b=EPAWM5i4U9AgUOY4KxZ8tpwLTkQ6sTKtTdgNW4EBv/Yv1ssCXrvDPLdqOwlkMaXQ3EZ9
	 K6pbEZXpkz8m/pEK0uIr7m5YTCWy4tnO5wcMPvhMXH+AqYMClAb7Eiw8qiY7v1j+IQq99
	 k9Jy+EtTp7YFYnMT3Yyxy0x7W4PbTAU4csHvilDfM8ctRkB0ezv1Ms78/pxolt393enjw
	 +S+QtQG2etDt9Lwy3gRfWNm55HSeDa0phuAmAl1E7ekm++RGofsdX8sbVNEvl4bT7z4kh
	 I5CvIa+uPuuamYSG8+8IObKoYAQNTwNG/Hh2l0Q7RqaT9HbvwVb+2ccNgEdQV+xQGhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793093514;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=0lp8ix384KyuQihbhJDejl7Hsm+NKly5D1mQFcd+Ymw=;
	b=H8/CvWzp6qFsqkBeF8kbgx5Pu96dm5Pik83drXDQguHLbIYbbrFkZ76mbLk6Z1v0/KxB
	 1xBd4iOkFv6PohBmMIXllCIm7zf///Q9kiNKNPGo6eCpk80ONCMkflPmBUHKEHChz+rbd
	 Y8VwiGZQwuqoGXMnRnRgb+E8LA2wsdmIUS5vaZwfQR+PNvSLGfb7SsY9hKUgXbTbY3DNT
	 P0dwfrCC3VJi1TZm3kdCF+Gakjvw5qq0mBjzcQG5nxF81SxEgumPO/e8Qkm7cnoCz+bfF
	 0UX18CYI8DGXSogNskbXlCpJHVFu5oH1AKv0d8FB/Sh1W3jMVKaL51inSRUYUldo+jQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=sq2fTXIs;
	arc=none smtp.remote-ip=74.125.227.138
Received: from mail-pj2-f10.google.com (mail-pj2-f10.google.com [74.125.227.138])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8FE606A31F
	for <linux-pm@vger.kernel.org>; Tue, 27 Oct 2026 09:31:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B8FE606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=sq2fTXIs
Received: by mail-pj2-f10.google.com with SMTP id d9443c01a7336-2e934c6c1c8so15468525ad.0
        for <linux-pm@vger.kernel.org>; Tue, 27 Oct 2026 02:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793093514; x=1793698314; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0lp8ix384KyuQihbhJDejl7Hsm+NKly5D1mQFcd+Ymw=;
        b=sq2fTXIsEYbEUtg0IqcDKMHteJoXYOAwMDyVqzIZfLLacj5r2gHuBfSfVl8SDyy//I
         Tgb1smw70VKqwN+dX7VApNE2E06pGewPMGMOz5yPZqhk+5pB4o3STGObkK3bQaHabu4Z
         vKfn2epktM8g9ZRjHpbg0zdov6W+IhCKQEfddtM5iOoYqxKzxwH5UJvsqwWkmbhJRPt6
         ig1SSiA1WHltZOvqZVm+1xYWO4y0e7xlazNAlOi8z8KfyeVRmCE5lAJS81DSqE3PxT3W
         lZn0JcA5XH6KEsoIoxJHZ9nq3LaW8OztyM6SvlC5W86KkD92x1DZXIuLwBrr9JtjwLoO
         MZYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793093514; x=1793698314;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0lp8ix384KyuQihbhJDejl7Hsm+NKly5D1mQFcd+Ymw=;
        b=QYsiuli72BywVH/IuoSnAdofA3oI2cqmR4K+FV22i8VT/LSz+D1kIrEMxOxQMbbKvk
         ibMg5seMdhkIwO+njl/imd542niesWtdl0d7iivv8Lg1uncDaMOrHEIFie5zut1HXlbx
         usM2XF3LEeXpLdfATtbgn7H/8MW1GvyYoIBt8yUEiPeNLzlWxaLzHyVnK+0XnURThWnR
         6qoPLKmen+YLJPlMcn7H+ut8Wq7lKve3IHA+Y/SwNyTCtIu7eX0R8bgyp/q2dbhNFYl5
         aKJOn+w609Nx7DoM+9ut/6wKF5CPVMXOsWyEojuaPnI3IKphbN1NUH8TpzQxLFQX7Xs1
         yA8A==
X-Forwarded-Encrypted: i=1; AKwUvBwDWqljAT61P7JpfTu/OybfvPKKepTUWsKuwzSHadG2dnmQzC9LwqyVfyX0imNbPtY4gx1LovG4kQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYL4moHD0NeSgzmVs2Y+V1iszD0SG9gAWkcLKdSb2TUMZ3p19wdi
	xduapekJ0Y13CSoLPxetDfEqXCaI3NCqkijK8tkHyPXHcc75F/GqEzC+G4ek8NZThBXeRpih
X-Gm-Gg: AYBFou0iOAZo0QwXFawCDd8fc6fye2oDMqbtnIIFfzphpmBEDKdL7ZH7r3dIli9XeNT
	Xfpys4x5vNA0VFdKV5fFYN4TEcoOYaJRxDgNGvG6p3SVfYClj8FmE6SxKC6G3HUykSVavR2+LIt
	jxhOsaxMHeyUtQ8BKBSqBWTnK91EJJzfKZ0M+Hvb2BRUnqs4i8ao2zeEBJUvjcV2Jj3gKNU65dh
	jjdeceG2L3Qd5HBudmF6iJbb+Iz3uyUkUDuUu28zggwUqlp5pbNAFZCZRI0bElpn1LycUDXq6CI
	XwsjiiJCDFgHuuXUHqfmmvRDLFS/phcRH6bCCXGlGhDPGu3Vzc0sEZ3wmVx98AmzLYGf0prCDqe
	Ffxmh2rMZ6heIUSkuq75WGEDULFwmi0q41rOlQluNzM6dsizFXyyAnVlnGn+X2zt1W6iH6vSA5p
	0k/RiDchq2G02fHI4F51gI4GflPsIOvZAWArVnZQQB1hgBHOxbqzu07oDyB0NgJlNOi15g9gymH
	NgL5r9TQRsgTjjJbTakAZ5n+lEgCrNX9hhusJCqUIylXboUxSSqEKTrZ4VDISt4xHj49Jf9upCO
X-Received: by 2002:a17:903:3c6c:b0:2e9:7719:4104 with SMTP id d9443c01a7336-2ea9c03f2ffmr86182255ad.8.1793093513672;
        Tue, 27 Oct 2026 02:31:53 -0700 (PDT)
Received: from [0.0.0.0] ([129.126.71.118])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eae6c9757bsm6281855ad.58.2026.10.27.02.31.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2026 02:31:52 -0700 (PDT)
Message-ID: <e9764219-8afc-4e8b-985f-9611b0c9a28f@gmail.com>
Date: Tue, 27 Oct 2026 17:31:44 +0800
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
To: Jerome Brunet <jbrunet@baylibre.com>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 christian.koever-draxl@student.uibk.ac.at
Cc: neil.armstrong@linaro.org, sboyd@kernel.org, bmasney+clk@redhat.com,
 khilman@baylibre.com, martin.blumenstingl@googlemail.com, rafael@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 =?UTF-8?Q?Christian_Stefan_K=C3=B6v=C3=A9r-Draxl?= <ckoever@outlook.de>
References: <20261025192219.209137-1-christian.koever-draxl@student.uibk.ac.at>
 <20261025192219.209137-5-christian.koever-draxl@student.uibk.ac.at>
 <at7lXEqds7ukoR2V@vireshk-B250M-D3H>
 <1jbj8gkff1.fsf@starbuckisacylon.baylibre.com>
From: Chuan Liu <chuan.liu686@gmail.com>
In-Reply-To: <1jbj8gkff1.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Jerome,

On 10/26/2026 4:57 PM, Jerome Brunet wrote:
> On lun. 26 oct. 2026 at 11:00, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> 
>> On 25-10-26, 20:22, christian.koever-draxl@student.uibk.ac.at wrote:
>>> From: Christian Stefan Kövér-Draxl <ckoever@outlook.de>
>>>
>>> Every S4 speed bin runs the same CPU frequencies but needs its own
>>> voltage curve, and the bin can only be read through the secure monitor.
>>>
>>> Read the bin from the firmware, select the matching
>>> "opp-microvolt-speed<bin>" property for all CPUs, then register
>>> cpufreq-dt. Bins outside the known range fall back to bin 0, which
>>> has the highest voltages. Like sun50i-cpufreq-nvmem, the driver binds
>>> on the SoC compatible and needs no node of its own, and S4 is added to
>>> the cpufreq-dt-platdev blocklist so cpufreq-dt is only created after
>>> the bin has been applied.
>>>
>>> Signed-off-by: Christian Stefan Kövér-Draxl <ckoever@outlook.de>
>>> ---
>>>   MAINTAINERS                          |   1 +
>>>   drivers/cpufreq/Kconfig.arm          |  14 ++
>>>   drivers/cpufreq/Makefile             |   1 +
>>>   drivers/cpufreq/amlogic-cpufreq.c    | 184 +++++++++++++++++++++++++++
>>>   drivers/cpufreq/cpufreq-dt-platdev.c |   2 +
>>>   5 files changed, 202 insertions(+)
>>>   create mode 100644 drivers/cpufreq/amlogic-cpufreq.c
>>
>> Is it safe to apply just this one ? I can take this via the PM tree then.
> 
> I would advise to wait a little for Amlogic to chime in.>
> Patch 2 is something I already rejected back when S4 support was
> initially introduced. I suppose AI just unearthed it and did not bother
> to mention it.
> 
> Amlogic was supposed to migrate to SCMI at that point, and possibly
> handle CPU frequency scaling through the secure fw entirely.

Yes, starting from the C3 clock upstream submission, we replaced the 
SMCs implementation of the secure-clock with SCMI. For the latest 
released Amlogic SoCs (S7 and later), secure-clock is implemented 
uniformly through SCMI.

> 
> They did on later SoCs, I don't know where their FW stands on the S4.

Most S4 customers receive a secure firmware (bl31.bin) that sets 
secure-clock via SMCs (because the S4 SDK had already been released by 
the time we added SCMI support). We have also provided an SCMI-capable 
bl31.bin to some customers.

> 
>>
>> -- 
>> viresh
> 

-- 
Best regards,
Chuan

