From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] PM / Domains: Change prototype for the ->attach_dev()
 callback
Date: Tue, 4 Nov 2014 17:33:53 -0800
Message-ID: <20141105013353.GA19238@dtor-ws>
References: <1414670569-3002-1-git-send-email-ulf.hansson@linaro.org>
 <3981560.mBph1QJkfl@vostro.rjw.lan>
 <7h4mul9ttl.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ig0-f177.google.com ([209.85.213.177]:61194 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752809AbaKEBd7 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 4 Nov 2014 20:33:59 -0500
Content-Disposition: inline
In-Reply-To: <7h4mul9ttl.fsf@deeprootsystems.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kevin Hilman <khilman@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ulf Hansson <ulf.hansson@linaro.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tomasz Figa <tomasz.figa@gmail.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Philipp Zabel <philipp.zabel@gmail.com>, Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Russell King <linux@arm.linux.org.uk>, Jack Dai <jack.dai@rock-chips.com>, Jinkun Hong <jinkun.hong@rock-chips.com>, Aaron Lu <aaron.lu@intel.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>

On Thu, Oct 30, 2014 at 01:38:30PM -0700, Kevin Hilman wrote:
> "Rafael J. Wysocki" <rjw@rjwysocki.net> writes:
> 
> > On Thursday, October 30, 2014 01:02:49 PM Ulf Hansson wrote:
> >> Convert the prototype to return and int. This is just an initial step,
> >> needed to support error handling.
> >> 
> >> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> 
> Acked-by: Kevin Hilman <khilman@linaro.org>
> 
> >> 
> >> This patch is intended as fix for 3.18 rc[n]. Why?
> >> 
> >> There are other SOC specific patches around that adds genpd support and which
> >> implements the ->attach_dev() callback. To prevent having an "atomic" patch
> >> during the next release cycle, let's change the prototype now instead.
> >> 
> >> Further patches will add the actual error handling in genpd and these can then
> >> be reviewed and tested thoroughly.
> >
> > So we have no users of ->attach_dev at the moment, right?
> 
> Not in mainline, but there are a couple getting ready to hit -next, so
> we wanted to fix this before they arrive so that adding the error
> handling will be easier.

BTW, while we are at it, can we also pass the domain itself to
attach_dev() and detach_dev()? If anything it helps with debugging (you
can print domain name from the callbacks).

Thanks.

-- 
Dmitry
