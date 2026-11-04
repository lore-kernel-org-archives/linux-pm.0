Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793784938;
	b=VWMYUjaaH6AggakziPM7tF0X2bPmZsrNTvhzYmA3S24W9//OKDISdx4SsPe3kNKDA/Yd
	 Z/PHL/6bdejc1d+b8fNEjLglD/wL331T8l9PPXpdIURxxc2IqdVsQICEEG4dAC98V1UUy
	 QPrqpMMF9plnvrtxovkz6kmW/TfVlEqlXWpJegaIHxHaTtGGZHTjF2L0RYH+Oi0rvNoET
	 Cwql+D27US+qN50zZuaOrrgqHL0/BTO7l0jobUGq5t8lEKPnGI5Xqld7El379YuPSbYMP
	 l9n6bbVhEO8ARvfVrYqqRvmpcJnDek2H9I6KNe46iZfHoEFLt5HlXefU6Z1nIDTMsWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793784938;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=o10ez3oKAyY7/DQg9ITlG7hQMuT0WwV1t5DaJPX3Q/s=;
	b=B45pZ+jon2ozgORxCdamXkpPhwjLeWOy4FNJ2RKuBnEXP5UD26x7JzWZcDAUF9mRoci6
	 rdLMJJpq/4BpCKvcTuuzXdBi7weLP4wXP5GQytESXSqdUIUvaiIIR0E9wYe0lUmQhNRLs
	 j5GWEYdplrL34XD4TBNa6pQtKCdpf8qumMxWmjgWJ5wsrY3WGW8p31yqfFkSjda+20yH+
	 7lL10EG/XTB0nDNBSkwDtrMGykrFvesGiYx2Rgx3y7jsTytcT59v9fDj8jNuWvjoygXas
	 A1iR1FpQU9My/Tou3kMBS3LMgImbJkxCDoYf+EgJbFwSTcgpI0mQj9jFq9vObY6Db6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FAZAHuCz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70619606A328
	for <linux-pm@vger.kernel.org>; Wed,  4 Nov 2026 09:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FAZAHuCz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 147F21F00A15
	for <linux-pm@vger.kernel.org>; Wed,  4 Nov 2026 09:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793784937;
	bh=o10ez3oKAyY7/DQg9ITlG7hQMuT0WwV1t5DaJPX3Q/s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=FAZAHuCzmhgkfOw7vmJQYav2xKAHNlQsli+mf7WieR+rL7SxqE0Ty2IGm5t19a++W
	 zHWfi3g4tw0y4BwawaQysuJZc/1QCzJ4UiiObUMZKAEhtMp4GxPClFh3QTi9Ib3QUn
	 khdpAXgQ1GY42xPG5fBueK4q8jf1dI0zXQBhBIZ/MDNh0XmKsb5uFL+d+o8ncqFpKY
	 TgPma+TsNtMV6Ae6oDjzwg3zVN9KmZcy4gkzXQc/iEcL/4AszDDdfq+VOUp5rM/wwO
	 wolih07qG+Pahg0Ab7f2efonl/qO+Z6MEPdeS8dEdP2s/rKZ9wRnE2TnKVYNVCaDxy
	 tIkZzkvkL25KA==
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6a642495d81so655737a12.2
        for <linux-pm@vger.kernel.org>; Wed, 04 Nov 2026 01:35:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBxIzoT34hqEPZ0fPOCT668b+8oTEmaGJX5iSTvsMLz7RcHaQjdVSI+wdm0G7SpjUl2EgjWKI+0MrA==@vger.kernel.org
X-Gm-Message-State: APuU4Z/ddKiXujVPderUdFSuSWbUAJV9+MZ2lgdxHmaPFPa20h9BG2L4
	ELcae9YZo/JznNuR4VI0r9fGdU1oRuMOym9C7dO39FxN8AP8h/p1rEQpIS++B6hb68q/jYs/jT/
	WR9jCwIHYDUmDbgJatGUrE0BczFUjvJ0=
X-Received: by 2002:a05:6402:543:b0:6aa:f809:ef44 with SMTP id
 4fb4d7f45d1cf-6b4d497f272mr8302572a12.19.1793784935620; Wed, 04 Nov 2026
 01:35:35 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1793690276.git.zhoubinbin@loongson.cn>
In-Reply-To: <cover.1793690276.git.zhoubinbin@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 4 Nov 2026 17:35:23 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4R1eJ08PFzFDPK9VZZKwdzTcC+ttF=eVCKP9k6TT5MeA@mail.gmail.com>
X-Gm-Features: AclHuK8wStkOlY_ZaRD_iGQLa7IK6kHakkz--62p0mmX43ie-RVsYBXeaxCxYr4
Message-ID: <CAAhV-H4R1eJ08PFzFDPK9VZZKwdzTcC+ttF=eVCKP9k6TT5MeA@mail.gmail.com>
Subject: Re: [PATCH v8 0/7] thermal/drivers/loongson2: Fix trip programming
 and add Loongson-2K0300 support
To: Binbin Zhou <zhoubinbin@loongson.cn>
Cc: Binbin Zhou <zhoubb.aaron@gmail.com>, Huacai Chen <chenhuacai@loongson.cn>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Yinbo Zhu <zhuyinbo@loongson.cn>, zhanghongchen <zhanghongchen@loongson.cn>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev, devicetree@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

For the whole series:

Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>

On Tue, Nov 3, 2026 at 3:24=E2=80=AFPM Binbin Zhou <zhoubinbin@loongson.cn>=
 wrote:
>
> Hi all:
>
> This series fixes trip-point handling in the Loongson-2 thermal driver,
> refactors the driver around per-SoC chip data, and adds support for the
> Loongson-2K0300 thermal sensor.
>
> The first three patches are fixes and are marked for stable:
>
> - Patch 1 fixes signed division when converting negative milli-degree
>   trip points to degrees Celsius.
> - Patch 2 fixes the arguments to clamp() so trip points are limited to
>   the supported sensor range.
> - Patch 3 fixes Loongson-2K2000 trip-point programming by adding a
>   per-SoC register callback and handling the split HI_GATE register.
>
> Patches 4-5 are cleanups and preparation work:
>
> - Patch 4 removes the unnecessary multi-sensor registration loop.
> - Patch 5 moves the per-SoC ops and hardware initialization into chip
>   data.
>
> Patch 6 adds the Loongson-2K0300 DT binding, and patch 7 adds driver
> support for the Loongson-2K0300 thermal sensor.
>
> The patchset have been validated on the Loongson-2K series development
> boards.
>
> Thanks.
> Binbin
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D
> V8:
> Patch (1/7):
>  - Use MILLIDEGREE_PER_DEGREE macro instead of explicitly casting MILLI;
>
> - Split patch-4 into two parts: the bitfields section will be merged into
>   patch-3, and the remaining changes will be merged into patch-6 as
>   preparation for introducing the new SoC.
>
> Link to V7:
> https://lore.kernel.org/all/cover.1791512067.git.zhoubinbin@loongson.cn/
>
> V7:
> Patch (1/8):
>  - New patch;
>  - Fix negative temperature conversion in set_trips;
> Patch (3/8):
>  - Use writew()/writeb() in loongson2_2k2000_set_trips_regs;
> Patch (4/8):
>  - Rewite the thermal sensor registration loop to clearer;
> Patch (5/8):
>  - Fix `loognson2_thermal_set_trips` typo;
> Patch (8/8):
>  - Read CHIP_ID1 only when EXTERN_ID is set;
>  - Simplify the Internal ID calculation;
>  - Add the necessary comments.
>
> Link to V6:
> https://lore.kernel.org/all/cover.1790561983.git.zhoubinbin@loongson.cn/
>
> V6:
>  - Rebase on linux-pm/thermal;
> Patch (2/7):
>  - New patch;
>  - Fix incorrect clamp() argument order for thermal trip points;
> Patch (3/7):
>  - New patch;
>  - Fix Loongson-2K2000 trip point programming by adding a per-SoC
>    set_trips_regs callback and handling the split HI_GATE registers;
> Patch (4/7):
>  - New patch;
>  - cleanup: use GENMASK/FIELD_* helpers, add named constants, and factor
>    common trip point setup;
> Patch (5/7):
>  - New patch;
>  - refactor: move thermal_zone_device_ops into chip_data and replace the
>    Loongson-2K2000 flag special case with an optional init_extend_resourc=
e
>    callback;
> Patch (7/7):
>  - Updated the 10-bit output to 11-bit in commit message;
>  - Temporarily remove the implementation of `set_trips`;
>  - Remove unnecessary header files;
>  - Rewrite `get_temp`, separating `read_calib` and `detect_old_fuse` into
>    new functions to be called during the probe;
>  - Use macros to define the relevant numbers.
>
> Link to V5:
> https://lore.kernel.org/all/cover.1789546118.git.zhoubinbin@loongson.cn/#=
t
>
> V5:
>  - Rebase on linux-pm/thermal;
>  - Drop patch-3 for it was applied.
>
> Link to V4:
> https://lore.kernel.org/all/cover.1785829933.git.zhoubinbin@loongson.cn/
>
> V4:
>  - Rebase on linux-mfd/for-mfd-next;
> Patch (3/5):
>  - Remove the operation that adds `compatible` to the `select` node.
>
> Link to V3:
> https://lore.kernel.org/all/cover.1785480242.git.zhoubinbin@loongson.cn/
>
> V3:
> Patch (2/5):
>  - New patch for moving thermal_ops to chip_data;
> Patch (3/5):
>  - Correct spelling errors;
> Patch (4/5):
>  - Add Acked-by from Conor, thanks;
> Patch (5/5):
>  - Keep loongson2_thermal_data->chip_data as const, and use
>    data->flags as the private data.
>  - Renmae LOONGSON2_THSENS_OUT_10B_MASK ->
>    LOONGSON2_THSENS_OUT_11B_MASK;
>
> Link to V2:
> https://lore.kernel.org/all/cover.1784619512.git.zhoubinbin@loongson.cn/
>
> V2:
> Patch (1/4):
>  - New patch form Sashiko;
> Patch (2/4):
>  - New patch for adding chipid syscon compatible;
> Patch (3/4):
>  - Use `loongson,chipid` phandle replace reg property;
> Patch (3/4):
>  - Refact `calib_offset` calculate routing;
>  - Add LS2K0300_OLD_FUSE_FLAG flag.
>
> Link to V1:
> https://lore.kernel.org/all/cover.1783670011.git.zhoubinbin@loongson.cn/
>
> Binbin Zhou (7):
>   thermal/drivers/loongson2: Fix negative trip conversion in set_trips
>   thermal/drivers/loongson2: Fix clamp() usage for thermal trip points
>   thermal/drivers/loongson2: Fix Loongson-2K2000 trip point programming
>   thermal/drivers/loongson2: Simplify thermal sensor registration
>   thermal/drivers/loongson2: Move per-SoC ops and init into chip data
>   dt-bindings: thermal: loongson,ls2k-thermal: Add compatible for
>     Loongson-2K0300
>   thermal/drivers/loongson2: Add Loongson-2K0300 support
>
>  .../thermal/loongson,ls2k-thermal.yaml        |  73 +++-
>  drivers/thermal/loongson2_thermal.c           | 359 ++++++++++++++----
>  2 files changed, 332 insertions(+), 100 deletions(-)
>
>
> base-commit: 4358090906b01806ee483229e8d7163b806bd116
> --
> 2.52.0
>
>
