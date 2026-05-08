Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17807410D34
	for <linux-pm@vger.kernel.org>; Fri,  8 May 2026 19:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778266898; cv=none; b=u/eS5kgBG9LgubleNqIrR4E1twm8/RScWU+Y1JkqBUfohJEOUWwXhujLorlVTnikatWpXbJoSeYgfUlqxqirSPgFAehWo3kTE0u386fLBP5Voybo9WuRRr+GfUS4ooRoCtXF7f7UErZsTdntR7WpyjlQL+velkzP1fLGRPTi9zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778266898; c=relaxed/simple;
	bh=50SMXz4G7+Ucp6B0QXGQ4Eq9CUeIww16GU//taPwKuw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VvjqkyjsE0DKKZrjOITSqF1vXd7iycJXphZSQfpuz6sWiBItvlNq9ZjWCLNK5muRg30e0NA8Tdc38y3M4lV3ly39qIzLz3wRx+JKREbglAhOyoooK2Md3pw/0WkNoz/+RZsUyvAuoXenjmCqQMxHspXPAhi5R1thpRn9SIsSOaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kMxjnNKD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kMxjnNKD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2475C2BCF4
	for <linux-pm@vger.kernel.org>; Fri,  8 May 2026 19:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778266897;
	bh=50SMXz4G7+Ucp6B0QXGQ4Eq9CUeIww16GU//taPwKuw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=kMxjnNKDNACcMoFB78LDcCOzWocwxbYqW5h8W+x0prfhCo9EhQzA4IjE6AGd3Yoma
	 X+mJYXfcP26r4yDsMW/LFG3NjcuzR5PDVg/ZI7Ps9bHnVLCM8sA34XmAqNa36iniC2
	 g9Hj6E7V123CGeFBplW9SYyoLrX3Klhj1RsYp8TTNp7BkNd67gz7e/KBD1N1sq7cIH
	 g4Y81Qg5JNa5NmQzoenA4W9H5XpwnpwCe+edWPxcSwB/r4sqlduXjsPWEFl2HGL8K3
	 iRbODU7TfhB54BLvpIwmwl3pRJIjsGx3dVBHIopXePVVhVQPl8Xj5LBOLHkOAsq3Td
	 aUkAl59YGfV3g==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-393c40246afso24928891fa.1
        for <linux-pm@vger.kernel.org>; Fri, 08 May 2026 12:01:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+wMoRkAGJdyzonLAoLI16i+qzgr4r5mqO6ZWnbXO4c5OjEokdvAzEcG2oI92hLQZeek/hpd73Cdg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8DfFK5T0UOg5+VsX2QTADS/P9RY21CzMzRGh2srgUBTPcZ8V1
	H7+f+Io/u+PSTh48VDZYubq7HF+HN05BjUDc9W1F4vJ4+DT682BYefY6Q4f6+k6OpPlKDxS6IsQ
	WNnBdYKzhluaxyf6L+pNg8DS+P45urJw=
X-Received: by 2002:a05:6512:1095:b0:5a4:4ea:9977 with SMTP id
 2adb3069b0e04-5a887adac13mr6102930e87.8.1778266896242; Fri, 08 May 2026
 12:01:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260430142430.755437-1-sumitg@nvidia.com>
In-Reply-To: <20260430142430.755437-1-sumitg@nvidia.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 8 May 2026 21:01:22 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gCSPjnxE2Vd+Py14ENJ6U46KBQVHiBetLfEKGybtDh8g@mail.gmail.com>
X-Gm-Features: AVHnY4KDNOdtryvfMGgDj_cDqWpBdpyIVcpUjhjZQjhE5vuQhaFeqwKRZcl3OjE
Message-ID: <CAJZ5v0gCSPjnxE2Vd+Py14ENJ6U46KBQVHiBetLfEKGybtDh8g@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] ACPI: CPPC: Add CPPC v4 support (ACPI 6.6)
To: Sumit Gupta <sumitg@nvidia.com>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, lenb@kernel.org, 
	pierre.gondois@arm.com, zhenglifeng1@huawei.com, zhanjie9@hisilicon.com, 
	mario.limonciello@amd.com, saket.dumbre@intel.com, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	acpica-devel@lists.linux.dev, treding@nvidia.com, jonathanh@nvidia.com, 
	vsethi@nvidia.com, ksitaraman@nvidia.com, sanjayc@nvidia.com, 
	bbasu@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 30, 2026 at 4:25=E2=80=AFPM Sumit Gupta <sumitg@nvidia.com> wro=
te:
>
> Add initial kernel support for CPPC v4 (ACPI 6.6, Section 8.4.6),
> which extends the _CPC package from 23 to 25 entries with two
> optional fields:
>
>   - OSPM Nominal Performance (8.4.6.1.2.6): register used by OSPM
>     to tell the platform what it considers nominal. The platform
>     classifies performance above this as boost and below as
>     throttle for power/thermal decisions.
>
>   - Resource Priority (8.4.6.1.2.7): Package of Resource Priority
>     Register Descriptor sub-packages. Full parsing is not yet
>     implemented; such entries are marked as unsupported.
>
> Patch 1: Add v4 _CPC parsing - validate the 25-entry layout,
> handle the Resource Priority package, and mark the two new
> registers optional.
>
> Patch 2: Add acpi_cppc/ospm_nominal_perf as a read-write sysfs
> attribute, and initialize it to the platform nominal value
> during cppc_cpufreq policy init.
>
> ---
> v1[1] -> v2:
> - Patch 1: added Reviewed-by from Mario Limonciello.
> - Patch 2:
>   - Make ospm_nominal_perf sysfs read-write; cache last write in
>     cpc_desc and skip redundant register writes.
>   - Validate input in cppc_set_ospm_nominal_perf.
>
> Sumit Gupta (2):
>   ACPI: CPPC: Add support for CPPC v4
>   ACPI: CPPC: Add ospm_nominal_perf support
>
>  drivers/acpi/cppc_acpi.c       | 93 +++++++++++++++++++++++++++++++---
>  drivers/cpufreq/cppc_cpufreq.c | 10 ++++
>  include/acpi/cppc_acpi.h       | 14 ++++-
>  3 files changed, 109 insertions(+), 8 deletions(-)
>
> [1] https://lore.kernel.org/lkml/20260427051823.280419-1-sumitg@nvidia.co=
m/
>
> --

Can you please see the sashiko.dev feedback on this set:

https://sashiko.dev/#/patchset/20260430142430.755437-1-sumitg%40nvidia.com

and let me know what you think?  Especially regarding the second patch?
