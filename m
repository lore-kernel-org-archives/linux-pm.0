Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59EE13B0AE9;
	Wed, 15 Jul 2026 03:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784086720; cv=none; b=cQl1ksX83dz8OY3/koS/MkUtklX141bk1yYCPNEwMUNxy2q6fbhModVDXYkHVACcvn2oJ4FWN3R8LyMHF9O0/KzVw2sVaNGoIDQ6xdR4iXSvwCcPyRPICdDR1mUowrtuVyh6Xa74CBp32APh/JL6O7XpAjYzRIQTqe4I8+h2cFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784086720; c=relaxed/simple;
	bh=TqsCUluC18meCS4YmKRlVVSyC/XfelGm2jVOFMs+an4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sdYVBDFfcDe8GPfBXQ7ltlXR322NPKwr8Nj2bs4nA2VhvVirgMtmy9TOePioYriTWC+JicAmNsVFWzhg+FYMP+kt5aD3sMELbYU71I4C/SuB0WfY4S9yLn9/mOUFav6s4hiBsLjCo/Sn7zQrRUm8Ls3W9+nK7b17nQc8vtKk4zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eruO3s3I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eruO3s3I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD84B1F000E9;
	Wed, 15 Jul 2026 03:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784086702;
	bh=vHSwHOAnKKuCtTdxbnWKpynBVvQ0SGMVv3laL9+whDE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eruO3s3Ia3FxGRpWUJqw/aKt5Qhq7a0O046iUoSmkf1egqujCkkOWNDt3aYiSPlQb
	 GRDCxpJ6ZH+/Kc9SDxgkO2xmW7O44Munp3NFCNPx2T8kmmeUcMtIf/cnra68Br0Wek
	 NYY0VFr2jWqDavQt4gJW95uhx3OJunvf4uIS7BHRSQjq3TJeKaxkQuEajo18e/3IMr
	 gpjtHfTnsuziuPwqKrGAGzh2tFpPkso1YDrZFuMYdshOmRTxD6pXHFpW4b22uI+VHI
	 GsZDmktjePxVBET+rOtQnQGMuswodqwJk0vRXfrAClVvi8KFXjSFVQOTTIbX7FdbP4
	 k1LtASxpyXjYg==
Date: Wed, 15 Jul 2026 03:38:17 +0000
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
Subject: Re: [PATCH v6 0/2] PM: dpm_watchdog: Improve DPM watchdog
 configurability
Message-ID: <alcAqfM9mgAVXVWD@google.com>
References: <20260708043317.2980098-1-tzungbi@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260708043317.2980098-1-tzungbi@kernel.org>

On Wed, Jul 08, 2026 at 04:33:15AM +0000, Tzung-Bi Shih wrote:
> This series improves the configurability of the DPM watchdog.
> 
> Currently, the DPM watchdog is always enabled if compiled in.  Also, the
> module parameters defined in drivers/base/power/main.c use the generic
> and non-descriptive "main" prefix.
> 
> This series addresses these limitations.
> 
> Patch 1 renames the module parameter prefix for
> drivers/base/power/main.c from "main" to "pm".
> 
> Patch 2 introduces the "dpm_watchdog_enabled" module parameter to allow
> enabling/disabling the watchdog at boot time and runtime.  It also adds
> CONFIG_DPM_WATCHDOG_ENABLED to set the default value of the module
> parameter at compile time.
> 
> The primary motivation for this configurability revolves around Android
> GKI (Generic Kernel Image).  We want to enable CONFIG_DPM_WATCHDOG in
> the GKI so the feature is available.  However, because the GKI is shared
> across many different devices, we don't want to inadvertently affect
> devices that are unaware of this feature.  This provides a way to
> compile it in, but keep it disabled by default for those devices via the
> kernel command line or module parameters.
> 
> To maintain backward compatibility, CONFIG_DPM_WATCHDOG_ENABLED relies
> on `default y`.  Previously, the DPM watchdog was always active if
> CONFIG_DPM_WATCHDOG was set.  Defaulting this new option to 'y' ensures
> that the behavior remains unchanged for existing users and defconfigs
> when they upgrade.
> ---
> v6:
> - Change the prefix "pm_sleep" -> "pm".
> 
> v5: https://lore.kernel.org/all/20260701045640.3130090-1-tzungbi@kernel.org
> - Rebase to v7.2-rc1.
> - Fix Signed-off-by lines.

Since there was no further feedback on v5, I'm sending out v6.  Any feedback
would be appreciated.
