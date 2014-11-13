From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] cpufreq: Remove architecture specific menu entries
Date: Wed, 12 Nov 2014 19:43:28 -0600
Message-ID: <1415843008.15957.45.camel@freescale.com>
References: <92d6fb45a43b8d800cbcdf690bbf6f8e4713b95e.1415765396.git.viresh.kumar@linaro.org>
	 <2888462.gyjhHfUy7m@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-bn1on0114.outbound.protection.outlook.com ([157.56.110.114]:59941
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753647AbaKMBnl (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 12 Nov 2014 20:43:41 -0500
In-Reply-To: <2888462.gyjhHfUy7m@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Yuantian.Tang@freescale.com

On Thu, 2014-11-13 at 02:47 +0100, Rafael J. Wysocki wrote:
> On Wednesday, November 12, 2014 09:40:43 AM Viresh Kumar wrote:
> > CPUFreq driver's Kconfig entries are added in Kconfig.<arch> files and they are
> > all included from the main Kconfig file using a menu entry. This creates another
> > level of (unnecessary) hierarchy within the menuconfig entries.
> > 
> > The problem occurs when there are drivers usable across architectures. Either
> > their config entry is duplicated in all the supported architectures or is put
> > into the main Kconfig entry. With the later one, we have menuconfig entries for
> > drivers at two levels then.
> > 
> > Fix these issues by getting rid of another level of menuconfig entries and
> > populate all drivers within the main cpufreq menu.
> 
> Won't this be confusing?

Why would it be confusing?  It's already in a not-too-large "CPU
Frequency scaling" menu, the names of the individual options should be
clear enough, and they'd all be grouped at the end of the menu.

FWIW, there's already "Generic DT based cpufreq driver" under that menu.

> Can we at least have a "CPU frequency scaling drivers" menu for drivers
> the *contents* of which will depend on the architecture?

That works too -- I just don't see the confusion aspect.

-Scott


