Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793866267;
	b=Nqihqm/qYQLfPXLrxlzv9M/bbpo4V6TEFSgicZgIubDLTBvhFsh72hlZ9ZPoJKhCgwGy
	 7McgLI6xmOGXi/Tj+GC1KfIfSODkpAeja+RWAoUatIQctRpye6UtqV0fGHyvSlpNHnoMO
	 +WhUa/gcnhoIDmgAFRYGEL8u53v4m5KLK/I+3njXPfjNefSWJYVLsWn9ChAZDwifAkE7N
	 HNx4TKjsqmAWl/6d8KxttO9a9JUojdMnXkOrOItcskdWV1wZydl7ViKQmi/RHWuHwE3eo
	 SGlEkDIvcNX2nT5vVuciTYjboOd4m7unmOYNKe/hDX048lNrQJY6JlNLhzC25L+QWdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793866267;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=k2kV++0KkLBH5brlnSSDfSfy6EkjMYv+IqlDHzr/Zis=;
	b=x5WXpiKxo+NgRqobKBESoKiDwbG9tUo0SypnZin2uIo9GyxbpIIaGungJjKSQZjcT0fc
	 fyexrZAZeSgq0xe+wPWQ7sGUSScnMEfEOppcfkS0bNWJSv547oIPu7kA9zqpDhXtgSlGE
	 LrWk3k+lQqUBUNTuPamX1nWCzZu/kDcC87dCYUQ//L0JfuB46nGwp6EP/ZwaZNrfaVrZJ
	 ANHjaP1h/ayKMOLrmmKv1goA6M5I1yiws/B+5HyEuDymnpHguNTMc7JxhFEQ+bjR2pt4m
	 kSlpPgUZZKAD5o+RKi3Ag+mxPaorz8jWcgpLrRLoiJ7sR208PMEYpUlspV7yIy7MD6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=XnEQ10Fp;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C758606A326;
	Thu,  5 Nov 2026 08:11:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C758606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=XnEQ10Fp
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5188D152B;
	Thu,  5 Nov 2026 00:11:01 -0800 (PST)
Received: from [10.57.17.2] (unknown [10.57.17.2])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8E8123F673;
	Thu,  5 Nov 2026 00:11:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793866264; bh=guG2LxtQjqQSAz+GSbDIH/DgynW4RmuQ4u309BCNpTY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XnEQ10Fp716oYvC3kMcPoqBk4TfdLNY3AuYHhNtItluOg2z+D1JSu09JdSm/um7XU
	 2ZSzsM8/XOG7pBy7p7vHwQ10/3ojbBQYu+VB1NgV/KuY3Xe/spJi7JGAInEH71Y+QP
	 sGb2lQg39/w9Tf6f5T/1XJ1r89mlhQuJgpT9Bv9M=
Message-ID: <be158e9a-a4f8-4ce4-8183-85c747af2129@arm.com>
Date: Thu, 5 Nov 2026 08:11:01 +0000
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
Subject: Re: [PATCH 0/2] cpuidle: idle_miss accounting fixes
To: "Rafael J . Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261030083633.1699270-1-christian.loehle@arm.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20261030083633.1699270-1-christian.loehle@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/30/26 08:36, Christian Loehle wrote:
> These two fixes exclude timer-broadcast fallbacks from governor miss
> accounting and respect the entry-time latency constraint when looking for
> a better deeper state.
> No functional change outside of sysfs above/below and tracing.
> 
> Patch 1: Exclude timer-broadcast fallbacks
> 
> When tick_broadcast_enter() fails, the core forces a shallower state.
> Exclude these entries from governor miss accounting while retaining
> residency, usage and governor feedback.
> 
> On Orion O6, traces with menu and TEO running schbench, tbench and hackbench
> recorded 6930 cpu_idle_miss events on 8172 broadcast fallbacks before the
> fix, and none on 7763 fallbacks with patch 1. All matched fallbacks entered
> WFI.
> 
> Patch 2: Respect latency constraints for below misses
> 
> An enabled deeper state may violate the latency QoS constraint, causing a
> false below miss. Save the governor latency limit at entry and exclude
> states exceeding it, without an additional state-table walk. Disable flags
> continue to be checked at exit as they are expected to change less frequently.
> 
> Christian Loehle (2):
>   cpuidle: Skip miss accounting for timer broadcast fallbacks
>   cpuidle: Respect latency constraints when accounting below misses
> 
>  drivers/cpuidle/cpuidle.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 

Rafael, any opinions?
