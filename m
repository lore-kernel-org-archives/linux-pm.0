From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH] PM / OPP: Remove confusing error message in
 of_cpumask_init_opp_table()
Date: Wed, 14 Oct 2015 23:31:33 +0200
Message-ID: <20151014233133.6293cbc3@free-electrons.com>
References: <1444837943-32263-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<2736370.6HB7CanQEp@vostro.rjw.lan>
	<20151014232927.4b43a897@free-electrons.com>
	<1480730.ra5d89GYrs@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:47037 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753301AbbJNVbg (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 14 Oct 2015 17:31:36 -0400
In-Reply-To: <1480730.ra5d89GYrs@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Lior Amsalem <alior@marvell.com>, Gregory Clement <gregory.clement@free-electrons.com>

Rafael,

On Wed, 14 Oct 2015 23:59:45 +0200, Rafael J. Wysocki wrote:

> > Yes, I wasn't sure if it really is a fix, and if so, which commit it is
> > fixing. It is really 8d4d4e98acd68c31435ebb7beea591dbf60b9eb2 that
> > introduces the confusing message, but the message will not appear until
> > the newly added function gets used in
> > 2e02d8723edf6599988852a8ade8f83b2f766cb8.
> > 
> > But if 2e02d8723edf6599988852a8ade8f83b2f766cb8 is considered to be the
> > commit actually introducing the regression, then I'll resubmit an
> > updated version with the Fixes: tag.
> 
> I've added the tag and applied the patch already.

Awesome, thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
