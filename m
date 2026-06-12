Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524FB1F5842;
	Fri, 12 Jun 2026 08:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781253969; cv=none; b=BOaBu+lDQ4KxQhMZ+BSYhBSJ2XBhwJxBSHdP22Pe0W0yDx5c+xlFFUM+An8rF+ip//XAA9Y9XKJdAEwU+DVEQ9KSWff+c1FiKyVAbUWk866qLL7r6NJir72dWL4sQdyzqUpt8HghpGNHFeeQlywI1DycbXMCEZegJ6TY4LHeFMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781253969; c=relaxed/simple;
	bh=G56EkkcKXDt2rgsTJTI96ertJkK1Ij5wSIzgy9PR6kg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LNvKVkSXRsjorBfsxKNJERAW1jkph9bqJU2xd+HiNS0ktbza792D0JIwM7skqJOzDzohwcexM7O+4elDw4IlacfWX1bhf9HqiZgJAAte9iXXcYQKt8aSbaGF/gq8wBVBnOIxwNYRN/muNNGThNcYgpHFKcp/2BZ09kIrBYvaZDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YZqUA8Jr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YZqUA8Jr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5E771F000E9;
	Fri, 12 Jun 2026 08:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781253967;
	bh=cLTDsfGmp4G6pyXvmILSR/PqkNU6P6jWgh91yvB1qAA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YZqUA8JrD6gizShnV9dlqJA9dvaN99VR9Dyyycqj37uhUrDnLvix5ZQUETz7/YFAe
	 VKMzBOQFi2wcA2y3XPnPqiOTGOnlPHYLaLVjiC9ZgBz+EQRqgO9ryGUaRwTtxzsvx3
	 bFHAOznJqMYE8x1Xj7pSUH/gidGcN6a4alYITccay6uGXTlGHnmMulv1/E7Y7EuMvO
	 a9Mzwrigd/jhxT61k/KSxMug9q1T4z0qTOV7QGhArRXo/euskCCLWrPBfGWNcqiWbq
	 y5xcJo1tL0ICNFosOQ/RuKTNQ8Ef4ogUHh+1uaG6/OJQRSlGagVuV0Y3JbmldCdUYa
	 3vhn/lK5kDOCw==
Received: from johan by xi.lan with local (Exim 4.99.3)
	(envelope-from <johan@kernel.org>)
	id 1wXxWf-000000029eQ-2CMc;
	Fri, 12 Jun 2026 10:46:05 +0200
Date: Fri, 12 Jun 2026 10:46:05 +0200
From: Johan Hovold <johan@kernel.org>
To: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Cc: Ulf Hansson <ulfh@kernel.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] pmdomains: fix unused variable warning with
 !PM_GENERIC_DOMAINS_OF
Message-ID: <aivHTaVZXi38V5zo@hovoldconsulting.com>
References: <20260611120345.484283-1-johan@kernel.org>
 <CAPx+jO_8hAv+DR-=Nk9_DD_9kSQFVKfHwf9bZABvooVFuQN2_A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPx+jO_8hAv+DR-=Nk9_DD_9kSQFVKfHwf9bZABvooVFuQN2_A@mail.gmail.com>

On Thu, Jun 11, 2026 at 04:07:29PM +0200, Ulf Hansson wrote:
> On Thu, Jun 11, 2026 at 2:04 PM Johan Hovold <johan@kernel.org> wrote:
> >
> > The genpd provider bus is really only used when
> > CONFIG_PM_GENERIC_DOMAINS_OF is enabled, and since the recent deferred
> > initialisation of domain parent devices, the root device pointer is
> > otherwise unused.
> >
> > Fix the unused variable warning by moving the definition of the root
> > device pointer inside the corresponding ifdef.
> >
> > Fixes: ea1ca7623281 ("pmdomain: fix early domain registration")
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202606111746.kAxaAbwg-lkp@intel.com/
> > Signed-off-by: Johan Hovold <johan@kernel.org>
> 
> Applied for next, thanks!

Note that a stray 's' managed to sneak into the summary prefix
("pmdomains"). Just wanted to mention it while the commit is still HEAD
in case you want to fix it up.

Johan
