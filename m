Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6CB2264A3
	for <linux-pm@vger.kernel.org>; Thu,  5 Feb 2026 05:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770269772; cv=none; b=VB7jEuwLFTLKuTdlXrx+98BXgGjg9ab33wP58nWaD8DpzozQqkCYRYfDn3mbQB/iwtUNo0SJyZlvOxQLQs8R5+uHdI1wDHjcuR0BT6pgbMXNnkO4wOF5vqx07RVzBObWdC2JB9FEdBYGsCsdZVQsLoSCHXP2/I0lZy4KfUcT0xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770269772; c=relaxed/simple;
	bh=c/2v7icKPFyeTOkKWCFw3lN/zTG8b96T0vy+Y4haNTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q2O7d9peaTyyusdfESroUy/0IAqnrxgQBdjF9cXuQFPSevQ2SJCIjEl6MHSRxM2Hn4WYDYeTVjt4nPkIHs4Kh3aN/1CM+rHEGYVTFmU5FJXc3GZ1oTJWIoh/xqMdbaGx+1UCc8n2zgvtU5p2wrfsxf7fcGRFVqRL1yBLpynlRQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AYOzcznI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AYOzcznI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5227C4CEF7;
	Thu,  5 Feb 2026 05:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770269771;
	bh=c/2v7icKPFyeTOkKWCFw3lN/zTG8b96T0vy+Y4haNTY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AYOzcznI0ar7+PpBlPxNIGtGxhS6l0E3jyewZKJ7tVpIvSz/8nOWTwJXzgTtK/okG
	 6DFKS6Hz0kDhwE4HRN4neDQzwLylcz5MuBZpFMzXX7KyPc1VWLlNMUHwZj8dc+bXvy
	 vZWEpCMXq8d0da4l0diMNKs78cNZbJ8S+iYLypE927EZwwnj/hZOuHCZ5nArOqklSw
	 ptAMQbjMRnM6tov7+VgqWYJnDJgvCrETcGM+JtFOdqKpOjcdqI0aL2xag0cFfJLqGh
	 TKubUdouvTDAlD7Z7X0pM21uGbBisbpVyVwn3oAARXjapw09SWKK+uN7vBt40KO28J
	 L84dKwB/8KwyQ==
Date: Thu, 5 Feb 2026 05:36:08 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-pm@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2] pmdomain: mediatek: Break lock dependency to
 `prepare_lock`
Message-ID: <aYQsSPQdx-DOzSSh@google.com>
References: <20251231035357.1147578-1-tzungbi@kernel.org>
 <CAGXv+5Fm7DFkZ_JONhHN4467=oVhuw-e1XtXuD53qBQDWd7cNw@mail.gmail.com>
 <CAPDyKFrqqXYy_Y-7WA=5taBhE4rcYX+Uz_RnGpOtD-AF3eipVQ@mail.gmail.com>
 <aXxpG3hEVVjuWInc@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aXxpG3hEVVjuWInc@google.com>

On Fri, Jan 30, 2026 at 08:17:34AM +0000, Tzung-Bi Shih wrote:
> On Tue, Jan 27, 2026 at 02:57:46PM +0100, Ulf Hansson wrote:
> > On Thu, 22 Jan 2026 at 09:38, Chen-Yu Tsai <wenst@chromium.org> wrote:
> > > On Wed, Dec 31, 2025 at 11:54 AM Tzung-Bi Shih <tzungbi@kernel.org> wrote:
> > > > @@ -398,7 +398,7 @@ static int scpsys_hwv_power_off(struct generic_pm_domain *genpd)
> > > >                         return ret;
> > > >         }
> > > >
> > > > -       ret = clk_bulk_prepare_enable(pd->num_subsys_clks, pd->subsys_clks);
> > > > +       ret = clk_bulk_enable(pd->num_subsys_clks, pd->subsys_clks);
> > 
> > scpsys_hwv_power_off() is typically called by genpd in the suspend
> > noirq() phase, when all devices attached to the genpd in question have
> > been suspended too. See genpd_suspend_noirq().
> > 
> > This means that scpsys_suspend() (below) may be called to unprepare
> > the clock, before scpsys_hwv_power_off() may call clk_disable(). This
> > is a bug according to the clock framework.
> 
> Ack, I observed a similar warning in a system suspend/resume cycle.
> 
> > 
> > Moving scpsys_suspend() to the noirq phase too could maybe work.
> 
> No, I guess it doesn't work as .prepare() can sleep however noirq phase
> shouldn't/can't.
> 
> > Although, perhaps an even simpler solution would be to do the
> > clk_prepare() during ->probe() and clk_unprepare() during ->remove()
> > (and error path in probe). Of course, this assumes that
> > clk_prepare/unprepare doesn't really do anything hardware wise, so we
> > don't start wasting power by keeping the clocks prepared.
> 
> It turns out a pure revert of f0fce06e345d ("soc: mtk-pm-domains: Fix
> the clock prepared issue").  Per the commit message of f0fce06e345d,
> the concern is some PLLs keep prepared even if the system is suspended.
> 
> Not sure should we take the compromise?

Please ignore the patch.  The observed paths are two independent power
domains.  Distinguishing them by setting different lock class key fixes
the lockdep warning as Chen-Yu suggested in [1].

[1] https://lore.kernel.org/all/CAGXv+5Fm7DFkZ_JONhHN4467=oVhuw-e1XtXuD53qBQDWd7cNw@mail.gmail.com/
