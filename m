Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792610400;
	b=WMqQv05G0od+Av+vMQqCXus/uTLGUIyQkFFwWXhspd0XQOwdddIbPvvGVgPf36O8VKvE
	 6nZsbKQPWWcbfwStQtVrKa1hGN/rTBA/s1QSllt+yDeIi0CsAwRQct4Yzfmel8zTFsldo
	 KyP5dLMEo4iKPt0B7BwdsqGbg8AQDJ83CPoUn/wIx6tQ4ELEpquzZ2czOsijqVaPbvBpD
	 V+mo4tTiBDjnJkg1tB7fB7xAbdx9sddMHkCghmRCwv3UCCdgF/yTNeSXrHWf09FaHMOkM
	 B8/ihu6w1OttRblRnNlbbICRco/tEb3GMLNJUyV4HuwUZkzYBiOH03fDshnaazfqkig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792610400;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=3+WTACnkwMXENrevO6sJabwmRcZyjukNXdtWkFkc+N4=;
	b=p4jSi3p6SrfBbMlAmRZcfzV9MMwezwBk7eOTwd9oddPawpFnqA08FFn4r68RfbygPcUD
	 zdNaZfqMY3v/aRpFOJ8NeV+lgFpBSyyi2zszezWFS7/W4c2Uc03w6EFrLqBHM7ezNUeIt
	 SlabpV3l8BolkJaQBT1CmWdNBcUZcW+HSIpMPWW7m7SpkOQTG7mIXhLjktgfPOOEY0QvO
	 faqfY4AFhfl9Yv7kEtwqV84ELIgrAvHptvTtkKeDDf87621gGebJQ9aEly4VX9vA4WvtV
	 KN6hhHPlgjBzHR5ee4HnJY21mUQm2C7mycG8xAD3BM390d1KwcYYr8ZDJfAg10ZacwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=AnGjMbWq;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38DC0606A31A;
	Wed, 21 Oct 2026 19:19:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 38DC0606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=AnGjMbWq
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0C6E016F8;
	Wed, 21 Oct 2026 12:19:55 -0700 (PDT)
Received: from [172.29.20.205] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6E85E3F673;
	Wed, 21 Oct 2026 12:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1792610398; bh=jkRhzxtfSJGZI2Q7Xf/Z61oLxh5NSfW4u0iArf/8I8s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AnGjMbWqtwDRs9BmpVVal1Pap4QoRsjGhOCq7WSGQQqxpshaTlSkB2Hv5MuxDsQct
	 wjX8MU7HLmPmYvQKiXugTdEdCg4eJg1Bxv2XuJPLgnz5vpaWHY48HtuWyTiTvhCSIv
	 wZsWHvaLAkt0Nf64LdQOS92CQDnIFnUipzxDU/n4=
Message-ID: <85f7842d-1728-445f-94a9-c917ffdb0fab@arm.com>
Date: Wed, 21 Oct 2026 14:19:55 -0500
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
Subject: Re: [PATCH] cpupower: Include stdint.h for int64_t in the CPPC helper
To: Florian Fainelli <florian.fainelli@broadcom.com>,
 linux-kernel@vger.kernel.org
Cc: Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>,
 "John B. Wyatt IV" <jwyatt@redhat.com>, John Kacur <jkacur@redhat.com>,
 "open list:CPU POWER MONITORING SUBSYSTEM" <linux-pm@vger.kernel.org>
References: <20261020214721.428420-1-florian.fainelli@broadcom.com>
Content-Language: en-US
From: Jeremy Linton <jeremy.linton@arm.com>
In-Reply-To: <20261020214721.428420-1-florian.fainelli@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 10/20/26 4:47 PM, Florian Fainelli wrote:
> cppc_show_perf_and_freq() uses int64_t without including the header that
> defines it. Building cpupower against musl fails with "unknown type name
> 'int64_t'" because the other included headers do not provide the type.
> 
> Include stdint.h directly instead of relying on transitive declarations
> from other C library headers.
> 
> Fixes: 68f34fad760b ("cpupower: Add generic CPPC performance display")
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---
>   tools/power/cpupower/utils/helpers/cppc.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/tools/power/cpupower/utils/helpers/cppc.c b/tools/power/cpupower/utils/helpers/cppc.c
> index 3493ce8551ea..e0e9784fe589 100644
> --- a/tools/power/cpupower/utils/helpers/cppc.c
> +++ b/tools/power/cpupower/utils/helpers/cppc.c
> @@ -1,6 +1,7 @@
>   // SPDX-License-Identifier: GPL-2.0
>   
>   #include <stdio.h>
> +#include <stdint.h>
>   #include <errno.h>
>   #include <stdlib.h>
>   #include <string.h>

Looks good, thanks

Reviewed-by: Jeremy Linton <jeremy.linton@arm.com>


