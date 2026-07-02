Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A72E364EB7;
	Thu,  2 Jul 2026 06:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782972722; cv=none; b=dJnMmj0GFkbJwSgesIbWUo6/cNRxrwQeu5sfFQb4NxCEhkFDmrEzHPjd1hNjlb/ZjIOefMyEdb6Ve2bMhv80Fb35hMeTDCZlq0kzYpV0v3RQi2xEE3wLSdMKRP39B0O1eGRabpWbaYWlQA6EDzDOpCKkhTbj12iUP2VpuDT2LeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782972722; c=relaxed/simple;
	bh=t827TVYMXTQd8S+gp0UwPJs7oNK07I25GzDE4oq9SEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ENEAe1zuLhdvz2VI0iCW7qJYBcuf6L3ZAvJyvYcns/FsdxujAtqwRRNutA0rmc4o5Qw2wK7y5vToXVvryfkjChfSx0fPfaTexXP3uv1SNJXH50UPUxShXoS/4yhdi/aSHVEMtzCR86soU1vqj9FkINX2/ZhrYyShlH9jNmN7VOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VpztKQ6r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VpztKQ6r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2DCA1F000E9;
	Thu,  2 Jul 2026 06:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782972721;
	bh=SDkqyV677VxlMxCqb4aZiQTtd1HYljxePBmarX14wwI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VpztKQ6rEBJScZ2L41WwKNsUvbreHujp2agzLDGxegTjDwBS7lNyqG5YFrLP7KPeL
	 w5G3T8lYEVMIdwsKQeul2f/PDSeR5jHEc4s5zP/kqqH+OhNb/llb4nTEKhl9CXKxQq
	 QwBjbrkuaToFjMVqaWr1GNtH+9mKnlt0/f/SCYnrv6geEfcSpk+3Aw5ykWJVFPHgyP
	 HngJYMK5we0FlrTqut31vZrGzmGXl599DBBYy00hbQuw+GcRbV/SIrg3Kblh+HUOe9
	 SPjZKa8uWfH+BQW0Fcjsp8H3pNIkVXOsGCOq+dW3Oxb4fMKj8YYLyZchSiUthDFTmN
	 SDu5+0wNArwrQ==
Date: Thu, 2 Jul 2026 06:11:56 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Danilo Krummrich <dakr@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, driver-core@lists.linux.dev,
	tfiga@chromium.org, senozhatsky@chromium.org,
	Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v5 1/2] PM: sleep: Rename module parameters prefix to
 "pm_sleep"
Message-ID: <akYBLFzOR_6kFISP@google.com>
References: <20260701045640.3130090-1-tzungbi@kernel.org>
 <20260701045640.3130090-2-tzungbi@kernel.org>
 <2026070110-unrented-crummiest-d6af@gregkh>
 <CAJZ5v0jNq5SMtAxLb6UqUO6OrZSYKK1+AfY6CQAcym7q0GntKA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0jNq5SMtAxLb6UqUO6OrZSYKK1+AfY6CQAcym7q0GntKA@mail.gmail.com>

On Wed, Jul 01, 2026 at 01:27:04PM +0200, Rafael J. Wysocki (Intel) wrote:
> On Wed, Jul 1, 2026 at 9:20 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Wed, Jul 01, 2026 at 04:56:39AM +0000, Tzung-Bi Shih wrote:
> > > Currently, the module parameters defined in drivers/base/power/main.c
> > > use the default prefix "main" (derived from the filename).  The prefix
> > > is too generic and non-descriptive.
> > >
> > > Redefine MODULE_PARAM_PREFIX to "pm_sleep." to group the module
> > > parameters under the namespace instead.  This makes the parameters more
> > > descriptive.
> >
> > You just changed the user/kernel api, right?  That will break things...
> 
> Or not, if that part of the ABI is not really used or the users of it
> can live with the change.
> 
> This actually is an attempt to correct a mistake in the ABI and only
> one module parameter is affected by this change
> (dpm_watchdog_all_cpu_backtrace).  I'm not expecting the people using
> it to get a particular heartburn about the change.   Or if they do,
> we'll back off.

To provide a bit more context (also discussed previously in v3 [1][2]):
The `dpm_watchdog_all_cpu_backtrace` parameter is relatively new.  It was
introduced in v6.19 (Oct 2025) via commit a67818f74512 ("PM: dpm_watchdog:
add module param to backtrace all CPUs").  Because of its recent
introduction, it shouldn't have many users in the wild yet.  The flag was
originally introduced for ChromeOS [3], which doesn't actually rely on this
module parameter in its production configuration yet [4].

Given the limited known usage, this is likely the best window to correct
the prefix before it gains wider adoption.

[1] https://lore.kernel.org/all/aigPNvkxRIz36dWm@google.com
[2] https://lore.kernel.org/all/CAJZ5v0gQTx_k9j2pGha7NKxAjdPS1J_ySZNYiL1=_+_M9znQ_g@mail.gmail.com
[3] https://crrev.com/c/7414781
[4] https://crrev.com/c/7414721

> 
> I'm now thinking though that using "pm" as the new prefix might be better.

Ack, we can change it back to "pm." in the next version.
