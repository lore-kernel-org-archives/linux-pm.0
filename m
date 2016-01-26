From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: Fix NULL reference crash while accessing policy->governor_data
Date: Tue, 26 Jan 2016 23:49:48 +0100
Message-ID: <30317803.WdZJECVyOY@vostro.rjw.lan>
References: <1297c8fc8135f8b5359f9c49d220a939c0ee640e.1453741314.git.viresh.kumar@linaro.org> <20160126095751.GJ10898@e106622-lin> <20160126180119.GK10898@e106622-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20160126180119.GK10898@e106622-lin>
Sender: stable-owner@vger.kernel.org
To: Juri Lelli <juri.lelli@arm.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, "# v4 . 2+" <stable@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, Juri Lelli <Juri.Lelli@arm.com>
List-Id: linux-pm@vger.kernel.org

On Tuesday, January 26, 2016 06:01:19 PM Juri Lelli wrote:
> On 26/01/16 09:57, Juri Lelli wrote:
> > Hi Viresh,
> > 
> > On 25/01/16 22:33, Viresh Kumar wrote:
> > > There is a little race discovered by Juri, where we are able to:
> > > - create and read a sysfs file before policy->governor_data is being set
> > >   to a non NULL value.
> > >   OR
> > > - set policy->governor_data to NULL, and reading a file before being
> > >   destroyed.
> > > 

[cut]

> 
> So, this goes away with your patch (that I forward ported) and a small
> additional fix on top of that.

Which patch exactly is that?

Thanks,
Rafael
