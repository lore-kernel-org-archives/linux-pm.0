From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V2 2/3] PM / OPP: Parse 'opp-supported-hw' binding
Date: Tue, 08 Dec 2015 17:50:16 +0100
Message-ID: <11600297.d0Q68hRS80@vostro.rjw.lan>
References: <cover.1447904566.git.viresh.kumar@linaro.org> <20151204082339.GH3430@ubuntu> <20151208150105.GH3692@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:58861 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756916AbbLHQUR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 8 Dec 2015 11:20:17 -0500
In-Reply-To: <20151208150105.GH3692@ubuntu>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: nm@ti.com, Stephen Boyd <sboyd@codeaurora.org>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Dmitry Torokhov <dtor@chromium.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, Shawn Guo <shawnguo@kernel.org>

On Tuesday, December 08, 2015 08:31:05 PM Viresh Kumar wrote:
> On 04-12-15, 13:53, Viresh Kumar wrote:
> > On 01-12-15, 12:22, Viresh Kumar wrote:
> > > Since these functions are *only* going to be called before any OPPs
> > > are added for the device, and hence ruling out any concurrent readers,
> > > maybe we can guarantee that with this:
> > 
> > @Rafael: Stephen has gone for vacations until end of year :(, can you
> > please help with some reviews ?
> 
> Ping !!

I don't remember that code clearly and it would take some time for me to
recall it and then figure out the details about the changes.  Not impossible,
but quite honestly I have other things to spend that time on.

Also, are the patches so urgent that they really can't wait for Stephen to get
back?  I'd really prefer the discussion between you guys to settle without my
intervention.

Thanks,
Rafael

