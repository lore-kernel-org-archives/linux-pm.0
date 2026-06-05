Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3D24BCAC3;
	Fri,  5 Jun 2026 09:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780650157; cv=none; b=A6jn0GM5s8oJWSpyFeDTMJte3civcRRn1BUVonQTXsLPbTRUTL9zDMCgtwEDtPI1Oe3stwKUMwfi58J+5KwL1HabgZe/lLH6SCnvdA6JOjX0b7B0EkAnXgk8/hCjkagHO7GO3+dp1Vobt5F5IyqMdboHFQ7r3TE173zK5wUZLUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780650157; c=relaxed/simple;
	bh=L0IH6A8sLwu2haEBIzm6qTY5hutHyj8cTlEX/ngpsrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BG4n2Hu7mc94dOeqf06amQr7ZpFWUvUHS1TrIfFw4KFNh4OtTWCU2+JRF87bzO9wAZmpQBckr3ZZe68KRMyQSUnYZxns/gBR8Ao7jLjKaV9itbDnioZIWjD08UyB2uzWOn1/AUDDvCUxdv/Kk9VsroW2lNNP0NlIotPZ0e7VMPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nw7jNpPz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nw7jNpPz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72FED1F00893;
	Fri,  5 Jun 2026 09:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780650154;
	bh=kE1HLfx6hCoGNH/jk00Y8VJf9rHnOdUQQDAqgAgZ3n0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Nw7jNpPzYdLA/kyLG7Ed1j5OK8UlqisSkRDUWHW82kLAyqlenhI6xSkAwxfuEuecm
	 mcwMY/QhQhy39T747M6FEY6EnmD3pqoDcidxBpLmr7d7v23Wb2+ZikE4YvvnyLvQOg
	 c/cx1zelEfCrPhfC8mL8wYjBZN5OPjO6oQaugsHtWWpcd9z23vJXnXr264Hrk1iozX
	 RwcAKmwPF0JMidYDbFnHxqFzRC6HJZXbO67n1ULO70iW2jZchWIKytoo6bj8KocgJa
	 3xQo0C2jPMLiI3G0t1HyEREkvmT98WINA+1urfn8eUCcD4AmMtmtAplTBo6RHoEjJt
	 2r7LcGPDsKV3A==
Date: Fri, 5 Jun 2026 11:02:27 +0200
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
Message-ID: <aiKQo5-_LZYNXwo7@gmail.com>
References: <20260605070826.2995913-1-jgross@suse.com>
 <20260605070826.2995913-5-jgross@suse.com>
 <aiKM8XsL6s6-6_h9@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aiKM8XsL6s6-6_h9@gmail.com>


* Ingo Molnar <mingo@kernel.org> wrote:

> 
> * Juergen Gross <jgross@suse.com> wrote:
> 
> > Now that wrmsr_on_cpu() has the same interface as wrmsrq_on_cpu(), the
> > callers of wrmsrq_on_cpu() can be switched to wrmsr_on_cpu() and
> > wrmsrq_on_cpu() can be removed.
> 
> Similarly to the other patches, this should be split into two
> as well.

Specifically, instead of:

  x86/msr: Switch wrmsr_on_cpu() to use a 64-bit quantity
  x86/msr: Switch all callers of wrmsrq_on_cpu() to use wrmsr_on_cpu()

We want something like this:

  x86/msr: Switch all callers of wrmsr_on_cpu() to use wrmsrq_on_cpu()
  x86/msr: Remove unused wrmsr_on_cpu() API

Thanks,

	Ingo
