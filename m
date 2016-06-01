From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 0/2] cpufreq: Use sorted frequency tables
Date: Wed, 01 Jun 2016 22:17:24 +0200
Message-ID: <1931561.zTIBYTMuDd@vostro.rjw.lan>
References: <cover.1464694144.git.viresh.kumar@linaro.org> <1514420.VAnFJF0vi6@vostro.rjw.lan> <20160601193709.GP9864@graphite.smuckle.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:47998 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750742AbcFAUNd (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 1 Jun 2016 16:13:33 -0400
In-Reply-To: <20160601193709.GP9864@graphite.smuckle.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Steve Muckle <steve.muckle@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Wednesday, June 01, 2016 12:37:09 PM Steve Muckle wrote:
> On Wed, Jun 01, 2016 at 06:40:36PM +0200, Rafael J. Wysocki wrote:
> > > Also what about leaving it as is? I didn't fully catch the concern with
> > > abuse in the series I posted, and it pushes this complexity of dealing
> > > with the freq table efficiently down into the driver, which is best
> > > suited for that IMO.
> > 
> > The concern is that all drivers using frequency tables would probably
> > implement the callbacks in question in a very similar way, leading to
> > quite a bit of code duplication.  That's rarely a good thing.
> 
> Could this be assuaged with helper macros exported by cpufreq?

In principle, it could.

Another option might be to provide default implementations of those
callbacks for drivers using frequency tables.

