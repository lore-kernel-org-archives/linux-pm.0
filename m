From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PM / OPP: Remove confusing error message in of_cpumask_init_opp_table()
Date: Thu, 15 Oct 2015 23:26:20 +0200
Message-ID: <2916410.E08Ns2sJtA@vostro.rjw.lan>
References: <1444837943-32263-1-git-send-email-thomas.petazzoni@free-electrons.com> <20151015094247.44f29da9@free-electrons.com> <20151015143738.GF19018@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:64388 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751244AbbJOU5g (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 15 Oct 2015 16:57:36 -0400
In-Reply-To: <20151015143738.GF19018@linux>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Lior Amsalem <alior@marvell.com>, Gregory Clement <gregory.clement@free-electrons.com>

On Thursday, October 15, 2015 08:07:38 PM Viresh Kumar wrote:
> On 15-10-15, 09:42, Thomas Petazzoni wrote:
> > Do you want me to resend a new version? Or a follow-up patch based on
> > the latest tree from Rafael now that he has applied the previous version?
> 
> A follow up patch, without any Fixes tag would be fine.

Well, to be honest, I would prefer a replacement.

And since it is going to miss -rc6 anyway, I'll probably simply let it wait
for the v4.4 merge window.

Thanks,
Rafael

