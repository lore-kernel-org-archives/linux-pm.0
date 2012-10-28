From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH 0/8] clk: ux500: Fixup smp_twd clk for clk notifiers
Date: Sun, 28 Oct 2012 23:59:18 +0100
Message-ID: <20121028225918.GC5411@sortiz-mobl>
References: <1349869349-8070-1-git-send-email-ulf.hansson@stericsson.com>
 <20121011134458.GB15428@gmail.com>
 <CACRpkdYEukMzMX1Q8nb5zKPMZEZfttzWVC24aOkv2g8SCQtTnQ@mail.gmail.com>
 <20121011151947.GD15428@gmail.com>
 <CAPDyKFof65xAVyOo3FrdS2uYQwB1Wq3553PKj04FR6JXaJsH6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:22212 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751145Ab2J1W7X (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 28 Oct 2012 18:59:23 -0400
Content-Disposition: inline
In-Reply-To: <CAPDyKFof65xAVyOo3FrdS2uYQwB1Wq3553PKj04FR6JXaJsH6Q@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Ulf Hansson <ulf.hansson@stericsson.com>, linux-arm-kernel@lists.infradead.org, Mike Turquette <mturquette@ti.com>, Mike Turquette <mturquette@linaro.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Philippe Begnic <philippe.begnic@st.com>, Rickard Andersson <rickard.andersson@stericsson.com>, Jonas Aberg <jonas.aberg@stericsson.com>, Vincent Guittot <vincent.guittot@linaro.org>

Hi Ulf,

On Fri, Oct 26, 2012 at 10:19:24AM +0200, Ulf Hansson wrote:
> On 11 October 2012 17:19, Lee Jones <lee.jones@linaro.org> wrote:
> > On Thu, 11 Oct 2012, Linus Walleij wrote:
> >
> >> On Thu, Oct 11, 2012 at 3:44 PM, Lee Jones <lee.jones@linaro.org> =
wrote:
> >>
> >> >> Patches are based on Linus Torvalds tree with latest commit as =
of okt 10.
> >> >
> >> > Hmm... I get:
> >> >
> >> > Applying: clk: ux500: Support for prcmu_scalable_rate clock
> >> > error: drivers/clk/ux500/clk-prcmu.c: does not exist in index
> >> > error: drivers/clk/ux500/clk.h: does not exist in index
> >> > Patch failed at 0001 clk: ux500: Support for prcmu_scalable_rate=
 clock
> >> >
> >> > So when did drivers/clk/ux500/* arrive?
> >>
> >> Exactly here, 10 days ago on Torvalds' master branch:
> >
> > Ah I see. Basing patches on commits half way through the merge
> > window. Good move! ;)
> >
> > --
> > Lee Jones
> > Linaro ST-Ericsson Landing Team Lead
> > Linaro.org =E2=94=82 Open source software for ARM SoCs
> > Follow Linaro: Facebook | Twitter | Blog
>=20
> Samuel, a kind reminder on this, trying to collect acks to be able to
> advise Mike to take this series through his clk tree. There are two
> mfd patches.
> [PATCH 2/8] mfd: db8500: Provide cpufreq table as platform data
> [PATCH 5/8] mfd: db8500: Connect ARMSS clk to ARM OPP
Sorry for the delay:

Acked-by: Samuel Ortiz <sameo@linux.intel.com>

Cheers,
Samuel.

--=20
Intel Open Source Technology Centre
http://oss.intel.com/
