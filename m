Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.63.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF2F2C21F1;
	Sat, 18 Jul 2026 06:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.68.63.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784355741; cv=none; b=XXvdvIaZ1gkODpTO9RaSVHOj/v3Soz8t9uoX6vOXyGylNNbYWTWtJyEqYsWyMFazC8S718bmXHnubI10yL+oDGSXPAiq97vBWZF/QKKs82eFYLMIlyAzrys6v0d7wNr9dMSQJ8OBCIrUJ21lZJ4NJvhdsPkk3HjugCE9T9ZcKMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784355741; c=relaxed/simple;
	bh=bD4zqy2aEZ2Zaz3Y5m7ow2vy5mGDbtWbsGbZTE/eXfI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hXJIG8Ve+JQeE+mwwiyXcI6i7CGDBRs/sDntgsc4HbyMmpmyrjzhaEMnYxIXRPT9K+s6oa8E1Ug05+BSeoNI/wEL0Q9QlBeOfgNBQzmThxXKeDZ/6ygUVnEN9rk8AqaAlGI5pPejEJgHMceeO+FaFAi9XCJvlkvDP9EptZda2fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=F1NrzjU3; arc=none smtp.client-ip=188.68.63.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="F1NrzjU3"
Received: from mors-relay-2501.netcup.net (localhost [127.0.0.1])
	by mors-relay-2501.netcup.net (Postfix) with ESMTPS id 4h2GfQ5Rrtz68rF;
	Sat, 18 Jul 2026 08:12:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1784355166;
	bh=bD4zqy2aEZ2Zaz3Y5m7ow2vy5mGDbtWbsGbZTE/eXfI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=F1NrzjU3Gn3YYSXQb9R2sIhNIhaZmYV/y1RxQHb2BvfMp3ewHid3+enh/31BHIMVe
	 XRB5VvF8rFjvNljk3wCa9TPuftQo6TnBT8GnJvPta2ZEjsynk921P/Bhyo00sHJtRG
	 it+5KsaeSKZmpqPR99Ek21Mh9bYPPuAzHWKEeC9mbUxbeaKbW3CF+rnIJO/0Qxay6j
	 MCSIChAU/GSwK6ewv5c5NGBZGVDhBuICDjzxzIyl7vCsdaUl2lsRL9RCNS83SYgR4N
	 2FU8TQPRp+SgxoVRuZaTlt1fq5N44to6A3NPLhsQj6BG8j4XcmAP1Cd2TmejHViJaN
	 zhKJv/AJTolfw==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-2501.netcup.net (Postfix) with ESMTPS id 4h2GfQ4jhMz4ybW;
	Sat, 18 Jul 2026 08:12:46 +0200 (CEST)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4h2GfP73Q4z8sbD;
	Sat, 18 Jul 2026 08:12:45 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id D03095FA0D;
	Sat, 18 Jul 2026 08:12:44 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=linux@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <b87c77da-d207-4b9d-a36a-5cdfd03eacde@leemhuis.info>
Date: Sat, 18 Jul 2026 08:12:43 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] cpupower: Add generic CPPC performance display
To: Jeremy Linton <jeremy.linton@arm.com>, linux-pm@vger.kernel.org
Cc: trenn@suse.com, shuah@kernel.org, jwyatt@redhat.com, jkacur@redhat.com,
 kaushlendra.kumar@intel.com, sashal@kernel.org, fj5851bi@fujitsu.com,
 rui.zhang@intel.com, linux-kernel@vger.kernel.org
References: <20260709221344.1919794-1-jeremy.linton@arm.com>
 <20260709221344.1919794-2-jeremy.linton@arm.com>
From: Thorsten Leemhuis <linux@leemhuis.info>
Content-Language: de-DE, en-US
Autocrypt: addr=linux@leemhuis.info; keydata=
 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 MEK4
In-Reply-To: <20260709221344.1919794-2-jeremy.linton@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: 
 <178435516529.2803023.17190362702016102716@mxe9fb.netcup.net>
X-Rspamd-Server: rspamd-worker-8404
X-Rspamd-Queue-Id: D03095FA0D
X-NC-CID: nWGfIWK7+g0UCl6+Fe63zYU7z2Agdp77vrlEBRUbPRJiv7zYpPo=

On 7/10/26 00:13, Jeremy Linton wrote:
> Arm64 machines, and possibly others, use the standard ACPI defined CPPC
> infrastructure. cpupower has CPPC support, but it's largely written
> around the intricacies of AMD processors, using platform MSRs to avoid
> shortcomings in the specification.
> 
> [...]
> +#include <stdio.h>
> +#include <errno.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <math.h>
> +
> +#include "helpers/helpers.h"
> +#include "cpufreq.h"
> +#include "acpi_cppc.h"
> +
> +#define cppc_to_frequency(perf) (roundf(slope * (perf) + intercept))
FYI, this patch showed up in -next yesterday and I suspect it caused
this build error for me on x86_64:

"""  CC       cpupower
/usr/bin/ld.bfd: /tmp/ccjOeWLF.ltrans0.ltrans.o: in function
`get_perf_cap.isra.0':
/builddir/build/BUILD/kernel-7.2.0-build/kernel-next-20260717/linux-7.2.0-0.0.next.20260717.330.vanilla.fc44.x86_64/tools/power/cpupower/utils/helpers/cppc.c:39:(.text+0x45cc):
undefined reference to `roundf'
/usr/bin/ld.bfd:
/tmp/ccjOeWLF.ltrans0.ltrans.o:/builddir/build/BUILD/kernel-7.2.0-build/kernel-next-20260717/linux-7.2.0-0.0.next.20260717.330.vanilla.fc44.x86_64/tools/power/cpupower/utils/helpers/cppc.c:49:(.text+0x46a2):
undefined reference to `roundf'
collect2: error: ld returned 1 exit status
make: *** [Makefile:238: cpupower] Error 1
"""
> [...]

Full log:
https://download.copr.fedorainfracloud.org/results/@kernel-vanilla/next/fedora-44-x86_64/10739303-next-next-all/builder-live.log.gz

Ciao, Thorsten
