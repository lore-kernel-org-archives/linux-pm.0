From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] cpufreq: Fix unsigned variable being checked for negative value
Date: Fri, 22 Mar 2013 00:47:04 +0100
Message-ID: <2203954.DESHeBtLnz@vostro.rjw.lan>
References: <000001ce23af$f51b0240$df5106c0$%choi@samsung.com> <CAKohponm1s9GkBML3+O1tjoiB=ZUUvj_X1yi5j3X0qk8_p8vxA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:59462 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751887Ab3CUXjp (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 21 Mar 2013 19:39:45 -0400
In-Reply-To: <CAKohponm1s9GkBML3+O1tjoiB=ZUUvj_X1yi5j3X0qk8_p8vxA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Jonghwan Choi <jhbird.choi@samsung.com>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>

On Monday, March 18, 2013 01:59:12 PM Viresh Kumar wrote:
> On 18 March 2013 13:39, Jonghwan Choi <jhbird.choi@samsung.com> wrote:
> > clk_round_rate() returns singed value which was assigned to an unsigned
> > variable.
> > So it can't be checked for negative.
> >
> > Signed-off-by: Jonghwan Choi <jhbird.choi@samsung.com>
> > ---
> >  drivers/cpufreq/cpufreq-cpu0.c |    3 ++-
> >  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied to linux-pm.git/bleeding-edge and will be moved to linux-next if
there are not build problems in the bleeding-edge branch.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
