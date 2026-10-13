Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79F751EDF6
	for <linux-pm@vger.kernel.org>; Tue, 13 Oct 2026 13:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791898427; cv=none; b=KT+RP2X/Q3fT/NF4yTFeIXk8sYGdQfT0ufM1JSvxIKUcWe/k1oEnHasMVDReADTgs3Yx2Nj0clIpZyJSLo6zmDiQfQ38d1BEdz2M3s/ZE93kw/Z9YQufqFTqhU5G6+ZEpsz3eDT9dASJu6mFqLyjpiuHTEb1kkAoHVZUrVYxpdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791898427; c=relaxed/simple;
	bh=/dI8CdsTM9CLzzZFGh1GnIPjnVLNtLnEzEgAZo4ZLCs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lhW4eH/hp+LKwLbPfXGtCvtbnqg2Ah+RExbyPPtyHlGOGNjpbSZ6sEciyJy2h3+CV+pugIaVNdKqEg4I0Co79GCJL8b2RCrPFuoU+K6J7h6oKKp3HpSSDePFICSYQhZp9AZw4SGn5q2xEJ9l82Hb2ZjBSQeWgJb5qfoB06yZ6tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=K6EW6+RJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kuzDdk3O; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="K6EW6+RJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kuzDdk3O"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69DD490d310419
	for <linux-pm@vger.kernel.org>; Tue, 13 Oct 2026 13:33:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NdjYixV139XIJUfa4dUSS6H2iccr02vLlhDH+5OWJZ8=; b=K6EW6+RJKa1RUFeJ
	WUBGZX7AYADagd9fq6ECvQygkFQYy3jhPbSZgHHhXZ5DTY0oLaJaoGo9Avqaeg1S
	apH84kF3pW13JxVHIY1rrnDoBS97+BvdxHvLEyCQTFyrqJFD4YaO2wxAQ0zvzFnv
	+rMmdgxY6Nm2CmSYtYcPXp1DshsuOe28y9roOF89U62XbWI2ou31r9plU6WGZ+W6
	Yymg3NSCyn91epsseg3rtd/nwy1vlAxCaeHOalzvg8j2TtERfl3rQoRf7f4OHWgU
	EFpoIDyeaIVwpr3JvkREimxa3CWFZ90UV0UUtbHJrSDQDJ1QSW3oD+mKHhkRCK4H
	kOs4mg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9n71g4mt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 13 Oct 2026 13:33:43 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-53513d2a70eso67931361cf.3
        for <linux-pm@vger.kernel.org>; Tue, 13 Oct 2026 06:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791898423; x=1792503223; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NdjYixV139XIJUfa4dUSS6H2iccr02vLlhDH+5OWJZ8=;
        b=kuzDdk3OeBkcuAMoVh2BTUoiyO3gyktcdOmtUKxNXyI0GQJ+99VMEklj/q4hBC3qv6
         56OugUlZqFo2t3ltcznwPnRfXmPeNQgg6hfUH6v8ZL8fhbZmQD2BqW15CmGECQ6tY0AX
         MbUnPWZTzXWWnXMoyKOhhtn4uGiGaWzYnCJ5LjPUu07jt5bX7YCaA/HQyffpe6DqBGD5
         6LzNaI6KnIVfh/xGRkMCNKz4O0aRSJQOcJl9Z0GEcXvGNuq3rMsdNOEcw7RXKTwl7qQm
         /EHyspdnaOZYHzuM7xdyph0B5HqAemtCH/KFQS0Lv4vhXPpU21U/YUO/7nfQzp0L7a2O
         x2SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791898423; x=1792503223;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NdjYixV139XIJUfa4dUSS6H2iccr02vLlhDH+5OWJZ8=;
        b=TpTJbf0p2sTdbkC5QwriKQXiwGPUGYoYk6JlFeMVTfmqxVhOPP3ROlKXezMDyycZ8e
         E41/8GWHbANKiGcdnokBksk1CFvjdcphQcVLqkrOpNsPXmoSVAT+XrKnaAStGXWQb0Jy
         eA09fjaCaVCNGbgFmYydVS/TMjOkVUT4e5GgtVs+Uz0TSdKzYm0pJlRuXuWt7s/t33D+
         s8DWYB7yrHXNqPC9WHEEdYyghs+xNmqeOqVKwgTcaVEPreiao8/uIve8DXVFtU3CAl+4
         ywGl9XhtQ6syCqRMIUG3gsx/U3CEfarai0N3wOqcnlxEuBjnhEql6f9A/B7HEUluG8u8
         gW5A==
X-Forwarded-Encrypted: i=1; AKwUvBzRjpVm11FUubOfXs3vK22isBm9aJhIuPeWkEoALgc6CMaYVRMkSsw2OF0Tq3CAU4Z/XIliw1K1Ig==@vger.kernel.org
X-Gm-Message-State: AFq9FYJDDhsmZjprxccmqkaJl61A9Whw8MeY5c+vwgVSm1ktXiifnn6O
	0PM7mkWzFEgz+1Yynu5HnafGSSJEwX6txdmLuZgmR5AbK26yZV5CiY5tBm1B/cd0K4pLsZBF7sn
	lsYKFFgpJVA/Bt5s0X3B0fa+tanCF3UGEPikSt07/cRXA8O7k+4DE3TEO9m3ecQ==
X-Gm-Gg: AYBFou1oYFZ1SfEGNggd1Fp+MxINMIkHdkc2A7snL4Q3sHv9F23WYzTwer0+6aCvGDR
	RkaXvqMYwzQEkcjELUkNq8ugUt0CEScQpUqQesSoLmxnorMMljKUNzmXY/sqJaiqin3EHAdmt2a
	QzbWT4xm8dpPB15t+dqYI6GkvzjoMtEFNn0lpybOksLWzwH1TLnT/qcYezVTMB+xnFFj1OZEa/i
	TVM9LQRHh7XgbGwmtTq5zg4sBgOhQc13OqDh4vI/FUhPtVY6vL+5Ul+XzZx7qk/5FksMR8WHH3J
	mNgiuwtYkmVrOcDp2ce8fkPlprgqw7W/RM6ddaRTSffaw0hFvxLTY5hSulVQz9p44TBPKVpzip/
	6HpLWuFDKqVEHmxj28sh9WnVtPbBKOot+PxAGHajgD6x9WIBwRWvp+Guo5Cj7eRkfpAc=
X-Received: by 2002:a05:622a:1b87:b0:535:70b3:aa2c with SMTP id d75a77b69052e-5359fe19dc5mr224898371cf.62.1791898422511;
        Tue, 13 Oct 2026 06:33:42 -0700 (PDT)
X-Received: by 2002:a05:622a:1b87:b0:535:70b3:aa2c with SMTP id d75a77b69052e-5359fe19dc5mr224897611cf.62.1791898421755;
        Tue, 13 Oct 2026 06:33:41 -0700 (PDT)
Received: from [10.111.162.196] (Global_NAT1_IAD_FW.qualcomm.com. [129.46.232.65])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ba3d63c70sm6421016d6.43.2026.10.13.06.33.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2026 06:33:40 -0700 (PDT)
Message-ID: <8142519a-0062-4f0f-b978-980e049f99c1@oss.qualcomm.com>
Date: Tue, 13 Oct 2026 15:33:35 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/5] thermal: samsung: Add support for Google GS101 TMU
To: Tudor Ambarus <tudor.ambarus@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Peter Griffin <peter.griffin@linaro.org>,
        =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>
Cc: jyescas@google.com, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
References: <20260603-acpm-tmu-v8-0-0f1810a356e6@linaro.org>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <20260603-acpm-tmu-v8-0-0f1810a356e6@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=FuqQbGrq c=1 sm=1 tr=0 ts=6ace3337 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=Nql5Bu3pbWay0AvSbw8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: ew1O9mld2ebp9cvA30-0y80oDLIYYkbx
X-Proofpoint-ORIG-GUID: ew1O9mld2ebp9cvA30-0y80oDLIYYkbx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA1MyBTYWx0ZWRfX9FYXqDkXNUlr
 4dyT8EgS3QhcC1OfvDPJkE8D01hJlWVqJQquC6HBolcqkEcyuk6x6P5YOjozVPtczMABdACS3TG
 DJqqqwZPhPGyKypwziJTtiqWtI2dD4fXz4w9uPKbWysS+4Ed8eS9j/vzLVd3DkCiVBm34xMV4dK
 ylqC7Xwz/g9tvQdFGirlYaOZNMQZs90Vc9XwYY3UvHYa8Rl2Q37RbI8AqEOF7q0zRrt9ZjiZbjc
 Y79QmW3KmxZfFe3GWqB2O6SMv777EqEuPee5WKWdcsWy7xqvmZmbLjmxdxpbxZm/FlQexrSK3E4
 geCK1jmaZStJ56v8tx/xFbUPPADzvt1HXWSGZHwWL9aJ1yiVI2FJRRxbfnnBatZv+yhgHl53TCe
 KyG3oTEeWlEf2/ZQlq5rssejMmfnQ97KVVx4ifnUuBc/mQYgP+9SCGIIkkZ76WMhwuP6nnaJh0O
 jGbjjpe0yPPNFgsjLzQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA1MyBTYWx0ZWRfXxjfs4ERVJvc5
 5DIZk/A05v0vvsBEZiEmjU0fefB0VWxxTcv6DJEXtj35j4w7/GDeeMum46zCwv+MyGOyc9Xr2MV
 y+I2WTkAHzhdAt/FmLZDKirCaQMU3/E=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130053

Hi Tudor,

I noticed I picked up your series without notifying you

However, I did not pay attention but picked also the dts files.

Shall I drop them ? (AFAICS there is one comment) and let you handle 
them separately ?

Le 03/06/2026 à 15:00, Tudor Ambarus a écrit :
> Add support for the Thermal Management Unit (TMU) on the Google GS101
> SoC.
> 
> The GS101 TMU implementation utilizes a hybrid architecture where
> management is shared between the kernel and the Alive Clock and
> Power Manager (ACPM) firmware. This hybrid ACPM TMU architecture is
> also present on other Samsung Exynos SoCs (e.g., AutoV920, Exynos850).
> 
> Dependencies
> ============
> The set depends on the ACPM TMU firmware helper driver that was queued
> via the Samsung SoC tree:
> https://lore.kernel.org/r/20260531115713.19388-2-krzk@kernel.org/T/#u
> 
> The bindings, driver and MAINTAINERS are expected to go via the thermal
> tree. The dts and defconfig patches are expected to go via the Samsung
> SoC tree, after the bindings and driver are queued.
> 
> Architecture Overview
> =====================
> 
> The hardware supports two parallel control paths. For this
> implementation, responsibilities are split as follows:
> 
> 1. Kernel Responsibility:
> - maintain direct memory-mapped access to the interrupt pending
>    (INTPEND) registers to identify thermal events.
> - map physical hardware interrupts to logical thermal zones.
> - coordinate functional operations through the ACPM IPC protocol.
> 
> 2. Firmware Responsibility (ACPM):
> - handle sensor initialization.
> - manage thermal thresholds configuration.
> - perform temperature acquisition and expose data via IPC.
> 
> Sensor Mapping (One-to-Many)
> ============================
> 
> The SoC contains multiple physical temperature sensors, but the ACPM
> firmware abstracts these into logical groups (Clusters) for reporting:
> 
> - ACPM Sensor 0 (Big Cluster): Aggregates physical sensors 0, 6, 7, 8, 9.
> - ACPM Sensor 1 (Mid Cluster): Aggregates physical sensors 4, 5.
> - ACPM Sensor 2 (Little Cluster): Aggregates physical sensors 1, 2.
> 
> The driver maps physical interrupt bits back to these logical parents.
> When an interrupt fires, the driver checks the bitmask in the INTPEND
> registers and updates the corresponding logical thermal zone.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---
> Changes in v8:
> - reword commit message and Kconfig description (Alexey)
> - adjust Kconfig dependency to require EXYNOS_ACPM_PROTOCOL unconditionally.
> - fix probe error path autosuspend clock leak (Sashiko).
> - fix system sleep clock leak via `pm_runtime_force_suspend` (Sashiko).
> - Link to v7: https://lore.kernel.org/r/20260602-acpm-tmu-v7-0-8047dd54b0e9@linaro.org
> 
> Changes in v7, addressed Sashiko's driver review:
> - add a rollback mechanism in `acpm_tmu_control` to prevent leaving hardware in
>    a dirty state when we fail to enable a sensor midway during probe or
>    resume.
> - prevent calling `ops->read_temp` on a disabled sensor if a concurrent disable
>    occurs (e.g. suspend).
> - don't mix mutex guards with goto as per cleanup guidelines
> - fix irq clear order in `acpm_tmu_thread_fn`. Avoid clearing a new interrupt
>    that occurs during `thermal_zone_device_update` (which can cause missed
>    over-temperature events).
> - initialize hardware thresholds at boot and prevent boot-time spurious
>    interrupts (which previously triggered because sensors were enabled before
>    thresholds were set).
> - ensure clocks are disabled when removing the driver, even if an autosuspend
>    is pending (which would otherwise get cancelled by `pm_runtime_disable()`,
>    leaking the clock).
> - add rollback in `acpm_tmu_suspend` on failure. If system suspend fails at
>    `ops->suspend`, re-enable the TMU sensors so they don't remain disabled.
> - Link to v6: https://lore.kernel.org/r/20260528-acpm-tmu-v6-0-b4d7ce57594b@linaro.org
> 
> Changes in v6:
> - defconfig: reword commit message (Krzysztof).
> - bindings: make samsung,acpm-ipc a required property (Krzysztof,
>    sashiko)
> - address sashiko's review feedback on the driver:
>    - ensure that the loop continues to disable the rest of the sensors
>      on the teardown path in `acpm_tmu_control`.
>    - avoid leaving the hardware in an active state during remove by
>      s/pm_runtime_put_autosuspend(dev)/pm_runtime_put_sync(dev) in
>      `acpm_tmu_control`.
>    - initialize `acpm_temp` in `acpm_tmu_get_temp` to mitigate the risk
>      of exposing stack memory.
>    - fix race condition in `acpm_tmu_update_thresholds`. Guard
>      `was_enabled = sensor->enabled;` with the mutex held.
>    - prevent keeping the sensor disabled on a threshold setting error
>      scenario.
>    - allow the IRQ subsystem to correctly detect an interrupt storm by
>      returning IRQ_NONE.
>    - devres ordering in probe, eliminate a UAF by moving the IRQ request
>      after registering the zones.
> - self review on Kconfig:
>    - add `depends on HAS_IOMEM`, due to `devm_platform_ioremap_resource`
>    - add `default ARCH_EXYNOS`, based on Krzysztof's patch from:
>      Link: https://lore.kernel.org/linux-samsung-soc/b20c560f-4bc3-4686-9c91-36d93f1535b2@oss.qualcomm.com/T/#t
> - Link to v5: https://lore.kernel.org/r/20260525-acpm-tmu-v5-0-85fde739752e@linaro.org
> 
> Changes in v5:
> - no changes, rebase on top of krzk/for-next branch.
> - Link to v4: https://lore.kernel.org/r/20260423-acpm-tmu-v4-0-8b59f8548634@linaro.org
> 
> Changes in v4: address sashiko review:
> - thermal driver: avoid mixing mutex cleanup helpers with goto statements
> - firmware, tmu:
>    - remove __packed from union acpm_tmu_msg.
>    - return ERR_PTR(-ENODEV) for devm_acpm_get_by_phandle when
>      CONFIG_EXYNOS_ACPM_PROTOCOL is disabled.
> - Link to v3: https://lore.kernel.org/r/20260420-acpm-tmu-v3-0-3dc8e93f0b26@linaro.org
> 
> Changes in v3:
> - thermal driver: use .set_trips() instead of .set_trip_point()
> - new cleaning/prerequisite patches for firmware/acpm:
>    - firmware: samsung: acpm: Make acpm_ops const and access via pointer
>    - firmware: samsung: acpm: Drop redundant _ops suffix in acpm_ops members
>    - firmware: samsung: acpm: Consolidate transfer initialization helper
> - firmware: acpm: TMU helpers - check return value from the firmware
> - overall change: emphasize that the ACPM TMU hibrid approach applies to
>    other Samsung SoCs as well (Exynos850, AutoV920).
> - dts: drop active trip points, update trip point values
> - collect R-b tags
> - Link to v2: https://lore.kernel.org/r/20260119-acpm-tmu-v2-0-e02a834f04c6@linaro.org
> 
> Changes in v2:
> - architecture: switch from a syscon/MFD approach to a thermal-sensor
>    node with a phandle to the ACPM interface
> - bindings: address Krzysztof's feedback, drop redundencies,
>    interrupts description.
> - firmware: introduce devm_acpm_get_by_phandle() to standardize IPC
>    handle acquisition.
> - thermal driver: drop compatible's data and use the static data from
>    the driver directly.
> - defconfig, make EXYNOS_ACPM_THERMAL a module
> - Link to v1: https://lore.kernel.org/r/20260114-acpm-tmu-v1-0-cfe56d93e90f@linaro.org
> 
> ---
> Tudor Ambarus (5):
>        dt-bindings: thermal: Add Google GS101 TMU
>        thermal: samsung: Add Exynos ACPM TMU driver GS101
>        MAINTAINERS: Add entry for Samsung Exynos ACPM thermal driver
>        arm64: dts: exynos: gs101: Add thermal management unit
>        arm64: defconfig: enable Exynos ACPM thermal support
> 
>   .../bindings/thermal/google,gs101-tmu-top.yaml     |  69 +++
>   MAINTAINERS                                        |   8 +
>   arch/arm64/boot/dts/exynos/google/gs101-tmu.dtsi   | 136 +++++
>   arch/arm64/boot/dts/exynos/google/gs101.dtsi       |  18 +
>   arch/arm64/configs/defconfig                       |   1 +
>   drivers/thermal/samsung/Kconfig                    |  19 +
>   drivers/thermal/samsung/Makefile                   |   2 +
>   drivers/thermal/samsung/acpm-tmu.c                 | 651 +++++++++++++++++++++
>   8 files changed, 904 insertions(+)
> ---
> base-commit: a1c3227fc1a1cd83cd7fceb93406da4e37fe06eb
> change-id: 20260113-acpm-tmu-27e21f0e2c3b
> 
> Best regards,

