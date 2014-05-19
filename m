From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PM / OPP: Make OPP invisible to users in Kconfig
Date: Tue, 20 May 2014 01:19:45 +0200
Message-ID: <2738394.FHGFLADJqP@vostro.rjw.lan>
References: <1399659488-13974-1-git-send-email-broonie@kernel.org> <CAKohpo=xtnHyWcjHxmSPgzdovMshgotMkQj6Y__R9UvzzfTyHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:53664 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751117AbaESXCu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 19 May 2014 19:02:50 -0400
In-Reply-To: <CAKohpo=xtnHyWcjHxmSPgzdovMshgotMkQj6Y__R9UvzzfTyHw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Mark Brown <broonie@kernel.org>, Nishanth Menon <menon.nishanth@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Mark Brown <broonie@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Monday, May 12, 2014 09:40:46 AM Viresh Kumar wrote:
> On 9 May 2014 23:48, Mark Brown <broonie@kernel.org> wrote:
> > From: Mark Brown <broonie@linaro.org>
> >
> > The OPP code is an in kernel library selected by its users, there is no
> > no architecture code required to implement it and enabling it without a
> 
> s/no no/no
> 
> > user just increases the kernel size. Since the users select rather than
> > depend on it just remove the ability to directly set the option from
> > Kconfig.
> >
> > Signed-off-by: Mark Brown <broonie@linaro.org>
> > ---
> >
> > This leaves the ARCH_HAS_OPP symbol since removing that requires
> > updating the relevant architectures, if this is OK I can sumbit a
> > followup patch cleaning that up.
> >
> >  kernel/power/Kconfig | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Queued up for 3.16, thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
