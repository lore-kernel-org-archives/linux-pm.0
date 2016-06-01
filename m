From: Steve Muckle <steve.muckle@linaro.org>
Subject: Re: [PATCH 0/2] cpufreq: Use sorted frequency tables
Date: Wed, 1 Jun 2016 12:37:09 -0700
Message-ID: <20160601193709.GP9864@graphite.smuckle.net>
References: <cover.1464694144.git.viresh.kumar@linaro.org>
 <CAJZ5v0ig61Q+EDjjcyHef5e9B4dKY+BhF802uV61w-G5CdRQvA@mail.gmail.com>
 <20160601010856.GM9864@graphite.smuckle.net>
 <1514420.VAnFJF0vi6@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f175.google.com ([209.85.192.175]:33893 "EHLO
	mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750744AbcFAThN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 1 Jun 2016 15:37:13 -0400
Received: by mail-pf0-f175.google.com with SMTP id 62so20841951pfd.1
        for <linux-pm@vger.kernel.org>; Wed, 01 Jun 2016 12:37:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1514420.VAnFJF0vi6@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Steve Muckle <steve.muckle@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Wed, Jun 01, 2016 at 06:40:36PM +0200, Rafael J. Wysocki wrote:
> > Also what about leaving it as is? I didn't fully catch the concern with
> > abuse in the series I posted, and it pushes this complexity of dealing
> > with the freq table efficiently down into the driver, which is best
> > suited for that IMO.
> 
> The concern is that all drivers using frequency tables would probably
> implement the callbacks in question in a very similar way, leading to
> quite a bit of code duplication.  That's rarely a good thing.

Could this be assuaged with helper macros exported by cpufreq?

