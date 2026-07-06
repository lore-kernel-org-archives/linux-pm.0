Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93002D0C62;
	Mon,  6 Jul 2026 04:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783313046; cv=none; b=NR13qz5XJnGP3K0V5/xMlS/0Bpk4t3L/8Auu1UYGROULRil5zA0Ro1uLnMODZlyNBA67BPZutcsmgr4yyUjykhnWzgsfqU/jIGoP09cot83APBhZ4Uk9CVv9Eg/gXvJPfUADPL4H+gxhlf+cm4vjDSrGZbKKs9DQePxb62GTqdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783313046; c=relaxed/simple;
	bh=ZwUpnrJpg1mgDhyLD6RpzOzJx1X4iLpAN306MercrsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HoQskv/pCLjV+Oo1ujfxKsEfj4SbtYSjsQ2Z1f4hB1n1mAwpVyR49dMqDx04w57MP0/m1yiQpWTjLnABNey9VCiSkyZdH6lBldJS6bJk7UZMWHC/1aWdAK9NPFa9XiT1vFJ8qSulAEpiSBAJhR/nVJ4Ihyld7i9h3KCBtCbfmIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YIlGb5lc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YIlGb5lc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CF9B1F000E9;
	Mon,  6 Jul 2026 04:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783313045;
	bh=OOT0M2EZdfcJh1s1OTtAjSBdwqM3ATiateEjVn+MbJA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YIlGb5lcWfs9WNrxxDjgeDEnIvM32TfzW/2J46SP5HWl0IWz69dCPLsqCgQ4vMKLw
	 gQGvBGvpAA66sGO/oXUSUUMIbPmiH69poExMOcfwmtj65cG88sb66eoLTvdInY+eBm
	 UfBjpoCU4HwTevLARZ6rpK73b1mqr6R6jsnzb92o5S3ELbEwWhE0QKunpadQUV466J
	 jg+Fkh80I2NeDzkNwb5Wt8F/DXabPRjZMLuBnxpe7InyenbWUh78cO/hawpf9c+wuv
	 viHFuDi/3cXAHZLOFwT4SIc8X2ETpSIZTSWE0FL+lpJuyo3yjn5gXthZ490VqqTiBf
	 pnzi//0bP/DdA==
Date: Mon, 6 Jul 2026 04:44:01 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, driver-core@lists.linux.dev,
	tfiga@chromium.org, senozhatsky@chromium.org,
	Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v5 2/2] PM: dpm_watchdog: Allow disabling DPM watchdog by
 default
Message-ID: <aksykRsv33t3lUla@google.com>
References: <20260701045640.3130090-1-tzungbi@kernel.org>
 <20260701045640.3130090-3-tzungbi@kernel.org>
 <2026070140-rally-prowling-4d66@gregkh>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026070140-rally-prowling-4d66@gregkh>

On Wed, Jul 01, 2026 at 09:20:46AM +0200, Greg Kroah-Hartman wrote:
> On Wed, Jul 01, 2026 at 04:56:40AM +0000, Tzung-Bi Shih wrote:
> > diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
> > index 530c897311d4..508ceabc4d2e 100644
> > --- a/kernel/power/Kconfig
> > +++ b/kernel/power/Kconfig
> > @@ -268,6 +268,16 @@ config DPM_WATCHDOG
> >  	  captured in pstore device for inspection in subsequent
> >  	  boot session.
> >  
> > +config DPM_WATCHDOG_ENABLED
> > +	bool "Enable DPM watchdog by default"
> > +	depends on DPM_WATCHDOG
> > +	default y
> 
> Only do this if you can not boot without the option enabled, which I do
> not think is the case here.

I assume you are referring to the `default y`?

The reason for adding `default y` here is to maintain backward compatibility.
Previously, the DPM watchdog was always active if CONFIG_DPM_WATCHDOG was set.
By defaulting this new option to 'y', we ensure that the behavior remains
unchanged for existing users and defconfigs when they upgrade.

At the same time, this new option provides the flexibility for systems
(like Android GKI) that want to compile the watchdog code in, but keep it
disabled by default.
