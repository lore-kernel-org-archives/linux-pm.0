From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2] PM / OPP: Fix parsing of opp-microvolt and opp-microamp properties
Date: Sun, 03 Jan 2016 01:58:54 +0100
Message-ID: <6184082.s696CKn4PL@vostro.rjw.lan>
References: <1471955.ORlHo2b56O@amdc1976> <20151218015135.GD28277@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:63840 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751056AbcACA2S (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 2 Jan 2016 19:28:18 -0500
In-Reply-To: <20151218015135.GD28277@ubuntu>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Lee Jones <lee.jones@linaro.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Stephen Boyd <sboyd@codeaurora.org>, nm@ti.com, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Dmitry Torokhov <dtor@chromium.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, Shawn Guo <shawnguo@kernel.org>, linux-samsung-soc@vger.kernel.org

On Friday, December 18, 2015 07:21:35 AM Viresh Kumar wrote:
> On 17-12-15, 19:04, Bartlomiej Zolnierkiewicz wrote:
> > Commit 01fb4d3c39d3 ("PM / OPP: Parse 'opp-<prop>-<name>'
> > bindings") broke support for parsing standard opp-microvolt and
> > opp-microamp properties.  Fix it by setting 'name' string to
> > proper value for !prop cases.
> > 
> > Cc: Viresh Kumar <viresh.kumar@linaro.org>
> > Cc: Lee Jones <lee.jones@linaro.org>
> > Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Fixes: 01fb4d3c39d3 ("PM / OPP: Parse 'opp-<prop>-<name> 'bindings")
> > Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > ---
> > v2:
> > - rework the changes as requested by Viresh
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied, thanks!

