From: Juri Lelli <juri.lelli@arm.com>
Subject: Re: [PATCH] cpufreq: Fix NULL reference crash while accessing
 policy->governor_data
Date: Wed, 27 Jan 2016 10:22:23 +0000
Message-ID: <20160127102223.GN10898@e106622-lin>
References: <1297c8fc8135f8b5359f9c49d220a939c0ee640e.1453741314.git.viresh.kumar@linaro.org>
 <20160126095751.GJ10898@e106622-lin>
 <20160126180119.GK10898@e106622-lin>
 <30317803.WdZJECVyOY@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:51378 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754410AbcA0KVs (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 27 Jan 2016 05:21:48 -0500
Content-Disposition: inline
In-Reply-To: <30317803.WdZJECVyOY@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, "# v4 . 2+" <stable@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>

On 26/01/16 23:49, Rafael J. Wysocki wrote:
> On Tuesday, January 26, 2016 06:01:19 PM Juri Lelli wrote:
> > On 26/01/16 09:57, Juri Lelli wrote:
> > > Hi Viresh,
> > > 
> > > On 25/01/16 22:33, Viresh Kumar wrote:
> > > > There is a little race discovered by Juri, where we are able to:
> > > > - create and read a sysfs file before policy->governor_data is being set
> > > >   to a non NULL value.
> > > >   OR
> > > > - set policy->governor_data to NULL, and reading a file before being
> > > >   destroyed.
> > > > 
> 
> [cut]
> 
> > 
> > So, this goes away with your patch (that I forward ported) and a small
> > additional fix on top of that.
> 
> Which patch exactly is that?
> 

As Viresh said, this is:

 cpufreq: Access governor's sysfs attributes without 'policy->rwsem'
 http://www.linux-arm.org/git?p=linux-jl.git;a=commit;h=d3eb02ed23732de2c8671377316a190c38b8fe93

Apologies for the confusion; I was already talking with Viresh on IRC
about it.

Best,

- Juri
