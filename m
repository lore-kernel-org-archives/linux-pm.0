From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V1 Resend 02/10] PM / OPP: Drop unlikely before IS_ERR(_OR_NULL)
Date: Fri, 28 Aug 2015 16:30:54 +0200
Message-ID: <2335781.AXnMjpFogC@vostro.rjw.lan>
References: <cover.1439375087.git.viresh.kumar@linaro.org> <4143341.O8kzUSgY49@vostro.rjw.lan> <alpine.LNX.2.00.1508281551320.25821@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:63161 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752592AbbH1ODT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 28 Aug 2015 10:03:19 -0400
In-Reply-To: <alpine.LNX.2.00.1508281551320.25821@pobox.suse.cz>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linaro-kernel@lists.linaro.org, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, "open list:SUSPEND TO RAM" <linux-pm@vger.kernel.org>

On Friday, August 28, 2015 03:52:46 PM Jiri Kosina wrote:
> On Fri, 28 Aug 2015, Rafael J. Wysocki wrote:
> 
> > > IS_ERR(_OR_NULL) already contain an 'unlikely' compiler flag and there
> > > is no need to do that again from its callers. Drop it.
> > > 
> > > Acked-by: Pavel Machek <pavel@ucw.cz>
> > > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > 
> > Did that go anywhere or should I apply it?
> 
> I didn't take it yet, so feel free to do so if you want.
> 
> With series like this, I usually wait a couple weeks and the pick the ones 
> which haven't been picked into maintainer trees (I check that by looking 
> for its presence in linux-next) through trivial.git afterwards.

OK, I'll apply it then, thanks!

Rafael

