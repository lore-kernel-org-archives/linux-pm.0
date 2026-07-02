Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4713147B41C;
	Thu,  2 Jul 2026 09:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782984707; cv=none; b=fvHzeSbPb9Y1PWJpTh7qgN63SIrhqun2UcdT/OwdSgnXC95P2gyEfQF215BYsM1b7AiSIIiz3FVMwRaT1CnRjT5ebmDhFxusi/b9KuRjSxTZl2UC8C3wtjfeKHMZZwJqBVZqwsSbWBxmwuTKj5RfgXDyg5kC4XbmzqHfuczB0Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782984707; c=relaxed/simple;
	bh=oZImZ5yVCg5/oBwPdd4McTggkHMzw/oicmCxa+Swgic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H3BySEDjj+HdWwXr75fMsbbpPDq07FhWnDW1OdBUkCyAIBSKdOndjiGhd0jJ33ZWjy3Mc7Zk+MIBUT9cnL30bo5vBoHb52ik7YK4bA0XbpUXz7lwt0WfsfAl6flqkGf4sICTwv/6xkmhFstxSFrjH/CSI4FZxizqpknr8FgWVIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MeNKj54K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MeNKj54K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B0951F00A3A;
	Thu,  2 Jul 2026 09:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782984705;
	bh=2qI0JBu5kxrh8RKwGL+NunSzEmUIMLwAFs/rB1859ic=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MeNKj54KocQW4BjZvCsdj1BLLjOFqfmHlU0oesaWf2ollfu28mQ381n9K9OVrz2Er
	 oizch54VVifdP5DHnRoWPifBna3onJ/XxMqHEDM/kbZLLrGTGrF1gg1mMzpw/N59XN
	 DPmrJTS7lr/5zQcL8p8GId0N8ID7usj2iTHTcVvPs+EQiQir4uZx3mZc/L+rgjjbzD
	 jhKrUxFFrtRODBtWvUDkHrK6p/LCwbPMh+3EjhTNvRKTOUXcBg7MHaYgbW0HRx1Icm
	 h65Xv7QfsvWMEoemCWuz4sHfddwLpIozMBVBhicN8Ubk80k9lVBbxhz9KB5R5EynmK
	 UGGxkzuxKUTHQ==
Date: Thu, 2 Jul 2026 11:31:41 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Juergen Gross <jgross@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>
Subject: Re: [PATCH 01/32] thermal/intel: Stop using 32-bit MSR interfaces
Message-ID: <akYv_fhsLpTt15FI@gmail.com>
References: <20260629060526.3638272-1-jgross@suse.com>
 <20260629060526.3638272-2-jgross@suse.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629060526.3638272-2-jgross@suse.com>


* Juergen Gross <jgross@suse.com> wrote:

> -	rdmsr(MSR_IA32_THERM_INTERRUPT, l, h);
> +	rdmsrq(MSR_IA32_THERM_INTERRUPT, val.q);
>  	if (cpu_has(c, X86_FEATURE_PLN) && !int_pln_enable)
> -		wrmsr(MSR_IA32_THERM_INTERRUPT,
> -			(l | (THERM_INT_LOW_ENABLE
> -			| THERM_INT_HIGH_ENABLE)) & ~THERM_INT_PLN_ENABLE, h);
> +		val.l = (val.l | THERM_INT_LOW_ENABLE | THERM_INT_HIGH_ENABLE) &
> +			~THERM_INT_PLN_ENABLE;

This could be written as something like:

		val.l |= THERM_INT_LOW_ENABLE | THERM_INT_HIGH_ENABLE;
		val.l &= ~THERM_INT_PLN_ENABLE;

Which would be far more readable than the multi-line statement.

> +			val.l = (val.l | PACKAGE_THERM_INT_LOW_ENABLE |
> +				 PACKAGE_THERM_INT_HIGH_ENABLE) &
> +				~PACKAGE_THERM_INT_PLN_ENABLE;

Ditto.

Thanks,

	Ingo
