From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V2] PM / OPP: of_property_count_u32_elems() can return errors
Date: Fri, 25 Sep 2015 23:40:33 +0200
Message-ID: <2265537.PORMnUrJPF@vostro.rjw.lan>
References: <3ad0ce115028e628e556a505689d396b6e98f04e.1442939340.git.viresh.kumar@linaro.org> <20150922165127.GH23081@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:43406 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S933215AbbIYVMS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 25 Sep 2015 17:12:18 -0400
In-Reply-To: <20150922165127.GH23081@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, nm@ti.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>

On Tuesday, September 22, 2015 09:51:27 AM Stephen Boyd wrote:
> On 09/22, Viresh Kumar wrote:
> > of_property_count_u32_elems() will never return 0, but a -ve error value
> > of a positive count. And so the current !count check is wrong.
> > 
> > Also, a missing "opp-microvolt" property isn't a problem and so we need
> > to do of_find_property() separately to confirm that.
> > 
> > Fixes: 274659029c9d ("PM / OPP: Add support to parse "operating-points-v2" bindings")
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> 
> Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

Applied, thanks!

Rafael

