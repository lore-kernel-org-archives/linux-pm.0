From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH] PM / OPP: Remove confusing error message in
 of_cpumask_init_opp_table()
Date: Thu, 15 Oct 2015 09:42:47 +0200
Message-ID: <20151015094247.44f29da9@free-electrons.com>
References: <1444837943-32263-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<20151015073544.GE19018@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:56062 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750752AbbJOHnh (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 15 Oct 2015 03:43:37 -0400
In-Reply-To: <20151015073544.GE19018@linux>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Lior Amsalem <alior@marvell.com>, Gregory Clement <gregory.clement@free-electrons.com>

Viresh, Rafael,

On Thu, 15 Oct 2015 13:05:44 +0530, Viresh Kumar wrote:
> On 14-10-15, 17:52, Thomas Petazzoni wrote:
> >  		ret = of_init_opp_table(cpu_dev);
> >  		if (ret) {
> > -			pr_err("%s: couldn't find opp table for cpu:%d, %d\n",
> > -			       __func__, cpu, ret);
> > -
> 
> It should have be modified to pr_debug() at least.

Would be fine as well, but then maybe with a rewording:

	pr_debug("%s: no static opp table found for cpu %d, assuming one will be added at runtime (%d)\n",
		 __func__, cpu, ret);

Do you want me to resend a new version? Or a follow-up patch based on
the latest tree from Rafael now that he has applied the previous version?

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
