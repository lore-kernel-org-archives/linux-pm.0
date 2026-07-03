Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09FB823535E;
	Fri,  3 Jul 2026 15:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783093911; cv=none; b=I3AogQQYODNaWqSvn64PEkxgBqykGQp0ABFSqY49xB8r1pyBFWVoKsdM++nT+uCfl7yYcqtOzQZKBj9Aeu7053pjAraOQPndbRiPEnojNAb7jVZPh1nyvwlpqy5EtBxSc/8qxC2YYcxDyQE97r+I7LVBRqqQgYs6+r3vhJxx0cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783093911; c=relaxed/simple;
	bh=lVW7oFsmm3mnZfJWpUXg/oAmayER/txPAT+ERX5ry/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nh2uh1hG/4+ezopIoRK9otbrC6jVBQHCwcIY3M93EfXCmy3pddGscxIxUtFexm1Od0xajmKHXuWY/TuknVheJOiq1y4isApyqV6XHJpsLuQtrvSDVFmnxECU+aZgcJ+HVk2iMlU/w38mCQJmLk2mJTrXh0cb5hV2ZUcRtiL5rtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S1W87LOQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S1W87LOQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 361A11F000E9;
	Fri,  3 Jul 2026 15:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783093909;
	bh=3tFkhV9y3YSpG7ZFQq6X18e4oKX1Jy1S3KYwLSR0WpE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=S1W87LOQhTm4vC9qjjU6evSDA7cIZuPkpXGHrVl4l/Y2SBeuvoH3TBVUAYI6gg35B
	 VMDwmFQDailxQp2+c++0GbmJHxuzaTy2XN9S6wp83hs4sHDycopFzFEGVwUjMObiUT
	 Je63NveeqJD6Bam9yHz6UZ0bTDCVl+eHpKGJeEkLKBIr4CyfnngUwG0MCmPLcc6/4h
	 yYOYIyfExN+aPu8V3GrcFy8GRZPzFJMaCxni28KSWA1qdJf88B3BNZpkckITHIPCoh
	 KkZzB4kXLBDry3iqhIgrM+IQPgQdLa6f1pP+eq1R4oAkPxZVWlMrXwRqEHg1yYZr22
	 9/n+cUnD34acg==
Date: Fri, 3 Jul 2026 16:51:43 +0100
From: Sudeep Holla <sudeep.holla@kernel.org>
To: Sneh Mankad <sneh.mankad@oss.qualcomm.com>
Cc: Thomas Gleixner <tglx@kernel.org>,
	Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Will Deacon <will@kernel.org>, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] arm64: Disallow disabling boot CPU based on config
Message-ID: <20260703-competent-adaptable-coot-f8daaf@sudeepholla>
References: <20260703-disable_boot_cpu_offline-v2-1-782d16ff58c3@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260703-disable_boot_cpu_offline-v2-1-782d16ff58c3@oss.qualcomm.com>

(It is always good to cc all PSCI maintainer for any ARM64 CPU
hotpug/suspend related changes)

On Fri, Jul 03, 2026 at 04:50:02PM +0530, Sneh Mankad wrote:
> The Qualcomm SoCs like LeMans, Monaco support suspend to ram which leads
> the SoC to ACPI S3 similar state where SoC is turned off and DDR is
> retained. The hardware design on these SoCs forces a constraint to suspend
> and resume the system on boot CPU / CPU0.
>
And you fail to explain why they have that constraint.

Is it because some secure context is not allowed to migrate ?

We already have a mechanism for that in place and this hack is not at all
required.

-- 
Regards,
Sudeep
