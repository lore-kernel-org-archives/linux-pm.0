Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8015C2C326D;
	Wed, 24 Jun 2026 09:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782293488; cv=none; b=qF7mecTWQOMG6J18Wl0fHUmyURS8rVyW4IZf76avXhgy/7JFQOfiaZwd73GmCShxF3Hc3Z34omGo1jycvS29yvxNOgYjvfcjJUHgVexEWK0pRk47/35L/ASscvYgfNxa1/JuM+X906aduic09bPKdW4r4P/+6tfJO3J372+mHFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782293488; c=relaxed/simple;
	bh=f78DdMk3lXSxl0fBDwM4Fv6/rYD6BuXGfJODMxf24cM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uc/7102gsImLUd7jxT3ECVQXtr7zEjeCIEEadoDsjeaLVrOsNzn/k/6uw1bKj0cyE9CsV/Tr7ho+lm2z9dps/vRPY1rsq/3VKEMNQ2raYT1NAFVCxAGSfKbM2MXaQJPrGwlOGQZJOYQqNIpaZF3Y6X+G2Ul31pcsR7MeKOwiLlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YeJtaNYr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YeJtaNYr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A26C41F00A3A;
	Wed, 24 Jun 2026 09:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782293478;
	bh=mKq3kVsQK8gnR5GGmjnAVb45whfGfX//spn0fYvXMlA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YeJtaNYrYqRK397CTg7wp9RmUgM+MnXqfoQBhpM2Lux9qViF3kPfqDnZ7v2zyBVtL
	 Fi0uhHc6y0iQTU0oGIx4cSAlBMwfUW0Gkca1yFIl96kzSuQ1UE9GLwYYiMitwdrvdd
	 GhMtL+66N3KvFS885K3jJjmY0+h1GCH5RMSS2N7Ex3lXldqXiHAX/87+vogGAw59FT
	 FJZsRw8DQ38ymckIoEP0glg+TRXtpaok3J2wiBzuysnLLHiYGDnWXAXNAycfZsqodF
	 PIUFY1nq1o1QE/8Jdsm7vFd4TCzpyKHT2QzCvhMEbP0uuj4erRNbHqBuq6plsbul6p
	 PZphR+8eTEdSw==
Date: Wed, 24 Jun 2026 09:31:14 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>
Cc: Shuah Khan <skhan@linuxfoundation.org>, Pavel Machek <pavel@kernel.org>,
	Len Brown <lenb@kernel.org>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	driver-core@lists.linux.dev, tfiga@chromium.org,
	senozhatsky@chromium.org, Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v4 0/2] PM: dpm_watchdog: Improve DPM watchdog
 configurability
Message-ID: <ajuj4i43qo4pYXQf@google.com>
References: <20260611021219.2093476-1-tzungbi@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260611021219.2093476-1-tzungbi@kernel.org>

On Thu, Jun 11, 2026 at 02:12:16AM +0000, Tzung-Bi Shih wrote:
> This series improves the configurability of the DPM watchdog.
> 
> Currently, the DPM watchdog timeouts are fixed at compile time, and the
> watchdog is always enabled if compiled in.  Also, the module parameters
> defined in drivers/base/power/main.c use the generic and non-descriptive
> "main" prefix.
> 
> This series addresses these limitations.
> 
> Patch 1 renames the module parameter prefix for drivers/base/power/main.c
> from "main" to "pm_sleep".
> 
> Patch 2 introduces the "dpm_watchdog_enabled" module parameter to allow
> enabling/disabling the watchdog at boot time and runtime.  It also adds
> CONFIG_DPM_WATCHDOG_ENABLED to set default value of the module parameter
> at compile time.

Just realized I messed up the Signed-off-by lines for the patches, so they
haven't been added correctly to the commit messages.  Please disregard this
series.  I'll fix and resend the series after v7.2-rc1 is out.
