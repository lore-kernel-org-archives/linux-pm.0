Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794911673;
	b=oNmIgk+wAiXSdCpiYCeXCLf+I0Wsl9A6Gtw6tVhqVtnhIvG9sZkhda72yWmocFW9VB7E
	 Azfd63kvS+ciiORMXhXixwQq1H03HaUfBJ58jhKbj8UuBtw7jfxAUxlxofCS4pcKGnblp
	 qpnSTNijABKbdoqWUr5EzRP9knzBHA/EVVgHUYYC9H7f7nkVe4ykUs/W99cmZ94CpT2kx
	 UloV1pyOVwIku2+uF0r4jXggogig1OOlKLs58BCySseG7hwyDMYGgWVEiCZbl1XsPpsp4
	 CrWTNKeJFhHDqAHsu4aABijmKXKlQbtJ1ARoPbAoXrUOyvqmTIfS80ehHDS8Xf4+eeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794911673;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=BmiLk7Woyt+5HnggThSiC1LBGvT5JbyN4EymqDd4Y40=;
	b=Ia4w33GvFD9PPUSOM5i2rgRfTywIlfdKPD9gJmpND0YB5FfLxfkkpm+P2M5QodSP8u3N
	 zqfYuhSTdXLTBw0vOL4fAO/E3Rg9wp+1CLsrkzCzKmKaN0Gp+12EolbicZ6S+eqgJD5tQ
	 QYq+r+FSiJB3Qy61pQMR/Q1g3E3vpnz0Kr38t1yy+zoIrMRPvQVd2dboiG07asMULmrHR
	 VPM1xtTyRMX5BtwKbvlN5B+mIomHCBQAUv1qM/vw78GTSaDoy/19BeVuR650GzAOccKWE
	 SxRspovB+kZ79F0NU+zdCMXm7UeSBXvODTWPav56ONP2w3D5afmQZ6epl7Xenli9PkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=En1EFsdr;
	arc=none smtp.remote-ip=74.125.82.42
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA72A606A32F
	for <linux-pm@vger.kernel.org>; Tue, 17 Nov 2026 10:34:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA72A606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=En1EFsdr
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-18818daa3e7so415337c88.0
        for <linux-pm@vger.kernel.org>; Tue, 17 Nov 2026 02:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1794911670; x=1795516470; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BmiLk7Woyt+5HnggThSiC1LBGvT5JbyN4EymqDd4Y40=;
        b=En1EFsdrdIkH9eyOkefMREOOPdHM/WJ+nB7do8MFPGS2RFE46buqsjhkuWVzuC8m3+
         3gF/6S2D7s5EKUEATZ4QiaqaxVW8vxGRVrNqRlv0ezJXermBAeEXcKla4/EuExo3AGhx
         744hX1dAhanRL4MRxPITaiF1pZc7rjSKVLZmLgqQPaxwG9QHuvi2XbBzY2z/Oz+c8clw
         w9aV/YcX9cHZDqQ7JoiLvJYMcZUoztZLy/qKIKtof7mobdWmjRX/Xb605HQRdDqW74k6
         TMi/qHyRczbrpjgMZe7BkgoUBqZIoFt20gqXXVyuC5UnYYSFfLMRBcKyYryrj3FhAjnf
         j83Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794911670; x=1795516470;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BmiLk7Woyt+5HnggThSiC1LBGvT5JbyN4EymqDd4Y40=;
        b=soVhXHUh02xZKx6Fj8dUvjaEDsqsBOOKOSCgQc/5RVLaeK149LUMdXCatwVWVlXyvT
         jkekzT3N031bNchoEdGSkqdnyOjgBTL0A0rnUhTgZlW6WkrlpRtCpvT6mfGWuVqQG5c2
         HgfBtQZ35/xHqHweVUxhIiAa0/yVC1+GR1GaiB4wvNmg+p0hk69BZC/4ogPKkuXLmmQo
         QY7scmDzJyt1uk7r+V6SHBziq/994QTOESjsBlktpJhvAUdBWta55Ia+48C0cIxnCOfj
         W9BjfEj/vWKHTJ5SKEcoEiuwixSvawqGNURnyIn0x7MdbRdjtpgUQiK9+ajY5RS9cRLG
         l36Q==
X-Forwarded-Encrypted: i=1; AL+hErG+MRdNSoDxyr40gVNgyvHYLktUwiyOZBDzzk1Q7O79Fa8FBL2CCC+D2NMFswntPihHson8Or2ksA==@vger.kernel.org
X-Gm-Message-State: APuU4Z+x1pI75nV8r4UlipJVj/wFGEJ9nx+eBggKN+YCDgxmOh3Kn5Wq
	wcmVec44Yo+uLFlyLrZKf6ExeV+OterI/9dl2+2R12AYc4AcbaZwHjW9T7w7yr8nzO0=
X-Gm-Gg: AYBFou1fXuTPp5CQ00ZEIdQXEBP/8lZ3FsDtF9+AuIC58lcrdem2oIPm0PV09A8eDDZ
	FrwEpaEPNmtoAOl8X7gUimSaaRKdp9R1heiaTVH7jueLrc4yqoT3gZ3xKUu9LERjgKom5gZPzre
	xdf3RKq54W6snHYKNI7MpXjpbTlSOstxo1SYJSsQ5YA61dYkcuru0XtdNmMHtYKpqCXTBIE+qgd
	OpTcqfmznYUk1QZNHKJ7KDqpwApZ9ZENXsPi4kxemVVg66TDFOak0PWzXJUbdNOYsfpCxKVht3h
	C0gohIFPA7oYVgSJZmtPJkUyoKEPjd+pHYcD/XcyPl77fIXNlLZv9dx14pKq/2pPKY1CJruaahW
	+jUmTElySV9hNPHZ47PbPw/Srh2bjdhrgevh9nDLctQmBCDR/pUb66BbgEPJpTZdj8aWPoShozJ
	XT2u7xAtmfpZRxFMCjD0oPgNF984ShchO8ga7W8QDx99ENOjzEIJB+iLjfG5x6Sm6M2+Q4rOcLy
	+q1+J99ZH7vO+phla8mYLTfvgCzhb99vLEtCxZAScDC9vPVpP289EV6KJjBd8xNkpQ5nQkm8FEc
	6oJgTpuy8mRmHTF6f3NRV1XHblKK4g==
X-Received: by 2002:a05:7022:b052:10b0:1b1:f02b:2317 with SMTP id a92af1059eb24-1b53a4758b9mr1979699c88.22.1794911669662;
        Tue, 17 Nov 2026 02:34:29 -0800 (PST)
Received: from localhost ([122.172.83.36])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5031b2519sm36212362c88.13.2026.11.17.02.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 02:34:28 -0800 (PST)
Date: Tue, 17 Nov 2026 16:04:26 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Ananthu C V <ananthu.cv@oss.qualcomm.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Jie Zhan <zhanjie9@hisilicon.com>,
	Pierre Gondois <pierre.gondois@arm.com>,
	linux-kernel@vger.kernel.org, driver-core@lists.linux.dev,
	linux-pm@vger.kernel.org,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Oleg Keri <okerixx@gmail.com>
Subject: Re: [PATCH v3 2/2] cpufreq: fix policy max not returning to
 non-boost freq on boost disable
Message-ID: <avwtsmp7Mqacbbtl@vireshk-B250M-D3H>
References: <20260929-schedutil-boost-frequency-handling-v3-0-68de169498c7@oss.qualcomm.com>
 <20260929-schedutil-boost-frequency-handling-v3-2-68de169498c7@oss.qualcomm.com>
 <auhMD2-5FD4BqImG@vireshk-B250M-D3H>
 <avRiWsxCEAuBouBZ@hu-anancv-blr.qualcomm.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <avRiWsxCEAuBouBZ@hu-anancv-blr.qualcomm.com>

On 11-11-26, 18:10, Ananthu C V wrote:
> diff --git a/drivers/cpufreq/freq_table.c b/drivers/cpufreq/freq_table.c
> index ea994647abc8..5b364d8da4f9 100644
> --- a/drivers/cpufreq/freq_table.c
> +++ b/drivers/cpufreq/freq_table.c
> @@ -49,15 +49,16 @@ int cpufreq_frequency_table_cpuinfo(struct cpufreq_policy *policy)
>                         max_freq = freq;
>         }
> 
> -       policy->cpuinfo.min_freq = min_freq;
> +       policy->min = policy->cpuinfo.min_freq = min_freq;
> +       policy->max = max_freq;
>         /*
>          * If the driver has set its own cpuinfo.max_freq above max_freq, leave
>          * it as is.
>          */
>         if (policy->cpuinfo.max_freq < max_freq)
> -               policy->cpuinfo.max_freq = max_freq;
> +               policy->max = policy->cpuinfo.max_freq = max_freq;
> 
> -       if (min_freq == ~0)
> +       if (policy->min == ~0)
>                 return -EINVAL;
>         else
>                 return 0;
> 
> I am pretty sure we can maintain the policy->min status quo and only touch the
> policy->max updation; which from a passing glance simply seems inconsequential.
> Potential side effects, if any, aside, this would at least fix the issue at
> hand, which is the frequency getting stuck on a higher value without being able
> to come down. What do you think about this?

So a change like this also fixes the issue ?

@@ -49,15 +49,16 @@ int cpufreq_frequency_table_cpuinfo(struct cpufreq_policy *policy)
                        max_freq = freq;
        }

        policy->cpuinfo.min_freq = min_freq;
+       policy->max = max_freq;
        /*
         * If the driver has set its own cpuinfo.max_freq above max_freq, leave
         * it as is.
         */
        if (policy->cpuinfo.max_freq < max_freq)
-               policy->cpuinfo.max_freq = max_freq;
+               policy->max = policy->cpuinfo.max_freq = max_freq;

Also, can you please explain the issue again in detail. I am not very
sure how you are reaching to this issue over current mainline (without
the first patch).

-- 
viresh
