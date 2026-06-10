Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C20F3C1095;
	Wed, 10 Jun 2026 09:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781082943; cv=none; b=nTaMwu3xyIE00BEez03LksjUUcGK78dK8R4fGpDaNtrbF98GCuV1/VxPpnjSDhjGtMO67jCwwfgFd4gMzkdu76SsLTIQR2pdmxwf10QM1mf/ZuziEqdzgw7OQk7zN2Td8/mkRuoCbUYVolgP446BWulIE3zm30l3/oAD8E+nWvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781082943; c=relaxed/simple;
	bh=L38tgxPDUQXcdEIyRwYhL/qEe81H4OfoVt8OWmStO9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mM5R+rWbW3I2Jru7M5Lu0rsnN+szz9dcQW4+o1Hz+gwzdZbJXdOqBNVViX29Dt2t6f2Vrdag9Hzuwx8CfjzYK1m3qTqM/VA73P8MMiUXX5Za2RJN9hnoImaeifXhzYTkWdfwONVpAQ1AuT9DwPipUFGf5kWtZo2H0ztW35bD7/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iyGwz0r1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iyGwz0r1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6A9E1F00893;
	Wed, 10 Jun 2026 09:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781082940;
	bh=C0vl5TJpcw3Ui0Woxlxux5sx4pqB6JE0fxuoKb0gAPE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iyGwz0r1982KDeY3mTAnisCvcy4R+JomnnCn0rqpZFfT0LNHr+q0vSysNB9DFfd+j
	 3KDvR4nXgdSsRVHVp7XmKQh+bSfk1Yg+VwlPYTxpLO6oY3SdkE4HZ/XAE8eCLDMIEG
	 iPHyGyokwagh8cP8XRLOCfx6F0yS9io2enVGHy7wq2RK8ZS2/K5MO35Eg0z+KL5uuP
	 aaHWED3qmT3mDCeTgLIur39fZuNB/oyKckhdjrpC+jHj1pjiu6TQ3iFK1J8EMBDTJW
	 7lQLhzThoPphxwyhA/00BnryIMkvNTYq9lDpvsTP2YNwZNE4dI7vZIeNKdNVOO9M9K
	 drf6T33i8eNnQ==
Received: from johan by xi.lan with local (Exim 4.99.3)
	(envelope-from <johan@kernel.org>)
	id 1wXF2A-00000001MN9-3aVc;
	Wed, 10 Jun 2026 11:15:38 +0200
Date: Wed, 10 Jun 2026 11:15:38 +0200
From: Johan Hovold <johan@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Ulf Hansson <ulfh@kernel.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pmdomain: fix early domain registration
Message-ID: <aikrOnglQEmn54sF@hovoldconsulting.com>
References: <20260609160634.246526-1-johan@kernel.org>
 <CAMuHMdVyRq7fT_m_gWtVKkkaTZQvSUvkMamQHb44x+Ed0jNbMQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdVyRq7fT_m_gWtVKkkaTZQvSUvkMamQHb44x+Ed0jNbMQ@mail.gmail.com>

On Wed, Jun 10, 2026 at 11:12:19AM +0200, Geert Uytterhoeven wrote:

> On Tue, 9 Jun 2026 at 18:07, Johan Hovold <johan@kernel.org> wrote:
> > A recent change switching to a dynamically allocated root device broke
> > platforms like rcar-sysc that registers PM domains before the PM domain
> > bus itself has been registered (cf. commit c5ae5a0c6112 ("pmdomain:
> > renesas: rcar-sysc: Add genpd OF provider at postcore_initcall")).
> >
> > Defer the assignment of the parent root device until the domain is
> > registered with driver core to avoid it being left unset.
> 
> Thanks for your patch!
> 
> > Fixes: a96e40f4afdc ("pmdomain: core: switch to dynamic root device")
> > Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > Link: https://lore.kernel.org/r/CAMuHMdUHabMGJyJ7e7yp7DLC+JJc9k6NK9p4anj2wRKNuwZUng@mail.gmail.com
> 
> s/Link/Closes/

I use use Link: on purpose (like Linus does).

> > Signed-off-by: Johan Hovold <johan@kernel.org>
> 
> This fixes the issue on R-Car H1, M2-W, H3 ES2.0, and on RZ/A1H.
> No regressions seen on SH-Mobile AG5, R-Mobile A1, and R-Car V4M.
> 
> Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks for confirming.

Johan
