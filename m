Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793794737;
	b=k/PG4rBjVNF3w+KkUuIQPowAAJc5mVr6YS12keVdzFQKFxgKNwhE66xJd+frkxfjDo58
	 NbJQn67YNwHYuibNA52vFCMcTmdQFxMs+vbV/A4gObGU8a1jioB3t0/dHFlT+hDMLY+0A
	 aGBvlDAmCZvmu1NeLniXXYBnrj7FC4TbLnYOAP940EItB97N8ya4ZJ8FwuARhD5phU+S4
	 +yBrYpT8SjJlgoC6Q9ZQFuMpVYAzdT7wnX0D2w9xXRUAI31UMdtiGh5k/+FSOVvY5FPu5
	 SXHQ99hNTGSDuNj6E3ukFhw8WYp+5S/6olXAlhseLli3jcJFSVWlcr1H+0r3z4rzObQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793794737;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=qXomi4rf2GhmcXTADjrL7n6lw6ISYtP/rDQPlcwPAVM=;
	b=qu8itWltn25Wjc9CEqPgLbWTmwsmcM4GMP7+hO2NP0KS3ORQOF6S5pAbOIrFzPN7u/gu
	 wScVN5zvlA2g6BIScT3+XVEv96CcZ/szlZcn9JxAcbJdtIrZ458YHYAisuNsMi414VL9a
	 GnBCOD4IEmKfh8JJDU0WaaKPgF7xnhr3YRC2J7XOIs2iYh5ocYq15+QNDhIiPCdwYeI0O
	 s8R8+Uv9wBa5WN0ulyKMWSQ9O8j6W93JghGR/6z1Jr7d3YQS3eeqhum4eSM0xRMhKvujK
	 +ft64pAbeFfpCTU61qzsf07pNfZu+hSaap6d1bouzJ7GbC8N0CNDDmUJ/CWrZUygflg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=bS+Avvp+;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD55606A31B
	for <linux-pm@vger.kernel.org>; Wed,  4 Nov 2026 12:18:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BAD55606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=bS+Avvp+
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E14362247;
	Wed,  4 Nov 2026 04:18:52 -0800 (PST)
Received: from [10.0.130.179] (e127648.arm.com [10.0.130.179])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 66A483F628;
	Wed,  4 Nov 2026 04:18:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793794736; bh=oK1Ttn6lJjUxA8MvboNY4QihmC3eD3F5PmlDVd6OYh0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bS+Avvp+nj7J9zJRqS2TPjfTdXJIDludw+x3R+wQyW0VNkVMwJ0Mij+zzpO6L93QI
	 dP0qSTKCCjDIfXxQ/2/UChuD5YOZ61vZmI3vjDNcokEap59vvNf+JCAwWLJam1ZdaD
	 7tgaGjxl3QY+cXux0VYbeNggpd8fiJemWmDXgJrg=
Message-ID: <3a7953b8-448d-40c4-a859-b8c61256424a@arm.com>
Date: Wed, 4 Nov 2026 12:18:52 +0000
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
Subject: Re: [PATCH v2 0/3] cpufreq: Fix synchronization with system
 suspend/resume
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
 Doug Smythies <dsmythies@telus.net>, Zak <zakbrightonknight@gmail.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Mario Limonciello <superm1@kernel.org>
References: <6065833.DvuYhMxLoT@rafael.j.wysocki>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <6065833.DvuYhMxLoT@rafael.j.wysocki>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/3/26 19:42, Rafael J. Wysocki wrote:
> Hi,
> 
> This is an update of
> 
> https://lore.kernel.org/linux-pm/5162355.31r3eYUQgx@rafael.j.wysocki/
> 
> that modifies the first two patches in the series (to address Sashiko
> findings) and drops the last one.
> 
> This series fixes issues related to the synchronization between cpufreq
> and the intel_pstate driver with system suspend/resume mentioned here:
> 
> https://lore.kernel.org/linux-pm/CAJZ5v0hT6aoX4tuJM+rO_5iequFc_7rEXCoaFnHoJBaH3JP4KA@mail.gmail.com/
> 
> The first patch actually prevents governor operations from being
> carried out on suspended cpufreq policies.
> 
> The second one forces the driver .target() callback to be invoked on
> the first frequency update after cpufreq policy resume.
> 
> The third one causes intel_pstate to invalidate the cached last
> P-state value during suspend.
> 
> Thanks!
> 
> 
> 

Tested-by: Christian Loehle <christian.loehle@arm.com>

AmpereOne: cppc_cpufreq, s2idle
AMD Ryzen 5 7430U, amd-pstate active/passive/guided, S3
AMD Ryzen 3 3300U: acpi-cpufreq, S3
Radxa Orion O6: cppc_cpufreq, PM test stages only
