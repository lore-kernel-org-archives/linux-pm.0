Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0FA4963A8;
	Fri,  5 Jun 2026 08:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780649211; cv=none; b=iNqp/XW7qJ7Q3lssh8Qk/jiGNGjmDRslMThJ6DWX0VHa7bXA85BHQ9Cmf4EpX3iEYHsvM1IoWGxdLefIcm8KP+Bv1Va8M/aPiwVtq9YP8GCRIpdxRy6eqa26hO8/6/gRccSVX66gBUlIuDQIFbhqU3Ir8zUIJ8//v69V4jB5TdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780649211; c=relaxed/simple;
	bh=h5Teg7Wkye+9/VHOc09vDQfFBBnMWuMpISWI3uDCqKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ojViCERTFttGk1m6J2vukevLkXyoHzYfkvETOeEeYtUFHi5NFQi+Kx6KJ73iHHbd7ArT+y5+eVoR0O1COKfXhNK4/4HxuAPTB/7PM5Bt6NGTAIcB+nmzd0VhP4+9Qkln5eLTYB7OAQD7SEzmuGvdadnMPajTMyYtnj7jxUGzS0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZKzdRkuB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZKzdRkuB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 810B41F00893;
	Fri,  5 Jun 2026 08:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780649207;
	bh=sTiCLUcDNVs3jG8PMviVhw4RKeHL/1qP/MhRnZu7xBA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZKzdRkuBPxY6cJEVwPyljO720DWyyF+WZPEP5rWwC+Xuu25sPUZOnZ4JGsDdBA2a4
	 xd/RVVQ1aTG9zMUTQJ6enwtaQhYnuHWoKihI4ctV0KMtVFxHfCvSHKGzuqlEUEARFm
	 ugWbklubBEIH86rUT7XSOfzc/LfX+3TJrHHoFhpUYLtnBKFJ9wui2LWgR0aIFOwlo9
	 rrjqLcT9UwzT8rULdD4gQg0Yi8h9KIGDh1OmkrSrDsAJL1YmU5Knh4y6AHsF1dNt5i
	 SCVW9KCLCnl9+HNCkNHXq0ztVCKdT786DdBDT3HvcbEZice7P7aRkzir+ZlnaCa9TG
	 1oJCDX9KVsLRQ==
Date: Fri, 5 Jun 2026 10:46:41 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Juergen Gross <jgross@suse.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, linux-pm@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Huang Rui <ray.huang@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Perry Yuan <perry.yuan@amd.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Len Brown <lenb@kernel.org>, Hans de Goede <hansg@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH 4/8] x86/msr: Switch all callers of wrmsrq_on_cpu() to
 use wrmsr_on_cpu()
Message-ID: <aiKM8XsL6s6-6_h9@gmail.com>
References: <20260605070826.2995913-1-jgross@suse.com>
 <20260605070826.2995913-5-jgross@suse.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260605070826.2995913-5-jgross@suse.com>


* Juergen Gross <jgross@suse.com> wrote:

> Now that wrmsr_on_cpu() has the same interface as wrmsrq_on_cpu(), the
> callers of wrmsrq_on_cpu() can be switched to wrmsr_on_cpu() and
> wrmsrq_on_cpu() can be removed.

Similarly to the other patches, this should be split into two
as well.

Thanks,

	Ingo
