Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC3421773D;
	Mon, 13 Jul 2026 13:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783948998; cv=none; b=MUMq6UFOSHRSAOkWbiHuoCzWJAz+pYiIRTY4GbN+I5r077gMAEpxPB6TT34J9m3zF9a5chdxNeGcRiZ1drCgdHiPrJo42bT5uQGGIrkbn7yiOPepoTa6VedLz/v7vk3BKb0SPunWlo8UszBEDFoKf8RonfB+9/JpBUEvmDu3yE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783948998; c=relaxed/simple;
	bh=g7+2c+xJvjqLoo0NzPoUiZSfb1LEQnIH28B8wd2ULzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qook+4Zy4+csEq9iqtPaXeG9kLdojyvS067Lo+HQIU7MJ2d6Gcqpnm5135nmp6geJUZ9V59okQ6oaqW+ZZDenRMSY1yKjBRCe3OI0caXVbAvEED5UNiO0FKZlfOMZs+3rCyo4EKJDhAHplhICSPoDGMCQAzeHi/SwWxtJAr3MvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W/mJRSb0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W/mJRSb0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85D6D1F000E9;
	Mon, 13 Jul 2026 13:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783948997;
	bh=bsmArhZQ4H29hAxDbVOATQfLGMaMjwwSPHkxmSwY3Tg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=W/mJRSb0N1jnLxakMNiTFuq8EhgN6fHthfqO0hM284B4MuQ5XNAcdUm7VOzQgWVrh
	 nWWinKRAe1MKg/pFgyy7FRnqJ3LC0Wc32WisPNsKT/PCKvn+0kvUUgGL4iMpP7o0k4
	 7y6ZbLF2sKMWnoashR6qtWKTvHhx8sW8NDypBkRpvpf5ApUhiDhAC7pG/UNoOLuSXr
	 PnGupmIuwkDpYGugO4uGdvxRWXILnAohAI76Ft9fkdxMLtiJFb4g5RxUf88XlhYb6V
	 cSvPnkQ6CPgjsL3+Y8i7ByIAFylPRR1x7bkYcZ5nMy04gs5hDBtb7YiM2weKzgEEP/
	 huysBDOEfJVrg==
Date: Mon, 13 Jul 2026 14:23:14 +0100
From: Sudeep Holla <sudeep.holla@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Linux ACPI <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v1 11/17] ACPI: processor: idle: Rework
 flatten_lpi_states()
Message-ID: <20260713-tall-precise-whale-93edc7@sudeepholla>
References: <4746278.LvFx2qVVIh@rafael.j.wysocki>
 <2064627.usQuhbGJ8B@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2064627.usQuhbGJ8B@rafael.j.wysocki>

On Thu, Jul 09, 2026 at 02:39:06PM +0200, Rafael J. Wysocki wrote:
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> 
> Rewrite flatten_lpi_states() to make it easier to follow:
> 
>  * Rename its flat_state_cnt, curr_level and prev_level parameters to
>    state_count, curr, and prev, respectively, so their names match the
>    names of analogous variables in acpi_processor_get_lpi_info().
> 
>  * Eliminate a redundant local variable state_count.
> 
>  * Move definitions of local variables to the code blocks in which
>    they are used.
> 
>  * Reduce the indentation level in the inner loop.
> 
>  * Use more meaningful names for local variables.
> 
>  * Move two statements that belong in acpi_processor_get_lpi_info()
>    from flatten_lpi_states() to that function.
> 
>  * Use acpi_handle_info() for printing a message when the count of
>    flattened states gets too large and drop the message requesting
>    ACPI_PROCESSOR_MAX_POWER to be adjusted which is pointless.
> 
>  * Add a comment explaining what happens in that function.
> 

Nice refactoring, thanks for doing this. It is much simpler to follow.

> No intentional functional impact beyond the message printed when
> the count of flattened states is too large.
> 

Reviewed-by: Sudeep Holla <sudeep.holla@kernel.org>

-- 
Regards,
Sudeep
