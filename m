Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB8B1D7E5C;
	Mon,  7 Sep 2026 08:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788770999; cv=none; b=RF8dA23+6UJgbpYPQwHC5YnhWuZUbACTGRsG0j6yV/Ha6BKp/JdpPsHKw+gsoCyBXgd0XVChDBZ7AxVswoCJa9NU8MSiX/SxS6IATBYKXj0Y/UjYPNzzFgCaIqNlBwDH0SrjyYGpKqlHK5suhWzX1iujAiiWJlmAAcJGSZ89Klo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788770999; c=relaxed/simple;
	bh=pH3II/1kOttsrioQX5Aapg02bskPjjORNKfZhPNOfa4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rCQDhX7PWA0Jf9gknSvUAgT9LkK+wBLfMqFgX/IVCy/Pf21xAyUmyZr/ZR6A5h9GUjnvH2f5/mM7tG5uTNB6cF+IDaQG3RitYX80sua1kHeT0ccj5of84sY7ZAyisMZBTGvdS+hbaLFLUKbYbt5sSGnxofm3OqVxQwdUlu176OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4hdgTJ67xSznTVn;
	Mon,  7 Sep 2026 16:38:44 +0800 (CST)
Received: from kwepemf200017.china.huawei.com (unknown [7.202.181.10])
	by mail.maildlp.com (Postfix) with ESMTPS id 2DAE140565;
	Mon,  7 Sep 2026 16:49:55 +0800 (CST)
Received: from [10.67.121.58] (10.67.121.58) by kwepemf200017.china.huawei.com
 (7.202.181.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 7 Sep
 2026 16:49:54 +0800
Message-ID: <d02f335a-c97d-49ad-85c0-2eacd744eb0c@hisilicon.com>
Date: Mon, 7 Sep 2026 16:49:53 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/3] cpufreq: cppc: Handle Highest Performance changes
 at runtime
To: Xueqin Luo <luoxueqin@kylinos.cn>, Sudeep Holla <sudeep.holla@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Viresh Kumar
	<viresh.kumar@linaro.org>
CC: Lifeng Zheng <zhenglifeng1@huawei.com>, Pierre Gondois
	<pierre.gondois@arm.com>, Sumit Gupta <sumitg@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <driver-core@lists.linux.dev>,
	<linux-pm@vger.kernel.org>
References: <20260807060848.832929-1-luoxueqin@kylinos.cn>
Content-Language: en-US
From: Jie Zhan <zhanjie9@hisilicon.com>
In-Reply-To: <20260807060848.832929-1-luoxueqin@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemf200017.china.huawei.com (7.202.181.10)



On 8/7/2026 2:08 PM, Xueqin Luo wrote:
> Hi Rafael, Pierre,
> 
> This series adds support for handling ACPI CPPC Highest Performance
> register changes at runtime, triggered by Notify(0x85) on a processor
> device.
> 
> When the platform changes the Highest Performance value (e.g. due to
> thermal or power budget adjustments), the OSPM must re-evaluate the
> cached capability and propagate the change to the cpufreq policy,
> the scheduler's CPU capacity model, and the frequency invariance
> engine.
Any real use case of this on platforms that run cppc_cpufreq drivers?
Some addtional motivation may help.

For example, a processor can age over time and its core frequency degrades.
It's good if platforms can make OSPM and userspace aware of this.
> 
> The series is split into three patches:
>   Patch 1: Core update_limits callback with boost QoS handling.
>   Patch 2: Refactor autonomous perf bounds into a reusable helper
>            and wire it into update_limits with error logging.
>   Patch 3: Topology subsystem runtime capacity updates with
>            validation, early-return optimization, and concurrent-safe
>            normalization.
> 
> v4 -> v5:
>   - Move cpu_data and caps pointer assignments after
>     guard(cpufreq_policy_write) in cppc_cpufreq_update_limits() to
>     avoid potential use-after-free if concurrent CPU offline frees
>     driver_data before the lock is acquired (Sashiko)
>   - Extract cppc_cpufreq_sync_boost_limits() from update_limits to
>     handle boost_supported re-evaluation, cpuinfo.max_freq tracking,
>     and boost_freq_req QoS update in a dedicated helper. The helper
>     always updates the QoS request (even when boost becomes
>     unsupported) to clear stale constraint values, and forcibly
>     disables boost_enabled when boost disappears at runtime
>   - Add highest_perf validation in topology_update_cpu_capacity():
>     reject values below lowest_perf to prevent corrupted register
>     reads from propagating into the scheduler capacity model
>   - Add early-return in topology_update_cpu_capacity() when
>     raw_capacity[cpu] is unchanged, avoiding redundant normalization
>     and schedule_work() calls
>   - Add zero capacity_scale guard in topology_update_cpu_capacity()
>     to prevent division by zero in the normalization loop
>   - Move guard(mutex) before the raw_capacity NULL check so that
>     the pointer read is protected by the lock
>   - Add CONFIG_GENERIC_ARCH_TOPOLOGY guard with no-op stub in
>     arch_topology.h for configs where the topology subsystem is
>     disabled
> 
> Xueqin Luo (3):
>   cpufreq: cppc: Add update_limits support for Highest Performance
>     changes
>   cpufreq: cppc: Refactor autonomous perf bounds into helper
>   arch_topology: Add topology_update_cpu_capacity() for runtime updates
> 
>  drivers/base/arch_topology.c   |  76 ++++++++++++++++
>  drivers/cpufreq/cppc_cpufreq.c | 157 ++++++++++++++++++++++++++++++---
>  include/linux/arch_topology.h  |  13 +++
>  3 files changed, 233 insertions(+), 13 deletions(-)
> 
