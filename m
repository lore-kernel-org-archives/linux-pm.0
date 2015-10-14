From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PM / OPP: Remove confusing error message in of_cpumask_init_opp_table()
Date: Wed, 14 Oct 2015 23:59:45 +0200
Message-ID: <1480730.ra5d89GYrs@vostro.rjw.lan>
References: <1444837943-32263-1-git-send-email-thomas.petazzoni@free-electrons.com> <2736370.6HB7CanQEp@vostro.rjw.lan> <20151014232927.4b43a897@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:50049 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753612AbbJNVbE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 14 Oct 2015 17:31:04 -0400
In-Reply-To: <20151014232927.4b43a897@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Lior Amsalem <alior@marvell.com>, Gregory Clement <gregory.clement@free-electrons.com>

On Wednesday, October 14, 2015 11:29:27 PM Thomas Petazzoni wrote:
> Hello,
> 
> On Wed, 14 Oct 2015 23:44:03 +0200, Rafael J. Wysocki wrote:
> > On Wednesday, October 14, 2015 11:10:39 PM Thomas Petazzoni wrote:
> > > Rafael,
> > > 
> > > On Wed, 14 Oct 2015 23:28:51 +0200, Rafael J. Wysocki wrote:
> > > 
> > > > > To avoid this confusion, this patch simply deletes the error message.
> > > > > 
> > > > > Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> > > > 
> > > > That's only present in linux-next now, right?
> > > 
> > > No, it is already in 4.3-rc since 4.3-rc1. The commit adding the
> > > problematic function is 8d4d4e98acd68c31435ebb7beea591dbf60b9eb2, and
> > > this function gets used in cpufreq-dt starting at commit
> > > 2e02d8723edf6599988852a8ade8f83b2f766cb8.
> > > 
> > > $ git tag --contains 2e02d8723edf6599988852a8ade8f83b2f766cb8
> > > v4.3-rc1
> > > v4.3-rc2
> > > v4.3-rc3
> > > v4.3-rc4
> > > v4.3-rc5
> > 
> > OK, thanks!
> > 
> > It should carry a
> > 
> > Fixes: 2e02d8723edf
> > 
> > tag then, right?
> 
> Yes, I wasn't sure if it really is a fix, and if so, which commit it is
> fixing. It is really 8d4d4e98acd68c31435ebb7beea591dbf60b9eb2 that
> introduces the confusing message, but the message will not appear until
> the newly added function gets used in
> 2e02d8723edf6599988852a8ade8f83b2f766cb8.
> 
> But if 2e02d8723edf6599988852a8ade8f83b2f766cb8 is considered to be the
> commit actually introducing the regression, then I'll resubmit an
> updated version with the Fixes: tag.

I've added the tag and applied the patch already.

Thanks,
Rafael

