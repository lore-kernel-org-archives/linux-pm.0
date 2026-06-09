Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38AE8380FD9;
	Tue,  9 Jun 2026 09:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780995781; cv=none; b=tk8ik5+eg1a+eGoQpJHLb6AbOX6c3v1ViUM6nV2LBrh69Rx7vzDpFgS5KoAVJ6xXBR6cQ738+fyQo5gEVuWUgzPo69Rxeuk4Vh24yG+QBdti61QB+1cUuJsRklWVXQXmcmQdK8/Juvl98F4cp339OgV6SNiub9pMFRi1JuwWXRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780995781; c=relaxed/simple;
	bh=nzW/fYmXXduoB5FimRJhLcKJ44jgrPMntIElE8ZQw3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=prvxkZKLZuVeLZK38EicQZDa1vCDEKELpGZ85nwkS58cWnEJx7zK+xH1hR6nmjUbxg7Bk8FX9YJDgWc/aLAHmfvvchVoefkCA1ZZowi84AyDkzOEtjgPqX8ja2i/I0x2kcjYvI/9McCOoECffjGYMprqhW/BeHgJPy5/R7iGc/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MDXynhtj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MDXynhtj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E61351F00893;
	Tue,  9 Jun 2026 09:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780995780;
	bh=N6keFIsZGhVHySVfSf+d5aXN2gpVIfICU7yfTQ8ojms=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MDXynhtjN/ur94BZZn53kQhVt9PTbPyq9iyXmUDnQ76Yby8Av2FqGz3WMEv8XjFBQ
	 t/3SOeAWdLsjhe5G94fgu4GQjDOl5jgR0jgdAnI2XjbpF62Ys9kXP465pCYQ/p4czy
	 6yAVThbP4CktKpCUoNYrjPrmEaiNIjo2HZbdDSKBI7F1jNCIYU3FggXXnDpFq/hD2g
	 nKI7c69CftQi1yDyawRgffYHJz9PTqvoSA0SjGoBmGes0crJDqtWli1IhdXaukaO1T
	 koORv4RCpVXosLeIoYX5sq/6emu0aJCTlFe1odrQHwODp67nmROy9ws8bJwbY+7joX
	 z1tDZpCxJePlQ==
Date: Tue, 9 Jun 2026 09:02:56 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, driver-core@lists.linux.dev,
	tfiga@chromium.org, senozhatsky@chromium.org,
	Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v3 1/3] PM: core: Rename module parameters prefix to
 "power"
Message-ID: <aifWwEyHuFejW4ac@google.com>
References: <20260608021526.1023248-1-tzungbi@kernel.org>
 <20260608021526.1023248-2-tzungbi@kernel.org>
 <CAJZ5v0jy75R24NztKJ0w4NMyRB7G+DcsC+gaQ0xZOQMfTfA5Ww@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0jy75R24NztKJ0w4NMyRB7G+DcsC+gaQ0xZOQMfTfA5Ww@mail.gmail.com>

On Mon, Jun 08, 2026 at 04:11:30PM +0200, Rafael J. Wysocki wrote:
> On Mon, Jun 8, 2026 at 4:16 AM Tzung-Bi Shih <tzungbi@kernel.org> wrote:
> >
> > Currently, the module parameters defined in drivers/base/power/main.c
> > use the default prefix "main" (derived from the filename).  The prefix
> > "main" is too generic and non-descriptive for power management
> > parameters.
> >
> > Redefine MODULE_PARAM_PREFIX to "power." at the beginning of the file
> > to group the module parameters under the "power" namespace instead.
> > This makes the parameters more descriptive.
> >
> > Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
> > ---
> > v3:
> > - No changes.
> >
> > v2: https://lore.kernel.org/all/20260604090756.2884671-2-tzungbi@kernel.org
> > - New to the series.
> >
> > v1: Doesn't exist.
> >
> >  drivers/base/power/main.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> > index ed48c292f575..cd864f3a2799 100644
> > --- a/drivers/base/power/main.c
> > +++ b/drivers/base/power/main.c
> > @@ -40,6 +40,9 @@
> >  #include "../base.h"
> >  #include "power.h"
> >
> > +#undef MODULE_PARAM_PREFIX
> > +#define MODULE_PARAM_PREFIX "power."
> 
> "power" may be confused with the power supply support, so I'd rather
> use "pm" or even "pm_sleep" (in which case the "dpm_" prefix could be
> dropped from the new module param name in the next patch).

Ack, will use "pm_sleep" in the next version.

Regarding dropping the "dpm_" prefix, should this also apply to the existing
dpm_watchdog_all_cpu_backtrace parameter?  Or should we leave it as-is to
avoid breaking existing configurations?
