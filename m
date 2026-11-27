Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795787429;
	b=Whwc6wppfWc8mZrMA4WZGnf/kcsZdVIoNp6W9qvNdaiDUObf79SSufGe9lWfgxpiKHDU
	 TacLE680DJ6Ws8LbDn2AHRCI6w55w3RgG2yB6Iv4Vkb5QbH8aBX7UH0AfYG2cOggsZCmX
	 LuSFGcYy5pq2tUIq6KYEfK0OzYcWks8xXE4Wp5EXAcGE9Yvh9FqBN5m6LeiL1D+NY+zyc
	 weu2Fvoktr4KCPotQgTJc5AP0ggiN2MtT1dSxPndu8wWIwzWNp4aa1uqamlhz7NG4ALwk
	 THi9XV99R6eIS5GXSt4dtaf4X2vysM6KjU43yKlQRA8WvABD88j7v8r3jKCeSvYXnog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795787429;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=pyDU52siD0mYcxwcywwQwT9LgOYvGR8lMbhhFRpCuKg=;
	b=SI97bnBGZrPHuTsAkIG2g4yploorPBzU6lx5oMJQ6GNAheWvdrkl87ipSeIVhQfjs/mr
	 R+QnejlDZzoyrp2JQWEZvrj4XJ9evgCCMkxYu4p7/PgUmfUCsZUIjwTKdXz9RZ6SOFrFm
	 3JIBrkrxHJiQQpgojh+bbmGC3CsVwbQqwFSuzQ7862/vUdUyGY4HVonjZYqTmbG1LbBrl
	 kFrb82Vdi8JB5QnWS/4tBPVJshc05wAUm1ytW095jUYx40b80ilohpJRX4qKciUM0RJ0K
	 Ax8Hbv1vw/ZcfyFlJ88nzqKav2RSsVPADRk4wZh9s1L2GKoifxCeQfq2WbjWghHyh5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LOvoYt7P;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411D1606A31F
	for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 13:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LOvoYt7P
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA9BE1F00923
	for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 13:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795787428;
	bh=pyDU52siD0mYcxwcywwQwT9LgOYvGR8lMbhhFRpCuKg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=LOvoYt7P4W3i72sXVxCoEs/gt8wPpomI9qsWGdMKGyyI52RlNtd9P/7sQr/v0Axte
	 RWoN5Q0JiqSunp48KDQNwGX8yYdv60JK5uIIPzdzgu2ZpkcTvBpk6eMx98oXveJ1jo
	 FsP93LTJdEXx/nUxjAWFepuWyJiP0jYiT40V5G/4xgbPdjd5Zuwky119TY7OyKlvz0
	 PT0lzQ8AlSXW59F7C6UiUCA1ogRfWNUP0R2EBqT5rkyaepBZrlXTyXc1pb5eM/i80J
	 42ogkIZiVwA6UzyWknpMnjQNvvz24MYkzrJwjHL/QvWD3J1ET/74Ba/E023qTdB2KE
	 NcPY8OsnThavA==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5c08539c827so6339829e87.2
        for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 05:50:28 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErHHuXDI1s/T3WkxQKAJrXj/mttHLnC6ZO0b5N10c9YvAR0kk8/UYxV/WTSS8H5O14BuEhrnXHUrQQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z/Cy6OJQHKmKrWVUhoCfd7SE2SN3LPJ+7WJTvxNP2nVcxiXviD1
	tEttGD9HvwJ+iJk6w8SIXlw0r9UgqoLjuvPI80R/uCnlz0zM8Vi67Ejc3TtVIn98+dohyBiEio9
	Dkrm6gGugk+cl2DQgh17Qk8OOyoAeg+g=
X-Received: by 2002:a05:6512:10c7:b0:5c1:5bc7:83c with SMTP id
 2adb3069b0e04-5c1bc89c62amr6845442e87.53.1795787427116; Fri, 27 Nov 2026
 05:50:27 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261119094706.3439040-1-daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <20261119094706.3439040-1-daniel.lezcano@oss.qualcomm.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 27 Nov 2026 14:50:14 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hpem9Zi-LUYHUZV3zt74u2oZaW17dZFZ9umW-rxMKEHg@mail.gmail.com>
X-Gm-Features: Aa3M54rGEvp6RBs-BR8LrunqB2b1616DRg-jRzuvyqm7Ffb_VP_JYi6I7y8tZow
Message-ID: <CAJZ5v0hpem9Zi-LUYHUZV3zt74u2oZaW17dZFZ9umW-rxMKEHg@mail.gmail.com>
Subject: Re: [PATCH v1 00/12] thermal: Add multi-source thermal zone aggregation
To: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>, Lukasz Luba <lukasz.luba@arm.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Anvesh Jain P <anvesh.p@oss.qualcomm.com>, 
	Ulf Hansson <ulf.hansson@oss.qualcomm.com>, linux-pm@vger.kernel.org, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

Thanks for the series, but there are questions regarding it and some
of them at a very general level.  It would be good to get answers to
them and some agreement on the basics before going into any details.

I talked to Lukasz offline about it and we seem to have similar doubts.

On Thu, Nov 19, 2026 at 10:47=E2=80=AFAM Daniel Lezcano
<daniel.lezcano@oss.qualcomm.com> wrote:
>
> Thermal management may need to estimate a temperature that no sensor
> measures directly. For example, skin temperature can be estimated from
> readings near the processor, display and battery; an internal board
> region's temperature from sensors around the processor, memory and
> power-management circuitry; and the temperature surrounding the battery
> from readings near the battery, charging circuitry and adjacent
> components.
>
> Each sensor's contribution depends on its location relative
> to the target region and the thermal paths connecting them. A linear
> regression model provides a practical approximation of these
> relationships: coefficients fitted from platform measurements weight each
> sensor's contribution, while a constant offset accounts for the baseline
> difference between the weighted readings and the target temperature.

No question about that, but it does not directly imply the necessity
to do some sort of temperature aggregation in the kernel.

So what's the motivation here?  Why is the kernel the right place to
aggregate temperatures in the first place?

We all know that such aggregation has been done in user space for a
relatively long time, so what problem is there with that which could
be addressed in the kernel in a better way?

> This series provides common support for aggregated thermal zones, allowin=
g
> estimated temperatures to benefit from the thermal framework's existing
> trip handling, governors and cooling policies.

What do you mean by "cooling policies" in this context, specifically?

In order to use the existing kernel code, the trip points and cooling
devices for those aggregate thermal zones would need to be described
somehow.  Also the aggregation coefficients used in this series would
need to be provided to the kernel so it knows how to do the
aggregation.  DT seems to be the only potentially viable source of
that information, but I'm not sure how realistic it is to expect DT
providers to produce sufficiently accurate information of that kind.

> It has two parts: thermal
> core support, which makes aggregation available independently of the
> firmware interface, and OF support, which allows platforms to describe
> aggregated zones in Device Tree.

In my view, OF support is key here because realistically there's no
other way in which the kernel can expect to get the requisite
information.

In ACPI, it is already possible to define thermal zones based on
aggregate temperatures.  It is only a matter of providing a _TMP
control method doing the aggregation and defining a thermal zone
around it, and there are no limitations related to linearity, the need
to create a thermal zone for every sensor involved etc.  This means
that on platforms using ACPI there is no real need to do temperature
aggregation of the proposed kind in the OS, at least in principle.

Given the above, it might be better to introduce a thermal sensor
abstraction into the DT bindings and define thermal zones around those
sensors individually (single-sensor) or in groups (multi-sensor or
aggregate) without modifying the non-OF part of the thermal core.
Wouldn't that be a viable approach?

> This series introduces support in the thermal core for deriving a zone's
> temperature from a weighted combination of existing thermal zone
> temperatures and a constant offset, reusing the readings already provided
> by sensor drivers.

This sounds nice, but only until you realize that whoever is going to
register an aggregate thermal zone will need to know in advance which
(already registered) thermal zones they want to aggregate and how
exactly to do it.  This requires information very much beyond anything
existing and tight control on what gets registered and when.  It may
not be generally achievable, so is this not a problem?

Moreover, the linear aggregation assumption this series is based on is
not generally applicable to temperature aggregation, especially in
cases like skin temperature estimation mentioned above, so is this
approach really sufficient to cover those use cases?

> Each source zone retains its own trips and cooling
> policy and can contribute to several aggregates, each representing a
> different thermal constraint. The series adds reference-counting helpers
> so aggregate owners can keep source zones alive until their dependencies
> are torn down. It also introduces registration-time validation of the
> aggregation parameters to reject unavailable sources, nested aggregation,
> incomplete coefficient sets and incompatible operations before the new
> zone is exposed.
>
> The series also adds OF support for describing aggregated zones through
> multiple thermal-sensors references and optional coefficients in Device
> Tree. These references identify hardware sensors whose registered thermal
> zones provide the source temperatures. Aggregate creation waits until all
> sources are available, allowing sensor drivers to probe independently.
> Dependent aggregates are removed before a source is unregistered and
> recreated when it returns. This lets platforms describe their thermal
> estimates without changes to sensor drivers, while preserving existing
> single-source calibration.
>
> The series includes KUnit tests for both the core and OF support, using
> synthetic thermal sources without requiring platform hardware. The core
> tests cover parameter validation, default coefficients, temperature
> calculations, error handling and source lock contention. The OF tests
> cover deferred creation, coefficient parsing, source removal and
> recreation, and a temperature read concurrent with source teardown. All
> 23 cases pass on UML with lockdep enabled. Initial late-init discovery,
> real module loading and platform hardware are not covered by these tests.
>
> Testing:
>   - git diff --check passes.
>   - Per-patch checkpatch reports no errors. Remaining warnings concern
>     commit-message line lengths and possible MAINTAINERS updates.
>
> This cover letter was drafted with OpenCode using gpt-6.1-sol from the
> commit series, human driven and a source-code study. The same tool ran
> the KUnit and patch checks reported above.

So is there any actual platform on which this new code can be
deployed, exercised and evaluated in practice?

Thanks,
Rafael
