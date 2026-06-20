Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com [209.85.215.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4759C3242AC
	for <linux-pm@vger.kernel.org>; Sat, 20 Jun 2026 14:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781965437; cv=none; b=s537rs3MEIYlkXIt863g9q7/E7UyNUAwBxjDZf+OYnEhGvgrVhkND3GEUJBqGtK25XuoqyY0Iy0XSU4ha98VJ6zGCtUwXirTYe67Dq3pn38JnHhzgXPCuMVaYAYKOad50Xsqv+k7VtKaecKs7aIAn85fP/AZtYaA6nw6fs7h1QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781965437; c=relaxed/simple;
	bh=1A3yRBCyiXnf2+7dCdstiNNFsshcbr96SxsOGFDoLtY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=guYcq/cfNe/0cpi1JLOlNeA9fbEWWISm8fE25mBxWtLcxQmfKAMowaiVwxCI+NEw7nNi06WUG2BFG1T7KBx4XxVzJCgESWGHzn1lxLiD86Pj3r4J4O20i1rAq4jIBKEy4Tf9we8iWLld78g6iQiO5cqJfp2tesAMM4rLsDdAoEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JX+0N1Fn; arc=none smtp.client-ip=209.85.215.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JX+0N1Fn"
Received: by mail-pg1-f196.google.com with SMTP id 41be03b00d2f7-c88e3e82d81so1378053a12.2
        for <linux-pm@vger.kernel.org>; Sat, 20 Jun 2026 07:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781965434; x=1782570234; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X2ppqhiXhC3WFA2wZf37Gep+L6TyBObHMBsyL7sziZw=;
        b=JX+0N1FnhFQWBSzU2Yqy1Zxw8YcBFw6h/BRT2zeyCxx8DRyZxrdXUmwhb395gCxhqU
         TJvvwhd+xBtA+vtf5IvqeR+uDnYWgUyeAy9QvflfV1uou6NUmV68hNkOZAPGk9F5i9v7
         3WruKdJP5thLrp5AVku6m1GZsNsurdjIM6cMXpqiBl1cmTLNoBrlgyfrPLEbAng4vm/U
         2tuJRquF6wY1b0OzNCd+N7BucQNLtaLNjwHbFvxAYWkw0FrJnPe6BoZZ9PBd2EVy+6+f
         0nqT851W2Aao2jcKDCnbNaD1+UGdHtdZbOFolnFmphcYIlK9cO9ES1m3Ghxps1bOxLI6
         ULBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781965434; x=1782570234;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X2ppqhiXhC3WFA2wZf37Gep+L6TyBObHMBsyL7sziZw=;
        b=YVtuJ8egVfc2thjGdF3SOVjs1NqFhwjS7NYbVrfAculu7/CkIlTI5enxnpKM5YD1Sd
         x5OAPHrNBaIgmQA7Pww/UqTPht2he5QhV6qUff6kmt/nFkqmucdNujjjyLBqFC50CDxS
         NHXh1BtKtVVpaPtpetUY7OJIdq+B4Ycnb/bOM1uF85B3PjcjALAPMrzPJtKqCfMzVIFw
         JmVRaGYZDXytE07RJxuuMqDTkG3RDAKIfT2PZOAG6ULnqomJR+GbtdJMx96o+pr0gjEI
         4pJqLEHF/zhyWDLBGk1xbiQxFGWLGqb5RqPtrfx2iLF9honzun2K65OcQcX1VPiDp06n
         hh3Q==
X-Gm-Message-State: AOJu0Yyjr32GRcMPOhhTqnSnbF5ZdRY+gCatCazu9Weljg3XLf/7WZl/
	MsLY+xwuXq/QudQvEc3Q+vg2nrgLOoH8jjbv9t7ifO3O6tSF9728drmi
X-Gm-Gg: AfdE7cnT1eu88C05ZOS+tSCyHApB3lc0tDD8fdQpjmZPdIzIabo9ovAwEum/5o+GvQS
	ShNzC2GcxEQqY4S6bgDdgatL5jMdewohDc/ZaeELgOrv2Ha4USo1DhdOb5SHmQUoM29vJuOUcHz
	vKXHFHJAXxMLcxgHYvhiTEqNysOJAxOA/iFrJnyr5bp4KCX4UBCJ9UxbpUq1B5Q+ZfLeDrqNgfS
	MfyGaamCzJa5RDH6Z6X6Ev4mYxObMsZnW0gv8Z5jqJ5OwqLzC9KFgmq2m5JuQyu+DwnycCDhJum
	OeiozoN4lIpeG5WK7g+wWKZ9xf70gQa1UhY9uAjT4NZaQmGFaPGOfRfr+kjrPitZYcDg+HmL3fD
	vMa71cp7BNnD1N7QdBGcptdDOrSNvnF/39x6Yp+5BwtSH9Ww3LmC+dkKQLxeK5/LrVOATp/z6YN
	npp6+fj4dTpYnPYnwqOUYyDdWItkC3b/brouqCwiWc1qJJavd0Bal926Ra+Pvqvj5s
X-Received: by 2002:a05:6a20:6a0f:b0:3b4:7c33:296b with SMTP id adf61e73a8af0-3bb3564431fmr7384251637.32.1781965433512;
        Sat, 20 Jun 2026 07:23:53 -0700 (PDT)
Received: from ?IPV6:240e:304:27f3:cf00:402d:ef5b:4082:aa65? ([240e:304:27f3:cf00:402d:ef5b:4082:aa65])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8bc563c406sm2556778a12.19.2026.06.20.07.23.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Jun 2026 07:23:52 -0700 (PDT)
Message-ID: <bae98712-2d0c-4831-8142-bb1318d147b1@gmail.com>
Date: Sat, 20 Jun 2026 22:23:44 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] cpufreq: spacemit: Add cpufreq support for K1 SoC
To: Shuwei Wu <shuwei.wu@mailbox.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Yixun Lan <dlan@kernel.org>,
 Vincent Legoll <legoll@online.fr>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
 devicetree@vger.kernel.org
References: <20260612-shadow-deps-v3-0-2f3ba88611ff@mailbox.org>
From: Gong Shuai <gsh517025@gmail.com>
In-Reply-To: <20260612-shadow-deps-v3-0-2f3ba88611ff@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/12/2026 5:51 PM, Shuwei Wu wrote:
> This series enables CPU frequency scaling for the SpacemiT K1 SoC.
> 
> K1 has two CPU cluster clocks but one shared CPU voltage rail. Add a
> small K1-specific cpufreq driver so the two clocks and the shared OPP
> transition can be handled together.
> 
> Tested on Banana Pi BPI-F3. The system boots with all eight CPUs online,
> the K1 cpufreq driver registers one policy for CPUs 0-7, and both CPU
> cluster clocks follow the selected cpufreq rate.
> 
> ~ # cat /sys/devices/system/cpu/online
> 0-7
> 
> ~ # ls /sys/devices/system/cpu/cpufreq
> policy0
> 
> ~ # cat /sys/devices/system/cpu/cpufreq/policy0/affected_cpus
> 0 1 2 3 4 5 6 7
> 
> ~ # cat /sys/devices/system/cpu/cpufreq/policy0/scaling_available_frequencies
> 614400 819000 1000000 1228800 1600000
> 
> With the userspace governor:
> ----------------------------------------------------------------------------
> Frequency    | scaling_cur | cpu_c0_core | cpu_c1_core | Real    | User
> (kHz)        | (kHz)       | (Hz)        | (Hz)        | (s)     | (s)
> -------------+-------------+-------------+-------------+---------+----------
> 1,600,000    | 1,600,000   | 1600000000  | 1600000000  | 1.80s   | 1.80s
> 1,228,800    | 1,228,800   | 1228800000  | 1228800000  | 2.33s   | 2.33s
> 1,000,000    | 1,000,000   | 1000000000  | 1000000000  | 2.88s   | 2.87s
>    819,000    |   819,000   |  819200000  |  819200000  | 3.53s   | 3.52s
>    614,400    |   614,400   |  614400000  |  614400000  | 4.72s   | 4.72s
> ----------------------------------------------------------------------------
> 
> Signed-off-by: Shuwei Wu <shuwei.wu@mailbox.org>
> ---
> Changes in v3:
> - Add a K1-specific cpufreq driver for the shared-rail, dual-clock topology
> - Use one shared CPU OPP table and one cpufreq policy for all CPUs
> - Link to v2: https://lore.kernel.org/r/20260410-shadow-deps-v2-0-4e16b8c0f60e@mailbox.org
> 
> Changes in v2:
> - Move OPP tables to dedicated k1-opp.dtsi
> - Enable OPP only on BPI-F3 with cpu-supply present
> - Link to v1: https://lore.kernel.org/r/20260308-shadow-deps-v1-0-0ceb5c7c07eb@mailbox.org
> 
> ---
> Shuwei Wu (2):
>        cpufreq: spacemit: Add K1 cpufreq driver
>        riscv: dts: spacemit: Add cpu scaling for K1 SoC
> 
>   arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts |  35 +++-
>   arch/riscv/boot/dts/spacemit/k1-opp.dtsi        |  70 +++++++
>   arch/riscv/boot/dts/spacemit/k1.dtsi            |   8 +
>   drivers/cpufreq/Kconfig                         |   4 +
>   drivers/cpufreq/Kconfig.riscv                   |  15 ++
>   drivers/cpufreq/Makefile                        |   3 +
>   drivers/cpufreq/cpufreq-dt-platdev.c            |   2 +
>   drivers/cpufreq/spacemit-k1-cpufreq.c           | 251 ++++++++++++++++++++++++
>   8 files changed, 387 insertions(+), 1 deletion(-)
> ---
> base-commit: 5164e95565d3fd508ca8a95351323f5716dfb695
> change-id: 20260307-shadow-deps-3582a78aa756
> prerequisite-patch-id: 154bd4f720ce5065d58b988de8f273207b44572e
> prerequisite-message-id: <20260206-spacemit-p1-v4-0-8f695d93811e@riscstar.com>
> prerequisite-patch-id: 5da3e75b18291a5540d4f66d7a0600fb8975ef62
> prerequisite-patch-id: bcf41917414ecef8cf743095d130f6004c32f6a5
> prerequisite-patch-id: cfe3800f8c791ec4c63e070af9628e88e0fc31b9
> prerequisite-message-id: <20260305-k1-clk-fix-v1-1-abca85d6e266@mailbox.org>
> prerequisite-patch-id: 7c7fb9f87dba019ece4c97c45750349a7cd28f3a
> 
> Best regards,


Hi Shuwei and Vincent,

I have tested this series on the OrangePi RV2 board (4GB) on top of
linux-next (next-20260619), with the v3 cpufreq series and Vincent's
patch "k1-orangepi-rv2: Add cpu scaling" applied.

The driver works as expected: all 8 CPUs are online and share a single
policy (policy0). Writing to
/sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
correctly changes the frequency for all cores simultaneously, and all
scaling_setspeed files show the same value. The frequency transitions
are smooth, and performance (tested with a simple awk loop, following
Vincent's approach) scales linearly with the set frequency.

Both of you can add my tag:

Tested-by: Gong Shuai <gsh517025@gmail.com> # OrangePi-RV2

If you send a new version, I'm also willing to test it again.

Thanks for the work.

Regards,
Shuai


