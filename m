Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3753537F9
	for <linux-pm@vger.kernel.org>; Sat, 27 Jun 2026 08:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782549629; cv=none; b=nYIntDdfGmJWBpPhPRCg8PMiswZzpWxdAPSaI4FSmbRk32UGlF5+ZE1h+r1juRyo432Lx7ONrrHAVFuWWB+CqQ9YR3dd5X6tlFTOtG8c+GWlUcTmdfjM0uN68h3kq2pGbNKXTrnz/ai/S0mGGaNyfJRroKS5/VELjiGf77ETH8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782549629; c=relaxed/simple;
	bh=JKhSg9RDF54SURVQ7numfu0xUSoj2Z34FmX9vg7Q64c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mp8x69UPjedo5PlzzXHDopp09jRLqPpJJ15xFU+0oPrDnTR0sqvyITVk2Trti45mFfyGdhMlBSEpvfwpLq93nSV188nqiE9bJdISIPUhLdK72/0AAxOG22ad0CjOPlz4GXUe8VNdu23U2iJf+9Woh7EC/5O8j0NQYlfli9lMMx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OZ/2JttV; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OZ/2JttV"
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-84536ecfc5bso1475253b3a.2
        for <linux-pm@vger.kernel.org>; Sat, 27 Jun 2026 01:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782549627; x=1783154427; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9qbhem3vAH/Z+X5nlRW00s0dAul+UODlOFziWrBe9No=;
        b=OZ/2JttVX0py6BDbt8DMDgsowpnE+WcboN1bgPm3+2RUlNOJq5dzTrjONhZVku4uMI
         7cufPs9ZWZrNaMayySDvjtP9yH9RK8VKCw7kWLXr4zfHIZBatTK/fhh2R/+r2f2Cgc8u
         5GRwQT00TBAgsDxAVKHdBMrKz0QkQ/pM73K/4raBQYOdh2F7m8nCNk1VXH1aRYYyX8nZ
         piSXGAvsHnpJEiJLJAdDrBA36ot6llfgfeuQxT7FbOqB2tzFqoBdpFsd15Vh1AYRLNQP
         KtN/kLNPgc9Ts98N8JA549SJLl1FhYLjfMH55YEqPTZne7v4t9S2xJvOZ8nEYivT2cl5
         17hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782549627; x=1783154427;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9qbhem3vAH/Z+X5nlRW00s0dAul+UODlOFziWrBe9No=;
        b=BL6SW9RPtxM8xuEABowIy3w1mD2xRg66gPBfsylkT4Qhjt6kqsAljCdfFKV6rAe7fq
         i3Znyx+yQiiKtQCebpmuAxqzu2lzhJl0AYy5yGH2fUurOs3ZO38TBfGJuE8meThD4cUr
         vdccTV2HHKVTA62qooV31fD/pTSg8ecN39JG6eZxWaxXqWWTXgBXO0sW8N3jUGMrX9VF
         1eZ8sVUNwPLHAsn75uriQM/VoLTmO9eNyFHIMWKRYpGkVMvjsKdadNmhEnSHnLRSz8Rx
         JhBVmU+PXjLyO5JK3jeaIxsPCDZzBTLQCjDy0+sJjTPu+uBoqUxImJn0YHjKfSThCNmn
         ThsQ==
X-Gm-Message-State: AOJu0YxaJw1374pr/c+QLJ1xDEHwKul5DkB2UVQkCa1TYbNhgMoC/cYr
	FNENUcUqT+eDqzcyLGMA/7A+ql/PY6B0OCFBgP+65Fr6uTvy0ZTye41xn/dhd2jnqKgWTBjkKC0
	=
X-Gm-Gg: AfdE7cm+XNV7QANcz4Hp1PBmEq2WYRfzJqaLC3aCyggQS3UCa1SrnMvSXrJ8+mQ3iiX
	4DXBH1VBvygL9yPLiBcZM0IDiqMYMvPKAeOVHPq8JIEXoyEYicDDioV+u5X+y3MftNcWOAP2KeB
	gUkrJ+fgeHLe/oZvQOvsk6UpsNw3UsF28iqG0SQth3+p3Z7ea5MJRhdSwhdYQuoc+ZDJct86HjL
	RL0poQiV/1j/ptNXv+eTlDfX9U0wYRaU5iD+je7lZo8NgB1GdpGuTTGv1GtSgKJKB7DCCqKNFb3
	/O0xT6HTXq/aGB2CJPUoLFiFk2mnMbKjGOWNpY1QY71j3BHqQ44ewsnotMrb6x68/m+AYk6VR76
	+4BV2kF8qCGynZeUYMpZxY1S3O86fOoQLTS8tWKSxHnlM1FiFMXDjHYuScrXKlkUlmRzjdX7T1f
	gO5gn4FwLlVxUMncd8L6nHPYR4sYqYZZ4=
X-Received: by 2002:a05:6a00:1816:b0:842:57e8:1bdb with SMTP id d2e1a72fcca58-845b3a52c01mr10776106b3a.20.1782549626710;
        Sat, 27 Jun 2026 01:40:26 -0700 (PDT)
Received: from [192.168.50.100] ([106.38.154.67])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-845a3fedaefsm8928591b3a.23.2026.06.27.01.40.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Jun 2026 01:40:26 -0700 (PDT)
Message-ID: <10f2a6af-86d8-4f98-86b0-0f1de394f19c@gmail.com>
Date: Sat, 27 Jun 2026 16:40:21 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/2] cpufreq: spacemit: Add cpufreq support for K1 SoC
To: Shuwei Wu <shuwei.wu@mailbox.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Yixun Lan <dlan@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
 devicetree@vger.kernel.org
References: <20260626-shadow-deps-v4-0-bba9831f2f1d@mailbox.org>
From: Gong Shuai <gsh517025@gmail.com>
In-Reply-To: <20260626-shadow-deps-v4-0-bba9831f2f1d@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/26/2026 4:10 PM, Shuwei Wu wrote:
> This series enables CPU DVFS for the SpacemiT K1 SoC using the generic
> cpufreq-dt driver.
> 
> K1 has two CPU clock clusters. The two clusters have separate CPU clocks,
> so they are represented as two cpufreq policies: policy0 for CPUs 0-3 and
> policy4 for CPUs 4-7.
> 
> The CPU voltage rail is shared between the clusters. To model this with two
> policies, the OPP entries describe voltage ranges instead of a single fixed
> voltage, so the shared regulator can keep the rail within a range acceptable
> for the active OPP constraints.
> 
> Tested on Banana Pi BPI-F3:
> 
> ~ # cat /sys/devices/system/cpu/online
> 0-7
> 
> ~ # ls /sys/devices/system/cpu/cpufreq/
> policy0  policy4
> 
> ~ # cat /sys/devices/system/cpu/cpufreq/policy0/scaling_driver
> cpufreq-dt
> ~ # cat /sys/devices/system/cpu/cpufreq/policy0/affected_cpus
> 0 1 2 3
> 
> ~ # cat /sys/devices/system/cpu/cpufreq/policy4/scaling_driver
> cpufreq-dt
> ~ # cat /sys/devices/system/cpu/cpufreq/policy4/affected_cpus
> 4 5 6 7
> 
> Both policies expose the same OPP frequencies:
> 
> ~ # cat /sys/devices/system/cpu/cpufreq/policy0/scaling_available_frequencies
> 614400 819000 1000000 1228800 1600000
> 
> ~ # cat /sys/devices/system/cpu/cpufreq/policy4/scaling_available_frequencies
> 614400 819000 1000000 1228800 1600000
> 
> For each policy, scaling_setspeed was set to each supported OPP and the
> workload was pinned to one CPU covered by that policy with taskset.
> CPU0 was used for policy0, and CPU4 was used for policy4. The clock rates below
> are from /sys/kernel/debug/clk/clk_summary.
> 
> policy0 / CPU0:
> ----------------------------------------------------------
> Frequency    |  cpu_c0_core_clk  |  Real (s)  |  User (s)
> (kHz)        |  (Hz)             |            |
> -------------+-------------------+------------+-----------
> 1,600,000    |  1,600,000,000    |    1.81    |    1.80
> 1,228,800    |  1,228,800,000    |    2.37    |    2.37
> 1,000,000    |  1,000,000,000    |    2.89    |    2.89
>    819,000    |    819,200,000    |    3.56    |    3.55
>    614,400    |    614,400,000    |    4.71    |    4.71
> ----------------------------------------------------------
> 
> policy4 / CPU4:
> ----------------------------------------------------------
> Frequency    |  cpu_c1_core_clk  |  Real (s)  |  User (s)
> (kHz)        |  (Hz)             |            |
> -------------+-------------------+------------+-----------
> 1,600,000    |  1,600,000,000    |    1.81    |    1.80
> 1,228,800    |  1,228,800,000    |    2.36    |    2.36
> 1,000,000    |  1,000,000,000    |    2.89    |    2.89
>    819,000    |    819,200,000    |    3.55    |    3.55
>    614,400    |    614,400,000    |    4.71    |    4.70
> ----------------------------------------------------------
> 
> Signed-off-by: Shuwei Wu <shuwei.wu@mailbox.org>

Hi Shuwei,

Thanks for your work.

I have tested this series on the OrangePi RV2 4GB board on top of
next-20260626, with Vincent's patch for OrangePi RV2 applied.

# uname -a
Linux orangepi-rv2 7.1.0-next-20260626-00005-g66ef697be46d #1 SMP PREEMPT Sat Jun 27 14:53:02 CST 2026 riscv64 GNU/Linux

# ls /sys/devices/system/cpu/cpufreq/
boost    policy0  policy4

# cat /sys/devices/system/cpu/cpufreq/policy*/scaling_driver
cpufreq-dt
cpufreq-dt

# cat /sys/devices/system/cpu/cpufreq/policy0/affected_cpus
0 1 2 3

# cat /sys/devices/system/cpu/cpufreq/policy4/affected_cpus
4 5 6 7

# cat /sys/devices/system/cpu/cpufreq/policy*/scaling_available_frequencies
614400 819000 1000000 1228800 1600000
614400 819000 1000000 1228800 1600000

I used the following test script to verify cpufreq functionality:

```bash
#!/bin/sh

echo userspace > /sys/devices/system/cpu/cpufreq/policy0/scaling_governor
echo userspace > /sys/devices/system/cpu/cpufreq/policy4/scaling_governor

echo "--- same frequency test ---"
for freq in 614400 819000 1000000 1228800 1600000; do
     echo $freq > /sys/devices/system/cpu/cpufreq/policy0/scaling_setspeed
     echo $freq > /sys/devices/system/cpu/cpufreq/policy4/scaling_setspeed
     sleep 1
     t=$(taskset -c 0 time -f "%e" dd if=/dev/zero of=/dev/null bs=1M count=1000 2>&1 | tail -1)
     echo "$freq kHz: ${t}s"
done

echo "--- mixed frequency test ---"
echo 614400 > /sys/devices/system/cpu/cpufreq/policy0/scaling_setspeed
echo 1600000 > /sys/devices/system/cpu/cpufreq/policy4/scaling_setspeed
sleep 1
t0=$(taskset -c 0 time -f "%e" dd if=/dev/zero of=/dev/null bs=1M count=1000 2>&1 | tail -1)
t4=$(taskset -c 4 time -f "%e" dd if=/dev/zero of=/dev/null bs=1M count=1000 2>&1 | tail -1)
echo "p0=614400 p4=1600000 -> cpu0=${t0}s cpu4=${t4}s"

echo 1600000 > /sys/devices/system/cpu/cpufreq/policy0/scaling_setspeed
echo 614400 > /sys/devices/system/cpu/cpufreq/policy4/scaling_setspeed
sleep 1
t0=$(taskset -c 0 time -f "%e" dd if=/dev/zero of=/dev/null bs=1M count=1000 2>&1 | tail -1)
t4=$(taskset -c 4 time -f "%e" dd if=/dev/zero of=/dev/null bs=1M count=1000 2>&1 | tail -1)
echo "p0=1600000 p4=614400 -> cpu0=${t0}s cpu4=${t4}s"

echo 1000000 > /sys/devices/system/cpu/cpufreq/policy0/scaling_setspeed
echo 1228800 > /sys/devices/system/cpu/cpufreq/policy4/scaling_setspeed
sleep 1
t0=$(taskset -c 0 time -f "%e" dd if=/dev/zero of=/dev/null bs=1M count=1000 2>&1 | tail -1)
t4=$(taskset -c 4 time -f "%e" dd if=/dev/zero of=/dev/null bs=1M count=1000 2>&1 | tail -1)
echo "p0=1000000 p4=1228800 -> cpu0=${t0}s cpu4=${t4}s"
```

Results:

# ./test_cpufreq_userspace.sh
--- same frequency test ---
614400 kHz: 0.90s
819000 kHz: 0.67s
1000000 kHz: 0.55s
1228800 kHz: 0.45s
1600000 kHz: 0.34s
--- mixed frequency test ---
p0=614400 p4=1600000 -> cpu0=0.90s cpu4=0.34s
p0=1600000 p4=614400 -> cpu0=0.34s cpu4=0.90s
p0=1000000 p4=1228800 -> cpu0=0.55s cpu4=0.45s


Tested-by: Gong Shuai <gsh517025@gmail.com> # OrangePi-RV2

Regards,
Shuai


> ---
> Changes in v4:
> - Represent K1 as two cpufreq-dt policies, one per CPU clock cluster
> - Use OPP voltage ranges for the shared CPU supply
> - Link to v3: https://lore.kernel.org/r/20260612-shadow-deps-v3-0-2f3ba88611ff@mailbox.org
> 
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
>        cpufreq: dt-platdev: Add SpacemiT K1 SoC to the allowlist
>        riscv: dts: spacemit: Add cpu scaling for K1 SoC
> 
>   arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts |  35 +++++++-
>   arch/riscv/boot/dts/spacemit/k1-opp.dtsi        | 105 ++++++++++++++++++++++++
>   arch/riscv/boot/dts/spacemit/k1.dtsi            |   8 ++
>   drivers/cpufreq/cpufreq-dt-platdev.c            |   2 +
>   4 files changed, 149 insertions(+), 1 deletion(-)
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

