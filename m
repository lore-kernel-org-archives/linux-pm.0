Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84827420476;
	Thu, 17 Sep 2026 10:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789639308; cv=none; b=BvXeGDK0YUhA+5gmZpEBshc4KMmH7ahjfqAJ6kJa7VxUP87AIHANPm30ui0V84YsS5Z5Lo5RmXW6HbKmnciqAF5XYeV7YETjUKTEhEeu414uQCd5Mtge/eFdQH3rrwi0oUe+Cb0uPG6X5kFaK9RuJWLWk7lDewOft5wNKVH1WUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789639308; c=relaxed/simple;
	bh=1pwwAA8ZeOmKPOIlnHk+XRlZJTnA6zBlBTY2TxR85cU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j1SykDim4Zj9miPb7KF0ttVnpON7WlrVZR0oZmWRbPTRAvZzwu/sZhGWDDHAFpE9PWhZgrzEnWuXZMRWzP3Tyc/q7ceoHqXWe6UteMHj9W9T9n5NQqR/0ocvT+DYlKaAi7nysGhi06XAES3AqnUEFU3IMw8mKftRW66NF7DC6Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=SvAAG4W6; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="SvAAG4W6"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5102E1476;
	Thu, 17 Sep 2026 03:01:32 -0700 (PDT)
Received: from [10.57.74.102] (unknown [10.57.74.102])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0CE963F7B4;
	Thu, 17 Sep 2026 03:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789639295; bh=1pwwAA8ZeOmKPOIlnHk+XRlZJTnA6zBlBTY2TxR85cU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SvAAG4W6pCrBYl8UpXFPHTB71j6RSyCdPuWmd6UkpE0cOM3aNKMGhTZAlgIGEB7fV
	 Cd4IX/FcwNi0bAPpT+dbXe03++P3TJBX21zD+nSnKRWo8w05d+mhGf6NjzzytfXlME
	 YQWqbo5gb1j49X8rnLzxfNNa3piSKywqbAZlc1EM=
Message-ID: <6f2907ec-848e-4e60-98b2-a3b7a905b880@arm.com>
Date: Thu, 17 Sep 2026 12:01:31 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] arm64: topology: fix arch_freq_get_on_cpu()
 overflow above 4.19 GHz
To: Oleg Keri <okerixx@gmail.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Sumit Gupta <sumitg@nvidia.com>,
 Prasanna Kumar T S M <ptsm@linux.microsoft.com>,
 Beata Michalska <beata.michalska@arm.com>,
 Russell King <linux@armlinux.org.uk>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Sudeep Holla <sudeep.holla@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <55538466-2203-42ec-a0bd-b743c04a3b38@arm.com>
 <178955779940.30466.10860982419496123467@gmail.com>
Content-Language: en-GB
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <178955779940.30466.10860982419496123467@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Oleg,

On 16.09.26 13:23, Oleg Keri wrote:
> Hi Dietmar,
> 
> On Wed, Sep 16, 2026, Dietmar Eggemann wrote:

[...]

> Fine by me, that reads better than open-coding the shift. Your diff
> builds here on arm64 (topology.o and kernel/sched/), so I will fold it
> into v4 and add the scheduler maintainers to Cc for the header move.
> 
> Since the diff is yours: is a Suggested-by enough, or would you rather
> have Co-developed-by and your Signed-off-by on the patch?

Don't worry, I will give my 'Reviewed-By' for the final version.
