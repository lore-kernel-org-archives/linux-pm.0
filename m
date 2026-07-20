Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E05A3BB10D;
	Mon, 20 Jul 2026 18:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784572400; cv=none; b=MozRF9HZCUcswEd6d+Dmeue7KKJpoYBUBoKDkDHiQ9UKq0lJ7WDc3gRZOKcoJpp6SvDGBGBq0qwttVL3WcHxNOg4121bSVNDa87Z4/gZFJLRXWEcuRHZ8GO2nMeuGbqd+ZQc1onPy/XBi0JNoCZGqQ5NvyDpeBLcY/0xZG/oD50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784572400; c=relaxed/simple;
	bh=MDMQNzNLUDDQ5pxsU9ocRbtzwbz5aTGptDk9uut4bOk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NbG5Zj5Ha+D7alU4S+P7dvGe/dvTjnK7nCXv6wA61CI7iPxtBWRCNZqWYF8WQkU4WTn8I6aP6PhTz9Pvx8Ak7VIrpw+mykt6nJuvdi+2HocEnYBl4+v0E24CI4vkDIJFJFXD6Nc3BnGDshzcBR0ZY/mxGzbDhBjAuMlNzSTQne8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Qbi6nJ0T; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Qbi6nJ0T"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 27BBD143D;
	Mon, 20 Jul 2026 11:33:13 -0700 (PDT)
Received: from [192.168.20.93] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1692E3F86F;
	Mon, 20 Jul 2026 11:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784572397; bh=MDMQNzNLUDDQ5pxsU9ocRbtzwbz5aTGptDk9uut4bOk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Qbi6nJ0TKPevhIZtyA+/GgwQ5NLWF8aE16u/7BnATl0Z7FaOHI77dzrRVgn+MPazs
	 c2FgqQJYuZVa3B4qIunMzGMN6MD4mKzS35CqCKLIzfDA5MhcA6DfOoIEHCmZqrXtm3
	 KBFxfg6lJ9qZcByGWFNbWkX3sPMouOg1Cv8mkIVA=
Message-ID: <611fb9db-6263-4e53-a2cf-9ec35ae8ef17@arm.com>
Date: Mon, 20 Jul 2026 13:33:16 -0500
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] cpupower: Add generic CPPC performance display
To: Thorsten Leemhuis <linux@leemhuis.info>, linux-pm@vger.kernel.org
Cc: trenn@suse.com, shuah@kernel.org, jwyatt@redhat.com, jkacur@redhat.com,
 kaushlendra.kumar@intel.com, sashal@kernel.org, fj5851bi@fujitsu.com,
 rui.zhang@intel.com, linux-kernel@vger.kernel.org
References: <20260709221344.1919794-1-jeremy.linton@arm.com>
 <20260709221344.1919794-2-jeremy.linton@arm.com>
 <b87c77da-d207-4b9d-a36a-5cdfd03eacde@leemhuis.info>
Content-Language: en-US
From: Jeremy Linton <jeremy.linton@arm.com>
In-Reply-To: <b87c77da-d207-4b9d-a36a-5cdfd03eacde@leemhuis.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 7/18/26 1:12 AM, Thorsten Leemhuis wrote:
> On 7/10/26 00:13, Jeremy Linton wrote:
>> Arm64 machines, and possibly others, use the standard ACPI defined CPPC
>> infrastructure. cpupower has CPPC support, but it's largely written
>> around the intricacies of AMD processors, using platform MSRs to avoid
>> shortcomings in the specification.

Patch to fix it.

https://lkml.org/lkml/2026/7/20/2191

>>
>> [...]
>> +#include <stdio.h>
>> +#include <errno.h>
>> +#include <stdlib.h>
>> +#include <string.h>
>> +#include <math.h>
>> +
>> +#include "helpers/helpers.h"
>> +#include "cpufreq.h"
>> +#include "acpi_cppc.h"
>> +
>> +#define cppc_to_frequency(perf) (roundf(slope * (perf) + intercept))
> FYI, this patch showed up in -next yesterday and I suspect it caused
> this build error for me on x86_64:
> 
> """  CC       cpupower
> /usr/bin/ld.bfd: /tmp/ccjOeWLF.ltrans0.ltrans.o: in function
> `get_perf_cap.isra.0':
> /builddir/build/BUILD/kernel-7.2.0-build/kernel-next-20260717/linux-7.2.0-0.0.next.20260717.330.vanilla.fc44.x86_64/tools/power/cpupower/utils/helpers/cppc.c:39:(.text+0x45cc):
> undefined reference to `roundf'
> /usr/bin/ld.bfd:
> /tmp/ccjOeWLF.ltrans0.ltrans.o:/builddir/build/BUILD/kernel-7.2.0-build/kernel-next-20260717/linux-7.2.0-0.0.next.20260717.330.vanilla.fc44.x86_64/tools/power/cpupower/utils/helpers/cppc.c:49:(.text+0x46a2):
> undefined reference to `roundf'
> collect2: error: ld returned 1 exit status
> make: *** [Makefile:238: cpupower] Error 1
> """
>> [...]
> 
> Full log:
> https://download.copr.fedorainfracloud.org/results/@kernel-vanilla/next/fedora-44-x86_64/10739303-next-next-all/builder-live.log.gz
> 
> Ciao, Thorsten

